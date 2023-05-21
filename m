Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB070B16D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEUWXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:23:52 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B26DD;
        Sun, 21 May 2023 15:23:51 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-39415d3526bso1805614b6e.2;
        Sun, 21 May 2023 15:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684707830; x=1687299830;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTDXznobr9OPk+Kds1D2lbqkYdCbNQhB7fj/Qh9tqKo=;
        b=DkZtRC3wKGVk7KlENQIVplS3L2HonPW1ookSIhbnhtwkfffLIzSJRhhhNrTHVhj/9E
         22acdedscyboX5khJJBhvyYsi7IhpQIf/Lpc5pJ7VPPgrnXBLzfaoXyOoZpWKTFu6KnL
         7eMPUgZzzLpDfDhyj4YKrfLSFGJSRzHAZqjlI+yI3tcnHhokSvZVfMJnU6UWlRtf9Zg9
         N4/DIteH4lX21Kk4511u1RjKHuUDUwtg1ebJvYLJ4S1Vjrv6oMVhn7i604aNUhNmI7d/
         0+aFTujyLBxWo8KHHGZEN2QKhyNYELsPDHNtP5Ox3EMWUPtnp3/V/tR09cndytbXeHF/
         49rA==
X-Gm-Message-State: AC+VfDzHoPYiViVj+WL2jvkfhvY2TdBwCHsxq2zjmsF3FmQeAMgtApxG
        QMrRmoUoRCj2i2XAUL2ZCQ==
X-Google-Smtp-Source: ACHHUZ4mXZIQJRPImk5ZQVXVSf87ZYMaE7QQotlJ+SeOXmbjEFs6/lL9AYO1x/bwqPZ9UK6CS+zBbA==
X-Received: by 2002:a05:6808:601:b0:396:38a9:cd80 with SMTP id y1-20020a056808060100b0039638a9cd80mr4357194oih.12.1684707830411;
        Sun, 21 May 2023 15:23:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p25-20020a4adc19000000b005476712364bsm1760475oov.19.2023.05.21.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 15:23:49 -0700 (PDT)
Received: (nullmailer pid 1541543 invoked by uid 1000);
        Sun, 21 May 2023 22:23:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-kernel@vger.kernel.org, Caleb Connolly <caleb@connolly.tech>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230521-drm-panels-sony-v1-5-541c341d6bee@somainline.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-5-541c341d6bee@somainline.org>
Message-Id: <168470782726.1541479.18410268198759128308.robh@kernel.org>
Subject: Re: [PATCH RFC 05/10] dt-bindings: display: panel: Describe
 Samsung SOFEF01-M Display-IC
Date:   Sun, 21 May 2023 17:23:48 -0500
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


On Sun, 21 May 2023 23:23:07 +0200, Marijn Suijten wrote:
> Document the SOFEF01-M Display-IC and 1080x2520 panels found in the Sony
> Xperia 5 (6.1") and Sony Xperia 10 II (6.0").
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/display/panel/samsung,sofef01-m.yaml  | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.example.dtb: panel@0: 'vci-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230521-drm-panels-sony-v1-5-541c341d6bee@somainline.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

