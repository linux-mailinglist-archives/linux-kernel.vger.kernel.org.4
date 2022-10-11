Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037E5FADF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJKIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:02:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E37E82F;
        Tue, 11 Oct 2022 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665475343; x=1697011343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+b82CYjgMEujCSIoPnH6pFh6QJ1B+w+5htV6oxWegnY=;
  b=aXw3H84mkLcbhSUZGTXWJnjvq/eitHKHJ9NS4Wv0iMEoTY+UawVtbnW0
   F7PvnpUfXL145SS1k1e3/fJCb+8bfVjX3ahDN5boYtBabj8ZgbaW6MpYm
   pch/rsdYPiwaARqUYwIIh9op7ggbqtHteNErr16iFP2khk4krnuud0ssN
   x7f5qM+m6BgF3Mqn4Mwy8ZasLCIdsSe+j/UGgt606FYrr5dp8t2XCpMOz
   s/WMFzevdPzl2L2eCXw3H5ZeSuv6pD4OmaRcdDmdCi5BQM70C8wmaXOoK
   pflvjkwbqGX+UyMZVPanHmAyzCtqkM06Tiar5Qv7RUlRC9N1crk1aiNcI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284820330"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="284820330"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 01:02:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="871417580"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="871417580"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 01:02:20 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 4985B20387;
        Tue, 11 Oct 2022 11:02:18 +0300 (EEST)
Date:   Tue, 11 Oct 2022 08:02:18 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: i2c: ov5645: Use runtime PM
Message-ID: <Y0UjCitXWh5tHQG7@paasikivi.fi.intel.com>
References: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vQce5+my5nQr=CiJf9KtuHgzmt18PT1kwp9Nq8ADHYFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vQce5+my5nQr=CiJf9KtuHgzmt18PT1kwp9Nq8ADHYFw@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Oct 10, 2022 at 09:04:22PM +0100, Lad, Prabhakar wrote:
> Hi,
> 
> On Tue, Sep 27, 2022 at 9:16 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Switch to using runtime PM for power management.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/media/i2c/Kconfig  |   2 +-
> >  drivers/media/i2c/ov5645.c | 135 +++++++++++++++++++------------------
> >  2 files changed, 69 insertions(+), 68 deletions(-)
> >
> I know it's too early, but I dont want to miss the v6.2 window for
> RZ/G2L CRU driver [0].
> 
> Gentle ping for review.

I'll check the patch now but will apply once we have -rc1 in media tree.

-- 
Sakari Ailus
