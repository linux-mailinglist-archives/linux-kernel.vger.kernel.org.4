Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56694678EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjAXDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXDE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B8B2CC76;
        Mon, 23 Jan 2023 19:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3905B80F99;
        Tue, 24 Jan 2023 03:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59182C433D2;
        Tue, 24 Jan 2023 03:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674529463;
        bh=giFIQo+mjqzUUAV7LAIzGUVEWvIHRytr3LaLHfDbk2w=;
        h=From:To:Cc:Subject:Date:From;
        b=IAqYOov90Vt0z/H9fPMmFNv/ri0lGsPKsg8UVpyD1I2pzvuSY70OZzpeh7Pd7e6Pc
         r4OVd5P46C2Vy0B2Ymq15ElVPy+hUMnVmeDbRwTKSqJVqg0l024fhcN218zncKCud4
         V6//xSv9nYQnLK5ECqQO45SMxNbXzWcy8nQV2ArZ8CghBeyIGk+zlolt/aEtNwA9nK
         eSZ80KfpsYBA/I76VkGCXnf1geIO1gL6/7HelxCWFsWjrBSEVGo4fEB+fpIjoNkKAh
         cNx3J6FWeuFXGiUpAyhTVeJVVi6jd4ZW4vdqkUbiM+NnH6mpIhbQQNbOkdjpuL1w96
         wMknuwlhLtkkw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: deb-pkg: add --source-option=-sP
Date:   Tue, 24 Jan 2023 12:04:16 +0900
Message-Id: <20230124030416.1164288-1-masahiroy@kernel.org>
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

If the source package fails to build, ../linux.orig is left over.
In the next run of 'make deb-pkg', you will get the following error:

  dpkg-source: error: orig directory 'linux.orig' already exists, not overwriting, giving up; use -sA, -sK or -sP to override

You can manually remove ../linux.orig, but it is annoying.

Pass -sP down to dpkg-source.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index e84c4e8ceb8e..dfbf40454a99 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -86,7 +86,7 @@ deb-pkg:
 	$(call cmd,src_tar,$(KDEB_SOURCENAME))
 	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
 		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -i.git -us -uc
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) --source-option=-sP -i.git -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg:
-- 
2.34.1

