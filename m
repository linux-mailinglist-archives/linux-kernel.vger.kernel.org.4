Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5445B3617
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIILNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIILNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:13:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190EC9F0C8;
        Fri,  9 Sep 2022 04:13:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c9so2154476ybf.5;
        Fri, 09 Sep 2022 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gmp0HKBH5+KYCw+NJuLL3WyMUpUJK+zAtsC9QZ5RPFQ=;
        b=dg5mwnKF3yovtERNp4+A0F+Tm2R2x8L79smsmD5SvCY1hPLO/quY8DBPLTA9k4BAbi
         4zv+P+MClaRnezy0Y0HWE402hf3SjjjQ2NXNLzdU8JUYeJqhi8P3lXNuJmARoN6mMgbG
         Qzz5OPdOF0Kkm0RnmHivlIaOwso3tLF0FsIGRiASpHQPuGFyMczmaRX+JcRPiNpX+b3Z
         IkXDtHR+Tkfu1SLOgFSFCPgKfVYdxrDdSbZCDPWDSybS3s5/dhfLvXar1pWid6nIKmzc
         xy1v6qcv3BvH0eW3LbYh1lJTF0wOgLD66+wJ/u+BWTAKGfJsc/hfrofzXVr4rub/tVXi
         hV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gmp0HKBH5+KYCw+NJuLL3WyMUpUJK+zAtsC9QZ5RPFQ=;
        b=aHTgzLuhPuG/bOUVQWRM3ph4ZElElNKMmNJ9dUMtsi17jXnJEoOUDI2CyIqSUVSR46
         +ezNwI9jjANR1S9eqyj1uhmULPtPZTiBSePcMe2y1Foi7tVVtr57BpAN0J3iqkajNE/P
         tqXSfBlblvYAwqh2v6A32H73g/Cpcr5fg916+IUUY6EQjWYcNNOb7QjkINYdZFHDg86x
         Ih1ZyOG8BfhzRwh2Yv5LGThH6rbW6sHNpk8jkiUgm0dIshI0gmlNjjW2V42t9DnfEfXs
         dsrvcIR6d2enkbcOXhnTZYOLAYhGFImm+t8NG6s+vR2BiFbNfnS86TSbkbj7ZPBlI4Fw
         TiVw==
X-Gm-Message-State: ACgBeo3pjneEGKHziG6qOuNRwQSay+hwFzUQakl8MbStOuHmrFGdz7G1
        G8UAznO4UMhDkC9iyvqGkzF+vA7ce1h5Vcwoojc=
X-Google-Smtp-Source: AA6agR7DEm+hf2rkuJd8OwC/lCqHve1KyOzzsWxcuFa4eCXvbO+BjFrn9/cdm4E2wIFA/MSJD8ad39r3UhaoFC4ax8s=
X-Received: by 2002:a05:6902:89:b0:695:7ed0:d8cb with SMTP id
 h9-20020a056902008900b006957ed0d8cbmr11198174ybs.77.1662722025136; Fri, 09
 Sep 2022 04:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com> <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
In-Reply-To: <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 9 Sep 2022 13:13:34 +0200
Message-ID: <CAKXUXMyCvnye2f-HWsi8vYEyxe9_SC_BaR_SeLR+2wZJ__maNw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of
 creating a PPC dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 1:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 9, 2022, at 11:03 AM, Lukas Bulwahn wrote:
> > Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
> > PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
> > that all architectures simply select this config when the architecture
> > supports using the PATA_PLATFORM driver.
> >
> > This is properly implemented already for all architectures except for the
> > powerpc architecture. Implement this for powerpc now.
> >
> > Adjust the config of the powerpc architecture to use the config
> > HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
> > any specific architecture anymore.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/powerpc/Kconfig | 1 +
> >  drivers/ata/Kconfig  | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 39d71d7701bd..2575e21b6e6b 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -237,6 +237,7 @@ config PPC
> >       select HAVE_MOD_ARCH_SPECIFIC
> >       select HAVE_NMI                         if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
> >       select HAVE_OPTPROBES
> > +     select HAVE_PATA_PLATFORM
> >       select HAVE_PERF_EVENTS
> >       select HAVE_PERF_EVENTS_NMI             if PPC64
> >       select HAVE_PERF_REGS
>
> I don't see a single powerpc machine that creates a
>  name="pata_platform" platform_device. I suspect this was
> only needed bwfore 2007 commit 9cd55be4d223 ("[POWERPC] pasemi:
> Move electra-ide to pata_of_platform"), so the "|| PPC"
> bit should just get removed without adding the HAVE_PATA_PLATFORM
> bit.
>

Thanks for your investigation. I will send a corresponding patch v3.

Lukas
