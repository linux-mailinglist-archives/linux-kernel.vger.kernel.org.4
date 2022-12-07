Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE366456AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLGJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiLGJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:37:44 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A236A42981;
        Wed,  7 Dec 2022 01:37:24 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2B79QuVC047635;
        Wed, 7 Dec 2022 17:26:56 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Dec
 2022 17:35:19 +0800
Message-ID: <8bd7b378-70c9-bcd2-2d81-f6567a9f63fb@aspeedtech.com>
Date:   Wed, 7 Dec 2022 17:35:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 1/5] media: v4l: Add definition for the Aspeed JPEG
 format
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <hverkuil-cisco@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <xavier.roumegue@oss.nxp.com>,
        <ezequiel@vanguardiasur.com.ar>, <stanimir.varbanov@linaro.org>,
        <nicolas.dufresne@collabora.com>, <ming.qian@nxp.com>,
        <andrzej.p@collabora.com>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20221028023554.928-1-jammy_huang@aspeedtech.com>
 <20221028023554.928-2-jammy_huang@aspeedtech.com>
 <Y4oKdBApOGk9TUHO@paasikivi.fi.intel.com>
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <Y4oKdBApOGk9TUHO@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2B79QuVC047635
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,


After discussing with Hans, I will send patches on top to update this.

Thanks for your review.


On 2022/12/2 下午 10:23, Sakari Ailus wrote:
> Hi Jammy,
>
> Apologies for a late reply.
>
> On Fri, Oct 28, 2022 at 10:35:50AM +0800, Jammy Huang wrote:
>> This introduces support for the Aspeed JPEG format, where the new frame
>> can refer to previous frame to reduce the amount of compressed data.
>> The concept is similar to I/P frame of video compression. It will
>> compare the new frame with previous one to decide which macroblock's
>> data is changed, and only the changed macroblocks will be compressed.
>>
>> This Aspeed JPEG format is used by the video engine on Aspeed platforms,
>> which is generally adapted for remote KVM.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> v11:
>>    - no update
>> v10:
>>    - no update
>> v9:
>>    - Rebase on new kernel
>> v8:
>>    - Add decoder information for aspeed-jpeg
>> v7:
>>    - Add more information for aspeed-jpeg
>> v6:
>>    - Update description for new format, aspeed-jpeg, in Documentation.
>> v5:
>>    - no update
>> v4:
>>    - new
>> ---
>>   .../userspace-api/media/v4l/pixfmt-reserved.rst | 17 +++++++++++++++++
>>   drivers/media/v4l2-core/v4l2-ioctl.c            |  1 +
>>   include/uapi/linux/videodev2.h                  |  1 +
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> index 0ff68cd8cf62..73cd99828010 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> @@ -258,6 +258,23 @@ please make a proposal on the linux-media mailing list.
>>           and it is used by various multimedia hardware blocks like GPU, display
>>           controllers, ISP and video accelerators.
>>           It contains four planes for progressive video.
>> +    * .. _V4L2-PIX-FMT-AJPG:
>> +
>> +      - ``V4L2_PIX_FMT_AJPG``
>> +      - 'AJPG'
>> +      - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
>> +        which is generally adapted for remote KVM.
>> +        On each frame compression, I will compare the new frame with previous
>> +        one to decide which macroblock's data is changed, and only the changed
>> +        macroblocks will be compressed.
>> +
>> +        The implementation is based on AST2600 A3 datasheet, revision 0.9, which
>> +        is not publicly available. Or you can reference Video stream data format
>> +        – ASPEED mode compression of SDK_User_Guide which available on
>> +        AspeedTech-BMC/openbmc/releases.
> What does this refer to? If it's a URL, please add a reference as below.
>
> Also please run this on the patches:
>
> 	$ scripts/checkpatch.pl --strict --max-line-length=80
>
>> +
>> +        Decoder's implementation can be found here,
>> +        `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
>>   .. raw:: latex
>>   
>>       \normalsize
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index fddba75d9074..8cb4b976064e 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>   		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>>   		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
>>   		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>> +		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
>>   		default:
>>   			if (fmt->description[0])
>>   				return;
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 86cae23cc446..870a7e5ef8ca 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
>>   #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
>>   #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
>> +#define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
>>   
>>   /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>>   #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */

-- 
Best Regards
Jammy

