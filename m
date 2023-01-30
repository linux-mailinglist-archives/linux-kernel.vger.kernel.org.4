Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255A7680D66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjA3MRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjA3MR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:17:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A51E3BE;
        Mon, 30 Jan 2023 04:17:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3474760D36;
        Mon, 30 Jan 2023 12:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A9C433EF;
        Mon, 30 Jan 2023 12:17:18 +0000 (UTC)
Message-ID: <e37b9210-2d34-1a30-0f3c-8f5c460ff128@xs4all.nl>
Date:   Mon, 30 Jan 2023 13:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v6 03/11] media: v4l2: Add extended buffer (de)queue
 operations for video types
Content-Language: en-US
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Brian.Starkey@arm.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, helen.koike@collabora.com,
        hiroh@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        tfiga@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ayaka <ayaka@soulik.info>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-4-helen.koike@collabora.com>
 <20230125200026.16643-1-ayaka@soulik.info>
 <7609d523-667a-49a8-45f5-8186de20c24b@xs4all.nl>
 <Y9Jd12nYGk2xTYzx@pendragon.ideasonboard.com>
 <02142e8c-7479-1066-b5af-dad954136adc@soulik.info>
 <197c3574-2ffa-7c8a-2372-a373123087a3@xs4all.nl>
 <413ed194-2302-1161-c74f-768faeb999f2@synaptics.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <413ed194-2302-1161-c74f-768faeb999f2@synaptics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 11:07, Hsia-Jun Li wrote:
> 
> 
> On 1/27/23 16:11, Hans Verkuil wrote:
>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> On 26/01/2023 19:36, ayaka wrote:
>>>
>>> On 1/26/23 19:02, Laurent Pinchart wrote:
>>>> On Thu, Jan 26, 2023 at 09:57:51AM +0100, Hans Verkuil wrote:
>>>>> On 25/01/2023 21:00, ayaka wrote:
>>>>>> I am currently refresh this patchset, but I didn't see the need beyond v4l2_ext_pix_fmt, which I had done.
>>>>>> On 2/23/21 20:58, Hans Verkuil wrote:
>>>>>>> On 14/01/2021 19:07, Helen Koike wrote:
>>>>>>>> Those extended buffer ops have several purpose:
>>>>>>>> 1/ Fix y2038 issues by converting the timestamp into an u64 counting
>>>>>>>>       the number of ns elapsed since 1970
>>>>>> I think application just use the timestamp field for tracking the
>>>>>> buffer. It would be just a sequence buffer.
>>>>>> At least for the most widely cases, the video encoder and decoder
>>>>>> and ISP, this field is not a wall time.
>>>>> For video capture and video output this is typically the monotonic
>>>>> clock value.
>>>>>
>>>>> For memory-to-memory devices it is something that is just copied from
>>>>> output to capture.
>>>>>
>>>>> So ISPs definitely use this as a proper timestamp.
>>>> There are both inline (live-to-memory) and offline (memory-to-memory)
>>>> ISPs. The former certainly need a proper timestamp.
>>>>
>>> I really have not seen a device that has timer starting with the epoch.
>>>
>>> I rarely know the ISP has a wall clock timer.
>>>
>>> Timestamp is not my first concern here. Offset is.
>>
>> You are working in the V4L2 core framework here, something that is used
>> by all V4L2 drivers. So everything is important. You can't just focus on
>> your own use-case.
>>
> I was trying to say we could focus on a more important item: offset.
>>>
>>>>>>>> 2/ Unify single/multiplanar handling
>>>>>>>> 3/ Add a new start offset field to each v4l2 plane buffer info struct
>>>>>>>>       to support the case where a single buffer object is storing all
>>>>>>>>       planes data, each one being placed at a different offset
>>>>>> I really care about this. But I think the data_offset field in
>>>>>> struct v4l2_plane is enough. The rest is the problem of the kernel
>>>>>> internal API and allocator.
>>>>> data_offset has proven to be very confusing and is rarely used because
>>>>> of that.
>>> Yes, I didn't know any stateful codec driver support this.
>>>>> We do need some sort of an offset field as proposed here, but it
>>>>> shouldn't be named data_offset.
>>> Maybe we could just rename it or make a union in the existing struct.
>>>> The existing data_offset field was indeed added for other purposes, to
>>>> let drivers report where the actual image data starts for devices that
>>>> prepend some sort of header.
>>>
>>> For the compressed image, it makes sense. But the most of usage I knew is the upstream would just allocate a large buffer for compression video bitstream,
>>>
>>> Then it could tell where the decoder should start.
>>
>> It's not codec specific, it's meant to be used with raw video frames.
>>
>> The key problem in today's API is that if the buffer for the video frame
>> contains multiple planes, typically Y and UV (2 planes) or Y, U and V (3 planes).
>>
>> The offset at which each plane begins is currently a property of the
>> pixelformat. That doesn't scale since there are often HW requirements
>> that influence this.
>>
>> One of the main confusing issues is that data_offset is included in
>> the bytesused value, which was a design mistake in hindsight.
>>
> I didn't see any problem here.
> And v6 does NOT have the length property. There are many reasons that we want to limit the hardware access region for a plane.
>> For the new APIs just ignore the existing data_offset and design
>> this from scratch.
>>
> All I am worrying is the effort we spent didn't have much change to the previous. Beyond breaking the userspace compatibility, it needs huge work on updating existing drivers included those could be
> replaced with the new framework.

