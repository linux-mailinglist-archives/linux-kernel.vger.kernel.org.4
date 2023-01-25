Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871ED67B6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjAYQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:36:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2336471
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:36:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so2591624pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gjeuMBJi0E7usVDBoVD4pYljRyA65e2p6zLRcXsT+M=;
        b=VXfFN2sKcuFtMkOJIK8FnEGx1n1jbrqkbh8aiLnDr08t3pVR2Keo1+ky3+1H/44+b2
         eRQWoH3l8g+sCNxO1r9nyIQRntey7cVzUGkrWAkaLOOnS3v6iFiLwyXaQhvjwYvNdZdG
         Wt+vTb0tP8Loz9+o+otoPbL5JEk2/TzH3omkxZ1Ubc3BqOWQK2rSfos5PIrtxmTxfInx
         x3xdcvxy9EUSgMCN6cvrL0IEVvRTEVQdtP8Q0scW/C7FomOwfJrLsZvdnoRQw6QSl/HS
         1qliWz0eL4QenyVdz/GnuP6mNdcxuFQx280g0JM0VqiS98AB/AQTasu/oKuNUvsUHDE/
         C0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gjeuMBJi0E7usVDBoVD4pYljRyA65e2p6zLRcXsT+M=;
        b=iji2hhPe+r/t5/eNuEcvUlXhQhhOfSIOOwAS4jOnN2/ALV3ireJCO+jiHjZUoCFPDz
         nW2XUOpkCtxZhUojLQ/44pYhgJK9pVPTwX7pKiK2C6hxeWZ7dfhSx2gnPNIK03aoMhop
         rlPh5MdfTo/eWMMssOkTBxBmK5USg1UwLch08qGDvsIuqWWTE4Dnj1SWgdbxzaObDlQj
         rEghym5JPeU8ktiowMT6CMpWyBmKy9gvI6mObVat6t0TY01Ls5JIvw1FhbvpRji17Q1y
         br0F9KnNOHAxhIWLqISSgQeMT1HncO4pozTXyTiIZthCyOGpKXqXJ7MYrzMxK1QoUA5n
         YwEw==
X-Gm-Message-State: AO0yUKXnDXyEMwE4cbhe3PlKiJ5lBGakIf0pYQqjbh3pWJCw/mRXF1UR
        PjYClPZsFt8cpu+myh1nmGXxwuUu8zU=
X-Google-Smtp-Source: AK7set/i3ZvdzEaAJdLRUPlgempqiPaRSIpBTyT+N/jDTUIKj0/ls1/6tauzQhTnyOnat1LPlgKejQ==
X-Received: by 2002:a17:902:e848:b0:196:32fa:6993 with SMTP id t8-20020a170902e84800b0019632fa6993mr1749025plg.66.1674664564769;
        Wed, 25 Jan 2023 08:36:04 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ff6:fb01:3677:2696])
        by smtp.gmail.com with ESMTPSA id p18-20020a63b812000000b004cf643a425asm3385177pge.61.2023.01.25.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:36:04 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Jan 2023 08:36:02 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9FacrcUIaLZq4DL@google.com>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9DigKf0w712t0OO@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > madvise LRU manipulation APIs need to scan address ranges to find
> > present pages at page table and provides advice hints for them.
> > 
> > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > shows the proactive reclaim efficiency so this patch adds those
> > two statistics in vmstat.
> > 
> > 	madvise_pgscanned, madvise_pghinted
> > 
> > Since proactive reclaim using process_madvise(2) as userland
> > memory policy is popular(e.g,. Android ActivityManagerService),
> > those stats are helpful to know how efficiently the policy works
> > well.
> 
> The usecase description is still too vague. What are those values useful
> for? Is there anything actionable based on those numbers? How do you
> deal with multiple parties using madvise resp. process_madvise so that
> their stats are combined?

The metric helps monitoing system MM health under fleet and experimental
tuning with diffrent policies from the centralized userland memory daemon.
That's really good fit under vmstat along with other MM metrics.

> 
> In the previous version I have also pointed out that this might be
> easily achieved by tracepoints. Your counterargument was a convenience
> in a large scale monitoring without going much into details. Presumably
> this is because your fleet based monitoring already collects
> /proc/vmstat while tracepoints based monitoring would require additional
> changes. This alone is rather weak argument to be honest because
> deploying tracepoints monitoring is quite trivial and can be done
> outside of the said memory reclaim agent.

The convenience matters but that's not my argument. 

Ithink using tracepoint for system metric makes no sense even though
the tracepoint could be extended by using bpf or histogram trigger to
get the accumulated counters for system metric.

The tracepoint is the next step if we want to know further breakdown
once something strange happens. That's why we have separate level metric
system to narrow problem down rather than implementing all the metric
with tracepoint. Please, look at vmstat fields. Almost every fields
would have same question you asked "how do you break down if multiple
processes were invovled to contribute the metric?"

I am fine if you suggest adding tracepoint as well as the vmstat fields
for further breakdown but only relying on tracepoint and frineds for
system global metric doesn't make sense.
