Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3026E5BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjDRIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjDRIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273855BB;
        Tue, 18 Apr 2023 01:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391AB625ED;
        Tue, 18 Apr 2023 08:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F15C433EF;
        Tue, 18 Apr 2023 08:09:34 +0000 (UTC)
Message-ID: <5c649a34-90cb-d02b-2737-7c9a858c3faa@xs4all.nl>
Date:   Tue, 18 Apr 2023 10:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 14/20] staging: media: tegra-video: move MIPI
 calibration calls from VI to CSI
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
 <20230407133852.2850145-15-luca.ceresoli@bootlin.com>
 <04e89fcc-87db-8677-daf9-48aa3cb61b8c@xs4all.nl>
 <20230418100756.329305ca@booty>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230418100756.329305ca@booty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 10:07, Luca Ceresoli wrote:
> Hi Hans,
> 
> On Fri, 14 Apr 2023 17:51:34 +0200
> Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> 
>> Hi Luca,
>>
>> I just encountered an error in this patch, so I have rejected the PR I made.
>>
>> See below for the details:
>>
>> On 07/04/2023 15:38, Luca Ceresoli wrote:
>>> The CSI module does not handle all the MIPI lane calibration procedure,
>>> leaving a small part of it to the VI module. In doing this,
>>> tegra_channel_enable_stream() (vi.c) manipulates the private data of the
>>> upstream subdev casting it to struct 'tegra_csi_channel', which will be
>>> wrong after introducing a VIP (parallel video input) channel.
>>>
>>> This prevents adding support for the VIP module.  It also breaks the
>>> logical isolation between modules.
>>>
>>> Since the lane calibration requirement does not exist in the parallel input
>>> module, moving the calibration function to a per-module op is not
>>> optimal. Instead move the calibration procedure in the CSI module, together
>>> with the rest of the calibration procedures. After this change,
>>> tegra_channel_enable_stream() just calls v4l2_subdev_call() to ask for a
>>> stream start/stop to the CSI module, which in turn knows all the
>>> CSI-specific details to implement it.
>>>
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> ---
>>>
>>> No changes in v5
>>>
>>> Changed in v4:
>>>  - Added review tags
>>>
>>> No changes in v3
>>> No changes in v2
>>> ---
>>>  drivers/staging/media/tegra-video/csi.c | 44 ++++++++++++++++++++
>>>  drivers/staging/media/tegra-video/vi.c  | 54 ++-----------------------
>>>  2 files changed, 48 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
>>> index 9a03d5ccdf3c..b93fc879ef3a 100644
>>> --- a/drivers/staging/media/tegra-video/csi.c
>>> +++ b/drivers/staging/media/tegra-video/csi.c
>>> @@ -328,12 +328,42 @@ static int tegra_csi_enable_stream(struct v4l2_subdev *subdev)
>>>  	}
>>>  
>>>  	csi_chan->pg_mode = chan->pg_mode;
>>> +
>>> +	/*
>>> +	 * Tegra CSI receiver can detect the first LP to HS transition.
>>> +	 * So, start the CSI stream-on prior to sensor stream-on and
>>> +	 * vice-versa for stream-off.
>>> +	 */
>>>  	ret = csi->ops->csi_start_streaming(csi_chan);
>>>  	if (ret < 0)
>>>  		goto finish_calibration;
>>>  
>>> +	if (csi_chan->mipi) {
>>> +		struct v4l2_subdev *src_subdev;
>>> +		/*
>>> +		 * TRM has incorrectly documented to wait for done status from
>>> +		 * calibration logic after CSI interface power on.
>>> +		 * As per the design, calibration results are latched and applied
>>> +		 * to the pads only when the link is in LP11 state which will happen
>>> +		 * during the sensor stream-on.
>>> +		 * CSI subdev stream-on triggers start of MIPI pads calibration.
>>> +		 * Wait for calibration to finish here after sensor subdev stream-on.
>>> +		 */
>>> +		src_subdev = tegra_channel_get_remote_source_subdev(chan);
>>> +		ret = v4l2_subdev_call(src_subdev, video, s_stream, true);
>>> +		err = tegra_mipi_finish_calibration(csi_chan->mipi);
>>> +
>>> +		if (ret < 0 && ret != -ENOIOCTLCMD)
>>> +			goto disable_csi_stream;  
>>
>> If there was an error from s_stream, then tegra_mipi_finish_calibration is called
>> and it goes to disable_csi_stream...
>>
>>> +
>>> +		if (err < 0)
>>> +			dev_warn(csi->dev, "MIPI calibration failed: %d\n", err);
>>> +	}
>>> +
>>>  	return 0;
>>>  
>>> +disable_csi_stream:
>>> +	csi->ops->csi_stop_streaming(csi_chan);
>>>  finish_calibration:
>>>  	if (csi_chan->mipi)
>>>  		tegra_mipi_finish_calibration(csi_chan->mipi);  
>>
>> ...but here tegra_mipi_finish_calibration() is called again, leading to an unlock
>> imbalance.
> 
> Many thanks for your testing! Unfortunately I have no Tegra210 hardware
> so this never happened here, but with your report the problem got
> obvious and, luckily, the fix appeared to be just a oneliner.
> 
> v6 just sent! I'm wondering whether there is still hope to get this
> 6.4...

Sorry, it's too late for 6.4 now. Only fixes can go in for 6.4.

Regards,

	Hans

> 
> Best regards,
> Luca
> 

