Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6C67B900
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjAYSH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:07:54 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD833170A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:07:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g9so1472618pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ph4PmSnV9gkntOR+tyZ2xCVJp+S/HCqBMLy3CJDgIs=;
        b=B3kmlyghCk/Gms0IxSLviaMQ0DunjankOyK8Eu5UcrZS4p1wyq2yl14FLZacrjZE2G
         8cdzM1r37TNyoj91FbTWRCUMrBJjdd4ccgHLtRWBQlrcyduYzeMkC+7ehA9S68ht7NhG
         qheSSmFPYv+VA77ZB7hzF5dUSQ1/pQsI6IFWXduIiCnO0LDUUwgcacUDTcCk4YYN7Ac7
         HfVik+J4gcCTXVUZSgpV++EDqHfKjVY9Md5uT9ThC+5wtAZe6BYyEB8WxRyuquV8q9FT
         t8jiXN/5csYf1O+/yETCpJ45NZ0bZjC3Q9jscyiOfskGEs8mQRG6hOcd1/eDJhEsnMTY
         z4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ph4PmSnV9gkntOR+tyZ2xCVJp+S/HCqBMLy3CJDgIs=;
        b=U3kRbAlei07Hz4Oz4VsiZg2L9Cj+2p6UWXxXJ+JC7xINuv5GjhVn8d4JxgrTPTYGBb
         fAqX4RMPSZWvI/IE1Qcq4QczgwdqSbCjabvhI3LAxXYYJGersTdvlbRqZrDeb6gDfeTz
         ZW0JPgUJiID0J/i2LLFbYYA+GwnGkpHZiq5k6vm8R21ADyWWvVdxXIbVdy4hF3R3mBWj
         fFvv4c4VBVlX5LNQOY8m3wTpfTfO/eM1+dZ5PNo7sSkCsMCNBeVihAaRQZxIwjPIAHkJ
         0FrBCBpRWp7WUBSs6ZgrsOpr5G+jlta8/Z2d+d4dJx/jWWNg/NCpvOyqp8FIdKuUdFHy
         rbxQ==
X-Gm-Message-State: AFqh2kptCRH2arp/HXo2B0DzYJTffXqv3dSM5HV9f7Yxtu1uNHKKFpvj
        LpOz3hAklIycqTTqVNbAalY=
X-Google-Smtp-Source: AMrXdXtLEtRtG8jiGuSCQqHIOY2lrPuHWW5AMyNky68CjwmNYoCK5TuHk0dkIHPXX0GpG4BdqknE2w==
X-Received: by 2002:a05:6a00:8b:b0:582:b8e0:bc54 with SMTP id c11-20020a056a00008b00b00582b8e0bc54mr32598193pfj.21.1674670072054;
        Wed, 25 Jan 2023 10:07:52 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ff6:fb01:3677:2696])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00224600b00589ed7ae132sm2585300pfu.13.2023.01.25.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:07:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Jan 2023 10:07:49 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9Fv9YnNn7bHvLkN@google.com>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:07:00PM +0100, Michal Hocko wrote:
> On Wed 25-01-23 08:36:02, Minchan Kim wrote:
> > On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> > > On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > present pages at page table and provides advice hints for them.
> > > > 
> > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > shows the proactive reclaim efficiency so this patch adds those
> > > > two statistics in vmstat.
> > > > 
> > > > 	madvise_pgscanned, madvise_pghinted
> > > > 
> > > > Since proactive reclaim using process_madvise(2) as userland
> > > > memory policy is popular(e.g,. Android ActivityManagerService),
> > > > those stats are helpful to know how efficiently the policy works
> > > > well.
> > > 
> > > The usecase description is still too vague. What are those values useful
> > > for? Is there anything actionable based on those numbers? How do you
> > > deal with multiple parties using madvise resp. process_madvise so that
> > > their stats are combined?
> > 
> > The metric helps monitoing system MM health under fleet and experimental
> > tuning with diffrent policies from the centralized userland memory daemon.
> 
> That is just too vague for me to imagine anything more specific then, we
> have numbers and we can show them in a report. What does it actually
> mean that madvise_pgscanned is high. Or that pghinted / pgscanned is
> low (that you tend to manually reclaim sparse mappings)?

If that's low, it means the userspace daemon's current tune/policy are
inefficient or too aggressive since it is working on address spacess
of processes which don't have enough memory the hint can work(e.g.,
shared addresses, cold address ranges or some special address ranges like
VM_PFNMAP) so sometime, we can detect regression to find culprit or
have a chance to look into better ideas to improve.

> 
> > That's really good fit under vmstat along with other MM metrics.
> > 
> > > 
> > > In the previous version I have also pointed out that this might be
> > > easily achieved by tracepoints. Your counterargument was a convenience
> > > in a large scale monitoring without going much into details. Presumably
> > > this is because your fleet based monitoring already collects
> > > /proc/vmstat while tracepoints based monitoring would require additional
> > > changes. This alone is rather weak argument to be honest because
> > > deploying tracepoints monitoring is quite trivial and can be done
> > > outside of the said memory reclaim agent.
> > 
> > The convenience matters but that's not my argument. 
> > 
> > Ithink using tracepoint for system metric makes no sense even though
> > the tracepoint could be extended by using bpf or histogram trigger to
> > get the accumulated counters for system metric.
> 
> System wide metrics data collection by ftrace is a common use case. I
> really do not follow your argument here. There are certainly cases where
> ftrace is suboptimal solution - e.g. when the cumulative data couldn't
> have been collected early on for one reason or another (e.g. system
> uptime is already high when you decide to start collecting). But you
> have stated there is data collection happening so what does prevent
> collecting this just along with anything else.
>  
> > The tracepoint is the next step if we want to know further breakdown
> > once something strange happens. That's why we have separate level metric
> > system to narrow problem down rather than implementing all the metric
> > with tracepoint. Please, look at vmstat fields. Almost every fields
> > would have same question you asked "how do you break down if multiple
> > processes were invovled to contribute the metric?"
> 
> Yes, we tended to be much more willing to add counters. Partly because
> runtime debugging capabilities were not that great in the past as we
> have these days.
> 
> > I am fine if you suggest adding tracepoint as well as the vmstat fields
> > for further breakdown but only relying on tracepoint and frineds for
> > system global metric doesn't make sense.
> 
> We have to agree to disagree here. I am not going to nack this but I
> disagree with this patch because the justification is just too vague and
> also those numbers cannot really be attributed to anybody performing
> madvise to actually evaluate that activity.
> -- 
> Michal Hocko
> SUSE Labs
