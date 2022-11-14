Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38C627CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiKNLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiKNLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:47:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07582222B4;
        Mon, 14 Nov 2022 03:45:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2BC61093;
        Mon, 14 Nov 2022 11:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC2FC433B5;
        Mon, 14 Nov 2022 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426329;
        bh=VHTSznvRU1NJt50Gn5cdfooru5h/hvP+AUl+sJEGPhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vH2xVVq9a7oMkBu897W0gAjD0uxcCuvGq364us9j38XwBhoYpK8lFuUcFpiWDuxut
         Rsu0/3S/RibVjT4IyA5Ub6bRkMIFahMLJwEj0f0edsEqkwxelhgus+v7RrQCCfLaZl
         yen5wyyk4N+ExrJ4A27S61XQL3Gi4R11PvTXF6VSm+z9OG0ugUmGYAZ2tYiI+92bq8
         VksRgFcyAPLh+LqhvXh0lLNY46bkwx/tzkFbOSiak1O6hcRKUI5jXUvXny8xqmM125
         4+VUObmU1Ll+vN5aesZZUCHC75DdkqIjkZ5a+I8GAGHUQ4gfH9jf9Ytd/AE+00JKhF
         BioFZgDVl2A4w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 38/46] Kbuild, lto: don't include weak source file symbols in System.map
Date:   Mon, 14 Nov 2022 12:43:36 +0100
Message-Id: <20221114114344.18650-39-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

The gcc LTO build can generate some extra weak source code file name
symbols on the second kallsyms link like:
  0000000002fdf20a W head64.c.552cf5a6

This causes the "Inconsistent kallsyms data" error due to mismatches in
the stage1 vs stage2 kallsyms link. Filter those out when generating
the System.map.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/mksysmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 16a08b8ef2f8..0f19a44ab136 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -34,6 +34,7 @@
 #   U - undefined global symbols
 #   N - debugging symbols
 #   w - local weak symbols
+#   W - weak symbols if they contain .c.
 
 # readprofile starts reading symbols when _stext is found, and
 # continue until it finds a symbol which is not either of 'T', 't',
@@ -57,4 +58,5 @@ $NM -n $1 | grep -v		\
 	-e ' __kstrtab_'	\
 	-e ' __kstrtabns_'	\
 	-e ' L0$'		\
+	-e ' W .*\.c\.'		\
 > $2
-- 
2.38.1

