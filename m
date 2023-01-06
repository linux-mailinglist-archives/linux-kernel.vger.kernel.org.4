Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE865FC99
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjAFIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjAFIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:20:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A619C1D;
        Fri,  6 Jan 2023 00:20:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z16so620528wrw.1;
        Fri, 06 Jan 2023 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d7uAPc5lV4BAkd0Lt50ZSuuOGeFfN66YKgz3Zf+2KBM=;
        b=VHwkfcrVl2FfVTrKkxC0HzjPtyZ9CGNZpbIlOZe6SsFxMv2z/OFxd4MKNvDnKOzFfu
         ZJ3oDzzoxycdiEGI12BPRrXF4sQFxCCH58MkY8isbgq+azciqbC3m+PsS7ooUHxQWXlZ
         nMIKuTmjWZ13hH4a/c5AVYp3+zZjTxXpNxuM02i8LSGhj1LAxwlzCaY4cpHaJISi2fS9
         8z6g/HuFW6ZqqJ6fBIa/IbK/WHWC0l/P8/mK09kXE5AF9P5wHPopv9LoJjKcd+/xUcwB
         vMP/zcpAN2vRlZgxangN7ND+fsmHpfC9yo37R5sX9Y3BLPZ116fwdzMqBKBZtV+8t08i
         SkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7uAPc5lV4BAkd0Lt50ZSuuOGeFfN66YKgz3Zf+2KBM=;
        b=Y0krsvtDENaupdyuQOkS8nMMhz9N021QOES8lTiWRoR2wp6eqtWswQFZfXzB2QQ27y
         Bm6pGOU8BUKb+W+t/7NleKZhM78qq76oVnI6p2acpXepW6ZuUNGBZ512uI5cI/rRFBSX
         xz1yrxolAGwW8rSWjFjyUX+6AqjjQmy45y6Fcnuiad6XQZrKSx9dn28s7k3GCHoaif7g
         Pm3NTHNJrLZVgdkXxOHg8FqPN4BjzdAvYpHKemqMvI/DdMm8LYGW1/jvFrT2zxWGEZp9
         mgU8xIbEqEatki/6RKruoJ5iRWQ3g5R+sa8D+D2rmuQt2F7b6sHv4VL/OQlvy0S51f3x
         fP1Q==
X-Gm-Message-State: AFqh2koAsEjtpQ1sr36QqV9HvRtwe1e1T8mRkY+PMonV3pAkP4A2JYU+
        7Dn4Vr5Vnq1PgtaCqT/YwCY=
X-Google-Smtp-Source: AMrXdXsSaZlnxU9wTK9Z3PLBDtebM5hY+mqg71s24qvIEUMA2DyDyulvecJ+TT82vQmAzLouQez4aw==
X-Received: by 2002:a5d:67c3:0:b0:2a4:bd16:2931 with SMTP id n3-20020a5d67c3000000b002a4bd162931mr6152301wrw.62.1672993222223;
        Fri, 06 Jan 2023 00:20:22 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id s10-20020adfea8a000000b002421ed1d8c8sm434978wrm.103.2023.01.06.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 00:20:21 -0800 (PST)
Date:   Fri, 6 Jan 2023 09:20:20 +0100
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
Subject: Re: [PATCH v2 1/3] dt-bindings: crypto: sun8i-ce: Add compatible for
 D1
Message-ID: <Y7fZxAl8WwVztDj/@Red>
References: <20221231220146.646-1-samuel@sholland.org>
 <20221231220146.646-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221231220146.646-2-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Dec 31, 2022 at 04:01:43PM -0600, Samuel Holland a écrit :
> D1 has a crypto engine similar to the one in other Allwinner SoCs.
> Like H6, it has a separate MBUS clock gate.
> 
> It also requires the internal RC oscillator to be enabled for the TRNG
> to return data, presumably because noise from the oscillator is used as
> an entropy source. This is likely the case for earlier variants as well,
> but it really only matters for H616 and newer SoCs, as H6 provides no
> way to disable the internal oscillator.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> I noticed that the vendor driver has code to explicitly enable IOSC when
> using the TRNG on A83T (search SS_TRNG_OSC_ADDR), but that is covered by
> a different binding/driver in mainline.
> 
> Changes in v2:
>  - Add TRNG clock
> 
>  .../bindings/crypto/allwinner,sun8i-ce.yaml   | 33 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
