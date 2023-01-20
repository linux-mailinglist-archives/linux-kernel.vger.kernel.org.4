Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD0675D22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjATSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjATSxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4FB771
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674240756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLA0P2Oo0NSyC29FxsEUtLQkfAdXpwLv+bHSoAALBfc=;
        b=NsxQIerPoAxO4tTnJVEdHv8B1GNgwZxd61CI3zbQUlE+0xQ+LmliRD5x2BVd8xbMaKpJiQ
        c14HNFBpzSRhkqPNjwLEYq3j0Jua/n6HVSeBgkTyu6AmkynXHpunFen0GGR9GXWEy+MW6f
        r0mvxOjH8npBCG0jc5C4+AWT15uc+r4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-ngM-D7yoNP2JDxTVX0VeAA-1; Fri, 20 Jan 2023 13:52:35 -0500
X-MC-Unique: ngM-D7yoNP2JDxTVX0VeAA-1
Received: by mail-qv1-f72.google.com with SMTP id lv8-20020a056214578800b0053477624294so2890987qvb.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLA0P2Oo0NSyC29FxsEUtLQkfAdXpwLv+bHSoAALBfc=;
        b=qLaJKkEiDENYqCmAzjIELsxxzl8/BZLisW/HfmL/l5oUe8ouVFwm3btdc0jRVCVXt5
         jZ57z8TPFEeTebK0CT2tfhV+4JZs7MS7EQ84DgIKI8PndMTEUPxxZGe6j6zJgA3EGz/G
         ifpBnGkD5SJL7cCEQithcojHE3GEjDkFmRNqKmsh0H/nZIvetm4tPi7mVD+FGxY7+v12
         qLu5T0OHCwQts35/TQV832ZX2TiYZ7b9h31J0lnBWxoMSE7pSy4wtY30krDpOFoCCrC3
         kew7wR9N4xezL7HziuQ+XR/G/RSUnBQ679WLb/aLb0uX+KLg3qhELH3ytkYYG730TgOt
         O6Zg==
X-Gm-Message-State: AFqh2krKnnn3qcTScJgvNkxjEBh111ilzbkFYVzc7tA75WDJ1OX+I5e7
        3OuzEBm5Aax0npzsRQKgVRvu6c5MYAioQLJHJ+iXwLqFnthLgx5KFIRnK/5Vzak8ZGqGM7HESfw
        DFnh91AXsPSTNwpDPm+Yvb3PL
X-Received: by 2002:a0c:e7ca:0:b0:537:4b24:7fba with SMTP id c10-20020a0ce7ca000000b005374b247fbamr2704054qvo.28.1674240754715;
        Fri, 20 Jan 2023 10:52:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt/+92+YuFUWrLFI6DSkbz2bjUdyl+N/U/fZqMKdgKCs/hwOTOdimPPjygjVc9xJzylT3w3qg==
X-Received: by 2002:a0c:e7ca:0:b0:537:4b24:7fba with SMTP id c10-20020a0ce7ca000000b005374b247fbamr2704035qvo.28.1674240754479;
        Fri, 20 Jan 2023 10:52:34 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b007069fde14a6sm7549789qkp.25.2023.01.20.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:52:33 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:53:36 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y8rjMHXNH8KVKapZ@bfoster>
References: <20230117195959.29768-1-nphamcs@gmail.com>
 <20230117195959.29768-2-nphamcs@gmail.com>
 <Y8qmaqpAFko+gI3h@bfoster>
 <Y8rA4C6qnT5InHGc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rA4C6qnT5InHGc@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:27:12AM -0500, Johannes Weiner wrote:
> On Fri, Jan 20, 2023 at 09:34:18AM -0500, Brian Foster wrote:
> > On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> > > +	int memcgid;
> > > +	struct pglist_data *pgdat;
> > > +	unsigned long token;
> > > +
> > > +	unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> > > +	eviction_memcg = mem_cgroup_from_id(memcgid);
> > > +
> > > +	lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > > +	lrugen = &lruvec->lrugen;
> > > +
> > > +	min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > +	return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > 
> > I think this might be more readable without the double negative.
> > 
> > Also it looks like this logic is pulled from lru_gen_refault(). Any
> > reason the caller isn't refactored to use this helper, similar to how
> > workingset_refault() is modified? It seems like a potential landmine to
> > duplicate the logic here for cachestat purposes and somewhere else for
> > actual workingset management.
> 
> The initial version was refactored. Yu explicitly requested it be
> duplicated [1] to cut down on some boiler plate.
> 

Ah, sorry for missing the previous discussion. TBH I wasn't terribly
comfortable reviewing this one until I had made enough passes at the
second patch..

> I have to agree with Brian on this one, though. The factored version
> is better for maintenance than duplicating the core logic here. Even
> if it ends up a bit more boiler plate - it's harder to screw that up,
> and easier to catch at compile time, than the duplicates diverging.
> 

It seems more elegant to me, FWIW. Glad I'm not totally off the rails at
least. ;) But I'll defer to those who know the code better and the
author, so that's just my .02. I don't want to cause this to go around
in circles..

Brian

> [1] https://lore.kernel.org/lkml/CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com/
> 

