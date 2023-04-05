Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475066D7F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjDEOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbjDEOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:19:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181765BC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680704323; x=1712240323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P2RqPac9TO0CaODUD6qKdkCCEU6OfG21RarkLTKjyUs=;
  b=S+Ah9AHQEPqLk2u/FfricfnYUX95swK1/vJFT6sAvPkgO3GlUG6dwRAn
   /ppiLe4S1HUbQfG7S795mrQ8c9Go7puQMx/Z3ZXyk9P8tO5xOVQq7YDVY
   hUYytqB9Jj+WHGjw7SfdAAzYXYQQ9wPKkMC4WBcBUyQq52CHMb5psaGbD
   y+IX/XZjvYzpwmbnKMWAI0WpZBKEx2GGPpF3R6/xqJTIhxcwMas1LHs3o
   aCUMwlDjhYn7RssqtH5fcuEY4tOMinyeh/FcvgFKZ/005HZZ+d4SBQGfP
   3J+GqhEy4xPZ8NKu1c1n16D06h+jLaJPyWA97YYRogbCaJB0K+D+9P/n8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345042331"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="345042331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 07:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="664052961"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="664052961"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.30.7]) ([10.213.30.7])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 07:16:16 -0700
Message-ID: <50dce146-f7b0-89ff-34f6-d0ddbda4c158@intel.com>
Date:   Wed, 5 Apr 2023 16:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/gt: Hold a wakeref for the active
 VM
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Chris Wilson <chris.p.wilson@linux.intel.com>
References: <20230330-hold_wakeref_for_active_vm-v2-1-724d201499c2@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230330-hold_wakeref_for_active_vm-v2-1-724d201499c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.2023 16:16, Andrzej Hajda wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> There may be a disconnect between the GT used by the engine and the GT
> used for the VM, requiring us to hold a wakeref on both while the GPU is
> active with this request.
> 
> v2: added explanation to __queue_and_release_pm
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> [ahajda: removed not-yet-upstremed wakeref tracking bits]
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>


Queued.

Regards
Andrzej

