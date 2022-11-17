Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2362D0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiKQBas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKQBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1645EDA;
        Wed, 16 Nov 2022 17:30:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B489F61F76;
        Thu, 17 Nov 2022 01:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A006C433D6;
        Thu, 17 Nov 2022 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668648641;
        bh=+PGZeGtBYoTBr5h6JcWPDbDXDm8TITSpW/m6MKyrUeo=;
        h=From:To:Cc:Subject:Date:From;
        b=L/UZOKq9H6xje/OlvgNOHky3TkyOVMOX5gC1BQpPEaanxgTNZFFPl6Fyo08M03FOi
         7yYzVYkCjAkCcjpPYyzKd4bR+Qajdmigy8nyXKo2DlW5fkyORMqRTXxbcx6AdWR/cx
         y84siDxlHNZh2PNsN5q4qNVbxAuiE/NJyR6VwVTMURZU+IgCfx0KDoVXQDwLlRQfRm
         dinfiMAC225cWKZOYuNIeAkvLQOpUFEeodUQHfVCRZKCu2R+Q2FpNlDqlRiD+Rjfrm
         quDAmH7GFSaYc70HLfZETuszZwI3nWATNh6cr8hr7AsOYnUY3m+GBdglb1RmpTJjBn
         BrcM3SPCZPKQw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: get rid of |flex:native workaround from Build-Depends
Date:   Thu, 17 Nov 2022 10:30:33 +0900
Message-Id: <20221117013033.1105289-1-masahiroy@kernel.org>
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

"| flex:native" was a workaround (suggested by Ben, see Link) because
"MultiArch: foreign" was missing in the flex package on some old distros
when commit e3a22850664f ("deb-pkg: generate correct build dependencies")
was applied.

It seems fixing the flex package has been completed. Get rid of the
workaround.

Link: https://lore.kernel.org/linux-kbuild/ab49b0582ef12b14b1a68877263b81813e2492a2.camel@decadent.org.uk/
Link: https://wiki.debian.org/CrossBuildPackagingGuidelines
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 60a2a63a5e90..852d13e738c5 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -175,7 +175,7 @@ Section: kernel
 Priority: optional
 Maintainer: $maintainer
 Rules-Requires-Root: no
-Build-Depends: bc, rsync, kmod, cpio, bison, flex | flex:native $extra_build_depends
+Build-Depends: bc, rsync, kmod, cpio, bison, flex $extra_build_depends
 Homepage: https://www.kernel.org/
 
 Package: $packagename-$version
-- 
2.34.1