What would you need to update existing drivers?

Perhaps the only drivers that would need work (I'm not at all certain about
that!) would be the drivers that use data_offset today. And frankly, it
wouldn't hurt if those are checked carefully anyway.

> 
> I highly recommend just rename a property which was not used by any drivers in the upstream and make a new description for it.
> 
>>>
>>>>    That's indeed not what we want here, we
>>>> instead need something similar to the offsets field of struct
>>>> drm_mode_fb_cmd2.
>>>
>>> That leads to another question. Should the offset be fixed from the first enqueued?
>>
>> It's always been fixed in the hardware I have seen, but I'm sure someone will
>> make it dynamic at some point in the future :-(
>>
> There have been two cases the offset won't be fixed.
> 1. video codec bitstream input in a circular buffer as mentioned in the previous mail
> 2. decoder resolution change(down) while reusing the existing buffer(re-allocation costs lots of time)
>> So I would say that the public API has to support this as a future enhancement,
>> but it is OK to write the initial code with the assumption that it will remain
>> fixed.
>>
>>>
>>> For the dmabuf, the v4l2 core framework would detatch then attach the buffer when it found the private of a plane is not same. Although it sounds unnecessary, some devices would a different cache line
>>> for the chroma channel, it should be updated.
>>>
>>> For the drm_mode_fb_cmd2, unless you remove that fb_id, there is no way to modify the offset. But this would break the existing usage I mentioned before.
>>>
>>> We need to consider whether we need to keep the previous offset and a hook for update it.
>>>
>>>>>> I am thinking just add a field recording the offset input from the user.
>>>>>> When we return the buffer back to the user, the value of the offset
>>>>>> should be same as the it is queued.
>>>>>>
>>>>>> Meanwhile, the API compatible that I want to keep is user using the
>>>>>> ext_pix API could access those drivers support old API.
>>>>>> But I don't want the user would expect they could get correct pixel
>>>>>> format using the old ioctl(). It could create many duplicated pixel
>>>>>> formats. If we want to keep the compatible here, that is the job of
>>>>>> libv4l.
>>>>>>
>>>>>> Besides, I think make the driver using the new API be compatible
>>>>>> with the old ioctl() would lead a huge problem. User won't like to
>>>>>> update its code if it could work even in a less performance mode
>>>>>> because this code are for all the other hardware vendors/models.
>>>>>> Unless we make this a feature, they could make a new branch in their
>>>>>> code(don't count them would upate the kernel of the other products).
>>>>> New drivers that require the additional information that these new ioctls give can
>>>>> decide to just support these new ioctls only. But for existing drivers you want
>>>>> to automatically support the new ioctls.
>>>
>>> What I said didn't break that. Application would use the new ioctl() to contact with the existing driver.
>>>
>>> What I want to remove is that Application use the old ioctl() to contact with the driver support new ioctl().
>>
>> No, you can't do that. Not unless the driver uses features that only work with the new API.
>>
>> I.e. if I make a new driver whose properties are completely compatible with the existing
>> APIs (so no weird offsets etc.), then I want to write the driver using the new ioctls,
>> and leave it to the V4L2 framework to provide support for the old ioctls.
>>
>> There is absolutely no reason to block old ioctls in that case. Applications will not
>> just be able to support a new API overnight, that takes years.
>>
>>>
>>> I would omit this related patches in the refresh set. We could always add it back. But what I want is a way  to enqueue and dequeue different formats(or usage) of buffers in both OUTPUT and CAPTURE. I
>>> may add a more complex API later.
>>
>> For discussion it is OK to drop the old ioctl support, but once you go beyond the RFC stage
>> it has to be put back.
>>
>> Regards,
>>
>>          Hans
> 

General note: this email thread is getting hard to read, and it is not helped
by the fact that the original patch series is very old.

Perhaps you should rebase v6 and post it as a v7?

Regards,

	Hans
