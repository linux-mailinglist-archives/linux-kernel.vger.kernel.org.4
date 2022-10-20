Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365160613E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJTNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiJTNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DDE17E207
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666271447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVYAKNZFP9AvH/lbqEre4C8lrF1P3191ZtQza+s/jZc=;
        b=TntW3JBopo5wc712o9aj38miMHP/U5w6OqdBcVwEVoL8V0fzUa66x4HvdQkPdQcA9vB9LX
        49y8s4kNxMMJLnrszY/jfJLHi4VNPRWA8IwvK7Vjcy7O2C3oJgyyXbwEt2UApFglczwBfg
        +Sf1WZtK6SX/Wc3uPoL3Yih8rHBj0Yw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-fePzNGN5PSCNXnXhA4mp7g-1; Thu, 20 Oct 2022 09:10:46 -0400
X-MC-Unique: fePzNGN5PSCNXnXhA4mp7g-1
Received: by mail-qv1-f71.google.com with SMTP id kr13-20020a0562142b8d00b004b1d5953a2cso12649678qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVYAKNZFP9AvH/lbqEre4C8lrF1P3191ZtQza+s/jZc=;
        b=WtV6jW14Lc8L6N18wFr6jz3PYASe1LXDWjxnpzNXtSawAPL7HlRdPnnStqKWMDfL25
         5E2A+toYw9KCghDXC/Mds/e5GLdu5Upo2BgWKoFLmNGtF/TcRvL77h4XHcgc+n7SGj7e
         wa3ZE/FnDfW+v75aWO4h0WHi+LvF5yafQ1EvPSH7589hDeuoGKPRZ2lJUO9fccaQ3Mdd
         eQ/chgIcLoDRcxTku4iIIF/+IMUhj+YnZtxuwITicZdMv6jaYLIClRN3ZsDo50i9IhiZ
         eqd607NIVT+7HIZ4+N2BXnjkRn2fwxAkKiHvDqK4i1d9pymH63PKh0TYIVAO/dKl7qLl
         kPzg==
X-Gm-Message-State: ACrzQf2l9Y+4dXyh1s7l8OutP6QzPiNH+C3WZMa0UnuEPM45u2MYZzO8
        3sY/WPlQlFR3O+suQ3f7QWq/9hA50OSCjWY7dlWjs0QmIjWnu/HRC4/rPgsmA1oSLvalhT7FyAc
        0Mw9B35O3oKoQoCF90+OSDILy
X-Received: by 2002:a05:620a:c85:b0:6ee:6fcf:cd45 with SMTP id q5-20020a05620a0c8500b006ee6fcfcd45mr9001224qki.595.1666271445449;
        Thu, 20 Oct 2022 06:10:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5b8Gfudw+r9XpzKAnmPFkCrMpX4DqBO/63iWv15JJhemCsFP2jxIbmP01iUo9bHb2P+HKyxQ==
X-Received: by 2002:a05:620a:c85:b0:6ee:6fcf:cd45 with SMTP id q5-20020a05620a0c8500b006ee6fcfcd45mr9001201qki.595.1666271445158;
        Thu, 20 Oct 2022 06:10:45 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id y21-20020a37e315000000b006ecb3694163sm6934979qki.95.2022.10.20.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:10:44 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:10:48 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH] mm/huge_memory: Do not clobber swp_entry_t during
 THP split
Message-ID: <Y1FI2HjBMlk5bDnp@bfoster>
References: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
 <CAHbLzkras5SV95-J4r=nbGx5u_5JS2u8KG=23hzVvFBqCnMA5g@mail.gmail.com>
 <20221019161810.7510df1f37658a2b71c5e3a7@linux-foundation.org>
 <20221020085214.7pgvylgxkojbiuat@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020085214.7pgvylgxkojbiuat@techsingularity.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Kirill

On Thu, Oct 20, 2022 at 09:52:14AM +0100, Mel Gorman wrote:
> Adding Brian to cc
> 
> On Wed, Oct 19, 2022 at 04:18:10PM -0700, Andrew Morton wrote:
> > On Wed, 19 Oct 2022 11:17:14 -0700 Yang Shi <shy828301@gmail.com> wrote:
> > 
> > > > The intent of commit b653db77350c patch was to avoid the case where
> > > > PG_private is clear but folio->private is not-NULL. However, THP tail
> > > > pages uses page->private for "swp_entry_t if folio_test_swapcache()" as
> > > > stated in the documentation for struct folio. This patch only clobbers
> > > > page->private for tail pages if the head page was not in swapcache and
> > > > warns once if page->private had an unexpected value.
> > > 
> > > It looks like the same issue fixed by
> > > https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/
> > 
> > It is.
> > 
> 
> Yep, based on Brian's changelog, it was the same workload that triggered
> it as it happens to stress the corner case that hits the bug. 
> 
> > As I asked earlier this week, what about reverting b653db77350c?  Why
> > do we care about the value of ->private for non-PG_private pages?
> 
> I don't think we do care but based on the changelog of b653db77350c, it's
> part of an effort to either remove the PG_private bit or is a preparation
> step for casting page to a meaningful type based on context but only Matthew
> can tell us his motivation. There at least is some value to identifying
> cases where a referenced page has valid information in page->private that
> is not reflected in the flags.
> 

Thanks.

It would have been nice to have received some feedback on the patch I
had posted 6 weeks or so ago ;), but regardless yours is better and
includes the comment Kirill asked for (and also appears to be added to
the hotfixes tree), so FWIW:

Acked-by: Brian Foster <bfoster@redhat.com>

> -- 
> Mel Gorman
> SUSE Labs
> 

