Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0570AEDF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEUQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjEUQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6011F;
        Sun, 21 May 2023 09:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9615561772;
        Sun, 21 May 2023 16:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B97C4339B;
        Sun, 21 May 2023 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685145;
        bh=Lm8ksZkkWnLti0mHUlCD6ajjZTqsYY5cMVf9EjewM9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdK53FM1qRG0L/Rn8FOqvnIfXjt/9/pqd/rYxzvd8FD45CBK1f+Lj2vjvHTu/t1r8
         wyyp/1+J8c8OAv41ABbvkhQhWdXcSYSYDCyW9rO//gbwB0Bcqsx2Yn0Qxm9PhF/HVy
         q/0HI0rD1dD1d43tvXVOTV2Xbp6JvDLifm2actX3GQQC/S8GXhhnZU4P1mSEbCb7N7
         zTo2ghmQ3qGMfMTyajqHl8k0fypLWc+IAB1GJvSVW29iWqr5vM3yyVPxIreuMezH7o
         AofzX+5UJFEL2mJQxvfMSoXIXVuKjtEAuCmcOy1EAT1r24j6yCKogvJcwNfS2iL4FN
         Zzj5leqHR7Z+A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 17/20] modpost: merge bad_tosec=ALL_EXIT_SECTIONS entries in sectioncheck table
Date:   Mon, 22 May 2023 01:04:22 +0900
Message-Id: <20230521160426.1881124-18-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no distinction between TEXT_TO_ANY_EXIT and DATA_TO_ANY_EXIT.
Just merge them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index aea9d6cd243d..b5f7f4811c39 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -844,8 +844,7 @@ static const char *const optim_symbols[] = { "*.constprop.*", NULL };
 enum mismatch {
 	TEXT_TO_ANY_INIT,
 	DATA_TO_ANY_INIT,
-	TEXT_TO_ANY_EXIT,
-	DATA_TO_ANY_EXIT,
+	TEXTDATA_TO_ANY_EXIT,
 	XXXINIT_TO_SOME_INIT,
 	XXXEXIT_TO_SOME_EXIT,
 	ANY_INIT_TO_ANY_EXIT,
@@ -888,14 +887,9 @@ static const struct sectioncheck sectioncheck[] = {
 	.mismatch = DATA_TO_ANY_INIT,
 },
 {
-	.fromsec = { TEXT_SECTIONS, NULL },
+	.fromsec = { TEXT_SECTIONS, DATA_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = TEXT_TO_ANY_EXIT,
-},
-{
-	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_EXIT,
+	.mismatch = TEXTDATA_TO_ANY_EXIT,
 },
 /* Do not reference init code/data from meminit code/data */
 {
@@ -1162,8 +1156,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	switch (mismatch->mismatch) {
 	case TEXT_TO_ANY_INIT:
 	case DATA_TO_ANY_INIT:
-	case TEXT_TO_ANY_EXIT:
-	case DATA_TO_ANY_EXIT:
+	case TEXTDATA_TO_ANY_EXIT:
 	case XXXINIT_TO_SOME_INIT:
 	case XXXEXIT_TO_SOME_EXIT:
 	case ANY_INIT_TO_ANY_EXIT:
-- 
2.39.2

