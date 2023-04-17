Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF6E4B71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDQO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDQO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64B1B0;
        Mon, 17 Apr 2023 07:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B382625FC;
        Mon, 17 Apr 2023 14:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C926C433D2;
        Mon, 17 Apr 2023 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681741555;
        bh=4VUfUFTzriUEayXF7DZGvDbUbjRc4fsFHIWx3dcJhYU=;
        h=From:To:Cc:Subject:Date:From;
        b=N35E61l7MknlldPrCkwVeaAaOA6fbZtbhZ9Ulezets7P9AiwfKKszo9AyBjG2nwf8
         Bs1F/UpANpgQWwaIdVGzW8XBGxVVQgl0It5JqM+U7R+5dFeYSmiZkd2D01LQJwtqwJ
         HuYM/sO4vxIWKasOyts/2vkdqCkSyOihFg6JjI4GXQz2cRIHzlYsBfvIT+E0ozDNNH
         vQDr9ZdKwMyi8VD5lu7P+DIGXmDZwSTJm97xWc78zsDMKr8cTpdNzvPg6y5W+HyuKn
         79n8oh7RJ32NzvkS00l3s6sXZeyCw91D0qWXlDs7kUmLHui8zvs0XOwpEKeC+U6WnU
         nh9gdyl3ocj8w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Bastian Germann <bage@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] kbuild: add srcdeb-pkg target
Date:   Mon, 17 Apr 2023 23:25:47 +0900
Message-Id: <20230417142548.249610-1-masahiroy@kernel.org>
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

This new target builds only the debian source package.

Unify the build rules of deb-pkg, srcdeb-pkg, bindeb-pkg to avoid
code duplication.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

 scripts/Makefile.package | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 4d90691505b1..d8a36304b26e 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -5,7 +5,6 @@ include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.lib
 
 KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
-KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 # Include only those top-level files that are needed by make, plus the GPL copy
 TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
                include init io_uring ipc kernel lib mm net rust \
@@ -86,6 +85,9 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
+# deb-pkg srcdeb-pkg bindeb-pkg
+# ---------------------------------------------------------------------------
+
 quiet_cmd_debianize = GEN     $@
       cmd_debianize = $(srctree)/scripts/package/mkdebian $(mkdebian-opts)
 
@@ -104,14 +106,25 @@ debian-orig: linux.tar.gz debian
 		cp $< ../$(orig-name); \
 	fi
 
-PHONY += deb-pkg
-deb-pkg: debian-orig
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary -nc -us -uc
+KBUILD_PKG_ROOTCMD ?= 'fakeroot -u'
+
+PHONY += deb-pkg srcdeb-pkg bindeb-pkg
+
+deb-pkg:    private build-type := source,binary
+srcdeb-pkg: private build-type := source
+bindeb-pkg: private build-type := binary
 
-PHONY += bindeb-pkg
+deb-pkg srcdeb-pkg: debian-orig
 bindeb-pkg: debian
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
+deb-pkg srcdeb-pkg bindeb-pkg:
+	+$(strip dpkg-buildpackage \
+	--build=$(build-type) --no-pre-clean --unsigned-changes \
+	$(if $(findstring source, $(build-type)), \
+		--unsigned-source) \
+	$(if $(findstring binary, $(build-type)), \
+		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		--no-check-builddeps) \
+	$(DPKG_FLAGS))
 
 PHONY += intdeb-pkg
 intdeb-pkg:
@@ -208,6 +221,7 @@ help:
 	@echo '  srcrpm-pkg          - Build only the source kernel RPM package'
 	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
 	@echo '  deb-pkg             - Build both source and binary deb kernel packages'
+	@echo '  srcdeb-pkg          - Build only the source kernel deb package'
 	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
 	@echo '  snap-pkg            - Build only the binary kernel snap package'
 	@echo '                        (will connect to external hosts)'
-- 
2.37.2

