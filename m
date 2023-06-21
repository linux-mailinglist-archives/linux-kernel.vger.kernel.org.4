Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD9737D74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjFUIRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFUIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:17:32 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B85E1BE8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:17:26 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:45863.1358915370
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.84 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 347E62800BB;
        Wed, 21 Jun 2023 16:17:22 +0800 (CST)
X-189-SAVE-TO-SEND: liuq131@chinatelecom.cn
Received: from  ([36.111.64.84])
        by app0023 with ESMTP id 6ca4e00d18f54c93bb51d24ce130bd1e for akpm@linux-foundation.org;
        Wed, 21 Jun 2023 16:17:25 CST
X-Transaction-ID: 6ca4e00d18f54c93bb51d24ce130bd1e
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
Message-ID: <653da4af-f999-690c-569d-bfee173eeffb@chinatelecom.cn>
Date:   Wed, 21 Jun 2023 16:17:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mm/min_free_kbytes: modify min_free_kbytes calculation
 rules
To:     akpm@linux-foundation.org, "Huang, Ying" <ying.huang@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <30f4ac69-fb51-8414-fdaf-a1366a84bbd3@chinatelecom.cn>
From:   liuq <liuq131@chinatelecom.cn>
In-Reply-To: <30f4ac69-fb51-8414-fdaf-a1366a84bbd3@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/21 16:09, liuq 写道:
> Hi, Liuq,
>
> Thanks for updated patch.
>
> liuq <liuq131@chinatelecom.cn> writes:
>
> > The current calculation of min_free_kbytes only uses ZONE_DMA and
> > ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> > will also divide part of min_free_kbytes.This will cause the min
> > watermark of ZONE_NORMAL to be too small in the presence of 
> ZONE_MOVEABLE.
> >
> > __GFP_HIGH and PF_MEMALLOC allocations usually don't need moveable
> > zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
> > value in __setup_per_zone_wmarks.
>
> Please list the test result of your patch.  That is, WMARK_MIN before
> and after your patch in a system with large ZONE_MOVABLE.
>
Hi Huang, Ying

Thank you very much for your review and suggestions. I will send another 
version later.

Best Regards,

liuq

> > Signed-off-by: liuq <liuq131@chinatelecom.cn>
> > ---
> >  mm/page_alloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 47421bedc12b..608384712a89 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6364,7 +6364,7 @@ static void __setup_per_zone_wmarks(void)
> >
> >          /* Calculate total number of !ZONE_HIGHMEM pages */
> >          for_each_zone(zone) {
> > -                if (!is_highmem(zone))
> > +                if (!is_highmem(zone) || zone_idx(zone) != 
> ZONE_MOVABLE)
> >                          lowmem_pages += zone_managed_pages(zone);
> >          }
> >
> > @@ -6374,7 +6374,7 @@ static void __setup_per_zone_wmarks(void)
> >                  spin_lock_irqsave(&zone->lock, flags);
> >                  tmp = (u64)pages_min * zone_managed_pages(zone);
> >                  do_div(tmp, lowmem_pages);
> > -                if (is_highmem(zone)) {
> > +                if (is_highmem(zone) || zone_idx(zone) == 
> ZONE_MOVABLE) {
> >                          /*
> >                           * __GFP_HIGH and PF_MEMALLOC allocations 
> usually don't
> >                           * need highmem pages, so cap pages_min to 
> a small
>                                 ~~~~~~~
>
> Change the comments above too?
>
> Best Regards,
> Huang, Ying
>
