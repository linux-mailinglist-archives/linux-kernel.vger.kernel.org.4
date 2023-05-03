Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0176F55BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECKPI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjECKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:15:06 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1526CE;
        Wed,  3 May 2023 03:15:05 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-55a5e0f5b1aso30548947b3.0;
        Wed, 03 May 2023 03:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108905; x=1685700905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9Ei4eIU9458pKjl+Q1vOAHQVhwFjS/Wijv4O7V3dZA=;
        b=UYnvKE4IdOfoSSCZBKLUieqkiy5yblXhWBcGHAKmYmFxMazr1jazskY7EpKK4Xq2fl
         8kRiiC6naTH8HU3XGgRfbyK91V4G4ToGyJfrdsPV9PMu/xyhtlMMGpZ4BfLgrWtEW6dD
         yQnsoQqCr+VLCOg+fQ3p3bZz9mJ4qmyCJiFf9JujI6dwjTmOrmjfo15zKSYATcFXEp45
         54uSn+iOXIoh5A40gcVmCp0yCl/qHDWoSHgx0VXig0uIvXQAawlkp0i4d70EpNj5wQ0j
         b9c38FwIS4CEyWXhzvQEBugsvvZj6Y7VmguWR6uwC7ZrexcsdWeGbR2xz+KFmcO2uH39
         1OvQ==
X-Gm-Message-State: AC+VfDwo7qu5dbB4fncJ2Hy/+h8BcNHm6IMKTJHSo6gdNj5JxbkqvIkn
        nXF7pa7ctsEvcm71xc30JBK5FZUEwV0M+w==
X-Google-Smtp-Source: ACHHUZ6YoJDvn2lKwqaOBxilCH42V89xOozSpg7tc4F2+SJaSpGvieRF5ZnzK30qGnvpSpCSr59cUQ==
X-Received: by 2002:a0d:f4c5:0:b0:556:b11e:ec34 with SMTP id d188-20020a0df4c5000000b00556b11eec34mr19442764ywf.50.1683108904693;
        Wed, 03 May 2023 03:15:04 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id u205-20020a8147d6000000b00557027bf788sm3994773ywa.74.2023.05.03.03.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 03:15:04 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a5e0f5b1aso30548467b3.0;
        Wed, 03 May 2023 03:15:03 -0700 (PDT)
X-Received: by 2002:a81:83cf:0:b0:55c:253b:91dc with SMTP id
 t198-20020a8183cf000000b0055c253b91dcmr1626279ywf.34.1683108903696; Wed, 03
 May 2023 03:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com> <20230502170618.55967-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230502170618.55967-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 12:14:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
Message-ID: <CAMuHMdV0iZJwNDRTxZXr-Rg_=VDN1hYw2gbSwwys1EDrzgC7Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a779a0: Add PWM nodes
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, May 2, 2023 at 7:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Phong Hoang <phong.hoang.wz@renesas.com>
>
> This patch adds PWM nodes for R-Car V3U (r8a779a0) SoC.
>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> [wsa: rebased]
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5.

> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> @@ -1108,6 +1108,56 @@ msiof5: spi@e6c28000 {
>                         status = "disabled";
>                 };
>
> +               pwm0: pwm@e6e30000 {

I'll move this before serial@e6e60000 while applying, to preserve sort
order (by unit address).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
