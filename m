Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6046EE3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDYO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDYO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:26:45 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D610EB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:26:43 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-5ef54bcded4so26081326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682432803; x=1685024803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzQgQguk3FOOn5Q0sl8SuL93RxV/W/XH0B4cmOPUOrU=;
        b=yOxoxF62ERjNeWj+CJa/Kah64bkFFMllNsu/eOE1VPjy/CtwcA4FxevLn1O/B4+AY+
         zfVO2T4iq6YWlUNEovI2VhyRBeqpSobmLFeaPBC790F8WxXVf2FT1xl83r3qVq+EGrsV
         IXaeU2RXZDlKh5LyQpUjFc140qZ447SZe8eQ3SwWZVC9XwDXAaTs7wXKISggALCPIrYo
         OMRTE2bLujG0i8qn4lvcsLiNYH1xdiBg/ug9sYv9Mn+NoV+jiCYrQMOv85l7AaIUuVoN
         +sB4aDdp2H9N9Nu7hdKDXR98TnMR707C/ZsscqiU3PpsaA6nhgtN7PAfb8QEsh+CXdwS
         JDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682432803; x=1685024803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzQgQguk3FOOn5Q0sl8SuL93RxV/W/XH0B4cmOPUOrU=;
        b=B7VFfTVAbGOyePEwg357EH7yzY9U6NO3yo4YF75aXJS53rICEQsN22O3r7+yiHVBq9
         ylEEle3ybN1V2xwbC3fJijcFEOwfZmML+HVtFY4FlbcsDuhJYWxodC3bv0hbu6y9kCnN
         Ltw7HOjIqbt4S3L/b2itgZRer38Okzj7lQf2SCpsgTsebyDmssXTp1teLWVyBb4cmB1V
         UsF7O+BpzKUNbJLqj7fol3GSe+lTLjFDGE2/9Fb7NJIdVhrHoKkFwxIciwVfVuBURFOC
         RmsmG6yvPGHs7bRanur1RH1kvsGFO2MNLTT1I6iFuWdbihXOk7CLbPSGodwetInt70XE
         LdbA==
X-Gm-Message-State: AAQBX9ft7Rd2JMSblkaQk3Z8P5J31CiULK85MNvbOY8n8hSTMQTbkxwG
        xsALfoXocYKZGOhfFanaoZXBVw==
X-Google-Smtp-Source: AKy350aVJB8UWDC5ePhBp0/DKlzvTUR/3tZD+AfBmuBDgB9VXbS/x6mF8kc684QsCsAoWpDytYxKqA==
X-Received: by 2002:a05:6214:1c49:b0:5e6:1723:a7e4 with SMTP id if9-20020a0562141c4900b005e61723a7e4mr31244225qvb.30.1682432802913;
        Tue, 25 Apr 2023 07:26:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9fc5])
        by smtp.gmail.com with ESMTPSA id q17-20020a0ce211000000b005f5b71f75f3sm4120360qvl.125.2023.04.25.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 07:26:42 -0700 (PDT)
Date:   Tue, 25 Apr 2023 10:26:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 20/26] mm: vmscan: use compaction_suitable() check in
 kswapd
Message-ID: <20230425142641.GA17132@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-21-hannes@cmpxchg.org>
 <87a5ywfyeb.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5ywfyeb.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:12:28AM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > Kswapd currently bails on higher-order allocations with an open-coded
> > check for whether it's reclaimed the compaction gap.
> >
> > compaction_suitable() is the customary interface to coordinate reclaim
> > with compaction.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
> >  1 file changed, 23 insertions(+), 44 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ee8c8ca2e7b5..723705b9e4d9 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  		if (!managed_zone(zone))
> >  			continue;
> >  
> > +		/* Allocation can succeed in any zone, done */
> >  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> >  			mark = wmark_pages(zone, WMARK_PROMO);
> >  		else
> >  			mark = high_wmark_pages(zone);
> >  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
> >  			return true;
> > +
> > +		/* Allocation can't succeed, but enough order-0 to compact */
> > +		if (compaction_suitable(zone, order,
> > +					highest_zoneidx) == COMPACT_CONTINUE)
> > +			return true;
> 
> Should we check the following first?
> 
>         order > 0 && zone_watermark_ok_safe(zone, 0, mark, highest_zoneidx)

That's what compaction_suitable() does. It checks whether there are
enough migration targets for compaction (COMPACT_CONTINUE) or whether
reclaim needs to do some more work (COMPACT_SKIPPED).
