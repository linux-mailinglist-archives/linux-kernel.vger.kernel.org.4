Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC24706083
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEQG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:57:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A809319B3;
        Tue, 16 May 2023 23:57:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 713536732A; Wed, 17 May 2023 08:56:53 +0200 (CEST)
Date:   Wed, 17 May 2023 08:56:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 RESEND 4/7] swiotlb: Dynamically allocated bounce
 buffers
Message-ID: <20230517065653.GA25016@lst.de>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com> <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com> <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com> <20230516061309.GA7219@lst.de> <20230516083942.0303b5fb@meshulam.tesarici.cz> <ZGPEgsplBSsI9li3@arm.com> <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just thinking out loud:

 - what if we always way overallocate the swiotlb buffer
 - and then mark the second half / two thirds / <pull some number out
   of the thin air> slots as used, and make that region available
   through a special CMA mechanism as ZONE_MOVABLE (but not allowing
   other CMA allocations to dip into it).

This allows us to have a single slot management for the entire
area, but allow reclaiming from it.  We'd probably also need to make
this CMA variant irq safe.

This could still be combined with more aggressive use of per-device
swiotlb area, which is probably a good idea based on some hints.
E.g. device could hint an amount of inflight DMA to the DMA layer,
and if there are addressing limitations and the amout is large enough
that could cause the allocation of a per-device swiotlb area.

