Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1B706447
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjEQJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:38:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24C240C1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684316331; x=1715852331;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=CNGqGF8c6TYzh812PwaejYLAHsNgbc/gb9bSy9QoNbo=;
  b=E/WmMibq2L1kB6srTqhqMeolSADe56AG7PKFDZR0P6tA89WQ2Ekb7vRN
   UibU/Q98Bgd5/M8o0jhRyMkQPovvhfVt4kZj0OpwttuJTCNQi5vrrBH4k
   it7+ztMaVgNss/vL0j8cuqzyDat3Yk55SlHYw2r2LYtXKFhkjYxzAsuE3
   +Xj8moW5J0jQO4rKRWh/Hk+SunHjRV2/YV6Ed6M3piSXGZlrZJWPIrHc6
   T5EOy22q52T08Vquhri8I7GqhsfNc5b/gdqpI+yfmVnI82e/xLM6SNKJ8
   88uNbdDPe52b797wwg34poCDS/Mh2Q5GrlfkYknJdo4Z4V05ryGgzPdW0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331329006"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="331329006"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 02:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="948199481"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="948199481"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.50.207])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 02:38:47 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/i915: constify pointers to hwmon_channel_info
In-Reply-To: <2a1b81da-39c8-4111-7e42-18f5f2f557c4@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
 <87cz2zgvdd.fsf@intel.com>
 <2a1b81da-39c8-4111-7e42-18f5f2f557c4@linaro.org>
Date:   Wed, 17 May 2023 12:38:44 +0300
Message-ID: <87a5y3guvv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 17/05/2023 11:28, Jani Nikula wrote:
>> On Thu, 11 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>> Statically allocated array of pointers to hwmon_channel_info can be made
>>> const for safety.
>>>
>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> 
>> FYI we'll merge this once we've done a backmerge to get the hwmon
>> changes to our tree.
>
> There are no dependencies. hwmon changes are already in rc1.

That's what I'm saying, drm-intel-next doesn't have rc1. :)

BR,
Jani.

>
> Best regards,
> Krzysztof
>

-- 
Jani Nikula, Intel Open Source Graphics Center
