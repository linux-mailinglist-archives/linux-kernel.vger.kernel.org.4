Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFD6475FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLHTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLHTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:09:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C2DBB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BpgFcTykCUCdNZRtCyOHoFGbH5EWy6ZB0yXQQsP7Ic=; b=OizC4MlpzR1c9dp0FY5822u9OF
        rFkKvAgpEo31ALaS+ERQtjvTkTiSxS8d8Ub7gTgyY2RWqcYeHiDnz2xE83b6N/p4oyezjrb0cEATV
        X+JaX6SN7ZsDNpeKDlNtJI3XisP8L1yEuAPUCtAMlDnRrHBaC2FGeJ1Y2oH5NMJ6lR5CT6IF7Dmuu
        h44a7RzR0JOVWzwnljif3iKDT78hpcMgsyEP3AsKx0FlTJtPdKcDQoUN2wIt/C3TFKOGmJKbUE4zy
        BRiILkwLPxJnCYBsWx2E8/2ROLC8AYV9P2M0E8ODvwajIhlyk81AfMOhpGAld9+/sLkkyy5VGK5JO
        QtgckbEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3MGM-007ERl-AY; Thu, 08 Dec 2022 19:08:54 +0000
Date:   Thu, 8 Dec 2022 19:08:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/5] swap: fold swap_ra_clamp_pfn into swap_ra_info
Message-ID: <Y5I2RiQzH/kFD6zX@casper.infradead.org>
References: <20221208180209.50845-1-ryncsn@gmail.com>
 <20221208180209.50845-4-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208180209.50845-4-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:02:07AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This make the code cleaner. This helper is made of only two line of
> self explanational code and not reused anywhere else.
> 
> And this actually make the compiled object smaller by a bit:
> 
>           text    data     bss     dec     hex filename
> Before:   9502     976      12   10490    28fa mm/swap_state.o
> After:    9470     976      12   10458    28da mm/swap_state.o

FYI, you can use scripts/bloat-o-meter to get a slightly more
useful analysis of object code changes.
