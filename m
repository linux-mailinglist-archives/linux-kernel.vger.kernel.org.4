Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29A62EC09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiKRCkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:40:28 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05FD6E545;
        Thu, 17 Nov 2022 18:40:24 -0800 (PST)
X-QQ-mid: bizesmtp89t1668739207tva5a994
Received: from localhost.localdomain ( [39.77.115.220])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Nov 2022 10:40:06 +0800 (CST)
X-QQ-SSF: 0120000000000090H000000A0000000
X-QQ-FEAT: 7jw2iSiCazqm4g+4YM0g74QsC2jHm2PIcQbsNK+GUZO9xquOKpCewj4oNufIg
        pDC1Pj8ZSFA+umyfVA0/IMzOsuVHRuhmDvrGiqq8EuKOtLzKmZ9jn4S+vghECGMW6yIv9Jk
        v985ChFYLMD9baK7iBFV2wOrdGgF76Y1l/SIu5ZOY2555LIdIwYvoUBL1jfaDXAG85t7syA
        05Z66hmYuhhRISBppBpHDTfpVeFpCoh1fmZJ7V1QfZVds3h1WHhCZI8mF8shlOZI4YE7dFU
        ddYCTH69l8LacxaZWFB8DpcOeU5gCv/hYck6b/bqLGaMeBwCWQK7QWq2sRpBMIzT0Q1W/0t
        YqKOAq3j8MVKKauy9gQTNyH4jGnVVDjWqEC35RRdmrHTz3ipcdNFe/a0jkqHw==
X-QQ-GoodBg: 0
From:   Jialu Xu <xujialu@vimux.org>
To:     guoren@kernel.org, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jialu Xu <xujialu@vimux.org>
Subject: [PATCH] csky: add alignment for the delay code
Date:   Fri, 18 Nov 2022 10:40:03 +0800
Message-Id: <20221118024003.1245339-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify 8 bytes alignment for the function __delay or we get bad delay
like udelay(10) will be 25us in fact.

Thanks for Guo Ren's help.

Signed-off-by: Jialu Xu <xujialu@vimux.org>
---
 arch/csky/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/lib/delay.c b/arch/csky/lib/delay.c
index 22570b0790d6..f5db317313bb 100644
--- a/arch/csky/lib/delay.c
+++ b/arch/csky/lib/delay.c
@@ -5,7 +5,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-void __delay(unsigned long loops)
+void __aligned(8) __delay(unsigned long loops)
 {
 	asm volatile (
 		"mov r0, r0\n"
-- 
2.30.2

