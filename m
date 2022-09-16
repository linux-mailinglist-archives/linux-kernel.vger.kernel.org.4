Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8E5BA6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIPGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIPGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:31:16 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DBA221D;
        Thu, 15 Sep 2022 23:31:05 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 28G6Tt1o032580;
        Fri, 16 Sep 2022 15:29:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 28G6Tt1o032580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663309796;
        bh=WXlDWDsYCum9LxZ9qRnuyZkbjXLf+rB9j22EfiqKyac=;
        h=From:To:Cc:Subject:Date:From;
        b=F1LHM4pLpPO6lHtuzFYNNaVJFQNdbn7HwpvD4l+xN1pRmaYCKPbRK3ytSo6O7anup
         9uTzLCGICJzAiL9T3Ghr55FVDFob6GS4YM7NfhEStjqHOXJ9TnmYd7GF5AcVVhtCP+
         1z4x9yBPL2PtEC4COrvbVCXsKsa+iHFdpJ1o3Hjm9KETuj2d2P8yN2Yuk5bxirXOsl
         Ebj3C/bM8YW4pIB6tKe3m3784o18fIzaHHEitfgYgYoXPW3dwFagCfir089NqS7fO5
         yAt+vAho26X5Tk8uTS0u9hl3ud9vzdL6f8a54S1oy8aFeP6caKt7JsMzH2wE1pxPTU
         h5dPByODRF12w==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] linux/export: use inline assembler to populate symbol CRCs
Date:   Fri, 16 Sep 2022 15:29:53 +0900
Message-Id: <20220916062953.2972556-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7b4537199a4a ("kbuild: link symbol CRCs at final link,
removing CONFIG_MODULE_REL_CRCS"), the module versioning on the
(non-upstreamed-yet) kvx Linux port is broken due to unexpected padding
for __crc_* symbols. The kvx GCC adds padding so u32 gets 8-byte
alignment instead of 4.

I do not know if this happens for upstream architectures in general,
but any compiler has the freedom to insert padding for faster access.

Use the inline assembler to directly specify the wanted data layout.
This is how we previously did before the breakage.

Link: https://lore.kernel.org/lkml/20220817161438.32039-1-ysionneau@kalray.eu/
Link: https://lore.kernel.org/linux-kbuild/31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu/
Fixes: 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS")
Reported-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Yann Sionneau <ysionneau@kalray.eu>
---

 include/linux/export-internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index c2b1d4fd5987..fb90f326b1b5 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -12,6 +12,9 @@
 
 /* __used is needed to keep __crc_* for LTO */
 #define SYMBOL_CRC(sym, crc, sec)   \
-	u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
+	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
+	    "__crc_" #sym ":"					"\n" \
+	    ".long " #crc					"\n" \
+	    ".previous"						"\n")
 
 #endif /* __LINUX_EXPORT_INTERNAL_H__ */
-- 
2.34.1

