Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6869C741
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBTJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBTJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E97C4C33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676883793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EenIhw+1HmIvsFUb0i4grWRCZp0khcXrPfOlppJ9ALo=;
        b=T7PdFmFo64TsBKoWWHnRbkYD6nX/+asKNOda+Lqm5Ja06qIRMU0CUGZr3z6cin6BZjJR6Y
        /P2sy/wwY6Yua/fPdqiO0x/2h6qbMNesKh2WLPti3OmG+w67owK46f1sJerkezmZfqGt2O
        +X9UaFltbzNHgC62rAG2qY33i7T1UIM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-nhktU60APWe9xPGVy0_DgQ-1; Mon, 20 Feb 2023 04:03:11 -0500
X-MC-Unique: nhktU60APWe9xPGVy0_DgQ-1
Received: by mail-ed1-f70.google.com with SMTP id v12-20020a056402174c00b004acb5c6e52bso665625edx.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EenIhw+1HmIvsFUb0i4grWRCZp0khcXrPfOlppJ9ALo=;
        b=V0W0/7JoBK486142Q+re+hlSCQUGogn2ipDnwBKSKTnZO3Sj3hwAS0PG2ruRyCAVG9
         i5AmnI1FxDqmXUgLVrgKIHFnSYHHnKxV52hE8E2eytoDK4Q3WpexyaVPI2nb38pIBFfl
         43t3LhOmWR4jqLVTSK7Ev4872ZCCUC9GdJxjeckn43hnAaFAv+FLxooQDTRdpkNAsLIv
         NK+XnrBnE4hpvQ4XE0JJNm2jwsWAiidRZXR2rTnSwCm9TuuH8pVP3PAieQnG169+t3sh
         qBmbgjKFsyfQAjFefPIGIkcnDSM95jJL458Y0DhZXbUpdQLKNI9mfya0bdIBaL6FsyLJ
         MDyA==
X-Gm-Message-State: AO0yUKXxvbjvglJ9o4Jlp2BY4RzZk+uYtnJJB2L0ewd/A/gYf5yXW6UV
        ysT5FMTqK7OZM8LotfWQwIsz6ReMABNmN6axScbQZMoBgZWO627lFSL84RHKuiiNeIttsF629ap
        /toYKMNKr2+4KBVUHSinj/+Iq
X-Received: by 2002:a50:ec83:0:b0:4ad:1e21:9981 with SMTP id e3-20020a50ec83000000b004ad1e219981mr930762edr.41.1676883790683;
        Mon, 20 Feb 2023 01:03:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8B8sBAq4Cj6T+76hS0E7sctHcJ4lB8XB7ZkExypjyKrm2A4TBTamMuPgI0pGhLpjHgpcMXzw==
X-Received: by 2002:a50:ec83:0:b0:4ad:1e21:9981 with SMTP id e3-20020a50ec83000000b004ad1e219981mr930742edr.41.1676883790360;
        Mon, 20 Feb 2023 01:03:10 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e23-20020a50d4d7000000b004acd9a3afb3sm208000edj.63.2023.02.20.01.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:03:09 -0800 (PST)
Message-ID: <dfa64234-ddac-d88a-3127-a18da145bdf0@redhat.com>
Date:   Mon, 20 Feb 2023 10:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Content-Language: en-US
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
 <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y/MxGRrKsgVat3zZ@kekkonen.localdomain>
 <DM6PR11MB4316B3105394F258D8205DBC8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM6PR11MB4316B3105394F258D8205DBC8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/20/23 09:57, Wu, Wentong wrote:
