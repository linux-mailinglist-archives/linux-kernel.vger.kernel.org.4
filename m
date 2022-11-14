Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70D627A27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiKNKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiKNKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:12:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BD2037F;
        Mon, 14 Nov 2022 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668420643; x=1699956643;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zc1y8BWK7mjmeSrhkG74pWOJjIpoWMU+QYmFu9YybfI=;
  b=LOlu3FglsgA6OizjvqDy2TC1E2My0RUfvkLc3UmgUU8kuPSmulMHTetd
   t+/VqQbkcYQKYhMySqrUrpr2VTErTEtTlMyPE756QVM9RYvGc1WK7bycz
   FpowoQ/XQTrnDQP7bby5FZNCPT9E4vUqrjfY808zm8n4p/qD8zaepnIeU
   ozWhOb652J4mWESn7PR2DkO2tA0cWqwn4RT1suaetBgWiGo95OzqqYEHe
   kWuB5iVLxAsGVhOgTZK7ayUxWP1ZQuZzQnpx8GY9CUtkJeCABB4ExUdtj
   0TPQrRfijJ8RlwkoN/ZsmXK5cT9gxKKgx75Uw8+k/gniTyUoIpvD6GOJK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313078939"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313078939"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:10:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="589312433"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="589312433"
Received: from dsmahang-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.240])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:10:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-intel tree with Linus' tree
In-Reply-To: <33ef1207-aad7-b7cd-61ac-327e9afb0699@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221114102327.6d53341e@canb.auug.org.au>
 <33ef1207-aad7-b7cd-61ac-327e9afb0699@redhat.com>
Date:   Mon, 14 Nov 2022 12:10:37 +0200
Message-ID: <87cz9p4zj6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11/14/22 00:23, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the drm-intel tree got a conflict in:
>> 
>>   drivers/gpu/drm/i915/display/intel_backlight.c
>> 
>> between commit:
>> 
>>   b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
>> 
>> from Linus' tree and commit:
>> 
>>   801543b2593b ("drm/i915: stop including i915_irq.h from i915_trace.h")
>> 
>> from the drm-intel tree.
>
> This is weird, because the:
>
>    b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
>
> commit is in 6.1-rc1, so there can only be a conflict it 6.1-rc1 has not
> been back-merged into drm-intel yet ?

That's the reason it *is* a conflict, right?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
