Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402116A117B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBWUvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:51:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F58215540;
        Thu, 23 Feb 2023 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7DGlfUnvfYwWSCguIE8WPkrvQTnToMa0+8F0V8cNuK4=; b=SSJshkyAK6myKyRuj/x4FeypBG
        bOOgui2oKkxOQjbvkfDpyqI6t6jR6wKjOlCisEHEKbXk6T3tvNpJrr00V5LSDQNWQVzOBVse4g8Hj
        KG8ZVeu8hoxbaU3SdL3fI1D1iFnHOil7jkHZQxtgfTZ7+6TtPin0pVbFevZoKqDGwpqElKRakJdSG
        u8jeBOI94RgPzxlfFOxk4T7SJQxITvCaDwq6BgW8MbcE68XBs88+EToJmEeASSyBk8DMncP+D2sOz
        bDs6xzdXUVfUGa0eGdXM3t4Zr1OiBacm1JDZcY+42+JNIebkHUjSBvRNhjexJuLDsmQ0iNJqD7cMJ
        y3Qa2Txw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVIYq-000JbX-G5; Thu, 23 Feb 2023 20:51:28 +0000
Date:   Thu, 23 Feb 2023 12:51:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
Message-ID: <Y/fR0KnxKP2rF3Da@bombadil.infradead.org>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-22-nick.alcock@oracle.com>
 <20230222144856.GA14220@lst.de>
 <Y/acoc6MDKNnrG+g@bombadil.infradead.org>
 <878rgopfdl.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rgopfdl.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:31:50PM +0000, Nick Alcock wrote:
> On 22 Feb 2023, Luis Chamberlain spake thusly:
> > Then we look for an optimal way to address the final step:
> >
> >  * remove all MODULE_LICENSE() and autogenerate them from SPDX
> 
> Ooh that would be nice!
> 
> > The difficulty in this will be that we want to upkeep existing build
> > heuristics and avoid to have to traverse the tree twice (see details
> > on commit 8b41fc4454e). I can't think of an easy way to do this that
> > does not involve using kconfig tristate somehow.
> 
> Nor can I -- and more generally I can't figure out a way to get from the
> Kconfig symbols to the source files that constitute them without
> retraversing the tree, since the only place the relationship is recorded
> is in makefiles, and those makefiles use a lot of make functionality
> (including more or less arbitrary make functions).

$ grep "_MODULE 1" ./include/generated/autoconf.h| wc -l
560

$ grep "_MODULE 1" ./include/generated/autoconf.h| grep XFS
#define CONFIG_XFS_FS_MODULE 1

I *think* the trick will likely be to have new a possibilities.h or just
agument autoconf.h with POSSIBLE_MODULE for each module.

The next complexity lies in inferring the license and doing the license
output given a combination. I *think* you already figured out the objs
from the module, and in fact your new kallsyms extension I think prints
these out right (which I find highly useful)? If so then we use these as
input source for an SPDX license lookup. Instead of having this
relationship grep'd after at build time, I wonder if might be good to
just collect all license associates to all files in a header file
similar to _MODULE prefix so maybe SPDX_$(file_path)_LICENSE_$license
which creates a header file 1-1 mapping.

Not sure if that's too much noise.

Just a thought, to get the wheels spinning.

  Luis
