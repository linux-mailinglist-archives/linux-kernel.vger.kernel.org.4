Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2B6DA8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjDGGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDGGBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:01:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475D40E0;
        Thu,  6 Apr 2023 23:01:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9BE168C4E; Fri,  7 Apr 2023 08:00:49 +0200 (CEST)
Date:   Fri, 7 Apr 2023 08:00:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [RFC v1 0/4] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230407060047.GE6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <630334b5-05d0-0152-7c2c-79174703f0ed@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630334b5-05d0-0152-7c2c-79174703f0ed@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:06:34PM +0200, Petr Tesarik wrote:
> B. Allocate a very big SWIOTLB, but allow to use it for normal
> allocations (similar to the CMA approach). The advantage is that there
> is only one table, pushing performance impact down to almost zero. The
> main challenge is migrating pages to/from the SWIOTLB. Existing CMA code
> cannot be reused, because CMA cannot be used from atomic contexts,
> unlike SWIOTLB.

That actually sounds very interesting, although I'd go futher and
figure out if we:

 a) could get away to only allow the CMA allocation for sleeping contexts,
    if we have enough sleeping context to matter
 b) check with the CMA maintainers if it is feasible and acceptable
    to them to extent CMA for irq allocations.

That being said, I think cases like dma-buf sharing really need to
be addressed at a higher level instead of basically double allocating
these long-term memory allocations.

I'd also really love to hear some feedback from the various confidential
computing implementors, as that seems to be ther big driving force for
swiotlb currently.
