Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E86053D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiJSXSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJSXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1161AAE46
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13AF7619D2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E22FC433D6;
        Wed, 19 Oct 2022 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666221491;
        bh=PQpDdjCNhgH/SV9g2/UI3EyVE4IUuose3w4ZZPETCZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iX+GyCvTyHxKlLGc4DPMWUDKazCf8F3gxd4aWuRFaCC1MN6GMNAkS9onWpNJ6+ohV
         pOJdhmLadfgJXoXOOnkpK39orQ63j/79kuXaiS5rxgCUHlS7u50fw7t6mbOCaw8t+C
         pRZUpAbckhlnTJzeXvhTqmDdxwYVtf5IBj1z9VuQ=
Date:   Wed, 19 Oct 2022 16:18:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/huge_memory: Do not clobber swp_entry_t during
 THP split
Message-Id: <20221019161810.7510df1f37658a2b71c5e3a7@linux-foundation.org>
In-Reply-To: <CAHbLzkras5SV95-J4r=nbGx5u_5JS2u8KG=23hzVvFBqCnMA5g@mail.gmail.com>
References: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
        <CAHbLzkras5SV95-J4r=nbGx5u_5JS2u8KG=23hzVvFBqCnMA5g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 11:17:14 -0700 Yang Shi <shy828301@gmail.com> wrote:

> > The intent of commit b653db77350c patch was to avoid the case where
> > PG_private is clear but folio->private is not-NULL. However, THP tail
> > pages uses page->private for "swp_entry_t if folio_test_swapcache()" as
> > stated in the documentation for struct folio. This patch only clobbers
> > page->private for tail pages if the head page was not in swapcache and
> > warns once if page->private had an unexpected value.
> 
> It looks like the same issue fixed by
> https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/

It is.

As I asked earlier this week, what about reverting b653db77350c?  Why
do we care about the value of ->private for non-PG_private pages?
