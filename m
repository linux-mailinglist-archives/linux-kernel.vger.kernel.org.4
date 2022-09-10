Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B55B4558
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIJJFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIJJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:05:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0C5C950
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:05:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c11so6938700wrp.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mWMJic3+3eVweR7Hb3wJwKAsDypmbh3PTgAfppiGim0=;
        b=XZ9bImxf8XtKwz5O25eFDJyl1TKgS+4Hi4wWwjJENYHZOY29lP2VbpTwYOMWw++olk
         4K1qpSSO4+87Hd6R+l2+0U0FqICl6zqzF0GSBh84YzSC4whAlP/MdFl21okuGN10B6Yh
         Sn8/q4/61ZcdlRKw4yjYBQnjgt0naNiZCApDprcpVXwF25huetUS/7ok5KdCu0Ty+J/Z
         cu6jV5yEoGommBEYZlut/agcSalGVwtlTwIp5k4KkI8gewIAZVYazi0bOSNUFSn0sWqx
         zaSSgaqEqKUC8EgGhwXOKIDrdGQSdyYn+ywLMVk5Ap0P19n4IkEEy0TnDVBdAaQxa9vd
         GQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mWMJic3+3eVweR7Hb3wJwKAsDypmbh3PTgAfppiGim0=;
        b=1iAB+ZfUWY0GU/31V105XQbLRw9kVkCl3CtWLFtaOX+fNNXKlVXqLeGP5/uVSVVw4H
         XY6xFO0KRGNfYgMFxbt25ASoBqRHn/U9tihRDjwWQ3HEpP/2rdkEppWJgxcJSBwAHUe5
         LISOw4r6WqU+9Oed9QcA/FlUFUzdQhovVcm0v7gPz6gfOBgqUqFA6Oqrs7g2t34+Fnup
         S0wl2sHZW8Fj75hegJUhVxPJFvr6Kh5PPEww2/jfk0C2rskrcaBOakOCrt3IfqStHWc2
         UYoOtFgmdlViCBQdpASbV6RRlnGduIUsf1CZwMPV1paKsrPkQ0cS7kK02R6rSUaVxyZ+
         sptA==
X-Gm-Message-State: ACgBeo2sJAj5o/EdaI3KGVkIw597D1/smYD3SogR5vayIsCZH965ST/g
        VHgpduEAVgpGNcICGg+x47ZW
X-Google-Smtp-Source: AA6agR6JF41rR8QPL5xWtDvgTWZqQ98E41/qIkwxUXbocZyQdJPUfyiZPLyuHGg3ZwaAWUEH25O4Aw==
X-Received: by 2002:a05:6000:1245:b0:228:6aa7:dbb2 with SMTP id j5-20020a056000124500b002286aa7dbb2mr10485053wrx.77.1662800727504;
        Sat, 10 Sep 2022 02:05:27 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id i81-20020a1c3b54000000b003a8418ee646sm3081677wma.12.2022.09.10.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:05:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
Date:   Sat, 10 Sep 2022 14:35:06 +0530
Message-Id: <20220910090508.61157-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
References: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EPC controller maintains a list of EPF drivers added to it. For
protecting this list against the concurrent accesses, the epc->lock
(used for protecting epc_ops) has been used so far. Since there were
no users trying to use epc_ops and modify the pci_epf list simultaneously,
this was not an issue.

But with the addition of callback mechanism for passing the events, this
will be a problem. Because the pci_epf list needs to be iterated first
for getting hold of the EPF driver and then the relevant event specific
callback needs to be called for the driver.

If the same epc->lock is used, then it will result in a deadlock scenario.

For instance,

...
	mutex_lock(&epc->lock);
	list_for_each_entry(epf, &epc->pci_epf, list) {
		epf->event_ops->core_init(epf);
		|
		|-> pci_epc_set_bar();
			|
			|-> mutex_lock(&epc->lock) # DEADLOCK
...

So to fix this issue, use a separate lock called "list_lock" for
protecting the pci_epf list against the concurrent accesses. This lock
will also be used by the callback mechanism.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 9 +++++----
 include/linux/pci-epc.h             | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..6cce430d431b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -613,7 +613,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	if (type == SECONDARY_INTERFACE && epf->sec_epc)
 		return -EBUSY;
 
-	mutex_lock(&epc->lock);
+	mutex_lock(&epc->list_lock);
 	func_no = find_first_zero_bit(&epc->function_num_map,
 				      BITS_PER_LONG);
 	if (func_no >= BITS_PER_LONG) {
@@ -640,7 +640,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 
 	list_add_tail(list, &epc->pci_epf);
 ret:
-	mutex_unlock(&epc->lock);
+	mutex_unlock(&epc->list_lock);
 
 	return ret;
 }
@@ -672,11 +672,11 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 		list = &epf->sec_epc_list;
 	}
 
-	mutex_lock(&epc->lock);
+	mutex_lock(&epc->list_lock);
 	clear_bit(func_no, &epc->function_num_map);
 	list_del(list);
 	epf->epc = NULL;
-	mutex_unlock(&epc->lock);
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
 
@@ -773,6 +773,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	}
 
 	mutex_init(&epc->lock);
+	mutex_init(&epc->list_lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..fe729dfe509b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -122,6 +122,7 @@ struct pci_epc_mem {
  * struct pci_epc - represents the PCI EPC device
  * @dev: PCI EPC device
  * @pci_epf: list of endpoint functions present in this EPC device
+ * list_lock: Mutex for protecting pci_epf list
  * @ops: function pointers for performing endpoint operations
  * @windows: array of address space of the endpoint controller
  * @mem: first window of the endpoint controller, which corresponds to
@@ -139,6 +140,7 @@ struct pci_epc_mem {
 struct pci_epc {
 	struct device			dev;
 	struct list_head		pci_epf;
+	struct mutex			list_lock;
 	const struct pci_epc_ops	*ops;
 	struct pci_epc_mem		**windows;
 	struct pci_epc_mem		*mem;
-- 
2.25.1

