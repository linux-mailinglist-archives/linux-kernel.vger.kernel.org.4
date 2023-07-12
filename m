Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025BE74FF89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGLGmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGLGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8719B;
        Tue, 11 Jul 2023 23:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A530616E3;
        Wed, 12 Jul 2023 06:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE665C433CB;
        Wed, 12 Jul 2023 06:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144141;
        bh=Lts7Ttry/DWypJyUuGIPywZ4oz1JjOWCv4NgY2hLjS8=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=UPjhm3r0ruTcSU8J/DisQuvVFubBpmkrQiRG66SNPMUZWT3Z/wPH1lRv6QTCidhPT
         4p5mM4KYSLep6ITrOE6dfkpqT+13PI1ojUBBLOyYhbjDudjaoCW+y7Qg4GpOAu4S1O
         c32vGGvFK9tdXdAp46iIDy2sgLv0uDvsT41U6eYcsIxXzfDlbj1j2RpqpS0VvjHCmZ
         do69/LbC//53GfcfddojTfRaK2mkDRg8Y+0BFwBKEpkG+DMf0DrNZTx0DiTLM5q8QT
         sMOe9EO3iIqDyPBYXfmUpj8waqwj6l5w6m0IipXUkEy2LqSnZ1AA2TIb0k6dGUNyvB
         4DAa+sSNLWlNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A56FFEB64DA;
        Wed, 12 Jul 2023 06:42:21 +0000 (UTC)
From:   Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date:   Wed, 12 Jul 2023 08:42:20 +0200
Subject: [PATCH] kbuild: rpm-pkg: Add dtbs support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-kbuild_rpm_dtbs-v1-1-99693e8faaaf@jannau.net>
X-B4-Tracking: v=1; b=H4sIAEtLrmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Mj3eyk0syclPiigtz4lJKkYt0UA1PTRGNzC4OkpFQloK6CotS0zAq
 widGxtbUAJFQ7cGEAAAA=
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=j@jannau.net;
 h=from:subject:message-id; bh=pqGGqDq9keUrENGYOALz/M+BMKf1FbSWOisiewqrdWw=;
 b=owJ4nJvAy8zAJbZQ2uZ2r35qGuNptSSGlHXePilL8v9Nb7kXvHy/hEax8s0vUYeldk7jW13n1
 KO9OHr5Mo2OUhYGMS4GWTFFliTtlx0Mq2sUY2ofhMHMYWUCGcLAxSkAEzknx8jw4oDAK1Hh2vur
 3s03twqYv7793qWJ7fafPl+ut0lvVmo1YPgrx3zOoOFWRt/0e78kL5m05J+Yc/s9/yHTrvka6ks
 WqacxAwBrX0jq
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

Based on the dtbs support in builddeb. Both Fedora and openSUSE kernel
rpm install their dtbs in "/boot/dtb-${KERNELRELEASE}". There seems no
other popular rpm based distributions which would benefit from dtbs
support and are not derived from those two.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 scripts/package/mkspec | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 8049f0e2c110..a170b0c0a93f 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -28,6 +28,14 @@ else
 	M=DEL
 fi
 
+# Only some architectures with OF support have the dtbs_install target
+if grep -q CONFIG_OF_EARLY_FLATTREE=y include/config/auto.conf && \
+   [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
+	D=
+else
+	D=DEL
+fi
+
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
 EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
@@ -38,6 +46,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 # Labels:
 #  $S: this line is enabled only when building source package
 #  $M: this line is enabled only when CONFIG_MODULES is enabled
+#  $D: this line is enabled only when CONFIG_OF_EARLY_FLATTREE is enabled and
+#      the arch has a dts directory
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Name: kernel
 	Summary: The Linux Kernel
@@ -103,6 +113,7 @@ $S
 	%endif
 $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+$D	$MAKE %{?_smp_mflags} INSTALL_DTBS_PATH=%{buildroot}/boot/dtb-${KERNELRELEASE} dtbs_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230712-kbuild_rpm_dtbs-d055a3780bbe

Best regards,
-- 
Janne Grunau <j@jannau.net>

