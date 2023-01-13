Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3266A244
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjAMSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjAMSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:42:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8231C403;
        Fri, 13 Jan 2023 10:42:00 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q9so15576018pgq.5;
        Fri, 13 Jan 2023 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QD7usKGVJK1l562LQUacW18IzdYjd/Cqja8WtRrdzI=;
        b=POsV12pAKGVvshfIo3TPMcxPlnkwnuIQte/Cz9GdueYMqOBXWgqDIr6mEnz9uvNLNi
         Mq9bBjNNKO3d5MM7vMW+SaT1UXgQF6cT7o/uNOFggKQRElaKtCPVH2p1u1g/CzuEmZiy
         hXn0oneKPbXd0x6GAJL6yO+dUdWjD3QJN0jhX6rEIvLH6/p4gd3Z2iJK4dTgjtCXlmjl
         lriACzelr4lU6PyVhOgM+Ca6pTSeF4p4gGp+xiigfQ1ZOe7CBX3jzJWa8T3gcq1Fsi8m
         Q5Wsxk5suUABb11RBV4MVl5RyfUGz9FScS1ZcbchOpQzB54ANAjHoViwiVyU53rqFo3g
         OTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QD7usKGVJK1l562LQUacW18IzdYjd/Cqja8WtRrdzI=;
        b=I8uEEzYMPvJIWKQ++4wB6c6s9o+wHFyKcNSB7w8LiEHQwvc1ORmZC/eDVAUchdHL6Q
         lAp5K2yBFF/wwENpabWxKjOnjgBWS79n5sk5XU5RDqWEtZfDnBQioF2iH1PcwUQNQY+3
         yDGDTOeOvRaHR9PTHHzmlOnPIG4VEgsXDTXFYED3Eb5+msxhx0PWV5OqxjpPZLP1p7ko
         Bd23Pe2k4PU9Sj25Vv26YmnvUYQjeAJ1tNdCPmRTQvPqu6gzCp07TltB4y43FNFH7xHw
         JeKVHLx4T9MFk/fhvNhN8BLKTu/ttwkC2GrMTgFSiBm2wEcxEl2vF5Ns88G7vhzWZulT
         N+xA==
X-Gm-Message-State: AFqh2kpDQfZ6UuaUio+E9QDTZ1dt3yIyloJzgMYnnqWK9+xT95VaMzbU
        g2j3W88+JjHaGe0ZHsOml96LXoG/S8gVjwufF+/1nAni
X-Google-Smtp-Source: AMrXdXsLRfpgr47HkG3dQHLOGmtQ+B0CitwU/YNWd06vHIaVRoliCeJ9GaAw0DL/DBkZhBJbUknIlle6ps6x0IOph90=
X-Received: by 2002:a63:4d04:0:b0:46f:c183:2437 with SMTP id
 a4-20020a634d04000000b0046fc1832437mr4813185pgb.613.1673635318972; Fri, 13
 Jan 2023 10:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20221220120754.2040428-1-aford173@gmail.com> <20221220120754.2040428-2-aford173@gmail.com>
In-Reply-To: <20221220120754.2040428-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 13 Jan 2023 12:41:47 -0600
Message-ID: <CAHCN7xLsm32SufnHb3pozmjKbT6KTETTRR4msdiYBxDn_LKHRw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] media: i2c: imx219: Support four-lane operation
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 6:08 AM Adam Ford <aford173@gmail.com> wrote:
>
> The imx219 camera is capable of either two-lane or four-lane
> operation.  When operating in four-lane, both the pixel rate and
> link frequency change. Regardless of the mode, however, both
> frequencies remain fixed.
>
> Helper functions are needed to read and set pixel and link frequencies
> which also reduces the number of fixed registers in the table of modes.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Gentle nudge on this.

