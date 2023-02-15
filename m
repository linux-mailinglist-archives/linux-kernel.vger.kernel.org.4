Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E8697380
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBOBWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBOBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B223250E;
        Tue, 14 Feb 2023 17:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2379DB81F8C;
        Wed, 15 Feb 2023 01:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB81C433EF;
        Wed, 15 Feb 2023 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424102;
        bh=nyoDlaWuMe+iAg2qQHK7dj0Pe2Isu5Lqca6xJRJDD9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9fkk6E7z0wPKaR6y//S2W/6zS/FeQ4fIEcwplSHQMo8U7/VIXTc4XCeGaHC3YODt
         waoknC0wxfdDUnXW9FZmPWQMuB4BCb4NwkxBXRg1fiobnhpIhoxWCeEsagz1Jh+d5x
         ySyqpGMAHpyPaGaN9KHAlXSeXfz8cX+h+rXjwHjPps2y4cSfnRAkAXWZ8q0oqnIzh+
         BpwIGJF9dn22ABNqG40VfGKO45Uv2im3Sij2Ws4ZusfrbZEb+mk0Ba8my/FezWRM7k
         NptGYmXD8PByRo3Q79fKJPu+rSIix4RajOJoVsIiyX0qauC/FnzSx5GSA3Dcko79bM
         nTVz4xzhteKKw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 06/12] kbuild: deb-pkg: make .orig tarball a hard link if possible
Date:   Wed, 15 Feb 2023 10:20:28 +0900
Message-Id: <20230215012034.403356-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
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

If '..' belongs to the same filesystem, create a hard link instead of
a copy. In most cases, you can save disk space.

I do not want to use 'mv' because keeping linux.tar.gz is useful to
avoid unneeded rebuilding of the tarball.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - New patch

 scripts/Makefile.package | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index c207f4ec47ac..80a96eb61426 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -96,7 +96,11 @@ debian-orig: private source = $(shell dpkg-parsechangelog -S Source)
 debian-orig: private version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
 debian-orig: private orig-name = $(source)_$(version).orig.tar.gz
 debian-orig: linux.tar.gz debian
-	$(Q)cp $< ../$(orig-name)
+	$(Q)if [ "$(df  --output=target .. 2>/dev/null)" = "$(df --output=target $< 2>/dev/null)" ]; then \
+		ln -f $< ../$(orig-name); \
+	else \
+		cp $< ../$(orig-name); \
+	fi
 
 PHONY += deb-pkg
 deb-pkg: debian-orig
-- 
2.34.1

