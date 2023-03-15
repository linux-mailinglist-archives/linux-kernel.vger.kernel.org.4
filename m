Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362996BBCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjCOTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCOTKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262C158B4B;
        Wed, 15 Mar 2023 12:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99B361E5A;
        Wed, 15 Mar 2023 19:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA5BC433D2;
        Wed, 15 Mar 2023 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678907394;
        bh=9BJPwTVMMlp2aU3GiprummHDcOkkaAFm3bnxPHRdWN4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ciim0dx8hiMREWkki909Fi445o3pjTl1da6WJFj7m0YY3HE4aTMhuEsobWz6wagYj
         oPVoQ8KG5/W34jb8V+vAVh2xy4nGz103U6tjyjqcSNT9tpaIYvz/RdlALeidCReE/4
         GOz3mtDAJv8fT7jE7ofA35hXHnfQwpQK+kcC1anZAFktk2BL/icQpPrZeCKTKDoAe7
         T5pG4MN4B9RfJZG5COfQef0cJDBTW9v8UUtHj5GOxtB9prGQYwH9rN/Z+pSKAEUIqY
         l1DlkTytirUBsYm3MhM5Seh1/yAf4okbGkxQXxg6buR7KXh10mPj1Mqr90y+l76vKX
         8Nzz4XQ7KuGlQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riad Abo Raed <riada@nvidia.com>
Subject: [PATCH -rc] kbuild: properly exclude linux.tar.gz from tar archive
Date:   Wed, 15 Mar 2023 21:09:33 +0200
Message-Id: <e0b06d9aa9f37156c4317f9915a7a0e247edb70f.1678907179.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Leon Romanovsky <leonro@nvidia.com>

Attempt to build rpm-pkg randomly fails in tar stage, with same error
as was reported by Nicolas [1]

tar -c -f linux.tar.gz -I pigz --exclude=./linux.tar.gz --exclude-from=.tmp_filelist_exclude --owner=0 --group=0 --sort=name --transform 's:^\.:linux:S' -C . .
tar: .: file changed as we read it
make[1]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
make[1]: *** Deleting file 'linux.tar.gz'
make: *** [Makefile:1657: rpm-pkg] Error 2

The reason to it that tar is dependent on order of command line
arguments and needs to have excluded file before creating it. So as a
solution, touch that file to create it and move --exclude list before
any tar arguments.

[1] https://lore.kernel.org/all/Y%2Fk+v%2FYj8VQ6q32H@fjasle.eu/
Cc: Nicolas Schier <nicolas@fjasle.eu>
Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without cleaning")
Signed-off-by: Riad Abo Raed <riada@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index b941e6341b36..be4623481ca2 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -44,7 +44,7 @@ filechk_filelist = \
 # ---------------------------------------------------------------------------
 
 quiet_cmd_tar = TAR     $@
-      cmd_tar = tar -c -f $@ $(tar-compress-opt) $(tar-exclude-opt) \
+      cmd_tar = touch ./$@ && tar $(tar-exclude-opt) -c -f $@ $(tar-compress-opt) \
                 --owner=0 --group=0 --sort=name \
                 --transform 's:^\.:$*:S' -C $(tar-rootdir) .
 
-- 
2.39.2

