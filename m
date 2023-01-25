Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A767BFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjAYWVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAYWVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:21:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118D5C0F3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:21:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 7so14415965pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvSZMfSpkQLGS9MrpGffKM3yb4DkNyW1TJfAGKrHgX0=;
        b=nLAng2WZmQ8ZVuNOvp0AhngglLvxaXpMFSou9FGKJXd30q6RiJeR0f9Bnsuhf5FbXI
         evElinEXzsCaQxVZXm/8gaIL2qenSQH3GjfVdsuRox2WNl/WPPJZWDbjJgQBmH2Ahz38
         XruSrI4Phm/qS09MDsBude7NuxXrAm7zGnyvPk1DZwr6fXUtO1tmtcpajE4hmYJkCxvc
         6nyOeH14EmNNDFCQD/HQ2XGkZS9NtST7g7O4zVeF2X6P/tNUTWNmSzfkpiX1NlGi8MbZ
         sBfT2YWHwgQhmuZWlhIOtXzEcWpbkY6JYUOMrjglaAg/Feme+H1YgFBxrsm+NlN/aN2P
         uGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvSZMfSpkQLGS9MrpGffKM3yb4DkNyW1TJfAGKrHgX0=;
        b=dvV+YWt8lnUpHHP9KqlxKkSuLmLCOGrCaDhdYIdJrO0jYkts5GGCqapUH9DWseLT3U
         vaEXmSHBp6B/a1iK1AuWR6Iu7ZdjyZVNLh2Ux2qhSDpIKmjNEf5I3EFmPX/UTn85lY4S
         1HeIaaImQIRCd9EPP4yvgw6RdI07LPOUflF4FR18PuqBxMAsGWkfWxvllZ3CR4eU8tke
         P4zfvD04Lf8b04g4Nw0j4alrg3Otf0LFkRF92sP8THtHb2bUGnaBXKdbcxFsQch7aegM
         Zb/Z0ecPpG5PbsfAvc3xP78pgVRdWsji98KA6bpBhtqBRVtRwocfbEdRgxuOjRMAL5n3
         BPBg==
X-Gm-Message-State: AO0yUKUTUn79TULFt243stizHAuINhCUeTYTPn0kh+2tERjgAkx4bb35
        LNAG5y0u+3intCilD6FI8Y8=
X-Google-Smtp-Source: AK7set/FMcVPsCh06RKDBW4N6JJhhhCVMx22Oa85mO4XIhFgGXNFUGX0rCsMqTDeN+R52Kx5VMtlAg==
X-Received: by 2002:a05:6a00:1311:b0:590:7558:613c with SMTP id j17-20020a056a00131100b005907558613cmr1692282pfu.21.1674685297726;
        Wed, 25 Jan 2023 14:21:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ff6:fb01:3677:2696])
        by smtp.gmail.com with ESMTPSA id x12-20020aa793ac000000b005898fcb7c2bsm4277118pff.170.2023.01.25.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:21:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 25 Jan 2023 14:21:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9Grb2rggptkCu+n@google.com>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:37:59PM +0100, Michal Hocko wrote:
> On Wed 25-01-23 10:07:49, Minchan Kim wrote:
> > On Wed, Jan 25, 2023 at 06:07:00PM +0100, Michal Hocko wrote:
> > > On Wed 25-01-23 08:36:02, Minchan Kim wrote:
> > > > On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> > > > > On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > > > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > > > present pages at page table and provides advice hints for them.
> > > > > > 
> > > > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > > > shows the proactive reclaim efficiency so this patch adds those
> > > > > > two statistics in vmstat.
> > > > > > 
> > > > > > 	madvise_pgscanned, madvise_pghinted
> > > > > > 
> > > > > > Since proactive reclaim using process_madvise(2) as userland
> > > > > > memory policy is popular(e.g,. Android ActivityManagerService),
> > > > > > those stats are helpful to know how efficiently the policy works
> > > > > > well.
> > > > > 
> > > > > The usecase description is still too vague. What are those values useful
> > > > > for? Is there anything actionable based on those numbers? How do you
> > > > > deal with multiple parties using madvise resp. process_madvise so that
> > > > > their stats are combined?
> > > > 
> > > > The metric helps monitoing system MM health under fleet and experimental
> > > > tuning with diffrent policies from the centralized userland memory daemon.
> > > 
> > > That is just too vague for me to imagine anything more specific then, we
> > > have numbers and we can show them in a report. What does it actually
> > > mean that madvise_pgscanned is high. Or that pghinted / pgscanned is
> > > low (that you tend to manually reclaim sparse mappings)?
> > 
> > If that's low, it means the userspace daemon's current tune/policy are
> > inefficient or too aggressive since it is working on address spacess
> > of processes which don't have enough memory the hint can work(e.g.,
> > shared addresses, cold address ranges or some special address ranges like
> > VM_PFNMAP) so sometime, we can detect regression to find culprit or
> > have a chance to look into better ideas to improve.
> 
> Are you sure this is really meaningful metric? Just consider a large and
> sparsely populated mapping. This can be a perfect candidate for user
> space reclaim target (e.g. consider a mapping covering a large matrix
> or other similar data structure). pghinted/pgscanned would be really
> small while the reclaim efficiency could be quite high in that case,
> wouldn't it?

Why do you think it's efficient? It need to spend quite CPU cycle to
scan a few of pages to evict. I don't see it's efficient if it happens
quite a lot.
