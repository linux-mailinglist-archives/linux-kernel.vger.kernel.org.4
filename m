Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0676E4B93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDQOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97AE8;
        Mon, 17 Apr 2023 07:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B9E622DB;
        Mon, 17 Apr 2023 14:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F738C433D2;
        Mon, 17 Apr 2023 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681742144;
        bh=xyEhykWo77jb6lqPEsWRugQUgBTPMFybp5iKWGmgYus=;
        h=From:To:Cc:Subject:Date:From;
        b=FBKobMNX9sTtTFjt3RRvAup6njpaxqMDmty+Jb5QANBd50/5jqfprbUQuwaB2zGrH
         IG2oI0nK5ycGtiROdrUSorXa7O/Eg/QN/wMHxzy67zScMsfc83HFaasCNHqo58rX1P
         SXaDhIUe4lneYOgDU721qCkyTFlVbGKLBIrtM+WLbUIzxJYYW14jNVVMVn1WWDYvOu
         JNZ6FGlQx0aYNqdL1Jh/tRfwz4g648I0qS4kgBQN53JO917Ibrm2F/ggjGJX/UgDGj
         EYPixZFCyIwxH2VJsMJjphOGUsZ+I80LbQFaJCd+vqGpr0H2+OTwlJAOw0DG0uQZrW
         0AwK752o59Pgg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: rpm-pkg: remove kernel-drm PROVIDES
Date:   Mon, 17 Apr 2023 23:35:35 +0900
Message-Id: <20230417143535.250565-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
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

This code was added more than 20 years ago. [1]

I checked the kernel spec files in Fedora and OpenSUSE, but did not
see 'kernel-drm'. I do not know if there exists a distro that uses it
in RPM dependency.

Remove this, and let's see if somebody complains about it.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=6d956df7d6b716b28c910c4f5b360c4d44d96c4d

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index fc8ad3fbc0a9..8049f0e2c110 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -28,11 +28,6 @@ else
 	M=DEL
 fi
 
-if grep -q CONFIG_DRM=y include/config/auto.conf; then
-	PROVIDES=kernel-drm
-fi
-
-PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
 EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
@@ -55,7 +50,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 $S	Source0: linux.tar.gz
 $S	Source1: config
 $S	Source2: diff.patch
-	Provides: $PROVIDES
+	Provides: kernel-$KERNELRELEASE
 $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
 $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
-- 
2.37.2

