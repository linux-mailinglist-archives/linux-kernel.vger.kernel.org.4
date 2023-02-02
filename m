Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014286877AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBBIjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjBBIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:38:59 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 942242E0FB;
        Thu,  2 Feb 2023 00:38:55 -0800 (PST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3_+KIdttjZrC4DA--.748S2;
        Thu, 02 Feb 2023 16:38:32 +0800 (CST)
Received: from phytium.com.cn (unknown [218.68.211.144])
        by mail (Coremail) with SMTP id AQAAfwB3OgCYdttjPRwAAA--.91S3;
        Thu, 02 Feb 2023 16:38:52 +0800 (CST)
From:   Zhang Yiqun <zhangyiqun@phytium.com.cn>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yiqun <zhangyiqun@phytium.com.cn>
Subject: [PATCH] crypto: testmgr - add diff-splits of src/dst into default cipher config
Date:   Thu,  2 Feb 2023 16:38:05 +0800
Message-Id: <20230202083805.21838-1-zhangyiqun@phytium.com.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAfwB3OgCYdttjPRwAAA--.91S3
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhangyiqun
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtFyUKr1DZFyrAF4rCFyDJrb_yoWfXFg_Cr
        15WF97Wr4UXFW8WF1q9rZYyFsYga1fCr4xWa12y3Wjya40q34vg3Z7Zr1kAFyUWw42gFWS
        k3yrAry5Kr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This type of request is often happened in AF_ALG cases.
So add this vector in default cipher config array.

Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
---
 crypto/testmgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4476ac97baa5..6e8d08999104 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -356,6 +356,14 @@ static const struct testvec_config default_cipher_testvec_configs[] = {
 			{ .proportion_of_total = 5000 },
 			{ .proportion_of_total = 5000 },
 		},
+	}, {
+		.name = "one src, two even splits dst",
+		.inplace_mode = OUT_OF_PLACE,
+		.src_divs = { { .proportion_of_total = 10000 } },
+		.dst_divs = {
+			{ .proportion_of_total = 5000 },
+			{ .proportion_of_total = 5000 },
+		 },
 	}, {
 		.name = "uneven misaligned splits, may sleep",
 		.req_flags = CRYPTO_TFM_REQ_MAY_SLEEP,
-- 
2.17.1

