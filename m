Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784B6F977C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEGILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEGILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:11:31 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8713C09;
        Sun,  7 May 2023 01:11:25 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QDcZK1S3vz9sTD;
        Sun,  7 May 2023 10:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683447081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sFVyzUblvCbm/T+33wb0wwPWLllx1DwIEQ1xE4io7o=;
        b=dMIZc6oTH/TnIWBWzqE7/QFqW9lHfwwy+zmzd0SRZJIEgTVxtDYHBW+n6Mx0zgbh9xmoFz
        JH8i1oMrQ1e8tHreErYQvYurSBPykmDcs/hPKglGrgOnr9VIIpi9M13A1U7riBOfb7oq91
        tcRK63hgCdOIxhmIJW8A1GLiPWUahgCn2swzm2wTySgrDZwi65fScthbcR2VPWcyusr+v4
        DGEGGsY3NQjVPbad1kH6wyITSf+lqmmw73a5djA08jZEsD6M803hl6rkApo+K/8n0tvlc4
        7Ji3/1GCkAnC450ifSH9cwsiIqtwwmGmbOguFCq17xgnPhf2yoWJOO5Z3bMS7Q==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 1/2] misc: fastrpc: support complete DMA pool access to the DSP
Date:   Sun,  7 May 2023 10:08:38 +0200
Message-Id: <20230507080839.37578-2-me@dylanvanassche.be>
In-Reply-To: <20230507080839.37578-1-me@dylanvanassche.be>
References: <20230507080839.37578-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QDcZK1S3vz9sTD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/misc/fastrpc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..423272bcbbf5 100644
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
@@ -2274,6 +2276,17 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
+	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
+		rmem = of_reserved_mem_lookup(rmem_node);
+		if (!rmem)
+			return -EINVAL;
+
+		qcom_scm_assign_mem(rmem->base, rmem->size, &data->perms,
+				    data->vmperms, data->vmcount);
+
+	}
+
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 
-- 
2.40.1

