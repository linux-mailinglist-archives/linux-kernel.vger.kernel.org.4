Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108EE742952
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF2PTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjF2PSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:18:53 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF6199E;
        Thu, 29 Jun 2023 08:18:52 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso32497839f.3;
        Thu, 29 Jun 2023 08:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051932; x=1690643932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2F5panrQ9N51YbtKXEYqm4xFh86mMaEOlU/moUG6+Y=;
        b=VTY8IOfMvrRO0r88NUy1IFD4csxpPpFTCD5zBW7krMZ5rfSsNyev6ilR28k5kXE9X8
         9EF1t7525umN8+iMtDUH4y2D3003ktNlTl30QHLxGFvOqR6nkSbI/nCQlVMGKkp2BuBy
         vDD7aV26JyrFc2YAYmnWiuWY8Hq0Q676tgkOxqzBHILSZ7QKXV+4JhQCa/FG7p26l0+z
         ce+2SLUkBBP/b7+enNvQ5bSIZLmhU+BrPTQ3Y9zVbp/yISSqjMvWJouWAG99UOsvAs5a
         Gew1SnrPFK5IJLV/cQumcpWjP1lsM4tG+LriM8bYyIyYrvwPLLTl1E3yXrBVi42QGhRQ
         w0LA==
X-Gm-Message-State: AC+VfDw36VuaT5luNss0LOXIGy8GoBktDDA9mJQ6sfdKGKhFmlJ8uk3z
        hTJ10jX5w35NZ996RJb8Tw==
X-Google-Smtp-Source: ACHHUZ6s9Jdl5RFEqCdgdp0bwGY7cGwuE+P2Z34gk2rOEic26k/FpRgytM547mDniAnRHCO5gYxGXA==
X-Received: by 2002:a6b:d912:0:b0:786:2c7d:dd19 with SMTP id r18-20020a6bd912000000b007862c7ddd19mr3191265ioc.17.1688051932111;
        Thu, 29 Jun 2023 08:18:52 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a22-20020a5d9ed6000000b0077e3566a801sm4430658ioe.29.2023.06.29.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:18:51 -0700 (PDT)
Received: (nullmailer pid 3053897 invoked by uid 1000);
        Thu, 29 Jun 2023 15:18:48 -0000
Date:   Thu, 29 Jun 2023 09:18:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>, iommu@lists.linux.dev,
        Konrad Dybcio <konradybcio@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Zac Crosby <zac@squareup.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-usb@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Max Chen <mchen@squareup.com>, Benjamin Li <benl@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        James Willcox <jwillcox@squareup.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xu Yang <xu.yang_2@nxp.com>,
        Joseph Gates <jgates@squareup.com>,
        Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/11] dt-bindings: sound: Convert
 pm8916-wcd-analog-codec to YAML
Message-ID: <168805192771.3053849.17023496929175540009.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-5-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-5-6b4b6cd081e5@linaro.org>
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


On Tue, 27 Jun 2023 18:24:21 +0200, Konrad Dybcio wrote:
> Convert the PM8916 analog WCD codec bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt     | 101 -------------
>  .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 160 +++++++++++++++++++++
>  2 files changed, 160 insertions(+), 101 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

