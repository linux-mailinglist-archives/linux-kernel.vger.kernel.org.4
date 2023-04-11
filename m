Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9B6DD079
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjDKDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDKDoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:44:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50D4488
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:42:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E37E368BFE; Tue, 11 Apr 2023 05:42:53 +0200 (CEST)
Date:   Tue, 11 Apr 2023 05:42:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230411034253.GC15679@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com> <20230407055016.GA6803@lst.de> <BYAPR21MB1688CCCC4CFC597A3C12E370D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688CCCC4CFC597A3C12E370D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:01:13PM +0000, Michael Kelley (LINUX) wrote:
> I coded the way I did to follow the kernel coding style guidance
> that prefers converting a Kconfig symbol into a C boolean
> expression, and using it in a normal C conditional instead of
> using #ifdef.  If CONFIG_DEBUG_FS=n, the compiler will constant
> fold the conditional away so there's no runtime overhead.  I
> like the way that approached worked out in this case, but if you prefer
> separate functions with #ifdef and stubs, I don't feel strongly either way.

I don't think there is a a hard and clear rule.  Actual ifdefs have the
benefit of allowing to actually remove struct fields as well.  But
the important bit is that I do want the accounting in helpers instead
of in the main swiotlb logic.  And once you do that, having #ifdefed
stubs for the functions make sense to me.
