Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5385BFA68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiIUJOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIUJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:13:39 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489818E9A7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:13:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id 2BB8AFABF8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:13:11 +0100 (IST)
Received: (qmail 17661 invoked from network); 21 Sep 2022 09:13:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2022 09:13:10 -0000
Date:   Wed, 21 Sep 2022 10:13:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Mel Gorman <mgorman@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
Message-ID: <20220921091303.hihmb3qvfvl3s365@techsingularity.net>
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
 <YyLUGnqtZXn4MjJF@casper.infradead.org>
 <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
 <YyLpls9/t6LKQefS@casper.infradead.org>
 <b52b3f49-ebf5-6f63-da1a-f57711c3f97d@loongson.cn>
 <YyQ2m9vU/plyBNas@casper.infradead.org>
 <4bd0012e-77ff-9d0d-e295-800471994aeb@loongson.cn>
 <c3f4d1bb-418c-fbf5-c251-fd448f4d4e86@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c3f4d1bb-418c-fbf5-c251-fd448f4d4e86@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:23:05AM +0800, Hongchen Zhang wrote:
> Hi Mel,
> 
> The scan adjust algorithm was originally introduced by you from
> commmit e82e0561dae9 ("mm: vmscan: obey proportional scanning requirements
> for kswapd"), any suggestion about this fix patch?
> In short, proportional scanning is not friendly to processes other than
> kswapd.
> 

I suspect that 6eb90d649537 ("mm: vmscan: fix extreme overreclaim and swap
floods") is a more appropriate fix. While it also has a fairness impact,
it's a more general approach that is likely more robust and while
fairness is important, completely thrashing a full LRU is neither fair
nor expected.

-- 
Mel Gorman
SUSE Labs
