Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3195E9407
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiIYPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:42:16 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Sep 2022 08:42:14 PDT
Received: from mail-m118207.qiye.163.com (mail-m118207.qiye.163.com [115.236.118.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D036C1C136
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:42:14 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118207.qiye.163.com (HMail) with ESMTPA id 21789900D0A;
        Sun, 25 Sep 2022 23:32:40 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     tglx@linutronix.de
Cc:     me@inclyc.cn, ndesaulniers@google.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
Date:   Sun, 25 Sep 2022 23:31:50 +0800
Message-Id: <20220925153151.2467884-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUJPT0JWT0JOTR8YSx1LGUtOVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Dio5HTlIIzcVNzw*OUxL
        MjMwFBxVSlVKTU1PSkpCQk1KSU1OVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUlJQ083Bg++
X-HM-Tid: 0a837547743f2d29kusn21789900d0a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WG14 N2350 made very clear that it is an UB having type definitions with
in "offsetof". This patch change the implementation of macro
"TYPE_ALIGN" to builtin "__alignof__" to avoid undefined behavior.

I've grepped all source files to find any type definitions within
"offsetof".

    offsetof\(struct .*\{ .*,

This implementation of macro "TYPE_ALIGN" seemes to be the only case of
type definitions within offsetof in the kernel codebase.

Signed-off-by: YingChi Long <me@inclyc.cn>
Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
---
 arch/x86/kernel/fpu/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 621f4b6cac4a..41425ba0b6b1 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -134,7 +134,7 @@ static void __init fpu__init_system_generic(void)
 }
 
 /* Get alignment of the TYPE. */
-#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
+#define TYPE_ALIGN(TYPE) __alignof__(TYPE)
 
 /*
  * Enforce that 'MEMBER' is the last field of 'TYPE'.
-- 
2.35.1

