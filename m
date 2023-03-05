Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BB6AB37C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCEXZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 18:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCEXZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 18:25:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32CE193E6;
        Sun,  5 Mar 2023 15:25:50 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678058747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1oqD3RLQE54KREnjnPSNU36NDXrqx5n49sI1IXyxQQ=;
        b=OX3+jXTYtDpuW7Y6HuXsrKM3fyr63rOlkxq722F4e7HW5MeMioSc5zunPt+90c6ilYhA8Q
        ydfErU+k6sFzF4pDzVDjJlDrVbZ565dC79fmULqHnbuW0YqXdBrHyK9XvtZn2C+UqC9/n2
        6U875vPXwtnSovDKO6IjKZuUdQ3gNE6q59myCyjHRDCFzQJKXCY3KGHdJgbqRXli2WsEFr
        v/PYhd3gMKz9jGE1wpF8xyCvX8PhWiTmhpZYODndz2Xiul/5UteGRTiAkTtq/JurbKvh2j
        ssIsVMqWjchsJ2/QhtYjTH/PV1oynO1+SNZE5GQ+EzfBm1Ej5RkJSKFVc6Sdkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678058747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1oqD3RLQE54KREnjnPSNU36NDXrqx5n49sI1IXyxQQ=;
        b=/YWYg87hXlmtkAgCJ2Vk4S8dmVu+0GGg8XgI3VgijIoVrIYrSs2XNhY+s74vleyA6tt00G
        0ri1XNInXIFhwnCg==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Date:   Mon,  6 Mar 2023 00:25:35 +0100
Message-Id: <20230305232536.19528-2-bage@linutronix.de>
In-Reply-To: <20230305232536.19528-1-bage@linutronix.de>
References: <20230305232536.19528-1-bage@linutronix.de>
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

deb-pkg's dpkg-buildpackage invocation was added --build=source,binary
recently. Before, it relied on the default, which is
--build=source,binary,all and makes no difference for the built packages
as there is no "Arch: all" package.

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

