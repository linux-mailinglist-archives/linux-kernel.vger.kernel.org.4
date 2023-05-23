Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCC70D993
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjEWJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjEWJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:51:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F5E7C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684835403; x=1716371403;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=z+PhmPjSvAdptOmQesLi0iHqQbygzxTXNrjRxXGKZnA=;
  b=fd4eHArl+uLYRLw26dzwqU8S6TMb33JC7b3wJ4aD9kubheNSbCeI0jCL
   QACTZeXpJrNZAwMiKvQ4dXiJG2buEtkptOj3W69dCO+89drwwWcrxLU/6
   qBA9DQs+amYPwtwxlsZnW09XWl2yfOX406nICUR9xGuJOLD0a59jxd8nu
   e6+T6sTrVZWyg+XL8/UI2iNRgiLz+OmqxaOPUAqP6upFrmYk1TPI4vd0e
   HYzJT4s0NadwzJ+sqB3A38+OBaSa5a2CaIbxw7s9aL581BqdD/n84vzc9
   afPJ5AOTpvfwMosR9VjRYJJbduODlRhlJzKQzJOGeMkLYTewQWYRFhA/5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342651762"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="342651762"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="681325468"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="681325468"
Received: from chauvina-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.70])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:49:59 -0700
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
In-Reply-To: <87a5y3guvv.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
 <87cz2zgvdd.fsf@intel.com>
 <2a1b81da-39c8-4111-7e42-18f5f2f557c4@linaro.org>
 <87a5y3guvv.fsf@intel.com>
Date:   Tue, 23 May 2023 12:49:57 +0300
Message-ID: <87a5xvml6i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 17 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 17/05/2023 11:28, Jani Nikula wrote:
>>> On Thu, 11 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>> Statically allocated array of pointers to hwmon_channel_info can be made
>>>> const for safety.
>>>>
>>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> 
>>> FYI we'll merge this once we've done a backmerge to get the hwmon
>>> changes to our tree.
>>
>> There are no dependencies. hwmon changes are already in rc1.
>
> That's what I'm saying, drm-intel-next doesn't have rc1. :)

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

>
> BR,
> Jani.
>
>>
>> Best regards,
>> Krzysztof
>>

-- 
Jani Nikula, Intel Open Source Graphics Center
