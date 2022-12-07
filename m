Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5681764550E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLGIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLGIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:05:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241C286D7;
        Wed,  7 Dec 2022 00:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD2D60920;
        Wed,  7 Dec 2022 08:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3702C433D6;
        Wed,  7 Dec 2022 08:05:14 +0000 (UTC)
Message-ID: <662957b7-562e-d8ca-0afe-bef484c16b7e@xs4all.nl>
Date:   Wed, 7 Dec 2022 09:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media: cedrus: Convert to MPLANE uAPI
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129074530.640251-1-wenst@chromium.org>
 <45143854.fMDQidcC6G@kista> <5d79ed06-15c0-3564-97b6-5fd4433acabf@xs4all.nl>
 <CAGXv+5GH==gm533P_sNiFTyaFwQXp-QLXRLWyABdsn+0p_83UQ@mail.gmail.com>
 <6c75bbbf497f9baa5d99f642bd466751e2b0d460.camel@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <6c75bbbf497f9baa5d99f642bd466751e2b0d460.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 20:15, Nicolas Dufresne wrote:
> Le mardi 06 décembre 2022 à 20:23 +0800, Chen-Yu Tsai a écrit :
>> On Tue, Dec 6, 2022 at 4:35 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>>
>>> On 05/12/2022 22:01, Jernej Škrabec wrote:
>>>> Hi Chen-Yu!
>>>>
>>>> Dne torek, 29. november 2022 ob 08:45:30 CET je Chen-Yu Tsai napisal(a):
>>>>> The majority of the V4L2 stateless video decoder drivers use the MPLANE
>>>>> interface.
>>>>>
>>>>> On the userspace side, Gstreamer supports non-MPLANE and MPLANE
>>>>> interfaces. Chromium only supports the MPLANE interface, and is not yet
>>>>> usable with standard desktop Linux. FFmpeg support for either has not
>>>>> landed.
>>>>
>>>> I don't like fixing userspace issues in kernel, if kernel side works fine.
>>>> Implementing missing non-MPLANE support in Chromium will also allow it to work
>>>> with older kernels.
>>>>
>>>> Hans, what's linux-media politics about such changes?
>>>
>>> Not keen on this. Does the cedrus HW even have support for multiple planes?
>>> I suspect not, in which case the driver shouldn't suggest that it can do that.
> 
> Hi Hans,
> 
>>>
>>> Now, if the hardware *can* support this, then there is an argument to be made
>>> for the cedrus driver to move to the multiplanar API before moving it out
>>> of staging to allow such future enhancements.
>>
>> AFAIK it can, but has some limitations on how far apart the buffers for
>> the separate planes can be. Nicolas mentioned that I could support the
>> multiplanar API, but only allow the contiguous single planar formats,
>> so NV12 instead of NV12M.
> 
> indeed, MPLANE buffer API is not an advertisement for MPLANE support. The pixel
> formats exposed through ENUM_FMT are the only possible advertisement, and only
> single allocation format (NV12) remains exposed.
> 
> Putting my userspace hat on, I see see an effort by the author of MPLANE API to
> make it so it would completely replaced the older API. The effort have imho very
> bad consequences (duplication of pixel formats), but if we also don't enforce
> porting existing drivers to the new API, we add yet another consequence, but
> this time on userspace, which must handle both C structures to actually work
> generically. I totally understand that from driver maintainer point of view,
> this change have absolutely no value, but we force userspace complexity simply
> because we leave it to driver author to pick older or newer (totally equivalent)
> APIs. To me, the problem is that V4L2 API maintainers didn't adopt the new API
> despite merging it. The adoption should have deprecated usage of the old API, at
> least in new drivers (since 2011). This should also have been an unstaging
> requirement.

I know all about it. We made design mistakes in hindsight. It's not just
that there are effectively two APIs, it is also that the MPLANE API has
awkward data structures. There have been proposals (starting with Helen
Koike) to fix this, but it never got the momentum. I still think that is
the way to go forward, but someone needs to take that ball and start
pestering the core maintainers to give feedback and really give it the
time it deserves.

The core issue for the MPLANE API was the gray area in design where you
have to decide to go with a completely new API or tweaking an existing API.

Certainly at the time this was designed we tended to be conservative and
went with tweaks. Today, after gaining years of additional experience, we
would go with a new redesigned API.

Regards,

	Hans

> 
> regards,
> Nicolas
> 
>>
>> And I suspect that reference frames have to be contiguous as well.
>> So I guess the overall answer is that it can't. But the same goes for
>> Hantro or rkvdec, which both use the multiplanar API.
>>
>> This conversion was done so that I could use Cedrus as a testbed for
>> developing new codec support, as I already own an H6 device. Added
>> bonus is trying to get V4L2 decoder support to work for desktop Linux,
>> without the libraries that ChromeOS ships.
>>
>>> Note that you have to choose whether to support single or multiplanar, you
>>> can't support both at the same time.
>>>
>>> So the decision to move to multiplanar should be led by the HW capabilities.
>>>
>>> And Chromium really needs to support non-multiplanar formats as well. I'm
>>> really surprised to hear that it doesn't, to be honest.
>>
>> Chromium does support non-multiplanar formats, such as NV12. In fact
>> this is the preferred format, unless it's on MediaTek, in which it
>> switches to MM21 as the capture format, and does untiling in software.
>> This support for formats is separate from using the multiplanar API.
>>
>> Support for video decoders is mostly driven by ChromeOS. Currently all the
>> hardware ChromeOS supports, be it stateful or stateless, use the multiplanar
>> API, so there hasn't been a real need to support it yet.
>>
>>
>> Regards
>> ChenYu
>>
>>> Regards,
>>>
>>>         Hans
>>>
>>>>
>>>> Best regards,
>>>> Jernej
>>>>
>>>>>
>>>>> A fallback route using libv4l is also available. The library translates
>>>>> MPLANE interface ioctl calls to non-MPLANE ones, provided that the pixel
>>>>> format used is single plane.
>>>>>
>>>>> Convert the Cedrus driver to the MPLANE interface, while keeping the
>>>>> supported formats single plane. Besides backward compatibility through
>>>>> the plugin, the hardware requires that different planes not be located
>>>>> too far apart in memory. Keeping the single plane pixel format makes
>>>>> this easy to enforce.
>>>>>
>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>> ---
>>>>>
>>>>> This has been tested with Fluster. The score remained the same with or
>>>>> without the patch. This also helps with getting VP8 decoding working
>>>>> with Chromium's in-tree test program "video_decode_accelerator_tests",
>>>>> though Chromium requires other changes regarding buffer allocation and
>>>>> management.
>>>>
>>>>
>>>
> 

