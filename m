Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9004E604520
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiJSMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiJSMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:20:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B223337F;
        Wed, 19 Oct 2022 04:55:50 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FXHAMzW4a9XVTHsL5D9BFFU/m0xbSktQUsev1KdCys=;
        b=YRdBZQReVke7coXiydWWMGTsvQWMPW26B5cSGko04E5bBkSL71xo/YUXMpULlcTh9IHC9I
        NYnZmF/E2thWCGLzM8vLx3Oe76+8cQL5yfNYp1oKVmxqGRTldsYIPSWK90HH333+SJZ+eb
        88mxWoUT0lLrj782gdkPjk/Jw/PGek/GlDZen4QaQbv1+PKSucl/rkgCU9Ejg1g0wKK7jz
        C65vu/BfCRsVPQJmAn1P22zOzvNiU+ErQJHSSTE0fiTixg/Cs9H/5rT4tpM1mUpH9UqM11
        z9EDSmMeRP32F80Jum/S3oqaS1Qk0N2d0l6kbnLDgx9ts0nYIyJL11nXb+y86w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FXHAMzW4a9XVTHsL5D9BFFU/m0xbSktQUsev1KdCys=;
        b=IpNs6+DiX8w1TM1/N6OfwMmMUx1bS09+EZVufo/xgp31HoayFwBNhPbGsJRwRrXJFECl4n
        VSIfW5kG4aSZ2ZDA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] signal/compat: Remove compat_sigset_t override
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-4-brgerst@gmail.com>
References: <20220606203802.158958-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974689.401.1612801669577621953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     653714220f88717f239d811222c2dd0e64b181ba
Gitweb:        https://git.kernel.org/tip/653714220f88717f239d811222c2dd0e64b181ba
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:37:57 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

signal/compat: Remove compat_sigset_t override

x86 no longer uses compat_sigset_t when CONFIG_COMPAT isn't enabled, so
remove the override define.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-4-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/linux/compat.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 5943578..44b1736 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -126,11 +126,9 @@ struct compat_tms {
 
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
-#ifndef compat_sigset_t
 typedef struct {
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
-#endif
 
 int set_compat_user_sigmask(const compat_sigset_t __user *umask,
 			    size_t sigsetsize);
