Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22172BB02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjFLImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjFLImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BDBB;
        Mon, 12 Jun 2023 01:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9F761300;
        Mon, 12 Jun 2023 08:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA2FC433EF;
        Mon, 12 Jun 2023 08:42:26 +0000 (UTC)
Message-ID: <0cec2b34-01bb-ec0e-f215-9e6ed3f44e73@xs4all.nl>
Date:   Mon, 12 Jun 2023 10:42:24 +0200
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
 <c544814a-7d99-add9-0397-d56776f911dd@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <c544814a-7d99-add9-0397-d56776f911dd@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 13:16, Martin Tůma wrote:
> Hi,
> This is the "technical" part of my response, comments bellow:
> 
> On 07. 06. 23 10:41, Hans Verkuil wrote:
>> Hi Martin,
>>
>> Some comments below:
>>
>> On 24/05/2023 13:21, tumic@gpxsee.org wrote:
>>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
> 
>>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>>> new file mode 100644
>>> index 000000000000..77db2fa64ab4
>>> --- /dev/null
>>> +++ b/Documentation/admin-guide/media/mgb4.rst
>>> @@ -0,0 +1,352 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>
>> Perhaps it is a good idea to start with a high level overview of the
>> hardware blocks. That might help understand how the various parts are
>> connected.
>>
> 
> This is the "admin-guide" documentation and I'm not sure if the admins (= the card users) are interested in some hardware blocks description. I can for sure ad some basic info like that the card (with
> the given module) has two inputs and two outputs, but if you hold the card in your hands while installing it into the PCIe slot you definitely notice that ;-)

True, but I don't have that module :-).

I assume the inputs (and also outputs) are mutually exclusive? I.e., only one at a time can be active?

But it is also possible to switch between the inputs/outputs dynamically if you want?

Right now it is hard coded through this property, but I assume there is a reason these
modules have two inputs and two outputs, so it is odd that it is not possible use
VIDIOC_S_INPUT/S_OUTPUT to toggle between them.

> 
>>> +**temperature** (R):
>>> +    FPGA core temperature in Celsius degree.
>>
>> I'm not sure if this is the right place for this. Shouldn't this
>> be exposed through the hwmon subsystem? That way you will see it
>> with e.g. the 'sensors' command. The drivers/media/i2c/video-i2c.c
>> driver uses hwmon in that way.
>>
> 
> Yes, this is the one exception where it makes sense and would improve compatibility/usability for the user. I will change that.
> 
>>> +
>>> +Common FPDL3/GMSL input parameters
>>> +==================================
>>> +
>>> +**input_id** (R):
>>> +    Input number ID, zero based.
>>
>> Input of what? I assume that the HW modules have multiple inputs?
>>
> 
> Yes. The card has two inputs and two outputs (with the current FPDL/GMSL modules).
> 
>>> +
>>> +**link_status** (R):
>>> +    Video link status. If the link is locked, chips are properly connected and
>>> +    communicating at the same speed and protocol. The link can be locked without
>>> +    an active video stream.
>>> +
>>> +    | 0 - unlocked
>>> +    | 1 - locked
>>
>> What is the relationship of this link status and the status bits returned by
>> VIDIOC_ENUMINPUT?
>>
> 
> This is "a necessary condition, not a sufficient one" for a valid video stream. Maybe the V4L2_IN_ST_NO_SYNC flag (together with V4L2_IN_ST_NO_SIGNAL) could be returned in this case in ENUMINPUT.

That would make sense.

