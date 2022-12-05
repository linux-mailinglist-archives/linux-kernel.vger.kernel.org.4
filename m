Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CB6439BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLEX6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLEX6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:58:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9510556
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:58:49 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so21047373lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doSWp/8FuNr+NEV3HjPTJkGGPY6r8PL0hvET2gbpcas=;
        b=Qerm5bC31eCO/u9ZcVP1OcqKBknqnslFPZd1KK3o1V2jy51sySmxFQBQZRAhfyjlr5
         0iF9IRsEbwty3qVO1wOSB1T87h54s4gx2dJ/E70LBpDUfxeBT2cSM76kwX5YzDpxthuy
         UnYbMgHX4IGFYzj1YAZQBQTpVChrQM5rc9K3429C+Jc0ZgfYBnYlDrz+7g2oiSPSXnK2
         QHFngs5DeLtpPzW019h10iP/OTn9g1CjjuZZRz4zuO33qvD06K6FnsWDYHMpslkxGyAW
         kCsR8n5tZFQ550S05KB+1mMT0htMsGwqyCLZkyGESXATDlNoAS3dU+8IhaYxSoZUBpq5
         Kgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doSWp/8FuNr+NEV3HjPTJkGGPY6r8PL0hvET2gbpcas=;
        b=lXDUeyWQX1+Hl+EeAZeKNWDnzIUOasJ2mvqxCnznTa5w+kMt+lcGIn2XmikCHpDi0T
         9BRVDuyiMkfIsM6dotu6xMwt/iR2AUzJBadzgW3LJBIXmLwdLrGKiUHhJQ3Xtbu5H/oy
         K4jkfZznovvgsWVBdhNT1cS+7oYBTEwdS9Moc8cH73cp9pa6UJSDiUpdxrqEYc3RUYpp
         sXuaCfABjz7qAGGVp1RsTAzgsUCh3qKfhnrs2hzbNu1lck9hghNt+6cj1DhlILXIOlBj
         hmZWdN7kk/jvSHLAZZwZ9fKpBx/4+FAQjKyxx9dGx9uA7/4vo56UeZtKlJeO9jWmkFVh
         0V4w==
X-Gm-Message-State: ANoB5pk3rP485xNH946JHbvibWQ4Jfh2CCh8YdIuU/KCaduu9Wn9yBNG
        OIbokPrlfnFbNGWaLw3h0E1/Bw==
X-Google-Smtp-Source: AA0mqf4iVNbwTKjN8IO9W2OPq2uXL5c4w2KkFC+MzkP3JxqHL9eP3wjuwJUr9hB+oLt1r/8eCoxMEA==
X-Received: by 2002:ac2:4e14:0:b0:4af:f5a0:8786 with SMTP id e20-20020ac24e14000000b004aff5a08786mr26291071lfr.265.1670284727601;
        Mon, 05 Dec 2022 15:58:47 -0800 (PST)
Received: from [127.0.0.1] ([188.170.72.128])
        by smtp.gmail.com with ESMTPSA id bp33-20020a05651215a100b004b5701b5337sm721215lfb.104.2022.12.05.15.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:58:47 -0800 (PST)
