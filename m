Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BAC6CA096
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjC0JzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjC0JzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:55:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6A49EA;
        Mon, 27 Mar 2023 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679910909; x=1711446909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7IhxYtUl63wNn0Vd3goQKvs/9xlUppgTbWbUbCY2K5A=;
  b=izrSIpBH0siZv76fdxseD2jQDGcJy3POY0jvCqkpkuJdyDaLlSb5oMm+
   bRYMKpoOoap1cn7eil/j1WaoBS58OsjdNbo5xWgnKqZ3vzXr4vceIx43z
   V7ScG+hNHwcOeTNP26JHTqgjLFwH6iUjN2NzuaI6+1GtKKaojiBzxPy/u
   B3gnRLnshn192MEgWXH54+3xZpGWStV4t31zC0Zh0DFkjXhFe0Wom3RJS
   DocBXtEey1j+BJBcIyrdHH8i5ZxMtU27xLGMBT/CKRH7BGKqjV5ZTbuFK
   cd1Nq2I0yfzqPFEowmMuy0OIrERPEHI4ZYvpxvbc0sYE+Eytcg1V3RM8Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="320626300"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="320626300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="826983666"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="826983666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 02:55:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgjZA-009AMh-2f;
        Mon, 27 Mar 2023 12:55:04 +0300
Date:   Mon, 27 Mar 2023 12:55:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZCFn+A6oAVNOe3yp@smile.fi.intel.com>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
 <ZB2k9m7rL7Hpy/zU@fedora>
 <ZB2qI7k/Igws5khg@smile.fi.intel.com>
 <ZB3DJjQLa48AodSD@fedora>
 <ZCDc0zPtPSyDgOaF@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCDc0zPtPSyDgOaF@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc clang (for the ideas you might have, while the issue seems related to GCC[?] )

On Sun, Mar 26, 2023 at 08:01:23PM -0400, William Breathitt Gray wrote:
> On Fri, Mar 24, 2023 at 11:35:02AM -0400, William Breathitt Gray wrote:
> > There are eight calls to quad8_control_register_update() in 104-quad-8:
> > 
> >         quad8_control_register_update(priv, priv->idr, id, DISABLE_INDEX_MODE, INDEX_MODE);
> >         quad8_control_register_update(priv, priv->cmr, id, mode_cfg, QUADRATURE_MODE);
> >         quad8_control_register_update(priv, priv->ior, event_node->channel, flg_pins, FLG_PINS);
> >         quad8_control_register_update(priv, priv->idr, channel_id, index_polarity, INDEX_POLARITY);
> >         quad8_control_register_update(priv, priv->idr, channel_id, synchronous_mode, INDEX_MODE);
> >         quad8_control_register_update(priv, priv->cmr, count->id, count_mode, COUNT_MODE);
> >         quad8_control_register_update(priv, priv->ior, count->id, enable, AB_GATE);
> >         quad8_control_register_update(priv, priv->ior, count->id, !preset_enable, LOAD_PIN);
> 
> I attempted the cross-compiling using an x86-64 system and I was able to
> recreate the build error. I tried to isolate the problem line by
> commenting out quad8_control_register_update() calls and discover that
> this appears to be an inline issue after all: if there are more than six
> calls to quad8_control_register_update() are in the code, then the
> '__bad_mask' build error occurs.
> 
> The build error doesn't occur if I force the inline via __always_inline,
> so I'll add that to quad8_control_register_update() to resolve this
> issue and submit a v3 patchset later this week.

Doe it mean it's a compiler error? Or is it a code error?

I'm wondering if clang also fails here.

-- 
With Best Regards,
Andy Shevchenko


