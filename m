Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01BE67F9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjA1RjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjA1Riy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:38:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FEA29E12;
        Sat, 28 Jan 2023 09:38:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 512ED60C38;
        Sat, 28 Jan 2023 17:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB9C4339E;
        Sat, 28 Jan 2023 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674927532;
        bh=GrGb9cq9sIB19Bfg04e4zkiYmu8jJkmhEilowIb/Og4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL0CscrWnVnssNZCMOLIlMWfvuZN8HbXrPrbjuVCqaBgpLGBu7NujXdKVmRAXEG9g
         FlSUNxSpA2opyc/ftP2YywZ5QnO0jGJ6+JxG9Nhg5xDheLIVj//gDvq0+wwiBigb3b
         i+qhpyvcPw/dqLpN1FbfeSWjcE3gtHznTxPt4Bro461Wiy9e/foIv+L60PxddBwr2J
         SevVw0ReF+9deWGLKJe3yqXOjXVaQMIxQFC62aScua6Yj76dltGUtsBq1UQlQ1WY6q
         IwXAVhnJUbaPf1TOycxpL3jmVod5Ec1LibRUcp34vnUfDBoPyNNJFodqsp/VpwQ8HO
         3Dzzf6VSALsSQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/4] kbuild: rpm-pkg: build binary packages from source rpm
Date:   Sun, 29 Jan 2023 02:38:42 +0900
Message-Id: <20230128173843.765212-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230128173843.765212-1-masahiroy@kernel.org>
References: <20230128173843.765212-1-masahiroy@kernel.org>
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

The build rules of rpm-pkg and srcrpm-pkg are almost the same.
Remove the code duplication.

Make rpm-pkg build binary packages from the source package built
by srcrpm-pkg.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index cb135c99a273..8fa6f05967aa 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -68,11 +68,9 @@ quiet_cmd_tar = TAR     $@
 # rpm-pkg
 # ---------------------------------------------------------------------------
 PHONY += rpm-pkg
-rpm-pkg:
-	$(MAKE) clean
-	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
-	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
-	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
+rpm-pkg: srpm = $(shell rpmspec --srpm --query --queryformat='%{name}-%{VERSION}-%{RELEASE}.src.rpm' kernel.spec)
+rpm-pkg: srcrpm-pkg
+	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -rb $(srpm) \
 	--define='_smp_mflags %{nil}'
 
 # srcrpm-pkg
-- 
2.34.1

