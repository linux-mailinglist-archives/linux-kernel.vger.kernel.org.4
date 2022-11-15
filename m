Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF362ADA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiKOWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKOWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:05:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26820BE7;
        Tue, 15 Nov 2022 14:05:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACE2DB81B61;
        Tue, 15 Nov 2022 22:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0FC433C1;
        Tue, 15 Nov 2022 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668549904;
        bh=A8hKVJDELpSDaM76TOxGC8jzHZnsHhPxgoYTVJKtqvw=;
        h=From:To:Cc:Subject:Date:From;
        b=o45sbarpGs0nSr/r8wCDwhN/6lr470p23hgVSasjyfDWsYnqf1ebnWOnep5EK0gSf
         dhMfsJs4K52ME3k0yXIH/HS8jyt6cmyFe1gIMaxL/tdXaTp0FU8QyUltCfsztLr8LS
         p4naDPHQY8WKXPK3BRoFyBZgbqp3S/0klQAchJ2ebVRtB/DvIjTHkoSwswlDHeKIjm
         K4jm8W2UsqTI9Xx8pu6FIxtVdD+hUsWibPCQHEado0nnJnA9rVjbgpz1pO8fiDSYnN
         kYzYUqcRhtPMsRWj0eIWUDWBAxww0RcXw30L2E4NntgoV4nWat/2kgFdHkkAX5vVta
         oABb4WlhbR0pw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ov43B-006Jl2-SZ;
        Tue, 15 Nov 2022 22:05:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: Restore .version auto-increment behaviour for Debian packages
Date:   Tue, 15 Nov 2022 22:04:53 +0000
Message-Id: <20221115220453.3463096-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net, ndesaulniers@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2df8220cc511 ("kbuild: build init/built-in.a just once"),
generating Debian packages using 'make bindeb-pkg' results in
packages that are stuck to the same .version, leading to unexpected
behaviours (multiple packages with the same version).

That's because the mkdebian script samples the build version
before building the kernel, and forces the use of that version
number for the actual build.

Restore the previous behaviour by calling init/build-version
instead of reading the .version file. This is likely to result
in too many .version bumps, but this is what was happening before
(although the bump was affecting builds made after the current one).

Eventually, this script should be turned into something that
is a bit less counter-intuitive (building the kernel first
and only then generating the packaging artefacts).

Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
---

Notes:
    v2: Drop the RPM version which was wrong, and make the path
        relative to $srctree.

 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 60a2a63a5e90..a3ac5a716e9f 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -90,7 +90,7 @@ if [ -n "$KDEB_PKGVERSION" ]; then
 	packageversion=$KDEB_PKGVERSION
 	revision=${packageversion##*-}
 else
-	revision=$(cat .version 2>/dev/null||echo 1)
+	revision=$($srctree/init/build-version)
 	packageversion=$version-$revision
 fi
 sourcename=$KDEB_SOURCENAME
-- 
2.34.1

