Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0599D627C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiKNLo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiKNLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F74205DF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66D05CE0F83
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9D6C433D7;
        Mon, 14 Nov 2022 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426244;
        bh=S5+Vjw62CK/36i3RI1mn6pcWVLxg3IPGXbTDUNKDC2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSBrtsJNbV7mx/uYXhf/OJyIsU9u7PgTvCICKkflE2XI2csPou0mZP7Pi27BYngn9
         +yQx9p84YQVkeV7Ov/s01QLKfsFfahTQsDQbzIdMsMop8MFZ37BKq2I1lg0Q2la2UR
         8YJIqjsObAn0uW8D74eFzf6niKzwFzhy2mQNkourORcLvu1WjeeLAk5RY+mF8tcc8t
         lEjiO/IRWRVqGj1jiEwiFShnpdDDy03imjUjm2l8IMlfpiWWDurGW6WIw44neWmXzs
         qXkTfIwc5OnZxBD5gFvDeZEXOI949yKpYX5O2+IO51+9DJ6W/zo0Kjxhll2D4eaMeT
         K8iHsI/vRsmkQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Liska <mliska@suse.cz>, Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/46] kbuild: lto: preserve MAKEFLAGS for module linking
Date:   Mon, 14 Nov 2022 12:43:01 +0100
Message-Id: <20221114114344.18650-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liska <mliska@suse.cz>

Prefix cc_o_c and ld_multi_m commands in makefile in order to preserve
access to jobserver. This is needed for gcc LTO at least (enabled in
later patches in this series). Note that both commands can invoke the
linker (ld_single_m in the former case).

Fixes this warning:
lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 41f3602fc8de..564a20ce2667 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -247,7 +247,7 @@ endef
 
 # Built-in and composite module parts
 $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
-	$(call if_changed_rule,cc_o_c)
+	+$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
 # To make this rule robust against "Argument list too long" error,
@@ -457,7 +457,7 @@ endef
 $(multi-obj-m): objtool-enabled := $(delay-objtool)
 $(multi-obj-m): part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
-	$(call if_changed_rule,ld_multi_m)
+	+$(call if_changed_rule,ld_multi_m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
 # Add intermediate targets:
-- 
2.38.1

