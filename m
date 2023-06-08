Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15057282AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbjFHOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjFHOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51D1FCC;
        Thu,  8 Jun 2023 07:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3A564E21;
        Thu,  8 Jun 2023 14:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F59C4339C;
        Thu,  8 Jun 2023 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234293;
        bh=iWuNSLxO6q6HZETxHyJL7TfXVCdA5aUkY9bgnycApiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tq32c9BM1jBz7n3OZOSVEKvK8CIw2f30Sc5jMXaFZuSj9ggqikMCPqn7VTj54d8A6
         L7W6koyjYkTKWhvPAWAoB/DocpdbNRQmVt7Fb6QgmxXrdv5SFvwiXuL8uKm4M62mOT
         ftmyEiKKgMoxx1KrVuv7D09woIaGiWylwqoFWcfa8po12eMQYGGODmx4Jjd6AOO2NB
         jSFXVIwXS9dQM2AZy4hv9NMyrdZJnf8ZNCUki98sFcLHqDAtcH/nZ5J+a1tDBs1jx9
         tN8MNU+VTiPXxDdZ/fUbebfIXPo80i69iWmxuCBkpsXXS1BIcMPA9IbSAXXAVIrTsq
         kp5GlTS6jU7DQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 10/11] modpost: show offset from symbol for section mismatch warnings
Date:   Thu,  8 Jun 2023 23:24:27 +0900
Message-Id: <20230608142428.256985-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, modpost only shows the symbol names and section names, so it
repeats the same message if there are multiple relocations in the same
symbol. It is common the relocation spans across multiple instructions.

It is better to show the offset from the symbol.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 85df3f3ba9ee..40967ed816df 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1147,8 +1147,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, fromsec, tosym, tosec);
+	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.39.2

