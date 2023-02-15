Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B045D6983C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBOSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBOSrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:47:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7FA3D916
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A47FB82357
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B679C4339B;
        Wed, 15 Feb 2023 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676486486;
        bh=Bn4PnsdfMk3VpRZTuBATRwN4ucU9A9gaRgDX010A7pA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K8DssxvWbdq3XXo1YlSzB5+4GoV8/dvTaDPuEvZyLvicAEOonCuS2M5DEFoCbrvhg
         9mX1bx0KyAhhg/9xZjzUlCLfgkI4AtVp12CiaitfkmBdGayB6shkHIcfQYfCaILPFl
         ZWwZx/cZ24fUFYqQNUm4vn0vD7tBojGDzilj0Ph30bbwU7lwBvDE/KMd10N660T9wb
         y0CoDUJoN5/UGiiVBnXt3o0rPnzt9mJ5v0OQ/zG481K9slBRUjyMcnYQ/P8+4OaEUm
         GhAGo6913DGwcPIbWcvHbaSpd/5Sd8TnWJ3pfordVGsGBdVCNuG6XT5/pW3IxuytL3
         5jbCLGsXGIUPA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 15 Feb 2023 11:41:15 -0700
Subject: [PATCH 1/3] powerpc/boot: Only use '-mabi=elfv2' with
 CONFIG_PPC64_BOOT_WRAPPER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230118-ppc64-elfv2-llvm-v1-1-b9e2ec9da11d@kernel.org>
References: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
In-Reply-To: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        erhard_f@mailbox.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Bn4PnsdfMk3VpRZTuBATRwN4ucU9A9gaRgDX010A7pA=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMlv1UNDVS+uVxZctb7mrC67yZbDwu3i3yIzTRpudAjIi
 LeJeV/tKGVhEONgkBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABP5spLhf+Bf/oNmFpFBUb6v
 WfMc5rDmiO8KlFiyN/ebnkn7A8F7Gxl+s/3U+PCZu/WaT3mP2GK3kIayadsSHt+fKtjALvwuec1
 TdgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PPC64_ELF_ABI_V2 is enabled with clang through
CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2, building the powerpc boot wrapper
in 32-bit mode (i.e. with CONFIG_PPC64_BOOT_WRAPPER=n) fails with:

    error: unknown target ABI 'elfv2'

The ABI cannot be changed with '-m32'; GCC silently accepts it but clang
errors out. Only provide '-mabi=elfv2' when CONFIG_PPC64_BOOT_WRAPPER is
enabled, which is the only way '-mabi=elfv2' will be useful.

Tested-by: "Erhard F." <erhard_f@mailbox.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/boot/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d32d95aea5d6..0d4a8e8bdcab 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,6 +44,9 @@ BOOTCFLAGS	+= -m64 -mcpu=powerpc64le
 else
 BOOTCFLAGS	+= -m64 -mcpu=powerpc64
 endif
+ifdef CONFIG_PPC64_ELF_ABI_V2
+BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
+endif
 else
 BOOTCFLAGS	+= -m32 -mcpu=powerpc
 endif
@@ -55,9 +58,6 @@ BOOTCFLAGS	+= -mbig-endian
 else
 BOOTCFLAGS	+= -mlittle-endian
 endif
-ifdef CONFIG_PPC64_ELF_ABI_V2
-BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
-endif
 
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -nostdinc
 

-- 
2.39.2

