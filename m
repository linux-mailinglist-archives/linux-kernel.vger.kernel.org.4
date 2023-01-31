Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE206831F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjAaP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjAaP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:57:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94124ED5;
        Tue, 31 Jan 2023 07:57:56 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675180674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZzJ+GQ2T/0Ua8BfIYWMuAMISueCW/XtJ+YiNk66U1I=;
        b=pzbnRaPLaQ/3gI7t6UbZa/Oa5PmR4y47cA+G2DKLBBCcUfEM/1uHI3tAcsTXD9NMw1CEBK
        qqoOhiPwvWe4w6NY9A/s+kE1k3Eflef7H6ginQ+Om6K8s8pBnyPhwgZ+my6HLznBL8wfEQ
        FYxn06Xxk7KrQwGcC7Mwn6N1Sz6ee9QJmk3Rs7a2HC0OouUzCYDRGywy28WzI9BiQ/4xqb
        +KHVpSsL9M1nZO9Jxy0BntK8BBIAfMhkEkQT1Lp8l3ekFOl3j1IrvnaeqJUJlMLiGWsO4l
        8UFG2ePQtQR/c/AhQSZm41uLc1G8AXrl51ntd1jLTvTMgOME3LHLJToHvvQP8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675180674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZzJ+GQ2T/0Ua8BfIYWMuAMISueCW/XtJ+YiNk66U1I=;
        b=h7RpaJHa6/0UI7mJcEDt5gunf0evL5A/bBsDZrDv12iro0vvgltSIUVG8vDBeIeyOwBfPB
        gA6Atrza6/OTsVAQ==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Allow only "1" as a late reload
 trigger value
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130213955.6046-3-ashok.raj@intel.com>
References: <20230130213955.6046-3-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167518067379.4906.5578847349116389476.tip-bot2@tip-bot2>
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

Commit-ID:     25d0dc4b957cc8674f8554e85f18a00467e876d7
Gitweb:        https://git.kernel.org/tip/25d0dc4b957cc8674f8554e85f18a00467e876d7
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 30 Jan 2023 13:39:48 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Jan 2023 16:47:03 +01:00

x86/microcode: Allow only "1" as a late reload trigger value

Microcode gets reloaded late only if "1" is written to the reload file.
However, the code silently treats any other unsigned integer as a
successful write even though no actions are performed to load microcode.

Make the loader more strict to accept only "1" as a trigger value and
return an error otherwise.

  [ bp: Massage commit message. ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230130213955.6046-3-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 61d57d9..fdd1e7e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -475,11 +475,8 @@ static ssize_t reload_store(struct device *dev,
 	ssize_t ret = 0;
 
 	ret = kstrtoul(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	if (val != 1)
-		return size;
+	if (ret || val != 1)
+		return -EINVAL;
 
 	cpus_read_lock();
 
