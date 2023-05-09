Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0596FC516
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEILgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjEILgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:36:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84B30F5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:35:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba5f2522304so621792276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683632151; x=1686224151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Pyw5nwHkNnu462qbwGos47j69OLpTlZbNxmPBS04M=;
        b=KrIh5Hk1NDf7N1L5Q/kIXQoVM/rJOfSZtn5DhWzorecfs4Y86UWthqOKU3cz6NRWfN
         14DVPJxjxqLySDfnikRT3EB6uvhGfTR5rhRxgLfsH6BhL5yVg7OwrN3BNb2UhX7kT8FJ
         F8F8R09NEzrb4KCxRzGNoXMichNsn24s57JCZW1stf9BC+WQCFJkYqhvK00rUb24ZdM1
         F8QZDG44dpCzaR/q7jKIUg1P3TzGnqK2D37Evjd7quQ00ZoUvKV727+L92lCAJM9KIZf
         SMawUtOh6bY3Qxhjg08P7crImuwFBKfX2Rp4OnYV0s8f1TSygKW4dL7idsm8i3CRWzUM
         uLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632151; x=1686224151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7Pyw5nwHkNnu462qbwGos47j69OLpTlZbNxmPBS04M=;
        b=JsbTCLIMWQua6chi+M1Gmm2sb+rCDp0d24Oj3uggKeTsSHpfbW02J+CoNbtjmgTvKS
         7FMftyW6LMosWkROMcaTQz1lJgHiM/DKc3JbZX74m62R6O17u+szeulKmKdBCK0nmFxQ
         jecGBJsvVdrLkuEoW/6qNDp2m5Gsh6KZ6soud+1eP6AVeO3/Q/QHd1yKIj5tvsXTRmgZ
         94zezn42yIcmWRgfRGevm57I1RQGXJZgwVUerrUY5bIlbWj0OFp/SjnshqZx3ST7+Unb
         Wvylm3RZ0gHT8+YqhJTfwM0fHda/UEZmg6bVjQcP/CqgsDLW+/DEdGti2rrP40rpnkmT
         YlNw==
X-Gm-Message-State: AC+VfDxb6mjNAcxpHPBPjKBTVidSqkROzavZRqOlOxOAHzAN5V7eAqF3
        VohTUFRbenouHP1GjuOyKY1kcgAhkOE/kgX1ZRCAPw==
X-Google-Smtp-Source: ACHHUZ5pDwhmbQ3yzou/tE8fGJ5nUcd3g6wD19VA1NiYGdmvHTCFdYBNP0eN6CVx1E4EqKnk8LmZaRtu8/gAgSWhsKg=
X-Received: by 2002:a25:5d6:0:b0:b95:2bd5:8f86 with SMTP id
 205-20020a2505d6000000b00b952bd58f86mr14675399ybf.26.1683632150830; Tue, 09
 May 2023 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683628357.git.quic_schowdhu@quicinc.com> <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
In-Reply-To: <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 14:35:39 +0300
Message-ID: <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
> All Qualcomm bootloaders log useful timestamp information related
> to bootloader stats in the IMEM region. Add the child node within
> IMEM for the boot stat region containing register address and
> compatible string.

I might have a minor vote here. Is there any reason why you have to
instantiate the device from DT?
It looks like a software interface. Ideally software should not be
described in DT (e.g. this can be instantiated from imem
driver-to-be).
Or we can follow the RPM master-stats approach, where the device is a
top-level device, having handle pointers to the sram regions.

>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sram/qcom,imem.yaml   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 0548e8e0d30b..bb884c5c8952 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -50,6 +50,28 @@ patternProperties:
>      $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>      description: Peripheral image loader relocation region
>
> +  "^stats@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Imem region dedicated for storing timestamps related
> +      information regarding bootstats.
> +
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - qcom,sm8450-bootstats
> +          - const: qcom,imem-bootstats
> +
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
>  required:
>    - compatible
>    - reg
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
