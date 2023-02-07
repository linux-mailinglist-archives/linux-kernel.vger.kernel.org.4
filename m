Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86DA68E33E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBGWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBGWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:07:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31E4226;
        Tue,  7 Feb 2023 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675807630; x=1707343630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZY6Ki7VN2EVVLpc44J2WKNXk7yMANdJzThAVNunvAuc=;
  b=PuMGcqPM+UP7wVe3NHGH6xmvamGYvMRrftd9r89HnQZIYorGg2gN6EYa
   21XZDYCoX0rZrMcbiNgmDWTXsPDdT7saUwj7gERojh0IhwUPiXT4ccbEr
   drNBRh2d8TNhQ8Ipo1mXkeC+VaODqk14+zhcoOUO3eJ+ysmKjBiHO+6KZ
   kS30LO8jmZpSY06CB8wIXs7TXtbCaqK5io/0/3IpiHJizFkwavjXurfwS
   yWGkpDH5XaOG1RLl/lHHPYrW3Kvq+ynme5htWkyrBt5KDWkyR8s7qq+Wx
   p/H24XbIUShlhO27rYYchd2qmiZdm6imwFl2QSHhXb647fW+b9Cn5DfYq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="392037719"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="392037719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755785563"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="755785563"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 14:06:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pPW6z-003nyL-37;
        Wed, 08 Feb 2023 00:06:49 +0200
Date:   Wed, 8 Feb 2023 00:06:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <keescook@chromium.org>, ionut_n2001@yahoo.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false
 positive warnings
Message-ID: <Y+LLeYF7CtLjeLbt@smile.fi.intel.com>
References: <20230106061659.never.817-kees@kernel.org>
 <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
 <202301061217.816FC0313D@keescook>
 <Y7jODnbUqCwfwwHI@pendragon.ideasonboard.com>
 <CANiDSCvB8vRp43A1J4BpNZveCvG66XbDmnkKZykbWSFCLX1XUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCvB8vRp43A1J4BpNZveCvG66XbDmnkKZykbWSFCLX1XUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:46:00AM +0100, Ricardo Ribalda wrote:
> Hi Laurent
> 
> I was thinking about something on the line of the attached patch,
> 
> uvc_frame_header->data could also be replaced with a union.
> 
> Warning, not tested ;)

...

> +struct uvc_frame_header {
> +	u8 length;
> +	u8 flags;
> +	u8 data[];
> +} __packed;

__packed! (See below)

...

> +		pts = (u32 *) header->data;

Ai-ai-ai.
Here is just a yellow flag...

...

>  	uvc_dbg(stream->dev, FRAME,
>  		"%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
>  		__func__, ktime_to_ns(time), meta->sof, meta->length,
>  		meta->flags,
> +		has_pts ? *pts : 0,

...and here is a red flag. What you need to have is

	void *pts;
	u32 pts_val;

	pts_val = get_unaligned_be32(); // or le32

	...use pts_val...

> +		has_scr ? scr->scr : 0,
> +		has_scr ? scr->frame_sof & 0x7ff : 0);


-- 
With Best Regards,
Andy Shevchenko


