Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFE5F69A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJFOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJFOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:33:33 -0400
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A357B1CE;
        Thu,  6 Oct 2022 07:33:31 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net [173.49.113.140])
        (Authenticated sender: zack)
        by letterbox.kde.org (Postfix) with ESMTPSA id 97D0232CAA7;
        Thu,  6 Oct 2022 15:33:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1665066809; bh=LzCW97odh7pu0RlVHSlZ7ZsFhUmcRmuT4QaeAcOWs9I=;
        h=From:To:Cc:Subject:Date:From;
        b=K0d7ZatQ9wJhIQtz7wFBE9wL6WFzIq+MuEVbvd01irXkGZ1+sHUc73ujY/S1RjN/i
         v+4iNmDshQtr5Dq/R7LBAbZv14kRKWr5isBgnwT9n/5xKtVMwbH2nk9LGhAa7+Sc0M
         KQbVW9onqkp2F5tIDmFl3keB6ZDW3Eu5LlevxGH4ghYG6ArcOcN0i6r0CoV80I0wmn
         1phlM0U/oAn/zF6vXvgVR501YIAKH5fvpCLUnOHjK+kdwPXgEqKIFExNWI1QZ7hvH9
         at1XGHhD6kjNEF7Mk6Z1LdpGA6UagOqHv9JoiebTdRSYvZCpzzNQ8ocefnLWpSFSO/
         4g8d8YwIxv2Qg==
From:   Zack Rusin <zack@kde.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Stop including vmlinux.bz2 in the rpm's
Date:   Thu,  6 Oct 2022 10:33:19 -0400
Message-Id: <20221006143319.264657-1-zack@kde.org>
X-Mailer: git-send-email 2.34.1
Reply-To: Zack Rusin <zackr@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

vmlinux.bz2 was added to the rpm packages in 2009 in the
fc370ecfdb37 ("kbuild: add vmlinux to kernel rpm") but seemingly hasn't
been used since.

Originally this should have been split up in a seperate debugging
package because it massively increases the size of the generated rpm's
e.g. kernel rpm built using binrpm-pkg on Fedora 36 default 5.19.8 kernel
config and localmodconfig is ~255MB with vmlinux.bz2 and only ~65MB
without it.

Make the kernel built rpms about 4x smaller by not including the unused
vmlinux.bz2 in them.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 scripts/package/mkspec | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 8fa7c5b8a1a1..af06d03fe7e2 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -97,8 +97,6 @@ $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
-	bzip2 -9 --keep vmlinux
-	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
 $S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
-- 
2.34.1

