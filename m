Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81776C9328
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjCZIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjCZIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:50:54 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8C83D9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:50:52 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D2BD024011F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1679820650; bh=RUgrxrDMePU7tGsaPfOz/SOu1phOc9qsDA9vA2peIfs=;
        h=Subject:From:To:Cc:Date:From;
        b=Cc0E7yQsg9lL/1Gp84Q3TbqSpBGrspem0P5h2foTDbmc76OPvpbySV+PNrTfoz3Yt
         53uvsueAF7vWlC1Tvwf/ZIL302y+ZYo1nv6NPPQxugbn7a4OqXd3klkGgdDvW4uA9Y
         aHtVFN3i8yLvjK3X7FS/4A7t4sIm/l6QQytlCkrsesAkOEUOKGGvQzkm34CAhNwa2R
         x7QVZ4F+ZRo40vv1xuH1K6FZDQyOB4H1pmPz9qk7DCU07s149MhIs/JjtdYvYfmrQU
         1YVPlI68tiTuF0VM2wRtPsdedUnC91rv1l5I/ZntcRAcy7oUUyexQ/wwPv0p2t/ZXe
         uq9zQvDeQZFQA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PkqRG06pQz9rxD;
        Sun, 26 Mar 2023 10:50:49 +0200 (CEST)
Message-ID: <4dcd261e56cf54eb409b6851128b63c5f7a2efcf.camel@posteo.de>
Subject: Re: [PATCH] media: hi846: Fix memleak in hi846_init_controls()
From:   Martin Kepplinger <martink@posteo.de>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Mar 2023 08:50:49 +0000
In-Reply-To: <20230324172427.3416342-1-harperchen1110@gmail.com>
References: <20230324172427.3416342-1-harperchen1110@gmail.com>
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

Am Freitag, dem 24.03.2023 um 17:24 +0000 schrieb Wei Chen:
> hi846_init_controls doesn't clean the allocated ctrl_hdlr
> in case there is a failure, which causes memleak. Add
> v4l2_ctrl_handler_free to free the resource properly.
> 
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> ---
>  drivers/media/i2c/hi846.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index 7c61873b7198..c45a6511d2c1 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -1472,6 +1472,7 @@ static int hi846_init_controls(struct hi846
> *hi846)
>         if (ctrl_hdlr->error) {
>                 dev_err(&client->dev, "v4l ctrl handler error: %d\n",
>                         ctrl_hdlr->error);
> +               v4l2_ctrl_handler_free(ctrl_hdlr);
>                 return ctrl_hdlr->error;
>         }
>  

hi Wei, thanks for the patch. It looks like I forgot that indeed, but
to me it looks like the subsequent error paths of
v4l2_fwnode_device_parse() and v4l2_ctrl_new_fwnode_properties() would
leak the same thing.

And since we only assign it to the subdev's ctrl_handler in the success
case later, you could simply add an error label:


@@ -1663,21 +1663,26 @@ static int hi846_init_controls(struct hi846
*hi846)
        if (ctrl_hdlr->error) {
                dev_err(&client->dev, "v4l ctrl handler error: %d\n",
                        ctrl_hdlr->error);
-               return ctrl_hdlr->error;
+               ret = ctrl_hdlr->error;
+               goto error;
        }
 
        ret = v4l2_fwnode_device_parse(&client->dev, &props);
        if (ret)
-               return ret;
+               goto error;
 
        ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr,
&hi846_ctrl_ops,
                                              &props);
        if (ret)
-               return ret;
+               goto error;
 
        hi846->sd.ctrl_handler = ctrl_hdlr;
 
        return 0;
+
+error:
+       v4l2_ctrl_handler_free(ctrl_hdlr);
+       return ret;
 }
 

what do you think? thanks!

                              martin


