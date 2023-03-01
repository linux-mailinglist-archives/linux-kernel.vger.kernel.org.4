Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD986A66D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCADzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCADzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:55:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DF28207
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:55:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11371626pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxXNGS30xbDsiSrnP4eiOcS4VTFoXH2EtjdLkfq37fw=;
        b=c0J1/NU4C1p2MxCz+gBaYYJQLAZIuLePvgiforWM9hGguJNr9GIviOO9PFuqkkokPd
         TJ7QXLyslj1N5fnbffE+++FDraYmb1b0KZTWP7zizhSI/8D7zrvVOMaihPQaDme6X1ZO
         yudS0mLC3ejuw0EHp9HOdbryGX8ioDq0SDuxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxXNGS30xbDsiSrnP4eiOcS4VTFoXH2EtjdLkfq37fw=;
        b=igsmqtB46qvzXA8lKCnKFiJe1gJgRAss4OnYHLy2sLPv6wQEsmomuVA33GuCY2UnFU
         JDjCRjDo3QPJnwpg33qKN4mdUVPh4QaPTcuNdX/VCAuwIriVjv/J5nZ/RPr47p4l4WgB
         ee8csITnVOMJ2wX2C7ijYtofe8FYZfo2Wd6GRMwxsqE7uKa40TZE2MEd/00G35KXNeSr
         SJdvCLCNmtGNN0EAlWYUk1/YHVApT7iSG3zUJ+BPs3uS6aWzyUIlf7c5DgjGGDbVFm5B
         HovxiBI9zahNejpbl4wCpguUCq+WV0V/FauwlgTaAo+TA4JvJJBi/VODlnMu50Vjz39V
         gCIg==
X-Gm-Message-State: AO0yUKX9/wvS/Mq3wsPBexOoHd8ZBvTr2xaO5OFtDIaRhWwWbqp9ome9
        e9yr8L2Txu3UQjVPCjQnXun36N4h2pBQ53hR
X-Google-Smtp-Source: AK7set/dibQGpnJXukAG07B/Aq07DluLOU8RyRB+i3Rlm4VMIo7dGNQeNpqZXMGsHs/9/SRKKVfVhA==
X-Received: by 2002:a05:6a20:8f04:b0:cc:9ca2:8b5f with SMTP id b4-20020a056a208f0400b000cc9ca28b5fmr6830196pzk.15.1677642900774;
        Tue, 28 Feb 2023 19:55:00 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78689000000b005898fcb7c1bsm7000864pfo.177.2023.02.28.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:55:00 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:54:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <Y/7MkLdVXImxPQeJ@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
 <Y/f75fkcQg6m3cbG@google.com>
 <Y/rYQdUDNHDCJJTO@google.com>
 <Y/5+PEfuEl3b/sDR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/5+PEfuEl3b/sDR@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/28 14:20), Minchan Kim wrote:
> On Sun, Feb 26, 2023 at 12:55:45PM +0900, Sergey Senozhatsky wrote:
> > On (23/02/23 15:51), Minchan Kim wrote:
> > > On Thu, Feb 23, 2023 at 12:04:50PM +0900, Sergey Senozhatsky wrote:
> > > > Extend zsmalloc zs_pool_stats with a new member that
> > > > holds the number of objects pool compaction moved
> > > > between pool pages.
> > > 
> > > I totally understand this new stat would be very useful for your
> > > development but not sure it's really useful for workload tune or
> > > monitoring.
> > > 
> > > Unless we have strong usecase, I'd like to avoid new stat.
> > 
> > The way I see is that it *can* give some interesting additional data to
> > periodical compaction (the one is not triggeed by the shrinker): if the
> > number of moves objects is relatively high but the number of comapcted
> > (feeed) pages is relatively low then the system has fragmentation in
> > small size classes (that tend to have many objects per zspage but not
> > too many pages per zspage) and in this case the interval between
> > periodical compactions probably can be increased. What do you think?
> 
> In the case, how could we get only data triggered by periodical munual
> compaction?

Something very simple like

	read zram mm_stat
	trigger comapction
	read zram mm_stat

can work in most cases, I guess. There can be memory pressure
and shrinkers can compact the pool concurrently, in which case
mm_stat will include shrinker impact, but that's probably not
a problem. If system is under memory pressure then user space
in general does not have to do comapction, since the kernel will
handle it.

Just an idea. It feels like "pages compacted" on its own tells very
little, but I don't insist on exporting that new stat.
