Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698826B7A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCMOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCMOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:18:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B744EF5;
        Mon, 13 Mar 2023 07:17:59 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678717077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJdIETnTtAzOLiF9tcbM5XRsp53hnZeWTZlPoSoLdx0=;
        b=bEflwGLvM9qzRRu9HOAS+cDk1h/iNdlsWhWq/4Ax8YG3755yg4/wvyTouAh82f/thNXY2G
        xduXSOrfINendSuEk7aoUi9ay9fWXr/lD7ylyneud0YsksIFZvYSK4t77z3TukV0hJVl7a
        8+e6yH8LmC6LOiR7jIPdDwCGJ8JGhEaAwhiDDdWukKBdYuebmSiLlNDu2pPiIllz4YV3Ax
        YCDRaUTZiAcoLhWdzZ/QfnCMA0HcsY9Un/SjJV90ahcJJC+agNQhtNyhYuB2S4+glDaG7S
        V36SFwT8pIUzwsHe7adudJXzt9kBQGYBjct0KuJEvFQAyZanVXw0knCc/K+c2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678717077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJdIETnTtAzOLiF9tcbM5XRsp53hnZeWTZlPoSoLdx0=;
        b=uBB5q9bDzR4XNyTe843O9136d85NHblxcdWATbCdX5vXE2ImDSJ5ZgHbD/RfCcTCahW78L
        fApYqDXkM1x6cZAA==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] builddeb: introduce profile excluding the dbg pkg
Date:   Mon, 13 Mar 2023 15:17:51 +0100
Message-Id: <20230313141751.186903-2-bage@linutronix.de>
In-Reply-To: <20230313141751.186903-1-bage@linutronix.de>
References: <20230313141751.186903-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_DEBUG_INFO implies building the binary linux-image-*-dbg.
As this increases package build time significantly, one might want to
exclude it from being built.

Add build profile pkg.$sourcename.nokerneldbg for that package
so it can be excluded via e.g.
`make DPKG_FLAGS=--build-profiles=pkg.linux-upstream.nokerneldbg deb-pkg`

The name is the same that is used in Debian's linux package since version
5.17~rc4-1~exp1.

Link: https://wiki.debian.org/BuildProfileSpec
Link: https://salsa.debian.org/kernel-team/linux/-/commit/140798ec2789
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/package/builddeb | 4 +++-
 scripts/package/mkdebian | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index ff5e7d8e380b..30f3948b8c7c 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -128,7 +128,9 @@ parisc|mips|powerpc)
 	installed_image_path="boot/vmlinuz-$version"
 esac
 
-BUILD_DEBUG=$(if_enabled_echo CONFIG_DEBUG_INFO Yes)
+if [ "${DEB_BUILD_PROFILES#*nokerneldbg}" = "$DEB_BUILD_PROFILES" ]; then
+	BUILD_DEBUG=$(if_enabled_echo CONFIG_DEBUG_INFO Yes)
+fi
 
 # Setup the directory structure
 rm -rf "$tmpdir" "$dbg_dir" debian/files
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f74380036bb5..8a7969926e53 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -227,6 +227,7 @@ if is_enabled CONFIG_DEBUG_INFO; then
 cat <<EOF >> debian/control
 
 Package: linux-image-$version-dbg
+Build-Profiles: <!pkg.$sourcename.nokerneldbg>
 Section: debug
 Architecture: $debarch
 Description: Linux kernel debugging symbols for $version
-- 
2.39.2

