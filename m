Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AAE7420DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF2HTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjF2HTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7502116;
        Thu, 29 Jun 2023 00:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76F6614D7;
        Thu, 29 Jun 2023 07:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595EAC433C8;
        Thu, 29 Jun 2023 07:19:00 +0000 (UTC)
Message-ID: <63bd261c-f05c-0530-6271-a4d82ccf7797@xs4all.nl>
Date:   Thu, 29 Jun 2023 09:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] OOB read and write in mdp_prepare_buffer
Content-Language: en-US
To:     yqsun1997@gmail.com, mchehab@kernel.org
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
References: <20230627082731.1769620-1-yqsun1997@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230627082731.1769620-1-yqsun1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 6/27/23 10:27, yqsun1997@gmail.com wrote:
> From: yqsun1997 <yqsun1997@gmail.com>
> 
> Because format in struct img_image_buffer max index is IMG_MAX_PLANES ==3,
> The num_planes max index is 8.so will be OOB like in mdp_prepare_buffer.
> 
> static void mdp_prepare_buffer(struct img_image_buffer *b,
>                                 struct mdp_frame *frame, struct vb2_buffer *vb)
> {
>          struct v4l2_pix_format_mplane *pix_mp = &frame->format.fmt.pix_mp;
>          unsigned int i;
> 
>          b->format.colorformat = frame->mdp_fmt->mdp_color;
>          b->format.ycbcr_prof = frame->ycbcr_prof;
>          for (i = 0; i < pix_mp->num_planes; ++i) {

Unless there is a bug in the driver, pix_mp->num_planes will never 
exceed 3. Userspace might certainly pass more than 3 planes, but only 
the first pix_mp->num_planes should ever be used.

If pix_mp->num_planes can ever be more than 3, then that would be the 
real bug.

Regards,

	Hans

>                  u32 stride = mdp_fmt_get_stride(frame->mdp_fmt,
>                          pix_mp->plane_fmt[i].bytesperline, i);
> 
>                  b->format.plane_fmt[i].stride = stride;  //oob
>                  ......
> 
> Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> ---
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> index ae0396806..e2e991a34 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> @@ -11,7 +11,7 @@
>   
>   #define IMG_MAX_HW_INPUTS	3
>   #define IMG_MAX_HW_OUTPUTS	4
> -#define IMG_MAX_PLANES		3
> +#define IMG_MAX_PLANES		8
>   #define IMG_MAX_COMPONENTS	20
>   
>   struct img_crop {
