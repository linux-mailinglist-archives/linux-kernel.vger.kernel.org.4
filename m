Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC66246B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKJQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKJQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:17:45 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF0193FF;
        Thu, 10 Nov 2022 08:17:44 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id i12so1707787qvs.2;
        Thu, 10 Nov 2022 08:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MJ9qt3ttdnADO10aIiv9hXi2PKgV5UbNwkReeDt/YY=;
        b=TMJ3iNWyio12igymTw59OKOEIYnXEpFg0yLwULsCilz72B/makH/WscK6nWsJ79SC5
         XceVXbpgKvNCQL65xlYB+cVbKnS7/ywIBEKJfNTwGbrWTIanpBU+sLKUdYdojPUVV3Yq
         oMD7h6PJUQDFyi5CFvyJ4ZoRzy5GUAy2wgjYlVXbtGTVb134Jmz2ZLurI+MNSOfutzFo
         Q3y8qG1RMIwpd+vuRgiTP0Kx6H57YPwRhVHxZtvLTWnT2CZbDkYLGte6ocm2/GumevcY
         HFa4xzTWpYY5cClCN2lVckqmnpptNOs9PG051vvcWkpjJ28fbYBlZJXN98IYFq8/Cl3u
         L2mg==
X-Gm-Message-State: ACrzQf1Y+k+H5TQ+bO6W1QcmDA8sqJy/uOCZibvrrNNeAsca8uEsNHz3
        89kVEEMukB0pelZvDq1kt8aFxJH1VSSETw==
X-Google-Smtp-Source: AMsMyM6P6ucoen5GA+9JBaafD6j9HNBYX6qkCpXNQfA7gauSRfbMaRx4RmNptHs01lLPKmtSkoj90Q==
X-Received: by 2002:a05:6214:21a8:b0:4bb:e31f:12c8 with SMTP id t8-20020a05621421a800b004bbe31f12c8mr55780438qvc.65.1668097062936;
        Thu, 10 Nov 2022 08:17:42 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b006f9c2be0b4bsm13438180qkp.135.2022.11.10.08.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:17:41 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id b131so2176547yba.11;
        Thu, 10 Nov 2022 08:17:41 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr52209529ybc.89.1668097061150; Thu, 10
 Nov 2022 08:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <mhng-563fb6cf-4505-4137-8da1-13f631e1c74f@palmer-ri-x1c9a> <Y2wZvZLAENWh6qvs@spud>
In-Reply-To: <Y2wZvZLAENWh6qvs@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Nov 2022 17:17:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtq67krGy++7y+x7jOTerZYpCfcJEY+nMpW=otGx8bSQ@mail.gmail.com>
Message-ID: <CAMuHMdXtq67krGy++7y+x7jOTerZYpCfcJEY+nMpW=otGx8bSQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, prabhakar.csengg@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        anup@brainfault.org, Atish Patra <atishp@rivosinc.com>,
        heinrich.schuchardt@canonical.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Nov 9, 2022 at 10:21 PM Conor Dooley <conor@kernel.org> wrote:
> On Wed, Nov 09, 2022 at 11:55:24AM -0800, Palmer Dabbelt wrote:
> > On Fri, 28 Oct 2022 09:59:14 PDT (-0700), prabhakar.csengg@gmail.com wrote:
> > > Lad Prabhakar (7):
> > >   dt-bindings: riscv: Sort the CPU core list alphabetically
> > >   dt-bindings: riscv: Add Andes AX45MP core to the list
> > >   riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
> > >   riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
> > >   riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
> > >   MAINTAINERS: Add entry for Renesas RISC-V
> > >   riscv: configs: defconfig: Enable Renesas RZ/Five SoC
>
> > Geert was mentioning taking these though one of his trees, that works for me
> > so
> >
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Series queued in renesas-devel for v6.2, spread across a few existing
and new branches to be pulled by soc, taking into account dependencies.

> > Happy to do a shared tag or whatever, but I think we can just skip that
> > here.  The only conflicts would be defconfig and Kconfig.socs, but I don't
> > think anything big is in the works for either -- unless Conor was planning
> > on re-spinning that Kconfig.socs rework?
>
> Uh, nah. I've got a wee bit (the removal of selects) that is "ready" but
> there's zero urgency so it can wait for after v6.2-rc1. I don't think
> it'd conflict anyway. The rest of it I need to sort out a v1 of, but I've
> been distracted. Should be safe to take the defconfig & Kconfig.socs stuff
> in terms of me doing anything.
>
> Geert, would you be able to apply the first two patches on top of
> v6.1-rc1 just in case, as you mentioned previously, it needs to become
> part of a shared branch? Seems unlikely at this point in the cycle
> though.

The bindings are in the existing renesas-dt-bindings-for-v6.2 branch,
which is based on v6.1-rc1, and only had RZ/Five related commits anyway.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
