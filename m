Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB326E71C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjDSDoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjDSDoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:44:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CFC449F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:44:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id fv6so18466254qtb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681875846; x=1684467846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPSq3OfLNyZvC33KlnI/fZAdJg9MqJ41VHFlSsDteiw=;
        b=Oz1b+xidKfkZ0OMWMQKzx1T9LpaIo45kYON8P97GoVjax1G5TaNVqIbWBUrV5n6Vjw
         Rr6R7wWWaZXfsE71gJENz4Lv9x5JGrEytG/1et3/7iT+R+vljNxwYXWG9P7Ws2ejoxq0
         lOFcM9fH2+ri41+Z5w4dq7gLsCo49XSuvy/Ow8BK9QtTLc3gYs9Q8kMOIEq0Phge2hb0
         H2WPB+gqHnrIAAcysTCawLVxTfDvvhl/SlF9ICVKW6YmSXxoFvTHWwnqgF5/WBtwN2Oi
         5qg51R63kUW5QdWWKKrgx+SFzMy1ea+CxARgSKuvwfrxg2z9m6FjOuIVsirrh57Et3uH
         JnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681875846; x=1684467846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPSq3OfLNyZvC33KlnI/fZAdJg9MqJ41VHFlSsDteiw=;
        b=LNg2ymmfyoGnFBrw7iCX18Ypj9FrR96LXIMvAHhFVeDfv3YgdS/aXS701Dhh0xWDwp
         s/LzioWCCIAyfem0NLncMFpntMacGfv8UwMqrGqr/iQM2cAmF0A3VZJ+p5Ic4XbfJfZq
         F5Sz5GXNpFfFFma/Sd5AkiFkME1iOCce6G7CHtw+uyokd8dnNkOIjnGRgDCoPrdxZlxv
         9P3zspgGbC8CuHb5ynpM0AZnTe2ftksfcD7457iL4LUCFyNkgX04towl808ipwfNaQ/d
         Gt33ZkJrnI04CvORZiPPv/OYLDxMQQp4vhPv16CHvRXeJJ2icM65EEh+gM0qL3TUD2BN
         Q1BQ==
X-Gm-Message-State: AAQBX9fP1IoQzr+MQZOifEWsOcuaE3vxckKzdnd/L4o9pEvF4AH1AnbO
        vbV9773GVZMlAY7//6raMJLz5w==
X-Google-Smtp-Source: AKy350YVNyCiOt3CzXLsb9tHi20H0nSSNRhfsIZ3DJ6ORcb7ixVCRnNwomFBlwI1xxFmc4CG9XxwZw==
X-Received: by 2002:a05:622a:14a:b0:3e8:b9a0:babf with SMTP id v10-20020a05622a014a00b003e8b9a0babfmr4167713qtw.12.1681875845919;
        Tue, 18 Apr 2023 20:44:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a0d8900b00706b09b16fasm4401719qkl.11.2023.04.18.20.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:44:05 -0700 (PDT)
Date:   Tue, 18 Apr 2023 23:44:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Message-ID: <20230419034404.GA274690@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
 <20230419000105.matz43p6ihrqmado@box.shutemov.name>
 <20230419025552.GB272256@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419025552.GB272256@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:55:53PM -0400, Johannes Weiner wrote:
> On Wed, Apr 19, 2023 at 03:01:05AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Apr 18, 2023 at 03:12:50PM -0400, Johannes Weiner wrote:
> > > pageblock_order can be of various sizes, depending on configuration,
> > > but the default is MAX_ORDER-1.
> > 
> > Note that MAX_ORDER got redefined in -mm tree recently.
> > 
> > > Given 4k pages, that comes out to
> > > 4M. This is a large chunk for the allocator/reclaim/compaction to try
> > > to keep grouped per migratetype. It's also unnecessary as the majority
> > > of higher order allocations - THP and slab - are smaller than that.
> > 
> > This seems way to x86-specific.
> > Other arches have larger THP sizes. I believe 16M is common.
> >
> > Maybe define it as min(MAX_ORDER, PMD_ORDER)?
> 
> Hm, let me play around with larger pageblocks.
> 
> The thing that gives me pause is that this seems quite aggressive as a
> default block size for the allocator and reclaim/compaction - if you
> consider the implications for internal fragmentation and the amount of
> ongoing defragmentation work it would require.
> 
> IOW, it's not just a function of physical page size supported by the
> CPU. It's also a function of overall memory capacity. Independent of
> architecture, 2MB seems like a more reasonable step up than 16M.

[ Quick addition: on those other archs, these patches would still help
  with other, non-THP sources of compound allocations, such as slub,
  variable-order cache folios, and really any orders up to 2M. So it's
  not like we *have* to raise it to PMD_ORDER for them to benefit. ]
