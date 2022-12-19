Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95EE6507A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLSGiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLSGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:38:20 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EE6429;
        Sun, 18 Dec 2022 22:38:16 -0800 (PST)
X-QQ-mid: bizesmtp87t1671431882tnw4rsim
Received: from localhost.localdomain ( [219.147.0.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Dec 2022 14:38:00 +0800 (CST)
X-QQ-SSF: 0120000000200090H000B00A0000000
X-QQ-FEAT: +LhgrVJY36KZec5+S5cuVmrU3aznWbQhZEr/oZNWjzdYoVD5pxsV38VixeRdV
        CrI7X3C67FNWNousirF1gAG5BPWbs3+QUeAhGvnvpG2oN2jGmkq4SWv9kVx1rHRKyhCqEms
        Pa+PjaRp0iWF0iOLuctM9XjQRy2vJqAtUwfPIbKSwx1V4MMt36fathmgjSOz7gC6ecnwPfI
        HE7890oz8c0wyryA4FcYPASdl8HHZHx6ceimWjUtl9WOnbcUBeboRKsRHnlPDrDphkcXaBW
        6MTcHbzM7brUGR1tT8nm3MuPhn/Cm4LeZfjlkOu/0maV1bxZ2EE9R6QdY77Sx/MB+zt0fef
        r16vbEnMIrLYVXdMk+GL7ReQhEufMESREujrOPB
X-QQ-GoodBg: 0
From:   Jialu Xu <xujialu@vimux.org>
To:     guoren@kernel.org, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jialu Xu <xujialu@vimux.org>
Subject: [PATCH RESEND]     csky: add alignment for the delay code
Date:   Mon, 19 Dec 2022 14:36:41 +0800
Message-Id: <20221219063640.63708-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

