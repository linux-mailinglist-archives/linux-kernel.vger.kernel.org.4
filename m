Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9765FC94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjAFISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjAFISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:18:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ABF19C1D;
        Fri,  6 Jan 2023 00:18:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so3038156wms.0;
        Fri, 06 Jan 2023 00:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtUcosCaiFsfOQ0fA0ahQY5pppeLiBLD4KCC5VXYb5U=;
        b=icRvW+Tr534VNRNBW5UTaAWPROkQHPaEQX/kRQllBk4WaLtMTbOvvt2+5GkqGvKwjk
         HMWXJQY72dSisDrmj5+XPNK4An0gYEbTyo1Izuw28K9NsQ1ZzJiOBh/qYCMC82mT2dSa
         XxZJloj1ZfhjaHunElL4zXEeJoKkxP22C9aR3f0QPYlooVtja02LbDwx367DjGDivev0
         N4OX1MHSB/+cUvxZOURfVofVvz6++3NbyK3W9oy7XmrqvQRpAdiOBp7pTKW+XHTtBPOf
         DULzmHwJkBrQkDOXKCCF4w4d0EJsgRIubwO9B4upphDSzYAyl7RBPrAww4OFbHh37aJR
         lIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtUcosCaiFsfOQ0fA0ahQY5pppeLiBLD4KCC5VXYb5U=;
        b=XGZb9G6uHAzwgan208fi3gXXph8rQ/y7yvJI1fZXfZ43CqxAgMgLS2QT/l+1GozXXO
         mgxiQMR9wN0+Qh7gtbU2rP5XpUR582I+Tf5Ox2Sd/mu5vm0lxAMyH3U7+s8lvIy9Wa7F
         UGG67sfE5oHaI+stQwRP3ZY4XgBoRT9JXpFR7CBHL7315Deq558HxtS43fZkMLfzbdNe
         vTK5LJfu/fjsKM3SIVmYPWTY8rffn1WWzlz+FHO4rbWTi7aW7DowdmlYO69M6sSgrIib
         W3xrR0zGSkMIUrrJYM9WJ8gGNMjvjOUjZ1anWKo0wjYEL4XzFoTs7FVz64VII9df7ocq
         BeUQ==
X-Gm-Message-State: AFqh2krh5c3peej9YKcqpPkuVbscKsNUopxXxVk39sUk00NloUAi5c0G
        VmwNU1wFPfsDkKSyK5DlA1I=
X-Google-Smtp-Source: AMrXdXvsRPiGLVmsJAtakcDFnG5+z9snPhbHZVsbxbv8NbhCBxCcgQosTNbJtylk0gcVpgxRnvAITg==
X-Received: by 2002:a05:600c:a51:b0:3d3:513c:240b with SMTP id c17-20020a05600c0a5100b003d3513c240bmr38839263wmq.7.1672993109084;
        Fri, 06 Jan 2023 00:18:29 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id o21-20020a1c7515000000b003d995a704fdsm797856wmc.33.2023.01.06.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 00:18:28 -0800 (PST)
Date:   Fri, 6 Jan 2023 09:18:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] crypto: sun8i-ce - Add TRNG clock to the D1
 variant
Message-ID: <Y7fZUDSWaZhpL0hc@Red>
References: <20221231220146.646-1-samuel@sholland.org>
 <20221231220146.646-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221231220146.646-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Dec 31, 2022 at 04:01:44PM -0600, Samuel Holland a écrit :
> At least the D1 variant requires a separate clock for the TRNG.
> Without this clock enabled, reading from /dev/hwrng reports:
> 
>    sun8i-ce 3040000.crypto: DMA timeout for TRNG (tm=96) on flow 3
> 
> Experimentation shows that the necessary clock is the SoC's internal
> RC oscillator. This makes sense, as noise from the oscillator can be
> used as a source of entropy.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
