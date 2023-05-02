Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D16F3DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjEBG4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjEBG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:56:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686B19B0;
        Mon,  1 May 2023 23:56:36 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:99ed:5b64:8e6c:9ae8] (unknown [IPv6:2a01:e0a:120:3210:99ed:5b64:8e6c:9ae8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29511660321C;
        Tue,  2 May 2023 07:56:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683010594;
        bh=8t4NEIsAniO3bd4vVmshsKlWfKThNbxeZzung0MKcYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CxRipMmYZnEJokm7XxvfHMn0v1DBzq4htksP9Ch1Ly30DVrbA2Lf+NVuacQR36bXg
         sDb5sqfb6ovBim+Ivm/Tda+aNmT+fF7vp6hF1soQ64867Oqh1NcCkb2Oz0+gbwLGIW
         TmsqsojR9eM2zlDUFtiIYUG+4hhEoJIP98bqo7WniUpdZgecqlLcd09EbBzQ7J9rxQ
         5Pzs1DHnIISvbH9fW9gnYIRHVCFFWB5K34pPPuZYRxc05s7wvtQeJmWKQZ0USzZPCx
         kQJ3IebZ8CkDQ5VAMLbQqo4zk2VSmIDgeoKJMTf5k47tx/Dg6V0uErtOt6H0a/sR8y
         VwDr83a7fdfRw==
Message-ID: <05da00c0-2180-62ee-6276-8553ad9341c4@collabora.com>
Date:   Tue, 2 May 2023 08:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Shreeya Patel <shreeya.patel@collabora.com>
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
 <dcd317db-3c24-895d-572b-1b139c370ff7@leemhuis.info>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <dcd317db-3c24-895d-572b-1b139c370ff7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/05/2023 à 09:21, Thorsten Leemhuis a écrit :
> On 27.04.23 00:19, Shreeya Patel wrote:
>> On 20/02/23 16:18, Benjamin Gaignard wrote:
>>> Setting context source and destination formats should only be done
>>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>>> the targeted queue is not busy.
>>> Remove these calls from hantro_reset_encoded_fmt() and
>>> hantro_reset_raw_fmt() to clean the driver.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> KernelCI found this patch causes a regression in the
>> baseline.dmesg.alert test [1] on rk3399-rock-pi-4b [2],
>> see the bisection report for more details [3].
>>
>> Let us know if you have any questions.
>>
>>
>> [1]
>> https://github.com/kernelci/kernelci-core/blob/main/config/rootfs/debos/overlays/baseline/opt/kernelci/dmesg.sh
>> [2] https://linux.kernelci.org/test/case/id/6442e825f19134d74c2e865d/
>> [3] https://groups.io/g/kernelci-results/message/40740
> Thx for the report. FWIW, regzbot noticed there is a patch that refers
> to the culprit that might have been landed in next after your test ran
> for the last time (and meanwhile it was mainlined): f100ce3bbd6 ("media:
> verisilicon: Fix crash when probing encoder")

Yes that patch should fix the probing issue.
Marek is working on an additional one to fix pixel format negotiation
but that doesn't impact the boot.

Regards,
Benjamin

>
> I wonder if that is related or might even fix the issue.
>
> Ciao, Thorsten
>
>>> ---
>>>    drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> index c0d427956210..d8aa42bd4cd4 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>>>          vpu_fmt = hantro_get_default_fmt(ctx, true);
>>>    -    if (ctx->is_encoder) {
>>> -        ctx->vpu_dst_fmt = vpu_fmt;
>>> +    if (ctx->is_encoder)
>>>            fmt = &ctx->dst_fmt;
>>> -    } else {
>>> -        ctx->vpu_src_fmt = vpu_fmt;
>>> +    else
>>>            fmt = &ctx->src_fmt;
>>> -    }
>>>          hantro_reset_fmt(fmt, vpu_fmt);
>>>        fmt->width = vpu_fmt->frmsize.min_width;
>>> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>>        raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
>>>          if (ctx->is_encoder) {
>>> -        ctx->vpu_src_fmt = raw_vpu_fmt;
>>>            raw_fmt = &ctx->src_fmt;
>>>            encoded_fmt = &ctx->dst_fmt;
>>>        } else {
>>> -        ctx->vpu_dst_fmt = raw_vpu_fmt;
>>>            raw_fmt = &ctx->dst_fmt;
>>>            encoded_fmt = &ctx->src_fmt;
>>>        }
>>
