Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A66FDE13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjEJMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjEJMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:47:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0509030D4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:47:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso104988666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683722863; x=1686314863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoN7UzTWOHRfV6DLizardjz7wWvM7VrRl9MfwBd/glw=;
        b=VW/vtsUD7aHDTF6FaXs3+2O6249VYRLtH3KLTs9QFnecSiHXDOEQvtqYCVCKIY/eFh
         9FT7d5g39c9IMLG1h9/MP4b43gdlgytJDJJ8xHo5M6XPXN3ALuGb7oduULFnnwQ2C9jZ
         HN5KnqpbEI4AWa8GaRp6t9zb9Q1pnJRiBXW4lSaKLltND8fcTXk9eF5AHEpLLfOvNWrA
         SK41quM3EQCkU4i8FRx3FXU6a6WwyskRI+fdjfbcyLkJbPG0+YmIjcPB+/7SLRxktP6R
         IwBWiG9h86zGKaUKt1hehWVyMyYL99FyDS/9ZABBf256m8Id6UrEJFyD7h/B3eYI0BNt
         iCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722863; x=1686314863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoN7UzTWOHRfV6DLizardjz7wWvM7VrRl9MfwBd/glw=;
        b=lAPHWqNJBRU2C+7t4M0cm6gz/c2aqjjZTEzI7fWjIBvk6hiB6Nzl4MyBn+PggyU31/
         DoSoYq3s1wR2/ZCtOF6bXY/DezjoEQlp03J+VEB9yp6BYrZRJGQUPHdzy7hAtcVpKZuJ
         xXXt5aCuPDgXx5DERZm6hi68XZhLYenZU1IH5Xoe1Q4/S7zGwVUb6hKQPOz67acAQdOu
         LE0YtekwhniKJzHZl/GUG8eN5SF4PrYe0dpB/y18zC6T0VyKjnpVl0S7shve4WPO6+k9
         njgjhczEUxNY3rEgRGar+tqqn8zCSLemu5tWtGiPuYACv7XjaavC5vENv9GdI8UokkyV
         LBhw==
X-Gm-Message-State: AC+VfDxzhcDzJAfinErorco613vvZlZPIQXHCxqOVxRhYo4IAhVBdX+K
        cBVxuW+kXUcDysZj9uxg/g6/+w==
X-Google-Smtp-Source: ACHHUZ4iOi30Xbasrz4chc7xaV2DeQmJMK4J7neQi6pkPjtC3qtmAjiIcox0YPP/WPvxuMbhLmzdxg==
X-Received: by 2002:a17:907:2dab:b0:96a:2b4:eb65 with SMTP id gt43-20020a1709072dab00b0096a02b4eb65mr4609370ejc.9.1683722863427;
        Wed, 10 May 2023 05:47:43 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id ia21-20020a170907a07500b00966392de4easm2672231ejc.14.2023.05.10.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:47:42 -0700 (PDT)
Date:   Wed, 10 May 2023 14:47:40 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com, conor+dt@kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: Add bindings to support DRAM MRQ GSCs
Message-ID: <20230510124740.lu7ndc5fvnq6fml6@krzk-bin>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-5-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-5-pdeschrijver@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 14:31:32 +0300, Peter De Schrijver wrote:
> Add bindings for DRAM MRQ GSC support.
> 
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../nvidia,tegra264-bpmp-shmem.yaml           | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dts:21.16-50: Warning (reg_format): /example-0/reserved-memory/shmem@f1be0000:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dts:19.47-23.14: Warning (avoid_default_addr_size): /example-0/reserved-memory/shmem@f1be0000: Relying on default #address-cells value
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dts:19.47-23.14: Warning (avoid_default_addr_size): /example-0/reserved-memory/shmem@f1be0000: Relying on default #size-cells value
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

See https://patchwork.ozlabs.org/patch/1779405

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
