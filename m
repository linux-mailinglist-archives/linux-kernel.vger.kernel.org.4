Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A344C732E67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345116AbjFPKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbjFPKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533A3C23;
        Fri, 16 Jun 2023 03:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD9B635D4;
        Fri, 16 Jun 2023 10:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230DEC433C9;
        Fri, 16 Jun 2023 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911258;
        bh=/2eu/IzHEjIEziEOgpfNknSs8ILwYCCzdmfnALL8w/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeE4lABO3LhB1axvrQrpi/kO/fLDnn1yXcR4b2o8GWkULyBgSq3uvYQmQ0c1hkLEg
         D9ALZ1RB81v1XWPJvNz7V6WZ2yZqmY817ky1o4ozXT7AoEWHNmrM/ucFxxMAdNdzNh
         dM2va06obvqGI4Yj5SYHNwlTV21w42hoA4W/hBPSONVCTlffGK1Vqtz6XVeZ7dTsQL
         vTECMlGuvqCIxTOg8uy0+LKWG9qMXWvwbe9jLzBp6wOL68Ta15kYsoOBBWc5FH8DIf
         Sroj1fkOUjdxA4JSLuMYeuF+ugHcVOSMuFr4K+d9EXFo7uDWNBGQ2jE0d2Tj10EvEL
         S35nVmnOA41tw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, masahiroy@kernel.org, svens@linux.ibm.com,
        nathan@kernel.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 08/16] s390/purgatory: disable branch profiling
Date:   Fri, 16 Jun 2023 06:27:11 -0400
Message-Id: <20230616102721.673775-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102721.673775-1-sashal@kernel.org>
References: <20230616102721.673775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 03c5c83b70dca3729a3eb488e668e5044bd9a5ea ]

Avoid linker error for randomly generated config file that
has CONFIG_BRANCH_PROFILE_NONE enabled and make it similar
to riscv, x86 and also to commit 4bf3ec384edf ("s390: disable
branch profiling for vdso").

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 360ada80d20c3..d22ec8acb13c5 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -26,6 +26,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-- 
2.39.2

