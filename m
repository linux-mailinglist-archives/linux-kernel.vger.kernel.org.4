Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093966BBAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjCORfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCORfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA151231E7;
        Wed, 15 Mar 2023 10:35:35 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678901733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZku9m6kfdujj4yMSFGSvRZ2JtD5CDHhGlIEaw7ici4=;
        b=1RDu+4JQNGvY7f0c7ybbV0KMc8lGdoSAaheCLOkJM7mdBeSPgCOZmM3kWVaRhHJJnGveTa
        uBbm9iR95WzDy5rDE6526YKnP7WvtM5P17gGt2F/S9lx8x6HDVYHYIr1t5JJcBGvpa7J/8
        OWJITatSTzY2V3mgTUvtxG0k0EPTCbrOCpy0GsC7SHnbrQVMVBt7xstX17JeOQ1/5MuY8h
        qO+gM3937xKuqpbyZPskUprrlCysnl1jzZGdHRGRYASU0bP7C7TmHHD5SNAP1PETqYCiH5
        GPV27mTmIdHlhFH5SA+BCx6qPgDKmADfQjlpOjcEgii9g7lQlNlpRJo5KgJ+5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678901733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZku9m6kfdujj4yMSFGSvRZ2JtD5CDHhGlIEaw7ici4=;
        b=/lkp2PeuVO+2FTtKJ0dQP24G6MDU+Vx5aof2hTWdnRNtUm/8mUx0X4X2EhHhryPZJlabTl
        ki8VOGnjLOCYiiBg==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
Date:   Wed, 15 Mar 2023 18:35:24 +0100
Message-Id: <20230315173524.63179-2-bage@linutronix.de>
In-Reply-To: <20230315173524.63179-1-bage@linutronix.de>
References: <20230315173524.63179-1-bage@linutronix.de>
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

With dpkg-buildpackage v1.21.10 or later, the only way to build the
deb-pkg generated package parallely is adding -j<N> to the MAKEFLAGS
environment variable or using the --jobs-force option, see dpkg commit
1d0ea9b2ba3f ("dpkg-buildpackage: Change -j, --jobs semantics to
non-force mode"). The package ignores the usual parallel build option
that is described in Debian Policy.

Derive make's -j parameter from the DEB_BUILD_OPTIONS environment variable
that ends up being set by dpkg-buildpackage -j<N>. The snippet is copied
from Debian Policy.

Link: https://www.debian.org/doc/debian-policy/ch-source.html#debian-rules-and-deb-build-options
Signed-off-by: Bastian Germann <bage@linutronix.de>
---
 scripts/package/mkdebian | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f74380036bb5..ed5c2b65798b 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -238,6 +238,11 @@ fi
 cat <<EOF > debian/rules
 #!$(command -v $MAKE) -f
 
+ifneq (,\$(filter parallel=%,\$(DEB_BUILD_OPTIONS)))
+	NUMJOBS = \$(patsubst parallel=%,%,\$(filter parallel=%,\$(DEB_BUILD_OPTIONS)))
+	MAKEFLAGS += -j\$(NUMJOBS)
+endif
+
 srctree ?= .
 
 build-indep:
-- 
2.39.2

