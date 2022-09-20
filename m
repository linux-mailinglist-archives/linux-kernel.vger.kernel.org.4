Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320405BE1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiITJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:28:33 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4ED6AA08
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:28:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 60586240101
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1663666110; bh=vHEP6vaM4hy2huTBhOW3ls1s8DRZuvLteUrEaol9UKs=;
        h=Subject:From:To:Cc:Date:From;
        b=SFW1NWbrvd0NIX9gO5dnfvdVVSQfYgnL05sqKzlHSWA0Ej99wDpZNBrzlfc06uzo1
         iLzzr4rYmTk9b7MKxT0R9RTRhFnPp1dcvRmON/86VxFx/Zug62L57n+a0JwWw6kXCf
         vorM0DTJnAvqM+uhY9pQwEuzTQBi5AR0byihMUqhe5Cfu4KPAya+/RNyZT4AGFcM1o
         Cm44C9TQkBnxkq38fWw2X/rNvfhkiDAGvrk9YoQLKkT6bzuB8nDgaFzqXoQIFphJQr
         HeV5nYdZ4HahwDa3pQZYHkxCzZ523A8DX3WaGfH8kC6943skEcuCAbzDZDFlXrP9OC
         rQ8fHDwOw8jPA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MWx7053TKz6tmV;
        Tue, 20 Sep 2022 11:28:28 +0200 (CEST)
Message-ID: <823a21b40a6ba6ccd022594c6bf1efaeb7a5a65d.camel@posteo.de>
Subject: Re: [PATCH] media: i2c: hi846: Fix memory leak in hi846_parse_dt()
From:   Martin Kepplinger <martink@posteo.de>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Sep 2022 09:28:28 +0000
In-Reply-To: <20220919021252.730729-1-rafaelmendsr@gmail.com>
References: <20220919021252.730729-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 18.09.2022 um 23:12 -0300 schrieb Rafael Mendonca:
> If any of the checks related to the supported link frequencies fail,
> then
> the V4L2 fwnode resources don't get released before returning, which
> leads
> to a memleak. Fix this by properly freeing the V4L2 fwnode data in a
> designated label.
> 
> Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846
> 8M pixel camera")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/media/i2c/hi846.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index ad35c3ff3611..254031503c72 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -2008,22 +2008,24 @@ static int hi846_parse_dt(struct hi846
> *hi846, struct device *dev)
>             bus_cfg.bus.mipi_csi2.num_data_lanes != 4) {
>                 dev_err(dev, "number of CSI2 data lanes %d is not
> supported",
>                         bus_cfg.bus.mipi_csi2.num_data_lanes);
> -               v4l2_fwnode_endpoint_free(&bus_cfg);
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto check_hwcfg_error;
>         }
>  
>         hi846->nr_lanes = bus_cfg.bus.mipi_csi2.num_data_lanes;
>  
>         if (!bus_cfg.nr_of_link_frequencies) {
>                 dev_err(dev, "link-frequency property not found in
> DT\n");
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto check_hwcfg_error;
>         }
>  
>         /* Check that link frequences for all the modes are in device
> tree */
>         fq = hi846_check_link_freqs(hi846, &bus_cfg);
>         if (fq) {
>                 dev_err(dev, "Link frequency of %lld is not
> supported\n", fq);
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto check_hwcfg_error;
>         }
>  
>         v4l2_fwnode_endpoint_free(&bus_cfg);
> @@ -2044,6 +2046,10 @@ static int hi846_parse_dt(struct hi846 *hi846,
> struct device *dev)
>         }
>  
>         return 0;
> +
> +check_hwcfg_error:
> +       v4l2_fwnode_endpoint_free(&bus_cfg);
> +       return ret;
>  }
>  
>  static int hi846_probe(struct i2c_client *client)

thank you very much for the patch. lgtm,

Reviewed-by: Martin Kepplinger <martink@posteo.de>

                  martin


