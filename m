Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B467AB23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjAYHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjAYHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483A3E602
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkeMwblj9hneaBAEGr4WY7HayLEL2jAXC1+f00C91Gc=;
        b=D55in57+dfVx+b3hsu9cJ8GuE4f5DkvXn3Z3zPNI1dOx5iqaiNkoANP2R+O7ESKIvDVDeo
        Q5drRJOHFH4uXKdh3V6HuAqlBff0WPDvwAkg6J2Txx1lJGVDFNAgN3qhY5EvSEQzXPHSYr
        4o+3AHgKtPNJhfGTDa77oaUZ4t+qJ1A=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-WD6zasTPNOW0le8QdAWCTA-1; Wed, 25 Jan 2023 02:44:23 -0500
X-MC-Unique: WD6zasTPNOW0le8QdAWCTA-1
Received: by mail-oo1-f69.google.com with SMTP id f6-20020a4aeb06000000b00510ebf9a906so580292ooj.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkeMwblj9hneaBAEGr4WY7HayLEL2jAXC1+f00C91Gc=;
        b=I00CxJ8H8CbRi63Gq6y9hGZCwG2Z+S3T4eA917/eggPWIkH3GvlMDCtiCrveAg5y/u
         TUnhkBdVypgciWRAoUZTnump4eXH7G+NhUpMMM9oaiRXV5KSqTnwtFhWR1O4r/53G39G
         JrqW/MYYkI/F98sizt9GK80AeEgHH7mpiA/d4BMuJlmlCyEUj/4iyNHH5i4M1UaoHlsF
         wft3tC1dfBiuiGG73ZDStz3N9+nwgxG2+lJIUico16u6at2Fj23qzIGDwhXqmvvtYHD6
         JI5GneFUU0Ta1p/wDqWMY1z5WOoQXpWxqbz5UaBRUIpACt1VAL2gp6KnIixcTTuS1bNn
         A+5A==
X-Gm-Message-State: AFqh2kqz5OeKzt1uOAYI/AzvEmZUaw8I6x6X6rgQlaAsoRKS7/1yPlu6
        iVD+8HPG/OchLFt4VNgCN0bV5Xc9w9akXkEOzEPZ19/691t6i5JFIPyaF2dqd5elg4IX3YNANP7
        rZZuVzLDoJqm1d4nB/DQ+yaSh
X-Received: by 2002:a05:6870:4288:b0:15e:e50c:1813 with SMTP id y8-20020a056870428800b0015ee50c1813mr17604043oah.55.1674632662615;
        Tue, 24 Jan 2023 23:44:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsmOOC0na3goHYTCuYUR80h3zsrixqTPIdufe5WuJ2AFLGjawvqUoIdakZTwJYrZcPAxvXVeg==
X-Received: by 2002:a05:6870:4288:b0:15e:e50c:1813 with SMTP id y8-20020a056870428800b0015ee50c1813mr17604031oah.55.1674632662379;
        Tue, 24 Jan 2023 23:44:22 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:14fa:9361:c141:6c70:c877? ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id p9-20020a4ad449000000b004fb2935d0e7sm1574351oos.36.2023.01.24.23.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:44:21 -0800 (PST)
Message-ID: <958969c204e1041dead005d1c801cf3c54ab86f1.camel@redhat.com>
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Date:   Wed, 25 Jan 2023 04:44:12 -0300
In-Reply-To: <Y2tfSAgt/lBVcdvf@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
         <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
         <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
         <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
         <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
         <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
         <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
         <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
         <4a4a6c73f3776d65f70f7ca92eb26fc90ed3d51a.camel@redhat.com>
         <Y2tfSAgt/lBVcdvf@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 09:05 +0100, Michal Hocko wrote:
> On Tue 08-11-22 20:09:25, Leonardo Br=C3=A1s wrote:
> [...]
> > > Yes, with a notable difference that with your spin lock option there =
is
> > > still a chance that the remote draining could influence the isolated =
CPU
> > > workload throug that said spinlock. If there is no pcp cache for that
> > > cpu being used then there is no potential interaction at all.
> >=20
> > I see.=20
> > But the slow path is slow for some reason, right?
> > Does not it make use of any locks also? So on normal operation there co=
uld be a
> > potentially larger impact than a spinlock, even though there would be n=
o
> > scheduled draining.
>=20
> Well, for the regular (try_charge) path that is essentially page_counter_=
try_charge
> which boils down to atomic_long_add_return of the memcg counter + all
> parents up the hierarchy and high memory limit evaluation (essentially 2
> atomic_reads for the memcg + all parents up the hierchy). That is not
> whole of a lot - especially when the memcg hierarchy is not very deep.
>=20
> Per cpu batch amortizes those per hierarchy updates as well as atomic
> operations + cache lines bouncing on updates.
>=20
> On the other hand spinlock would do the unconditional atomic updates as
> well and even much more on CONFIG_RT. A plus is that the update will be
> mostly local so cache line bouncing shouldn't be terrible. Unless
> somebody heavily triggers pcp cache draining but this shouldn't be all
> that common (e.g. when a memcg triggers its limit.
>=20
> All that being said, I am still not convinced that the pcp cache bypass
> for isolated CPUs would make a dramatic difference. Especially in the
> context of workloads that tend to run on isolated CPUs and rarely enter
> kernel.
> =20
> > > It is true true that appart from user
> > > space memory which can be under full control of the userspace there a=
re
> > > kernel allocations which can be done on behalf of the process and tho=
se
> > > could be charged to memcg as well. So I can imagine the pcp cache cou=
ld
> > > be populated even if the process is not faulting anything in during R=
T
> > > sensitive phase.
> >=20
> > Humm, I think I will apply the change and do a comparative testing with
> > upstream. This should bring good comparison results.
>=20
> That would be certainly appreciated!
>  (
> > > > On the other hand, compared to how it works now now, this should be=
 a more
> > > > controllable way of introducing latency than a scheduled cache drai=
n.
> > > >=20
> > > > Your suggestion on no-stocks/caches in isolated CPUs would be great=
 for
> > > > predictability, but I am almost sure the cost in overall performanc=
e would not
> > > > be fine.
> > >=20
> > > It is hard to estimate the overhead without measuring that. Do you th=
ink
> > > you can give it a try? If the performance is not really acceptable
> > > (which I would be really surprised) then we can think of a more compl=
ex
> > > solution.
> >=20
> > Sure, I can try that.
> > Do you suggest any specific workload that happens to stress the percpu =
cache
> > usage, with usual drains and so? Maybe I will also try with synthetic w=
orloads
> > also.
>=20
> I really think you want to test it on the isolcpu aware workload.
> Artificial benchmark are not all that useful in this context.

Hello Michael,
I just sent a v2 for this patchset with a lot of changes.
https://lore.kernel.org/lkml/20230125073502.743446-1-leobras@redhat.com/

I have tried to gather some data on the performance numbers as suggested, b=
ut I
got carried away and the cover letter ended up too big. I hope it's not too=
 much
trouble.

Best regards,
Leo



