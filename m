Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A36A35CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0AEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0AEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:04:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F020B44D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 16:04:34 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BF3866020AF;
        Mon, 27 Feb 2023 00:04:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677456273;
        bh=+8W31VeoOfS5KCIykRP7XjN5krIxqbI1vA8JOGyKkHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dm8LY/SHievdfP/cJSC6IWrO5UXPQiUIobNosRTLGq+DfkAGG2x0FcpUnsGPeuODB
         VFuNrA4bgf7fSKv/1ws3xWL4WS567ILYvDuzXJrhpsBVpWk2xiej+f1jgRU729xLfw
         +9BIyVIC0jd0++oqRmK4gnUhiRM73YlGa69O4bygAriFpXQ3h2gct2yCVYwqaiY7Or
         1VrVslPrbEPq9H/beYY4hvVc7OSY3cAZZ8b+kViTuI8KNBHVaNwx4qKQ285LJhtN6j
         +7mwKQaw6SR2gkdeOTW4P1esVaSPSG5iDnVOhE98/5CKidjeaN99dNvNnt6IbBSb63
         vmgp03r0ZkbCw==
Message-ID: <257f88ec-6bfc-0e91-610a-41a1af8e1180@collabora.com>
Date:   Mon, 27 Feb 2023 03:04:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH linux-next] drm/virtio: use strscpy() to instead of
 strncpy()
Content-Language: en-US
To:     yang.yang29@zte.com.cn, airlied@redhat.com
Cc:     xu.panda@zte.com.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, kraxel@redhat.com,
        gurchetansingh@chromium.org
References: <202212070913161959936@zte.com.cn>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <202212070913161959936@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 04:13, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9ff8660b50ad..7d95bc74b307 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -916,8 +916,7 @@ void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
>  	cmd_p->hdr.ctx_id = cpu_to_le32(id);
>  	cmd_p->nlen = cpu_to_le32(nlen);
>  	cmd_p->context_init = cpu_to_le32(context_init);
> -	strncpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name) - 1);
> -	cmd_p->debug_name[sizeof(cmd_p->debug_name) - 1] = 0;
> +	strscpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name));
>  	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>  }
> 

Applied to misc-next

-- 
Best regards,
Dmitry

