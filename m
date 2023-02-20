Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7C469D14A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjBTQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjBTQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:24:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933B1E9D8;
        Mon, 20 Feb 2023 08:24:34 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:d30c:b155:96fb:dcc] (unknown [IPv6:2a01:e0a:120:3210:d30c:b155:96fb:dcc])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FB746602149;
        Mon, 20 Feb 2023 16:24:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676910272;
        bh=g2IHNrew0kWcRPOw2e3XyoeeIUPD0YEIAtIZiAGobF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Na154KLhB9zEUG8GfxTqr6v0pbvHwVgfIavVzgzRWoHlgGcxnzrB3mUg4srgRwG19
         aGAOaXcSrWuAwxyOxltOOjjZ8RGrDdk+soV+FozMRexYLiZvGugivhWGaQ7k5invVv
         DDeL4HWp/jO72vRXyV2vQx+tWaXWWzSHbfSxgpVSJ52VrC51aCuB+xI2WR0MDEewSB
         3YN5QXuvvKl2wGKbPgiacoivHzbZOgKuL47luAK8h03olp0B3B4fjGfiSAdSxfoqZD
         1Ko8gEkWdrHuQ9LlNkuxJHuZya9FzVNUxJiUsB46MkB+UWt+Ve8tlIK3D8LHJzGd+t
         n8v8UFDN3rBcA==
Message-ID: <c4d355d5-5e14-8eba-1944-fc26b1050cf5@collabora.com>
Date:   Mon, 20 Feb 2023 17:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 06/12] media: verisilicon: Check AV1 bitstreams bit
 depth
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, nicolas.dufresne@collabora.com,
        jernej.skrabec@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
 <20230214140557.537984-7-benjamin.gaignard@collabora.com>
 <CAAEAJfDihZND+1FSzFxT86j9u6h-wH6uMMNh7BiaEWQWtSpk=Q@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfDihZND+1FSzFxT86j9u6h-wH6uMMNh7BiaEWQWtSpk=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 18/02/2023 à 14:11, Ezequiel Garcia a écrit :
> On Tue, Feb 14, 2023 at 11:06 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> The driver supports 8 and 10 bits bitstreams, make sure to discard
>> other cases.
>> It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENCE
>> exists without setting bit_depth field in this case use
>> HANTRO_DEFAULT_BIT_DEPTH value.
>>
> This shouldn't happen.
>
> If the bit_depth argument in hantro_check_depth_match()
> can be set unchecked by userspace, we have done something wrong!!
>
> Are you sure that userspace can do a S_CTRL with an invalid bit-depth?
> The try_or_set_cluster() function seems to always call try_ctrl before s_ctrl.

I have dump the stack when AV1 sequence bit depth = 0 in s_ctrl.
It is happening when opening the driver, v4l2 setup the ctrls by calling __v4l2_ctrl_handler_setup()
this led to call hantro_av1_s_ctrl() with empty structure.

For other codecs isn't a problem because bit depth is coded with a minus 8 value (ie: 8 bits = 0)
while for AV1 it is the real value (ie: 8 bits = 8).

[   88.478751] Hardware name: Radxa Rock 5A Board (DT)
[   88.479184] Call trace:
[   88.479406]  dump_backtrace.part.0+0xdc/0xf0
[   88.479796]  show_stack+0x18/0x30
[   88.480099]  dump_stack_lvl+0x68/0x84
[   88.480431]  dump_stack+0x18/0x34
[   88.480732]  hantro_av1_s_ctrl+0x7c/0xcc [hantro_vpu]
[   88.481211]  __v4l2_ctrl_handler_setup+0x120/0x154
[   88.481643]  v4l2_ctrl_handler_setup+0x2c/0x50
[   88.482043]  hantro_open+0x138/0x204 [hantro_vpu]
[   88.482490]  v4l2_open+0xa8/0x124
[   88.482794]  chrdev_open+0xc0/0x22c
[   88.483114]  do_dentry_open+0x13c/0x490
[   88.483464]  vfs_open+0x2c/0x40
[   88.483749]  path_openat+0x878/0xe50
[   88.484074]  do_filp_open+0x80/0x130
[   88.484399]  do_sys_openat2+0xb4/0x170
[   88.484736]  __arm64_sys_openat+0x60/0xb0
[   88.485097]  invoke_syscall+0x48/0x114
[   88.485437]  el0_svc_common.constprop.0+0x44/0xfc
[   88.485860]  do_el0_svc+0x3c/0xc0
[   88.486163]  el0_svc+0x2c/0x84
[   88.486441]  el0t_64_sync_handler+0xbc/0x140
[   88.486826]  el0t_64_sync+0x190/0x194

Regards,
Benjamin

>
> Thanks,
> Ezequiel
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> version 4:
>> - This patch is the result of squashing "Save bit depth for AV1 decoder"
>>    and "Check AV1 bitstreams bit depth" of version 3 + adapation to
>>    "[PATCH v8 0/6] media: verisilicon: HEVC: fix 10bits handling" series.
>>
>>   .../media/platform/verisilicon/hantro_drv.c   | 36 +++++++++++++++++++
>>   .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index bc1a85456142..666cd46902da 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -275,7 +275,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>                  /* We only support profile 0 */
>>                  if (dec_params->profile != 0)
>>                          return -EINVAL;
>> +       } else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
>> +               const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
>> +
>> +               if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
>> +                       return -EINVAL;
>>          }
>> +
>>          return 0;
>>   }
>>
>> @@ -348,6 +354,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>>          return 0;
>>   }
>>
>> +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +       struct hantro_ctx *ctx;
>> +
>> +       ctx = container_of(ctrl->handler,
>> +                          struct hantro_ctx, ctrl_handler);
>> +
>> +       switch (ctrl->id) {
>> +       case V4L2_CID_STATELESS_AV1_SEQUENCE:
>> +       {
>> +               int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
>> +
>> +               if (ctx->bit_depth == bit_depth)
>> +                       return 0;
>> +
>> +               return hantro_reset_raw_fmt(ctx, bit_depth);
>> +       }
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>>          .try_ctrl = hantro_try_ctrl,
>>   };
>> @@ -365,6 +395,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>>          .s_ctrl = hantro_hevc_s_ctrl,
>>   };
>>
>> +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops = {
>> +       .try_ctrl = hantro_try_ctrl,
>> +       .s_ctrl = hantro_av1_s_ctrl,
>> +};
>> +
>>   #define HANTRO_JPEG_ACTIVE_MARKERS     (V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>>                                           V4L2_JPEG_ACTIVE_MARKER_COM | \
>>                                           V4L2_JPEG_ACTIVE_MARKER_DQT | \
>> @@ -542,6 +577,7 @@ static const struct hantro_ctrl controls[] = {
>>                  .codec = HANTRO_AV1_DECODER,
>>                  .cfg = {
>>                          .id = V4L2_CID_STATELESS_AV1_SEQUENCE,
>> +                       .ops = &hantro_av1_ctrl_ops,
>>                  },
>>          }, {
>>                  .codec = HANTRO_AV1_DECODER,
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 992c5baa929f..7e74e47c9a89 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -86,6 +86,10 @@ hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>>          if (!fmt->match_depth && !fmt->postprocessed)
>>                  return true;
>>
>> +       /* 0 means default depth, which is 8 */
>> +       if (!bit_depth)
>> +               bit_depth = HANTRO_DEFAULT_BIT_DEPTH;
>> +
>>          fmt_depth = hantro_get_format_depth(fmt->fourcc);
>>
>>          /*
>> --
>> 2.34.1
>>
