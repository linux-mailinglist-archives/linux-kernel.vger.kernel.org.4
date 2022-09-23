Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36EB5E76AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiIWJTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIWJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:19:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6142FAE9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663924738; x=1695460738;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qFRpcPQ3Nucr6vmKDoOh9w6fsNE+aROgpsnIbjVMoU4=;
  b=bUKYsorL1NjFvawWOqHNdEu3qHvdsVv5YZBBoGQBp2ecE9m69qf1x/KJ
   ueaLIC1f7jpT4ydAcyXhjnyLuiE7Tyk9Dtj6jtD0WRwvSTo6exA4WKNm/
   bG7uISSIJY8fKSOEbhSWAFKR9Flr6g2iO0nk++UXKRN1tWXOXKMOjUBAD
   ir8DYBKPQsUXIK1VzQ4HIA1FxiPd0grwqCQ5w5pCFOQwWhSIIscXpNrEU
   zWe2HTKrqCVsDIiQx2HtygspPbC0kEitue1p6ZmSlfJm/nt0Loy0gUAq7
   7eVl4AroO5WHa3rQaYos0fIoGpeB4xh15kLN4zjezIAJ+70/FCU6cm5P8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298151934"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298151934"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:18:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865231225"
Received: from armannov-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.61.93])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:18:50 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 10/33] drm/modes: Add a function to generate analog
 display modes
In-Reply-To: <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-f733a0ed9f90@cerno.tech>
 <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
Date:   Fri, 23 Sep 2022 12:18:32 +0300
Message-ID: <87h70y4ffb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 22.09.22 um 16:25 schrieb Maxime Ripard:
>> +	drm_dbg_kms(dev,
>> +		    "Generating a %ux%u%c, %u-line mode with a %lu kHz clock\n",
>> +		    hactive, vactive,
>> +		    interlace ? 'i' : 'p',
>> +		    params->num_lines,
>> +		    pixel_clock_hz / 1000);
>
> Divide by HZ_PER_KHZ here and in other places.
>
>    https://elixir.bootlin.com/linux/latest/source/include/linux/units.h#L23

From the Department of Bikeshedding:

I find "pixel_clock_hz / 1000" has much more clarity than
"pixel_clock_hz / HZ_PER_KHZ".

I don't consider the SI prefixes magic numbers.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
