Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A55627CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiKNLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiKNLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD523179
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81933B80E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3997EC433D6;
        Mon, 14 Nov 2022 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426301;
        bh=5FX1a1JgcDe4CO/FI8j/3+v36Volg7rloP622gTjs4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OA+g6g1OOecEy+y6VOPK3J54mGvMkQm2tYT6ZFbxX+0wGYJHWM01XYB/5x9ld9PVo
         ktQcoiU9YUeFjxsllBKPobxgacW1tr1IHrVPZsiXK8EjBpyZvTtFrjM5G5dCk4x8HZ
         nc88qy7GvW16gdXTeBP4dZuKahL4Kr5aCEgo/L/GJirF85Y7RtvE3uyW/YtCECZ8Lr
         01J3///gSOype8s079CsWY2X0rJMO1TSSGscywo63cbm0Jp6GtaC+Qd5PHI4hW1A9Q
         828gJx3mCuVbH1A/6dw/5GGVj3d6bol7osArPmK8EJ1BAdoJMqnpdJWjNVVer16h8v
         sFHNuPR0rd9Vw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>
Subject: [PATCH 26/46] x86/apic, lto: Mark apic_driver*() as __noreorder
Date:   Mon, 14 Nov 2022 12:43:24 +0100
Message-Id: <20221114114344.18650-27-jirislaby@kernel.org>
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

From: Jiri Slaby <jslaby@suse.cz>

The apic code assumes that the apic drivers are in a particular order in
memory. gcc LTO can violate this. So add __noreorder to apic_driver()
and apic_drivers() to avoid a boot BUG().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/include/asm/apic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321c8240..9c5c69482ab0 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -363,12 +363,12 @@ extern struct apic *apic;
  * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
-	static const struct apic *__apicdrivers_##sym __used		\
+	static const struct apic *__apicdrivers_##sym __used __noreorder \
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") = { &sym }
 
 #define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
+	static struct apic *__apicdrivers_##sym1##sym2[2] __used __noreorder \
 	__aligned(sizeof(struct apic *))				\
 	__section(".apicdrivers") = { &sym1, &sym2 }
 
-- 
2.38.1

