Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05674C9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGJCbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGJCbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:31:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CF120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 19:31:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7836164a08aso206389239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1688956298; x=1691548298;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isa1f9w1YAsa/74wPYj1r7q419fkTN20HLg99m8qpkA=;
        b=mFZswzl1RlYTs5AWE7GDCCo8UVeEYQHjmFqzYJvYIsP9YMuHde68KL/MO7BqBcUs/j
         Pfzss9dd27Rtu2QxNSq2/ln1Tiw6onWpGNqqXRmuhRsF5e2kMlap+MwafD+AOmyaNKQV
         xpc3XiDHGoY7NpSuxiw+Pz7ZiLl4J0gpyyzJk53/6as1xrky1yiyQD/0xaggkQGBNjag
         jiOx4qPqZgfzq+mITWOrHXZ+nrFYZUNpUzarzlulx3EpWianmMztR69VqOnNVITIEh6I
         29bs54tp8g+FIUEznagf5oxQZ6oiGB/Q8Q4/S50hOPUDw8Imk+dmex1pD+JYEWi9GXfX
         npQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688956298; x=1691548298;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isa1f9w1YAsa/74wPYj1r7q419fkTN20HLg99m8qpkA=;
        b=XT1ADcNFobilGglOUxrHYe34kQUzDz4Uu0dGNuuzJ3KO2GeoGcgKvG7V8hp4iHs+oB
         RPmM+gEznYmSBKweVWftV/l4eRMD/47rpyOtDgZ0DrNg+0QbVxwP/0lpaInHdi50+MI6
         roqXW9XUyoB/zyYjK75jRj/AnRMiN4bz5NRl8nWvbTITJFAkrTbZ3ZbTu0PQW5RuNI+0
         2d60VyWC1IUEmR7SZArnUJ0bsFo6vdiMjQW+hbXFs40PvueUc+NvfOUuk0bzjW/2757V
         SRlQogqdb5nmCQM9MzdWz6Qix1rwx3NRIluJLFDWF/6wH6qAa9HS5uUx/WlzHLHfSDCr
         aitQ==
X-Gm-Message-State: ABy/qLYKFHyxYnsFUd2xXdDN73R0jriIOpvsRmnR5v1sqF+15oxIYCKH
        BucZfaIMD4RVfl9uR0Y37s6hFNxWT+jaUyZG3ur3aw==
X-Google-Smtp-Source: APBJJlHgTcZgGKu2YLtJ/MiJvLEIkJ1ajhXWgPkh99DKnAUjWAuEsY9txbdl4fQ7dZ7Xh/t9mtEv/crQbRLZf49CcKE=
X-Received: by 2002:a5d:898b:0:b0:783:67a3:a69f with SMTP id
 m11-20020a5d898b000000b0078367a3a69fmr12969071iol.18.1688956298607; Sun, 09
 Jul 2023 19:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090141.23546-1-zong.li@sifive.com> <CANXhq0rVred1YMcV5449yYt+MhOu2NUx9Oa-1xJqbS=o_1Qb6g@mail.gmail.com>
In-Reply-To: <CANXhq0rVred1YMcV5449yYt+MhOu2NUx9Oa-1xJqbS=o_1Qb6g@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 10 Jul 2023 10:31:27 +0800
Message-ID: <CANXhq0q+tkM=_C5gJq1Hv-uMx_ihiLLYyYgvJNAAMA=9SRurAg@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: xilinx: dma: remove arch dependency
To:     vkoul@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        radhey.shyam.pandey@amd.com, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:54=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
>
> On Wed, May 31, 2023 at 5:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > As following patches, xilinx dma is also now architecture agnostic,
> > and it can be compiled for several architectures. We have verified the
> > CDMA on RISC-V platform, let's remove the ARCH dependency list instead
> > of adding new ARCH.
> >
> > To avoid breaking the s390 build, add a dependency on HAS_IOMEM.
> >
> > 'e8b6c54f6d57 ("net: xilinx: temac: Relax Kconfig dependencies")'
> > 'd7eaf962a90b ("net: axienet: In kconfig remove arch dependency for axi=
_emac")'
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Suggested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >
> >  Changes in v3:
> >  - Add a dependency on HAS_IOMEM to avoid breaking the s390 build
> >
> >  Changes in v2:
> >  - Remove ARCH dependency list instead of adding new ARCH
> >
> >  drivers/dma/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index f5f422f9b850..fd5a94e67163 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -696,7 +696,7 @@ config XGENE_DMA
> >
> >  config XILINX_DMA
> >         tristate "Xilinx AXI DMAS Engine"
> > -       depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> > +       depends on HAS_IOMEM
> >         select DMA_ENGINE
> >         help
> >           Enable support for Xilinx AXI VDMA Soft IP.
> > --
> > 2.17.1
> >
>
> Hi Vinod,
> Linux 6.5-rc1 is opening, could I know if this patch is good for you?
> Would it be considered in this merge window?
> Thanks.

Hi Vinod,
It seems that we are transitioning to Linux v6.5-rc2. I'm uncertain
whether you consider this a new feature or a fix. Is there a
possibility of incorporating it during this cycle? Thank you.
