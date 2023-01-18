Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA16725A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARRzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:55:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673124AA55
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:55:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b10so5077282pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYGzASaMgdQyU1ai4B9HmCaBD8gCFtuFaG8+LyR//88=;
        b=lnKfyPJGbs8A+mCtmrZjqEM/BcBIseTpfRe2r6p5gq1nxsUqBbpk0jWG+GimPdv/rD
         jOsHkFfECEUpSfGJEJYTeEXS1L1FbKiHmE0XozSU2mS1f1TduHHJaQknLrZgRv+jQ5+l
         aVABAzOPPD8cgIrPTJ17FFGRhSbLhwJsWhw/WG70pWcgnVTCdbYJ5V49lRir9xiOutnM
         SXi54/x+ixBN9lK7fomTV3OQaQ2+lPzKhKMLJGeHb9Ye5lyoqve/qNarwfY13mLRv7Yt
         zA/e5ZTfysgQKZneOzzrNoidE5toxgeB4dZHeJ/sB6iHoThV9a9QopCoFPCURZrdjrNN
         HzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYGzASaMgdQyU1ai4B9HmCaBD8gCFtuFaG8+LyR//88=;
        b=aOBuodkBJjikdfUrkmh0H/hEHnFw+NxRhaI4RPi0s0roYwVjqZ4rMsc4P3jy6VJwSE
         eY+3aXBJUierL2+VkIqCUWXCk4H9J9z1IAtuSzmM7jocZvl1jmohlH6XKcI/bN6mJOef
         QlkDnWqY2wyMpqNg9Bcrqhv/uFVa4j5hl7rNMxszSeHR28K+lVsSibsS/UHti4pOmDUQ
         SpHIc12a52kAqMuNDKmnc4e2UjfWOHUFw40s8xzpYXZ6/5cSXO6XBqyDfD4RdOCnz6Hi
         1ghLcBqsEgRItKs1ZYsFN9fJ4RAFZolVrQXJeU+v/10dtSbfXyjtRVLQcP5agJ6L4ro3
         HuUA==
X-Gm-Message-State: AFqh2kqFamCJK85yybf8ZhYEtnIweNKghYvI40N8ZEapgNlfBpWxEhct
        O/rHljMfM+YH4hfbZo5p9Gg=
X-Google-Smtp-Source: AMrXdXsqg/OuflhDxILeOg/AYcDPGwOirg6fqeC9y4S4JCW4FxxYz6rhoSzTduz7Hkz1P+MrBfsjcw==
X-Received: by 2002:a05:6a20:cf62:b0:b8:775b:2caa with SMTP id hz34-20020a056a20cf6200b000b8775b2caamr6943557pzb.42.1674064540858;
        Wed, 18 Jan 2023 09:55:40 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id q145-20020a632a97000000b004a4f24fbce9sm19174361pgq.5.2023.01.18.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:55:40 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 09:55:38 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8gympFAnomQePGD@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
 <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
 <Y8gpNgkwMqVPN7dm@google.com>
 <Y8gr5haAMtQJJSR6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gr5haAMtQJJSR6@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:27:02PM +0100, Michal Hocko wrote:
> On Wed 18-01-23 09:15:34, Minchan Kim wrote:
> > On Wed, Jan 18, 2023 at 10:11:46AM +0100, Michal Hocko wrote:
> > > On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > present pages at page table and provides advice hints for them.
> > > > 
> > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > shows the proactive reclaim efficiency so this patch addes those
> > > > two statistics in vmstat.
> > > 
> > > Please describe the usecase for those new counters.
> > 
> > I wanted to know the proactive reclaim efficieny using MADV_COLD/MDDV_PAGEOUT.
> > Userspace has several policy which when/which vmas need to be hinted by the call
> > and they are evolving. I needed to know how effectively their policy works since
> > the vma ranges are huge(i.e., nr_hinted/nr_scanned).
> 
> I can see how that can be an interesting information but is there
> anything actionable about that beyond debugging purposes? In other words
> isn't this something that could be done by tracing instead?

That's the statictis for telemetry. With those stat, we are collecting
various vmstat fields(i.e., pgsteal/pgscan) from real field devices
and thought those two stats would be good fit along with other reclaim
statistics in vmstat since we can know how much proactive madvise policy
could make system healthier(e.g., less kswapd scan, less allocstall
and so on).

> 
> Also how are you going to identify specific madvise calls when they can
> interleave arbitrarily?

I guess you are talking about how we could separate MADV_PAGEOUT and
MADV_COLD from vmstat. That's valid question. I thought for the start,
adds just umbrella stat like this and if we want to break down, we need
to introudce sysfs likewise slab. 
