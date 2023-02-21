Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE569E226
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjBUOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjBUOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:18:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5A28218
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8316A60FFC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F97C433D2;
        Tue, 21 Feb 2023 14:18:35 +0000 (UTC)
Message-ID: <9d5346bf-526d-d8ec-d055-175aae429638@xs4all.nl>
Date:   Tue, 21 Feb 2023 15:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/9] drm/vc4: Switch to container_of_const
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20221207-rpi-hdmi-improvements-v2-0-8ace2d8221ad@cerno.tech>
 <20221207-rpi-hdmi-improvements-v2-1-8ace2d8221ad@cerno.tech>
 <c70e40fe-6834-2382-ec89-28714a67fd1f@xs4all.nl>
 <20230221113834.i3nitxp4soev6cks@houat>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230221113834.i3nitxp4soev6cks@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 12:38, Maxime Ripard wrote:
> Hi Hans,
> 
> On Sat, Feb 18, 2023 at 11:45:04AM +0100, Hans Verkuil wrote:
>>> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
>>> index 86d629e45307..d0a00ed42cb0 100644
>>> --- a/drivers/gpu/drm/vc4/vc4_bo.c
>>> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
>>> @@ -609,7 +609,7 @@ static void vc4_free_object(struct drm_gem_object *gem_bo)
>>>  static void vc4_bo_cache_time_work(struct work_struct *work)
>>>  {
>>>  	struct vc4_dev *vc4 =
>>> -		container_of(work, struct vc4_dev, bo_cache.time_work);
>>> +		container_of_const(work, struct vc4_dev, bo_cache.time_work);
>>
>> ...I think this is misleading. It's definitely not const, so switching to
>> container_of_const suggests that there is some 'constness' involved, which
>> isn't the case. I'd leave this just as 'container_of'. This also reduces the
>> size of the patch, since this is done in quite a few places.
> 
> The name threw me off too, but it's supposed to keep the argument
> pointer constness, not always take and return a const pointer. I still
> believe that it's beneficial since, if the work pointer was ever to
> change constness, we would have that additional check.

If both inner (work) and outer (vc4) pointers are non-const, then there is no sense
in switching to container_of_const. I don't see it used like that elsewhere
in the kernel.

It only makes sense to use it if the inner pointer might be const.

If the work pointer (in this example) would ever become const, then the
regular container_of macro would report a warning, that's something that
was added in commit 7376e561fd2e. So preemptively switching to container_of_const
appears unnecessary to me.

Regards,

	Hans
