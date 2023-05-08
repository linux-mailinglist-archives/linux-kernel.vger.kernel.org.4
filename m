Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C86FB301
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjEHOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjEHOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:33:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC96106
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:32:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so5509121a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683556334; x=1686148334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEv+z5GVdo2fQSYihfhkSqRDiOLayeUJlpv8lAfiwYM=;
        b=Kaf9fWxY6VO630xBlmIB0J1+uTcjZtM4DCx4GNCDMfcSuetv/mBM/pBJGw9ncMz1M5
         qY/P7/UpMLSzessGqJTNY4ZWuU7Ot/3GgKzhH6AT2J8eSXNT7kGbIcG1Y2UB9usLWrzx
         f8985Zy4yMLH0qHxkFvcyND/1cwi3X2eSx43vth7pRpTN26ZWKPD05HuMUWtdf3X0agA
         d2NCAsnxqp+U6TZ1Pd5wJqWAzaTGbJwYaAZp/nuU81G/V+e3ZjT3HBtGTuQLPwqc0wJ5
         /0hkl1Bw/QpGEVrunLyA0PNH/h95r6HN1dTUzHUOopZb2eEBIGAP/NizByct99GIYkAd
         GvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556334; x=1686148334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEv+z5GVdo2fQSYihfhkSqRDiOLayeUJlpv8lAfiwYM=;
        b=K3BQv5CAjulE+G7/G+j1uKcnI4CvQihRjAfaeFE/kmFsocQTbwWA7hdP5+rHbzthhG
         Qrd2bkghWjyrBfbqmKq+gpDSKhL9BoxO6pxmn3kVN5g4TyyusvkEZkl4hPEWkBaw5So1
         4VnbOUaiVwIcTdJlFPn++u/+8HJPIDZrHkTo3wV0VhVvb1AN+YBNyHybXLBuSpHSYZtS
         HY0thjLXh1cbp1BK+jCJ8yv/vll/xus76CGkp7NNekCdepNCQLuZxTPqO4fUWE7NHEoz
         4WUVDoUQEMuLxqtf4N38WsV1FQ/X9p02+uAGS4juhwDMUvlyQeb96rxAhDaRfkEeOxJ/
         nmTw==
X-Gm-Message-State: AC+VfDxavDTgKdrM4DwulWlGSK1dZQ3bX2vENoeqmTxpnnwajQsSTI+u
        OaQsUu/X39e40freBU2necsPJA==
X-Google-Smtp-Source: ACHHUZ77Q52W7qX/Tx9LySY6H2jF/m5IuGtO1D9kQCz/B/KU3e37fc6N+T2OpiLHlJ8HaPUpTRAWmg==
X-Received: by 2002:aa7:d659:0:b0:508:14f2:399c with SMTP id v25-20020aa7d659000000b0050814f2399cmr9763316edr.10.1683556333872;
        Mon, 08 May 2023 07:32:13 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id j14-20020a50ed0e000000b0050bc4600d38sm6129103eds.79.2023.05.08.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:32:04 -0700 (PDT)
Date:   Mon, 8 May 2023 16:31:59 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     robh+dt@kernel.org, sre@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>, lee@kernel.org,
        linux-pm@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v3 6/7] dt-bindings: mfd: max77658: Add ADI MAX77658
Message-ID: <20230508143159.xr3zrlsgtilxd7ha@krzk-bin>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-7-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508131045.9399-7-Zeynep.Arslanbenzer@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 May 2023 16:10:44 +0300, Zeynep Arslanbenzer wrote:
> Add ADI MAX77658 devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77658.yaml | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/adi,max77658.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/power/supply/adi,max77658-charger.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: pmic@48: charger: False schema does not allow {'compatible': ['adi,max77658-charger'], 'monitored-battery': [[2]], 'adi,input-current-limit-microamp': [[475000]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: pmic@48: fuel-gauge: False schema does not allow {'compatible': ['adi,max77658-battery'], 'monitored-battery': [[2]], 'adi,valrt-min-microvolt': [[0]], 'adi,valrt-max-microvolt': [[5100000]], 'adi,ialrt-min-microamp': [[4294962296]], 'adi,ialrt-max-microamp': [[5000]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: /example-0/i2c/pmic@48/charger: failed to match any schema with compatible: ['adi,max77658-charger']
Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: /example-0/i2c/pmic@48/fuel-gauge: failed to match any schema with compatible: ['adi,max77658-battery']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: pmic@40: charger: False schema does not allow {'compatible': ['adi,max77659-charger'], 'monitored-battery': [[2]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
Documentation/devicetree/bindings/mfd/adi,max77658.example.dtb: /example-1/i2c/pmic@40/charger: failed to match any schema with compatible: ['adi,max77659-charger']

See https://patchwork.ozlabs.org/patch/1778414

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
