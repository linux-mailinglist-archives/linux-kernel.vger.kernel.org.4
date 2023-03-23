Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF46C68BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCWMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:45:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBE298DF;
        Thu, 23 Mar 2023 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679575521; x=1711111521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z034CEWDZWzBHQVHZYtVHoLpxMyCoA3kXaDvrv1Q98w=;
  b=XR4GbRRxOLhhGzwBKbILpOX2956u5kEKM+CllvviJ4Jy3MIGM93tW+TZ
   mSkinGjVbUsmmlOF8Or0B+wAS0kdxXGh9OigJWr3C+UrE63ERJ79538Nt
   hJczlBfMoR2s4il6/2qlHSll8Y8SXvoUq0g//i6PjhuyKr2VZ9UMZ+HJ0
   LkQBmAOfb7uG5K1lsRJ9HFUO1SEz2mJZolQn8KdCyyuWVMXWoXHh8G3kg
   t2Z0Bc7kiFCbnNPz9/wyrA/YxWexLzaedr5iinOnLE//A7O3rkPxkMVuD
   TeO6DUipnZurcsVfb9HlHeEgjifMzkAXnClXpSYht2/X5cUHrrrNW3Ov7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338196404"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338196404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632383474"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="632383474"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 05:45:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfKJU-007VlG-0v;
        Thu, 23 Mar 2023 14:45:04 +0200
Date:   Thu, 23 Mar 2023 14:45:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v14 03/10] drm/display: Add Type-C switch helpers
Message-ID: <ZBxJz4ESBocICA/L@smile.fi.intel.com>
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-4-treapking@chromium.org>
 <ZBrgD61p/p17IOJL@smile.fi.intel.com>
 <87edpg7nub.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edpg7nub.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:27:56PM +0200, Jani Nikula wrote:
> On Wed, 22 Mar 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 22, 2023 at 06:46:32PM +0800, Pin-yen Lin wrote:
> >> +#ifdef CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER
> >
> > Ah, maybe this should use IS_REACHABLE() ?
> 
> Personally, I think IS_REACHABLE() is a build-time band-aid solution to
> a problem that should be solved in Kconfig. :p
> 
> I think it always means there's a configuration combo that shouldn't
> exist, and it's a surprise to the user when they've configured
> something, Kconfig has deemed it a valid configuration, but they don't
> get the feature they want.
> 
> As a user, how would they even debug that case? Double check configs,
> don't see anything wrong.

Usual pairing is 'imply FOO' in Kconfig & 'IS_REACHEABLE(CONFIG_FOO)' in the
code. And I believe it's not an abnormal.

-- 
With Best Regards,
Andy Shevchenko


