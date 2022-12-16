Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473264E969
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLPKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiLPKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:24:44 -0500
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD250D4B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:24:17 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 04C951C61
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:24:16 +0000 (GMT)
Received: (qmail 5411 invoked from network); 16 Dec 2022 10:24:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Dec 2022 10:24:15 -0000
Date:   Fri, 16 Dec 2022 10:24:10 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Akira Naribayashi (Fujitsu)" <a.naribayashi@fujitsu.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "rientjes@google.com" <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, compaction: fix fast_isolate_around() to stay within
 boundaries
Message-ID: <20221216102410.hem6wxqyqf43vnnp@techsingularity.net>
References: <20221027132557.5f724149bd5753036f41512a@linux-foundation.org>
 <20221031073559.36021-1-a.naribayashi@fujitsu.com>
 <TYCPR01MB77752C15C512BB7EC952F05BE53C9@TYCPR01MB7775.jpnprd01.prod.outlook.com>
 <20221107154350.34brdl3ms2ve5wud@techsingularity.net>
 <TYCPR01MB7775D957483C895456CFE146E53E9@TYCPR01MB7775.jpnprd01.prod.outlook.com>
 <20221123102550.kbsd3xclsr6o27up@techsingularity.net>
 <OS3PR01MB7779E069E3F269349D4EEA3AE51C9@OS3PR01MB7779.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <OS3PR01MB7779E069E3F269349D4EEA3AE51C9@OS3PR01MB7779.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 09:19:37AM +0000, Akira Naribayashi (Fujitsu) wrote:
> On Wed, 23 Nov 2022 10:26:05 +0000, Mei Gorman wrote:
> > On Wed, Nov 09, 2022 at 05:41:12AM +0000, Akira Naribayashi (Fujitsu) wrote:
> > > On Mon, 7 Nov 2022 15:43:56 +0000, Mei Gorman wrote:
> > > > On Mon, Nov 07, 2022 at 12:32:34PM +0000, Akira Naribayashi (Fujitsu) wrote:
> > > > > > Under what circumstances will this panic occur?  I assume those
> > > > > > circumstnces are pretty rare, give that 6e2b7044c1992 was nearly two
> > > > > > years ago.
> > > > > > 
> > > > > > Did you consider the desirability of backporting this fix into earlier
> > > > > > kernels?
> > > > > 
> > > > > 
> > > > > Panic can occur on systems with multiple zones in a single pageblock.
> > > > > 
> > > > 
> > > > Please provide an example of the panic and the zoneinfo.
> > > 
> > > This issue is occurring in our customer's environment and cannot 
> > > be shared publicly as it contains customer information.
> > > Also, the panic is occurring with the kernel in RHEL and may not 
> > > panic with Upstream's community kernel.
> > > In other words, it is possible to panic on older kernels.
> > > I think this fix should be backported to stable kernel series.
> > > 
> > > > > The reason it is rare is that it only happens in special configurations.
> > > > 
> > > > How is this special configuration created?
> > > 
> > > This is the case when the node boundary is not aligned to pageblock boundary.
> > 
> > In that case, does this work to avoid rescanning an area that was already
> > isolated?
> 
> In the case of your patch, I think I need to clamp the isolated_end as well.
> Because sometimes isolated_end < start_pfn(value before entering Scan after) < end_pfn.
> 
> After re-reading the source, I think the problem is that min_pfn and low_pfn
> can be out of range in fast_isolate_freepages.
> How about the following patch?
> 

Ok, makes sense and it is a condition that could happen because of pageblock
alignment.

-- 
Mel Gorman
SUSE Labs
