Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0F6BB9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjCOQaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjCOQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:29:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4438B52;
        Wed, 15 Mar 2023 09:29:53 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678897791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/XBXXM6poOLUz6DLq//1r04pc3BCCslWpFv9PZ8fEc=;
        b=GscP2+3jHOr3BREJist/ojOJw87k8P26mjNBXmnNaVV/gHIOSrxS1Sgz3e+XWIzB9XCjRa
        VdoRpW56dkG0i3ylLaU4zBhpej3BoMxWL6l5To5hXMWApve9UJXjYtOciVjyIP6fn1gah0
        sEHBEu9Cr2Db38kd5GM25nNHfvlGJ2etLjUgB6OVqQgL+5f3Pb7gGjTUaeFY5Wm2WWMbOZ
        Xd0AfYhmGACyYK/62L+pe4UMi/3QIWGehFUs9XrcOxDHZ4Eif+6vC8dn3AccYpkQoCeh0M
        MZbo6ugx8OAaxgFT6uuAjmw5R751Hr6vy6yBxHPymlBlxwv+mnJ2FpEkOmED0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678897791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/XBXXM6poOLUz6DLq//1r04pc3BCCslWpFv9PZ8fEc=;
        b=Fnu7swAXfJvnaMocIo95rNtJX2JHcuJxlsAAl71yCa7MbEqFA7JenT+F8/Hkf7Iw7D2wJS
        ZzLqEtAePRLYu4AA==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
Date:   Wed, 15 Mar 2023 17:29:43 +0100
Message-Id: <20230315162944.39542-2-bage@linutronix.de>
In-Reply-To: <20230315162944.39542-1-bage@linutronix.de>
References: <20230315162944.39542-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dpkg-buildpackage v1.21.10 or later, the only way to build the
deb-pkg generated package parallely is adding -j<N> to the MAKEFLAGS
environment variable or using the --jobs-force option. The package ignores
the usual parallel build option that is described in Debian Policy §4.9.1.

Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variable
that ends up being set by dpkg-buildpackage -j<N>.

Link: https://www.debian.org/doc/debian-policy/ch-source.html
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/package/mkdebian | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f74380036bb5..0217790e7a26 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -238,11 +238,15 @@ fi
 cat <<EOF > debian/rules
 #!$(command -v $MAKE) -f
 
+ifneq (,\$(filter parallel=%,\$(DEB_BUILD_OPTIONS)))
+	JOBS = -j\$(subst parallel=,,\$(filter parallel=%,\$(DEB_BUILD_OPTIONS)))
+endif
+
 srctree ?= .
 
 build-indep:
 build-arch:
-	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \$(JOBS) \
 	\$(shell \$(srctree)/scripts/package/deb-build-option) \
 	olddefconfig all
 
@@ -250,10 +254,10 @@ build: build-arch
 
 binary-indep:
 binary-arch: build-arch
-	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} intdeb-pkg
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \$(JOBS) intdeb-pkg
 clean:
 	rm -rf debian/files debian/linux-*
-	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} clean
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \$(JOBS) clean
 
 binary: binary-arch
 EOF
-- 
2.39.2

