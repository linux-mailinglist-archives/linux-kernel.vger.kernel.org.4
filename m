Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81E627060
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiKMQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:02:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763CE0D5;
        Sun, 13 Nov 2022 08:02:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89D960B1B;
        Sun, 13 Nov 2022 16:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A07C433C1;
        Sun, 13 Nov 2022 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668355370;
        bh=fd55kZAvjkdETDENLLWlzIVZsgNDYBlzkiG2yK3Pih8=;
        h=From:To:Cc:Subject:Date:From;
        b=u49yItbgwJ5myv8DAsSJ2enIlJTQvQqItouAeaZRU3SIkvky0jPxg39lLQrocqSBz
         r9hu/AUXJcSnH3cH9/p0Gu/wkM9H/e5lbiOQIAoGNxACbVRHhVr0jxkkjamnIgUFSI
         Tnnd+kOIwAxFbr8p55RQzcwWLqKSIB0P7AR9v8LPTI7qKvV8DvDYz7gYLIfC1GA0Cd
         pEmUwRswltUlEfScBGFxjDH4yc0isxg9iP5tA5sKfA9uFN8nmjUPbMOEYjsZIdDliq
         T2geJtYbCE6c46u49c4CmbeKVEceNXSGsNmAjeARO2pbAGy7VWjYmLseTgLr84f6bE
         yDa/mtI9bBQvA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ouFRY-005oI3-0F;
        Sun, 13 Nov 2022 16:02:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: Restore .version auto-increment behaviour for Debian/RPM packages
Date:   Sun, 13 Nov 2022 16:02:37 +0000
Message-Id: <20221113160237.3152770-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net, ndesaulniers@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2df8220cc511 ("kbuild: build init/built-in.a just once"),
generating Debian packages using 'make bindeb-pkg' results in
packages that are stuck to the same .version, leading to unexpected
behaviours (multiple packages with the same version).

Restore the previous behaviour by calling init/build-version
instead of reading the .version file. This is likely to result
in too many .version bumps, but this is what was happening before
(although the bump was affecting builds made the current one).

Only tested with bindeb-pkg.

Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/package/mkdebian | 2 +-
 scripts/package/mkspec   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 60a2a63a5e90..e5c983afddab 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -90,7 +90,7 @@ if [ -n "$KDEB_PKGVERSION" ]; then
 	packageversion=$KDEB_PKGVERSION
 	revision=${packageversion##*-}
 else
-	revision=$(cat .version 2>/dev/null||echo 1)
+	revision=$(init/build-version)
 	packageversion=$version-$revision
 fi
 sourcename=$KDEB_SOURCENAME
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 70392fd2fd29..9cbd45f497ba 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -42,7 +42,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Name: kernel
 	Summary: The Linux Kernel
 	Version: $__KERNELRELEASE
-	Release: $(cat .version 2>/dev/null || echo 1)
+	Release: $(init/build-version)
 	License: GPL
 	Group: System Environment/Kernel
 	Vendor: The Linux Community
-- 
2.34.1

