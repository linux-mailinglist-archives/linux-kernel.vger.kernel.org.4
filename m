Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930E6CAD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC0SnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjC0SnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:06 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6B4230;
        Mon, 27 Mar 2023 11:42:28 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PlhWJ2Mtnz9sT1;
        Mon, 27 Mar 2023 20:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA9Z6Ce+zSDDUHL/hOOqdBN8+RqhLoUSRKQM+XmUbV0=;
        b=RBstaBAVEtWDgmLe6MjWgNh2okU3w6dAMt2iehw83rtAxvQdl62NSrOLzJX/dcDkvTZ8dn
        3E+QkvT+PcHXowPaQNbYpcnIGfnwilBYgaD94XU+HGJuVG73WZ88gfeCdLefwSR3vM5jau
        QaXyjd3beMWLHhKH3GueyeIxtlaVFxBlPZQpFILXuB8Zs/RcchEAs5xINcDjqrFj4QfOHd
        82TMiN/ou/vayKVpE1U1oZRWlKgIlBITkpqb/YPOezhf3EcpD5le79ag2bsH05GYvmpNrB
        KD6f9YtejGji38CDdEzaip1UJv+/qZT6JYJM7SYN/AX2gF5v3xzW4iETl4zcXw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 1/2] misc: fastrpc: support complete DMA pool access to the DSP
Date:   Mon, 27 Mar 2023 20:42:03 +0200
Message-Id: <20230327184204.498032-2-me@dylanvanassche.be>
In-Reply-To: <20230327184204.498032-1-me@dylanvanassche.be>
References: <20230327184204.498032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PlhWJ2Mtnz9sT1
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
This is only necessary when a memory region is provided for SLPI DSPs
so guard this with a domain ID check.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/misc/fastrpc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..caf2ae556956 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2231,6 +2231,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	int i, err, domain_id = -1, vmcount;
 	const char *domain;
 	bool secure_dsp;
+	struct device_node *rmem_node;
+	struct reserved_mem *rmem;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
@@ -2274,6 +2276,20 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
+	dev_info(rdev, "ASSIGNING MEMORY\n");
+	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
+		rmem = of_reserved_mem_lookup(rmem_node);
+		if (!rmem)
+			return -EINVAL;
+
+		dev_info(rdev, "ASSIGNING MEMORY START\n");
+		qcom_scm_assign_mem(rmem->base, rmem->size, &data->perms,
+				    data->vmperms, data->vmcount);
+
+		dev_info(rdev, "ASSIGNING MEMORY END\n");
+	}
+
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 
-- 
2.39.2

