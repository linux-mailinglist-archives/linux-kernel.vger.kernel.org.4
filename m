Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29564DA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLOL0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLOL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:26:20 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49E2B602
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:26:06 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-144b21f5e5fso20503139fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzBu09mDNq5od2QDqdPk1lAEX0XPtU9krf/GwA+RPJY=;
        b=v2m4kc2iGSRRt6ZRKPEIUlectgou5queRkEGL01awAIbkgCEaqvbvAxEkYhItFmPMp
         7eUXUQqZ2/L5JqxNrVK6z86qAEprHOgQhs56OT5JKnYK5gQulYFG0lp/Ek0cGB6e+kC6
         bXklXxjbxepwEnHaaqRFpMae+jxdL5DLKMZFJjvUw9xYZx7ABdoN9tHd3Mpu4GCJ9vSA
         tkM2aVe36dNnW5kBz97UxFuNz39KRiUqP2z+uAMHoXJSSl1G/hNXaCK2GEsIMgcJAFRY
         3tNKrknSWLnQRqkVnY9VhxKHnde18lnjyXkg+7abkEe0hGYRoKENtb7C486z78pV3/+7
         IPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzBu09mDNq5od2QDqdPk1lAEX0XPtU9krf/GwA+RPJY=;
        b=J7BuHoS8z1gzT4q3hV2+aunQnANdcWrsCfkbZlXTGoGXRj+cVHfsVWv9K/C114PBPv
         INRTeSgBKxQU2kMwbFkrpYjR761FeLLyy7RzJJ6Iy4bmwKJwP6Vf6U5pGmLufw4sNACb
         6AsEkzo/7PQoyiMdNo86hOrIC2h8yPiFWVSDkSy6vuA9REEGqc827AeE9GVhYQ0ll1cr
         +YGb/RXkCXObKJet6G9fy1wZQ/J6pgnx6igQViCKyQc+Ebxgi1REqe69OZfy3AbKTpk2
         5mdqjLeOjt72qlSuVuyWL0ue2Nz2joQMpSHXBjZwg4tN/7Tpue19jYyCbRLnwYf5UBiW
         nl1A==
X-Gm-Message-State: AFqh2kqTJN+ZclKLH8TfdD4eG0hYdeh+CQYpw8CwMmSGG0W9j2ZMljzI
        sXjiIE1rcshhYOHWQbYoXCcEEQSEErE9AmDFpn28xg==
X-Google-Smtp-Source: AA0mqf45eNjcBDqYyjIy3WCWWUrekvaEjIMVCLmAAlhDuVxeAdYM+pNqRVSpZsJGArT7JNtrZpNNeiQ8znox2+ggghU=
X-Received: by 2002:a05:6870:9e4c:b0:13c:33d0:22e2 with SMTP id
 pt12-20020a0568709e4c00b0013c33d022e2mr594661oab.14.1671103565499; Thu, 15
 Dec 2022 03:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214130122.12911-1-paul@crapouillou.net>
In-Reply-To: <20221214130122.12911-1-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 12:25:54 +0100
Message-ID: <CAG3jFysF_i0ycn8AADJsq6+SOpwwP0-CTp04gXuD6sV=FYzE=w@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm: bridge: it66121: Move VID/PID to new
 it66121_chip_info structure
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 14:01, Paul Cercueil <paul@crapouillou.net> wrote:
>
> This will make it easier later to introduce support for new chips in
> this driver.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 7972003d4776..43b027b85b8e 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -35,10 +35,6 @@
>  #define IT66121_DEVICE_ID0_REG                 0x02
>  #define IT66121_DEVICE_ID1_REG                 0x03
>
> -#define IT66121_VENDOR_ID0                     0x54
> -#define IT66121_VENDOR_ID1                     0x49
> -#define IT66121_DEVICE_ID0                     0x12
> -#define IT66121_DEVICE_ID1                     0x06
>  #define IT66121_REVISION_MASK                  GENMASK(7, 4)
>  #define IT66121_DEVICE_ID1_MASK                        GENMASK(3, 0)
>
> @@ -286,13 +282,12 @@
>  #define IT66121_AUD_SWL_16BIT                  0x2
>  #define IT66121_AUD_SWL_NOT_INDICATED          0x0
>
> -#define IT66121_VENDOR_ID0                     0x54
> -#define IT66121_VENDOR_ID1                     0x49
> -#define IT66121_DEVICE_ID0                     0x12
> -#define IT66121_DEVICE_ID1                     0x06
> -#define IT66121_DEVICE_MASK                    0x0F
>  #define IT66121_AFE_CLK_HIGH                   80000 /* Khz */
>
> +struct it66121_chip_info {
> +       u16 vid, pid;
> +};
> +
>  struct it66121_ctx {
>         struct regmap *regmap;
>         struct drm_bridge bridge;
> @@ -311,6 +306,7 @@ struct it66121_ctx {
>                 u8 swl;
>                 bool auto_cts;
>         } audio;
> +       const struct it66121_chip_info *info;
>  };
>
>  static const struct regmap_range_cfg it66121_regmap_banks[] = {
> @@ -1451,6 +1447,7 @@ static const char * const it66121_supplies[] = {
>
>  static int it66121_probe(struct i2c_client *client)
>  {
> +       const struct i2c_device_id *id = i2c_client_get_device_id(client);
>         u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
>         struct device_node *ep;
>         int ret;
> @@ -1472,6 +1469,7 @@ static int it66121_probe(struct i2c_client *client)
>
>         ctx->dev = dev;
>         ctx->client = client;
> +       ctx->info = (const struct it66121_chip_info *) id->driver_data;
>
>         of_property_read_u32(ep, "bus-width", &ctx->bus_width);
>         of_node_put(ep);
> @@ -1523,8 +1521,8 @@ static int it66121_probe(struct i2c_client *client)
>         revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
>         device_ids[1] &= IT66121_DEVICE_ID1_MASK;
>
> -       if (vendor_ids[0] != IT66121_VENDOR_ID0 || vendor_ids[1] != IT66121_VENDOR_ID1 ||
> -           device_ids[0] != IT66121_DEVICE_ID0 || device_ids[1] != IT66121_DEVICE_ID1) {
> +       if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
> +           (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
>                 return -ENODEV;
>         }
>
> @@ -1563,8 +1561,13 @@ static const struct of_device_id it66121_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, it66121_dt_match);
>
> +static const struct it66121_chip_info it66121_chip_info = {
> +       .vid = 0x4954,
> +       .pid = 0x0612,
> +};
> +
>  static const struct i2c_device_id it66121_id[] = {
> -       { "it66121", 0 },
> +       { "it66121", (kernel_ulong_t) &it66121_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, it66121_id);
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
