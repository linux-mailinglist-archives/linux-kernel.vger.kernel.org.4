Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153636382AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYDZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKYDZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:25:21 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E42189B;
        Thu, 24 Nov 2022 19:25:19 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2AP2xDVf033118;
        Fri, 25 Nov 2022 10:59:13 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Nov
 2022 11:23:42 +0800
Message-ID: <80b80234-7dbb-4344-0328-15e83ef2357e@aspeedtech.com>
Date:   Fri, 25 Nov 2022 11:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid
 log spam
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <hverkuil-cisco@xs4all.nl>,
        <zev@bewilderbeest.net>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20221110095611.522-1-jammy_huang@aspeedtech.com>
 <c8a4a3b6-6591-2710-433f-642277eeb8f3@molgen.mpg.de>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <c8a4a3b6-6591-2710-433f-642277eeb8f3@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2AP2xDVf033118
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/11/23 下午 04:08, Paul Menzel wrote:
> Dear Jammy,
>
>
> Am 10.11.22 um 10:56 schrieb Jammy Huang:
>> If the host is powered off, there will be many warning log. To avoid the
>
> …, many warnings are logged.
>
> Also, please paste one example message.
OK
>
> Are the messages really just debug messages, or only in the one 
> condition? If the latter, another solution should be found, like 
> checking if the host is powered off, or rate limiting the message.

In my opinion, these logs are the former one.

video: Timed out; first mode detect

=> This would happen if timing detection failed.

No signal; don't start frame

=> This would happen when timing-detection is not finished with valid 
resolution detected.

>
>> log spam in this condition, replace v4l2_warn with v4l2_dbg.
>
> Please add a reference, to Zev’s report on the mailing list.
>
> Link: …
OK, thanks.
>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed/aspeed-video.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed/aspeed-video.c 
>> b/drivers/media/platform/aspeed/aspeed-video.c
>> index cf76aeee8cb6..662465d13a0e 100644
>> --- a/drivers/media/platform/aspeed/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed/aspeed-video.c
>> @@ -586,13 +586,13 @@ static int aspeed_video_start_frame(struct 
>> aspeed_video *video)
>>       bool bcd_buf_need = (video->format != VIDEO_FMT_STANDARD);
>>         if (video->v4l2_input_status) {
>> -        v4l2_warn(&video->v4l2_dev, "No signal; don't start frame\n");
>> +        v4l2_dbg(1, debug, &video->v4l2_dev, "No signal; don't start 
>> frame\n");
>>           return 0;
>>       }
>>         if (!(seq_ctrl & VE_SEQ_CTRL_COMP_BUSY) ||
>>           !(seq_ctrl & VE_SEQ_CTRL_CAP_BUSY)) {
>> -        v4l2_warn(&video->v4l2_dev, "Engine busy; don't start 
>> frame\n");
>> +        v4l2_dbg(1, debug, &video->v4l2_dev, "Engine busy; don't 
>> start frame\n");
>>           return -EBUSY;
>>       }
>>   @@ -615,7 +615,7 @@ static int aspeed_video_start_frame(struct 
>> aspeed_video *video)
>>                          struct aspeed_video_buffer, link);
>>       if (!buf) {
>>           spin_unlock_irqrestore(&video->lock, flags);
>> -        v4l2_warn(&video->v4l2_dev, "No buffers; don't start frame\n");
>> +        v4l2_dbg(1, debug, &video->v4l2_dev, "No buffers; don't 
>> start frame\n");
>>           return -EPROTO;
>>       }
>>   @@ -796,7 +796,7 @@ static irqreturn_t aspeed_video_irq(int irq, 
>> void *arg)
>>               if (video->format == VIDEO_FMT_STANDARD &&
>>                   list_is_last(&buf->link, &video->buffers)) {
>>                   empty = false;
>> -                v4l2_warn(&video->v4l2_dev, "skip to keep last frame 
>> updated\n");
>> +                v4l2_dbg(1, debug, &video->v4l2_dev, "skip to keep 
>> last frame updated\n");
>>               } else {
>>                   buf->vb.vb2_buf.timestamp = ktime_get_ns();
>>                   buf->vb.sequence = video->sequence++;
>> @@ -1060,7 +1060,7 @@ static void aspeed_video_get_resolution(struct 
>> aspeed_video *video)
>>                                 res_check(video),
>>                                 MODE_DETECT_TIMEOUT);
>>           if (!rc) {
>> -            v4l2_warn(&video->v4l2_dev, "Timed out; first mode 
>> detect\n");
>> +            v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; first 
>> mode detect\n");
>>               clear_bit(VIDEO_RES_DETECT, &video->flags);
>>               return;
>>           }
>> @@ -1081,7 +1081,7 @@ static void aspeed_video_get_resolution(struct 
>> aspeed_video *video)
>>                                 MODE_DETECT_TIMEOUT);
>>           clear_bit(VIDEO_RES_DETECT, &video->flags);
>>           if (!rc) {
>> -            v4l2_warn(&video->v4l2_dev, "Timed out; second mode 
>> detect\n");
>> +            v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; second 
>> mode detect\n");
>>               return;
>>           }
>>   @@ -1104,7 +1104,7 @@ static void 
>> aspeed_video_get_resolution(struct aspeed_video *video)
>>       } while (invalid_resolution && (tries++ < 
>> INVALID_RESOLUTION_RETRIES));
>>         if (invalid_resolution) {
>> -        v4l2_warn(&video->v4l2_dev, "Invalid resolution detected\n");
>> +        v4l2_dbg(1, debug, &video->v4l2_dev, "Invalid resolution 
>> detected\n");
>>           return;
>>       }
>>   @@ -1856,7 +1856,7 @@ static void 
>> aspeed_video_stop_streaming(struct vb2_queue *q)
>>                   !test_bit(VIDEO_FRAME_INPRG, &video->flags),
>>                   STOP_TIMEOUT);
>>       if (!rc) {
>> -        v4l2_warn(&video->v4l2_dev, "Timed out when stopping 
>> streaming\n");
>> +        v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out when 
>> stopping streaming\n");
>>             /*
>>            * Need to force stop any DMA and try and get HW into a good
>>
>> base-commit: aae703b02f92bde9264366c545e87cec451de471
>> prerequisite-patch-id: bf47e8ab2998acfbc32be5a4b7b5ae8a3ae4218b
>> prerequisite-patch-id: bf82715983e08f2e810ff1a82ce644f5f9006cd9
>> prerequisite-patch-id: 28a2040ef0235e5765f05d2fc5529bce2a0f4c6f
>> prerequisite-patch-id: 7e761c779730536db8baf50db5fc8caf058e95af
>> prerequisite-patch-id: c48ea20973fa35938a7d33a0e20d2900df48755f

-- 
Best Regards
Jammy

