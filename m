Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62D7282AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjFHOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjFHOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55730198B;
        Thu,  8 Jun 2023 07:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A371B64E1C;
        Thu,  8 Jun 2023 14:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15FEC4339E;
        Thu,  8 Jun 2023 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234292;
        bh=Tv49Wx2718uLurHeG8QRHYpB10Ur4mWH5TKdeB3r3Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9JMO6Pph34Rul/bfEipZsbH/IK6Vox1G/S4T29o1Wdi1nNe+QJlnzU4XJXkJYaIU
         nXfgGK/UyA4YVJmbYJ44YArzehdxORxGisVHczcGaz0lIW3qW/dtx3ycnuCzS4pELe
         xFxXjmKvLEQEHikSZ2h/6rqc2svxRMTZgD8MOChvOba2vOvZFjJcC7pogYoiih3mgl
         Al0swWVPGXkhliC/ypfGNWBzsnXVVghT4vwZ78cxfGKMw56aQQa61B7qAvki7CV0Ip
         ChWRSB4I/5XU6X5FQBKJkndAouaia2AOmZX50T0FsZIj1I4d2U8w7k4bSMidCpL3ih
         5p5Oc9kuO/ZnA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 09/11] modpost: merge two similar section mismatch warnings
Date:   Thu,  8 Jun 2023 23:24:26 +0900
Message-Id: <20230608142428.256985-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
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

In case of section mismatch, modpost shows slightly different messages.

For extable section mismatch:

 "%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"

For the other cases:

 "%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n"

They are similar. Merge them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index decb7d23ef9f..85df3f3ba9ee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1147,21 +1147,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	switch (mismatch->mismatch) {
-	case TEXT_TO_ANY_INIT:
-	case DATA_TO_ANY_INIT:
-	case TEXTDATA_TO_ANY_EXIT:
-	case XXXINIT_TO_SOME_INIT:
-	case XXXEXIT_TO_SOME_EXIT:
-	case ANY_INIT_TO_ANY_EXIT:
-	case ANY_EXIT_TO_ANY_INIT:
-		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-		     modname, fromsym, fromsec, tosym, tosec);
-		break;
-	case EXTABLE_TO_NON_TEXT:
-		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-		     modname, fromsec, (long)faddr, tosec, tosym);
+	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, fromsec, tosym, tosec);
 
+	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
 			fatal("The relocation at %s+0x%lx references\n"
 			      "section \"%s\" which is black-listed.\n"
@@ -1181,7 +1170,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		else
 			error("%s+0x%lx references non-executable section '%s'\n",
 			      fromsec, (long)faddr, tosec);
-		break;
 	}
 }
 
-- 
2.39.2

