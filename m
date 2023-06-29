Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4B7429A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjF2P2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjF2P1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:27:50 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DAE57;
        Thu, 29 Jun 2023 08:27:48 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-783544a1c90so33585039f.1;
        Thu, 29 Jun 2023 08:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052468; x=1690644468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZR9sZh+9bjHT/NeBWN3KSD8INZ5F1XGNWsIgo61+bw=;
        b=WGuX7TOe7g3Vn5OECSraMNCk52ob8wEu4AguwZ4TTgo9V8y64dSGkQ+ksPwRUe5PuZ
         N1tlvjDIWMriF54ytl+ZCJ8RYhsVle8f3h78apO36+GAQe2kTAVqQWsuoJHETngPl1ck
         fxTIYXGYJfgA1K90pgPWkR9FC3qk+q3Y5sEe7b/hdcXtKvGeYewV2ZR6rw5HbPWjsvZt
         mKBFn5tDfgOvFLn4kkwMlDhMPl8yCFnlRCqAuALGlEC9numaaO4EtNHLSavQGAaaYAAy
         EcLthhkJd+Rb5PeO8ITLnSBzJxywgA9+6HRpbf9Ax3FhcgxNVfAUr+ND9v/WCRYlbC35
         klUw==
X-Gm-Message-State: AC+VfDwOwTktjkpBf5BgnlDXunbkhl1Inp5ZdX+cuYfO2nYbPLO2lcZe
        jgnH1/iKcGlDrUcyl5HMUDUqh8S/lA==
X-Google-Smtp-Source: ACHHUZ4KLxkCInEQQQCS9qmNAEIF532E5Hd6Y2pqUoJrYe3Vdsqc/jeuYEguX546tpcpPckCkDYkiA==
X-Received: by 2002:a05:6602:424e:b0:775:5f74:f4c7 with SMTP id cc14-20020a056602424e00b007755f74f4c7mr42469927iob.17.1688052468076;
        Thu, 29 Jun 2023 08:27:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a02878a000000b00428722c1c51sm3875373jai.32.2023.06.29.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:27:47 -0700 (PDT)
Received: (nullmailer pid 3066583 invoked by uid 1000);
        Thu, 29 Jun 2023 15:27:44 -0000
Date:   Thu, 29 Jun 2023 09:27:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lux Aliaga <they@mint.lgbt>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require
 GCC PLL0 DIV clock
Message-ID: <168805246390.3066499.7212254924681716912.robh@kernel.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-3-03e430a2078c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-sm6125-dpu-v2-3-03e430a2078c@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 22:14:18 +0200, Marijn Suijten wrote:
> The "gcc_disp_gpll0_div_clk_src" clock is consumed by the driver, will
> be passed from DT, and should be required by the bindings.
> 
> Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

