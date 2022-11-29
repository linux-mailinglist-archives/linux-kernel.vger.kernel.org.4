Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC963B925
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiK2Eee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiK2EeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:34:21 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF17315A18;
        Mon, 28 Nov 2022 20:34:19 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so8361505ots.8;
        Mon, 28 Nov 2022 20:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQJriYYoXhycdFppxIrfyXtPVy4esIPKw5wab9lgd0U=;
        b=CUkrijMW5IrXJMwL0+zJUVPixrr3LQO9UL9NyPEgfk0Bf5KVaV0Mq6ozs9REarA5MY
         ZsqU0z2UN0yFFk3ImXGAxDzKb7xB5RpYWBMKO3thLVAeweFWXXSvW28mqntKw+3nIr1T
         X69mancNZKv6iHAKwRaA0Q3MxUDxQ/4rKQA6Wz65xFtSOYA+GYWUjhd7lF8WcKIzilpn
         sNO0i4Fja0f/BjBYkbMsVBhmNqINxNIWrYbwhV6/NNedznV4nwSDDarUAURAnqbga+Vj
         s3E3r1OhqzU9xvf6O2XVV63iv5qOojgggrUl6zsWhdAck5LMeV3IHF1isPys8EmafDSf
         dnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQJriYYoXhycdFppxIrfyXtPVy4esIPKw5wab9lgd0U=;
        b=SPlNWlVsJX814vZgnt6fsN82d66L8mtQ83yOKlL1lf3i2b/zaIlAYFneESI1f/Z14G
         DuN3OHOR3UQSOmHYV+fmsd/CRPyWByIL2wnUmGNcujGesAr2eXIGGDLXSpaXAnC5ahVb
         J7TtXmP6incmc3Lg4y4u4Kr9f8HjqSxe+pUZ3RYCt0XlvAvu0o6Zd9o6HCKalUK83lg1
         +7c0NMEUgKLDaMBXMvM9yqxtkNceFnzp7XHJ8Z3rc5TpVXRduHPwcGtIEWPeBHi6mAki
         wFVEUS55LCuNiXaq8sEGvKa9s23Y0AFlJoDcgvdDrpx9aHiANmLHjuKcSrWQNDH5HNYO
         ZvpA==
X-Gm-Message-State: ANoB5pmayOKfTO5ecySbJ9cmgHeXUJtl+l2cNxyjOa9196QpNpraSpPE
        e44KPBAeFn78izPjI4Exh1NFJYg90QkeZ1sPdMA=
X-Google-Smtp-Source: AA0mqf6/XYxlYHxhs9kQru0NF89/KXPCrtasB+MfuvgCaTgm1pPa8NmW29U0wOCl8i+uKDmQOI9kGcAFCxRY6MdVsZQ=
X-Received: by 2002:a05:6830:1e65:b0:661:b632:4259 with SMTP id
 m5-20020a0568301e6500b00661b6324259mr17837342otr.304.1669696459200; Mon, 28
 Nov 2022 20:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20221128213238.3959-1-arinc.unal@arinc9.com>
In-Reply-To: <20221128213238.3959-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 29 Nov 2022 05:34:07 +0100
Message-ID: <CAMhs-H_Oz_W1HWM521qS2fLj15okptQCVE1D88P=p0L31UiF7g@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: mt7621: fix phy-mode of external phy on GB-PC2
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Louda <petr.louda@outlook.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:33 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> The phy-mode property must be defined on the MAC instead of the PHY. Defi=
ne
> phy-mode under gmac1 which the external phy is connected to.
>
> Tested-by: Petr Louda <petr.louda@outlook.cz>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
