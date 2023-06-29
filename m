Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB085742A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjF2QTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF2QTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:19:10 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F3CF;
        Thu, 29 Jun 2023 09:19:09 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7835c92c373so20254039f.0;
        Thu, 29 Jun 2023 09:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055549; x=1690647549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzFF9iYtdArZX/WdIkxczovu3b9psWf4QpXmpxsWlSo=;
        b=KnllrfWaCdmarRCJccQBr3cKLNnS3nGkrB+bmz4fkovJOHBLF9WyylEBjR/s1MSVvP
         sIhH4ox9yFS7iKAkA4zdWYgzgjkIdRxuG/2G4vBz/I1B6oi9ncY3l7dt3XstjashAHTR
         t1y1j+JFekQBs2MzFXnB2uWGij/chV1+6+hVLdylDjBoUZEdAmhiB+e6MizYWA6RBT/s
         PihK/Yfr2NHhsc4scSvecHTKqabGOrcWeOzbn0A/F7rtJwt5fFyCJnYWLz+rUBqBJwhb
         mAMDPjOQTo7jZCJdFEmqz1Mdm5WWCNBZvWAvgkXKlbqLpDT+9s8BpO7gpYLV8ETRzfME
         u7yA==
X-Gm-Message-State: AC+VfDwk1Tl/UH9rSac97lCd5wdmTcC75wAEP2OoZUe52u7VI7BtZMez
        1MkVViyQ+RCx9hLmvhuUBJKGi2EjcA==
X-Google-Smtp-Source: ACHHUZ4Egtuwpgl/FjmgbZkIkLAoLebxcaeXSSJQrI05xRI+RigHebzty+j+IJ1GFKNXMDPF6py4fw==
X-Received: by 2002:a6b:6106:0:b0:783:6c18:1e97 with SMTP id v6-20020a6b6106000000b007836c181e97mr302767iob.8.1688055548803;
        Thu, 29 Jun 2023 09:19:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v18-20020a02cbb2000000b0042acf389ac8sm2538540jap.130.2023.06.29.09.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:19:08 -0700 (PDT)
Received: (nullmailer pid 3137121 invoked by uid 1000);
        Thu, 29 Jun 2023 16:19:06 -0000
Date:   Thu, 29 Jun 2023 10:19:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liang Yang <liang.yang@amlogic.com>, kernel@sberdevices.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, oxffffaa@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: nand: meson: support for 512B
 ECC step size
Message-ID: <168805554569.3137064.405254444310669508.robh@kernel.org>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
 <20230628092937.538683-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092937.538683-2-AVKrasnov@sberdevices.ru>
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


On Wed, 28 Jun 2023 12:29:35 +0300, Arseniy Krasnov wrote:
> Meson NAND supports both 512B and 1024B ECC step size, so replace
> 'const' for only 1024B step size with enum for both sizes.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

