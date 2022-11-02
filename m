Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47627615E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKBI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKBI43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEA27DC1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667379327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goTFNCR5xh8RjjY26CfHji/Ra2onaonESW/AoDsU4Pc=;
        b=Y3OzR6eljwjqax99nJJ0PftaHRruFxJgNzuljUaSWMWsnnpY1Jaart8yz0LhI3NT93frYY
        bAC/2dCdF16809xCt8LximxnNvPkPh3mZcaQ6u0YjclFdaYxWiMYbfesYsST9SKEI7D4qp
        1kQXbExKTAkvPFnJEivdsrrt4fYp0Jk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-foPQ8IwXP5yhtqX5D6E3mQ-1; Wed, 02 Nov 2022 04:55:26 -0400
X-MC-Unique: foPQ8IwXP5yhtqX5D6E3mQ-1
Received: by mail-qk1-f199.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so14607039qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=goTFNCR5xh8RjjY26CfHji/Ra2onaonESW/AoDsU4Pc=;
        b=pvZVjx6Nv5Xtmm276PeFFzzhUmjTqalE1deltVjn3ZN53AJweNLojUCv3FQacztU/L
         2vAYV64BJ9piWgDAO1XOoeS3EjD4ycQqetHeELIn50vjwpsUUeRYiCol5neO3IGsm0Pe
         3azb+KIMc9kJPPTyyGf7epfMGTW7jGUWGucf2PVRrbD8BGjwh5IRYREgfapXGZjLx3wo
         y7CB2feMTfdbFiwLvDkkzvvOQ0KHG4PAudBtaLCPlES39ND4+elp8n7ypi1k+fwW1S3d
         WV6or1pltW8CpXriDFMJQK8M/Iad93ManA5pJGmb1ssfzcsl5iLq6LJW2hfYKO35j6i8
         aiWQ==
X-Gm-Message-State: ACrzQf1apwXtsymzxbkyCDBfNS4Lr5vSTP54WI0BHHI8L6h6NRBsOkT1
        Ug2ujMenBCk5/dPLCA8mfF1l71M2Bqgfy10osQcHbJg5XgmUv4+TwCy/zRaFgwKbvitVb3yk543
        b6+2k2kbWfPu420Hl9iqzBt6m
X-Received: by 2002:ad4:5bee:0:b0:4bb:eaab:1a5e with SMTP id k14-20020ad45bee000000b004bbeaab1a5emr14202216qvc.40.1667379325557;
        Wed, 02 Nov 2022 01:55:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53moQsWcJr7Me0CJypyY1+grVDd1SMub5SMvZLIYWP4uv0DvWz1tq6m2LHA3mwQtoNIsqMpg==
X-Received: by 2002:ad4:5bee:0:b0:4bb:eaab:1a5e with SMTP id k14-20020ad45bee000000b004bbeaab1a5emr14202203qvc.40.1667379325329;
        Wed, 02 Nov 2022 01:55:25 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-135.inter.net.il. [84.229.250.135])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b006bb366779a4sm1767396qkb.6.2022.11.02.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:55:24 -0700 (PDT)
Message-ID: <4ae08a4e28993cf3e41f2e659d8549050c6e49f3.camel@redhat.com>
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
Date:   Wed, 02 Nov 2022 10:55:18 +0200
In-Reply-To: <ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com>
References: <20220804131728.58513-1-ypodemsk@redhat.com>
         <YxdfO/5/Yfodm18i@hirez.programming.kicks-ass.net>
         <xhsmhsfl4bhpb.mognet@vschneid.remote.csb>
         <ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping? 

On Wed, 2022-10-19 at 14:31 +0300, ypodemsk@redhat.com wrote:
> On Tue, 2022-09-06 at 17:17 +0100, Valentin Schneider wrote:
> > On 06/09/22 16:54, Peter Zijlstra wrote:
> > > On Thu, Aug 04, 2022 at 04:17:28PM +0300, Yair Podemsky wrote:
> > > > @@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
> > > >      s->mcnt = mcnt;
> > > >      raw_write_seqcount_end(&s->seq);
> > > > 
> > > > -	scale_freq_tick(acnt, mcnt);
> > > > +	/*
> > > > +	 * Avoid calling scale_freq_tick() when the last update
> > > > was too
> > > > long ago,
> > > > +	 * as it might overflow during calulation.
> > > > +	 */
> > > > +	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
> > > > +		scale_freq_tick(acnt, mcnt);
> > > >  }
> > > 
> > > All this patch does is avoid the warning; but afaict it doesn't
> > > make it
> > > behave in a sane way.
> 
> It also avoids the disabling of the frequency invariance accounting
> for
> all cpus, that occurs immediately after the warning.
> That is the bug that is being solved, Since it affects also non-
> tickless cpus.
> 
> > > I'm thinking that on nohz_full cpus you don't have load
> > > balancing,
> > > I'm
> > > also thinking that on nohz_full cpus you don't have DVFS.
> > > 
> > > So *why* the heck are we setting this stuff to random values ?
> > > Should
> > > you not simply kill th entire thing for nohz_full cpus?
> > 
> > IIRC this stems from systems where nohz_full CPUs are not running
> > tickless
> > at all times (you get transitions to/from latency-sensitive work).
> > Also
> > from what I've seen isolation is (intentionally) done with just
> > isolcpus=managed_irq,<nohz_cpus>; there isn't the 'domain' flag so
> > load
> > balancing isn't permanently disabled.
> > 
> > DVFS is another point, I don't remember seeing cpufreq governor
> > changes in
> > the transitions, but I wouldn't be suprised if there were - so we'd
> > move
> > from tickless, no-DVFS to ticking with DVFS (and would like that to
> > behave
> > "sanely").
> > 
> > FWIW arm64 does something similar in that it just saves the
> > counters
> > but
> > doesn't update the scale when the delta overflows/wrapsaround, so
> > that the
> > next tick can work with a sane delta, cf
> > 
> >   arch/arm64/kernel/topology.c::amu_scale_freq_tick()
> > 

