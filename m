Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679196ACE02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCFT1m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCFT1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:27:39 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079D6F607;
        Mon,  6 Mar 2023 11:27:33 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id c19so11780732qtn.13;
        Mon, 06 Mar 2023 11:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D92nMbIi4lHs3DnQywmKH6mi3CjLwh028pcMcffmjd8=;
        b=6ueZRd3NyWgcUTfMz4jzoBBMuzkknMnitCKo+3CoBcZzMU98i+4ZlANZmPLW0ug5R4
         hZRklGVozJ1cEWlQx4tbR+MsDiPb4HS927hz95sqx3cdaokDDYcoNKdLl4LHL9jhtJe2
         pSwsRd9iqIJpwOtmUk9uFwfheoxcgJS8I3BvWAFkSIFQx/3F8jXBLIbOvc6tWAM3hI8M
         aPKbJ3B7OW583+xTFr4Z+/oM6iYrtX713ePyq/HtsU6uhrQfE+eoexAMN8XgZ4pTGwN5
         zPFXEhPCb2UyZ9o5M1bcthdddklbQb0W+5FYgplysSxbxH/jTU7t7oAqqEdXTcw+/TGq
         Nc3Q==
X-Gm-Message-State: AO0yUKUsNpfEhijvVk16tQpnGsGBapwI4c10Gw1qZW/3jeoARciBjjaX
        VbxIbkaQASChHqPMDlw8UdAX9qohqkbhmw==
X-Google-Smtp-Source: AK7set/lxerxxr+Ri9uv8IXBen7Vi7vXwReecYvKWjaWuoH8qh2g9wUxpfgasCmOXhAy0l1HOeLctw==
X-Received: by 2002:a05:622a:1212:b0:3bf:d025:ca9c with SMTP id y18-20020a05622a121200b003bfd025ca9cmr20511185qtx.62.1678130852059;
        Mon, 06 Mar 2023 11:27:32 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y16-20020a37f610000000b0074308a0124asm7967821qkj.50.2023.03.06.11.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:27:31 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id i6so9299245ybu.8;
        Mon, 06 Mar 2023 11:27:31 -0800 (PST)
X-Received: by 2002:a05:6902:208:b0:acd:7374:f154 with SMTP id
 j8-20020a056902020800b00acd7374f154mr7055408ybs.7.1678130850785; Mon, 06 Mar
 2023 11:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 20:27:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
Message-ID: <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Feb 16, 2023 at 6:57 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> OV5645 sensor can be connected to the CN1 connector on the
> carrier board. This patch adds the ov5645 node under i2c0 node.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> @@ -6,6 +6,10 @@
>   */
>
>  /dts-v1/;
> +
> +/* comment the #define statement if OV5645 is not connected to CN1  */
> +#define CAM_INTERFACE_OV5645   1

I believe the camera is optional ("can be connector" above).
So shouldn't this be commented out by default?

The rest LGTM, so with the above sorted out:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
