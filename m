Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E772BE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjFLKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjFLKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:09:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11016EAF;
        Mon, 12 Jun 2023 02:50:15 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A183C66058B2;
        Mon, 12 Jun 2023 10:50:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686563414;
        bh=wmvtK+oqOxpBOXyKAz7/3lsmHYoDLT73jaS8Dq7DrvU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8DimQV8BiihOvWjkoF6sFhzMDYc3It7wJ21l8LGYxicqoybjtzpGITCR854Kzqqb
         3ArSMUrQeYZF59l+rT7j1AsWLIsc9wXkmxJoDS+00fUL29GDidt8rFfJCqC3+ZaTTu
         LmHOTDji8oRzvkKF9xRrzlJNO7SGnBzDhgmdgTNOijTJ4R8pPHD1kfurMnHGjXlxV7
         U4uYPMfoCFMNOgZcQRNeiCcJZwy1NTI3IiILJheEEWGWNhjPUColFo1brGPyinxBF7
         XzQSEybCdoCUptfegsX1nFXVycNp9Q+xMKduRLO/48xX9LBZ/qdxeSTBZDyR9wcsEn
         BZgu93plqdetg==
Message-ID: <518923e0-029c-f206-7900-c396682a230d@collabora.com>
Date:   Mon, 12 Jun 2023 11:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] media: mediatek: vcodec: fix cancel_work_sync fail with
 fluster test
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230612031557.17959-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612031557.17959-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/06/23 05:15, Yunfei Dong ha scritto:
> Will cause below warning then reboot when exercising the decoder with
> fluster on mt8192-asurada-spherion.
> 
> This deinit function is called on the v4l2 release callback, even though the
> work might not have been initialized as that only happens if/when the codec
> specific 'decode' callback is called (as a result of device_run m2m callback).
> 
> CPU: 5 PID: 2338 Comm: gst-launch-1.0 Tainted: G        W          6.4.0-rc5-next-20230607+ #475
> Hardware name: Google Spherion (rev0 - 3) (DT)
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __flush_work.isra.0+0x23c/0x258
> lr : __cancel_work_timer+0x14c/0x1c8
> sp : ffff8000896e3b00
> x29: ffff8000896e3b00 x28: ffff57c3d4079f80 x27: 0000000000000000
> x26: ffff57c3d4079f80 x25: ffffb76395b59dc8 x24: 0000000000000001
> x23: ffffb763928daab8 x22: ffff57c3d4079f80 x21: 0000000000000000
> x20: ffffb763955f6778 x19: ffff57c3cf06f4a0 x18: 0000000000000000
> x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
> x14: ffff57c3c03a1f80 x13: ffffa0616a2fc000 x12: 000000003464d91d
> x11: 0000000000000000 x10: 0000000000001b10 x9 : ffffb763928de61c
> x8 : ffff57c3d407baf0 x7 : 0000000000000000 x6 : ffff57c3d4079f80
> x5 : ffff57c3d4079f80 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffff8000896e3bf0 x1 : 0000000000000011 x0 : 0000000000000000
> Call trace:
>   __flush_work.isra.0+0x23c/0x258
>   __cancel_work_timer+0x14c/0x1c8
>   cancel_work_sync+0x1c/0x30
>   vdec_msg_queue_deinit+0xac/0xc8
>   vdec_h264_slice_deinit+0x64/0xb8
>   vdec_if_deinit+0x3c/0x68
>   mtk_vcodec_dec_release+0x20/0x40
>   fops_vcodec_release+0x50/0xd8
>   v4l2_release+0x7c/0x100
>   __fput+0x80/0x270
>   ____fput+0x18/0x30
>   task_work_run+0x78/0xe0
>   do_notify_resume+0x29c/0x7f8
>   el0_svc+0xa4/0xb8
>   el0t_64_sync_handler+0xc0/0xc8
>   el0t_64_sync+0x1a8/0x1b0
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 297160d411e3 ("media: mediatek: vcodec: move core context from device to each instance")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

You missed a tag...
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

after adding that tag:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

> ---
>   drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> index f555341ae708..04e6dc6cfa1d 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> @@ -233,7 +233,8 @@ void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
>   		kfree(lat_buf->private_data);
>   	}
>   
> -	cancel_work_sync(&msg_queue->core_work);
> +	if (msg_queue->wdma_addr.size)
> +		cancel_work_sync(&msg_queue->core_work);
>   }
>   
>   static void vdec_msg_queue_core_work(struct work_struct *work)


