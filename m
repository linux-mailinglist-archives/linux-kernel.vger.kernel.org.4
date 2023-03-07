Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55326ADD23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCGLUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCGLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:20:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE65BBF;
        Tue,  7 Mar 2023 03:20:38 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678188036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vw/agwiRkH/+qz3TgnqeX8PAPR86KX4ifoh9bejOFI=;
        b=HnhWD+zaIYTjQ/aIHcCbBzBcXGb6jwJG8wENNfT9RULwXh3gxsL1tIfaw6EeVkG1JTPV1D
        p6PeqsNO2I+igjnJIHoCBZIrdyXGTvQIFAcIuI4ACJ3CmynBAjaVyTOMSegPRIVI6TYOyL
        eBbob9h/bR7ktg4KlwIiBr9LpKw2mb0kyJ4min8ADpLruPhezGKEp/vP67oOe0IFf6VnqJ
        wAQ9bC8W36l0vowGS+oKU8qGblG8aJhhtiz34lBhPmkFg9s1udHFVOzPrMwkuMKH9rFmL0
        WMlyI6PeOjGvubDbq1kRg4nm3jJZKgDVP+/EKeNaonIhzncXRS6WdEUq4xcjvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678188036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vw/agwiRkH/+qz3TgnqeX8PAPR86KX4ifoh9bejOFI=;
        b=jDthIXZY5FL8BWMghwGGyx970u1hMYGAyUIqmQNRkl/bl4t5p4Xp9f/waGqd1DLFC9J9RP
        cc/7s1xG6I9PGKAg==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Bastian Germann <bage@linutronix.de>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Date:   Tue,  7 Mar 2023 12:20:28 +0100
Message-Id: <20230307112028.14190-2-bage@linutronix.de>
In-Reply-To: <20230307112028.14190-1-bage@linutronix.de>
References: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
 <20230307112028.14190-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deb-pkg's dpkg-buildpackage invocation was added --build=source,binary
recently. Before, it relied on the default, which is the same, so it
no difference for the built packages.

However, the explicit --build eliminates overriding it via DPKG_FLAGS,
which used to fill the gap of generating only a source package without
building it.

Recover the old, default behavior.

Fixes: 7bf4582d7aad ("kbuild: deb-pkg: create source package without cleaning")
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index b941e6341b36..fe1721915a59 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -120,7 +120,7 @@ debian-orig: linux.tar.gz debian
 PHONY += deb-pkg
 deb-pkg: debian-orig
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary -nc -us -uc
+		-nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg: debian
-- 
2.39.2

