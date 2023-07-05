Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27197488D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjGEQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjGEQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:03:07 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DD19AB;
        Wed,  5 Jul 2023 09:03:06 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7835ae70e46so261770639f.3;
        Wed, 05 Jul 2023 09:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572985; x=1691164985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KBpOFJZyS5xM9abNo2nJ57ufwQERCZ3x55i0T0eDUY=;
        b=Tyz24ETWp0Bg9+0tO2dn52iiN/aLrCHfAtIrZalJvQ+V8ob2KXyGvC5sX9bh6UM90B
         z7Rvs+72z9tk0c6VSwcwkTpe2yOnHbiU/utD5uXG6IkD/Ty257s3Nytt/HQEa1VV3U2M
         8QUdEhOJVpFhDs4Hhp++8vL/bd2KE4BystEwcgO75tdezzZTPziMUB8VjN07PctrDbuV
         BUtTrk0BF5OxjOwm5PAB6vX+YfvCwWCdXzkcCG0a4DoMCKN8W6G5zCJ0XOphCWZ6Wd6h
         CcXDyALA8Jta1+QcLH7IZWeewKh7yymSpJkKwuBokbDZ4+jTllUUc4QXZBojalzPkQuc
         6R5A==
X-Gm-Message-State: AC+VfDyhUEJ2xMX8JDHd+Gusii/ls7sDOFn1UVgxrdKOfj21ZUlQqhGI
        Td5ucCC0HzfEUb/n+y8+kw==
X-Google-Smtp-Source: ACHHUZ5Z8VqWZ/v/LomwEhPw2FxxUKwe6Z2nAX7VtpW4YDpUCLHgztTIHZAFe8baQtOy8AZBd0mglg==
X-Received: by 2002:a5e:c910:0:b0:783:58f4:2e2e with SMTP id z16-20020a5ec910000000b0078358f42e2emr16821097iol.0.1688572984946;
        Wed, 05 Jul 2023 09:03:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k9-20020a02c769000000b0042b449ac66dsm2108515jao.56.2023.07.05.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:03:04 -0700 (PDT)
Received: (nullmailer pid 712513 invoked by uid 1000);
        Wed, 05 Jul 2023 16:03:01 -0000
Date:   Wed, 5 Jul 2023 10:03:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, kernel@sberdevices.ru,
        Richard Weinberger <richard@nod.at>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, oxffffaa@gmail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: support for 512B
 ECC step size
Message-ID: <168857288612.706374.4421201197090184183.robh@kernel.org>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
 <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
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


On Wed, 05 Jul 2023 09:54:33 +0300, Arseniy Krasnov wrote:
> Meson NAND supports both 512B and 1024B ECC step size, so replace
> 'const' for only 1024B step size with enum for both sizes.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>



