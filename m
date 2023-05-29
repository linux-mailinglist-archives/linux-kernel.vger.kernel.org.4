Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726607150DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjE2VL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2VLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:11:24 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F604C7;
        Mon, 29 May 2023 14:11:23 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 65D193EBA6;
        Mon, 29 May 2023 23:11:21 +0200 (CEST)
Date:   Mon, 29 May 2023 23:11:20 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony
 Xperia XZ3
Message-ID: <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
<snip>
> > +	if (ctx->dsi->dsc) {
> 
> dsi->dsc is always set, thus this condition can be dropped.

I want to leave room for possibly running the panel without DSC (at a
lower resolution/refresh rate, or at higher power consumption if there
is enough BW) by not assigning the pointer, if we get access to panel
documentation: probably one of the magic commands sent in this driver
controls it but we don't know which.

> > +		drm_dsc_pps_payload_pack(&pps, ctx->dsi->dsc);
> > +
> > +		ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> > +		if (ret < 0) {
> > +			dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> > +			goto fail;
> > +		}
> > +		ret = mipi_dsi_compression_mode(ctx->dsi, true);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to enable compression mode: %d\n", ret);
> > +			goto fail;
> > +		}
> > +
> > +		msleep(28);
> > +	}
> > +
> > +	ctx->prepared = true;
> > +	return 0;
> > +
> > +fail:
> > +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > +	regulator_disable(ctx->vddio);
> > +	return ret;
> > +}
<snip>
> > +	/* This panel only supports DSC; unconditionally enable it */

On that note I should perhaps reword this.

> > +	dsi->dsc = dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);
> 
> I think double assignments are frowned upon.

Ack.

> 
> > +	if (!dsc)
> > +		return -ENOMEM;
> > +
> > +	dsc->dsc_version_major = 1;
> > +	dsc->dsc_version_minor = 1;
> > +
> > +	dsc->slice_height = 32;
> > +	dsc->slice_count = 2;
> > +	// TODO: Get hdisplay from the mode
> 
> Would you like to fix the TODO?

I can't unless either migrating to drm_bridge (is that doable?) or
expand drm_panel.  That's a larger task, but I don't think this driver
is the right place to track that desire.  Should I drop the comment
entirely or reword it?

> > +	WARN_ON(1440 % dsc->slice_count);
> > +	dsc->slice_width = 1440 / dsc->slice_count;

<snip>

- Marijn
