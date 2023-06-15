Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF7732260
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjFOWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFOWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:03:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942B2D6B;
        Thu, 15 Jun 2023 15:03:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686866611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WePTMyE45qwE++8TRrjkwtysmPUcOS3LgW/k38AkuSI=;
        b=BFrLebSkFNVOCzT2IpgGiJ0Pvwl4C6rJQWMOuiT+63wINu33JzO78MU9TYGFMlnWUXyAUh
        Xhk4wm8ZUtG+W8XJ1HYlTbHql0VJge25Ax5kGvVg+m6ndfrxbxGCAKdspD5x5j4TmDVxGW
        hz23M3Hz+IqqiDWtpbQps8Ylv0FhHNkVJiImy19cXSnE3P8f2RAAZmjZTovqVh5T0zERE4
        P/0Lx/U4+CDx5K5TMi5xFn2XRxKyjm/1lX7z1RJvE4XZO349M91G/jWdnDwbBd8z42Bqhr
        R8YBEF4GMDQ+PIIUcGwC4fRAq2j8jxS43fkmJxExYShf33Zc0q093qDMYhFKxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686866611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WePTMyE45qwE++8TRrjkwtysmPUcOS3LgW/k38AkuSI=;
        b=6iNPBBEFXbFtS5Ao2dawxcNVDyr/qHhbmKNIDyn3HuL1jxxTrLdZSnDkEAT/K1svJmXSNt
        QPnvP4lcgbb0l9Ag==
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "darwi@linutronix.de" <darwi@linutronix.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "dalias@libc.org" <dalias@libc.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
In-Reply-To: <b0be67b75d1c3f6b0e98b46a56b8588b9b9e4b2a.camel@intel.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.612182854@linutronix.de>
 <b0be67b75d1c3f6b0e98b46a56b8588b9b9e4b2a.camel@intel.com>
Date:   Fri, 16 Jun 2023 00:03:30 +0200
Message-ID: <87sfas758t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2023 at 21:44, Rick P. Edgecombe wrote:
> On Wed, 2023-06-14 at 01:39 +0200, Thomas Gleixner wrote:
>> Fortunately none of the init calls between calibrate_delay() and
>> arch_cpu_finalize_init() is relevant for the functionality of
>> arch_cpu_finalize_init().
>> 
>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> I did my best to find a counterpoint to this statement. The only thing
> I found was that lockdep_init_task(&init_task) in fork_init() is now
> called after the spin_lock() usage in set_memory_4k().
>
> But AFAICT, that whole lockdep_init_task() call is unneeded because
> the fields it sets are already statically initialized.

Correct. The call there looks absolute pointless. Peter?
