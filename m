Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF655B90B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiINXCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 19:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINXCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:02:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760086C11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q0AmhJ66BcoKwGqCpa8ZnB7weX2R83u//PNx4e8dS3M=; b=MteI3Z/TAj+ZwVukeWG2feEHMF
        Qpzh8HrZgnvFTR5zsNjRVulNtZ8hCMwyuY6FSXXO+3d7AYZQviIHGUeSCDwOkctmudC9s29IdW+j2
        6A4BVItmE9jkFRTfNoOxgmF9bDoByuUSUBLuUxH7TiETTSD7HAKOH1uOWLFg7ykn5vcNuUW56LnNY
        KaJr7StB3LlfTdmwpfZo2GBUFEJy7whNGMjSdbcbMsDMukl6saxCabDKq7KY2iVCKopWHf5gsEcSY
        dT4HFYRZE9Fp/TldK90Z2sueUu06067tBzOEuRDlJryMM/arh/m7GzpDy6YX1Kf5CtStCVBUQXbOz
        9rHsp7yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYbOY-000Zq5-JW; Wed, 14 Sep 2022 23:02:14 +0000
Date:   Thu, 15 Sep 2022 00:02:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hongchen Zhang <zhanghongchen@loongson.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
Message-ID: <YyJdds+Tv9oiAEjd@casper.infradead.org>
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:51:42PM -0700, Andrew Morton wrote:
> On Wed, 14 Sep 2022 10:33:18 +0800 Hongchen Zhang <zhanghongchen@loongson.cn> wrote:
> 
> > when a process falls into page fault and there is not enough free
> > memory,it will do direct reclaim. At the same time,it is holding
> > mmap_lock.So in case of multi-thread,it should exit from page fault
> > ASAP.
> > When reclaim memory,we do scan adjust between anon and file lru which
> > may cost too much time and trigger hung task for other thread.So for a
> > process which is not kswapd,it should just do a little scan adjust.
> 
> Well, that's a pretty nasty bug.  Before diving into a possible fix,
> can you please tell us more about how this happens?  What sort of
> machine, what sort of workload.  Can you suggest why others are not
> experiencing this?

One thing I'd like to know is whether the page fault is for an anonymous or
file-backed page.  We already drop the mmap_lock for doing file I/O
(or we should ...) and maybe we also need to drop the mmap_lock for
doing direct reclaim?
