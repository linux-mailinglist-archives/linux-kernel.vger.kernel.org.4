Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C767DABC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjA0A1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA0A12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:27:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DE4239
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:27:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40340B81ED5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93DC433EF;
        Fri, 27 Jan 2023 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674779244;
        bh=deQh6cAWkh3EgE6cMrbUrdOHHjl5t+yVbCHQD1OOjMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aiT96oz8szS8HSpsPnEMTHJ1HnqZCQtp7YSbSfVnk+YTV8pMB/QHj79nWfmC8L/9C
         F2QdXYF8SPRXsKw2YO6vYTGExxgx+YhahGp18QQuuRV7iHi6Z6hjK8HmCkC1Dp4L0G
         yYqKICWKAatTTJ6XogEWo1w6CFlXVsNAhC232bv/prRo39K2gROixcIdp0UIR5XyG6
         MOKedvha0AnWS/8XiXaFPR0mx/NkT4GISnwxiIkkffpgznE59uSFqTV6E9mK4Y0siA
         37w42JM1pXkDaoh2uWPlj24x7rmROu2A1MRSSyvh4webeOQM5iHBadEvEjf0GJZQrI
         THunnr92fUpcg==
Date:   Thu, 26 Jan 2023 17:27:21 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        tonyb@cybernetics.com, kernel-team@meta.com
Subject: Re: [PATCHv4 00/12] dmapool enhancements
Message-ID: <Y9MaaZDY5BrgUwkm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126142209.b3546fc52f3f13ddcda67bac@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142209.b3546fc52f3f13ddcda67bac@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:22:09PM -0800, Andrew Morton wrote:
> On Thu, 26 Jan 2023 13:51:13 -0800 Keith Busch <kbusch@meta.com> wrote:
> 
> > Time spent in dma_pool alloc/free increases linearly with the number of
> > pages backing the pool. We can reduce this to constant time with minor
> > changes to how free pages are tracked.
> 
> Do we have any performance testing results for realistic workloads?

Yes, I mentioned this a little in patch 11, profiling with nvme with high-depth
dmapool allocating workloads. Results really depend on your environment, so
YMMV, but I was able to observe time spent in dma_pool_{alloc,free}() reduced
by half.
