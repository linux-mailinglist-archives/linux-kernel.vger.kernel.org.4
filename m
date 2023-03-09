Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DA6B1B91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCIGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCIGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:31:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB6DBB7B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:31:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so5356326pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678343494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHiDNEIuddEYc3xNn4RWgU642tcrPWESFH0u3putV3Y=;
        b=XxCnzBuBCM/7yUSrjwZL0yHN/4WUWX6okvCTZA+EOJXZbNGoNWk3OUaaQJHab0d/h2
         M9oXltkSwHlrzhzX70Y4KOQCmMFkw5BNZO4/8hjsYjtswxq8I20Z39E0dJjHC7KG9mQP
         lCV0ezpps9R04KO8LdHLgiaIgY3+3b6v4DwZb64WVB7m+7Im4mnCK6fGSA1FWOBZ9UCp
         0uh8Ov90PfBOYEgw5uBYBXsPgBrdkxzBqkN112jJpiXCsB3M+dQloaEDnEG81TZW7fAz
         4QMJWhuJJ+MZgX70Q3msmNtn8kyWxWluxxE6FFtCISXDngATeGNNWaj2qpdshJI/RAhf
         TSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678343494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHiDNEIuddEYc3xNn4RWgU642tcrPWESFH0u3putV3Y=;
        b=tBg2pXncdVhJSTR3sDa0opWGwvY14QQ/FhVkmDrBOlGBuEC39A0BbJw1/VuF8ImO9a
         JqPIhj5+n5Bt/W5ujzY3ehRuOCvsNH1gNudpbZDxo1LtXKtGfX/efAlS+JRp0UYAZ/bq
         cY3PscfOAMOVolFYRFedSI4o+txDZCKwqFroFTWN++A+s2DpYUBCA3IaMwkKwEUqlZij
         YMBFKvWgPXIl/Epk+pHMFP+W1s/TLiP2VlVtQUI2bJ99gdy0IzNg3OSKeRpdXfbnGYW9
         FxbvCal2CseRL4J5HpEzKZ7bz6jYGQarGTIOZSWwBB8R7OeDzaHRvAPoNR/jhYZMtCZc
         bSRA==
X-Gm-Message-State: AO0yUKXPpEmMsxwPaxGUXDb2wBGNmk+u6hvVH4OEY6ZE5QmUZ2v4ynjm
        9UtGX4R4H8aTmEOqKgWa0rUBVfoU6C6hGw==
X-Google-Smtp-Source: AK7set/h36exTu0G/SORM8/uHPt4jXa+WpEAJQPd9xyvSxthLaHGp/NriJnWoW3wbr64olGkvadK9w==
X-Received: by 2002:a17:902:ea04:b0:19e:6e9d:4bd with SMTP id s4-20020a170902ea0400b0019e6e9d04bdmr25940990plg.43.1678343493946;
        Wed, 08 Mar 2023 22:31:33 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019a7d6a9a76sm10838183plc.111.2023.03.08.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 22:31:32 -0800 (PST)
Date:   Thu, 9 Mar 2023 06:31:25 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZAl9PbMe1CRlvzva@localhost>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094106.227365-2-rppt@kernel.org>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:41:02AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> When set_memory or set_direct_map APIs used to change attribute or
> permissions for chunks of several pages, the large PMD that maps these
> pages in the direct map must be split. Fragmenting the direct map in such
> manner causes TLB pressure and, eventually, performance degradation.
> 
> To avoid excessive direct map fragmentation, add ability to allocate
> "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> allocated pages from the direct map and use a cache of the unmapped pages.
> 
> This cache is replenished with higher order pages with preference for
> PMD_SIZE pages when possible so that there will be fewer splits of large
> pages in the direct map.
> 
> The cache is implemented as a buddy allocator, so it can serve high order
> allocations of unmapped pages.

Hello,

To me it seems unnecessary to increase pageblock bitmap size just to
distinguish if it is allocated with __GFP_UNMAPPED.

I think this can be implemented as an independent cache on top of
buddy allocator, and introducing new API for unmapped page
allocation and freeing?

Thanks,
Hyeonggon
