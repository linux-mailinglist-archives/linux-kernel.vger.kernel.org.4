Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1842C704000
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbjEOVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjEOVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:43:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0210EC;
        Mon, 15 May 2023 14:43:19 -0700 (PDT)
Date:   Mon, 15 May 2023 21:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684186998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d+8BDmnkH8cVYts5uM333ozeqBPiCdFJuGIcor3JssI=;
        b=kwBfXuJ/9xWnUSImOI5lE8EtpjC8kd7fr5F6BbaDAmEZu4rJbCxOCwfhhURZaYQzoKoxk3
        NI/Ja7VOz3d5veXx+br30A5pZX3El2/T9BPkWFDYyGJ/d+dy00Ly1QAj1u2q9vPw3bF/Xt
        x/2fWuCbho7I4YXMlEW3vB48OoBeO1bk82weKHcrx6beQpMDwa9tHpRrTsYKj/boJklaIh
        MUNALNvMKzWWMLyQ49GYzxKSMwn7WScHa4BRA48qP7EGx8vaqkt6FGmtay+pajN8wBe1aL
        b/Yraucy7EUi8arUGwB+0iPQAhKJ4bucePcJt4c8AqTRrB2/OO229M5C+R4jNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684186998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d+8BDmnkH8cVYts5uM333ozeqBPiCdFJuGIcor3JssI=;
        b=c9JPzNS2+efNU3jG9lICsgLaY0aUXErh+x4XEGr6R/V/Uwgrc70NzsDlsERxDCSi9JK8bs
        goHlAAezD+Z4xmCg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/Kconfig: Make X86_FEATURE_NAMES non-configurable in prompt
Cc:     Borislav Petkov <bp@alien8.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168418699788.404.11674060014687395413.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     424e23fd6c30ec204c1c77919066ae777577a4f9
Gitweb:        https://git.kernel.org/tip/424e23fd6c30ec204c1c77919066ae777577a4f9
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 10 May 2023 08:57:12 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 May 2023 19:56:19 +02:00

x86/Kconfig: Make X86_FEATURE_NAMES non-configurable in prompt

While discussing to change the visibility of X86_FEATURE_NAMES (see Link)
in order to remove CONFIG_EMBEDDED, Boris suggested to simply make the
X86_FEATURE_NAMES functionality unconditional.

As a first step, make X86_FEATURE_NAMES disappear from Kconfig. So, as
X86_FEATURE_NAMES defaults to yes, to disable it, one now needs to
modify the .config file before compiling the kernel.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20230509084007.24373-1-lukas.bulwahn@gmail.com/
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab12..a7db116 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -442,7 +442,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config X86_FEATURE_NAMES
-	bool "Processor feature human-readable names" if EMBEDDED
+	bool
 	default y
 	help
 	  This option compiles in a table of x86 feature bits and corresponding
