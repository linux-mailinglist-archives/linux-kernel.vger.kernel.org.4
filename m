Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363964B422
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiLMLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiLMLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:25:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4891DF23;
        Tue, 13 Dec 2022 03:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801B761494;
        Tue, 13 Dec 2022 11:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FB7C433D2;
        Tue, 13 Dec 2022 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670930664;
        bh=PbXc6SRr9xN1QYaPN3TsPWd8S69cdNJktt9W6lBgvIY=;
        h=From:To:Cc:Subject:Date:From;
        b=O4vAwYQFtuU/Z3PsbUbWTMoSf34+Amqv+3SjM2viYX6wQid9ExPXTMbojXQI1C4Jd
         bAn36VkU0HQbQqmuJeiflFF36IvfPep8efBuziuf+FjxEsijVdXaKhoK1ctf28V49o
         VjX+K0DDUe8ANQ57EV5glPGoJm28XXFmJ4IdRtjxPCAh0q1IjBdtoxnNxPZhrBLeYq
         Lod5wcnNrLnSJkbzw1ZQFZFsdgf/2zdsdZG6eFEH2+JcOieqS//CRHJ1Q0xEcBrR0O
         lkX7d5f4/OolcYMeKkqzhgzFwddg9cu9uVC7jjavxTbyq9HLliKqYJNSW0YMbOSYTI
         IvmsHkIFpSonw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v4] kbuild: ensure Make >= 3.82 is used
Date:   Tue, 13 Dec 2022 20:24:20 +0900
Message-Id: <20221213112420.3320301-1-masahiroy@kernel.org>
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
$(.FEATURES) since the feature list always grows.

GNU Make 3.81 expands $(.FEATURES) to:
  target-specific order-only second-expansion else-if archives jobserver check-symlink

GNU Make 3.82 expands $(.FEATURES) to:
  target-specific order-only second-expansion else-if shortest-stem undefine archives jobserver check-symlink

To ensure Make >= 3.82, you can check either 'shortest-stem' or
'undefine'.

This way is not always possible. For example, Make 4.0 through 4.2 have
the same set of $(.FEATURES). At that point, we will need to come up
with a different approach.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v4:
  - Show the minumal required version in the error message
  - More commit description

Changes in v3:
  - Check the version in a different way

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 591485152a95..7f831e63b39b 100644
--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,10 @@ NAME = Hurr durr I'ma ninja sloth
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+ifeq ($(filter undefine,$(.FEATURES)),)
+$(error GNU Make >= 3.82 is required. Your Make version is $(MAKE_VERSION))
+endif
+
 $(if $(filter __%, $(MAKECMDGOALS)), \
 	$(error targets prefixed with '__' are only for internal use))
 
-- 
2.34.1

