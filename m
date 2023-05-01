Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9636F2F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjEAHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEAHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:22:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17061E53;
        Mon,  1 May 2023 00:21:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ptNr8-0001Go-Es; Mon, 01 May 2023 09:21:54 +0200
Message-ID: <dcd317db-3c24-895d-572b-1b139c370ff7@leemhuis.info>
Date:   Mon, 1 May 2023 09:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, robert.mader@collabora.com,
        nicolas.dufresne@collabora.co.uk, ezequiel@vanguardiasur.com.ar,
        festevam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        hverkuil-cisco@xs4all.nl, linux-imx@nxp.com,
        regressions@lists.linux.dev
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
 <20230220104849.398203-2-benjamin.gaignard@collabora.com>
 <26addb7d-bb9d-34e8-d4fe-e323ff488101@collabora.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
In-Reply-To: <26addb7d-bb9d-34e8-d4fe-e323ff488101@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1682925718;5ed265df;
X-HE-SMSGID: 1ptNr8-0001Go-Es
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.23 00:19, Shreeya Patel wrote:
> On 20/02/23 16:18, Benjamin Gaignard wrote:
>> Setting context source and destination formats should only be done
>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>> the targeted queue is not busy.
>> Remove these calls from hantro_reset_encoded_fmt() and
>> hantro_reset_raw_fmt() to clean the driver.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
> KernelCI found this patch causes a regression in the
> baseline.dmesg.alert test [1] on rk3399-rock-pi-4b [2],
> see the bisection report for more details [3].
> 
> Let us know if you have any questions.
> 
> 
> [1]
> https://github.com/kernelci/kernelci-core/blob/main/config/rootfs/debos/overlays/baseline/opt/kernelci/dmesg.sh
> [2] https://linux.kernelci.org/test/case/id/6442e825f19134d74c2e865d/
> [3] https://groups.io/g/kernelci-results/message/40740

Thx for the report. FWIW, regzbot noticed there is a patch that refers
to the culprit that might have been landed in next after your test ran
for the last time (and meanwhile it was mainlined): f100ce3bbd6 ("media:
verisilicon: Fix crash when probing encoder")

I wonder if that is related or might even fix the issue.

Ciao, Thorsten

>> ---
>>   drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index c0d427956210..d8aa42bd4cd4 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>>         vpu_fmt = hantro_get_default_fmt(ctx, true);
>>   -    if (ctx->is_encoder) {
>> -        ctx->vpu_dst_fmt = vpu_fmt;
>> +    if (ctx->is_encoder)
>>           fmt = &ctx->dst_fmt;
>> -    } else {
>> -        ctx->vpu_src_fmt = vpu_fmt;
>> +    else
>>           fmt = &ctx->src_fmt;
>> -    }
>>         hantro_reset_fmt(fmt, vpu_fmt);
>>       fmt->width = vpu_fmt->frmsize.min_width;
>> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>       raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
>>         if (ctx->is_encoder) {
>> -        ctx->vpu_src_fmt = raw_vpu_fmt;
>>           raw_fmt = &ctx->src_fmt;
>>           encoded_fmt = &ctx->dst_fmt;
>>       } else {
>> -        ctx->vpu_dst_fmt = raw_vpu_fmt;
>>           raw_fmt = &ctx->dst_fmt;
>>           encoded_fmt = &ctx->src_fmt;
>>       }
> 
> 
