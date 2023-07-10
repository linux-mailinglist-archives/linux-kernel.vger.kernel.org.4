Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0774D41A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGJLDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGJLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:02:53 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBE2D2;
        Mon, 10 Jul 2023 04:02:51 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANOHK019769;
        Mon, 10 Jul 2023 05:23:24 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANOV9019767;
        Mon, 10 Jul 2023 05:23:24 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 06/13] Add root domain trust implementation.
Date:   Mon, 10 Jul 2023 05:23:12 -0500
Message-Id: <20230710102319.19716-7-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trust.c contains the support infrastructure for anchoring the
root modeling domain in a hardware TPM implementation if it is
available.

The security state coefficients are extended, by default, into
Platform Configuration Register (PCR) 11 in order to provide
authentication of the security execution trajectory for the root
domain.  This value was chosen to avoid the use of PCR register
10 that the Integrity Measurement Architecture uses to register
the integrity events that it handles.

This PCR value can be changed through the kernel configuration
process.

This file is also responsible for computing the hardware platform
aggregate measurement.  This is the linear extension sum over PCR
rsegisters 0 through 7.  This file contains an accessor function
for surfacing this value to either the internal or external
Trusted Modeling Agent implementations.

The platform hardware aggregate value is designed to be the first
security state coefficient injected into a model.

Updates to the TPM are through an ordered asynchronous workqueue.
This is needed in order to support the modeling of security event
hooks that are called while a process is in atomic context.

This is also a performance optimization given that TPM
transactions are not highly performant, particularly on discrete
TPM implementations.  Extension of values to PCR's have
historically been done on a relatively infrequent basis, such as
when a file is accessed.  The high rate of security event
processing that can occur in the root modeling namespace
significantly benefits from this optimization.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/trust.c | 220 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)
 create mode 100644 security/tsem/trust.c

