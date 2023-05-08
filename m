Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC146FB099
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjEHMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjEHMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:49:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D63315A;
        Mon,  8 May 2023 05:49:01 -0700 (PDT)
Date:   Mon, 08 May 2023 12:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683550139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22E6zwgdVOnD151+cuXBbZA+cn6V3HC9zP6LwmHi3uo=;
        b=fvfrVc+nQH/os+XZpwaXfkV1HUt5aAN/5W7ViNFDsFc7ySyquM66sBJAiZSUiP8Ixz0UlZ
        4M+ifh/flUsJ+1fcvAfJjxDTROuE4IvJf0QWGPXoK/Bimai5wMHC5/UC1JsEVQiDAvtITg
        e3VOmMLyolkkUNNqnRw4hHvCuGEZEP//fu5V6agvqO9lbJ1rGpHXLTUFMoWaFRhPxC0EJ2
        EI2psY3lQ5+b0og09PrlSaE0aZ7mqnl+CVrwrx8xcRT+7Vll1aT7bz5kANmf4oHPci4fAS
        x8iKYQPRJAsp+XBAd4bvJOlwJEouMezRvZ5kG8oto5E2RqUeRFWkP1/GKR7Ujw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683550139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22E6zwgdVOnD151+cuXBbZA+cn6V3HC9zP6LwmHi3uo=;
        b=22ANs4JstIo5ddmg29tp51oy420Jkk7h9N/JLEP6o1TAcmuD6zpC4fTlSGl+8hThnwr46p
        UMKccKKneMd+UiDg==
From:   "tip-bot2 for Nathan Fontenot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Remove unneeded pointer arithmetic
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502174232.73880-1-nathan.fontenot@amd.com>
References: <20230502174232.73880-1-nathan.fontenot@amd.com>
MIME-Version: 1.0
Message-ID: <168355013826.404.7907670056370146878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     e281d5cad1f3924edf1042441b98c25204ae0def
Gitweb:        https://git.kernel.org/tip/e281d5cad1f3924edf1042441b98c25204ae0def
Author:        Nathan Fontenot <nathan.fontenot@amd.com>
AuthorDate:    Tue, 02 May 2023 12:42:32 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 14:38:38 +02:00

x86/microcode/amd: Remove unneeded pointer arithmetic

Remove unneeded pointer increment arithmetic, the pointer is
set at the beginning of the loop.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230502174232.73880-1-nathan.fontenot@amd.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index dd33ee8..f14f4ea 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -78,8 +78,6 @@ static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 
 		if (sig == e->installed_cpu)
 			return e->equiv_cpu;
-
-		e++;
 	}
 	return 0;
 }
