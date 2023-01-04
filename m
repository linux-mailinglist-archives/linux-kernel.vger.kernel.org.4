Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67E765D788
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbjADPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjADPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBAC395D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672847288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2rJSAAlmqM+LlUkt//QmruVQdZu3RTOFEFxDJMkPC4=;
        b=Mh1VqfMTxbnYcvaJk0vxCLC4XCqYifuwM3aQOY6Nwre5ez/sL0JRhVxkvCiDsirQIRG6hg
        ci8u8dhQYI7SFTYqCNVqSn2RUuWjY0MgxImbXjj2sFNaa7h8fXw1zxPXpR0dx16mVivv9+
        /B1poQbROhMV9glu6s+5bNeDCoak334=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-x0haxWGnMR2I3luSqMNmHg-1; Wed, 04 Jan 2023 10:48:05 -0500
X-MC-Unique: x0haxWGnMR2I3luSqMNmHg-1
Received: by mail-vk1-f200.google.com with SMTP id q128-20020a1fa786000000b003d56dd6d8a7so6522962vke.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2rJSAAlmqM+LlUkt//QmruVQdZu3RTOFEFxDJMkPC4=;
        b=pGiZBBgurM0lHojlyh4vsmpMiXsVLPSFUWMZ9eH8QxPH9aR0OcQ787SLlWJojG1c2i
         /B0E6ed5pKRKglSPcNrNgv4U3EvG1yrO4S7lUvio+af3jDMELoLSNvinITQdRve7yeAv
         WK+PG98WxaqtOlQMGtHNdhoEPK+4t506MqaUYY/KojR3VDCcLxhvaEeDvTHVlMSanExS
         Zp2s97q9GvINgM93RFpZA8MjKnPENTJLFJE86etnCL3ex7u4aItpCEjJg4S8Oa/TV4uz
         /Xg91Rmdx91y7oDJSFqghBpKeTb46c+W0DuI8Pn7BhfUr+3Y5gBdO45xAyYDv0S2Tb9X
         WVUA==
X-Gm-Message-State: AFqh2kpoP8puFug/wo8wTpoZY7Vdf88bVB+EPBeZ2RymSRGZp9hLt80m
        /THTiFUzqY6qHBO3J6hKIf2ygtBALfB2o3vBR2d8AmsvgGzUgo2rzyjdqhHW+S+nWBPw6+qBRaY
        ZOixBxOWZIf4FUcZRTR0fE6EG
X-Received: by 2002:a1f:1f08:0:b0:3c0:fd5e:84c with SMTP id f8-20020a1f1f08000000b003c0fd5e084cmr4994912vkf.12.1672847284359;
        Wed, 04 Jan 2023 07:48:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsKzywdxNrFnU8kDbG4NTxJscwOR9dPFxvdSqOhS0HtgnUKxTDppwzZvo3zRGKSXp5DuWNjMw==
X-Received: by 2002:a1f:1f08:0:b0:3c0:fd5e:84c with SMTP id f8-20020a1f1f08000000b003c0fd5e084cmr4994882vkf.12.1672847284046;
        Wed, 04 Jan 2023 07:48:04 -0800 (PST)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-135.inter.net.il. [84.229.250.135])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm23989571qki.55.2023.01.04.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:48:03 -0800 (PST)
Message-ID: <198a76a3f1e8299dab1096d0bc8adba5a3b12fbc.camel@redhat.com>
Subject: Re: [PATCH] sched/core: Fix arch_scale_freq_tick() on tickless
 systems
From:   ypodemsk@redhat.com
To:     Giovanni Gherdovich <ggherdovich@suse.cz>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, jlelli@redhat.com, mtosatti@redhat.com,
        nsaenz@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jan 2023 17:47:58 +0200
In-Reply-To: <4dff11851bf3fd306ff623bbcc29fca4b2e690e1.camel@suse.cz>
References: <20221130125121.34407-1-ypodemsk@redhat.com>
         <4dff11851bf3fd306ff623bbcc29fca4b2e690e1.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping

On Wed, 2022-12-14 at 16:35 +0100, Giovanni Gherdovich wrote:
> On Wed, 2022-11-30 at 14:51 +0200, Yair Podemsky wrote:
> > In order for the scheduler to be frequency invariant we measure the
> > ratio between the maximum cpu frequency and the actual cpu
> > frequency.
> > During long tickless periods of time the calculations that keep
> > track
> > of that might overflow, in the function scale_freq_tick():
> > 
> > if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> > »       goto error;
> > 
> > eventually forcing the kernel to disable the feature for all cpus,
> > and show the warning message
> > "Scheduler frequency invariance went wobbly, disabling!".
> > Let's avoid that by limiting the frequency invariant calculations
> > to cpus with regular tick.
> > 
> > Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in
> > frequency invariant accounting")
> > Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> > Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> 
> > ---
> > V1 -> V2: solution approach was changed from detecting long
> > tickless periods
> > to frequency invariant measurements on housekeeping cpus only.
> > Link: ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com
> > ---
> >  kernel/sched/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index daff72f00385..1bb0a840c817 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5469,7 +5469,9 @@ void scheduler_tick(void)
> >  	unsigned long thermal_pressure;
> >  	u64 resched_latency;
> >  
> > -	arch_scale_freq_tick();
> > +	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
> > +		arch_scale_freq_tick();
> > +
> >  	sched_clock_tick();
> >  
> >  	rq_lock(rq, &rf);

