Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDE7236A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjFFFJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFFFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:09:44 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5761B1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:09:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38e04d1b2b4so4789087b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686028182; x=1688620182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QAmYzkZJYwnJJFYZpQxGTcgFYpbZNs+6+zl7l0n4pU=;
        b=JXFSn6VNhygL1OAk3/ZP0liCG/XEnZWOsOFIzpkLeJid5YgJ/0UBH95KhvW+OQJiqq
         PTV80ggbnXi52CYWyai3ElIfou8S0cLneNhd5a3rr6PDGCiiazrcLIHJv5RFHIYhAo6G
         cZI3JHXDJQeBard1omGS9y9hMPr/+9dEVFIRQoKbceJX0wgX9zG+1SUN+fZbbwav5qAP
         Q8OZECiThm0WQSXeakApMmZc3Ng5oZjZtcnlnG+IOXXJ5au58Srui8K10ENsmcSB10TZ
         p8MBS90sii5U1HIE+InCJZXRMXlMF3ivep5n1kNza2kek2/mTC9h/Yct/pTEipCuTZZr
         7HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686028182; x=1688620182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QAmYzkZJYwnJJFYZpQxGTcgFYpbZNs+6+zl7l0n4pU=;
        b=a+mwzBE7iM719j+6J7XtO1mESzsQYsmBCPWV0ZSeFX/gSBOIeb0hY0atPrLVo9uq6Y
         y3dVfTaDzZ+8/YPqRBWUqpFNgAkbHdLdFnJ7EJawhRcafbFhNFLtf5LomTKXbUbiTZ0I
         9dXpaEmQPjsR1mB0XL3fbkjwx8Sj3713FaylgwSj7szSWQfjSQ5t0g7+FLHqOx4MwdM/
         2Z5Bh1C0MEKGuKPm3qFN1UxkF0CLg0OCunax4M+0E11e4cIT4E5FnkFs3ubeKccsbb0r
         GOHuJptNY+RaRDJckHPPzZ25VApAQZuCy+Wu09GItMpkrDTGcmBcqdXmSx0mUvfIP7Rb
         x6uQ==
X-Gm-Message-State: AC+VfDyyTCYE4oKgbNsonvshI2Z8QGTC5DaNGWHA/Ynhq4GcNtsbhXVm
        tLXx2I1nfNuw06Ba13F7lZxqug==
X-Google-Smtp-Source: ACHHUZ4LPB7P+/U4Q9XmCW1NRg+AD+DxaS2uUaaghhhEJeB0XPHf03Y/D3Km/OUJ1v+WJgOlH0YoFw==
X-Received: by 2002:a54:401a:0:b0:398:a09:3d5 with SMTP id x26-20020a54401a000000b003980a0903d5mr977168oie.41.1686028182536;
        Mon, 05 Jun 2023 22:09:42 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001aaf2e7b06csm7444051plg.132.2023.06.05.22.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:09:42 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:39:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, tglx@linutronix.de,
        maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, mani@kernel.org, robimarko@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 05/10] dt-bindings: cpufreq: cpufreq-qcom-hw: Add
 SDX75 compatible
Message-ID: <20230606050939.jzpiuupwhirpyooq@vireshk-i7>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-6-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685982557-28326-6-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-23, 21:59, Rohit Agarwal wrote:
> Add compatible for EPSS CPUFREQ-HW on SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index a6b3bb8..866ed2d 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -36,6 +36,7 @@ properties:
>                - qcom,sa8775p-cpufreq-epss
>                - qcom,sc7280-cpufreq-epss
>                - qcom,sc8280xp-cpufreq-epss
> +              - qcom,sdx75-cpufreq-epss
>                - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
>                - qcom,sm8350-cpufreq-epss

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
