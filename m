Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7321E6C68C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCWMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:47:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7CFF5;
        Thu, 23 Mar 2023 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679575628; x=1711111628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30e+iacdeNDPi27w7ie3RbTMuGmuD+8WwfFs1tSEjl4=;
  b=ariwPPxpmrykYm93sHDD9/VPYMC3eeHl/AEnzIdq2QvzbM8wjwxhP3eY
   Pn5PuWch7y1gD0oV13jQ9TJukbfT9NfWNNH3WnJK6y5kLbrutTujLkSc9
   3kj0mL2oZpbt7XcjZkQAmPvraZHLtY8SRB4O1z+frgGk4LiEcdg+LPpEb
   UNqgbtY/YzDlsKsR1nktD2zfSnbudyMUAjpMM+vtBOg56uNc6MaJSy1el
   9xqh66Dwmf0BxrRXrWVG51Ljs5zxM0eJEVbjzPBzTE9Jg1k2JalL9vRA0
   ayHcsuLC+AsD6BvIc5D8tnDKVmVBMiiCjHBtxS4R0QJvw9o7YCfbOxJ+g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341013528"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341013528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682292594"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="682292594"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2023 05:46:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfKLG-007VoD-1R;
        Thu, 23 Mar 2023 14:46:54 +0200
Date:   Thu, 23 Mar 2023 14:46:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v14 03/10] drm/display: Add Type-C switch helpers
Message-ID: <ZBxKPiduTQ2A49Dy@smile.fi.intel.com>
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-4-treapking@chromium.org>
 <CAA8EJpqFuhAtTaTJNMmfaQoYaKF_t6N2QMgbOS1c9XVey8Jf3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqFuhAtTaTJNMmfaQoYaKF_t6N2QMgbOS1c9XVey8Jf3w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:38:49AM +0200, Dmitry Baryshkov wrote:
> On Wed, 22 Mar 2023 at 12:47, Pin-yen Lin <treapking@chromium.org> wrote:

...

> > +config DRM_DISPLAY_DP_TYPEC_HELPER
> > +       bool
> > +       default y
> > +       depends on DRM_DISPLAY_HELPER
> > +       depends on DRM_DISPLAY_HELPER=TYPEC || TYPEC=y
> 
> If it is a select'able option, it doesn't make sense to use "depends"
> here. Select will override depends.

He-he, not so easy. This will help to find configurations that miss these
dependencies. Arnd taught me that. IIRC the ASoC subsystem has a lot of
such cases.

> > +       help
> > +         DRM display helpers for USB Type-C Displayport Alternate mode.

-- 
With Best Regards,
Andy Shevchenko


