Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE16EE0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjDYLJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjDYLJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7213C02;
        Tue, 25 Apr 2023 04:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B231625BA;
        Tue, 25 Apr 2023 11:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4166C433D2;
        Tue, 25 Apr 2023 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682420946;
        bh=N4A+e7aLAiSuJq881XsSCZo2/DplqwGz+n84VQ38/kI=;
        h=From:To:Cc:Subject:Date:From;
        b=Sog/inqYhQTSG97VMlyPM5aKoUIjyAcaG9ZnvHtKbYeDu44/tEcNceC1WAMCoBK6S
         f+4A69b2XzPYfS2s4kVciAIDF3OJ3DOuw6VWkh1X1R8ZiULxEJGV1R4vQFyr7N05ZJ
         SKR6bItnzPNR+c4zXLJIjYdPXk9djpUN1WxRyXEcSK5FAjTl5MRRdT5bIoIb3DFFCF
         iiluVPYr1igFX/gaCPYLyVUli+zMAHwQOarpfQXrZ4DN8A3v0ZgbyE/3VI5/8Lk9B+
         L891ZgKUf6c0XQgQRdeHL039LN8T6T6aLZiTycmx47mM6ZjmfBsymU3yOQvMqsa9rL
         EyUthH2BStZXA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: deb-pkg: specify targets in debian/rules as .PHONY
Date:   Tue, 25 Apr 2023 20:08:59 +0900
Message-Id: <20230425110859.1757001-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file with the same name exists, the target is not run.

For example, the following command fails.

  $ make O=build-arch bindeb-pkg
    [ snip ]
  sed: can't read modules.order: No such file or directory
  make[6]: *** [../Makefile:1577: __modinst_pre] Error 2
  make[5]: *** [../scripts/Makefile.package:150: intdeb-pkg] Error 2
  make[4]: *** [../Makefile:1657: intdeb-pkg] Error 2
  make[3]: *** [debian/rules:14: binary-arch] Error 2
  dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
  make[2]: *** [../scripts/Makefile.package:139: bindeb-pkg] Error 2

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkdebian | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index a4c2c2276223..b6cb95473548 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -269,6 +269,8 @@ cat <<EOF > debian/rules
 srctree ?= .
 KERNELRELEASE = ${KERNELRELEASE}
 
+.PHONY: clean build build-arch build-indep binary binary-arch binary-indep
+
 build-indep:
 build-arch:
 	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
-- 
2.37.2