> 
>>> +
>>> +**stream_status** (R):
>>> +    Video stream status. A stream is detected if the link is locked, the input
>>> +    pixel clock is running and the DE signal is moving.
>>> +
>>> +    | 0 - not detected
>>> +    | 1 - detected
>>
>> This definitely looks like this should be handled by ENUMINPUT.
>>
> 
> It is (also) handled in ENUMINPUT. You get V4L2_IN_ST_NO_SIGNAL in the status in this case (in the code the check is based on the resolution, but those are almost equivalent things. If there is no
> valid resolution, there is no valid stream.
> 
> The reason why this is also available in sysfs is that the users can easily see all the info on one place (accessible without special SW) to debug problems with the streams which will be much more
> common than with some "regular" grabbers.

Please document the relationship of these properties with the ENUMINPUT status bits.

> 
>>> +
>>> +**video_width** (R):
>>> +    Video stream width. This is the actual width as detected by the HW. You may
>>> +    see a different width in the v4l2 APIs as those values can not be arbitrary
>>> +    changed by the driver.
>>> +
>>> +**video_height** (R):
>>> +    Video stream height. This is the actual height as detected by the HW. You
>>> +    may see a different height in the v4l2 APIs as those values can not be
>>> +    arbitrary changed by the driver.
>>
>> Is this the width/height of the active video? Or active + blanking video?
>>
>> It is not quite clear to me what you mean with 'those values can not be arbitrary
>> changed by the driver'. With QUERY_DV_TIMINGS you can get all this info.
>>
> 
> When you do QUERY_DV_TIMINGS, you get this info. What was meant with that description is, that you can see something different in your video player that mostly does not automatically change the
> DV_TIMINGS and in this property. Again, the card is primary designed to dvelope/test the infotainment systems and the user often wants too see the current state of the HW to find out why the video
> player stopped showing the expected output.

This needs to be rephrased. Perhaps something along these lines:

**video_width** (R):
    Active video width. This is the width as detected by the HW, identical to
    what VIDIOC_QUERY_DV_TIMINGS returns in the width field of struct v4l2_bt_timings.

> 
>>> +
>>> +**vsync_status** (R):
>>> +    The type of VSYNC pulses as detected by the video format detector.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +    | 2 - not available
>>> +
>>> +**hsync_status** (R):
>>> +    The type of HSYNC pulses as detected by the video format detector.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +    | 2 - not available
>>
>> Why do you need this?
>>
> 
> For example to set the correct type of hsync/vsync for the outputs, when you want to emulate this input stream. Again, the users need some low level info in the common use-cases.
> 
>>> +
>>> +**vsync_gap_length** (RW):
>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>> +    internal VSYNC pulse.
>>> +
>>> +**hsync_gap_length** (RW):
>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>> +    internal HSYNC pulse. The value must be greater than 1 and smaller than
>>> +    vsync_gap_length.
>>> +
>>> +**pclk_frequency** (R):
>>> +    Input pixel clock frequency in kHz.
>>> +
>>> +    *Note: The frequency_range parameter must be set properly first to get
>>> +    a valid frequency here.*
>>
>> Wouldn't QUERY_DV_TIMINGS return this?
>>
>>> +
>>> +**hsync_width** (R):
>>> +    Width of the HSYNC signal in PCLK clock ticks.
>>> +
>>> +**vsync_width** (R):
>>> +    Width of the VSYNC signal in PCLK clock ticks.
>>> +
>>> +**hback_porch** (R):
>>> +    Number of PCLK pulses between deassertion of the HSYNC signal and the first
>>> +    valid pixel in the video line (marked by DE=1).
>>> +
>>> +**hfront_porch** (R):
>>> +    Number of PCLK pulses between the end of the last valid pixel in the video
>>> +    line (marked by DE=1) and assertion of the HSYNC signal.
>>> +
>>> +**vback_porch** (R):
>>> +    Number of video lines between deassertion of the VSYNC signal and the video
>>> +    line with the first valid pixel (marked by DE=1).
>>> +
>>> +**vfront_porch** (R):
>>> +    Number of video lines between the end of the last valid pixel line (marked
>>> +    by DE=1) and assertion of the VSYNC signal.
>>
>> Ditto for all these.
>>
> 
> Where applicable, the walues should be also returned in the appropriate v4l2 APIs. But like described in the "why sysfs" mail, we want all the values to be accesible on a single place with standard OS
> SW like cat.

Please point to the corresponding v4l2_bt_timings field in this documentation.
It helps relate these properties to what the V4L2 API returns.

> 
>>> +
>>> +**frequency_range** (RW)
>>> +    PLL frequency range of the OLDI input clock generator. The PLL frequency is
>>> +    derived from the Pixel Clock Frequency (PCLK) and is equal to PCLK if
>>> +    oldi_lane_width is set to "single" and PCLK/2 if oldi_lane_width is set to
>>> +    "dual".
>>> +
>>> +    | 0 - PLL < 50MHz
>>> +    | 1 - PLL >= 50MHz
>>> +
>>> +    *Note: This parameter can not be changed while the input v4l2 device is
>>> +    open.*
>>> +
>>> +**alignment** (RW)
>>> +    Pixel line alignment. Sets the pixel line alignment in bytes of the frame
>>> +    buffers provided via the v4l2 interface. The number must be a power of 2.
>>
>> A bit vague what you mean here. I wonder if this isn't something that userspace
>> can't set through the bytesperline field of struct v4l2_pix_format.

As mentioned above, please document if this is the same as bytesperline. I'm not sure
why this is here, why is this needed? Are there other processing blocks that need
specific alignment? This seems to be more a DMA property than a video signal property.

>>
> 
> Dtto like in all other cases. It probably could, but we want the configuration to happen on a single place (accesible using standard UDEV rules).
> 
>>> +
>>> +    *Note: This parameter can not be changed while the input v4l2 device is
>>> +    open.*
>>> +
>>> +Common FPDL3/GMSL output parameters
>>> +===================================
>>> +
>>> +**output_id** (R):
>>> +    Output number ID, zero based.
>>
>> Output of what to what?
>>
> 
> This is the same info like in the case of inputs. The card has two outputs and this simply enumerates the output.
> 
>>> +
>>> +**video_source** (RW):
>>> +    Output video source. If set to 0 or 1, the source is the corresponding card
>>> +    input and the v4l2 output devices are disabled. If set to 2 or 3, the source
>>> +    is the corresponding v4l2 video output device.
>>> +
>>> +    | 0 - input 0
>>> +    | 1 - input 1
>>> +    | 2 - v4l2 output 0
>>> +    | 3 - v4l2 output 1
>>> +
>>> +    *Note: This parameter can not be changed while ANY of the input/output v4l2
>>> +    devices is open.*
>>> +
>>> +**display_width** (RW):
>>> +    Display width. There is no autodetection of the connected display, so the
>>> +    propper value must be set before the start of streaming.
>>
>> propper -> proper
>>
> 
> Ok.
> 
>>> +
>>> +    *Note: This parameter can not be changed while the output v4l2 device is
>>> +    open.*
>>> +
>>> +**display_height** (RW):
>>> +    Display height. There is no autodetection of the connected display, so the
>>> +    propper value must be set before the start of streaming.
>>> +
>>> +    *Note: This parameter can not be changed while the output v4l2 device is
>>> +    open.*
>>> +
>>> +**frame_rate** (RW):
>>> +    Output video frame rate in frames per second.
>>> +
>>> +**hsync_polarity** (RW):
>>> +    HSYNC signal polarity.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +
>>> +**vsync_polarity** (RW):
>>> +    VSYNC signal polarity.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +
>>> +**de_polarity** (RW):
>>> +    DE signal polarity.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +
>>> +**pclk_frequency** (RW):
>>> +    Output pixel clock frequency. Allowed values are between 25000-190000(kHz)
>>> +    and there is a non-linear stepping between two consecutive allowed
>>> +    frequencies. The driver finds the nearest allowed frequency to the given
>>> +    value and sets it. When reading this property, you get the exact
>>> +    frequency set by the driver.
>>> +
>>> +    *Note: This parameter can not be changed while the output v4l2 device is
>>> +    open.*
>>> +
>>> +**hsync_width** (RW):
>>> +    Width of the HSYNC signal in PCLK clock ticks.
>>> +
>>> +**vsync_width** (RW):
>>> +    Width of the VSYNC signal in PCLK clock ticks.
>>> +
>>> +**hback_porch** (RW):
>>> +    Number of PCLK pulses between deassertion of the HSYNC signal and the first
>>> +    valid pixel in the video line (marked by DE=1).
>>> +
>>> +**hfront_porch** (RW):
>>> +    Number of PCLK pulses between the end of the last valid pixel in the video
>>> +    line (marked by DE=1) and assertion of the HSYNC signal.
>>> +
>>> +**vback_porch** (RW):
>>> +    Number of video lines between deassertion of the VSYNC signal and the video
>>> +    line with the first valid pixel (marked by DE=1).
>>> +
>>> +**vfront_porch** (RW):
>>> +    Number of video lines between the end of the last valid pixel line (marked
>>> +    by DE=1) and assertion of the VSYNC signal.
>>
>> For these as well I wonder how much can be done with VIDIOC_DV_S_TIMINGS.
>>
> 
> Dtto like all above cases.
> 
>>> --- a/Documentation/admin-guide/media/v4l-drivers.rst
>>> +++ b/Documentation/admin-guide/media/v4l-drivers.rst
>>> @@ -17,6 +17,7 @@ Video4Linux (V4L) driver-specific documentation
>>>       imx7
>>>       ipu3
>>>       ivtv
>>> +    mgb4
>>>       omap3isp
>>>       omap4_camera
>>>       philips
>>
>> A general note: I suggest that you split off the documentation part in
>> a separate patch rather than it being part of the driver.
>>
> 
> Ok, I will split the patches.
> 
>>> +
>>> +static size_t freq_srch(u32 key, const u32 *array, size_t size)
>>> +{
>>> +    int l = 0;
>>> +    int r = size - 1;
>>> +    int m;
>>> +
>>> +    while (l <= r) {
>>> +        m = (l + r) / 2;
>>> +        if (array[m] < key)
>>> +            l = m + 1;
>>> +        else if (array[m] > key)
>>> +            r = m - 1;
>>> +        else
>>> +            return m;
>>> +    }
>>> +
>>> +    if (r < 0 || l > size - 1)
>>> +        return m;
>>> +    else
>>> +        return (abs(key - array[l]) < abs(key - array[r])) ? l : r;
>>> +}
>>
>> Can you use the bsearch function? (see lib/bsearch.c)
> 
> The function does not search for the exact match but for the nearest value (= it always returns a value). lib/bsearch.c has IMHO no option for that.
> 
>>> +
>>> +u32 mgb4_cmt_set_vout(struct mgb4_vout_dev *voutdev, unsigned int freq)
>>
>> Isn't mgb4_cmt_set_vout_freq a better name? At least that makes it clear
>> this sets the frequency.
>>
> 
> Ok, will change that.
> 
>>> +void mgb4_cmt_set_vin(struct mgb4_vin_dev *vindev, unsigned int freq_range)
>>
>> mgb4_cmt_set_vin_freq_range?
>>
> 
> Ok.
> 
>>> +static struct i2c_adapter *get_i2c_adap(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < 10; i++) {
>>> +        msleep(100);
>>
>> What's the purpose of this msleep? That should be documented since it
>> is unexpected.
> 
> Well, the purpose is to make the adapter fetch work... For some reason, platform_device_register_resndata() of the i2c adapter does not work synchronous and the adapter is not available after the
> register function call. I have spent quiet lot time to find out why this happens/whether there is a better mechanism to wait for the adapter as msleep(), but I was not successful.
> 
> If you know a better mechanism, I will love to change that as I also do not like this "magic" sleep. But you are right I can at least document that in the code.
> 
>>> + * This module handles the IIO trigger device. The card has two signal inputs
>>
>> 'signal inputs': I assume that means it has two input pins (GPIO like) that an
>> external device can trigger? Or is it something else?
>>
> 
> Exactly. The card has two GPIO input pins that the users use for external triggers. In the admin-guide doc you can find some more info under "mgb4 iio (triggers)".
> 
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (C) 2021-2022 Digiteq Automotive
>>
>> Note that you can update the copyright year from 2022 to 2023 in all
>> these sources.
> 
> Ok, will fix that.
> 
>>> + *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
>>> + *
>>> + * This is the v4l2 input device module. It initializes the signal deserializers
>>> + * and creates the v4l2 video devices. The input signal can change at any time
>>> + * which is handled by the "timings" callbacks and an IRQ based watcher, that
>>> + * emits the V4L2_EVENT_SOURCE_CHANGE event in case of a signal source change.
>>> + *
>>> + * When the device is in loopback mode (a direct, in HW, in->out frame passing
>>> + * mode) the cards's frame queue must be running regardles whether a v4l2 stream
>>
>> cards's -> card's
>> regardles -> regardless of
>>
> 
> Ok.
> 
>>> +static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>>> +               unsigned int *nplanes, unsigned int sizes[],
>>> +               struct device *alloc_devs[])
>>> +{
>>> +    struct mgb4_vin_dev *vindev = vb2_get_drv_priv(q);
>>> +    unsigned int size = BYTESPERLINE(vindev->width, vindev->alignment)
>>> +      * vindev->height;
>>> +
>>> +    if (*nbuffers < 2)
>>> +        *nbuffers = 2;
>>
>> I recommend setting min_buffers_needed to 2 in struct vb2_queue.
>> Then you can drop these two lines. It's the recommended way of
>> dealing with this.
>>
> 
> min_buffers_needed is already set to 2. If it makes this code useless, I will remove it here.
> 
>>> +
>>> +static int vidioc_enum_frameintervals(struct file *file, void *priv,
>>> +                      struct v4l2_frmivalenum *ival)
>>
>> I don't think this is needed: this is specific to camera sensor inputs,
>> but this is video input.
>>
> 
> Ok, I have AFAIK no special reason for that besides that someone might want to use it. But if it is for camera sensor inputs only, I will drop it.
> 
>>> +static int vidioc_enum_framesizes(struct file *file, void *fh,
>>> +                  struct v4l2_frmsizeenum *fsize)
>>
>> Ditto.
> 
> Like with frame intervals, If it is never used in the userspace, I will drop it as well.
> 
>>
>> Looking at what the dv_timings ioctls do and the sysfs properties, it seems to me
>> that a lot of the sysfs timings properties can be handle here instead.
>>
>> If some of the sysfs properties are missing here, then we can consider either
>> extending the dv timings API or keeping them as sysfs properties.
>>
> 
> I'll keep this discussion in the separate mail thread.
> 
>>> +static void signal_change(struct work_struct *work)
>>> +{
>>> +    struct mgb4_vin_dev *vindev = container_of(work, struct mgb4_vin_dev, err_work);
>>> +    struct device *dev = &vindev->mgbdev->pdev->dev;
>>> +    u32 resolution = detect_resolution(vindev);
>>> +
>>> +    if (res_cmp(vindev->width, vindev->height, resolution)) {
>>> +        static const struct v4l2_event ev = {
>>> +            .type = V4L2_EVENT_SOURCE_CHANGE,
>>> +            .u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
>>> +        };
>>> +
>>> +        v4l2_event_queue(&vindev->vdev, &ev);
>>> +
>>> +        if (vb2_is_streaming(&vindev->queue))
>>> +            vb2_queue_error(&vindev->queue);
>>> +    }
>>> +
>>> +    dev_warn(dev, "stream changed to %ux%u\n", resolution >> 16,
>>> +         resolution & 0xFFFF);
>>
>> Not a warning. Change to dev_dbg or drop it. You don't want this to spam the
>> kernel log.
> 
> Warning is probably wrong, but I would keep it at least as dev_info. It is quiet useful for troubleshooting video signal problems. So it is not exactly what I understand under dev_dbg which is for
> debuging the driver/kernel code. Here the user debugs the infotainment setup/problems.
> 
>>> +static int deser_init(struct mgb4_vin_dev *vindev, int id)
>>> +{
>>> +    int rv, addr_size;
>>> +    size_t values_count;
>>> +    const struct mgb4_i2c_kv *values;
>>> +    const struct i2c_board_info *info;
>>> +    struct device *dev = &vindev->mgbdev->pdev->dev;
>>> +
>>> +    if (MGB4_IS_GMSL(vindev->mgbdev)) {
>>> +        info = &gmsl_deser_info[id];
>>> +        addr_size = 16;
>>> +        values = gmsl_i2c;
>>> +        values_count = ARRAY_SIZE(gmsl_i2c);
>>> +    } else {
>>> +        info = &fpdl3_deser_info[id];
>>> +        addr_size = 8;
>>> +        values = fpdl3_i2c;
>>> +        values_count = ARRAY_SIZE(fpdl3_i2c);
>>> +    }
>>> +
>>> +    rv = mgb4_i2c_init(&vindev->deser, vindev->mgbdev->i2c_adap, info, addr_size);
>>
>> Consider using v4l2_i2c_new_subdev_board() instead. That's what V4L2 PCI drivers
>> normally use. The advantage is that this will call request_module() and avoids
>> having to wait for the module to be loaded by the kernel. I think that's why the
>> msleep(100) was needed in this driver.
>>
> 
> I have tried request_module() when fiddling with the "magic sleep", but it didn't help. So this is IMHO not the solution. I will look at v4l2_i2c_new_subdev_board() if it makes sense and eventually
> switch the code, but I don't think it will help with the sleep issue.
> 
>>> +    vindev->queue.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>> +    vindev->queue.io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
>>
>> The use of VB2_READ is discouraged for raw video devices. It's up to
>> you, though.
> 
> What if there is some SW that only uses VB2_READ? I would rather let the choice on the user(space).
> 
>>
>>> +    vindev->queue.buf_struct_size = sizeof(struct frame_buffer);
>>> +    vindev->queue.ops = &queue_ops;
>>> +    vindev->queue.mem_ops = &vb2_dma_sg_memops;
>>> +    vindev->queue.gfp_flags = GFP_DMA32;
>>> +    vindev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>>> +    vindev->queue.min_buffers_needed = 2;
>>
>> Ah, this is already set, so in the setup callback you can just drop the
>> *nbuffers < 2 check.
>>
> 
> Ok.
> 
>>> +    vindev->queue.drv_priv = vindev;
>>> +    vindev->queue.lock = &vindev->lock;
>>> +    vindev->queue.dev = dev;
>>> +    rv = vb2_queue_init(&vindev->queue);
>>> +    if (rv) {
>>> +        dev_err(dev, "failed to initialize vb2 queue\n");
>>> +        goto err_v4l2_dev;
>>> +    }
>>> +
>>> +    snprintf(vindev->vdev.name, sizeof(vindev->vdev.name), "mgb4-in%d", id + 1);
>>> +    vindev->vdev.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE
>>> +      | V4L2_CAP_STREAMING;
>>> +    vindev->vdev.fops = &video_fops;
>>> +    vindev->vdev.ioctl_ops = &video_ioctl_ops;
>>> +    vindev->vdev.release = video_device_release_empty;
>>> +    vindev->vdev.v4l2_dev = &vindev->v4l2dev;
>>> +    vindev->vdev.lock = &vindev->lock;
>>> +    vindev->vdev.queue = &vindev->queue;
>>> +    video_set_drvdata(&vindev->vdev, vindev);
>>> +
>>> +    rv = video_register_device(&vindev->vdev, VFL_TYPE_VIDEO, -1);
>>
>> This should be the last thing this function does. You still do more
>> initialization below, but that should be done first.
>>
>> As soon as the video device is registered it can be used, so you
>> want everything it relies on to be ready before you call this.
>>
> 
> Ok, will fix that.
> 
>>> +static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>>> +               unsigned int *nplanes, unsigned int sizes[],
>>> +               struct device *alloc_devs[])
>>> +{
>>> +    struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(q);
>>> +    unsigned long size = BYTESPERLINE(voutdev->width, voutdev->alignment)
>>> +      * voutdev->height;
>>> +
>>> +    if (*nbuffers < 2)
>>> +        *nbuffers = 2;
>>
>> I assume that min_buffers_needed is set to 2 for output as well, so just drop
>> this check.
> 
> Ok.
> 
>>> +static int start_streaming(struct vb2_queue *vq, unsigned int count)
>>> +{
>>> +    struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vq);
>>> +    struct device *dev = &voutdev->mgbdev->pdev->dev;
>>> +    struct frame_buffer *buf = 0;
>>> +    struct mgb4_regs *video = &voutdev->mgbdev->video;
>>> +    int irq = xdma_get_user_irq(voutdev->mgbdev->xdev, voutdev->config->irq);
>>> +    u32 addr;
>>> +
>>> +    mgb4_mask_reg(video, voutdev->config->regs.config, 0x2, 0x2);
>>> +
>>> +    addr = mgb4_read_reg(video, voutdev->config->regs.address);
>>> +    if (addr >= ERR_QUEUE_FULL) {
>>> +        dev_err(dev, "frame queue error (%d)\n", (int)addr);
>>> +        return_all_buffers(voutdev, VB2_BUF_STATE_QUEUED);
>>> +        return -EIO;
>>
>> Should this perhaps be EBUSY? What exactly does this error mean?
>> Some comments would be helpful.
> 
> If the HW returns any frame data address >= ERR_QUEUE_FULL, it means some HW problem/error. This may be temporary as well as permanent, thats why EIO. I myself have no more info when or what exact
> errors can happen, the HW documentation just states that its an error...

OK, this definitely needs to be documented in comments here.

> 
>>> +static int fh_open(struct file *file)
>>> +{
>>> +    struct mgb4_vout_dev *voutdev = video_drvdata(file);
>>> +    struct mgb4_regs *video = &voutdev->mgbdev->video;
>>> +    u32 config, resolution;
>>> +    int ret;
>>> +
>>> +    /* Return EBUSY when the device is in loopback mode */
>>> +    config = mgb4_read_reg(video, voutdev->config->regs.config);
>>> +    if ((config & 0xc) >> 2 != voutdev->config->id + MGB4_VIN_DEVICES)
>>> +        return -EBUSY;
>>
>> A dev_dbg() line might be helpful in this case. Up to you, though.
> 
> Yes, I will add some info message. But like in the resolution change, wouldn't a dev_info not be better as this is not a driver debug but an info for the user?

No, generally you do not want info messages due to incorrect user actions. It can really pollute the kernel log.

> 
>>> +struct mgb4_vout_dev *mgb4_vout_create(struct mgb4_dev *mgbdev, int id)
>>> +{
>>> +    int rv, irq;
>>> +    struct device_attribute **attr, **module_attr;
>>> +    struct mgb4_vout_dev *voutdev;
>>> +    struct mgb4_regs *video;
>>> +    struct pci_dev *pdev = mgbdev->pdev;
>>> +    struct device *dev = &pdev->dev;
>>> +
>>> +    voutdev = kzalloc(sizeof(*voutdev), GFP_KERNEL);
>>> +    if (!voutdev)
>>> +        return NULL;
>>> +
>>> +    voutdev->mgbdev = mgbdev;
>>> +    voutdev->config = &vout_cfg[id];
>>> +    video = &voutdev->mgbdev->video;
>>> +
>>> +    /* Frame queue*/
>>
>> Add space before */
>>
> 
> Will fix that.
> 
>>> +    voutdev->queue.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
>>> +    voutdev->queue.io_modes = VB2_MMAP | VB2_DMABUF | VB2_WRITE;
>>
>> Are you sure you want to support VB2_WRITE? Just checking.
>>
> 
> I have no special need for that, but why not to let it to the user(space)? What if there is some simple SW that only can work using read()?

Just to note that read/write requires a memcpy of the buffer, so this is
highly inefficient. It's OK for compressed video streams, but for raw
video it is not recommended. But, as I said, it is up to you.

> 
>>> +    rv = video_register_device(&voutdev->vdev, VFL_TYPE_VIDEO, -1);
>>
>> Same as with the input: this should be the last thing in the probe().
>>
> 
> Will fix that.
> 
>>
>> Besides the small stuff, the main issue with this driver is how much is
>> done via sysfs. I think that should be reduced and where possible
>> properties should be moved to S_FMT and DV_TIMINGS.
> 
> Again, I will keep this discussion in the separate mail thread.
> 
>>
>> Regards,
>>
>>     Hans
> 
> Thanks for the review.
> 
> Martin

Regards,

	Hans
