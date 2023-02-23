Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CD6A0865
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjBWMQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjBWMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:16:25 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73282138
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:16:22 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 65698C8008D;
        Thu, 23 Feb 2023 13:16:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id L8LRnpStdvmA; Thu, 23 Feb 2023 13:16:20 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id BEE2EC8008A;
        Thu, 23 Feb 2023 13:16:18 +0100 (CET)
Message-ID: <aac0ea4e-ce96-f487-9567-83ad9913b306@tuxedocomputers.com>
Date:   Thu, 23 Feb 2023 13:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Intel-gfx] [PATCH 2/2] Apply quirk to disable PSR 2 on Tongfang
 PHxTxX1 and PHxTQx1
To:     "Hogander, Jouni" <jouni.hogander@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Cc:     "Souza, Jose" <jose.souza@intel.com>,
        "Santa Cruz, Diego" <Diego.SantaCruz@spinetix.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Kahola, Mika" <mika.kahola@intel.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>
References: <20230222141755.1060162-1-wse@tuxedocomputers.com>
 <20230222141755.1060162-3-wse@tuxedocomputers.com>
 <Y/Z3ZJjYQIKb2LQ0@intel.com>
 <d254b88a99e0a979efb07d9298afdeb7016f0e0f.camel@intel.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <d254b88a99e0a979efb07d9298afdeb7016f0e0f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 23.02.23 um 07:27 schrieb Hogander, Jouni:
> On Wed, 2023-02-22 at 15:13 -0500, Rodrigo Vivi wrote:
>> On Wed, Feb 22, 2023 at 03:17:55PM +0100, Werner Sembach wrote:
>>> On these Barebones PSR 2 is recognized as supported but is very
>>> buggy:
>>> - Upper third of screen does sometimes not updated, resulting in
>>> disappearing cursors or ghosts of already closed Windows saying
>>> behind.
>>> - Approximately 40 px from the bottom edge a 3 pixel wide strip of
>>> randomly
>>> colored pixels is flickering.
>>>
>>> PSR 1 is working fine however.
>> I wonder if this is really about the panel's PSR2 or about the
>> userspace
>> there not marking the dirtyfb? I know I know... it is not userspace
>> fault...
>>
>> But I wonder if the case you got here highlights the fact that we
>> have
>> a substantial bug in the i915 itself in regards to PSR2 API.
>>
>> Jose, Jouni, ideas on how to check what could be happening here?
> There is already fix for this (Thanks to Werner Sembach for testing the
> patch):
>
> https://patchwork.freedesktop.org/series/114217/

Yes, thanks for creating that patch ^^

I posted this quirk patch just as an possible alternative for stable if that 
other patch is considered not suitable for it (lets wait and see).

And to get some feedback if something like this could be a viable workaround if 
similar bugs appear in the future.

>
>> oh, btw, Werner, do we have an  open gilab issue for this?
> https://gitlab.freedesktop.org/drm/intel/-/issues/7347
>
>> Thanks,
>> Rodrigo.
>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_quirks.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
>>> b/drivers/gpu/drm/i915/display/intel_quirks.c
>>> index ce6d0fe6448f5..eeb32d3189f5c 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
>>> @@ -65,6 +65,10 @@ static void
>>> quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
>>>          drm_info(&i915->drm, "Applying no pps backlight power
>>> quirk\n");
>>>   }
>>>   
>>> +/*
>>> + * Tongfang PHxTxX1 and PHxTQx1 devices have support for PSR 2 but
>>> it is broken
>>> + * on Linux. PSR 1 however works just fine.
>>> + */
>>>   static void quirk_no_psr2(struct drm_i915_private *i915)
>>>   {
>>>          intel_set_quirk(i915, QUIRK_NO_PSR2);
>>> @@ -205,6 +209,10 @@ static struct intel_quirk intel_quirks[] = {
>>>          /* ECS Liva Q2 */
>>>          { 0x3185, 0x1019, 0xa94d, quirk_increase_ddi_disabled_time
>>> },
>>>          { 0x3184, 0x1019, 0xa94d, quirk_increase_ddi_disabled_time
>>> },
>>> +
>>> +       /* Tongfang PHxTxX1 and PHxTQx1/TUXEDO InfinityBook 14 Gen6
>>> */
>>> +       { 0x9a49, 0x1d05, 0x1105, quirk_no_psr2 },
>>> +       { 0x9a49, 0x1d05, 0x114c, quirk_no_psr2 },
>>>   };
>>>   
>>>   void intel_init_quirks(struct drm_i915_private *i915)
>>> -- 
>>> 2.34.1
>>>
