Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2E70E26B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjEWQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjEWQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:33:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCE1B5;
        Tue, 23 May 2023 09:33:33 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:1ba:3e91:de16:9b34] (unknown [IPv6:2a01:e0a:120:3210:1ba:3e91:de16:9b34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B2D16605961;
        Tue, 23 May 2023 17:33:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684859610;
        bh=hm9GXI++V1p38wPBhy077rjD8CVi06sRryeA4cCqMHg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kVuXKut9UkTmyvKnD09JMb0Aq3PPcm1cOV6Wrxmksx+I+PGRLsexTAkGogbN0VeYU
         5qxJy63D8psw8n37zasdU1AIY+kHJ1NE+yycRw/HRZHZnkhi7FaVy1d2KrIjTnHQ7G
         bJkHMMLfpW4FqauR+X3+15sXQkxtVPLEkDdWuA0cqifCsY4ELOto3+OsW4Sn95MMJC
         VXdH4cuLcZZRAO4ft4pMWk+RANhrzjBuO6R5U0l8SqGK5W34HsiYKb+3/tfoy7A3h7
         YsCsydvzJ+B+ReYqKGggxjLxZfrSItSI2T3hp27bYvuU09zReWzP6bpcXy4mek54Hs
         BTXcVF0Nf7woA==
Message-ID: <50d751a5-c6bb-0b4b-4d4f-2a5d87be3dd4@collabora.com>
Date:   Tue, 23 May 2023 18:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        m.tretter@pengutronix.de, didi.debian@cknow.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
 <CAAEAJfDgJM++zHzR9ez94ZgRSr7H6NrohsG8=+8722ZEjC1gRg@mail.gmail.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfDgJM++zHzR9ez94ZgRSr7H6NrohsG8=+8722ZEjC1gRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 23/05/2023 à 18:28, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> Thanks for the patch.
>
> On Tue, May 23, 2023 at 1:25 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> This fixes the following issue observed on Odroid-M1 board:
>>
>>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> What pointer is NULL? ctx->src_fmt ?

yes ctx->vpu_src_fmt pointer was NULL when probing the encoder.

>
>>   Mem abort info:
>>   ...
>>   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_tables x_tables ipv6
>>   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
>>   Hardware name: Hardkernel ODROID-M1 (DT)
>>   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>>   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
>>   ...
>>   Call trace:
>>    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>>    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
>>    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
>>    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
>>    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
>>    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
>>    hantro_open+0xd4/0x20c [hantro_vpu]
>>    v4l2_open+0x80/0x120 [videodev]
>>    chrdev_open+0xc0/0x22c
>>    do_dentry_open+0x13c/0x48c
>>    vfs_open+0x2c/0x38
>>    path_openat+0x550/0x934
>>    do_filp_open+0x80/0x12c
>>    do_sys_openat2+0xb4/0x168
>>    __arm64_sys_openat+0x64/0xac
>>    invoke_syscall+0x48/0x114
>>    el0_svc_common+0x100/0x120
>>    do_el0_svc+0x3c/0xa8
>>    el0_svc+0x40/0xa8
>>    el0t_64_sync_handler+0xb8/0xbc
>>    el0t_64_sync+0x190/0x194
>>   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
>>   ---[ end trace 0000000000000000 ]---
>>
>> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 835518534e3b..61cfaaf4e927 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
>>          if (!raw_vpu_fmt)
>>                  return -EINVAL;
>>
>> -       if (ctx->is_encoder)
>> +       if (ctx->is_encoder) {
>>                  encoded_fmt = &ctx->dst_fmt;
>> -       else
>> +               ctx->vpu_src_fmt = raw_vpu_fmt;
>> +       } else {
>>                  encoded_fmt = &ctx->src_fmt;
>> +       }
>>
>>          hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
>>          raw_fmt.width = encoded_fmt->width;
>> --
>> 2.34.1
>>
