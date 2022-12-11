Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8064922C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 04:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLKDEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 22:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKDEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 22:04:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D8FD37;
        Sat, 10 Dec 2022 19:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBC84B80937;
        Sun, 11 Dec 2022 03:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B32C433EF;
        Sun, 11 Dec 2022 03:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670727839;
        bh=KRNswHAYO1IcuR9kG0iBZlhOuhjVaWb06YuN0ImwPlE=;
        h=From:To:Cc:Subject:Date:From;
        b=cIJtLunhw2FQPzxttbW8f+vSGCrdQiBhGtcgwyNa6vH/80dogQvDn3eDg0d4p45nV
         /GDnjqqHgwbrFLkdC2pZofiaByQrBWWT7SOjUf6PmB3Kbsib5d9vMIva32cTVTwI38
         KWEE2cWUhKPQCCwJROjnYlUej+mlGyK12hyq+VpqQGfwnjIBxVCMZPQB0dQV8PBKm8
         F4cbP4IujgmRZ39TRQr44r70fogKnMqC2dTNnGAF9pb0ns6kWEAc8sh4pN9XNV0MK0
         7H23efSSwnevuGV05ag2WMTwLaPL2aDUoBFVEaPH695IyBAtlLIRe9y/b3xzcXPX2k
         BEJihBtEgnZrA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: ensure Make >= 3.82 is used
Date:   Sun, 11 Dec 2022 12:03:52 +0900
Message-Id: <20221211030352.2622425-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Documentation/process/changes.rst notes the minimal GNU Make version,
but it is not checked anywhere.

We could check $(MAKE_VERSION), but another simple way is to check
$(.FEATURES) since the feature list always grows although this way
is not always possible. For example Make 4.0 through 4.2 have the
same set of $(.FEATURES).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Check the version in a different way

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 2dda1e9a717a..66dfc5751470 100644
--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,11 @@ NAME = Hurr durr I'ma ninja sloth
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+# Ensure Make >= 3.82
+ifeq ($(filter undefine,$(.FEATURES)),)
+$(error Make $(MAKE_VERSION) is too old)
+endif
+
 $(if $(filter __%, $(MAKECMDGOALS)), \
 	$(error targets prefixed with '__' are only for internal use))
 
-- 
2.34.1

