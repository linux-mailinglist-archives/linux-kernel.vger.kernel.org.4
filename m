Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD956608D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJVNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DDE49B66
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666446610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9L4JE6hZ7E7BRXfPAr2m26KAuFLoVfy/IaYPaNDhBM4=;
        b=i+e3KgQ3bu9GFO+odJPn9e0UobVGBdefj/fLzspCzt3hXcOOfO75dBaP7di+2Vvd5/g7kt
        Lpcejxl7V3hcq8WrxNVRvy1uM/q/0S26SMKtFFOHE8qLSoTakVvCPeWRAH25cv9OzudyJT
        BYAjiAgIim2NI/Yb4fJf1A+wGijPorM=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-FpbbSkP5NwuUrpGOCmsuIQ-1; Sat, 22 Oct 2022 09:49:58 -0400
X-MC-Unique: FpbbSkP5NwuUrpGOCmsuIQ-1
Received: by mail-vs1-f71.google.com with SMTP id k62-20020a672441000000b003a762e05594so1440472vsk.18
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9L4JE6hZ7E7BRXfPAr2m26KAuFLoVfy/IaYPaNDhBM4=;
        b=eJFAdYrcn6OoxbrO4C35tODz7+SPLB6X6v0YcM2NDnah/kDN2V81sZmDY9faORbQX7
         TGWrSsjlK3nNKFe9LWUCtfYM/iwbWo5MVJP1+AXDUoFFddyzeNalLMSp/PqumpUWHDDu
         VAKs3duH3g4LDAddyouwRTdvOj8RT1RBVG3UPn5kQwwIooxp4s+C2ABIQLD01JaXV7Gn
         1+IVA6ADQu6OVXKncsOF6+hkml58AGTABE/Ibs6CUQQKiafy476gTaiCiwoL2RqVJCnQ
         Sn7rN2PIK2klWAjQvAq8N1dkY0M4EDR3SLSW7mcmdy5+RKyQFVTta5vhi/zebeOJaAqX
         x14g==
X-Gm-Message-State: ACrzQf2fj2xQCDw4MOMarOs2em2ZmY82oaYDKsYIHk6LvEfnuv+91foV
        SgRHOKp8jUPO9hcaLKBzDnYWF1WNr2PAKzuChRxmXPC6ATaq69gvZIpqHWIh6snUJELkAEmt1NF
        Uz1bA5AJzA08wi4GSDybzSSP2hNMJGVlLWCxLO1+Z
X-Received: by 2002:a67:eac1:0:b0:3a6:eeaf:bb10 with SMTP id s1-20020a67eac1000000b003a6eeafbb10mr17843635vso.13.1666446598133;
        Sat, 22 Oct 2022 06:49:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ulU5EcnN5sYdSwkk4YPB4fyn/1SpiyaEqPkdjSmKDL50inCgaVHuxtn3ot8G8PsbCohyqEeH7CEQstqyyGTM=
X-Received: by 2002:a67:eac1:0:b0:3a6:eeaf:bb10 with SMTP id
 s1-20020a67eac1000000b003a6eeafbb10mr17843631vso.13.1666446597922; Sat, 22
 Oct 2022 06:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221021235523.76585-1-konrad.dybcio@somainline.org> <cccebca9-69a9-523c-dd5e-85d17f0946b6@somainline.org>
In-Reply-To: <cccebca9-69a9-523c-dd5e-85d17f0946b6@somainline.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sat, 22 Oct 2022 14:49:41 +0100
Message-ID: <CAOgh=Fyg7nRMy2oKNgcFCqXXsxbZY1jEmXf-y-JH-P3TLTMz8g@mail.gmail.com>
Subject: Re: [PATCH] irqchip/apple-aic: Mark aic_info structs __initconst
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 at 01:04, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 22.10.2022 01:55, Konrad Dybcio wrote:
> > These structs hold information used only at init time that never
> > gets modified, hence mark them __initconst.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> > ---
> Forgot to add:
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
>
>
> Konrad
> >  drivers/irqchip/irq-apple-aic.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> > index 1c2813ad8bbe..ae3437f03e6c 100644
> > --- a/drivers/irqchip/irq-apple-aic.c
> > +++ b/drivers/irqchip/irq-apple-aic.c
> > @@ -248,14 +248,14 @@ struct aic_info {
> >       bool fast_ipi;
> >  };
> >
> > -static const struct aic_info aic1_info = {
> > +static const struct aic_info aic1_info __initconst = {
> >       .version        = 1,
> >
> >       .event          = AIC_EVENT,
> >       .target_cpu     = AIC_TARGET_CPU,
> >  };
> >
> > -static const struct aic_info aic1_fipi_info = {
> > +static const struct aic_info aic1_fipi_info __initconst = {
> >       .version        = 1,
> >
> >       .event          = AIC_EVENT,
> > @@ -264,7 +264,7 @@ static const struct aic_info aic1_fipi_info = {
> >       .fast_ipi       = true,
> >  };
> >
> > -static const struct aic_info aic2_info = {
> > +static const struct aic_info aic2_info __initconst = {
> >       .version        = 2,
> >
> >       .irq_cfg        = AIC2_IRQ_CFG,
>

