Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5A706ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjEQQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjEQQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:53:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DB10E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:53:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso1004692a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342428; x=1686934428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hIDvPEdjftlVYbqhIG0JXGHdNlYOdLmSjve7aY9Eo0=;
        b=LuAGyfOolGY2lv4bXLQZDUlCkYAFbMjVgJBhtQ35ZvoRANe0rP+NbkFwtPlSSeIKq/
         Z1ELa4OdH1BhZPPVuEcS54mWAsAWMdI99jGP8mvKnKSUwftMqm5xSRaOfxTPxFqtkLxY
         qdUkIgvZbQvT+RLeoqerdDueR+U+biU/Yr3n0d7E/Y5DiwxKMmqsHwOlN18at7sz3xX0
         hix+tDpT085M0KrBRn5JxxVnqtP8l3xr6wG5PX+qP30zi+WThJQQGkTX+BzXAmY+WljI
         684VChIFfk5qFuVy1ZK+D6QjxLctgUm4HmqkW+vvQDOPqCPVkbasYZ1D9Mdfy/5Rs9bJ
         aCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342428; x=1686934428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hIDvPEdjftlVYbqhIG0JXGHdNlYOdLmSjve7aY9Eo0=;
        b=jRzAOWb89uxc1EyhVXG9o11PUWMak3ILdwaMunRvw4iOVs4qLnK3xt6zMaw7dinzN9
         oFJkzUZNUip6UdH3WlmOqtf8SUl+qNXDdDnrEUp+0AYvybHKPdoqg1YnDjBqmnqf3h2w
         s9Sb3Sk3DFWS3dwi3cO/4Q0sBv+qiPG1vurGC3WzS0H+gDuJpwTG0WZo8XpNTJzwIAj6
         aINJjvuqLa4hLwifEKo58g21o0o/Xj5o3OTVQmG9+k2EvbIBD8p/tltmTWbAf9huTNTV
         boKSDxlPU/G9CiiV2lb449SN4r0wC4XP35rm856sqS6qjnLj2qQwwFWzyxBiIbSjCplk
         /1wQ==
X-Gm-Message-State: AC+VfDwF5bvgB0qGIIVY7RmufPP1gbJwg5dzch1nhWSvn1vGQmCRGkc+
        KSLQMgfUQajslMZmKcmwDHxchg==
X-Google-Smtp-Source: ACHHUZ41XuiV/6uHDBhzp+l1Rm28KeZOiUPPrRFoy46T5x5hqEOTvHbPfGD88VINkhOzOmp9caPxnQ==
X-Received: by 2002:a17:906:9b86:b0:96a:5a59:92cb with SMTP id dd6-20020a1709069b8600b0096a5a5992cbmr24102081ejc.47.1684342428067;
        Wed, 17 May 2023 09:53:48 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id mc27-20020a170906eb5b00b00966330021e9sm12332628ejb.47.2023.05.17.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:53:47 -0700 (PDT)
Date:   Wed, 17 May 2023 18:53:44 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     conor+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, matthias.bgg@gmail.com,
        sumit.semwal@linaro.org, daniel@ffwll.ch, tzimmermann@suse.de,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linaro-mm-sig@lists.linaro.org,
        airlied@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, bero@baylibre.com, mripard@kernel.org,
        nbelin@baylibre.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, khilman@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Message-ID: <20230517165344.6gzwzkwzu44noyqm@krzk-bin>
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517145237.295461-8-abailon@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 16:52:37 +0200, Alexandre Bailon wrote:
> This adds the device tree bindings for the APU DRM driver.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
./Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/gpu/mtk,apu-drm.yaml#
Documentation/devicetree/bindings/gpu/mtk,apu-drm.example.dts:18.15-22.11: Warning (unit_address_vs_reg): /example-0/apu@0: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.example.dtb: apu@0: remoteproc: [[4294967295, 4294967295]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1782720

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
