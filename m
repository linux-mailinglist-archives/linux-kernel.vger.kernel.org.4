Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673474297E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjF2PYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjF2PYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:07 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB722972;
        Thu, 29 Jun 2023 08:24:06 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so33101339f.3;
        Thu, 29 Jun 2023 08:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052246; x=1690644246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOrbkrApUMBf/IMLW4pZSn/5D8w3VaUXsE+FOQe8nA=;
        b=k53bMDqJjO87SyJwB6RwqKcev7VnNl+Oqcv6hZpEz0dmS4kG9W/q/WZRCOeCFrsKMD
         vNoL4KGlSeO5c8EICWBn+6QqMRzSsYPf4WCqnOjiOQdU8YWRh9nLa4TNpPwUYtmNzeF6
         VcFtUPQMM1lVWgz0+AabDwTssHYjFGQFSn+or4eDqT3L8pRuHWtxHZsfAvUrTfomQj7B
         wWHOu4MiaGBUzLd1fu4y1E8BwG6sLJ3EqSoC/jeiZbCHU0PIzvGTKgjKdVQRHW7JQqP3
         7QNDOZa/ovlq7Jkl7jULM00fzw0yp/x/srvBlWLl0/BFVwCGPGsgDuwKUeP99AlEVdnd
         d8Gw==
X-Gm-Message-State: AC+VfDxoJ9/jKoAlMWIFJXaOSFMjJ7zAOi716HTDs2l7GGBCHXPqo1nD
        ctPJV8UHCE0w9AYaBEyhXw==
X-Google-Smtp-Source: ACHHUZ5pbxnXCzp2MEXm/J9Ni9E/P2BCRXI4zVDiAbDqngY6/EOJYBBbjy9gNYs39w0iASDYHMGIww==
X-Received: by 2002:a5e:d908:0:b0:785:ff35:f340 with SMTP id n8-20020a5ed908000000b00785ff35f340mr5661463iop.14.1688052246225;
        Thu, 29 Jun 2023 08:24:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h17-20020a02b611000000b0041d73d0a412sm3955608jam.19.2023.06.29.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:24:05 -0700 (PDT)
Received: (nullmailer pid 3061241 invoked by uid 1000);
        Thu, 29 Jun 2023 15:24:02 -0000
Date:   Thu, 29 Jun 2023 09:24:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        devicetree@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        alsa-devel@alsa-project.org,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Max Chen <mchen@squareup.com>,
        Andy Gross <andy.gross@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Joseph Gates <jgates@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Peng Fan <peng.fan@nxp.com>, Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
        iommu@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        cros-qcom-dts-watchers@chromium.org, Lee Jones <lee@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
Message-ID: <168805224161.3061187.9426822881905540470.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
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


On Tue, 27 Jun 2023 18:24:25 +0200, Konrad Dybcio wrote:
> The description of reg[1] says that register is optional. Adjust
> minItems to make it truly optional.
> 
> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