> ---
> V4:  Restore check for nr_of_link_frequencies and update commit message
> V3:  Keep the helper function doing the link and lane parsing to
>      keep th probe function small.
>
> V2:  Replace if-else statements with ternary operator
>      Fix 4-lane Link Rate.
>      Fix checking the link rate so only the link rate for
>      the given number of lanes is permitted.
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 7f44d62047b6..b5fa4986470a 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -42,10 +42,16 @@
>  /* External clock frequency is 24.0M */
>  #define IMX219_XCLK_FREQ               24000000
>
> -/* Pixel rate is fixed at 182.4M for all the modes */
> +/* Pixel rate is fixed for all the modes */
>  #define IMX219_PIXEL_RATE              182400000
> +#define IMX219_PIXEL_RATE_4LANE                280800000
>
>  #define IMX219_DEFAULT_LINK_FREQ       456000000
> +#define IMX219_DEFAULT_LINK_FREQ_4LANE 363000000
> +
> +#define IMX219_REG_CSI_LANE_MODE       0x0114
> +#define IMX219_CSI_2_LANE_MODE         0x01
> +#define IMX219_CSI_4_LANE_MODE         0x03
>
>  /* V_TIMING internal */
>  #define IMX219_REG_VTS                 0x0160
> @@ -299,6 +305,10 @@ static const s64 imx219_link_freq_menu[] = {
>         IMX219_DEFAULT_LINK_FREQ,
>  };
>
> +static const s64 imx219_link_freq_4lane_menu[] = {
> +       IMX219_DEFAULT_LINK_FREQ_4LANE,
> +};
> +
>  static const char * const imx219_test_pattern_menu[] = {
>         "Disabled",
>         "Color Bars",
> @@ -474,6 +484,9 @@ struct imx219 {
>
>         /* Streaming on/off */
>         bool streaming;
> +
> +       /* Two or Four lanes */
> +       u8 lanes;
>  };
>
>  static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
> @@ -936,6 +949,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>         return -EINVAL;
>  }
>
> +static int imx219_configure_lanes(struct imx219 *imx219)
> +{
> +       return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> +                               IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
> +                               IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
> +};
> +
>  static int imx219_start_streaming(struct imx219 *imx219)
>  {
>         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> @@ -953,6 +973,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>                 goto err_rpm_put;
>         }
>
> +       /* Configure two or four Lane mode */
> +       ret = imx219_configure_lanes(imx219);
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
>         /* Apply default values of current mode */
>         reg_list = &imx219->mode->reg_list;
>         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> @@ -1184,6 +1211,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
>         .open = imx219_open,
>  };
>
> +static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
> +{
> +       return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
> +}
> +
>  /* Initialize control handlers */
>  static int imx219_init_controls(struct imx219 *imx219)
>  {
> @@ -1205,15 +1237,16 @@ static int imx219_init_controls(struct imx219 *imx219)
>         /* By default, PIXEL_RATE is read only */
>         imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
>                                                V4L2_CID_PIXEL_RATE,
> -                                              IMX219_PIXEL_RATE,
> -                                              IMX219_PIXEL_RATE, 1,
> -                                              IMX219_PIXEL_RATE);
> +                                              imx219_get_pixel_rate(imx219),
> +                                              imx219_get_pixel_rate(imx219), 1,
> +                                              imx219_get_pixel_rate(imx219));
>
>         imx219->link_freq =
>                 v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
>                                        V4L2_CID_LINK_FREQ,
>                                        ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
> -                                      imx219_link_freq_menu);
> +                                      (imx219->lanes == 2) ? imx219_link_freq_menu :
> +                                      imx219_link_freq_4lane_menu);
>         if (imx219->link_freq)
>                 imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>
> @@ -1308,7 +1341,7 @@ static void imx219_free_controls(struct imx219 *imx219)
>         mutex_destroy(&imx219->mutex);
>  }
>
> -static int imx219_check_hwcfg(struct device *dev)
> +static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
>  {
>         struct fwnode_handle *endpoint;
>         struct v4l2_fwnode_endpoint ep_cfg = {
> @@ -1328,10 +1361,12 @@ static int imx219_check_hwcfg(struct device *dev)
>         }
>
>         /* Check the number of MIPI CSI2 data lanes */
> -       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> -               dev_err(dev, "only 2 data lanes are currently supported\n");
> +       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2 &&
> +           ep_cfg.bus.mipi_csi2.num_data_lanes != 4) {
> +               dev_err(dev, "only 2 or 4 data lanes are currently supported\n");
>                 goto error_out;
>         }
> +       imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
>
>         /* Check the link frequency set in device tree */
>         if (!ep_cfg.nr_of_link_frequencies) {
> @@ -1340,7 +1375,8 @@ static int imx219_check_hwcfg(struct device *dev)
>         }
>
>         if (ep_cfg.nr_of_link_frequencies != 1 ||
> -           ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
> +          (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
> +           IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE))) {
>                 dev_err(dev, "Link frequency not supported: %lld\n",
>                         ep_cfg.link_frequencies[0]);
>                 goto error_out;
> @@ -1368,7 +1404,7 @@ static int imx219_probe(struct i2c_client *client)
>         v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
>
>         /* Check the hardware configuration in device tree */
> -       if (imx219_check_hwcfg(dev))
> +       if (imx219_check_hwcfg(dev, imx219))
>                 return -EINVAL;
>
>         /* Get system clock (xclk) */
> --
> 2.34.1
>
