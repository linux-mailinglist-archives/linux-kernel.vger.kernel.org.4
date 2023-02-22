Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214369F715
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBVOuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBVOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:49:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079014C12;
        Wed, 22 Feb 2023 06:49:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61B62CE1DDB;
        Wed, 22 Feb 2023 14:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB1C433D2;
        Wed, 22 Feb 2023 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077308;
        bh=yfGB7wkl3+UVIAj3h3HfdZVfdpzFWH0CMmxedu0oZTM=;
        h=From:To:Cc:Subject:Date:From;
        b=unolfEpo3XY6bLDU5npar61VWM3jC4W/1XssF6IiK2h9L/rN/26yENZYAbZ2E3Fg6
         UiW+PdeG8XgLBijUuoQ8p4rFCWXCvclPhEA5feBkZd0Oe0KeUPZhMrWx+oH011ruh1
         5rcTRLGaAyEI2qJCzqVsi11OK3gzWweTqrflg6BjX+a4+cfl62PRKhlFbPhZTIfqlo
         8SjpuxBIM30ulYyxU9srDeikm1Y9sqq/agEgfzX2P11F/8BA1CYrBE3RmikzJA9IIR
         pBdIjgyZgNi+7Y0DXu2AQ/01iz+QwDbWNuBhFoJK6XpzG8pbYXOuOZQBNb+7mK0zwL
         KYQngtYH9LvKw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: rpm-pkg: remove unneeded KERNELRELEASE from modules/headers_install
Date:   Wed, 22 Feb 2023 23:47:29 +0900
Message-Id: <20230222144730.3813421-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

There is no need to pass KERNELRELEASE to installation targets.

KERNELRELEASE used for building the kernel is saved in
include/config/kernel.release.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 83a64d9d7372..3c550960dd39 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -99,8 +99,8 @@ $S
 	%else
 	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
-$M	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE INSTALL_MOD_PATH=%{buildroot} modules_install
-	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
-- 
2.34.1

