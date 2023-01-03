Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10E65BC40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjACIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbjACIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:32:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B6DF72
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:32:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C41237F0D;
        Tue,  3 Jan 2023 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672734727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otz19k1tc7qzP2hV2fG+WMWuYfwYpYbTF6IlJwVmXWM=;
        b=AZGQFsAC5EaiBv+XveQ+4UmNX6EaEKIH8Ux13WW/BOlmVOwcHt9N+mGVRbN5uzwCdaBuVQ
        U3arMH591+NVs4tIRzDYGhvnHhG8azwZVlqJyWMF4qjCFmsW5X3VgA2Wh7LmcdKuYCdoT0
        xJxUNORQmCPI/qwcwk9seLuY1Nc59WE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1A381390C;
        Tue,  3 Jan 2023 08:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xrkTOAbos2P3CAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Jan 2023 08:32:06 +0000
Date:   Tue, 3 Jan 2023 09:32:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: (2) [PATCH] page_alloc: avoid the negative free for meminfo
 available
Message-ID: <Y7PoBkLyCaH1KHbB@dhcp22.suse.cz>
References: <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
 <20230103072807.19578-1-jaewon31.kim@samsung.com>
 <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p6>
 <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-01-23 17:20:08, 김재원 wrote:
> >On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
> >> The totalreserve_pages could be higher than the free because of
> >> watermark high or watermark boost. Handle this situation and fix it to 0
> >> free size.
> >
> >What is the actual problem you are trying to address by this change?
> 
> Hello
> 
> As described on the original commit,
>   34e431b0ae39 /proc/meminfo: provide estimated available memory
> mm is tring to provide the avaiable memory to user space.
> 
> But if free is negative, the available memory shown to userspace
> would be shown smaller thatn the actual available size. The userspace
> may do unwanted memory shrinking actions like process kills.

Do you have any specific example? Have you seen this happening in
practice or is this based on the code inspection?

Also does this patch actually fix anything? Say the system is really
struggling and we are under min watermark. Shouldn't that lead to
Available to be reported as 0 without even looking at other counters?

> I think the logic sholud account the positive size only.
> 
> BR
> 
> >
> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> >> ---
> >>  mm/page_alloc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 218b28ee49ed..e510ae83d5f3 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5948,6 +5948,8 @@ long si_mem_available(void)
> >>  	 * without causing swapping or OOM.
> >>  	 */
> >>  	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
> >> +	if (available < 0)
> >> +		available = 0;
> >>  
> >>  	/*
> >>  	 * Not all the page cache can be freed, otherwise the system will
> >> -- 
> >> 2.17.1
> >
> >-- 
> >Michal Hocko
> >SUSE Labs
> 
> 
> 
>  
> --------- Original Message ---------
> Sender : Michal Hocko <mhocko@suse.com>
> Date : 2023-01-03 17:03 (GMT+9)
> Title : Re: [PATCH] page_alloc: avoid the negative free for meminfo available
>  
> On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
> > The totalreserve_pages could be higher than the free because of
> > watermark high or watermark boost. Handle this situation and fix it to 0
> > free size.
> 
> What is the actual problem you are trying to address by this change?
> 
> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> > ---
> >  mm/page_alloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 218b28ee49ed..e510ae83d5f3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5948,6 +5948,8 @@ long si_mem_available(void)
> >           * without causing swapping or OOM.
> >           */
> >          available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
> > +        if (available < 0)
> > +                available = 0;
> >  
> >          /*
> >           * Not all the page cache can be freed, otherwise the system will
> > -- 
> > 2.17.1
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Michal Hocko
SUSE Labs
