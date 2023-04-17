Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087996E469B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDQLjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:39:40 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607E5FD8;
        Mon, 17 Apr 2023 04:38:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54c12009c30so520789807b3.9;
        Mon, 17 Apr 2023 04:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731468; x=1684323468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o06OvCm7/JJ0dOtkcNU5u/X4HgBtDN4dg1a5gDLpjQc=;
        b=TdPbjye/lB39U+WSak2xRP6UUeW+tRJt1ftK6/5Dohe9/4AhbfvnbHyToxJuqNFTOH
         g1iBUKZLhk9+f3P0MVqp/NnP8hmLgec2JNhewR5YjJ+qThy/JvdN041P+hQYrob93TNx
         92xLQf3C9bkbP3hK4o3dZh3nra34q69z7+NqkBJnuRyXBxg2KmiW5rzdmXu/iVeUH0iS
         IcDPC6ee8bYJRE2B2f+jGspauaa/R4HLkBwLYrURkXr978DazrtjADhcPJ+4D1LzSsMC
         +xuLa93vZP3sNxeJmqfrgdhSHZ/45JJpc7L0QW3KzQfTFxlO3BRc53G1auG9dSbJEFVu
         vgCQ==
X-Gm-Message-State: AAQBX9f2UJrb5Z6xi4fwg2ni3zCX6Oxs+Htke+shxGMGxbISwdm0IQh9
        tHhGWk7yECwJ/fCnxGH8thXqW1Wti34bqw==
X-Google-Smtp-Source: AKy350aTSuoDXQHgpQyjrEQVJI/6aHltteXabalU8fJhQnF2xMLDBtGzflxd0C58ewvYLtIZR+7u7g==
X-Received: by 2002:a81:d34a:0:b0:54f:9de8:fd61 with SMTP id d10-20020a81d34a000000b0054f9de8fd61mr13412324ywl.12.1681731467950;
        Mon, 17 Apr 2023 04:37:47 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cl22-20020a05690c0c1600b0054fbadd96c4sm3032782ywb.126.2023.04.17.04.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:37:47 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id l5so4582174ybe.7;
        Mon, 17 Apr 2023 04:37:47 -0700 (PDT)
X-Received: by 2002:a25:d08d:0:b0:b7c:1144:a708 with SMTP id
 h135-20020a25d08d000000b00b7c1144a708mr9361683ybg.12.1681731467399; Mon, 17
 Apr 2023 04:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com> <CA+V-a8sVjK7jm6m=7XC9B8JBeUqL+aL_wvFjM-e=-p+4xWuszQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sVjK7jm6m=7XC9B8JBeUqL+aL_wvFjM-e=-p+4xWuszQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 13:37:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1kkxaKfRJ+HbJA6nxX8x9KRsszo+Kq0g87Rf3eo0v7A@mail.gmail.com>
Message-ID: <CAMuHMdX1kkxaKfRJ+HbJA6nxX8x9KRsszo+Kq0g87Rf3eo0v7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Apr 17, 2023 at 1:05 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Apr 17, 2023 at 9:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Apr 12, 2023 at 8:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Enable CRU, CSI on RZ/V2L SMARC EVK and tie the CSI to the OV5645 sensor
> > > using Device Tree overlay. RZ/G2L SMARC EVK and RZ/V2L SMARC EVK have the
> > > same connections for connecting the CSI to OV5645 sensor so just reuse
> > > the existing r9a07g044l2-smarc-cru-csi-ov5645.dtso and create a symbolic
> > > link to this file for RZ/V2L SMARC EVK.
> >
> > Perhaps it makes more sense to rename r9a07g044l2-smarc-cru-csi-ov5645.dtso
> > to rzg2l-smarc-cru-csi-ov5645.dtso instead?
> >
> ok, and then for g2lc [0] I add rzg2lc-smarc-cru-csi-ov5645.dtso ?
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Oh wait... had missed that one. Let me catch up and get a better
view on the big picture first... ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
