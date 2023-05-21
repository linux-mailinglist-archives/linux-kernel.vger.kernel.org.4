Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFC70B170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjEUWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjEUWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:23:54 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC68DD;
        Sun, 21 May 2023 15:23:53 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6af6df840ffso757334a34.1;
        Sun, 21 May 2023 15:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684707833; x=1687299833;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KAY67UCuApho3EFGBTe+ZwXaOBBvqQRkfmzBqO+gFKk=;
        b=S2ZGPZidlN3cOFNKQPt9zHHYKuqzB0EAt0r80dbz2gn582/XBuXMlgJHroO82boDs8
         ssn3v9BNZo2p0shmWqelD+WtsNqALpPPXLBPOyweIQktuQtoBuTUfmBOn8sUp8ZSB7d1
         9tW6FW5bvazieEMiZlIvClWw8T/utNdEJGlAVPxYzNiOXnPXH2AKwaWStNTmKUgm6UsI
         IkuZ7ITlPJ/i4B7WQib8W2IG66be1YdezHx6OV7UB5FlSgzAOt/RXbA7mV5WS1cglpzI
         nY8rQpLwI8e3stuWCUVTUVF4P7soz7LCkRgIyivE0PwF17gFNJVON9DlzsnDby0m00Bu
         cSWQ==
X-Gm-Message-State: AC+VfDxsuVXr9d90q0cpfUSUIlOMaAJFxv0AzTa+lkg7FmsJAaAtPxZU
        yhyHujVoeP/I9IO6dpCz6w==
X-Google-Smtp-Source: ACHHUZ7L6bXXfCzbawGSRq/3weqfOYxW8zXa/PPv5VJnhrT+5whuhA5JYT6Gqt+riwr27cWsTCTAzA==
X-Received: by 2002:a9d:5e8f:0:b0:6af:793b:a87 with SMTP id f15-20020a9d5e8f000000b006af793b0a87mr901124otl.28.1684707832800;
        Sun, 21 May 2023 15:23:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q25-20020a9d7c99000000b006aaf82bd5a2sm1825160otn.43.2023.05.21.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 15:23:52 -0700 (PDT)
Received: (nullmailer pid 1541546 invoked by uid 1000);
        Sun, 21 May 2023 22:23:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Martin Botka <martin.botka@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20230521-drm-panels-sony-v1-9-541c341d6bee@somainline.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-9-541c341d6bee@somainline.org>
Message-Id: <168470782808.1541521.2400870342628606112.robh@kernel.org>
Subject: Re: [PATCH RFC 09/10] dt-bindings: display: panel: Describe Sony
 Xperia 1 display
Date:   Sun, 21 May 2023 17:23:48 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 May 2023 23:23:11 +0200, Marijn Suijten wrote:
> Document an unnamed Samsung Display-IC and 1644x3840@60 6.5" panel found
> in the Sony Xperia 1.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../display/panel/sony,griffin-samsung.yaml        | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/display/panel/sony,griffin-samsung.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/display/panel/sony,griffin-samsung.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230521-drm-panels-sony-v1-9-541c341d6bee@somainline.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

