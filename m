Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C239961F98C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiKGQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiKGQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:24:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E522613E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BgdLKn51MHlz22SyEjHwV09QoO0gl+24rNf4NSfnXOM=; b=mlghPPiWpPuGNtAjaxMjLpmTTc
        v2EFCRL1iFfOoE5yJrG39Am6ii4/G/jCiMqF7lQo/JZFdgNVKa6ODH85ABvTG8dRgquf5sPBjfTfQ
        r5t/D2c1I8Rioz3M+qX7xNzzTVqU7l/3YttgKyT7+kZ1yCO/oTXuSplgVOabYYNHtVWUrHpLEDleG
        yd5a2DjsYrJMwA1sbE60s4dMswTOaERUXYed5RJzWv3UMMDGq7CyU6+27JFHH9iXWUy4BmKOz71Sk
        xZoOST8/HjTOmp2gpPdQWcLsedFFzGBwZmFR3GRW8kXE2SsUSKvWeVgW+K95VEiXLxLtjV1ej6sTu
        ic5sB9sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os4sP-009Ut4-Uj; Mon, 07 Nov 2022 16:21:33 +0000
Date:   Mon, 7 Nov 2022 16:21:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 0/3] new subsystem for compute accelerator devices
Message-ID: <Y2kwjawUuFGDvr20@casper.infradead.org>
References: <20221106210225.2065371-1-ogabbay@kernel.org>
 <6f756dec-b386-a822-5f52-c121c00525b4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f756dec-b386-a822-5f52-c121c00525b4@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:07:28AM -0700, Jeffrey Hugo wrote:
> > Another important change is that I have reverted back to use IDR for minor
> > handling instead of xarray. This is because I have found that xarray doesn't
> > handle well the scenario where you allocate a NULL entry and then exchange it
> > with a real pointer. It appears xarray still considers that entry a "zero"
> > entry. This is unfortunate because DRM works that way (first allocates a NULL
> > entry and then replaces the entry with a real pointer).
> > 
> > I decided to revert to IDR because I don't want to hold up these patches,
> > as many people are blocked until the support for accel is merged. The xarray
> > issue should be fixed as a separate patch by either fixing the xarray code or
> > changing how DRM + ACCEL do minor id handling.
> 
> This sounds sane to me.  However, this appears to be something that Matthew
> Wilcox should be aware of (added for visibility).  Perhaps he has a very
> quick solution.  If not, at-least he might have ideas on how to best address
> in the future.

Thanks for cc'ing me.  I wasn't aware of this problem because I hadn't
seen Oded's email yet.  The "problem" is simply a mis-use of the API.
