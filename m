Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0E5B5635
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiILIaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiILI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:29:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59262ADE;
        Mon, 12 Sep 2022 01:29:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5141568B05; Mon, 12 Sep 2022 10:29:10 +0200 (CEST)
Date:   Mon, 12 Sep 2022 10:29:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220912082909.GA10666@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru> <20220910053045.GA23052@lst.de> <20220910123542.tzxg2blegw55z5fj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910123542.tzxg2blegw55z5fj@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 03:35:42PM +0300, Serge Semin wrote:
> Well, both approaches will solve the denoted problem. I am just
> wondering why do you think that the kmalloc-ed buffer is more
> preferable?

Because it clearly documents the intent.  Here is one buffer that is
just a data buffer, and here is one with kernel internal structure.
The concept of embedding on-disk / on-the-wire structures into internal
stuctures always seemed rather weird and unexpected to me, as we now
need to ensure that the alignment works right on both sides.  With
the right annotations (as done in this series) this will work, but
it feels a little fragile to me.

> What would be the best solution if we had a qualifier like this:
> #ifdef CONFIG_DMA_NONCOHERENT
> #define ____dma_buffer ____cacheline_aligned
> #else
> #define ____dma_buffer
> #endif
> and used it instead of the direct ____cacheline_aligned utilization.

So independent of my preference for separate allocations, this suggested
additional would still be very useful for the places where we need
to use the alignment for performance or other reasons.  I'd use
something like __dma_alligned or similar, though.
