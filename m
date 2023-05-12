Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38EA700DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbjELRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjELRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:31:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0FAD06
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:31:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9d8e8898eeso12970216276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683912700; x=1686504700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOBiYL4MwkPBAdAa0oljolb6gFlLduUl+hv8/gzGBww=;
        b=Ljb2Ic9b8AFxQ3m1p0awPhm6nnq3HpWkJcsg1631eUZzTO/5hnV2HsKfisYyDtDb17
         V8552imBkDLbXmsjLctugQqCfKAMaR1wmUD2LIEePT6ZNVq93DcGJLaEMO0Tg7q3XRzg
         T+nmAgGCDQwI673WZ51nYlxKCCAy2VMVN2QaC8MNO1MZB2PKR/oZt4bUuHyFpaovvBTd
         i1ik1UyIy1Bz/rJ9JxXZVeeRzgUhQXNnk4CVj4XcxqPEUUnuO/i6PmIQbM8+3Zac0zc7
         0DSoAHA7T0OB84VFnq7RXQfc9uK0QfUBRdYFXUF4fSZnsREIgHwm2mIyXcHRdciVZvUA
         fy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912700; x=1686504700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOBiYL4MwkPBAdAa0oljolb6gFlLduUl+hv8/gzGBww=;
        b=dmy596T1bjIFr1qIitIIPb7LukyRDMPUNlc1bbti0u1axcrmxAU6buN7xdfu/zrvtb
         ZP0naP/2RdJm6JvIJF5d5wBuptdCg27Y6cBP0FKGsi5+zj/6OY8AXsrPSCiJNlsR8DiQ
         kTkqda9AH4SX06J3nfKWF0kDudyicyAXklutZhLQ8pqYFZdL8XBxwNx/oRAr4/1udoXS
         bjjDO1xEFIYzFXNKGQLUQgkquAHf6KC7pOBxr1bbhMj2oqky2xFSlBneGj/fT88Yij3z
         3dGV30jdrdyICYqFCUivwPYy+em4SwWxd/NJm+MHwhtiC91BE5KyOlcdCvgIirMcymiT
         gOKA==
X-Gm-Message-State: AC+VfDyl7srCS5JlH7MwgsGGkAmumKrMV+k4Iad9rOreWebceheqmzgN
        0Ukak93WigwD6xc5DC047M5MUwvMpnzZ1CFp1+/ndA==
X-Google-Smtp-Source: ACHHUZ5QiUFPYw4G5Vzfw9NyzYMR98hObzlMHs6fX4n4VbtBCGWAHhsTIfoiD8WdkQP2k/IguG8OB9exVS+Jukb8ijM=
X-Received: by 2002:a25:d38c:0:b0:ba6:a813:f19e with SMTP id
 e134-20020a25d38c000000b00ba6a813f19emr5660000ybf.50.1683912699977; Fri, 12
 May 2023 10:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-5-quic_kbajaj@quicinc.com> <68f9bee2-5a5b-2962-6c3d-e73ade371545@linaro.org>
In-Reply-To: <68f9bee2-5a5b-2962-6c3d-e73ade371545@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 12 May 2023 20:31:29 +0300
Message-ID: <CAA8EJppObh3h8sxB_f9SQy7EQ1Gfhe9EbzV=wsUbVNj9PtX=GA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] nvmem: qfprom: Add support for secure reading on QDU1000/QRU1000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 at 20:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/05/2023 14:21, Komal Bajaj wrote:
> > Add qfprom driver support for QDU1000/QRU1000 SOCs.
> >
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > ---
> >  drivers/nvmem/qfprom.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> > index 20662e2d3732..12a7981a8a71 100644
> > --- a/drivers/nvmem/qfprom.c
> > +++ b/drivers/nvmem/qfprom.c
> > @@ -109,6 +109,10 @@ struct qfprom_soc_compatible_data {
> >       bool secure;
> >  };
> >
> > +static const struct qfprom_soc_compatible_data qdu1000_qfprom = {
> > +     .secure = true
> > +};
> > +
> >  static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
> >       {.start = 0x128, .end = 0x148},
> >       {.start = 0x220, .end = 0x228}
> > @@ -490,6 +494,7 @@ static int qfprom_probe(struct platform_device *pdev)
> >
> >  static const struct of_device_id qfprom_of_match[] = {
> >       { .compatible = "qcom,qfprom",},
> > +     { .compatible = "qcom,qdu1000-qfprom", .data = &qdu1000_qfprom},
> >       { .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
>
> I have doubts that this is still compatible with qcom,qfprom. It uses
> entirely different read method. That's why generic fallbacks are bad,
> one more case to my growing list of awesome examples. :)

Yes, it looks like it should be 'qcom,qdu1000-qfprom",
"qcom,scm-qfprom". And possibly a separate driver for scm-qfprom.


-- 
With best wishes
Dmitry
