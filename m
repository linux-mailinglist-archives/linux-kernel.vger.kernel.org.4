Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8B627CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiKNLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiKNLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150623E93
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32B761087
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2217C433C1;
        Mon, 14 Nov 2022 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426313;
        bh=NQjJxsyILnecrraVLrD0UKjVsHwWFfzkE/ontSglPSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr+JYDfS+0aus5xijYRaMBvF+FXRDnpM+dWoHIiFfmScS3GOY36UxHNYZeLj3b3zS
         XNaakPmcEiSPxT80ueG3+y7woeiEEbVWMtAtTN/zR17K1PhT7njmfVrr/KeBIIxFjR
         do1cwcwwThBI9Kjq3eb5p+Z1Ptv/8WEvXBLuOoM6QX7TWUpM4h9A+ifuJLwtfBCplk
         pj43yCKwVF67uQq0okCBxNvKIzb6bLVKZsP5z724LHOZlpC4vzQI4neD1PsZxr67PD
         j4owce6boYT9eo0JCWwP43SA5/F/30l1iGQMf4D9/TTVm4EyYqcC3+QNuOJzOmBlbr
         nrdMoRJB/JTGg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 31/46] x86/purgatory, lto: Disable gcc LTO for purgatory
Date:   Mon, 14 Nov 2022 12:43:29 +0100
Message-Id: <20221114114344.18650-32-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

There are various issues with gcc LTO in the purgatory code, so disable
LTO here for now.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/purgatory/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 17f09dc26381..c00dc09d6fe4 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -60,6 +60,8 @@ ifdef CONFIG_CFI_CLANG
 PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
 endif
 
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_LTO)
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.38.1

