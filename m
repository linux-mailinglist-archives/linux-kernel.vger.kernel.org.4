Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6670D9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjEWJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjEWJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56111121;
        Tue, 23 May 2023 02:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF46C61447;
        Tue, 23 May 2023 09:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D0C433EF;
        Tue, 23 May 2023 09:54:14 +0000 (UTC)
Date:   Tue, 23 May 2023 10:54:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <ZGyNQxY6By1QdXur@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com>
 <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230516061309.GA7219@lst.de>
 <20230516083942.0303b5fb@meshulam.tesarici.cz>
 <ZGPEgsplBSsI9li3@arm.com>
 <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
 <20230517132748.2e250f9c@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517132748.2e250f9c@meshulam.tesarici.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 01:27:48PM +0200, Petr Tesařík wrote:
> On Wed, 17 May 2023 08:35:10 +0200
> Petr Tesařík <petr@tesarici.cz> wrote:
> > Anyway, my greatest objection to allocating additional swiotlb chunks is
> > that _all_ of them must be searched to determine that the physical
> > address does _not_ belong to a swiotlb, incurring performance penalty
> 
> I thought about this part again, and I overlooked one option. We can
> track only the _active_ swiotlbs for each device. If a device never
> needs a swiotlb, there is no active swiotlb, and is_swiotlb_buffer()
> short-circuits to false. This should avoid all collateral damage to
> innocent devices.

Does this work with dma-buf or does dma-buf not allow swiotlb bouncing?

-- 
Catalin
