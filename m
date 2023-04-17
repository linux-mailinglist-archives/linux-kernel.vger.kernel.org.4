Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F466E41DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjDQH74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjDQH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81046AF;
        Mon, 17 Apr 2023 00:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 255A560303;
        Mon, 17 Apr 2023 07:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B03FC433EF;
        Mon, 17 Apr 2023 07:58:55 +0000 (UTC)
Message-ID: <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
Date:   Mon, 17 Apr 2023 09:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: au0828: Move a variable assignment behind
 condition checks in au0828_isoc_copy()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 21:10, Markus Elfring wrote:
> Date: Fri, 14 Apr 2023 21:00:45 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “au0828_isoc_copy”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable “vbi_dma_q” behind some condition checks.

Just drop these lines instead:

        if (!dev)
                return 0;

If you analyze the code then you'll see that dev is never NULL.

> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 7f8eacd2162a39ca7fc1240883118a786f147ccb ("V4L/DVB: Add closed captioning support for the HVR-950q")

This doesn't actually fix anything since nothing was wrong. Drop the
Fixes tag. Same for all the other patches.

Regards,

	Hans

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/media/usb/au0828/au0828-video.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
> index fd9fc43d47e0..c0c5f2ed65e3 100644
> --- a/drivers/media/usb/au0828/au0828-video.c
> +++ b/drivers/media/usb/au0828/au0828-video.c
> @@ -491,7 +491,7 @@ static inline int au0828_isoc_copy(struct au0828_dev *dev, struct urb *urb)
>  	struct au0828_buffer    *buf;
>  	struct au0828_buffer    *vbi_buf;
>  	struct au0828_dmaqueue  *dma_q = urb->context;
> -	struct au0828_dmaqueue  *vbi_dma_q = &dev->vbiq;
> +	struct au0828_dmaqueue  *vbi_dma_q;
>  	unsigned char *outp = NULL;
>  	unsigned char *vbioutp = NULL;
>  	int i, len = 0, rc = 1;
> @@ -521,6 +521,8 @@ static inline int au0828_isoc_copy(struct au0828_dev *dev, struct urb *urb)
>  	if (vbi_buf != NULL)
>  		vbioutp = vb2_plane_vaddr(&vbi_buf->vb.vb2_buf, 0);
> 
> +	vbi_dma_q = &dev->vbiq;
> +
>  	for (i = 0; i < urb->number_of_packets; i++) {
>  		int status = urb->iso_frame_desc[i].status;
> 
> --
> 2.40.0
> 

