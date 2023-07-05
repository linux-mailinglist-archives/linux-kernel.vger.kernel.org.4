Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE63D748047
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGEI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGEI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:59:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808F10E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:59:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688547563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf4glG5RrjzsZDHEwCTkoyrZ5ilmAB1pGZBJhpzC2Ts=;
        b=E2tkiAQP8nJBMn1PkgdEZ69sQ2IlnvWWTH85RSq6aBRgUxQ8D7EPMNlv1NPOaOK8tPq9uM
        Vb7PNvXF/RH+Cne8w8ZXUUdEr4mvq/AtNGXWSclItV1Q67rt3N67l9a9h4B5BQc/sCplKI
        Ti4fkDAb9sWazTqTsoA1f8k7TjuY5y24Tb9eDS2Y58xE/nlSnssvI3XxGfw8KbnAlfhXU0
        Oi5daN0zBbBTb45zKy9c/nURvGDq5WQGrkRfKT7YCdVG+0+C5NCFjRimZG4xXw1N71lfaS
        k5gNIpjqhlrwjM0SIdFRtUUKWtR/7E2aaM8p/h2T3gHx8BUvoChj90oihUtkVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688547563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf4glG5RrjzsZDHEwCTkoyrZ5ilmAB1pGZBJhpzC2Ts=;
        b=WXuFSKXOCh1bWDYSwOVlOTwwgaxNSLNZrIvGR6iUs0KHjqUewYG+1ALcpaqMWc2qLLu8J1
        r2WKhuAza3mrCBDw==
To:     Baokun Li <libaokun1@huawei.com>
Cc:     arjan@linux.intel.com, ashok.raj@intel.com,
        ashok.raj@linux.intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        tonyb@cybernetics.com, x86@kernel.org,
        yangerkun <yangerkun@huawei.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
In-Reply-To: <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com>
Date:   Wed, 05 Jul 2023 10:59:23 +0200
Message-ID: <87ttui91jo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03 2023 at 11:44, Baokun Li wrote:

> When I manually trigger panic in a qume x86 VM with
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `echo c > /proc/sysrq-trigger`,
>
>  =C2=A0I find that the VM will probably reboot directly, but the=20
> PANIC_TIMEOUT is 0.
> This prevents us from exporting the vmcore via panic, and even if we succ=
eed
> in panic exporting the vmcore, the processes in the vmcore are mostly
> stop_this_cpu(). By dichotomizing we found the patch that introduced the
> behavior change
>
>  =C2=A0=C2=A0 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if p=
ossible"),

Bah, I missed that this is used by crash too. So if this happens to be
invoked on an AP, i.e. not on CPU 0, then the INIT will reset the
machine. Fix below.

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ed2d51960a7d..e1aa2cd7734b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1348,6 +1348,14 @@ bool smp_park_other_cpus_in_init(void)
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
=20
+	/*
+	 * If this is a crash stop which does not execute on the boot CPU,
+	 * then this cannot use the INIT mechanism because INIT to the boot
+	 * CPU will reset the machine.
+	 */
+	if (this_cpu)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		if (cpu =3D=3D this_cpu)
 			continue;
