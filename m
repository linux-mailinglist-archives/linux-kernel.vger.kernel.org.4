Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD96DB081
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDGQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDGQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:23:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B1114
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:23:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i6so49505814ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680884599; x=1683476599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohFbb1dKXrRtFWACbHMbO4cTeWK5wuWqXsuHiYb+bX8=;
        b=Ojhfm9tGp/aGabu3O8Q+Hh2Kpu1ETK2PV2IJjttUyw0AOjfzoHvwuHzLV9REzximp9
         lktVgzeS977HRyU0i3ejL9NrMS17OPp54Bh4nLDbw6cYDyjTcoJTLYtF7zy9TOcumR3K
         /WPjBx6INaVEyLsSZc3v+Ve8ksDe/72npLKOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884599; x=1683476599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohFbb1dKXrRtFWACbHMbO4cTeWK5wuWqXsuHiYb+bX8=;
        b=tYNMPEZAjVQpYlLg8lOcwUA2Kp4XXT9xwk6ola/cQiZ4sQeCzMDWQCpHTtGqUnPUKg
         1UkczkTpXLYrDiz0zIGr+vxRohAbJrr6mNrQDCiCmelVue2nui2zgmX7Ua8iiD+dMRQI
         7zMo05wGuC3KK+55zhjYwINWG4SQDp+dYqli148a3+iWeuCD+dlZ938Eamc/KThwHNYR
         NiXHu8mN4Gc4eM7MPbFE5vRe5L6OdZHP3GHYEAOgPzclBbWTdClkmUtBTQxKQAGNcok9
         lz1X5CJoxM2XaPnA4RYO+LBGYg65Ecft3YWCZWKI5cW79CVxHfHOkwzYGvbAiOVn+R6N
         keYA==
X-Gm-Message-State: AAQBX9eI+Ci7jnqvkpFE1xiqa/9p6/nnSFiGlPR0tp5QovbNXJbS6aY6
        +JrAOh/EV9AE1nyiOH6+34auAGVYvuy+kI7vhsQ=
X-Google-Smtp-Source: AKy350ate78UoXgAWQ1azCAJRxPV79S+qzGiSMnwzCTI3lWQnws9dOqMAw9TrKA/45Xdg6RAZD7sZA==
X-Received: by 2002:a25:db12:0:b0:b33:d8a5:e2cc with SMTP id g18-20020a25db12000000b00b33d8a5e2ccmr2399916ybf.22.1680884599247;
        Fri, 07 Apr 2023 09:23:19 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id e73-20020a25374c000000b00b7767ca7476sm1199555yba.19.2023.04.07.09.23.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:23:17 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id cf7so49494955ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:17 -0700 (PDT)
X-Received: by 2002:a25:cfcf:0:b0:b2f:bdc9:2cdc with SMTP id
 f198-20020a25cfcf000000b00b2fbdc92cdcmr2102212ybg.7.1680884596886; Fri, 07
 Apr 2023 09:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230407151423.59993-1-nikita@trvn.ru> <20230407151423.59993-3-nikita@trvn.ru>
In-Reply-To: <20230407151423.59993-3-nikita@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Apr 2023 09:23:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_iLB7kgsvdQAUX+7tMtQTj91xFV_CoTzDDxsLK+zFMg@mail.gmail.com>
Message-ID: <CAD=FV=V_iLB7kgsvdQAUX+7tMtQTj91xFV_CoTzDDxsLK+zFMg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: sc7180: Drop redundant disable
 in mdp
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 7, 2023 at 8:14=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wrot=
e:
>
> mdss is useless without a display controller which makes explicitly
> enabling mdp redundant. Have it enabled by default to drop the extra
> node for all users.
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 --
>  3 files changed, 10 deletions(-)

Makes sense to me. If you were feeling particularly proactive, you
could also fix the same issue on sc7280.dtsi

Reviewed-by: Douglas Anderson <dianders@chromium.org>
