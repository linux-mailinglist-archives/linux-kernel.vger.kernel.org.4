Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2835667F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjALToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbjALToG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684A101F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:35:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bf43so29922414lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAYjynh/JlSA73SJ+NClSDWR2Z+GwEtREPC4s1NxZeM=;
        b=GHFE1mgKGNMBi88jxaIEXnLBn3cC2pHb7pcv7ZbbS07IdBfH/fjwvLPsOOf4lRc2Ji
         jROi2YaMBZ+BWsbmsa2ANMyBuL41Uca0hOqE1zJFuGSsF9ZFE7s78WymunKIONPk/Mjs
         QxRIizM2TyP/lO0Q1RmLmGTakDIsbT5HT4gB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAYjynh/JlSA73SJ+NClSDWR2Z+GwEtREPC4s1NxZeM=;
        b=ym5DitPp4wi56ecT266K1/3BeCTppA0crboX7wqY30asyCIeyBf2viAiqodWM1T4xI
         Uvp5Th6J5xFLp9RXJM7/9+Ies/KVKJdNaIpctRMcwvDjLne334uuPm1aoYSYNM2vZ3nY
         6JtkaS7KtlMGJp+t0HMoSREA257nrDWM+JnPMXelRo1VprwnOBGiG2DglbpLyh9Nv2db
         AeerZM5PYOpOqktj5ynkSG6VP+/EYLQVu+Qgz1xTioa5nmyXSRkVtK6bqbcFK8UrUlk0
         oszCYfOTo0SRqZRXbbfzOOgGHGHrOjl27Icrt0QDrCtT/6no8Ecc8xgWPRYtD26FkJTd
         C+6g==
X-Gm-Message-State: AFqh2kq4GVKrN8SoE2ogOwekUcb1Af9tTlqBe/qzsg7v9DZixJGLgpho
        DgkHHKABq2jrySwpoK4569N2mmMcq2m6XX9cMOJ0Ng==
X-Google-Smtp-Source: AMrXdXsiV4/qvAwCS2YzjkQkBI2pWHnV74UvffxWaNqCcnh7r+wpnwzqtGa37hxSn3pp+XeRTd+rObR64w2TTviCRQc=
X-Received: by 2002:a05:6512:ba1:b0:4b5:5f2d:1458 with SMTP id
 b33-20020a0565120ba100b004b55f2d1458mr3475453lfv.253.1673552114933; Thu, 12
 Jan 2023 11:35:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Jan 2023 11:35:14 -0800
MIME-Version: 1.0
In-Reply-To: <6cea0a3f-08de-47d5-99d1-74b0d8c7b732@quicinc.com>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com>
 <1672849297-3116-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51AZCa9K_uY=ikTLqV-g_MsSA6Lv=Zq1LMrF-wVhR8_pg@mail.gmail.com> <6cea0a3f-08de-47d5-99d1-74b0d8c7b732@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 Jan 2023 11:35:14 -0800
Message-ID: <CAE-0n52ahKMzk0ho5jG1wxebm3ZE+Wfu_BunCaTR1WhN+J5jpw@mail.gmail.com>
Subject: Re: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for audioreach
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-11 23:53:23)
>
> On 1/12/2023 2:54 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:37)
> >> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> >> index 85dd5b9..1efb72d 100644
> >> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> >> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> >> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
> >>          .num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
> >>   };
> >>
> >> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
> >> +       [LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
> >> +       [LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
> >> +       [LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> > Why are we adding these resets again? These are already exposed in
> > lpassaudiocc-sc7280.c
>
> As explained in previous versions, legacy path nodes are not being used
> in ADSP based platforms, due to conflicts.

What is legacy path nodes?

>
> Hence lpasscc node alone being used exclusively in ADSP based solution,
> resets are added.

I think I understand..

>
> In probe also, these reset controls are enabled based on
> "qcom,adsp-pil-mode" property.
>

but now I'm super confused! Please help me! We shouldn't have two
different device nodes for the same physical hardware registers.
Instead, we should have one node. The "qcom,adsp-pil-mode" property was
supposed to indicate the different mode of operation.

Maybe the audio clk and reset drivers on sc7280 are duplicating each
other and one of them can be removed?
