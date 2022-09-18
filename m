Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958625BC0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 01:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIRXr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 19:47:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EC13D20;
        Sun, 18 Sep 2022 16:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E928AB8159B;
        Sun, 18 Sep 2022 23:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F72FC433D6;
        Sun, 18 Sep 2022 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663544873;
        bh=4fwR9rPjWfkV5OrkpZKeGBol8VbyfO8AaecqrymPg84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CryioqGUr67tZVMXmPinT0VyfA+BiW9GFUPBq5vhkJmwwfSD4hXi8RBFUY0XHTkr8
         GH0Cpzirbegi9k5DJjUu8WGDFAn5VQyo89jqWDwDdg6oPXJczvBxpPCQvqOPY0gZNo
         F1v42ZUI8ew0rTfnsqbpVGSdGtwun+to0k5Q9Ho8=
Date:   Sun, 18 Sep 2022 16:47:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v14 00/14] Multi-Gen LRU Framework
Message-Id: <20220918164751.376ec0c07bb619e5eb12ab49@linux-foundation.org>
In-Reply-To: <CAOUHufZzDCezgeeAj6M3WqOQKJYxQ_4jNCD8itU0+J6JE_fV4g@mail.gmail.com>
References: <20220815071332.627393-1-yuzhao@google.com>
        <20220911170814.f6a32b40e64397a61b1f8daf@linux-foundation.org>
        <CAOUHufZk-u0S+FyDEdxw1nehBKz_G_GG_3_LAzqyssx21Wd4Jw@mail.gmail.com>
        <CAOUHufZzDCezgeeAj6M3WqOQKJYxQ_4jNCD8itU0+J6JE_fV4g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022 14:40:01 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Let me also post the incremental patches after this email, in case you
> strongly prefer to add them on top of v14.

Thanks, helpful.

I have one question regarding 03/11.

The final two updates look pretty substantial.  I guess I'll do a
series replacement and let this and mapletree sit another week.
