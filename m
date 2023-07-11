Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02B674EC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjGKLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGKLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:24:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088611D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2z8gHnnfWXVnbaPbAKfNL95zyeeEa49QugKWjZPnsQA=; b=EeVTW+HLkRQAXr1iKYCBdZb6ma
        Gav/yYrWTRd5IQ9xeX5f9qreJ6pF33YZQFwNWi1/V+D642ZHtG/CruMj3a73Eq3VSy8xrkBh5drDX
        EuuT/NayTQcYd6/wD6zt9Z/nMKjPczEvON4vTo2ZVdZcwJ/wO2dadajHa5RA4gr6RTJ4oOqu5PRlR
        YjuJ+QDmFBv8TqOTFf/Ec4hUh3WED7K8dpFg1V72qy32YZ4I8+H2uO56KhSY8d0Qa0Z66wN31eAJE
        S8g/y6/+YBs+smR+mOrTJ0jGU3QCdRWJssKjCCirM1G/wvHpshAN0a0dROAc1q3gdCoL3/yLfziut
        uI/YJhmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJBTi-00FfOy-OT; Tue, 11 Jul 2023 11:24:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E93D030014A;
        Tue, 11 Jul 2023 13:24:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A10A3240EBDB3; Tue, 11 Jul 2023 13:24:21 +0200 (CEST)
Date:   Tue, 11 Jul 2023 13:24:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     arjan@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:11:44AM +0200, Bruno Goncalves wrote:
> Hello Arjan and Rafael,
> 
> I'm not sure if you are the right person to contact about this, but
> we've noticed the following call trace when booting on KVM machines
> using kernel 6.5.0-rc1:
> 
> [    1.089740] io scheduler kyber registered
> [    1.091080] io scheduler bfq registered
> [    1.094696] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    1.097371] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.099559] unchecked MSR access error: RDMSR from 0xe2 at rIP:
> 0xffffffffa60912d7 (native_read_msr+0x7/0x40)
> [    1.102725] Call Trace:
> [    1.103547]  <TASK>
> [    1.104236]  ? ex_handler_msr+0x121/0x130
> [    1.105545]  ? fixup_exception+0x234/0x310
> [    1.106858]  ? gp_try_fixup_and_notify+0x1d/0xb0
> [    1.108342]  ? exc_general_protection+0x147/0x420
> [    1.109838]  ? pcpu_block_refresh_hint+0x87/0xb0
> [    1.111309]  ? asm_exc_general_protection+0x26/0x30
> [    1.112866]  ? native_read_msr+0x7/0x40
> [    1.114099]  intel_idle_init_cstates_icpu.constprop.0+0x762/0x7f0
> [    1.116063]  intel_idle_init+0x31b/0x4c0
> [    1.117315]  ? __pfx_intel_idle_init+0x10/0x10
> [    1.118734]  do_one_initcall+0x5a/0x320
> [    1.119981]  kernel_init_freeable+0x31b/0x470
> [    1.121373]  ? __pfx_kernel_init+0x10/0x10
> [    1.122681]  kernel_init+0x1a/0x1c0
> [    1.123796]  ret_from_fork+0x29/0x50
> [    1.124963]  </TASK>
> [    1.126012] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    1.128477] ACPI: button: Power Button [PWRF]
> [    1.163767] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> [    1.193831] ACPI: \_SB_.LNKC: Enabled at IRQ 11

You forgot to say on what host hardware, what qemu options and you
forgot to run the above through scripts/decode_stacktrace.sh.
