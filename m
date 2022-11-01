Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBB6147CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKAKk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:40:46 -0400
Received: from outbound-smtp17.blacknight.com (outbound-smtp17.blacknight.com [46.22.139.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD415A2E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:40:43 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 316151C36D7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:40:42 +0000 (GMT)
Received: (qmail 7548 invoked from network); 1 Nov 2022 10:40:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Nov 2022 10:40:42 -0000
Date:   Tue, 1 Nov 2022 10:40:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
Message-ID: <20221101104040.o6gqtyyd5d4pkhle@techsingularity.net>
References: <20221024134146.3442393-1-chenwandun@huawei.com>
 <20221024145555.oaoisy6m723h4axc@techsingularity.net>
 <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
 <20221025131959.sd47fipimhehf76i@techsingularity.net>
 <316bc0a2-34d9-e485-11d2-f3dffd0fdea4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <316bc0a2-34d9-e485-11d2-f3dffd0fdea4@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:37:35AM +0800, Chen Wandun wrote:
> > > >    As is, the patch could result in a batch request of 0 and
> > >   I foget this, the patch need some improve, thanks.
> > > 
> > > > fall through to allocating from the zone list anyway defeating the
> > > > purpose of the PCP allocator and probably regressing performance in some
> > > > csaes.
> > > Same as I understand???how about set high/batch for each order in pcplist???
> > Using anything would than (X >> order) consumes storage. Even if storage
> > was to be used, selecting a value per-order would be impossible because
> > the correct value would depend on frequency of requests for each order.
> > That can only be determined at runtime and the cost of determining the
> > value would likely exceed the benefit.
>
> Can we set a experience value for pcp batch for each order during init
> stage?

I'm not sure what you mean by "experience value" but maybe you meant
experimental value?

> If so we can make accurately control for pcp size. Nowdays, the size of each
> order in pcp list is full of randomness. I dont konw which scheme is better
> for performance.
> 

It is something that could be experimented with but the main question is
-- what should those per-order values be? One option would be to enforce
pcp->high for all high-order values except THP if THP is enabled. That would
limit some of the issues with pcp->high being exceeded as even if two THPs
are refilled, one of them is allocated immediately. I wasn't convinced it was
necessary when implementing high-order PCP support but it could be evaluated.

-- 
Mel Gorman
SUSE Labs
