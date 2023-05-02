Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96D26F440B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjEBMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:45:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDB103;
        Tue,  2 May 2023 05:44:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b7588005fso2978381b3a.0;
        Tue, 02 May 2023 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031499; x=1685623499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ySYJlTGoivPIC1fZq21ZetJk8Jlo1cqjNqLD3csp6I=;
        b=F/au09ewfQJ0ENuPr1s5Da4CfGnxUpQXrqQXVTlH0FSVwjo4FngZcv9A6xuNdPpk4w
         gi2HrfEaxAG3mlXFS7/WftW+ikJT1MIwalN2/gp2wc/97fMc3iicK2IRPDF5Q+XJN7Nx
         x/9OU1WSBe1AgnZG1DgyK92DAjXv0ywqLVR9wpw+sBSc5w6yz0bJ5ajkk1Siwv1ALgD1
         FvG7qy7cdRxxy412fOPEOzfXUR+jMgcmDhiwddZfX9pCVzbgZezCrIcDrvMDHvnVBiDS
         /mNcib9mGBqaqlj5vffRNOwexTQG4jcUOrX37QmoNuFzKmwbKiAoB6IIGrgrbBoG12y9
         Feug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031499; x=1685623499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ySYJlTGoivPIC1fZq21ZetJk8Jlo1cqjNqLD3csp6I=;
        b=jfwJfE1qkfYSrIqMXQnlR9ukT1FW7OqDbTtRH77wa1zaqq0JG8EP1pvmQWrN0DNUzP
         vON4K/Udr4AF2QF8n6ZoRITkt/2pSVtTzLMtuoaYfD++qszlpJuTn3VH4HvjSNBjwc1F
         RhlVA7/NoSlQ2T/9LBe9nm7L/EADLGdr1u67EqvPFcxZya5PlbwMwoN4iPSHmxu/p2MP
         RHD7wXorxAWY9iyR4WKAjvm3XTn0voUcZlHOq3+2xa4IB3PqqDRsy/lb4H4XJ3i3M6E/
         JnGqTMMvXXKAY0AF6e5ydzk9ta2YJGoDDW8jKymJR8++CAv6pAxNZ3bTQ3pcUwk5IJ0F
         r6fQ==
X-Gm-Message-State: AC+VfDwAVtjGisgiVBCHW+2jhhOm+P0T7Ee62QtrMrJ1+FNA2qYx59sW
        x+sPfX0SNkjcWOC2fHwlLIE=
X-Google-Smtp-Source: ACHHUZ6SMTxteP+9Qd5Dins2aBjFT1JCB47wUqc5JYnqbgdgAF3WIqCIzVuGULGKIMfsn8vWAdSfcA==
X-Received: by 2002:a05:6a00:2485:b0:641:4d30:7922 with SMTP id c5-20020a056a00248500b006414d307922mr14315368pfv.4.1683031499107;
        Tue, 02 May 2023 05:44:59 -0700 (PDT)
Received: from Gentoo (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id o23-20020a637e57000000b0050bf1d1cdc8sm18588053pgn.21.2023.05.02.05.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:44:58 -0700 (PDT)
Date:   Tue, 2 May 2023 20:44:51 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: display: novatek,nt36523: define
 ports
Message-ID: <ZFEFwwU9_h36xFvd@Gentoo>
References: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
 <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:00:36PM +0200, Krzysztof Kozlowski wrote:
>      description: regulator that supplies the I/O voltage
[..]
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    required:
> +      - port@0
> +      - port@1
Konrad has added a single DSI panel to this bindings, so we should
drop port@1 to allow it.

See https://lore.kernel.org/lkml/20230412-topic-lenovopanel-v3-1-bcf9ba4de46f@linaro.org/

> +
>    reg: true
> -  ports: true
>    backlight: true
>  
>  required:
> -- 
> 2.34.1
> 
