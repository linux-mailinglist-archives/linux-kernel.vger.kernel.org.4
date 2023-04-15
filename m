Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FF6E33BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 23:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDOVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 17:04:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7425B0;
        Sat, 15 Apr 2023 14:04:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681592657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvzaDLok1TQ4UelYWBZG7isf5NmoEpMzY70xaWHq6tY=;
        b=fIS1RUsnFKdb9xABGYfFiZCU2J2QWZeug/pOhRzYO2SSFiN67M2BraQ6i1WFD37roLQsyb
        0Xo1pTWRYZ/WwMogkjjzj3I+bbwhVwR7hTC3ROy5wKT1EIYulJpr/cXNAdOvjkRz7uB3BI
        klyFr/vToH0lZCb+hb3VXX9pfB0N3D76XKagNMZKWitt63oRwb7aPaIvEhJSApLEK7ILRG
        Zkcr6A4WMIslSyduOboeP87v5gUiVRgVXC8mEjpP6oV0s0oxKgYk+mkzY1TMBc6xKWwYqj
        lHlMmqQccgQg7IW71Y5KizHByK/0ncSB7/Q2HObdyAE/q+s6MPivfs7vv6Bz9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681592657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvzaDLok1TQ4UelYWBZG7isf5NmoEpMzY70xaWHq6tY=;
        b=uGGpswhVFZB8lospVRZK/FCDeguM0Ticu2FJ7GXNrivH09zniqOSmq2BEICy2eBqNRVNGH
        0xJtAf6AVJyuuYBQ==
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 19/37] x86/smpboot: Switch to hotplug core state
 synchronization
In-Reply-To: <CAMzpN2j4NbGGR=jfxpVVQwYCZ=hHOUKm3oBpw1WKGiTUJ73EXA@mail.gmail.com>
References: <20230414225551.858160935@linutronix.de>
 <20230414232310.382005483@linutronix.de>
 <CAMzpN2j4NbGGR=jfxpVVQwYCZ=hHOUKm3oBpw1WKGiTUJ73EXA@mail.gmail.com>
Date:   Sat, 15 Apr 2023 23:04:16 +0200
Message-ID: <87pm84yi0f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15 2023 at 08:58, Brian Gerst wrote:
> On Fri, Apr 14, 2023 at 7:44=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>         pr_debug("Before bogomips\n");
>> -       for_each_possible_cpu(cpu)
>> -               if (cpumask_test_cpu(cpu, cpu_callout_mask))
>> +       for_each_possible_cpu(cpu) {
>> +               if (cpumask_test_cpu(cpu, cpu_online_mask))
>>                         bogosum +=3D cpu_data(cpu).loops_per_jiffy;
>
> This should be the same as for_each_online_cpu().

Duh, yes. Obviously...
