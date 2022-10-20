Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF79605A46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJTIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJTIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:52:30 -0400
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2D192BB1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:52:19 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id D70D41C4F60
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:52:17 +0100 (IST)
Received: (qmail 17092 invoked from network); 20 Oct 2022 08:52:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Oct 2022 08:52:17 -0000
Date:   Thu, 20 Oct 2022 09:52:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [RFC PATCH] mm/huge_memory: Do not clobber swp_entry_t during
 THP split
Message-ID: <20221020085214.7pgvylgxkojbiuat@techsingularity.net>
References: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
 <CAHbLzkras5SV95-J4r=nbGx5u_5JS2u8KG=23hzVvFBqCnMA5g@mail.gmail.com>
 <20221019161810.7510df1f37658a2b71c5e3a7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221019161810.7510df1f37658a2b71c5e3a7@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Brian to cc

On Wed, Oct 19, 2022 at 04:18:10PM -0700, Andrew Morton wrote:
> On Wed, 19 Oct 2022 11:17:14 -0700 Yang Shi <shy828301@gmail.com> wrote:
> 
> > > The intent of commit b653db77350c patch was to avoid the case where
> > > PG_private is clear but folio->private is not-NULL. However, THP tail
> > > pages uses page->private for "swp_entry_t if folio_test_swapcache()" as
> > > stated in the documentation for struct folio. This patch only clobbers
> > > page->private for tail pages if the head page was not in swapcache and
> > > warns once if page->private had an unexpected value.
> > 
> > It looks like the same issue fixed by
> > https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/
> 
> It is.
> 

Yep, based on Brian's changelog, it was the same workload that triggered
it as it happens to stress the corner case that hits the bug. 

> As I asked earlier this week, what about reverting b653db77350c?  Why
> do we care about the value of ->private for non-PG_private pages?

I don't think we do care but based on the changelog of b653db77350c, it's
part of an effort to either remove the PG_private bit or is a preparation
step for casting page to a meaningful type based on context but only Matthew
can tell us his motivation. There at least is some value to identifying
cases where a referenced page has valid information in page->private that
is not reflected in the flags.

-- 
Mel Gorman
SUSE Labs
