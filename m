Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E196DA8A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDGFxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjDGFxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:53:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C6AD1A;
        Thu,  6 Apr 2023 22:52:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02D1367373; Fri,  7 Apr 2023 07:52:55 +0200 (CEST)
Date:   Fri, 7 Apr 2023 07:52:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
Message-ID: <20230407055254.GB6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com> <20230328035725.GA25506@lst.de> <f42723f3-6dda-037d-3dd2-dc60ac0dcc3d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42723f3-6dda-037d-3dd2-dc60ac0dcc3d@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:21:10AM +0200, Petr Tesarik wrote:
> The full series in my local tree added it to the implementation of
> DRM_IOCTL_PRIME_FD_TO_HANDLE:

Umm, an all these are callers that absolutely never should even
end up in swiotlb.  If we have large buffers allocated by media
subsystems, we need to make sure they are fully addressable.
