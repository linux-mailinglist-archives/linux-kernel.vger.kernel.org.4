Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3270E240
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbjEWQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjEWQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:36:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9C196;
        Tue, 23 May 2023 09:36:14 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:1ba:3e91:de16:9b34] (unknown [IPv6:2a01:e0a:120:3210:1ba:3e91:de16:9b34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB39566058F2;
        Tue, 23 May 2023 17:36:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684859772;
        bh=3CHENV+5lz2J3P/NrtkeHy+T26fSrnBLYvY12RFPujU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bn/9h34rplwZ8vt11Bie+wDUicXHyWL16UJevssSKdtIhuZdvsOWd59sLMpgNTVke
         O/kQ+cWgurR1TtUR9ztJy6CuT2wR4ov4Y+6ArXmgUNOT4nC1RC2p01y+3t/y1TyjRz
         PdaAMa24UeY+oYBNmNyqEb+UX3nksoipZ4MZv2LWF2JQjgtp52oyOKqMXyS9vsN8Z8
         /Cu5emY1niveMq6OoMuZ9DP24C6nOqEI5pPTrh+K0ZmhHg4OZO7TDpk5xBuLaHgMEN
         ES5XJu5vg/wF6+/qQNLuc2ILy9d5qCB23+Z1BJFlN3UcjOStELmSaoy0+wZ6Rrk8j8
         WJ/6zywxuozNQ==
Message-ID: <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
Date:   Tue, 23 May 2023 18:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
Content-Language: en-US
To:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, m.tretter@pengutronix.de,
        didi.debian@cknow.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
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


Le 23/05/2023 à 18:25, Benjamin Gaignard a écrit :
> This fixes the following issue observed on Odroid-M1 board:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>   Mem abort info:
>   ...
>   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_tables x_tables ipv6
>   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
>   Hardware name: Hardkernel ODROID-M1 (DT)
>   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
>   ...
>   Call trace:
>    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
>    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
>    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
>    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
>    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
>    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
>    hantro_open+0xd4/0x20c [hantro_vpu]
>    v4l2_open+0x80/0x120 [videodev]
>    chrdev_open+0xc0/0x22c
>    do_dentry_open+0x13c/0x48c
>    vfs_open+0x2c/0x38
>    path_openat+0x550/0x934
>    do_filp_open+0x80/0x12c
>    do_sys_openat2+0xb4/0x168
>    __arm64_sys_openat+0x64/0xac
>    invoke_syscall+0x48/0x114
>    el0_svc_common+0x100/0x120
>    do_el0_svc+0x3c/0xa8
>    el0_svc+0x40/0xa8
>    el0t_64_sync_handler+0xb8/0xbc
>    el0t_64_sync+0x190/0x194
>   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
>   ---[ end trace 0000000000000000 ]---
>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---

Diederick, Marek, Michael,
I have tested this patch on my boards and I see no regressions on
decoder part and no more crash when probing the encoder.
Could you test it on your side to confirm it is ok ?

Thorsten, I try/test regzbot commands, please tell me if it is correct.

#regzbot ^introduced db6f68b51e5c
#regzbot title media: verisilicon: null pointer dereference in try_fmt
#regzbot ignore-activity


>   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 835518534e3b..61cfaaf4e927 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
>   	if (!raw_vpu_fmt)
>   		return -EINVAL;
>   
> -	if (ctx->is_encoder)
> +	if (ctx->is_encoder) {
>   		encoded_fmt = &ctx->dst_fmt;
> -	else
> +		ctx->vpu_src_fmt = raw_vpu_fmt;
> +	} else {
>   		encoded_fmt = &ctx->src_fmt;
> +	}
>   
>   	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
>   	raw_fmt.width = encoded_fmt->width;
