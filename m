Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C16E03F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDMCHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:07:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09932708;
        Wed, 12 Apr 2023 19:07:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so5742532pjb.2;
        Wed, 12 Apr 2023 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681351642; x=1683943642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEy739Q6DzyPTPI+EMOV/uu+jSkhw/XJ8H+BPcHU6Bs=;
        b=YABSAzecJklqy+eOR5eewLTULsC0NynzfDE9O0fbd42ALSZM+w+gf4McrSErgoyYaK
         Fsnz+P7cNCAKB6FN4O1oatl3SbLvcJW0n4yEcX3KBvmQAOJUyEFssVz+xa4BXuzRBUt6
         zzcSd+nq2FL3bbLR5+tgRXfrbeOgRhnzscVlurEfwPgIU9CXuREmCFZhvruyOhfvWaO+
         VX/NvzU2baoHrG0KY9uHtl7JRkcuuCXJrc6L7bXh8k+4wTki4//kNKgofyHJS5d8aKPC
         lBVmNG5TkTc6pN2SCood8G6R/Q5jxVOEcf+3HY1QpIkQeGZE8e164CmoH9SudD2Dlh7c
         mMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681351642; x=1683943642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEy739Q6DzyPTPI+EMOV/uu+jSkhw/XJ8H+BPcHU6Bs=;
        b=HPlsTzACCEpaVa60E+B7IYkizFgJz8bR3f5FnCA3FTegJdlo+7fmr+PwbGjbZU2qU/
         QK7WbePhurErSk3f/L/JIAabJ+dN/UQT+9CmLKmDKYK86L1y9JvxUx54mMLq5w/pjWvw
         NFp23A/+jCyBlmppHVeckIOEzV2H0QhjjJW1fJk1k0oT7WM+4xxJSfBTDeNCGZ6D0gRW
         IA+IhVr980gzLWAkYlV5qZYkgBRrstw4eymUXoeZS2lYdRy2+trF0jNwIjzJ6QNzxvRv
         AERPz/WNzNxt8c3LqhU2Hgtd5ES1boKA/D3Siwkd43HBNTMTVyoizBR1RT9XCjzRgaA9
         6WGg==
X-Gm-Message-State: AAQBX9dM+9lTFmLxg9LzpeqBOYgPeb7VMa0ToqdnF0qY0g6rQTKPYlLw
        zxrmpDUITvNacc1UngbW1P0=
X-Google-Smtp-Source: AKy350bRu/BzSqanT7tkZ7WazrwfBESoI0yWMZiJHdyKwePaMYz7NCCNIjcPK2NWOPsAetiGcY7GXQ==
X-Received: by 2002:a17:90a:b005:b0:23d:16d6:2f05 with SMTP id x5-20020a17090ab00500b0023d16d62f05mr212424pjq.22.1681351642301;
        Wed, 12 Apr 2023 19:07:22 -0700 (PDT)
Received: from Gentoo (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902bd8f00b001a67759f9f8sm239125pls.106.2023.04.12.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 19:07:21 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:07:15 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/panel: nt36523: Get orientation from OF
Message-ID: <ZDdj04+RiBcOP9z0@Gentoo>
References: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
 <20230412-topic-lenovopanel-v1-4-00b25df46824@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-topic-lenovopanel-v1-4-00b25df46824@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:46:01PM +0200, Konrad Dybcio wrote:
> Some bright vendors mount their display panels upside down. Add the
> required pieces to allow for accounting for that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index 3c81ec014eef..db4b4af13ec1 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -31,6 +31,7 @@ struct panel_info {
>  	struct drm_panel panel;
>  	struct mipi_dsi_device *dsi[2];
>  	const struct panel_desc *desc;
> +	enum drm_panel_orientation orientation;
>  
>  	struct gpio_desc *reset_gpio;
>  	struct backlight_device *backlight;
> @@ -674,11 +675,19 @@ static int nt36523_get_modes(struct drm_panel *panel,
>  	return pinfo->desc->num_modes;
>  }
>  
> +static enum drm_panel_orientation nt36523_get_orientation(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo = to_panel_info(panel);
> +
> +	return pinfo->orientation;
> +}
> +
>  static const struct drm_panel_funcs nt36523_panel_funcs = {
>  	.disable = nt36523_disable,
>  	.prepare = nt36523_prepare,
>  	.unprepare = nt36523_unprepare,
>  	.get_modes = nt36523_get_modes,
> +	.get_orientation = nt36523_get_orientation,
>  };
>  
>  static int nt36523_bl_update_status(struct backlight_device *bl)
> @@ -784,6 +793,12 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>  	mipi_dsi_set_drvdata(dsi, pinfo);
>  	drm_panel_init(&pinfo->panel, dev, &nt36523_panel_funcs, DRM_MODE_CONNECTOR_DSI);
>  
> +	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
> +	if (ret < 0) {
> +		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
> +		return ret;
> +	}
> +
>  	if (pinfo->desc->has_dcs_backlight) {
>  		pinfo->panel.backlight = nt36523_create_backlight(dsi);
>  		if (IS_ERR(pinfo->panel.backlight))
> 
> -- 
> 2.40.0
> 
