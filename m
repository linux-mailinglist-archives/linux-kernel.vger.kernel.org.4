Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE16A9AF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCCPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCCPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:45:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01915547
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:45:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a2so3088978plm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677858353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUrdf6MZd4Bc/cJvmEdQo3H49BiVbJ8IWrHGSAtocn8=;
        b=ZwNAWntDzIXhLpXm+UxGbCquSggabPxjiWTdH07AOEr2F/iKVKFTnQETKg0BevqA7k
         bThNxmZSXw5veuOs9BBu0bNR+fD13muhVrsY9qEcj+vvkpDEugyTR0eHDsEyNXXc0/iM
         i/NyOkzs+qrjRIZAf5Lj34GQjUHJpkQhW+Hzb4jMVwD4mbnjpUX7ge4gbuczgAPKYQLU
         js8zL4+S8HFrEp8PxUt7DHo5q16dMqY4n9Bm04hcpibrN2uee+D1sv9U41OFUItVtcyV
         OrAQYZCc4Y+JL1iG2FFgP9z5AsIexOSQVzorweoXbYM6IgV9RQXdW1XjnVp0S4sLlSpQ
         CzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677858353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUrdf6MZd4Bc/cJvmEdQo3H49BiVbJ8IWrHGSAtocn8=;
        b=0aDvL0vEYzZsJiXmwHuT24ziZPU/o01UBRGCULJypWrKOoK8LIoURumT0lD9CjSTQp
         RI/bxE94DjwosMrJ3FyT1tNZAOj9LDJyGX5RISefQVkiLBBUkso3byLY+NJ172QeAH7P
         lNvjcmYYYtYmutojAZH0rVvAzmlPS+Q3zaY5XsHl/nN6bwUgTPO58mQerzNZVOJzCF5q
         /MBrome+rbKSane2Zwky3l9VfRhTB1UoAmUggxDlaqoxuzWnPrUmxYjIiCiT1IS+HVEx
         DyKBc+X6e6EdwsB1/vdvUqgEgj1Jw0zRzaG6Aa7xNgMe69QxssRI8DB2gV505D9Wgwsr
         aEZw==
X-Gm-Message-State: AO0yUKXps4kwqCMpsHoqEgcQWuPNfXFKtt8U6+OpLcBy0nHYDLumnBK/
        LmAY91vrgzeemuIfyefS0EXq/w==
X-Google-Smtp-Source: AK7set+lCN5F5Cbsep/m67mKpIsN4i0zksZlRs9Hv1GK95z3lis7CUT7+0vY4dJrr8BGtovepGn68A==
X-Received: by 2002:a17:903:42cc:b0:199:3909:eaee with SMTP id jy12-20020a17090342cc00b001993909eaeemr279241plb.6.1677858353255;
        Fri, 03 Mar 2023 07:45:53 -0800 (PST)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019a7d6a9a76sm1689767plc.111.2023.03.03.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:45:52 -0800 (PST)
Date:   Fri, 3 Mar 2023 07:45:49 -0800
From:   Zach O'Keefe <zokeefe@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
Message-ID: <20230303154549.xli4knfliv4c7gc4@google.com>
References: <20230217085439.2826375-1-stevensd@google.com>
 <ZAIT2YI4WrzZK5NK@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAIT2YI4WrzZK5NK@x1n>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 03 10:35, Peter Xu wrote:
> On Fri, Feb 17, 2023 at 05:54:36PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > Fix two races in khugepaged+shmem that cause issues with userfaultfd and
> > lseek, respectively.
> > 
> > v3 -> v4:
> >  - Base changes on mm-everything (fba720cb4dc0)
> >  - Add patch to refactor error handling control flow in collapse_file
> >  - Rebase userfaultfd patch with no significant logic changes
> >  - Different approach for fixing lseek race
> 
> I just noticed this one hasn't landed unstable, so I guess I just posted a
> trivial cleanup that can conflict with this so it won't apply cleanly..
> 
> https://lore.kernel.org/r/20230303151218.311015-1-peterx@redhat.com
> 
> The resolution will be fairly straightforward though, and I'm happy to
> rebase that one to this since this targets a real bug so should have higher
> priority.
> 
> I guess it's possible Andrew thought the series has unsettled comment so
> Andrew could just have ignored that whole set in the mark ups.  A repost
> could possibly clarify that.
> 
> Again, it'll always great to get another eye on this slightly involved
> series. Matthew / Yang were already on the list, also copying Zach for his
> recent works on khugepaged just in case he spots anything wrong.

Thanks Peter. My email filters need some tinkering, since I missed this until
yesterday when I came across it by chance. Thanks for Cc'ing me. I'm taking a
look now, and likewise will if reposted.

Best,
Zach

> 
> Thanks,
> 
> -- 
> Peter Xu
> 
