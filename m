Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F870AEC2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjEUQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjEUQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D5DC7;
        Sun, 21 May 2023 09:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52B460FB0;
        Sun, 21 May 2023 16:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DC5C4339E;
        Sun, 21 May 2023 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685121;
        bh=PLUcGmlR+NY3691REVWSeKyvhjpYj54g/UwfJ/FUdKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAXOJlDLX6Ry1NQApjGojF27AzvcfLiHkd+tvuPCx1Lf7mEWKxFY0WHa6cGeNguC4
         swIUrX/7WeBad0n8PfynPYA/Kk0YzmiEe4FwgeM6nYe/X/LUr2LsN5PUNGi2ROVtqy
         hvAmWrD2445kZJHyO55munZM7D+0JFHj1jkrRbvDVfb1eVW80XOLbEY4DKCE9CIX+R
         FpebEZfge4PFQqO42Q++f6VQ+thJJXINN62NtnDTwqrE2MCPBoEgsxFJREGPppEE4w
         T0ZkYbYZI/tM81EC5uJmeaYVmdlOwL/z17B1Ju7b7eh/E9UtbJj6V4fmv6i43EzZAq
         wcMXr5uM570LQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 04/20] modpost: remove unused argument from secref_whitelist()
Date:   Mon, 22 May 2023 01:04:09 +0900
Message-Id: <20230521160426.1881124-5-masahiroy@kernel.org>
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

secref_whitelist() does not use the argument 'mismatch'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ed2301e951a9..d2329ac32177 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1035,8 +1035,7 @@ static const struct sectioncheck *section_mismatch(
  *   refsymname = *.constprop.*
  *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
-			    const char *fromsec, const char *fromsym,
+static int secref_whitelist(const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
 	/* Check for pattern 1 */
@@ -1206,7 +1205,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (!secref_whitelist(mismatch, fromsec, fromsym, tosec, tosym))
+	if (!secref_whitelist(fromsec, fromsym, tosec, tosym))
 		return;
 
 	sec_mismatch_count++;
-- 
2.39.2

