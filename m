Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0574156A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjF1Pkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:40:52 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:59437 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjF1PkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:40:25 -0400
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-34568286979so26465765ab.2;
        Wed, 28 Jun 2023 08:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966824; x=1690558824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4udzc9jnMqC5J8rq17SsUAo8Uct+p8BS0NFlNfOk8c=;
        b=j3HM2E3QOW7RpDo3yfJmNn0h0K5gUpCpc36OAdFqOWfYqGs5sgQrb2HFMFTFQIByYW
         xU6M2K5GBt20KP7YQhsED7xMGwvLq82O2Qo7JUlFWgE+2gl3YwCsN9FvJzTAjP7EZcui
         xLMYtC9/tWnwf1pfDvJHgL96ROVr/xTF3qFSVwK1QaoyrDibTB+393GlIokf76/5o7aI
         sxr5I/lFPufDBNUz7BSXxmOQ6qlemghdp3F4B+O85Pu977iHTaAgiwGuGdWdV9HgpP4v
         mmrMLheUK60QCThJGFiG78USyj8aoZumioT2IF/iZO+PkGY7se/JQjck+ZetHlzAQZGt
         yQsA==
X-Gm-Message-State: AC+VfDzbNkjPTwN5yMCfqduy1d+LSYrK5EpAhAlN3dLOlZMSnf6hypsn
        JeEF8vMC7rHCG2zxIkdWqg==
X-Google-Smtp-Source: ACHHUZ6ayGbYzQG1PKJecSRaIV1JAJEG1gN8LqkRrUvtwo0eGDQVu8JOqSFjv4oiFaqjy/3ofA1oKA==
X-Received: by 2002:a05:6e02:102:b0:33c:b395:a898 with SMTP id t2-20020a056e02010200b0033cb395a898mr30352399ilm.18.1687966824151;
        Wed, 28 Jun 2023 08:40:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z7-20020a92bf07000000b00338a1272ce1sm3433838ilh.52.2023.06.28.08.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:40:23 -0700 (PDT)
Received: (nullmailer pid 525524 invoked by uid 1000);
        Wed, 28 Jun 2023 15:40:22 -0000
Date:   Wed, 28 Jun 2023 09:40:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs system tick counter
Message-ID: <20230628154022.GA520881-robh@kernel.org>
References: <20230628082716.2075736-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628082716.2075736-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:27:16AM +0200, Sergio Paracuellos wrote:
> Add YAML doc for the system tick counter which is present on Ralink SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> new file mode 100644
> index 000000000000..59d97feddf4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: System tick counter present in Ralink family SoCs
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ralink,cevt-systick

What is "cevt"? Would be nice to define. Really this should have been 
SoC specific, but it looks like it has been upstream "forever", so fine.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

(the error report can be ignored)
