Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE445FE24E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJMS7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiJMS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:58:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F0122767
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:56:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so2698141pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWRpr36T0vvq5ApDatbP6GER4re2aJOEKr2PxsMGVwo=;
        b=FPFt3yOEfGwAJKS6G8ieWTOkgCkn7k7tjXJgzao8TvPZ3+ep3kpnG3uSiMJCtdlZAq
         0m6zhPax4wvRaecvmxZuiVBMb4by2zlwPVv7gTcQlpWueAD002NEZqX9fin/PwQiZJ8N
         EEZ/5H/32HU9wFTU6IHEu0zSjYsu+eumn2zslMJ7xBuARtaoMkOWuJ69POuuW2GgXVPV
         1vMQBb7BxHzoddHA60gRD0Vd0F5if2bUAMxfo8mlRhGEAZqLhF6QXfkEH8R0xU1GiyQU
         i1cmwIpar3JRqG6oH8JxCjBZZNKKvG05q2c84T9kXzRtPmxtJsbTQwqLioaKnYlD/38+
         crYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWRpr36T0vvq5ApDatbP6GER4re2aJOEKr2PxsMGVwo=;
        b=uoA24w1VAjUiG5KILZmL9QOfql4g0tkolHue2IKxvOzD9yay3Kj1lsjdJtbaN9cABY
         i0rRNgMMKL/HsXjCIWWcXcksPm0OS+7U4XsdA/lAMuZEhrbK6HZNhh1eYVhx/Bjp1pB6
         /+G2L2lyedjhcUXNdEG1B6P+6/CuDjFKJb98M+Yt7IZE12FwVhVe3Ie05tTehUoV0ZrG
         4qYplr1Chl5diqXS+mTL0A3Emkj4H5eM+AQaDN3sEuARLi/kye/IhJ98DSmQyJy3G6pS
         VgyuXj3PdJdCfjBMaS4ooavlKQh/aHJZugUrwlmorbcRuNNQMicT7nPrHuy7tGyrkMWC
         3WfA==
X-Gm-Message-State: ACrzQf2nx5mqFpLeElgLS+EI0IRq+qI2lkmnavVEnt4nVDVGuzEpD5av
        C/1qPN2F4GBlaqVgZHeXpic=
X-Google-Smtp-Source: AMsMyM59xd6ZcVEx+l3swra9RQo5gElDf282vgtxbCfMlBM5HWdPGtooDKymbuG/Y/s6RPa38fhMgA==
X-Received: by 2002:a17:90b:1e11:b0:20d:90b3:45a0 with SMTP id pg17-20020a17090b1e1100b0020d90b345a0mr10212953pjb.29.1665687361502;
        Thu, 13 Oct 2022 11:56:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d40100b0017870f471f6sm173606ple.226.2022.10.13.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:56:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 13 Oct 2022 11:55:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, pali@kernel.org,
        paul@paul-moore.com, rmclure@linux.ibm.com, ruscur@russell.cc,
        windhl@126.com, wsa+renesas@sang-engineering.com,
        ye.xingchen@zte.com.cn, yuanjilin@cdjrlc.com,
        zhengyongjun3@huawei.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <20221013185559.GA836698@roeck-us.net>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net>
 <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <bba714ce-4af7-a7ea-21b5-10e5578b6db8@roeck-us.net>
 <CNKJES19WP6K.LOS0TA0Q4MRO@bobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CNKJES19WP6K.LOS0TA0Q4MRO@bobo>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:14:08PM +1000, Nicholas Piggin wrote:
> > > 
> > > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> > > caller is .__flush_tlb_pending+0x40/0xf0
> > > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-28380-gde492c83cae0-dirty #4
> > > Hardware name: PowerMac3,1 PPC970FX 0x3c0301 PowerMac
> > > Call Trace:
> > > [c0000000044c3540] [c000000000f93ef0] .dump_stack_lvl+0x7c/0xc4 (unreliable)
> > > [c0000000044c35d0] [c000000000fc9550] .check_preemption_disabled+0x140/0x150
> > > [c0000000044c3660] [c000000000073dd0] .__flush_tlb_pending+0x40/0xf0
> > > [c0000000044c36f0] [c000000000334434] .__apply_to_page_range+0x764/0xa30
> > > [c0000000044c3840] [c00000000006cad0] .change_memory_attr+0xf0/0x160
> > > [c0000000044c38d0] [c0000000002a1d70] .bpf_prog_select_runtime+0x150/0x230
> > > [c0000000044c3970] [c000000000d405d4] .bpf_prepare_filter+0x504/0x6f0
> > > [c0000000044c3a30] [c000000000d4085c] .bpf_prog_create+0x9c/0x140
> > > [c0000000044c3ac0] [c000000002051d9c] .ptp_classifier_init+0x44/0x78
> > > [c0000000044c3b50] [c000000002050f3c] .sock_init+0xe0/0x100
> > > [c0000000044c3bd0] [c000000000010bd4] .do_one_initcall+0xa4/0x438
> > > [c0000000044c3cc0] [c000000002005008] .kernel_init_freeable+0x378/0x428
> > > [c0000000044c3da0] [c0000000000113d8] .kernel_init+0x28/0x1a0
> > > [c0000000044c3e10] [c00000000000ca3c] .ret_from_kernel_thread+0x58/0x60
> > > 
> > > This in turn is because __flush_tlb_pending() calls:
> > > 
> > > static inline int mm_is_thread_local(struct mm_struct *mm)
> > > {
> > >          return cpumask_equal(mm_cpumask(mm),
> > >                                cpumask_of(smp_processor_id()));
> > > }
> > > 
> > > __flush_tlb_pending() has a comment about this:
> > > 
> > >   * Must be called from within some kind of spinlock/non-preempt region...
> > >   */
> > > void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
> > > 
> > > So I guess that didn't happen for some reason? Maybe this is indicative
> > > of some lock imbalance that then gets hit later?
> >
> > I managed to bisect that problem. Unfortunately it points to the
> > scheduler merge. No idea what to do about that. Any idea ?
> > I am copying Peter and Ingo for comments.
> >
> 
> > # first bad commit: [30c999937f69abf935b0228b8411713737377d9e] Merge tag 'sched-core-2022-10-07' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> This might be a red herring because I can reproduce without it.
> I think we can fix this with some preempt critical sections, they
> don't look too much of a problem.
> 

Do you refer to the bisect of the BUG: message above, or to the other
problem ? I can try to repeat the bisect with some retries if you
think that 30c999937f69a isn't responsible for "BUG: using
smp_processor_id() in preemptible [00000000] code".

Thanks,
Guenter
