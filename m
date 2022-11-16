Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793AC62B660
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiKPJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiKPJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:22:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD027CF0;
        Wed, 16 Nov 2022 01:22:28 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590546;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrCWOvdxapIC2FhJTIH20tHEZ3kAPRTBVFgIugO7JtY=;
        b=dqAVZi9DRU2H/2zgIHGha9h8egSYldJesAtstY9tX5uKggePerVqA3mtNw40uQxeUrSZ2o
        +jnR5eiXw1a2/hCvd8LbqUIno9TwC39bBOj3axYFm+yt+NaMGyIIlDvUgLrNs4LIeCdTGc
        Pbj2PMLoeuGdrxR7jItxQ3fWxxNiJoHEv7fgvx7EqrioGF47/XWpyvzhgcgCm4QdbowPa8
        qN/tIGn2SNFKWTGFNfWdaUZy8Pn1GAYP0Dyk7GXnLYZyFBvjF5E/h7LqVL3zaqIpXckcIy
        Q0bW+NYpf3tAmWoe2HyUGsiOeK873c3Fif2caH2qNTnBgX5O/0udbelWL8k/oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590546;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrCWOvdxapIC2FhJTIH20tHEZ3kAPRTBVFgIugO7JtY=;
        b=XgxzFEQFK96juimMW4PuhXvjFoAbPhwmYA77SUhldLsbsdFjHdLWlEbWWASke7KVNVMJpY
        UASbDZ/X5Vm9O7Dw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/debug: Include percpu.h in debugreg.h to get
 DECLARE_PER_CPU() et al
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110201707.1976032-1-seanjc@google.com>
References: <20221110201707.1976032-1-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <166859054557.4906.8309714877801364722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2d08a893b87cf9b2f9dbb3afaff60ca4530d55a2
Gitweb:        https://git.kernel.org/tip/2d08a893b87cf9b2f9dbb3afaff60ca4530=
d55a2
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:17:07=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Nov 2022 10:12:56 +01:00

x86/debug: Include percpu.h in debugreg.h to get DECLARE_PER_CPU() et al

Include percpu.h to pick up the definition of DECLARE_PER_CPU() and
friends instead of relying on the parent to provide the #include.  E.g.
swapping the order of includes in arch/x86/kvm/vmx/nested.c (simulating
KVM code movement being done for other purposes) results in build errors:

  In file included from arch/x86/kvm/vmx/nested.c:3:
  arch/x86/include/asm/debugreg.h:9:32: error: unknown type name =C3=A2=C2=80=
=C2=98cpu_dr7=C3=A2=C2=80=3D99
      9 | DECLARE_PER_CPU(unsigned long, cpu_dr7);
        |                                ^~~~~~~

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110201707.1976032-1-seanjc@google.com
---
 arch/x86/include/asm/debugreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index cfdf307..b049d95 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -2,8 +2,8 @@
 #ifndef _ASM_X86_DEBUGREG_H
 #define _ASM_X86_DEBUGREG_H
=20
-
 #include <linux/bug.h>
+#include <linux/percpu.h>
 #include <uapi/asm/debugreg.h>
=20
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
