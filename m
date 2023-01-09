Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6655D663517
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjAIXR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjAIXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC461CB13;
        Mon,  9 Jan 2023 15:16:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so15550208lfv.2;
        Mon, 09 Jan 2023 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ORCokxU5jx6cKMaaTper0S84yDtXOhtofp7KVmnXiA=;
        b=QdlzW40tyv/wOyAd0t/0Pkv5enmi1SZeXXuLb3sKU0MVWmGJHk9UuQG1SLoL7xhkdB
         AqABtKiqP1rzK18A6dnd0Pr1S8ChdG55n6ixEjrataQ3NhjrihGrh2S+hW4sPeWF5fPC
         lj0huOAVW51wYVP+tsGCov9pOr9HPNSfy5Tp5AMqejjkLs7w1M8/thZ0WdpFGHUfJtN1
         MvdhWu2jfRV/n0iEyLy/4spC1FRkhODF3U0FQD179eZVquhwRqDGbkefeStLYyEF3XNW
         d6DrohC+tHzhtOL0WV/JcPj1/H+7FMVUIoJRu7L0UU1T169OFV+uFO2wt0cNTjnrIBsF
         20KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ORCokxU5jx6cKMaaTper0S84yDtXOhtofp7KVmnXiA=;
        b=FSWphUA/WMMWqb9Hf6yh1cKlRzAPp/jwh+EJjz8aBcQydz8SwuatKs3B4W94Zo0Bxx
         KNgoSbwfhznA74E87yUPiAW174wDMXygmCVQOwq3HWZakVGJg0osxVpWjENBR0e1pMPT
         kuBLQAoZknEVkbs2FuevUedtYJX2j5xJBTiDU7GMsRJh43ON8WAXpMm5j0Svu6Qkzr7a
         xQ/vToxDRXmShm2Jsp+QkqEZ2KWRwxCzpzkBG2mI8vQ0KVl+vrz4m5cJXK8+us1soGRw
         dqskt4VyWZQziYimqruNtW5ryOQAjtwDPbL+0xNdJHHoOt0qdeiwh13PG9yXheqZwpkI
         837Q==
X-Gm-Message-State: AFqh2kr8hBrFB8cFiMt9xuz8IOTNYHISUcdercLFEQsB+R5EyC2FCT1l
        bhJe0bnmx+PfvXCWLWVoP5c=
X-Google-Smtp-Source: AMrXdXsCbcTdDaTRpnUjGR5hQtLiFtCrpoRSWtrpxkgLsUUlzEWRhBdXsDzyLfrRwhHb4avnFJjojQ==
X-Received: by 2002:a05:6512:260a:b0:4cb:427:745c with SMTP id bt10-20020a056512260a00b004cb0427745cmr21625530lfb.33.1673306188877;
        Mon, 09 Jan 2023 15:16:28 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fe6000000b004b6efcb7bb5sm1840277lfg.169.2023.01.09.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:28 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1672163103-31254-1-git-send-email-quic_khsieh@quicinc.com>
References: <1672163103-31254-1-git-send-email-quic_khsieh@quicinc.com>
Subject: Re: [PATCH v16 0/5] Add data-lanes and link-frequencies to dp_out endpoint
Message-Id: <167330408780.609993.2871958303249366717.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 09:44:58 -0800, Kuogee Hsieh wrote:
> Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
> functions to DP driver.
> 
> Kuogee Hsieh (5):
>   arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
>     endpoint
>   dt-bindings: msm/dp: add data-lanes and link-frequencies property
>   drm/msm/dp: parse data-lanes as property of dp_out endpoint
>   Add capability to parser and retrieve max DP link supported rate from
>        link-frequencies property of dp_out endpoint.
>   drm/msm/dp: add support of max dp link rate
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: msm/dp: add data-lanes and link-frequencies property
      https://gitlab.freedesktop.org/lumag/msm/-/commit/123f12555074
[3/5] drm/msm/dp: parse data-lanes as property of dp_out endpoint
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d25cfeeec064
[4/5] Add capability to parser and retrieve max DP link supported rate from link-frequencies property of dp_out endpoint.
      https://gitlab.freedesktop.org/lumag/msm/-/commit/381518a1677c
[5/5] drm/msm/dp: add support of max dp link rate
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0e7f270591a4

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
