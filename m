Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896557160C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjE3M5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjE3M5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:57:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E42AF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:56:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso4146944a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451409; x=1688043409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhsY+hhRc4iSF6YgdclHWjJeSAbTG4rDYJhMMhzuUyQ=;
        b=WBS0a8nQAh/I44LB/nupfxbOMVbFwBJ6OzEY/qATr6Bd41Xo5CsW1ld3/2zLPEhxd1
         fCoViKdtSykZYB6hndDKWKMiPTQ7EU/DscqVOHXxfzTN329DQl1TuS+sh0u56G2VCvPj
         cTDKAraus+XFa/kqGZLcoLg/81omH4qMDQjLJHqHMA+n1h1V+34HMaOPCY7H+zUK2FS7
         sjEWB/WYyjxM6gLf+yVm0+KuLyXo2EFGUech4YORQF4vomi/9WL8840fcfcnm2ylhgox
         sp1BFsm8ErK0Hus3+Ndc/SlywVUx5j2pT/On1Z+qzB0DjeDrMT70lChuFGKmUMlo7tm9
         tgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451409; x=1688043409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhsY+hhRc4iSF6YgdclHWjJeSAbTG4rDYJhMMhzuUyQ=;
        b=cDYahGdI1Lgmxbf91gnUjVel4JW5c2WfzJMILSDGn5x87Uq2xrYJbmvUnI+5GgMJik
         QV4PuOs6LlEwnEEZqLr52736BqlkloTGN679Q5MkjKCRcq0Wn4sRsZ/8YfpcyePz7SUk
         dE0yj/bXUZeXocit3nit+EvP6YIQvcKUvKcoEQs4osHk5YXI/Ua8Us3VYa0apEg30kBU
         2TFtRju434K/VAlDc1U5UQsn1rUgknNyXEphsxsorHW424N2cFP/ugVpXBeGwFp2FDZn
         N3XB3PVLMjxHnt4k027BER1APp9JQA1JEJs6SY/T6ufbAFOwTtW8VJp6dnH8/A50n+kR
         lS+g==
X-Gm-Message-State: AC+VfDzVHEEIsRa8aFRo8e/j/ntV1TDBEAWBfFZjKq1FoQ3iKfbOMOLF
        MvmGEV/zfNxy45Vvgr9vL8+qeA==
X-Google-Smtp-Source: ACHHUZ52CRi1rZ1Td3mZ3VL6pr2PyrkknEvQNA1Esi8BwxVXoSn0obftCgpFKZydkULmsPFFhT9EVg==
X-Received: by 2002:a17:906:fe4d:b0:970:1a68:bacc with SMTP id wz13-20020a170906fe4d00b009701a68baccmr2314391ejb.67.1685451408768;
        Tue, 30 May 2023 05:56:48 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090652d300b0094f23480619sm7437454ejn.172.2023.05.30.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:56:48 -0700 (PDT)
Date:   Tue, 30 May 2023 14:56:45 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, quic_arajkuma@quicinc.com, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, quic_ipkumar@quicinc.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, quic_srichara@quicinc.com,
        quic_kathirav@quicinc.com, vkoul@kernel.org, andersson@kernel.org,
        quic_anusha@quicinc.com, quic_sjaganat@quicinc.com
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574
 bindings
Message-ID: <20230530125645.ezd4qs5bmoyfhg33@krzk-bin>
References: <20230519085723.15601-1-quic_devipriy@quicinc.com>
 <20230519085723.15601-2-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519085723.15601-2-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 14:27:22 +0530, Devi Priya wrote:
> Add bindings for the PCIe QMP PHYs found on IPQ9574.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Picked up the R-b tag
> 	- Did not convert the clock IDs to numerical values as the clock
> 	  header (dependent patch) is merged in latest rc1.
> 
>  .../phy/qcom,ipq9574-qmp-pcie-phy.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dts:29.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1783652

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
