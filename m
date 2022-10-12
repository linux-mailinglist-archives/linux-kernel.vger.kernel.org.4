Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB45FC586
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJLMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJLMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:42:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D454C8943
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:42:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so37750687ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scSSoPVjvPcIKMwAKdcIxF1HMnXwBEuvlyuD0JbeDac=;
        b=hSkbNoXoG3wWcVdKnqVO7XYK1bv0MH9u8oEv95OaWkkCTB9RsoNg9sS+DyfAXD0gi8
         C3B5RxdZ6EF3FePvqnrCKkr5w8XgiGA0OEB2iK+NsGb9ZOHdvUgBAY5mEupVk514sXh2
         BcfULR6zZ2AZhQJP/B28JemyEcyeDcI3AKRJ5lPKFWuGde9NbfJyX15rLE2gsyDez6YX
         OKDkOurVilre1ybmB6wqSmbSEpcfuh+ukasYa8QPIj2WOxaDkWQTz+Nri8qre79tIxTd
         1cFDVYDQytan/tbkNZZVN4NNSOJbGSrVUq2mGHauT+3m9QGeWYsm/jufVV+rUDLqTO07
         hCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scSSoPVjvPcIKMwAKdcIxF1HMnXwBEuvlyuD0JbeDac=;
        b=K6J1xEzQKFRNi0aftXTMOatr1H0vVau+okvKAf972DV+ypX1hgq4bZDzICXVUdwAiK
         cNbhLMG+xWGVyFqm5c8tJky/jY4Uj+7XxW69KlZlvpPawl1YOukm5xxYDLnPDeledxoK
         7MMvfkmJQ4IIMdtJVmqoBRZATnKqbxKLVATxvTirGg5exF5CXjXxVTz+DZU3g5MJoy7k
         +rQcZpixt0GHYukHp7WZlJfwYHXHpABOcauHh1m3YZBXht/nbP8N5jayX0JYEZG1V5px
         5VVS0ofYB30oSRWDlr13EoRYg3qoLt/2HB+gmYIcCbV49oxhXkZDv77ZN4Ttb81KOx3q
         TonA==
X-Gm-Message-State: ACrzQf1iaEUjW/sApshO59KySt+5uDKizu6dxebfYRjgHTwIt5uQB3Cz
        MbKmcGXxfoA2nHNKDqhu63c49g==
X-Google-Smtp-Source: AMsMyM5pMRTzBK4wxOaeWPxAICeTFfKr9UUi5U35RJKBVu1VmBh/W7bpRQUc+vTTEtwGS2qmCt2lPQ==
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id ia11-20020a170907a06b00b0078dd25fb726mr7250759ejc.203.1665578537183;
        Wed, 12 Oct 2022 05:42:17 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7da55000000b0044e01e2533asm11133463eds.43.2022.10.12.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:42:16 -0700 (PDT)
Date:   Wed, 12 Oct 2022 14:42:15 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221012124215.edmgo6767yipfkt2@kamzik>
References: <20221012081905.1800640-1-ajones@ventanamicro.com>
 <20221012082422.uavybxdfmv4xkhxi@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012082422.uavybxdfmv4xkhxi@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding more people and lists to CC in order to point this patch out,
because, based on a quick grep of cpuinfo seq operations, I think at least
openrisc, powerpc, and s390 also need an equivalent patch (and I've
already sent a patch for riscv). While the test is simple (see next
paragraph) I'm not equipped to test on each architecture.

To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to a
shell, do 'cat /proc/cpuinfo', and look for a kernel warning.

Thanks,
drew

On Wed, Oct 12, 2022 at 10:24:22AM +0200, Andrew Jones wrote:
> On Wed, Oct 12, 2022 at 10:19:05AM +0200, Andrew Jones wrote:
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > start and next seq operations implement a pattern like
> > 
> >   n = cpumask_next(n - 1, mask);
> >   show(n);
> >   while (1) {
> >       ++n;
> >       n = cpumask_next(n - 1, mask);
> >       if (n >= nr_cpu_ids)
> >           break;
> >       show(n);
> >   }
> > 
> > which will issue the warning when reading /proc/cpuinfo. Ensure no
> > warning is generated by validating the cpu index before calling
> > cpumask_next().
> > 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > ---
> 
> Forgot the changelog...
> 
> v2:
>   - Added all the information I should have in the first place to the
>     commit message [Boris]
>   - Changed style of fix [Boris]
> 
> >  arch/x86/kernel/cpu/proc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > index 099b6f0d96bd..94ac02c8dd6f 100644
> > --- a/arch/x86/kernel/cpu/proc.c
> > +++ b/arch/x86/kernel/cpu/proc.c
> > @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > +	if (*pos >= nr_cpu_ids)
> > +		return NULL;
> > +
> >  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> >  	if ((*pos) < nr_cpu_ids)
> >  		return &cpu_data(*pos);
> > -- 
> > 2.37.3
> > 
