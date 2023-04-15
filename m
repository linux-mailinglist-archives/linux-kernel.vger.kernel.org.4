Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13C6E2DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDOArd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDOArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:47:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E111BE6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:47:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a273b3b466so346835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681519651; x=1684111651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOjLK7bQw/L2nScgnPBp53VOvgLxyAOh6awtiT0/aow=;
        b=RtOWkJYbe+9ZGSd5xT+gJJLYqAEs2lVrS2bkzsMdZM7klHA/vSY0tlzl9xqOiJdx8m
         rqlTfL3MNAEjVlQMaCXNLrbo5gZYSR3bhVkruXKeaodAqxkbYpyechzuxax+w8YuuJUD
         3OGs6/AEAYveEgXL/bO+6mCSy9S7+6J4/XJLqCXX0u9jEvIaoVBuWSt5OgAdjfBwsXre
         rKkC0tHcAyrqchK8mRNiDF2e23Guzns+ByJka25IHcbAt4DomqxMo8dbEzlSCLdjltxr
         QUB8GI9mo8ImKeov5KYlljJx8+b7wgs8PgbPW1MCx681BvtaYwevu0jbqxSasgXmR7Bg
         QoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681519651; x=1684111651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOjLK7bQw/L2nScgnPBp53VOvgLxyAOh6awtiT0/aow=;
        b=RSIyj+2FVA9UlAb+YhxGztdVOa4sOFL6yZ7s+k5NKYlOiS3qpwQfBLf0oySyWyNvf5
         DfLXclHaxMeI7FtdFg/C4+9MP4U4ga2dMVLMd8ONqcYyGW+9M9HjNgrtw1zP3isNdzMv
         a3gTpHwbrVpNnsxGwS6zv2xgM4RYkRY1Ya2/DaNx0qzYu632gu4a0G7RxpLJPx4Ty8tn
         rNgwGYXA/7imghBtqpzHfiGqUh29DmwxY+KSjljOPKVHoyfBYUhFEdviQ8dkgvNWwP6J
         0uTNpFEvRCWB3rOf/oTMj4/X/XsmxKCGJoikxbrQ8b6E9mRc4fAWpsLTpgHkaOIS9FIL
         lZbA==
X-Gm-Message-State: AAQBX9cAi7UdLAIAxidw71nhFaeZtAgSXN4Ydlr+IJ9RsL6VE/ZnfXww
        LCyerM1y+KDS0qA153sU98G3UA==
X-Google-Smtp-Source: AKy350bHkVJvegqUh1KkAk2WDRkXKzUMzBurIQmEMbkglCRkotl3792v/bGfao0Tkm70skXEKMpw4g==
X-Received: by 2002:a17:902:6505:b0:19a:c659:e1cc with SMTP id b5-20020a170902650500b0019ac659e1ccmr72607plk.2.1681519650587;
        Fri, 14 Apr 2023 17:47:30 -0700 (PDT)
Received: from [2620:0:1008:11:7645:4c1a:1f51:a9b8] ([2620:0:1008:11:7645:4c1a:1f51:a9b8])
        by smtp.gmail.com with ESMTPSA id k20-20020aa790d4000000b0063585190b09sm3552921pfk.113.2023.04.14.17.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 17:47:29 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:47:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Michal Hocko <mhocko@suse.com>
cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap allocation
 guarantees
In-Reply-To: <ZDhGADdnbIAqdlrg@dhcp22.suse.cz>
Message-ID: <e7171928-61aa-2897-b3d1-e5f826a4592c@google.com>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com> <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org> <ZDcSG2t3/sVuZc67@dhcp22.suse.cz> <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com> <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
 <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com> <ZDhGADdnbIAqdlrg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023, Michal Hocko wrote:

> [...]
> > > > This is a theoretical concern. Freeing a 1G page requires 16M of free
> > > > memory. A machine might need to be reconfigured from one task to
> > > > another, and release a large number of 1G pages back to the system if
> > > > allocating 16M fails, the release won't work.
> > >
> > > This is really an important "detail" changelog should mention. While I
> > > am not really against that change I would much rather see that as a
> > > result of a real world fix rather than a theoretical concern. Mostly
> > > because a real life scenario would allow us to test the
> > > __GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
> > > just end up with a theoretical fix for a theoretical problem. Something
> > > that is easy to introduce but much harder to get rid of should we ever
> > > need to change __GFP_RETRY_MAYFAIL implementation for example.
> > 
> > I will add this to changelog in v3. If  __GFP_RETRY_MAYFAIL is
> > ineffective we will receive feedback once someone hits this problem.
> 
> I do not remember anybody hitting this with the current __GFP_NORETRY.
> So arguably there is nothing to be fixed ATM.
> 

I think we should still at least clear __GFP_NORETRY in this allocation: 
to be able to free 1GB hugepages back to the system we'd like the page 
allocator to at least exercise its normal order-0 allocation logic rather 
than exempting it from retrying reclaim by opting into __GFP_NORETRY.

I'd agree with the analysis in 
https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/ that 
either a cleared __GFP_NORETRY or a __GFP_RETRY_MAYFAIL makes logical 
sense.

We really *do* want to free these hugepages back to the system and the 
amount of memory freeing will always be more than the allocation for 
struct page.  The net result is more free memory.

If the allocation fails, we can't free 1GB back to the system on a 
saturated node if our first reclaim attempt didn't allow these struct 
pages to be allocated.  Stranding 1GB in the hugetlb pool that no 
userspace on the system can make use of at the time isn't very useful.
