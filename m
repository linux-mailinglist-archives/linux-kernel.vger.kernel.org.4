Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571947006C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjELL0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbjELL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:26:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B85E72F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:26:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1644004766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683890799; x=1686482799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSwedcTP/T/+3RiFeQQ6laFrOjHRfiDbObl8sJJc6nc=;
        b=qKicyjgvvn4+DMRMaPClTlbFr7jvphVS0WCD6hHC3LtHa312PvVfURIURH4axz7nZW
         OV0zlUYgAFqBMrk0SYV7EUnzHsPJxl7jtbZd2iiyxUZ8bneyp3X5SvDMs3CiDYVvg1R8
         Cl61CGidTrrF9g+Ho6M/gA7rIN9oOY1CA5Od7jAGyVPQF7R6o3HyyoLJUJENE6szAcF4
         RS8UcdWT3DphuZquZ/VDsWV//Rv8AxXKeJ0Xb5Pf+7BegMInckb2xE2PyvL2EW5YmdRJ
         QqIQflHxEGum828JXeOGVL4t59QGzLdNFwsfZRAI9627oRQvtlEqfKp5W1KN47HFw9/m
         uv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890799; x=1686482799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSwedcTP/T/+3RiFeQQ6laFrOjHRfiDbObl8sJJc6nc=;
        b=hmyNo3+1jeaOuw7tD+g/Z/DB9qBk2Ncn0Q5AU6zVNDvjnY3d+YxOGsRu4U8vnMaNCI
         LVegUNwEAbNp8NiyjRS43togPy2iJXTdJK1o/IuWghmWMT1/+jIY+U9oxmrS510bFyih
         MhAJqCvelXvZuNJmJrt3HeydMo9BuPdp/+ER3uoTrFz8Avuuv7c1I6i51iTw+DwLlZYG
         1zeTa6m9/9jvyFaVkWHhO47vDaA3hOw3OtTPgrnPfGALrZFot0GBuB6M6UVRuWFFpek0
         Q5myDdmZuDVLaWU5kuaRCA6apcKXn9lSmZjHururH+E6ikSTUHuMfd1DeN7xTWRtlpQg
         dbDg==
X-Gm-Message-State: AC+VfDxrRWUxqaQTRPeoTKQwBrnOHoqZh/0b1I8q6vk3DcPPIV4l+Nhf
        a8BrO31xYF/XGn3benCkJR1ZYw==
X-Google-Smtp-Source: ACHHUZ7BhkAH/nqhNqGI1/QVLs0Ys0in9nUfI4VBwsohX9SXFQNlVz6iV86gxdYNTkcwECrR4h7k2A==
X-Received: by 2002:a17:906:6a1b:b0:96a:54e5:55d6 with SMTP id qw27-20020a1709066a1b00b0096a54e555d6mr5883243ejc.48.1683890798957;
        Fri, 12 May 2023 04:26:38 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ml17-20020a170906cc1100b009661484e84esm5319108ejb.191.2023.05.12.04.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:26:38 -0700 (PDT)
Date:   Fri, 12 May 2023 13:26:36 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        michals@xilinx.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bharat.kumar.gogada@amd.com,
        devicetree@vger.kernel.org, nagaradhesh.yeleswarapu@amd.com
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Message-ID: <20230512112636.7qmq2qwzzcnkf7dx@krzk-bin>
References: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
 <20230512062725.1208385-3-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512062725.1208385-3-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 11:57:24 +0530, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
>  .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: /example-0/soc/pcie@a0000000: failed to match any schema with compatible: ['xlnx,xdma-host-3.00']

See https://patchwork.ozlabs.org/patch/1780383

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
