Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EC641016
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiLBVis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBViq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:38:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FBCDA7D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:38:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E61B822B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 21:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DB9C433D6;
        Fri,  2 Dec 2022 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670017121;
        bh=tJ16Bk0WI8y8XcmDkzMO+dBcBAplNjNR2GBLgl4eFgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nG9gJJjNM1REQ9Dp2YlErXGNujtva4AwRxgbaw//vEAA+mb9a2qG+/9ZCpzJdNayg
         rrjBRTylp+09XRSUZBbv3eM65UQCWET0S5lrUINYtGA0CTQ1sUXjowiYIfbqFIxPK9
         nUat24/ksykBSb2BMwBB3ivIRcfOZNfJLiEEbOic=
Date:   Fri, 2 Dec 2022 13:38:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: disable top-tier fallback to reclaim on
 proactive reclaim
Message-Id: <20221202133840.5cdd4270cf73eaaa1d9d0345@linux-foundation.org>
In-Reply-To: <20221201233317.1394958-1-almasrymina@google.com>
References: <20221201233317.1394958-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Dec 2022 15:33:17 -0800 Mina Almasry <almasrymina@google.com> wrote:

> Reclaiming directly from top tier nodes breaks the aging pipeline of
> memory tiers.  If we have a RAM -> CXL -> storage hierarchy, we
> should demote from RAM to CXL and from CXL to storage. If we reclaim
> a page from RAM, it means we 'demote' it directly from RAM to storage,
> bypassing potentially a huge amount of pages colder than it in CXL.
> 
> However disabling reclaim from top tier nodes entirely would cause ooms
> in edge scenarios where lower tier memory is unreclaimable for whatever
> reason, e.g. memory being mlocked() or too hot to reclaim.  In these
> cases we would rather the job run with a performance regression rather
> than it oom altogether.
> 
> However, we can disable reclaim from top tier nodes for proactive reclaim.
> That reclaim is not real memory pressure, and we don't have any cause to
> be breaking the aging pipeline.
> 

Is this purely from code inspection, or are there quantitative
observations to be shared?

