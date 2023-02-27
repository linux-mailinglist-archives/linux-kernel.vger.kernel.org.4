Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260F6A3F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjB0KiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB0KiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:38:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE74ED2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677494279; x=1709030279;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lbriUZ8YDUdLm75pRAQtvLKSIwX7Z6Uxi7I/SUAfONw=;
  b=j5c6+i84osimtTv0GxX/es5kl1HXMUAEErh99hiRTXKSqVo13djj+FjV
   f7hl55d4nLWwzA8OQmy9gOZm6NijeT7UfcNwhT3YvCFhfjfwPEqXZL9W6
   14Zyh+TXnGECsMFSt0i1a0PWrmR8cg9RUCh4WFNdoUf0INllI+JKFI1F0
   4l5Nj3U7C42o//0ASXR0KUUjMNbXWDIBYlJRkWtH4LjBipt5IWF3eKmiP
   wuZ16tyUU88poxBhcZOevCABBH36ZH0Cf88W1FV6aNDoTv1nth8RgY7pM
   2cdLpw74cZQ1htX6ESbHIrEteKsfPn7eSAZzuv+zSWs1djrkAezmNBvgi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335310497"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="335310497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 02:37:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="706136106"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="706136106"
Received: from jkaisrli-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.158])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 02:37:49 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
In-Reply-To: <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <ab018466-1659-d54d-4144-5e0879815de6@suse.de>
 <e9364e10-1ad8-aaaf-3d78-a29b0c1516ef@collabora.com>
 <6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com>
Date:   Mon, 27 Feb 2023 12:37:46 +0200
Message-ID: <87a60z2y2t.fsf@intel.com>
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

On Mon, 27 Feb 2023, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> On 2/17/23 16:41, Dmitry Osipenko wrote:
>> On 2/17/23 16:28, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> I looked through the series. Most of the patches should have an r-b or
>>> a-b at this point. I can't say much about patch 2 and had questions
>>> about others.
>>>
>>> Maybe you can already land patches 2, and 4 to 6? They look independent
>>> from the shrinker changes. You could also attempt to land the locking
>>> changes in patch 7. They need to get testing. I'll send you an a-b for
>>> the patch.
>> 
>> Thank you, I'll apply the acked patches and then make v11 with the
>> remaining patches updated.
>> 
>> Not sure if it will be possible to split patch 8, but I'll think on it
>> for v11.
>> 
>
> Applied patches 1-2 to misc-fixes and patches 3-7 to misc-next, with the
> review comments addressed.

Please resolve the drm-tip rebuild conflict [1].

BR,
Jani.


[1] https://paste.debian.net/1272275/


-- 
Jani Nikula, Intel Open Source Graphics Center
