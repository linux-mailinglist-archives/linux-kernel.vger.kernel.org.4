Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903647158E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjE3Ill (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE3IlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:41:22 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F4194;
        Tue, 30 May 2023 01:41:21 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8B8B820311;
        Tue, 30 May 2023 10:41:18 +0200 (CEST)
Date:   Tue, 30 May 2023 10:41:17 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony
 Xperia XZ3
Message-ID: <63qt5jmdi5qg7tvhbb7vk75kz53wmygc7iubwprfhcc3hvgwuv@ildrzq32ese3>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-30 09:24:24, Neil Armstrong wrote:
> Hi Marijn, Dmitry, Caleb, Jessica,
> 
> On 29/05/2023 23:11, Marijn Suijten wrote:
> > On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
> > <snip>
> >>> +	if (ctx->dsi->dsc) {
> >>
> >> dsi->dsc is always set, thus this condition can be dropped.
> > 
> > I want to leave room for possibly running the panel without DSC (at a
> > lower resolution/refresh rate, or at higher power consumption if there
> > is enough BW) by not assigning the pointer, if we get access to panel
> > documentation: probably one of the magic commands sent in this driver
> > controls it but we don't know which.
> 
> I'd like to investigate if DSC should perhaps only be enabled if we
> run non certain platforms/socs ?
> 
> I mean, we don't know if the controller supports DSC and those particular
> DSC parameters so we should probably start adding something like :
> 
> static drm_dsc_config dsc_params_qcom = {}
> 
> static const struct of_device_id panel_of_dsc_params[] = {
> 	{ .compatible = "qcom,sm8150", , .data = &dsc_params_qcom },
> 	{ .compatible = "qcom,sm8250", , .data = &dsc_params_qcom },
> 	{ .compatible = "qcom,sm8350", , .data = &dsc_params_qcom },
> 	{ .compatible = "qcom,sm8450", , .data = &dsc_params_qcom },
> };

I'd absolutely hate hardcoding a list of compatible SoC names in a panel
driver.  For one these lists will fall out of date really soon even if
we store this list in a generic place: even the current DPU catalog and
new entries floating on the lists weren't faithfully representing DSC
capabilities (but that's all being / been fixed now).

What's more, most of these panel drivers are "hardcoded" for a specific
(smartphone) device (and SoC...) since we don't (usually) have the
DrIC/panel name nor documentation to make the commands generic enough.
I don't think we should be specific on that end, while being generic on
the DSC side.

That does mean I'll remove the if (dsc) here, as Dmitry noted most of
this driver expects/requires it is enabled.

> ...
> static int sony_akatsuki_lgd_probe(struct mipi_dsi_device *dsi)
> ...
> 	const struct of_device_id *match;
> 
> ...
> 	match = of_match_node(panel_of_dsc_params, of_root);
> 	if (match && match->data) {
> 		dsi->dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);
> 		memcpy(dsi->dsc, match->data, sizeof(*dsc));
> 	} else {
> 		dev_warn(&dsi->dev, "DSI controller is not marked as supporting DSC\n");
> 	}
> ...
> }
> 
> and probably bail out if it's a DSC only panel.
> 
> We could alternatively match on the DSI controller's dsi->host->dev instead of the SoC root compatible.

I'd much rather have the DSI host/controller state whether it is capable
of DSC (likely allowing us to expose different modes for panels that
support toggling DSC), but for starters also validate (in DPU?) that the
pointer is NULL when the hardware does not support it (but maybe that
already happens implicitly somewhere in e.g.
dpu_encoder_virt_atomic_mode_set when finding the DSC blocks).

- Marijn
