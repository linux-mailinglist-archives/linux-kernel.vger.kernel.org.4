Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17551742988
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjF2PZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjF2PYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:37 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDDC359C;
        Thu, 29 Jun 2023 08:24:34 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-341ff6251f2so3289825ab.0;
        Thu, 29 Jun 2023 08:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052273; x=1690644273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eQgcjG/JNZBQYsHaOaghoEHW/pYFGXm2Ot9OAjBn+I=;
        b=Nq2TvS/ZBwthT+5sf3AkLP6uvpP8O4K67rzv2UWNL6tS5DgiM17vLkwEiuQ0MgwvOx
         TXAWJsfp4MSlVDudYR47jAU4VN0kePvhci5jpvJIrWvQGPv1V6KqCQ6249ibh+WFsdwz
         EhjjBCfb6N9zckAh4Pl088NcsUw1Ftd0Jhq1LmhQe7gfEaUS13MdULOS98UurGoQls7C
         bx/5hEfoZIDLY9Hqya27K+909eLtd4eRIRf2dH2qt4U4l5CfIGiiFirkTQU+LMa7U3ES
         0YVV8v6goT0tAljKgx/2NtiZkXM9FRl0TVwdPTmMwKtkIPe+t+GpBGXg9yRX0O0cdYx3
         DYeQ==
X-Gm-Message-State: AC+VfDx6g3wbbVTjLabCHHLiSYG4H/XOFslzNZKb2Z/nt/L3igo2fI1h
        Am6UT18Evya/IHauSoxEmA==
X-Google-Smtp-Source: ACHHUZ6aWR2cNKLqqna8mhpYMU4KBK1rHsg3TJ2zE4I+ravgqHborA0R3NbQyITNWdKK9jJT6CE9HA==
X-Received: by 2002:a92:c802:0:b0:33d:8720:7d98 with SMTP id v2-20020a92c802000000b0033d87207d98mr31008278iln.13.1688052273202;
        Thu, 29 Jun 2023 08:24:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o13-20020a92c04d000000b0033a50ad8176sm4232350ilf.18.2023.06.29.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:24:32 -0700 (PDT)
Received: (nullmailer pid 3061956 invoked by uid 1000);
        Thu, 29 Jun 2023 15:24:29 -0000
Date:   Thu, 29 Jun 2023 09:24:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Xu Yang <xu.yang_2@nxp.com>, iommu@lists.linux.dev,
        Will Deacon <will@kernel.org>, Jun Nie <jun.nie@linaro.org>,
        alsa-devel@alsa-project.org, Andy Gross <andy.gross@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Max Chen <mchen@squareup.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, James Willcox <jwillcox@squareup.com>,
        Andy Gross <agross@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Zac Crosby <zac@squareup.com>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawn.guo@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Joseph Gates <jgates@squareup.com>,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 10/11] dt-bindings: usb: dwc3: Allow just 1 interrupt for
 MSM8996
Message-ID: <168805226868.3061904.18194272296816895150.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>
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


On Tue, 27 Jun 2023 18:24:26 +0200, Konrad Dybcio wrote:
> MSM8996, similarly to SDM660 has two DWC3 controllers: one for SS and
> another one for HS operation. Allow just specifying the HS interrupt
> in the latter case.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

