Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087A6A46A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB0QCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB0QCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:02:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF72197E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677513754; x=1709049754;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GzUcXJBiPN1dZra43WnMj0WTwuVeYjywGsI5YJvho1g=;
  b=SRb8HHmJ4Oij6LLhoCF2Xrh+tYZFXjGoSvAehtaIu0aJc3s0doNK7E6q
   BRxSBLQZYpaRn2667HCajatKQZSwhii68n1+hhEalWfJd361XSxlJQb2/
   qv+CI7SpbMDOf3L31mJBHNjjEqS9vm6/GyKtZCvfcy7RtnjrfgIoyfTsR
   wTGQduD0m/6ez8F79qBfv1RwuazukjQDZArkFgoM5B7XXXkgokIiz7rrb
   4KaUMt01JBO1E0BHTF+ye8FXCyuTVYKfAJDzTLZkLnsLj/NWYleCO3ui8
   d6Gi9vJbiwlSiMVA1WcxvkPYUxZNBBA/WOtxGZuIrZbkjucB8ga7wQ6yj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="420153540"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="420153540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:02:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="706233045"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="706233045"
Received: from jkaisrli-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.158])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:02:30 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     maarten lankhorst <maarten.lankhorst@linux.intel.com>,
        maxime ripard <mripard@kernel.org>,
        thomas zimmermann <tzimmermann@suse.de>,
        david airlie <airlied@gmail.com>,
        daniel vetter <daniel@ffwll.ch>,
        jim cromie <jim.cromie@gmail.com>,
        sam ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 1/7] drm/print: Fix and add support for NULL as first
 argument in drm_* macros
In-Reply-To: <18693900367.2ce71ba5548919.6872574648582795181@siddh.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1677395403.git.code@siddh.me>
 <89f0aa1f26696846c2303527fe4d133bb4ff4bf6.1677395403.git.code@siddh.me>
 <87ilfn30li.fsf@intel.com>
 <18693900367.2ce71ba5548919.6872574648582795181@siddh.me>
Date:   Mon, 27 Feb 2023 18:02:25 +0200
Message-ID: <878rgj14ha.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023, Siddh Raman Pant <code@siddh.me> wrote:
> On Mon, 27 Feb 2023 15:13:21 +0530, Jani Nikula wrote:
>> First of all, that's two distinct changes in one patch. The subject says
>> one thing, but it's really two.
>
> Sorry, my bad.
>
>> But the main question is, do we *really* want to let callers pass either
>> struct drm_device * or struct device *? It will be type safe with
>> generics, but if it's okay to use either, people *will* use either. The
>> call sites will end up being a mixture of both. You can't control it. It
>> will be very tedious if you ever want to revert that decision.
>> 
>> Do we want to promote a style where you can pass either? To me, in C
>> context, it seems awfully sloppy and confusing rather than convenient.
>> 
>> I'd argue the struct mipi_dsi_host stuff should use dev_* calls
>> directly, as it's more of a special case, rather than allow struct
>> device * in drm_* logging macros.
>
> I agree. I thought direct dev_* calls would not be ideal, as there is a
> TODO to move away from that, and also incorrectly expected to have more
> such dev ptr problems. But on a second thought, you are correct.
>
> Should I post a new patch, with using __drm_dev_ptr instead and
> removing the __get_dev_ptr generic macro, and using dev_* in
> drm_mipi_dsi.c as `dev_err(dev, "*ERROR* [drm] <msg>", ...);`?

I think commit 1040e424353f ("drm: mipi-dsi: Convert logging to drm_*
functions.") and any similar ones should just be reverted. It worked by
accident. You're supposed to pass struct drm_device * to the drm_*
logging functions, and that passes struct mipi_dsi_host *.

BR,
Jani.



>
>> BR,
>> Jani.
>
> Thanks,
> Siddh

-- 
Jani Nikula, Intel Open Source Graphics Center
