Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C09723FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFFKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjFFKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:42:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750210F1;
        Tue,  6 Jun 2023 03:40:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q6U71-0001kW-84; Tue, 06 Jun 2023 12:40:27 +0200
Message-ID: <5cae4b60-a303-5cf6-9d30-8a723d417467@leemhuis.info>
Date:   Tue, 6 Jun 2023 12:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Webcam LED control regression
Content-Language: en-US, de-DE
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <468a36ec-c3ac-cb47-e12f-5906239ae3cd@spahan.ch>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     linux-media@vger.kernel.org, Poncho <poncho@spahan.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <468a36ec-c3ac-cb47-e12f-5906239ae3cd@spahan.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686048028;fd235b51;
X-HE-SMSGID: 1q6U71-0001kW-84
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing a few people and lists that should be aware of this and might be
able to help.

On 05.06.23 18:39, Poncho wrote:
> With kernel 6.3, the LED of my C922 Pro Stream Webcam is no longer
> controllable.
> 
> With kernel 6.1 v4l2-ctl --all returns:
> 
>> led1_mode 0x0a046d05 (menu)   : min=0 max=3 default=0 value=0 (Off)
>>     0: Off
>>     1: On
>>     2: Blink
>>     3: Auto
> 
> 
> 
> but with kernel 6.3 I get:
> 
>> led1_mode 0x0a046d05 (menu)   : min=4 max=4 default=0 value=0
>>     4:

Thanks for the report.

FWIW, maybe one of those people that I CCed has an idea what's wrong. If
none of them brings one to the table withing the next two or three days,
you likely have to perform a bisection to find the change that broke
thing for you.

For the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

> Full output bellow:
> 
>> Driver Info:
>>     Driver name      : uvcvideo
>>     Card type        : C922 Pro Stream Webcam
>>     Bus info         : usb-0000:00:14.0-9
>>     Driver version   : 6.3.5
>>     Capabilities     : 0x84a00001
>>         Video Capture
>>         Metadata Capture
>>         Streaming
>>         Extended Pix Format
>>         Device Capabilities
>>     Device Caps      : 0x04200001
>>         Video Capture
>>         Streaming
>>         Extended Pix Format
>> Media Driver Info:
>>     Driver name      : uvcvideo
>>     Model            : C922 Pro Stream Webcam
>>     Serial           : 6E8DF1BF
>>     Bus info         : usb-0000:00:14.0-9
>>     Media version    : 6.3.5
>>     Hardware revision: 0x00000016 (22)
>>     Driver version   : 6.3.5
>> Interface Info:
>>     ID               : 0x03000002
>>     Type             : V4L Video
>> Entity Info:
>>     ID               : 0x00000001 (1)
>>     Name             : C922 Pro Stream Webcam
>>     Function         : V4L2 I/O
>>     Flags            : default
>>     Pad 0x01000007   : 0: Sink
>>       Link 0x0200001f: from remote pad 0x100000a of entity 'Processing
>> 3' (Video Pixel Formatter): Data, Enabled, Immutable
>> Priority: 2
>> Video input : 0 (Camera 1: ok)
>> Format Video Capture:
>>     Width/Height      : 160/90
>>     Pixel Format      : 'YUYV' (YUYV 4:2:2)
>>     Field             : None
>>     Bytes per Line    : 320
>>     Size Image        : 28800
>>     Colorspace        : sRGB
>>     Transfer Function : Rec. 709
>>     YCbCr/HSV Encoding: ITU-R 601
>>     Quantization      : Default (maps to Limited Range)
>>     Flags             : Crop Capability Video Capture:
>>     Bounds      : Left 0, Top 0, Width 160, Height 90
>>     Default     : Left 0, Top 0, Width 160, Height 90
>>     Pixel Aspect: 1/1
>> Selection Video Capture: crop_default, Left 0, Top 0, Width 160,
>> Height 90, Flags: Selection Video Capture: crop_bounds, Left 0, Top 0,
>> Width 160, Height 90, Flags: Streaming Parameters Video Capture:
>>     Capabilities     : timeperframe
>>     Frames per second: 30.000 (30/1)
>>     Read buffers     : 0
>>
>> User Controls
>>
>>                      brightness 0x00980900 (int)    : min=0 max=255
>> step=1 default=128 value=128
>>                        contrast 0x00980901 (int)    : min=0 max=255
>> step=1 default=128 value=128
>>                      saturation 0x00980902 (int)    : min=0 max=255
>> step=1 default=128 value=128
>>         white_balance_automatic 0x0098090c (bool)   : default=1 value=1
>>                            gain 0x00980913 (int)    : min=0 max=255
>> step=1 default=0 value=0
>>            power_line_frequency 0x00980918 (menu)   : min=0 max=2
>> default=2 value=2 (60 Hz)
>>                 0: Disabled
>>                 1: 50 Hz
>>                 2: 60 Hz
>>       white_balance_temperature 0x0098091a (int)    : min=2000
>> max=6500 step=1 default=4000 value=4000 flags=inactive
>>                       sharpness 0x0098091b (int)    : min=0 max=255
>> step=1 default=128 value=128
>>          backlight_compensation 0x0098091c (int)    : min=0 max=1
>> step=1 default=0 value=0
>>
>> Camera Controls
>>
>>                   auto_exposure 0x009a0901 (menu)   : min=0 max=3
>> default=3 value=3 (Aperture Priority Mode)
>>                 1: Manual Mode
>>                 3: Aperture Priority Mode
>>          exposure_time_absolute 0x009a0902 (int)    : min=3 max=2047
>> step=1 default=250 value=250 flags=inactive
>>      exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=1
>>                    pan_absolute 0x009a0908 (int)    : min=-36000
>> max=36000 step=3600 default=0 value=0
>>                   tilt_absolute 0x009a0909 (int)    : min=-36000
>> max=36000 step=3600 default=0 value=0
>>                  focus_absolute 0x009a090a (int)    : min=0 max=250
>> step=5 default=0 value=0 flags=inactive
>>      focus_automatic_continuous 0x009a090c (bool)   : default=1 value=1
>>                   zoom_absolute 0x009a090d (int)    : min=100 max=500
>> step=1 default=100 value=100
>>                       led1_mode 0x0a046d05 (menu)   : min=4 max=4
>> default=0 value=0
>>                 4:                  led1_frequency 0x0a046d06 (int)   
>> : min=0 max=255 step=1 default=0 value=255

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced v6.1..v6.3
#regzbot title media: uvcvideo: Webcam LED control regression
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
