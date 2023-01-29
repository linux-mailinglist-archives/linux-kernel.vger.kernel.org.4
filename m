Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48696800E2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjA2SqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjA2SqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:46:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233BF1E1F7;
        Sun, 29 Jan 2023 10:46:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2FEA60DDC;
        Sun, 29 Jan 2023 18:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA29C4339E;
        Sun, 29 Jan 2023 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675017974;
        bh=R3C1yPHqmwWVWqJshYNvFRThjW5p8L53OLdI9EyXq2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrdNlcajd3swD5hnUlJUcyBFLyx2peA8bKV8cMyTnfbQLqoZyYf4oqEzJDLsFe0Ht
         j0f9dLm4JwbwLdeo2w4l/f1q7XOnHKqsq0WjQHnN6sFr/iHz1pa8A/4t0UKR93BpOi
         s5+Wi3wWoYynRTDZ7wJNRslrigqHfKS2htnZ6HT9MqKvzcXcTgws8wHkIJ7O3+3/1n
         mOFF8g6V29QOcfoZoLASbTzd7M1Rv02dKnC59E29I16JHqJEA2gduB+qL3oSuQS7j6
         /yx7eOO2+izBv1OmnWnLRhFjs/QcBG1J9bGnlnqS+f895ivq7TqW/9vShY7kFrAltz
         F1mgZq8hUaHXQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 3/5] kbuild: rpm-pkg: build binary packages from source rpm
Date:   Mon, 30 Jan 2023 03:46:00 +0900
Message-Id: <20230129184602.3974058-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230129184602.3974058-1-masahiroy@kernel.org>
References: <20230129184602.3974058-1-masahiroy@kernel.org>
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

The build rules of rpm-pkg and srcrpm-pkg are almost the same.
Remove the code duplication.

Change rpm-pkg to build binary packages from the source package generated
by srcrpm-pkg.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/Makefile.package | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 5ac0a2dec01d..97e146885e53 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -72,11 +72,9 @@ quiet_cmd_tar = TAR     $@
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

