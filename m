Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD566C2372
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCTVPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:15:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC3726A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:15:02 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 991E82C02A8;
        Tue, 21 Mar 2023 10:15:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1679346900;
        bh=5fbUoPoaf6SIruAr40HkxELYXpDyUBwBU0mIygv7a/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gyE7AosaQVDk1Xjj+wC/8SLZPl+EIj0XpVBPHFZh03efZqJKTr1b62HkYZ/VID36S
         EFTlMgcfF43pgdOijOv4uH9+Lc96ThWryhrZZyRPBiDGtWnbJExIo0lrkmPo/72JNu
         xuxDa8Po/8JOPXYbJfw4eHT73s+vl5xcgqLM0suJjVodswZOYyyuhaEhzxsA25vWZY
         BPokAre/U3K3hbGOjzpzS7Q3WLCbI2cGUZPh7xhlDbcL5tij3jqbmk/brwZmMgae4T
         I3OSjyMw86521pfN9kTnqt2Daj5hEtv+UY1hpSMVlV7kVLYflwBpw71VPFoMOAQgGl
         rjj6ayIBqm13g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6418ccd40001>; Tue, 21 Mar 2023 10:15:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 79B5513ED0C;
        Tue, 21 Mar 2023 10:15:00 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 75BF0282452; Tue, 21 Mar 2023 10:15:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] arm64: Support CMDLINE_EXTEND
Date:   Tue, 21 Mar 2023 10:14:51 +1300
Message-Id: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=F6spiZpN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k__wU0fu6RkA:10 a=Q_Ijp8T_OeaM2KZaP48A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support extending the bootloader provided command line for arm64
targets. This support is already present via generic DT/EFI code the
only thing required is for the architecture to make it selectable.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..3c837b085f21 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2228,6 +2228,12 @@ config CMDLINE_FROM_BOOTLOADER
 	  the boot loader doesn't provide any, the default kernel command
 	  string provided in CMDLINE will be used.
=20
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
--=20
2.40.0