Date:   Tue, 06 Dec 2022 02:41:21 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
CC:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v9_4/5=5D_drm/msm/dp=3A_parser_link?= =?US-ASCII?Q?-frequencies_as_property_of_dp=5Fout_endpoint?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1670281694-13281-5-git-send-email-quic_khsieh@quicinc.com>
References: <1670281694-13281-1-git-send-email-quic_khsieh@quicinc.com> <1670281694-13281-5-git-send-email-quic_khsieh@quicinc.com>
Message-ID: <90C493B1-E7E3-46A9-89F0-443922B8FEF5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6 =D0=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2022 =D0=B3=2E 02:08:13 GMT+03=
:00, Kuogee Hsieh <quic_khsieh@quicinc=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>Add capability to parser and retrieve max DP link supported rate from
>link-frequencies property of dp_out endpoint=2E
>
>Changes in v6:
>-- second patch after split parser patch into two patches
>
>Changes in v7:
>-- without checking cnt against DP_MAX_NUM_DP_LANES to retrieve link rate
>
>Changes in v9:
>-- separate parser link-frequencies out of data-lanes
>
>Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc=2Ecom>
>---
> drivers/gpu/drm/msm/dp/dp_parser=2Ec | 20 ++++++++++++++++++--
> drivers/gpu/drm/msm/dp/dp_parser=2Eh |  2 ++
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/msm/dp/dp_parser=2Ec b/drivers/gpu/drm/msm/d=
p/dp_parser=2Ec
>index b5f7e70=2E=2Efdea843 100644
>--- a/drivers/gpu/drm/msm/dp/dp_parser=2Ec
>+++ b/drivers/gpu/drm/msm/dp/dp_parser=2Ec
>@@ -94,15 +94,17 @@ static int dp_parser_ctrl_res(struct dp_parser *parse=
r)
> static int dp_parser_misc(struct dp_parser *parser)
> {
> 	struct device_node *of_node =3D parser->pdev->dev=2Eof_node;
>+	struct device_node *endpoint;
>+	u64 frequency;
> 	int cnt;
>=20
> 	/*
> 	 * data-lanes is the property of dp_out endpoint
> 	 */
> 	cnt =3D drm_of_get_data_lanes_count_ep(of_node, 1, 0, 1, DP_MAX_NUM_DP_=
LANES);
>-	if (cnt > 0)
>+	if (cnt > 0) {
> 		parser->max_dp_lanes =3D cnt;
>-	else {
>+	} else {

This belongs to the previous patch=20

> 		/*
> 		 * legacy code, data-lanes is the property of mdss_dp node
> 		 */
>@@ -113,6 +115,20 @@ static int dp_parser_misc(struct dp_parser *parser)
> 			parser->max_dp_lanes =3D DP_MAX_NUM_DP_LANES; /* 4 lanes */
> 	}
>=20
>+	cnt =3D 0;
>+	endpoint =3D of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
>+	if (endpoint)
>+		cnt =3D of_property_count_u64_elems(endpoint, "link-frequencies");
>+	of_node_put(endpoint);
>+	if (cnt > 0) {
>+		of_property_read_u64_index(endpoint, "link-frequencies",

And this is use after free=2E

I still think than an additional function would make code simpler=2E You c=
an return an error code at any point=2E And then handle it in the calling c=
ode=2E

>+						cnt - 1, &frequency);
>+		frequency /=3D 10;	/* from symbol rate to link rate */
>+		parser->max_dp_link_rate =3D (frequency / 1000); /* kbits */
>+	} else {
>+		parser->max_dp_link_rate =3D DP_LINK_RATE_HBR2; /* 540000 khz */
>+	}
>+
> 	return 0;
> }
>=20
>diff --git a/drivers/gpu/drm/msm/dp/dp_parser=2Eh b/drivers/gpu/drm/msm/d=
p/dp_parser=2Eh
>index 866c1a8=2E=2E3ddf639 100644
>--- a/drivers/gpu/drm/msm/dp/dp_parser=2Eh
>+++ b/drivers/gpu/drm/msm/dp/dp_parser=2Eh
>@@ -15,6 +15,7 @@
> #define DP_LABEL "MDSS DP DISPLAY"
> #define DP_MAX_PIXEL_CLK_KHZ	675000
> #define DP_MAX_NUM_DP_LANES	4
>+#define DP_LINK_RATE_HBR2       540000
>=20
> enum dp_pm_type {
> 	DP_CORE_PM,
>@@ -119,6 +120,7 @@ struct dp_parser {
> 	struct dp_io io;
> 	struct dp_display_data disp_data;
> 	u32 max_dp_lanes;
>+	u32 max_dp_link_rate;
> 	struct drm_bridge *next_bridge;
>=20
> 	int (*parse)(struct dp_parser *parser);

