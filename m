Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDD6712FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjARFGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjARFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:05:48 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633158282;
        Tue, 17 Jan 2023 21:05:47 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674018345;
        bh=aYunoo5x5odK4usSUbnIpWDFANhMjpbIUG7PfzbCVpI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=axcgvCv9lTgT9hwQsrr6GlKYsEAEoQtmRf2jjpq9Uy3ZfbUUbaHUa6se2OYyx7vhX
         X7iJ5dyg/eNAZQYyOY/eJbSBnYCvC5Ut+8Oj8RNd2FeO5sBj06wJ/IlOQUaBtcTfLu
         EiPOa8WRaT64zgENcKLXRuca4arIlEetc+XLBubM=
Date:   Wed, 18 Jan 2023 05:05:34 +0000
Subject: [PATCH v3 1/2] kbuild: also delete temporary directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230117-kernel-kheaders-gitignore-v3-1-e686b93b0732@weissschuh.net>
References: <20230117-kernel-kheaders-gitignore-v3-0-e686b93b0732@weissschuh.net>
In-Reply-To: <20230117-kernel-kheaders-gitignore-v3-0-e686b93b0732@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674018337; l=959;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aYunoo5x5odK4usSUbnIpWDFANhMjpbIUG7PfzbCVpI=;
 b=c/5gcfjMh2EedFCrZGqbxj5rOTR4Gm/6xCPkbZnboA91XQQYQeHZIZ1TQVQmsUUBxM2mql4uVtlH
 9vzFgFBHCkOrKz+un1FUM9bb43nyfUPFL/juefWDYNScI2W65F6N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the standard naming schema for temporary files also for temporary
directories.

Such a directory will be used by the kheaders generation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e09fe100efb2..863b3fdd4374 100644
--- a/Makefile
+++ b/Makefile
@@ -2026,11 +2026,12 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
-		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
+		-o -name '*.*.symversions' \) -type f -print \
+		-o -name '.tmp_*' -print \
+		| xargs rm -rf
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------

-- 
2.39.1
