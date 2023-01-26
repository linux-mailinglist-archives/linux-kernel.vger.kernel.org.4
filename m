Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A321267D447
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjAZSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZSgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:36:21 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334237F14;
        Thu, 26 Jan 2023 10:36:20 -0800 (PST)
Received: from [192.168.0.134] (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPSA id 70268100DAB;
        Fri, 27 Jan 2023 03:35:17 +0900 (JST)
Message-ID: <02142e8c-7479-1066-b5af-dad954136adc@soulik.info>
Date:   Fri, 27 Jan 2023 02:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v6 03/11] media: v4l2: Add extended buffer (de)queue
 operations for video types
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com,
        helen.koike@collabora.com, hiroh@chromium.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-4-helen.koike@collabora.com>
 <20230125200026.16643-1-ayaka@soulik.info>
 <7609d523-667a-49a8-45f5-8186de20c24b@xs4all.nl>
 <Y9Jd12nYGk2xTYzx@pendragon.ideasonboard.com>
From:   ayaka <ayaka@soulik.info>
In-Reply-To: <Y9Jd12nYGk2xTYzx@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/23 19:02, Laurent Pinchart wrote:
> On Thu, Jan 26, 2023 at 09:57:51AM +0100, Hans Verkuil wrote:
>> On 25/01/2023 21:00, ayaka wrote:
>>> I am currently refresh this patchset, but I didn't see the need beyond v4l2_ext_pix_fmt, which I had done.
>>> On 2/23/21 20:58, Hans Verkuil wrote:
>>>> On 14/01/2021 19:07, Helen Koike wrote:
>>>>> Those extended buffer ops have several purpose:
>>>>> 1/ Fix y2038 issues by converting the timestamp into an u64 counting
>>>>>      the number of ns elapsed since 1970
>>> I think application just use the timestamp field for tracking the
>>> buffer. It would be just a sequence buffer.
>>> At least for the most widely cases, the video encoder and decoder
>>> and ISP, this field is not a wall time.
>> For video capture and video output this is typically the monotonic
>> clock value.
>>
>> For memory-to-memory devices it is something that is just copied from
>> output to capture.
>>
>> So ISPs definitely use this as a proper timestamp.
> There are both inline (live-to-memory) and offline (memory-to-memory)
> ISPs. The former certainly need a proper timestamp.
>
I really have not seen a device that has timer starting with the epoch.

I rarely know the ISP has a wall clock timer.

Timestamp is not my first concern here. Offset is.

>>>>> 2/ Unify single/multiplanar handling
>>>>> 3/ Add a new start offset field to each v4l2 plane buffer info struct
>>>>>      to support the case where a single buffer object is storing all
>>>>>      planes data, each one being placed at a different offset
>>> I really care about this. But I think the data_offset field in
>>> struct v4l2_plane is enough. The rest is the problem of the kernel
>>> internal API and allocator.
>> data_offset has proven to be very confusing and is rarely used because
>> of that.
Yes, I didn't know any stateful codec driver support this.
>> We do need some sort of an offset field as proposed here, but it
>> shouldn't be named data_offset.
Maybe we could just rename it or make a union in the existing struct.
> The existing data_offset field was indeed added for other purposes, to
> let drivers report where the actual image data starts for devices that
> prepend some sort of header.

For the compressed image, it makes sense. But the most of usage I knew 
is the upstream would just allocate a large buffer for compression video 
bitstream,

Then it could tell where the decoder should start.

>   That's indeed not what we want here, we
> instead need something similar to the offsets field of struct
> drm_mode_fb_cmd2.

That leads to another question. Should the offset be fixed from the 
first enqueued?

For the dmabuf, the v4l2 core framework would detatch then attach the 
buffer when it found the private of a plane is not same. Although it 
sounds unnecessary, some devices would a different cache line for the 
chroma channel, it should be updated.

For the drm_mode_fb_cmd2, unless you remove that fb_id, there is no way 
to modify the offset. But this would break the existing usage I 
mentioned before.

We need to consider whether we need to keep the previous offset and a 
hook for update it.

>>> I am thinking just add a field recording the offset input from the user.
>>> When we return the buffer back to the user, the value of the offset
>>> should be same as the it is queued.
>>>
>>> Meanwhile, the API compatible that I want to keep is user using the
>>> ext_pix API could access those drivers support old API.
>>> But I don't want the user would expect they could get correct pixel
>>> format using the old ioctl(). It could create many duplicated pixel
>>> formats. If we want to keep the compatible here, that is the job of
>>> libv4l.
>>>
>>> Besides, I think make the driver using the new API be compatible
>>> with the old ioctl() would lead a huge problem. User won't like to
>>> update its code if it could work even in a less performance mode
>>> because this code are for all the other hardware vendors/models.
>>> Unless we make this a feature, they could make a new branch in their
>>> code(don't count them would upate the kernel of the other products).
>> New drivers that require the additional information that these new ioctls give can
>> decide to just support these new ioctls only. But for existing drivers you want
>> to automatically support the new ioctls.

What I said didn't break that. Application would use the new ioctl() to 
contact with the existing driver.

What I want to remove is that Application use the old ioctl() to contact 
with the driver support new ioctl().

I would omit this related patches in the refresh set. We could always 
add it back. But what I want is a way  to enqueue and dequeue different 
formats(or usage) of buffers in both OUTPUT and CAPTURE. I may add a 
more complex API later.
