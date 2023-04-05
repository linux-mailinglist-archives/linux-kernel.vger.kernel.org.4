Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2C6D789F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjDEJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjDEJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:41:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FCC90;
        Wed,  5 Apr 2023 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680687709; x=1712223709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVOobzmnj++i6/mTKNgBVbf82YVzMo2cPA27RJYUBOw=;
  b=WYqB7Va5djM/Yk/74wEawGWrJtjQdbptwGGlKz/Qa9y0Nse88o3GUNXf
   s86u3QaOKPrwJBDTYsHxCqk/9YsvNBncOfppYuk56ljhGwL0asBefhiMU
   p0jW07msRJapnnCnS3FctdDo5jWOX0OH3AfxLj7vG8sRsX8OcySt8fYXb
   ch3ucxPAIi2+zVQxDuf0Q/ZkhyuwoqlJcibpVtrrEf4ewmU4FE4TZ0LbK
   mbV7mG+1vvQr+SiukBPpoaD5PLOdJ1QuPC0HFMBQbx76h/u8PJZI9g5h5
   0gOM+ddQkvcNvCjCqfC2D01biY6KwOH/O7fPRSZf0aNwi9oB/3So+tp6q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326445343"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326445343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="830301145"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="830301145"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2023 02:41:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1225913A; Wed,  5 Apr 2023 12:41:47 +0300 (EEST)
Date:   Wed, 5 Apr 2023 12:41:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Olliver Schinagl <oliver@schinagl.nl>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/2] iopoll: Introduce ioreadXX_poll_timeout() macros
Message-ID: <20230405094147.GS33314@black.fi.intel.com>
References: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
 <3a348abc-d1f3-364f-88de-a0012fbc0fde@schinagl.nl>
 <ZC04J30xQTVPJ1ho@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC04J30xQTVPJ1ho@smile.fi.intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 05, 2023 at 11:58:15AM +0300, Andy Shevchenko wrote:
> On Fri, Mar 31, 2023 at 10:12:31AM +0200, Olliver Schinagl wrote:
> > On 30-03-2023 16:14, Andy Shevchenko wrote:
> 
> ...
> 
> > But I actually have a small addendum for this series, as it will break
> > `drivers/net/wwan/t7xx/t7xx_dpmaif.c` due to a redefinition (yeah I know).
> > 
> > So I have:
> > https://gitlab.com/olliver/linux/-/commit/c9e591f2dabb2dbaeceebee61fa70b70fdbffc2a
> > https://gitlab.com/olliver/linux/-/commit/41e0f8c08a1c55940813a240215910336ad7bec2
> > https://gitlab.com/olliver/linux/-/commit/f36562f09b0185d403415864ef7218b46a742cdc
> > https://gitlab.com/olliver/linux/-/commit/66237fd97bc42d272602b01dc0cca541c619b2be
> > 
> > Which actually replaces silly calls like readx_poll_timeout(ioread32, ... .
> > 
> > Do you want me to (re-?)post this as a series? I can put your thunderbolt
> > (and your changes here) and post as one big series (or you can do the same
> > obviously).
> 
> I believe the best course of action is to collect this series and your fix
> in your hands and send it as a material for Linux WWAN subsystem with Mika's
> Ack (if he has no objections). That said, let's wait for Mika's answer
> on this.

No objections from my side.
