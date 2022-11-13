Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2033627389
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 00:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiKMXi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 18:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMXiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 18:38:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB456DE9D;
        Sun, 13 Nov 2022 15:38:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g62so9529037pfb.10;
        Sun, 13 Nov 2022 15:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vnx3d3UtkT0/AOZKRIdRL+527l3FrSpUvOUpZvyUTU=;
        b=blKoO8j4ehhHyUaUop6u8o1NYssyGklb1fBQii6ccnOuJB1GCx33PlNv2pQ6LgZI8x
         yISfq6eaSXYTJlHY+oiMASEfAsGDtzNU9YoQHYLgcLJwkigMAo8d44e88qqINeTXFUf6
         EY17RqbzjzSnBB/1zMS6KU+5cvHFS/NuAByEiTBwPcITmnKq+XZJJfhNmzxBj2upsOoB
         mBBMqWpXDdFp5CF4Yg7sQCbBlpOG6ahyaKbKeSN3hasbb5HQo4Y7oq3+8Elag3oVhR8p
         15lFmO9KRVte7WIyXLFJFlmbJHsvAxSwdpaIyAr46BEoPfbnqHAsXO2+oRB77vTpL4Hg
         xN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vnx3d3UtkT0/AOZKRIdRL+527l3FrSpUvOUpZvyUTU=;
        b=2aHUltpcLhmBpofqMdltSn/iUIY8Vkd6O6htfuIcFpwIors7J7BUV+t9D83W6J0dJG
         frulpG6WCyfSbRHvNSlMuVnNpnvUDBmvucGC0jysDCXzlCKZWxWSkr9pnn29581cupcd
         4rMh1D9i6TcnSca75U0Ux//vJzyzr1CNSbbgdfz4fTrbgqYVN6BZCLPHxg3FgKXlvode
         5XMTnu8PIkzqer9pTDpZNi4U7vIN/ftqf5BEKnfbZdUkAFzezFZECwBBcbNOCvTOyp6i
         rxtyXuCI06I5D3HYh4PgVoCER5a4fy52Z+qGYxqlCBlfVguJyIdQUW1BEecfbslubs5W
         BxNA==
X-Gm-Message-State: ANoB5pnYVGYGRF5x07yXWsizPaVD/TSxnITcY1ymxq8NSk4MUFNKSDdP
        lz8kW/dDhT1Z11TkO6CbXQU3RKyJw082uw==
X-Google-Smtp-Source: AA0mqf5xzbKMvhosYmjeFdvvr2ztvRpv/6HUe8EXpW13Kz5dAstFCQ6bhMPlCpEcQuOEVXLI2Cfr7Q==
X-Received: by 2002:a63:165f:0:b0:439:ac9b:37a6 with SMTP id 31-20020a63165f000000b00439ac9b37a6mr10000824pgw.591.1668382702061;
        Sun, 13 Nov 2022 15:38:22 -0800 (PST)
Received: from nicks-air.lan ([2601:647:5700:fdc:a9a7:4597:ad5b:e304])
        by smtp.googlemail.com with ESMTPSA id ip4-20020a17090b314400b00212cf2fe8c3sm8890336pjb.1.2022.11.13.15.38.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Nov 2022 15:38:21 -0800 (PST)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] scripts: subarch.include: fix SUBARCH on MacOS hosts
Date:   Sun, 13 Nov 2022 15:38:09 -0800
Message-Id: <20221113233812.36784-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the Linux kernel on an aarch64 MacOS based host, if we don't
specify a value for ARCH when invoking make, we default to arm and thus
multi_v7_defconfig rather than the expected arm64 and arm64's defconfig.

This is because subarch.include invokes `uname -m` which on MacOS hosts
evaluates to `arm64` but on Linux hosts evaluates to `aarch64`,

This allows us to build ARCH=arm64 natively on MacOS (as in ARCH need
not be specified on an aarch64-based system).

Utilize a negative lookahead regular expression to avoid matching arm64.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
This is only part 1 of
https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb340355f471c1dfe95a
I'm still working on the rest...

 scripts/subarch.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/subarch.include b/scripts/subarch.include
index 4bd327d0ae42..aa130286b627 100644
--- a/scripts/subarch.include
+++ b/scripts/subarch.include
@@ -6,7 +6,7 @@
 
 SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/arm\(?:\(?!64\).*\)/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-- 
2.37.0 (Apple Git-136)

