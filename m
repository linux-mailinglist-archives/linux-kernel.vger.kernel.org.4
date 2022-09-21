Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8E5BF27B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiIUAx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIUAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:53:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23B79A78;
        Tue, 20 Sep 2022 17:53:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11D76415;
        Wed, 21 Sep 2022 02:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663721626;
        bh=NKIBgvf5EtOAYU3QLWV5VyxZpPJqOS7yx89s5sYlf5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blZQMaVfVNLDa8/2YPRtCI2NTuYDjtw7wWUSk53LSLafVL+bdwF3IKdvzsQCLxVjH
         YZwU+N+JJJFfjx5+t0j4vSnuQQoza3kRv3jW4u+4MKsV0eB1kxhs+5ZDlhhXilYBAp
         9RAsNZKa0rASQSZ4tNPsxPmk1zEVY4oxB1+aQN2w=
Date:   Wed, 21 Sep 2022 03:53:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 1/1] media: uvc: Handle cameras with invalid
 descriptors
Message-ID: <Yypgi6Jc9/tZLtIw@pendragon.ideasonboard.com>
References: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
 <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Sep 20, 2022 at 04:04:55PM +0200, Ricardo Ribalda wrote:
> If the source entity does not contain any pads, do not create a link.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> index 7c4d2f93d351..1f730cb72e58 100644
> --- a/drivers/media/usb/uvc/uvc_entity.c
> +++ b/drivers/media/usb/uvc/uvc_entity.c
> @@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
>  		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
>  		       ? (remote->vdev ? &remote->vdev->entity : NULL)
>  		       : &remote->subdev.entity;
> -		if (source == NULL)
> +		if (source == NULL || source->num_pads == 0)

source->num_pads and remote->num_pads should always be identical, but as
the next line uses remote->num_pads, wouldn't it be better to test that
variable ? If so, I'd move the test a file lines earlier, with the
remote == NULL test.

What do you think ? If you agree I can make that change when applying,
there's no need for a new version. Otherwise I'll keep the patch as-is.

>  			continue;
>  
>  		remote_pad = remote->num_pads - 1;
> 

-- 
Regards,

Laurent Pinchart
