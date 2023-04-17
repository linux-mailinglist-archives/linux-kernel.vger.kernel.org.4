Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCE6E4712
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDQMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDQMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:02:10 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA099BB;
        Mon, 17 Apr 2023 05:01:25 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C7E5061CC40F9;
        Mon, 17 Apr 2023 13:24:36 +0200 (CEST)
Message-ID: <a736cae5-8c05-ddda-a1b0-37c8afdbd6ea@molgen.mpg.de>
Date:   Mon, 17 Apr 2023 13:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de>
In-Reply-To: <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Correct David’s address]

Am 17.04.23 um 13:19 schrieb Paul Menzel:
> Dear Thomas,
> 
> 
> Am 15.04.23 um 01:44 schrieb Thomas Gleixner:
> 
>> This is a complete rework of the parallel bringup patch series (V17)
>>
>>      
>> https://lore.kernel.org/lkml/20230328195758.1049469-1-usama.arif@bytedance.com
>>
>> to address the issues which were discovered in review:
> 
> […]
> 
> Thank you very much for your rework.
> 
> I tested this on the ASUS F2A85-M PRO, and get a delay of ten seconds.
> 
> ```
> […]
> [    0.258193] smpboot: CPU0: AMD A6-6400K APU with Radeon(tm) HD 
> Graphics (family: 0x15, model: 0x13, stepping: 0x1)
> […]
> [    0.259329] smp: Bringing up secondary CPUs ...
> [    0.259527] x86: Booting SMP configuration:
> [    0.259528] .... node  #0, CPUs:      #1
> [    0.261007] After schedule_preempt_disabled
> [   10.260990] CPU1 failed to report alive state
> [   10.261070] smp: Brought up 1 node, 1 CPU
> [   10.261073] smpboot: Max logical packages: 2
> [   10.261074] smpboot: Total of 1 processors activated (7800.54 BogoMIPS)
> [   10.261601] devtmpfs: initialized
> [   10.261697] x86/mm: Memory block size: 128MB
> ```
> 
> This delay has been there with v6.3-rc6-46-gde4664485abbc and some 
> custom (printk) patches on top and merging dwmw2/parallel-6.2-rc3-v16 
> into it. I only tested this. I think dwmw2/parallel-6.2-v17 failed to 
> build for me, when trying to merge it into Linus’ master version at that 
> time. I didn’t come around to report it, and you posted your rework, so 
> I am replying here.
> 
> I am going to try your branch directly in the next days, but just wanted 
> to report back already.
> 
> 
> Kind regards,
> 
> Paul
