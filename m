Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00683643C13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLFEHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLFEHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:07:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE825F0;
        Mon,  5 Dec 2022 20:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6206E6154E;
        Tue,  6 Dec 2022 04:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F2C433C1;
        Tue,  6 Dec 2022 04:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670299658;
        bh=xMuxZCae0szPGAJBhjSo4T2NR8ZPREZDgVVh/yx9ZQY=;
        h=From:To:Cc:Subject:Date:From;
        b=gTgkS23LO53e9ZXwSI8myw+UnXHo138gf3ao7r8gpyPpDn8KGHtIIatSMjBU6SFM1
         wcnf8nk53H9p19I3XY/w6KCoeLakXRgXvo5BYzLcRoI+nhJpTUuH/hHOhmo8YVJacu
         FO9olYX74DbjsL2XuY+Rd0OAOPH7W0wUWx+ZcO1gUiYO8/MDeFufTyLpYBijHiuaTr
         H2MLBc4wwSqrVI7PPgiyMeEXCRZJCxkolFhhgiv/eSHzatxtva7gDwHX1vH1jFBlXg
         YMogoNE3RK19Pdl+rIJbgHeGxPmzYvb045iOqE8lvuo5O+9k+bZHQMfWY8buHsQOUR
         SswN4twsvD0Ew==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/2] kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Tue,  6 Dec 2022 13:07:30 +0900
Message-Id: <20221206040731.442499-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_WERROR turns warnings into errors, which happens only for *.c
files because -Werror is added to KBUILD_CFLAGS.

Adding it to KBUILD_CPPFLAGS makes more sense because preprocessors
understand the -Werror option.

For example, you can put a #warning directive in any preprocessed code.

    warning: #warning "this is a warning message" [-Wcpp]

If -Werror is added, it is promoted to an error.

    error: #warning "this is a warning message" [-Werror=cpp]

This commit moves -Werror to KBUILD_CPPFLAGS so it works in the same way
for *.c, *.S, *.lds.S or whatever needs preprocessing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 53fa1a9fba8a..f84b57910667 100644
--- a/Makefile
+++ b/Makefile
@@ -869,7 +869,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
 KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 
 KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
-- 
2.34.1

