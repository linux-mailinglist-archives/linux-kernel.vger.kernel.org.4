Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCD6FF3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjEKONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbjEKON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:13:27 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E7A240;
        Thu, 11 May 2023 07:12:41 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QHDNb6kB2z9sZD;
        Thu, 11 May 2023 16:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683814319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2otcDdUshgA/c9L7n2sngTXTgjQKeWeYo6cxQJutfE=;
        b=VO9CwJzGrBO1Spq63OV3oM5pIeShIfHHKAr8IWzkHKJUP+gGR6ZYeI53x9m7Q5+h8ByFJf
        v7mvRcPkmBztyE6xxsXnDtU9vHJ9pdfezDSNUA9VBdcYd/w4HBSlxPUyY9euIHJbLW1io8
        8tm8vau+bxg+/c05UYrtklYN28EHOTkASLv9UZTpNfGkS4tsh/MtPCHJB85QdB88c7RBbn
        +2mtkrky87rJn6x4I3Db+AzL++HyqDm/3zA98XsfHLFZzFHNWoSwBmKuxx7va5VWwkhhIB
        29gOMPhPm8Ah01gjkGyLqetyiZDd28nXHS0E2GQDyYYKXJpx7We5PjtNrr79Eg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        dan.carpenter@linaro.org, Dylan Van Assche <me@dylanvanassche.be>,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 1/2] misc: fastrpc: support complete DMA pool access to the DSP
Date:   Thu, 11 May 2023 16:11:45 +0200
Message-Id: <20230511141146.30465-2-me@dylanvanassche.be>
In-Reply-To: <20230511141146.30465-1-me@dylanvanassche.be>
References: <20230511141146.30465-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/misc/fastrpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..1ced553ae959 100644
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
@@ -2274,6 +2276,19 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
+	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
+		rmem = of_reserved_mem_lookup(rmem_node);
+		if (!rmem) {
+			err = -EINVAL;
+			goto fdev_error;
+		}
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

