Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9372E6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbjFMPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjFMPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53110FF;
        Tue, 13 Jun 2023 08:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6498562D43;
        Tue, 13 Jun 2023 15:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF13DC433F0;
        Tue, 13 Jun 2023 15:04:34 +0000 (UTC)
Message-ID: <2e7209cf-29c4-0245-fefe-deece350bd2c@xs4all.nl>
Date:   Tue, 13 Jun 2023 17:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v6 1/1] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230524112126.2242-1-tumic@gpxsee.org>
 <20230524112126.2242-2-tumic@gpxsee.org>
 <3a7da3cd-8d03-a2c4-0534-a75565aefc13@xs4all.nl>
 <7072a8f3-5c9e-1170-e480-6fb57b95110f@gpxsee.org>
 <6b792de3-bb2c-d2b5-a652-eca6d20dad20@xs4all.nl>
 <c34db414-159a-313f-90eb-2bfc0f4496fa@gpxsee.org>
 <089e728b-0596-d3e3-39a1-651a3ac73e33@xs4all.nl>
 <f72a7380-d8bc-24bf-630c-75f8ffd6abf3@gpxsee.org>
 <72494a61-5be8-033b-5bcd-59699a226002@xs4all.nl>
 <756729ed-18d6-519c-ba61-98afeecaa0b7@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <756729ed-18d6-519c-ba61-98afeecaa0b7@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 13/06/2023 16:46, Martin Tůma wrote:
> On 13. 06. 23 14:18, Hans Verkuil wrote:
>> Hi Martin,
>>
>> On 12/06/2023 13:34, Martin Tůma wrote:
>>> On 12. 06. 23 10:51, Hans Verkuil wrote:
>>>> On 08/06/2023 17:30, Martin Tůma wrote:
>>>>> On 08. 06. 23 12:23, Hans Verkuil wrote:
>>>>>
>>>>>> Can you make a list of which sysfs properties correspond to existing V4L2
>>>>>> format or timing fields and which are 'new'?
>>>>>>
>>>>>
>>>>> On the left all the current mgb4 sysfs properties (see the admin-guide doc from the patch for description), on the right v4l2 structures where they could be mapped (may not be true for all of
>>>>> them in
>>>>> the patch, I will check it and update the code in v7)
>>>>>
>>>>>
>>>>> --- PCIE CARD ---
>>>>>
>>>>> module_type        -
>>>>> module_version        -
>>>>> fw_type            -
>>>>> fw_version        -
>>>>> serial_number        -
>>>>> temperature        hwmon
>>>>>
>>>>> --- INPUTS ---
>>>>>
>>>>> input_id        -
>>>>> oldi_lane_width        -
>>>>> color_mapping        -
>>>>> link_status        v4l2_input.status (V4L2_IN_ST_NO_SYNC)
>>>>> stream_status        v4l2_input.status (V4L2_IN_ST_NO_SIGNAL)
>>>>> video_width        v4l2_bt_timings.width
>>>>> video_height        v4l2_bt_timings.height
>>>>> vsync_status        v4l2_bt_timings.polarities
>>>>> hsync_status        v4l2_bt_timings.polarities
>>>>> vsync_gap_length    -
>>>>> hsync_gap_length    -
>>>>> pclk_frequency        v4l2_bt_timings.pixelclock
>>>>> hsync_width        v4l2_bt_timings.hsync
>>>>> vsync_width        v4l2_bt_timings.vsync
>>>>> hback_porch        v4l2_bt_timings.hbackporch
>>>>> hfront_porch        v4l2_bt_timings.hfrontporch
>>>>> vback_porch        v4l2_bt_timings.vbackporch
>>>>> vfront_porch        v4l2_bt_timings.vfrontporch
>>>>> frequency_range        -
>>>>> alignment        v4l2_pix_format.bytesperline
>>>>> fpdl3_input_width    -
>>>>> gmsl_mode        -
>>>>> gmsl_stream_id        -
>>>>> gmsl_fec        -
>>>>>
>>>>> --- OUTPUTS ---
>>>>>
>>>>> output_id        -
>>>>> video_source        -
>>>>> display_width        v4l2_bt_timings.width
>>>>> display_height        v4l2_bt_timings.height
>>>>> frame_rate        v4l2_frmivalenum
>>>>
>>>> The frame rate is a property of the width/height+blanking and the
>>>> pixel clock frequency. IMHO it does not make sense to have this as
>>>> a writable property. Read-only is OK.
>>>>
>>>>> hsync_polarity        v4l2_bt_timings.polarities
>>>>> vsync_polarity        v4l2_bt_timings.polarities
>>>>> de_polarity        -
>>>>> pclk_frequency        v4l2_bt_timings.pixelclock
>>>>> hsync_width        v4l2_bt_timings.hsync
>>>>> vsync_width        v4l2_bt_timings.vsync
>>>>> vsync_width        v4l2_bt_timings.vsync
>>>>> hback_porch        v4l2_bt_timings.hbackporch
>>>>> hfront_porch        v4l2_bt_timings.hfrontporch
>>>>> vback_porch        v4l2_bt_timings.vbackporch
>>>>> vfront_porch        v4l2_bt_timings.vfrontporch
>>>>> alignment        v4l2_pix_format.bytesperline
>>>>> fpdl3_output_width    -
>>>>>
>>>>>
>>>>> M.
>>>>
>>>> The property I am most concerned with is alignment (both for input and output).
>>>> But it is not clear to me what the use-case is.
>>>>
>>>
>>> Hi,
>>> The use-case is to provide the alignment required by some video processing chips. We have a product based on NVIDIA Jetson TX2 that uses the mgb4 cards and the HW video encoding needs a specific
>>> alignment to work.
>>
>> OK. I would suggest that for this property it has a default value of 0 (i.e. a 1 byte alignment),
>> and in that case VIDIOC_S_FMT allows userspace to set bytesperline to whatever they want. I.e.,
>> this is the normal behavior for DMA engines that can deal with custom padding at the end of each
>> line.
>>
>> If it is > 0, then bytesperline is fixed, based on this value.
>>
>> That way both methods are supported fairly cleanly.
>>
>> BTW, what is missing in the property documentation for writable properties is what the default
>> value is. That must be documented as well.
>>
> 
> The default value is 1 (no padding, 1 byte alignment), I will add it to the documentation.
> 
> I would really urge to stick with the "set all the properties at one place in sysfs, report them in v4l2" mechanism. Like with most of the properties, there are some special cases and HW related
> dependencies across inputs/outputs (the output alignment has to comply with input alignment - see the documentation rst for details) and duplicating this logic together with some additional logic
> handling changes from another source - VIDIOC_S_FMT - will make the driver much more complicated and "messy" for no benefit for the user (he will be even more confused).

When mainlining drivers it is important to support the standard APIs as much as possible,
otherwise it will become a big mess if every driver does something different. So as
maintainer it is my job to ensure that the standard APIs are used.

Looking at the properties that were introduced, most are related to timings, except
for alignment. That is really something for VIDIOC_S_FMT. And should be perfectly
fine to support as long as alignment is set to 1. If it is > 1, then bytesperline can
be set by the driver and userspace can't change it. It adds only very little complexity,
but it ensures that the default behavior is consistent with the V4L2 API.

I'm not very keen on all the properties at all, but given the specific nature of
this board I can understand it. They are to some extent similar to device tree
snippets to configure the device. But 'alignment' is not really part of that,
but I'm OK with it as long as the standard method is also supported. And in fact,
the property documentation should refer to the standard method as well.

Regards,

	Hans
