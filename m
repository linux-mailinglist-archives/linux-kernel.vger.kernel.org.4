Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C736375C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKXKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKXKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:00:36 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6F175A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:00:32 -0800 (PST)
X-QQ-mid: bizesmtpipv601t1669283989t4ga
Received: from localhost ( [255.244.225.9])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Nov 2022 17:59:48 +0800 (CST)
X-QQ-SSF: 01400000002000506000B00A0000000
X-QQ-FEAT: zT6n3Y95oi0KjB5qD2vgo+9Z95mG8fSYlxILX8DZ9Qq5/iqAp8PHe5OxNq8eL
        hJ2hQo0hU2Dk1mB4yOb0a94YOYxnKDFu46U1j6a/hMalHEIEslPeoVyKOTptT+Ge1CjjU3k
        mu0oxtxfE+QVNiEV9MbYmsuYw4EONYqnU3WQ4dR7HjEPeORGWqKHsQcNrtBj6GJ1e5kdqp1
        mKTP5+q+3vFZejjCEEKWRDUW+4YLGJ6/bnTLPcQSWvo8aJ09roPHfIm87tzG3wIalo188l2
        VCVrImUV8LuAAxmYFZ62Day8KsbOeowrBL/WD5ih7yncqP5gDzw3NOYRWNMO9eWnBp/p/vL
        zew2rrqEBK4YgjsDrdtTlZ43QYRtsGraL3NCIZBp8ySd0er4Fgrm7HNbmpR+A==
X-QQ-GoodBg: 2
Date:   Thu, 24 Nov 2022 17:59:47 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] arm_scpi: Rev last modify to support acpi
Message-ID: <566DA2F800E4BACA+Y39Ak8xtNJaBqB90@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rev last modify to support acpi

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/firmware/arm_scpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index e2e90dcc38bd..aca0a9780c12 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -908,7 +908,9 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
 	{ }
 };
 
+#ifdef CONFIG_PHYTIUM_MBOX
 extern struct mbox_chan *phytium_mbox_request_channel(struct mbox_client *cl);
+#endif
 
 static int scpi_probe(struct platform_device *pdev)
 {
@@ -1047,6 +1049,7 @@ static int scpi_probe(struct platform_device *pdev)
 
                         ret = scpi_alloc_xfer_list(dev, pchan);
 
+#ifdef phytium_mbox_request_channel
                         if (!ret) {
                                 pchan->chan = phytium_mbox_request_channel(cl);
 
@@ -1058,6 +1061,7 @@ static int scpi_probe(struct platform_device *pdev)
                                         dev_err(dev, "failed to get channel%d err %d\n",
                                                 idx, ret);
                         }
+#endif
 
                         return ret;
                 }
-- 
2.34.1

