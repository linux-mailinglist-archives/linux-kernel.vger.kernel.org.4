Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5E604571
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiJSMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiJSMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698EEE8B0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666181658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2ajoM6HKyyy0fQV6RqoVpjRKL+El/OinHj8fwlKME4=;
        b=VYNNUMpoPumwuHJGMG/d+caaOclbcd9TcHRqBNILi1dopDWza1DVpRSxCpYjePDRtiAumw
        X+eQeLHbkBGyITyjeJDLUIzjyL/qbGrUviPOXT5CjUHL6g8ePtQcE4rRGYu4qSh0PGXR7B
        jB/WPVcEFnCKYXECx55Nfxc4BtGhgAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-Opx8lbmnP5SdPVKKAAvGvQ-1; Wed, 19 Oct 2022 07:31:47 -0400
X-MC-Unique: Opx8lbmnP5SdPVKKAAvGvQ-1
Received: by mail-wm1-f70.google.com with SMTP id r203-20020a1c44d4000000b003c3a87d8abdso147613wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H2ajoM6HKyyy0fQV6RqoVpjRKL+El/OinHj8fwlKME4=;
        b=Tg8qkx9VS+d3tgKKvqQNK7I3310XRlf3yDctKHJ4BlfJa84CMqa9O+MXBGgdgqgT+H
         FtOGSbqhGI0t1Gpwrwla5xId9cDHc9ICSVtfDozE9acQutEIblXRR12f4pqEezARBuUe
         Ugu26oSG8Rq3Ct7j2uNExfi+8s5tUfAGF2/rdn6n8eWbpA8zC+zJW+fLcg00jjbyxrEZ
         lToFlsnGGUg8T0SSUnM99+YxLtSqkNF40I9v/20nxm2OWZt+tvSdiynwmoMoeFSaB13a
         Y7Fj2AbpvqDrsR45IjNSQ6rog5YoYK42jY1oG7PPgN+EskzZ+hPFk1udywmih4pnn1Ev
         Oy6g==
X-Gm-Message-State: ACrzQf3WmDh6FF/qP0vkCWt0VX3RrHzjjkWXz+HpgzySRLwYNBIfEp2X
        7ZbQq9q7ByNrYU8isoisKyWQLj/u6BzAzE34o5QyXphZgy0KVIHBAw3OsFAXyR5ujTtoPt6pl8I
        gnnV+M/9FDbiPPnOedC82JqJM
X-Received: by 2002:a05:6000:c9:b0:22e:4055:559c with SMTP id q9-20020a05600000c900b0022e4055559cmr4949058wrx.438.1666179106160;
        Wed, 19 Oct 2022 04:31:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5jhXdXMY6tfwF+LeqiXu53MARy6CeNryQi7gzcTecSoJUh1oPQe8TyCADGSn28OF8Mz3uJCA==
X-Received: by 2002:a05:6000:c9:b0:22e:4055:559c with SMTP id q9-20020a05600000c900b0022e4055559cmr4949042wrx.438.1666179105944;
        Wed, 19 Oct 2022 04:31:45 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-135.inter.net.il. [84.229.250.135])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b003c7087f6c9asm593781wmo.32.2022.10.19.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:31:44 -0700 (PDT)
Message-ID: <ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com>
Subject: Re: [PATCH] x86/aperfmperf: Fix arch_scale_freq_tick() on tickless
 systems
From:   ypodemsk@redhat.com
To:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        rafael.j.wysocki@intel.com, pauld@redhat.com, frederic@kernel.org,
        ggherdovich@suse.cz, linux-kernel@vger.kernel.org, lenb@kernel.org,
        jlelli@redhat.com, mtosatti@redhat.com, ppandit@redhat.com,
        alougovs@redhat.com, lcapitul@redhat.com, nsaenz@kernel.org
Date:   Wed, 19 Oct 2022 14:31:40 +0300
In-Reply-To: <xhsmhsfl4bhpb.mognet@vschneid.remote.csb>
References: <20220804131728.58513-1-ypodemsk@redhat.com>
         <YxdfO/5/Yfodm18i@hirez.programming.kicks-ass.net>
         <xhsmhsfl4bhpb.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-06 at 17:17 +0100, Valentin Schneider wrote:
> On 06/09/22 16:54, Peter Zijlstra wrote:
> > On Thu, Aug 04, 2022 at 04:17:28PM +0300, Yair Podemsky wrote:
> > > @@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
> > >      s->mcnt = mcnt;
> > >      raw_write_seqcount_end(&s->seq);
> > > 
> > > -	scale_freq_tick(acnt, mcnt);
> > > +	/*
> > > +	 * Avoid calling scale_freq_tick() when the last update was too
> > > long ago,
> > > +	 * as it might overflow during calulation.
> > > +	 */
> > > +	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
> > > +		scale_freq_tick(acnt, mcnt);
> > >  }
> > 
> > All this patch does is avoid the warning; but afaict it doesn't
> > make it
> > behave in a sane way.

It also avoids the disabling of the frequency invariance accounting for
all cpus, that occurs immediately after the warning.
That is the bug that is being solved, Since it affects also non-
tickless cpus.

> > 
> > I'm thinking that on nohz_full cpus you don't have load balancing,
> > I'm
> > also thinking that on nohz_full cpus you don't have DVFS.
> > 
> > So *why* the heck are we setting this stuff to random values ?
> > Should
> > you not simply kill th entire thing for nohz_full cpus?
> 
> IIRC this stems from systems where nohz_full CPUs are not running
> tickless
> at all times (you get transitions to/from latency-sensitive work).
> Also
> from what I've seen isolation is (intentionally) done with just
> isolcpus=managed_irq,<nohz_cpus>; there isn't the 'domain' flag so
> load
> balancing isn't permanently disabled.
> 
> DVFS is another point, I don't remember seeing cpufreq governor
> changes in
> the transitions, but I wouldn't be suprised if there were - so we'd
> move
> from tickless, no-DVFS to ticking with DVFS (and would like that to
> behave
> "sanely").
> 
> FWIW arm64 does something similar in that it just saves the counters
> but
> doesn't update the scale when the delta overflows/wrapsaround, so
> that the
> next tick can work with a sane delta, cf
> 
>   arch/arm64/kernel/topology.c::amu_scale_freq_tick()
> 

