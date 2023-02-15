Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF4697389
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjBOBWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjBOBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88534329;
        Tue, 14 Feb 2023 17:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE0F61995;
        Wed, 15 Feb 2023 01:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17A1C4339B;
        Wed, 15 Feb 2023 01:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424110;
        bh=6sFDo6FafZi154G+JCbShxczRgVL1UN+FRTvqIYv8wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDqGKl+e1zll1x7Oa+77V7fifFvYMVKuuRpY6xxqqIzJVqVtCivlOHhSKJ4fjYL8c
         V63fs825mPcRJFVNaUUYLfKKUm38cmk8uFwnZbZxmp2yspSz9nfBGPqJrjgdp5kNGv
         byQ9pJEpJ27i21kmv+qi8JK3yKHTyl3Lcpb0p+ULApO5Zl+DocQ5cNOSmcu/1GN2b6
         p1P4tNdwogGihrezA+m5GgRt1uByym4FcNE+spKDypMkJFOjsxAEko3btGW+IcvJRI
         opWem93UZ1WKTc5SWkLHnX+aplDKVTd5ESJtlsgmykFeo411uTMycO+YyAImm6iPks
         yPlF1EaZSK8ZA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 10/12] kbuild: deb-pkg: fix binary-arch and clean in debian/rules
Date:   Wed, 15 Feb 2023 10:20:32 +0900
Message-Id: <20230215012034.403356-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clean target needs ARCH=${ARCH} to clean up the tree for the correct
architecture. 'make (bin)deb-pkg' skips cleaning, but the preclean hook
may be executed if dpkg-buildpackage is directly used.

The binary-arch target does not need KERNELRELEASE because it is not
updated during the installation. KBUILD_BUILD_VERSION is not needed
either because binary-arch does not build vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - New patch

 scripts/package/mkdebian | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 22fc73a5e4f2..eef20d5dc288 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -251,12 +251,10 @@ build: build-arch
 
 binary-indep:
 binary-arch: build-arch
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile intdeb-pkg
-
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} intdeb-pkg
 clean:
 	rm -rf debian/files debian/linux-*
-	\$(MAKE) clean
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} clean
 
 binary: binary-arch
 EOF
-- 
2.34.1

