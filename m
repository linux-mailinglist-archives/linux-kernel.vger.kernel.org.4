Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34546C93BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCZKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCZKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 06:22:38 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483B86BD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:22:37 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E006A240262
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1679826155; bh=gJR9k90hH+sr13a0GUurygJMhm/eT12uSIgworv0JdM=;
        h=Subject:From:To:Cc:Date:From;
        b=Wb7mJK0uVG6TGC9VM/KQ4ajRKSRGkS7t/laP+v9Huz2QUNvhbx38ZcWpJwrpvJjV/
         hbPKwkC0ypaHZPMHHYq24z+Z8177adPv3HcmdMEixVvQLIPMW8W/OrlwZ9TSoqiz4M
         FI4orJ7F7uVcNgJTxExk8WsYbel0Zh+Ic93kzUJ8sGEJzOOtdRJ0Sk8jw5DVWB0maZ
         68vehUykM3MOgck29lZUI7H4qLVC+s9qUxSqiuTvTNFe/yde6R3Sej3RIQuczkdDjX
         V2+4R6WLl9/3t1htPkeSPvKRmFkxxpPTeqwZqy17xDUzg/4N4diBf6m6EFkc0A1Wm9
         s0Hd4oOGisOBA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PksT66nXVz9rxN;
        Sun, 26 Mar 2023 12:22:34 +0200 (CEST)
Message-ID: <b18c05d52b11c883371ad4a7f18ddc26bad244b8.camel@posteo.de>
Subject: Re: [PATCH v2] media: hi846: Fix memleak in hi846_init_controls()
From:   Martin Kepplinger <martink@posteo.de>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Mar 2023 10:22:34 +0000
In-Reply-To: <20230326092712.139791-1-harperchen1110@gmail.com>
References: <20230326092712.139791-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 26.03.2023 um 09:27 +0000 schrieb Wei Chen:
> hi846_init_controls doesn't clean the allocated ctrl_hdlr
> in case there is a failure, which causes memleak. Add
> v4l2_ctrl_handler_free to free the resource properly.
> 
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>


Reviewed-by: Martin Kepplinger <martin.kepplinger@puri.sm>

thanks,

                        martin

> ---
> Changes in v2:
>  - move v4l2_ctrl_handler_free to error tag
>  - handle memleak in other failure positions
> 
>  drivers/media/i2c/hi846.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index 7c61873b7198..f86997a261f5 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -1472,21 +1472,26 @@ static int hi846_init_controls(struct hi846
> *hi846)
>         if (ctrl_hdlr->error) {
>                 dev_err(&client->dev, "v4l ctrl handler error: %d\n",
>                         ctrl_hdlr->error);
> -               return ctrl_hdlr->error;
> +               ret = ctrl_hdlr->error;
> +               goto error;
>         }
>  
>         ret = v4l2_fwnode_device_parse(&client->dev, &props);
>         if (ret)
> -               return ret;
> +               goto error;
>  
>         ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr,
> &hi846_ctrl_ops,
>                                               &props);
>         if (ret)
> -               return ret;
> +               goto error;
>  
>         hi846->sd.ctrl_handler = ctrl_hdlr;
> 
>         return 0;
> +
> +error:
> +       v4l2_ctrl_handler_free(ctrl_hdlr);
> +       return ret;
>  }
>  
>  static int hi846_set_video_mode(struct hi846 *hi846, int fps)


