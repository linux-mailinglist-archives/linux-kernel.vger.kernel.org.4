Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720FC5BDFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiITIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiITIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3A9FE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663662056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+rrVO93NDmOlIUnSwDzWkTM+P8LQ+RPw309XhLJrYc=;
        b=VqR6r/IRiHCMTBqLUB1xoFsp2aRz6Fh9o3WEmw9xuAFH6kRdZFi4e/j6X3B+uexBvQd9GX
        H+Gt6SBqH3qp9aqZWNmUC23DMagAVeNViaanKLlH3CkY97BTdqqP6um6I7owtQ73Syck18
        Cm8gYFNxkes9MVEZK1o8x1cVO0iIKLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-T-FX5pA9NK6ydTGNOZEM_w-1; Tue, 20 Sep 2022 04:20:53 -0400
X-MC-Unique: T-FX5pA9NK6ydTGNOZEM_w-1
Received: by mail-wr1-f69.google.com with SMTP id x1-20020adfbb41000000b0022b113add45so670904wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1+rrVO93NDmOlIUnSwDzWkTM+P8LQ+RPw309XhLJrYc=;
        b=zWvsrbm7MjTB3WV2q2Zwn7L2g4K407e89XRsdpBF3yqaF33G0HIB6DvQhtEP9F6E2q
         6304nRf6ZfajQsRIf+hv0M+qoR9GV/8ExB77ctAQfEHNi10fAz26Y7cYSAdsH35n15zY
         r1deJpO4Yd/LqOdwkik/VNHQnw/CLE/Zq/txcuB1DSSvDYVvG++148EPnlCaT+KjbDTj
         o5maJJ7fwhBSmymaywqrBB/V+bT634QomB1DprL0ESn0cApCcTxLdyej8rIBcf4RCdXJ
         dcpRfA/sCOUMSYmmhajaNT6fIeVZPRdhPT3wnSHr3JqFc+59oJuV+U4I2aatBk5EtbpK
         vQkA==
X-Gm-Message-State: ACrzQf11ZXvzVt30kLIfikttclbNs88S37OlRZ3xMDh0EK9gdzY19xoH
        BV9/zPRsVVzDrWsezzUauAVi2LP4K+btxBOnJZuByaLZ6zDe8ckk7kTgsvQQJeP4q1S7AQsmp19
        2VOXgGyKxtMZTRxDveeouXUCm
X-Received: by 2002:adf:eb52:0:b0:223:9164:b5b4 with SMTP id u18-20020adfeb52000000b002239164b5b4mr13499018wrn.518.1663662051682;
        Tue, 20 Sep 2022 01:20:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4iQ6R42icnZ09Saqbmpo6z2thRHisAaEDC27R2xhSI+2071PE+zluAAoYhYgRGg3JTJpzmOw==
X-Received: by 2002:adf:eb52:0:b0:223:9164:b5b4 with SMTP id u18-20020adfeb52000000b002239164b5b4mr13499001wrn.518.1663662051415;
        Tue, 20 Sep 2022 01:20:51 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id iw18-20020a05600c54d200b003b492b30822sm1436129wmb.2.2022.09.20.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:20:50 -0700 (PDT)
Message-ID: <c105971a72dfe6d46ad75fb7e71f79ba716e081c.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] perf/x86/intel/lbr: use setup_clear_cpu_cap
 instead of clear_cpu_cap
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
Date:   Tue, 20 Sep 2022 11:20:47 +0300
In-Reply-To: <Yyh9RDbaRqUR1XSW@zn.tnic>
References: <20220718141123.136106-1-mlevitsk@redhat.com>
         <20220718141123.136106-2-mlevitsk@redhat.com> <Yyh9RDbaRqUR1XSW@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-19 at 16:31 +0200, Borislav Petkov wrote:
> On Mon, Jul 18, 2022 at 05:11:19PM +0300, Maxim Levitsky wrote:
> > clear_cpu_cap(&boot_cpu_data) is very similar to setup_clear_cpu_cap
> > except that the latter also sets a bit in 'cpu_caps_cleared' which
> > later clears the same cap in secondary cpus, which is likely
> > what is meant here.
> > 
> > Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> > 
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/events/intel/lbr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> > index 13179f31fe10fa..b08715172309a7 100644
> > --- a/arch/x86/events/intel/lbr.c
> > +++ b/arch/x86/events/intel/lbr.c
> > @@ -1860,7 +1860,7 @@ void __init intel_pmu_arch_lbr_init(void)
> >         return;
> >  
> >  clear_arch_lbr:
> > -       clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
> > +       setup_clear_cpu_cap(X86_FEATURE_ARCH_LBR);
> 
> setup_clear_cpu_cap() has a very specific purpose - see
> apply_forced_caps().
> 
> This whole call sequence is an early_initcall() which is way after the
> whole CPU features picking apart happens.
> 
> So what is actually this fixing?
> 

If I understand that correctly, the difference between clear_cpu_cap and setup_clear_cpu_cap
is that setup_clear_cpu_cap should be called early when only the boot cpu is running and it 
 
1. works on 'boot_cpu_data' which represents the boot cpu.
2. sets a bit in 'cpu_caps_cleared' which are later applied to all CPUs, including these that are hotplugged.
 
On the other hand the clear_cpu_cap just affects the given 'struct cpuinfo_x86'.
 
Call of 'clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR)' is weird since it still affects 'boot_cpu_data'
but doesn't affect 'cpu_caps_cleared'
 
I assumed that this was a mistake and the intention was to disable the feature on all CPUs.
 
I need this patch because in the next patch, I change the clear_cpu_cap such as it detects being
called on boot_cpu_data and in this case also clears bits in 'cpu_caps_cleared', thus
while this patch does introduce a functional change, the next patch doesn't since this is the only
place where clear_cpu_cap is called explicitly on 'boot_cpu_data'
 
 
I do now notice that initcalls are run after smp is initialized, which means that this code doesn't really
disable the CPUID feature on all CPUs at all.
 
Maybe we can drop the call instead, which does seem to be wrong?

Best regards,
	Maxim Levitsky




