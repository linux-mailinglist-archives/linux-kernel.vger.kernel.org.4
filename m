Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E426DB5E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDGVs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDGVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:48:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48700C65D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:48:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d7so10898065lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680904103;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DllG90e1WWVTHQdAKRkXXv+zJvR74w4Quq11ghlPJtY=;
        b=OVyB1bAFGN0vaGLmVCCfIH5/O4EAIz104DNP3AiG1HqDZ6ggD45bD6puMR+66SwJSK
         4ZUAKjMTvJqwjpGxxauYTX3B3Qsy5NOfW3GSp6NCJY1Dbq0SiP8vRE2nv87+iJxdV3Ff
         b4b2Gr4tI95SF2pvloDwpvasMCAXEcUsELAo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904103;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DllG90e1WWVTHQdAKRkXXv+zJvR74w4Quq11ghlPJtY=;
        b=LXSnJ8MKPqb1EfBIQoC2XFnYUgOdskaYiZQWJ2BmbJPS2g4UERLZ1uGjZd7YzSODV3
         76Ttd1hnit3N47nWUY+K2Hsibi/6jcpOhuE1pT9UZcKesR2tPKVXzp8vf0O3B5W1G2q5
         yW5wzXxZn/gmM/0iR3YGroYGmnypAAIDjGW8jHOzXLOUnNH5lm+XfgbD4B3mpiVVYfUn
         mgP7eJEuOh9lB/ckC8LdZ8rdEvOmdsbhSCKGA8LNNohO+K5rmIHp8Wnc7ZngdjYK7olp
         f3ynBSxRedOs3joZLjj0nJ4WW4ez4mY1thoaKzVXVFGVGbUzQnDKfbhnNFDRZfnEkYUr
         0Dog==
X-Gm-Message-State: AAQBX9f0BNM8u9ntieeWG1tR0QxOJ2rdh5/NiBj7A6JBecCmmXt953me
        4l3jpRymorvjvTVMWdHI0AwgrvhrrwUge2eZDFOaMQ==
X-Google-Smtp-Source: AKy350Yu9m9x8GYDbA/5kgPKVUoE6uvF5g/lH6PO8SorwlwARoXyVdIMeX0FCOQzbIDqgqm+YxpKrwGoFLvyzeXjW/I=
X-Received: by 2002:ac2:4c14:0:b0:4eb:eaf:aa00 with SMTP id
 t20-20020ac24c14000000b004eb0eafaa00mr1109097lfq.4.1680904103550; Fri, 07 Apr
 2023 14:48:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Apr 2023 14:48:23 -0700
MIME-Version: 1.0
In-Reply-To: <20230407092255.119690-4-quic_mohs@quicinc.com>
References: <20230407092255.119690-1-quic_mohs@quicinc.com> <20230407092255.119690-4-quic_mohs@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 7 Apr 2023 14:48:23 -0700
Message-ID: <CAE-0n539B++ynhR04xEDiszz7u718QGLyN4KukrPE3ya6_m9Zg@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] clk: qcom: lpassaudiocc-sc7280: Add required gdsc
 power domain clks in lpass_cc_sc7280_desc
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-04-07 02:22:55)
> Add GDSCs in lpass_cc_sc7280_desc struct.
> When qcom,adsp-pil-mode is enabled, GDSCs required to solve
> dependencies in lpass_audiocc probe().
>
> Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