> 
> 
>> -----Original Message-----
>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Sent: Monday, February 20, 2023 4:37 PM
>>
>> Hi Wentong,
>>
>> On Mon, Feb 20, 2023 at 03:50:55AM +0000, Wu, Wentong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Sent: Friday, February 17, 2023 7:19 PM
>>>>
>>>> Hi Wentong,
>>>>
>>>> On Fri, Feb 17, 2023 at 06:10:22AM +0000, Wu, Wentong wrote:
>>>>> On Sent: Wednesday, February 15, 2023 5:46 PM, Laurent Pinchart wrote:
>>>>>> On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
>>>>>>> On 2/14/23 17:06, Sakari Ailus wrote:
>>>>>>>> On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
>>>>>>>>> IVSC directly connects to camera sensor on source side, and
>>>>>>>>> on output side it not only connects ISH via I2C, but also
>>>>>>>>> exposes MIPI
>>>>>>>>> CSI-2 interface to output camera sensor data. IVSC can use
>>>>>>>>> the camera sensor data to do AI algorithm, and send the results to
>> ISH.
>>>>>>>>> On the other end, IVSC can share camera sensor to host by
>>>>>>>>> routing the raw camera sensor data to the exposed MIPI
>>>>>>>>> CSI-2 interface. But they can not work at the same time, so
>>>>>>>>> software APIs are defined to sync the ownership.
>>>>>>>>>
>>>>>>>>> This commit defines the interfaces between IVSC and camera
>>>>>>>>> sensor driver in include/linux/ivsc.h. The camera driver
>>>>>>>>> controls ownership of the CSI-2 link and sensor with the
>>>>>>>>> acquire/release APIs. When acquiring camera, lane number
>>>>>>>>> and link freq are also required by IVSC frame router.
>>>>>>>>
>>>>>>>> The more I learn about this system, the more I'm inclined to
>>>>>>>> think this functionality should be exposed as a V4L2 sub-device.
>>>>>>>> IVSC doesn't really do anything to the data (as long as it
>>>>>>>> directs it towards the CSI-2 receiver in the SoC), but it is
>>>>>>>> definitely part of the image pipeline.
>>>>>>>
>>>>>>> Yes I happened to discuss this exact same thing with Laurent
>>>>>>> at FOSDEM and we also came to the conclusion that the IVSC
>>>>>>> chip should be modeled as a V4L2 sub-device.
>>>>>>
>>>>>> Agreed.
>>>>>
>>>>> Thanks for your quick review and conclusion, I'm fresh to media
>>>>> sub-system, is there any convention that I should follow to
>>>>> upstream this kind of v4l2 sub-device driver so that not too much
>>>>> back and forth?
>>>>
>>>> This is a tentative proposal, as I'm not very familiar with the
>>>> hardware
>>>> architecture:
>>>>
>>>> - The subdev should have two pads, a sink pad connected to the camera
>>>>   sensor, and a source pad connected to the CSI-2 receiver in the IPU.
>>>>
>>>> - As for any new driver, the subdev driver should use the active state
>>>>   managed by the v4l2-subdev core. This requires calling
>>>>   v4l2_subdev_init_finalize() at probe time. See
>>>>   https://git.linuxtv.org/media_tree.git/commit/?id=a2514b9a634a for an
>>>>   example of a subdev driver converted to this mechanism.
>>>>
>>>> - As we're talking about CSI-2, the subdev driver should use the streams
>>>>   API that was recently merged, and in particular support the
>>>>   .get_frame_desc(), .set_routing(), .enable_streams() and
>>>>   .disable_streams() operations.
>>>>
>>>> - I don't see a need to support V4L2 controls in the subdev driver, but
>>>>   I may be missing something.
>>>>
>>>> - The driver should be validated with v4l2-compliance, part of
>>>>   v4l-utils.
>>>>
>>>
>>> Thanks for the detail, but I have one more question, during probe of
>>> sensor(v4l2-sudev) driver, it will configure camera sensor connected
>>> to IVSC via I2C, but before that it should acquire camera sensor's
>>> ownership from IVSC, how v4l2 framework guarantee this?
>>
>> Please wrap the lines at 74 characters or so when replying.
> 
> Thanks, I will.
> 
>>
>> Do you mean accessing the sensor via I²C also requires acquiring the sensor
>> from IVSC?
> 
> Yes

Hmm, that is going to be a problem since  we really want to have
independent driver for the 2 which are not aware of each other.

I think that maybe we can model this part of the ivsc functionality
as an i2c-mux. But then we will need to somehow change the parent
of the i2c device for the sensor to the output of this mux ...

I guess this means adding some code (some hack likely) to
drivers/platform/x86/intel/int3472/discrete.c which' proe function 
is already guaranteed to run before the sensor's i2c-client gets
instantiated, because of the ACPI _DEP on the INT3472 ACPI device
in the DSDT.

This is going to be a tricky problem to tackle.

Regards,

Hans

