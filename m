Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B636C8E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCYNoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCYNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:44:35 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096812859;
        Sat, 25 Mar 2023 06:44:34 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PkL0Z1zpbz9sZ5;
        Sat, 25 Mar 2023 14:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679751870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sIg4+FYFSnYc3mW7AmwNzvgOLT4u1cXGrJ6xp9wOhE=;
        b=zmItbdzpCmB5D3oVIkJ0NewbyApwH9z0bpGgeV7q0rUsjfFCZ/xSAanvCcziJQ9Jbc/z5U
        dKJHJLA2MY+3dDJ4iROyviyqxtRS6q0btQNJq1wbWagz6Pveozyx8audQ6Iz62LQm/vbSc
        C36RtQrEqN57L3VgsO9byNTWbNIcsN2oQlH6PZswPVbE0WdFVxvj1PSO3SkQCpDAYdAmPf
        uAq0OML11fSwr/Yex6Yj5jnCeTAj1pXOV+LdYWlfYR5MN27avQLLZxyFz64XZ+oP9Bib8k
        yw7VbCbQDyYZHnq8F9Y2dUH2SCOtvsyU7dxiNavHjgzB3kJBJJF+Jv6jVmSYPw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 2/2] misc: fastrpc: support complete DMA pool access to the DSP
Date:   Sat, 25 Mar 2023 14:44:10 +0100
Message-Id: <20230325134410.21092-3-me@dylanvanassche.be>
In-Reply-To: <20230325134410.21092-1-me@dylanvanassche.be>
References: <20230325134410.21092-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkL0Z1zpbz9sZ5
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support FastRPC Context Banks which aren't mapped via the SMMU,
make the whole reserved memory region available to the DSP to allow
access to coherent buffers.

This is performed by assigning the memory to the DSP via a hypervisor
call to set the correct permissions for the Virtual Machines on the DSP.
Only perform this operation when at least one VM is enabled
and 'qcom,assign-all-mem' property is present in DTS.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/misc/fastrpc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..ecfd0a91113c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2230,7 +2230,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	struct fastrpc_channel_ctx *data;
 	int i, err, domain_id = -1, vmcount;
 	const char *domain;
-	bool secure_dsp;
+	bool secure_dsp, assign_all_mem;
+	struct device_node *rmem_node;
+	struct reserved_mem *rmem;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
@@ -2265,6 +2267,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
+	assign_all_mem = of_property_read_bool(rdev->of_node, "qcom,assign-all-mem");
+
+	if (assign_all_mem && !vmcount)
+		return -EINVAL;
+
 	if (vmcount) {
 		data->vmcount = vmcount;
 		data->perms = BIT(QCOM_SCM_VMID_HLOS);
@@ -2274,6 +2281,16 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	if (assign_all_mem) {
+		rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
+		if (rmem_node) {
+			rmem = of_reserved_mem_lookup(rmem_node);
+			if (rmem)
+				qcom_scm_assign_mem(rmem->base, rmem->size, &data->perms,
+						    data->vmperms, data->vmcount);
+		}
+	}
+
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 
-- 
2.39.2

