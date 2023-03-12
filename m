Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027216B6AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCLTdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCLTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:32:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01456392A3;
        Sun, 12 Mar 2023 12:32:53 -0700 (PDT)
Date:   Sun, 12 Mar 2023 19:32:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678649571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKIRktVYI9ydybMvRx3yc+RM+KVutJMeX+5vggZ8T4s=;
        b=wZ91N7yE8eLvD70UHmSspI///tlJIVrXZXYl+Uc3wVtOgKBo8djFkjCOl+zM9ViUlbyhfu
        bTeqyzRLtpS1Z1TSYnJd5oOM+MZLBge57LvFxmRU2BJdTTqjQZFbyoKNk0p7ygAHYVvAgG
        YyqNhQ+IQk+0XgBpqjNSXndHz1iRgcilEqlA2G+IBOpCCF/HyO8d2O/6PjKgCAmnMoyk9+
        TZ6yNzaoKEQLT1yibJk4xDoZPnNBe52TBW19Vy6yGZvOAcyaAZ/x6nJCCa3wfnogJnz2+K
        nYacaXRN79hWeH2Bd53FbVUwZKMpITQTZtAXRCsN7hkIANVGnKaJAxZ3rili0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678649571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKIRktVYI9ydybMvRx3yc+RM+KVutJMeX+5vggZ8T4s=;
        b=Mk6wuFuwiz3aYg7LrVD3puyktCrXlVJeGbKKnXNlBiF7/AT6s6CBKNzTl0E52Ly3/5nBA+
        zqhtLOAx+L+3uMBQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Get rid of __find_equiv_id()
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227160352.7260-1-bp@alien8.de>
References: <20230227160352.7260-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167864957031.5837.1116812221182540208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9652df50cd444d0e6c26906ec9dfa894f2d4d6bc
Gitweb:        https://git.kernel.org/tip/9652df50cd444d0e6c26906ec9dfa894f2d4d6bc
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 27 Feb 2023 17:03:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 12 Mar 2023 20:14:38 +01:00

x86/microcode/AMD: Get rid of __find_equiv_id()

Merge it into its only call site.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230227160352.7260-1-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9eb457b..394a9e1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -596,11 +596,6 @@ void reload_ucode_amd(unsigned int cpu)
 		}
 	}
 }
-static u16 __find_equiv_id(unsigned int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
-}
 
 /*
  * a small, trivial cache of per-family ucode patches
@@ -651,9 +646,11 @@ static void free_cache(void)
 
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u16 equiv_id;
 
-	equiv_id = __find_equiv_id(cpu);
+
+	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 	if (!equiv_id)
 		return NULL;
 