diff --git a/security/tsem/trust.c b/security/tsem/trust.c
new file mode 100644
index 000000000000..85f7542cf76f
--- /dev/null
+++ b/security/tsem/trust.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2023 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * Implements management of a TPM trust root for the in kernel TMA.
+ */
+
+#include <linux/tpm.h>
+
+#include "tsem.h"
+
+static struct workqueue_struct *tpm_update_wq;
+
+static u8 zero_aggregate[HASH_MAX_DIGESTSIZE];
+
+static struct tpm_chip *tpm;
+
+static struct tpm_digest *digests;
+
+struct hardware_aggregate {
+	struct list_head list;
+	char *name;
+	u8 value[HASH_MAX_DIGESTSIZE];
+};
+
+DEFINE_MUTEX(hardware_aggregate_mutex);
+LIST_HEAD(hardware_aggregate_list);
+
+static struct hardware_aggregate *find_aggregate(void)
+{
+	struct hardware_aggregate *aggregate;
+
+	list_for_each_entry(aggregate, &hardware_aggregate_list, list) {
+		if (!strcmp(aggregate->name,
+			    tsem_context(current)->digestname))
+			goto done;
+	}
+	aggregate = NULL;
+
+ done:
+	return aggregate;
+}
+
+static struct hardware_aggregate *add_aggregate(u8 *new_aggregate)
+{
+	struct hardware_aggregate *aggregate;
+
+	aggregate = kzalloc(sizeof(*aggregate), GFP_KERNEL);
+	if (!aggregate)
+		return NULL;
+
+	aggregate->name = kstrdup(tsem_context(current)->digestname,
+				  GFP_KERNEL);
+	if (!aggregate->name) {
+		kfree(aggregate);
+		return NULL;
+	}
+	memcpy(aggregate->value, new_aggregate, tsem_digestsize());
+
+	list_add(&aggregate->list, &hardware_aggregate_list);
+
+	return aggregate;
+}
+
+/**
+ * tsem_trust_aggregate() - Return a pointer to the hardware aggregate.
+ *
+ * This function returns a pointer to the hardware aggregate encoded
+ * with the hash function for the current modeling domain.
+ *
+ * Return: A pointer is returned to the hardware aggregate value that
+ *	   has been cached.
+ */
+u8 *tsem_trust_aggregate(void)
+{
+	u8 aggregate[HASH_MAX_DIGESTSIZE], *retn = zero_aggregate;
+	u16 size;
+	unsigned int lp;
+	struct tpm_digest pcr;
+	struct hardware_aggregate *hw_aggregate;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	if (!tpm)
+		return retn;
+
+	mutex_lock(&hardware_aggregate_mutex);
+
+	hw_aggregate = find_aggregate();
+	if (hw_aggregate) {
+		retn = hw_aggregate->value;
+		goto done;
+	}
+
+	shash->tfm = tsem_digest();
+	if (crypto_shash_init(shash))
+		goto done;
+
+	if (tpm_is_tpm2(tpm))
+		pcr.alg_id = TPM_ALG_SHA256;
+	else
+		pcr.alg_id = TPM_ALG_SHA1;
+	memset(pcr.digest, '\0', TPM_MAX_DIGEST_SIZE);
+
+	for (lp = 0; lp < tpm->nr_allocated_banks; lp++) {
+		if (pcr.alg_id == tpm->allocated_banks[lp].alg_id) {
+			size = tpm->allocated_banks[lp].digest_size;
+			break;
+		}
+	}
+
+	for (lp = 0; lp < 8; ++lp) {
+		if (tpm_pcr_read(tpm, lp, &pcr))
+			goto done;
+		if (crypto_shash_update(shash, pcr.digest, size))
+			goto done;
+	}
+	if (!crypto_shash_final(shash, aggregate)) {
+		hw_aggregate = add_aggregate(aggregate);
+		if (hw_aggregate)
+			retn = hw_aggregate->value;
+	}
+
+ done:
+	mutex_unlock(&hardware_aggregate_mutex);
+
+	if (retn == zero_aggregate)
+		pr_warn("tsem: Error generating platform aggregate\n");
+
+	return retn;
+}
+
+static void tpm_update_worker(struct work_struct *work)
+{
+	int amt, bank, digestsize;
+	struct tsem_event *ep;
+
+	ep = container_of(work, struct tsem_event, work);
+	digestsize = ep->digestsize;
+
+	for (bank = 0; bank < tpm->nr_allocated_banks; bank++) {
+		if (tpm->allocated_banks[bank].digest_size > digestsize) {
+			amt = digestsize;
+			memset(digests[bank].digest, '\0',
+			       tpm->allocated_banks[bank].digest_size);
+		} else
+			amt = tpm->allocated_banks[bank].digest_size;
+		memcpy(digests[bank].digest, ep->mapping, amt);
+	}
+
+	if (tpm_pcr_extend(tpm, CONFIG_SECURITY_TSEM_ROOT_MODEL_PCR,
+			   digests))
+		pr_warn("tsem: Failed TPM update.\n");
+
+	tsem_event_put(ep);
+}
+
+/**
+ * tsem_trust_add_point() - Add a measurement to the trust root.
+ * @ep: A pointer to the security event description whose measurement
+ *	is to be extended into the TPM.
+ *
+ * This function extends the platform configuration register being
+ * used to document the hardware root of trust for internally modeled
+ * domains with a security event coefficient value.
+ *
+ * Return: If the extension fails the error return value from the
+ *	   TPM command is returned, otherwise a value of zero is
+ *	   returned.
+ */
+int tsem_trust_add_event(struct tsem_event *ep)
+{
+	bool retn;
+
+	if (!tpm)
+		return 0;
+
+	tsem_event_get(ep);
+	ep->digestsize = tsem_digestsize();
+
+	INIT_WORK(&ep->work, tpm_update_worker);
+	retn = queue_work(tpm_update_wq, &ep->work);
+
+	return 0;
+}
+
+static int __init trust_init(void)
+{
+	int retn = -EINVAL, lp;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		return retn;
+
+	tpm_update_wq = alloc_ordered_workqueue("tsem_tpm", 0);
+	if (IS_ERR(tpm_update_wq)) {
+		retn = PTR_ERR(tpm_update_wq);
+		goto done;
+	}
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests), GFP_NOFS);
+	if (!digests) {
+		tpm = NULL;
+		return retn;
+	}
+	for (lp = 0; lp < tpm->nr_allocated_banks; lp++)
+		digests[lp].alg_id = tpm->allocated_banks[lp].alg_id;
+	retn = 0;
+
+ done:
+	if (retn) {
+		destroy_workqueue(tpm_update_wq);
+		kfree(digests);
+	}
+
+	return retn;
+}
+
+device_initcall_sync(trust_init);
-- 
2.39.1

