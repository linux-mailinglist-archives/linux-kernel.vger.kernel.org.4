Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56178742957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjF2PTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjF2PTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:19:19 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26B199E;
        Thu, 29 Jun 2023 08:19:18 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7835e2286c4so33504739f.1;
        Thu, 29 Jun 2023 08:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051958; x=1690643958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nRe+VLQZebwwcwm/RXqyCDIRs/U83v9Vgel4a9NPr8=;
        b=AzLSyPk49DAK3i5g/xrprvfnU6wXXiBMj4T+c5+WMyi3kcOlmQqIzi5FiMz1JLhZY7
         mVjLt5ngXCcR/pCfoem5lrKO0lMMKnTfw+9tm41hIX9e8tNSUTXwT6AOvkk3XGFZhL4G
         lpjIRxWLv6Abtnt8p1VE+zIg5pbj3KMVSQWtIBJTHy9EMXpqPCFNSDAv/I8TlRLVnVZW
         BJGHW4tEUxgFyJU5eFr62I5AuhTToZz+8IA/sGl4vy40UaQCphegJIR1tS3SHJLvxWPt
         JESSuyUk6DsU400wQY2Zxm9dAjwTiY9hpQ7HIUs1F4gdwvENzVFXFyj57cLZGVsNK8dv
         vaew==
X-Gm-Message-State: AC+VfDy3T6WXYx+CidAsmrlV5nbyMCQSI93VLKM65sRtPhPuwZv0mPLX
        FAggfkMr+WQqP1YQZvdjCA==
X-Google-Smtp-Source: ACHHUZ48KcznqwLkw6z0qAkjZFQO0MzxYQ3ANegEU7QUC+CxcohvQReTpyZ1G+rkUcOgPwM8WbHOAA==
X-Received: by 2002:a6b:d808:0:b0:783:491a:13fe with SMTP id y8-20020a6bd808000000b00783491a13femr15716563iob.5.1688051957784;
        Thu, 29 Jun 2023 08:19:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f4-20020a056638168400b0042b05c1b702sm454549jat.12.2023.06.29.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:19:17 -0700 (PDT)
Received: (nullmailer pid 3054549 invoked by uid 1000);
        Thu, 29 Jun 2023 15:19:13 -0000
Date:   Thu, 29 Jun 2023 09:19:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zac Crosby <zac@squareup.com>, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, Robin Murphy <robin.murphy@arm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <andy.gross@linaro.org>, iommu@lists.linux.dev,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Benjamin Li <benl@squareup.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Max Chen <mchen@squareup.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH 06/11] dt-bindings: mfd: qcom,spmi-pmic: Reference pm8916
 wcd analog codec schema
Message-ID: <168805195264.3054489.18382502326981278606.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>
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


On Tue, 27 Jun 2023 18:24:22 +0200, Konrad Dybcio wrote:
> Now that it's been converted to YAML, reference the PM8916 wcd codec
> schema.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

