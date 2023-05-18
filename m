Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51C3708B43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjERWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjERWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDAAE5E;
        Thu, 18 May 2023 15:03:14 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FPwDkKAMXUKs/+pkRHShHp8gERHgCWToqTFG/FEqrbw=;
        b=UU4GMyzuYgmyqp0pLlyUlMnPFfQLv6dS5UbxFqp9qLDaxjnh8eKLCMJrZ97o8ZjD9niSh2
        BKqRUQbhKZIX4ff9Y6HH5OCVjjbJ/um+HfIOBAK4HZ+mYm7z+9ogJjpqS/3GOICwLJagC7
        +qfcjdA4cXBlqd07CgweSgBHyLUb9dUJG+re1BLbNDp0gc6QglABgH6jMkIm1+HbYX9ubJ
        /y5AmWOue8ESDIqsr+Q3dRQ/0Sxrad+K5OtFZp5lvj5q5FgXo287dfRsjBps0LVIyJ3zWC
        B2sD0bX1Mu301jV85CAkh+fpgdO068IRUaRQMkW/95fgxLZBOwP51OV0WTHnXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FPwDkKAMXUKs/+pkRHShHp8gERHgCWToqTFG/FEqrbw=;
        b=XrNio2cDk6lHxuqhiiHgiM+ZXtjB8Kvtuf3LXbiFkD9dwdQhQHFIKB6Tdv0is+ghhAhcoe
        upfdBLF3JxEx0YDQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mce: Add copy_mc_fragile_handle_tail() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739294.404.2460168423574239895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e9c2a283e7d9d4e207b5ab4aa1723d62ee2ecbee
Gitweb:        https://git.kernel.org/tip/e9c2a283e7d9d4e207b5ab4aa1723d62ee2=
ecbee
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:44 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/mce: Add copy_mc_fragile_handle_tail() prototype

copy_mc_fragile_handle_tail() is only called from assembler,
but 'make W=3D1' complains about a missing prototype:

arch/x86/lib/copy_mc.c:26:1: warning: no previous prototype for =E2=80=98copy=
_mc_fragile_handle_tail=E2=80=99 [-Wmissing-prototypes]
   26 | copy_mc_fragile_handle_tail(char *to, char *from, unsigned len)

Add the prototype to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-16-arnd%40kernel.org
---
 arch/x86/include/asm/mce.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9646ed6..180b1cb 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -350,4 +350,7 @@ static inline void mce_amd_feature_init(struct cpuinfo_x8=
6 *c)		{ }
 #endif
=20
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mc=
e_amd_feature_init(c); }
+
+unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len=
);
+
 #endif /* _ASM_X86_MCE_H */
