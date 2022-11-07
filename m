Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8571D61ECCD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKGIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:23:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAB26CA;
        Mon,  7 Nov 2022 00:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B548CB80E34;
        Mon,  7 Nov 2022 08:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D10AC433D6;
        Mon,  7 Nov 2022 08:23:43 +0000 (UTC)
Message-ID: <daab81c3-4592-5ef0-5a0e-5f89fe58a3e7@xs4all.nl>
Date:   Mon, 7 Nov 2022 09:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     Kun-Fa Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20221104033810.1324686-1-milkfafa@gmail.com>
 <20221104033810.1324686-6-milkfafa@gmail.com>
 <357a3098-918b-895b-7305-0f1a63aacdb0@xs4all.nl>
 <CADnNmFp4r-3+pvHa+_HOxcXAkORadMzgg6fFKbLcgs66a_90gw@mail.gmail.com>
Content-Language: en-US
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CADnNmFp4r-3+pvHa+_HOxcXAkORadMzgg6fFKbLcgs66a_90gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 08:20, Kun-Fa Lin wrote:
> Hi Hans,
> 
> Thanks for the review.
> 
>>
>> These functions are not usually present when capturing from video. You don't
>> have a choice w.r.t. resolution and fps, since that's determined by the
>> incoming video. I would drop support for this.
> 
> Just to confirm, do you mean `npcm_video_enum_framesizes` and
> `npcm_video_enum_frameintervals` functions?

Right.

> 
> 
>>> +     switch (ctrl->id) {
>>> +     case V4L2_CID_DETECT_MD_MODE:
>>> +             if (ctrl->val == V4L2_DETECT_MD_MODE_GLOBAL)
>>> +                     video->ctrl_cmd = VCD_CMD_OPERATION_CAPTURE;
>>> +             else
>>> +                     video->ctrl_cmd = VCD_CMD_OPERATION_COMPARE;
>>> +     break;
>>
>> Incorrect indentation for the 'break'.
> 
> Will correct it.
> 
> 
>>> +     v4l2_ctrl_new_std_menu(&video->ctrl_handler, &npcm_video_ctrl_ops,
>>> +                            V4L2_CID_DETECT_MD_MODE,
>>> +                            V4L2_DETECT_MD_MODE_REGION_GRID, 0,
>>> +                            V4L2_DETECT_MD_MODE_GLOBAL);
>>
>> Why is this driver using a control designed for motion detection devices?
>> That seems odd, and it looks like you are abusing this control to do something
>> else.
> 
> The Video Capture/Differentiation (VCD) engine supports two modes:
> - COMPLETE (capture the next "complete frame" into memory)
> - DIFF (compare the incoming frame with the frame stored in memory,
> and updates the "diff frame" in memory)
> 
> The purpose here is to provide a way for application to switch the
> COMPLETE/DIFF mode. Since I couldn't find an appropriate ioctl that is
> designed for this purpose, so I used VIDIOC_S_CTRL with control values
> of V4L2_DETECT_MD_MODE_GLOBAL (for COMPLETE) and
> V4L2_DETECT_MD_MODE_REGION_GRID (for DIFF). It would be appreciated if
> you could point me in the right direction.

This is very much a driver-specific control. So you have to make your
own.

This series is a good example on how to add a custom control:

https://lore.kernel.org/linux-media/20221028023554.928-1-jammy_huang@aspeedtech.com/

Driver-specific controls are fine, as long as they are properly documented.

> 
> 
>> When you post v7, please also include the output of v4l2-compliance to the
>> cover letter!
>> Make sure you compile v4l2-compliance from the v4l-utils git repo, do not
>> use a version from a distro, that will be too old.
> 
> OK, I'll try to compile v4l2-compliance and include the output.
> 
> Regards,
> Marvin

Regards,

	Hans
