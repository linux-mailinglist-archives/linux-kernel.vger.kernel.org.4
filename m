Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6349870BD11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjEVMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjEVMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:13:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B698119;
        Mon, 22 May 2023 05:12:46 -0700 (PDT)
Date:   Mon, 22 May 2023 12:12:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684757564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEjofJonbFjcrIFx5W6JsYcXuFz3vdclGrLXxCuKyb4=;
        b=r3mq2lyd/CSnJMz4F/RrxpJQKpG1+eo9TAe1UmzqW/zTFFq4IbrSBfpnUETpwxBnrhqa5Y
        fQq41JENXrZ9pUrZvzhr/hLGNfKnp4i7dojPoLBCwGt0BqTA9buHEzBFFkpf2id/+m/VPu
        3J6IabjH5frnsPvrNbg6nX4WPhceVB7digFwEbSLUA0obn+MzEX0kAjrvK8uZIuaqSzfg2
        t19lutUeznB3uvrAVNHv5oHOzbMFPesKJN+UomNaLMUaHq94lB6MhV49JFkhIllpROcbuk
        VDsnqV/VE91hvPT4QiXRpdE1tIue5EcqT8Smi4DXyUA/12zd9becH4C5pJ61Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684757564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEjofJonbFjcrIFx5W6JsYcXuFz3vdclGrLXxCuKyb4=;
        b=P5lbzH1qjGAKTAAHz5CS+xoLnOq1+LMRsgdDcxDsO88gFnjQmo665zxOsfe5h8z8b/QAVO
        Fr3BskORxf2cq8Dw==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/apic: Fix use of X{,2}APIC_ENABLE in asm with
 older binutils
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522105738.2378364-1-andrew.cooper3@citrix.com>
References: <20230522105738.2378364-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Message-ID: <168475756408.404.16653429197194734425.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     6a4be6984595b164b6f281c5b242dbdf1c06d528
Gitweb:        https://git.kernel.org/tip/6a4be6984595b164b6f281c5b242dbdf1c06d528
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Mon, 22 May 2023 11:57:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 May 2023 14:06:33 +02:00

x86/apic: Fix use of X{,2}APIC_ENABLE in asm with older binutils

"x86/smpboot: Support parallel startup of secondary CPUs" adds the first use
of X2APIC_ENABLE in assembly, but older binutils don't tolerate the UL suffix.

Switch to using BIT() instead.

Fixes: 7e75178a0950 ("x86/smpboot: Support parallel startup of secondary CPUs")
Reported-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://lore.kernel.org/r/20230522105738.2378364-1-andrew.cooper3@citrix.com

---
 arch/x86/include/asm/apicdef.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index bf546df..4b125e5 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_APICDEF_H
 #define _ASM_X86_APICDEF_H
 
+#include <linux/bits.h>
+
 /*
  * Constants for various Intel APICs. (local APIC, IOAPIC, etc.)
  *
@@ -140,8 +142,8 @@
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 #define APIC_BASE_MSR		0x800
 #define APIC_X2APIC_ID_MSR	0x802
-#define XAPIC_ENABLE	(1UL << 11)
-#define X2APIC_ENABLE	(1UL << 10)
+#define XAPIC_ENABLE		BIT(11)
+#define X2APIC_ENABLE		BIT(10)
 
 #ifdef CONFIG_X86_32
 # define MAX_IO_APICS 64
