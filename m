Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFA72F9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbjFNJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjFNJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:52:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC5DC;
        Wed, 14 Jun 2023 02:52:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686736334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8/kluo4EhxJUN1w8Wkxa+89VuHL9oMdcgH3J0LyeG0=;
        b=Az/2Llqz+IM3XCNfPKYHopkPqaXC+pwMBOIpVA+mJJHPWxSPOIY34kEAIaen1V0Ow+QlxI
        NwXssu9xAGcIJuH9pLqUTwxjEj03zgvfEssBnfsHPEPQIBpsWpsym5MYe87R56oVEK6Ppg
        so8zxD9U3nruzhrdwW2y8dBP09ZrsaczRfdum4KYj2TOgHQWqvaDr8+oKdPXE/SpaX1Vb0
        dUO9xBd0DLIueg+D6EjwtITyCleCX9eGbA0lXl1NQ8rRG3RuKc1Q695iKe085RguBbM6B1
        KehZaYHQ9WpTKOCQntKCcBydTrGOqa6dvjJFZUj8dWdUzmbM7Ell8lih0F5yrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686736334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8/kluo4EhxJUN1w8Wkxa+89VuHL9oMdcgH3J0LyeG0=;
        b=FVmcyAPxnopLQkGRCsMmFInFjSnDHkimejjG/YwNIqrUEGJ3/xx0bziZNTPs5wNfY73Etv
        rMYxWz+Vccq4JaAQ==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
In-Reply-To: <23dc1c47-88ee-6b2d-1a5a-d6c812bb1761@intel.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <23dc1c47-88ee-6b2d-1a5a-d6c812bb1761@intel.com>
Date:   Wed, 14 Jun 2023 11:52:14 +0200
Message-ID: <87o7li8j75.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13 2023 at 22:03, Chang S. Bae wrote:

> On 6/13/2023 4:39 PM, Thomas Gleixner wrote:
>>   
>> @@ -2396,6 +2393,13 @@ void __init arch_cpu_finalize_init(void)
>>   			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
>>   	}
>>   
>> +	/*
>> +	 * Must be before alternatives because it might set or clear
>> +	 * feature bits.
>> +	 */
>> +	fpu__init_system();
>> +	fpu__init_cpu();
>
> fpu__init_cpu() appears to be duplicated here because fpu__init_system() 
> invoked this already:
>
> void __init fpu__init_system(void)
> {
> ...
> 	/*
> 	 * The FPU has to be operational for some of the
> 	 * later FPU init activities:
> 	 */
> 	fpu__init_cpu();

Well, that's _before_ xstate initialization and I couldn't convince
myself that it's good enough. All of this is such a horrible mess...
