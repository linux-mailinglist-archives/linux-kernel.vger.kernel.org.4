Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B81742A63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjF2QMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjF2QMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:12:36 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40DF10E5;
        Thu, 29 Jun 2023 09:12:35 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7836164a08aso36498839f.1;
        Thu, 29 Jun 2023 09:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055155; x=1690647155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3cbrEba2zKCc7+NLRK37Om5CmAjDmmF+NMGLR2TXNw=;
        b=gbC2SH9FC+4L6slEkdxO7KzGlldgyQFsjHcc6umJg3lviQzSMIgR9ZBDwIHYQXqgcv
         u5SgCTtPjnuLHH2Vbjp1Qu+a6M/1neFWcDwOGM65j+s8oglY5IsNGmGjNB7tdM+nTQ5k
         xCcrB4L/AMHi3jVLyMHT0VvWMwX/DRw0boSH/Z3v+oQ1+Fnv1b+4sXp8XLhHCl32Aefi
         yBnihCvYXumXHnHitKks9MdMGk7moh+p3xDUymt9RV1z3l+bQDVt9vXdiApoOyfe2O6u
         2X8gpwQyCXI2n1WAinoYXHgoLnrG8MrgpmR42+B8rDBPmvpGmcTsse++8jKA0z0VuNQb
         KR2A==
X-Gm-Message-State: AC+VfDzKBUQXNthokP6A+rPoK1XGpmbh3SwwPRJu6F/DkJUeRXzF2EkX
        1GIF4I5/PgXuX9al20uq89RmmH3Q/Q==
X-Google-Smtp-Source: ACHHUZ705vS8Dn9vGnSlG3J2dxDiTeOe9Cq3FIEpSpo5xeOKdlFlvpHugksZ11fmTkDJxH+5o0uW8Q==
X-Received: by 2002:a5e:a51a:0:b0:783:62af:fbdf with SMTP id 26-20020a5ea51a000000b0078362affbdfmr11390301iog.14.1688055155018;
        Thu, 29 Jun 2023 09:12:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a21-20020a5d89d5000000b00784315b7f86sm1856336iot.24.2023.06.29.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:12:34 -0700 (PDT)
Received: (nullmailer pid 3128049 invoked by uid 1000);
        Thu, 29 Jun 2023 16:12:31 -0000
Date:   Thu, 29 Jun 2023 10:12:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Lux Aliaga <they@mint.lgbt>,
        Sean Paul <sean@poorly.run>,
        Loic Poulain <loic.poulain@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Message-ID: <168805515067.3127989.380988000500770065.robh@kernel.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-6-03e430a2078c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-sm6125-dpu-v2-6-03e430a2078c@somainline.org>
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


On Tue, 27 Jun 2023 22:14:21 +0200, Marijn Suijten wrote:
> SM6125 is identical to SM6375 except that while downstream also defines
> a throttle clock, its presence results in timeouts whereas SM6375
> requires it to not observe any timeouts.  This is represented by
> reducing the clock array length to 6 so that it cannot be passed.  Note
> that any SoC other than SM6375 (currently SC7180 and SM6350) are
> unconstrained and could either pass or leave out this "throttle" clock.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

