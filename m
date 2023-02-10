Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E520692438
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjBJRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjBJROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878F7A7D5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676049158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7luEvPkWujB4zxIctqB6JQjV0VaIW6RHVMIPA6fiA0=;
        b=K0twe8UhqrtThlfyGAD8IqGPPpv9nZb92aXSAs6SZCTC2Cz2GagEcZrTc0OLPJrR7BnSxG
        Ea4e022pioO3XaOy8q9daHeAg/c38YhZcc5saigQKsAUOw6YIlbFi0kdluhzMHyq+QElyM
        OTMpgbNRJQ+nEXEtw898z2wuswqGNJw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-4_r_uK7POF-xaOcQuBQwLw-1; Fri, 10 Feb 2023 12:12:35 -0500
X-MC-Unique: 4_r_uK7POF-xaOcQuBQwLw-1
Received: by mail-qv1-f70.google.com with SMTP id k15-20020a0cd68f000000b00535261af1b1so3514829qvi.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7luEvPkWujB4zxIctqB6JQjV0VaIW6RHVMIPA6fiA0=;
        b=AUKGRZ4xx+0Cjk03Z18nPiklmSXpuI+TgmwjizuevTs9egy+TJrlibvvJbL85C8g47
         he4T1MIY7IftqrMoytCe4ngzKCmb9uyr5+cwu8E117eTtEA/IyXoc7Oyd2dGop2aNVmg
         mAimzYp8r3zAIPFhVkdTntCyNXCEy6PCQ2HW1z1DetkZSIvH1U9L2+QEi3sLE1HGoTI8
         o6ADFerpCYoqlErn9bKfAp3PpQII5Vc65VWYY9SojUdCP5691MpG0OFWiEYNrEGsaHOa
         bJvFnUYuXBsssyELl6JpDuxbkCe2Lmjs9dNGLtkKKmsT/zZCYvpiK8PK7JfyNQqu2Mov
         d9YQ==
X-Gm-Message-State: AO0yUKV2tTr8Q0GaaDQBKbyR3sn0aGEm7IkoJf9hjwsIoAhJeZDhDEhJ
        ZjO7e7LFiIDQUY6oYjqMnWjIvCaERJ/IjqgenyKqZpgq3T7KBCbo/Psr+n7wtX0s+2yZ1m7KC6m
        U+0VkT8FcsslvRppMf7TVCEH+
X-Received: by 2002:ac8:57cf:0:b0:3b8:6d70:9fe2 with SMTP id w15-20020ac857cf000000b003b86d709fe2mr26088247qta.59.1676049155020;
        Fri, 10 Feb 2023 09:12:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/hGJjfilDSZ6ODVxm0G+j3wuLje3k02Br3xakiSXYhkJnMSdauBcAOS4vSSs3xZWyEsWvqxg==
X-Received: by 2002:ac8:57cf:0:b0:3b8:6d70:9fe2 with SMTP id w15-20020ac857cf000000b003b86d709fe2mr26088213qta.59.1676049154756;
        Fri, 10 Feb 2023 09:12:34 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id x12-20020ac8700c000000b003b0766cd169sm3769157qtm.2.2023.02.10.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:12:33 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
In-Reply-To: <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
Date:   Fri, 10 Feb 2023 17:12:30 +0000
Message-ID: <xhsmhk00pqwap.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/23 17:53, Peter Zijlstra wrote:
> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
>
>> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
>> its parent), but remove it from the lowest non-degenerated topology level?
>
> So I was rather confused about the whole moving it between levels things
> this morning -- conceptually, prefer siblings says you want to try
> sibling domains before filling up your current domain. Now, balancing
> between siblings happens one level up, hence looking at child->flags
> makes perfect sense.
>
> But looking at the current domain and still calling it prefer sibling
> makes absolutely no sense what so ever.
>

True :-)

> In that confusion I think I also got the polarity wrong, I thought you
> wanted to kill prefer_sibling for the assymetric SMT cases, instead you
> want to force enable it as long as there is one SMT child around.
>
> Whichever way around it we do it, I'm thinking perhaps some renaming
> might be in order to clarify things.
>
> How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
> of the behaviour, but have it be set by children with SD_PREFER_SIBLING
> or something.
>

Or entirely bin SD_PREFER_SIBLING and stick with SD_SPREAD_TASKS, but yeah
something along those lines.

> OTOH, there's also
>
>   if (busiest->group_weight == 1 || sds->prefer_sibling) {
>
> which explicitly also takes the group-of-one (the !child case) into
> account, but that's not consistently done.
>
>       sds->prefer_sibling = !child || child->flags & SD_PREFER_SIBLING;
>
> seems an interesting option,

> except perhaps ASYM_CPUCAPACITY -- I
> forget, can CPUs of different capacity be in the same leaf domain? With
> big.LITTLE I think not, they had their own cache domains and so you get
> at least MC domains per capacity, but DynamiQ might have totally wrecked
> that party.

Yeah, newer systems can have different capacities in one MC domain, cf:

  b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")

>
>> (+ add it to the first NUMA level to keep things as they are, even if TBF I
>> find relying on it for NUMA balancing a bit odd).
>
> Arguably it ought to perhaps be one of those node_reclaim_distance
> things. The thing is that NUMA-1 is often fairly quick, esp. these days
> where it's basically on die numa.

Right, makes sense, thanks.

