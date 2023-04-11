Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176F6DD075
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDKDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjDKDnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:43:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADB213D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:42:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47E8868BEB; Tue, 11 Apr 2023 05:41:37 +0200 (CEST)
Date:   Tue, 11 Apr 2023 05:41:37 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230411034137.GB15679@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com> <20230407125535.476350d4@meshulam.tesarici.cz> <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:05:26PM +0000, Michael Kelley (LINUX) wrote:
> > Yes, this works fine now, but why are total_used and used_hiwater
> > global variables? If you make them fields in struct io_tlb_mem
> > (possibly guarded with #ifdef CONFIG_DEBUG_FS), you can get rid of the
> > check. Of course, in instances other than io_tlb_default_mem these
> > fields would not be exported to userspace through debugfs, but if really
> > needed, I can at least find them in a crash dump (or read them through
> > /proc/kcore).
> > 
> 
> Got it.
> 
> Your previously comments mentioned making them fields in struct io_tlb_mem,
> and I missed your point.  :-(   I got focused on fixing the accounting for
> DEBUG_FS so it didn't include the non-default pools, and didn't pick up on the
> idea of doing the accounting for the non-default pools even though the values
> aren't exposed in /sys.   I'll fix this in the next version.

FYI, I agree that per-instance accounting is probably the better way,
too.
