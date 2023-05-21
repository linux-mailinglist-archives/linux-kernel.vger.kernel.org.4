Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBE70AED9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjEUQGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjEUQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BDF124;
        Sun, 21 May 2023 09:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E52460FB0;
        Sun, 21 May 2023 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699FAC433D2;
        Sun, 21 May 2023 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685146;
        bh=xkkHzfnL3ubXNCXhol2tJvXMJSRLG0VEcBb56VUY1PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVgHH4vJtM2RM6heu4Np31j75OuIt6w1WnPM3+OgbM1iI6dOK0EfPNRbPgKMZm8O4
         GCa3kGdPYcvS5eN70GFAgbIc9A6LmVNAmJZzH6Qh253361qyDNp3ik1XQxksXGAPzo
         3AsvNW+lrkx0fO7KDFp6y1U5AgYzjc2k35N94XXzMZFe54H8dDzi+Srei1IplPWpKU
         GIn7uOo9EEYo4xS830Tfh2fh7AJB5s3V7huCYuvoi81ufvdD/tINYf55fB47MWnovY
         VxprJvKl67DEizW/gbCfj0Y2+GX1fXy7PxQ3RZ1IFwupxCY4aOrkofNBnl1BwKmF3u
         J2xV5zqMcPqwA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 18/20] modpost: remove *_sections[] arrays
Date:   Mon, 22 May 2023 01:04:23 +0900
Message-Id: <20230521160426.1881124-19-masahiroy@kernel.org>
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

Use PATTERNS() macros to remove unneeded array definitions.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b5f7f4811c39..852cc164c77e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -823,24 +823,6 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS, \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
-/* init data sections */
-static const char *const init_data_sections[] =
-	{ ALL_INIT_DATA_SECTIONS, NULL };
-
-/* all init sections */
-static const char *const init_sections[] = { ALL_INIT_SECTIONS, NULL };
-
-/* all text sections */
-static const char *const text_sections[] = { ALL_TEXT_SECTIONS, NULL };
-
-/* data section */
-static const char *const data_sections[] = { DATA_SECTIONS, NULL };
-
-static const char *const head_sections[] = { ".head.text*", NULL };
-static const char *const linker_symbols[] =
-	{ "__init_begin", "_sinittext", "_einittext", NULL };
-static const char *const optim_symbols[] = { "*.constprop.*", NULL };
-
 enum mismatch {
 	TEXT_TO_ANY_INIT,
 	DATA_TO_ANY_INIT,
@@ -1006,14 +988,14 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
 	/* Check for pattern 1 */
-	if (match(tosec, init_data_sections) &&
-	    match(fromsec, data_sections) &&
+	if (match(tosec, PATTERNS(ALL_INIT_DATA_SECTIONS)) &&
+	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
 	    strstarts(fromsym, "__param"))
 		return 0;
 
 	/* Check for pattern 1a */
 	if (strcmp(tosec, ".init.text") == 0 &&
-	    match(fromsec, data_sections) &&
+	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
 	    strstarts(fromsym, "__param_ops_"))
 		return 0;
 
@@ -1036,18 +1018,18 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 		return 0;
 
 	/* Check for pattern 3 */
-	if (match(fromsec, head_sections) &&
-	    match(tosec, init_sections))
+	if (strstarts(fromsec, ".head.text") &&
+	    match(tosec, PATTERNS(ALL_INIT_SECTIONS)))
 		return 0;
 
 	/* Check for pattern 4 */
-	if (match(tosym, linker_symbols))
+	if (match(tosym, PATTERNS("__init_begin", "_sinittext", "_einittext")))
 		return 0;
 
 	/* Check for pattern 5 */
-	if (match(fromsec, text_sections) &&
-	    match(tosec, init_sections) &&
-	    match(fromsym, optim_symbols))
+	if (match(fromsec, PATTERNS(ALL_TEXT_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_INIT_SECTIONS)) &&
+	    match(fromsym, PATTERNS("*.constprop.*")))
 		return 0;
 
 	return 1;
-- 
2.39.2

