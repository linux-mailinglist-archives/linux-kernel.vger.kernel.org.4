Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D671902B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFABsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFABsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:48:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0A121;
        Wed, 31 May 2023 18:48:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565ba53f434so2749537b3.3;
        Wed, 31 May 2023 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685584096; x=1688176096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY1NjF/V6GhOX2EI20En2QzilopBHJEYIzNYU2d7hhU=;
        b=fZQdaiqWSF7qZENcsyoeFdPGx4MxvvCB/SIYpzFCyGSx8wiBJWk8n9J49+Z7hD+PDA
         XPZGr9kegDQVl6+46TF1v56e+nmGSrnrHneSAqNWxkAypz7TJsy/z5bpqS6PJ/sigW4q
         Z8Pj9wfqkanMlvwntShGtlO1sT9UnDV999n/uy6iCcS2xe9WdIRBmGe3Kms1Ix+OiK6y
         ktnTbL+m5U1fWjjFhwv38Nl/MiorR3ucegi/A8jYsF9P6Pt46PxCKAjIXNEH/zi8QTsy
         Pc22rLhT1egDOyPrOo3Nh0oOwcA7Sdlx9NMUR3jKAKSmUHIy3fp1iV4raYj92VcUMyq6
         WfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685584096; x=1688176096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY1NjF/V6GhOX2EI20En2QzilopBHJEYIzNYU2d7hhU=;
        b=kadp28lhNP2xp6mgcSqxjc2gBylqER4PRXSz6SUvPPUkPtMID+zR/KSTWDWdDP/GRM
         h0XsXHAIPDiZoytEujtC9osh7NulcOC8F0x16e6XJ+Ap7am3YjkjLoMlxd5y4R5jQdd7
         fvvxqS8rvxIThl8/hp+JzOWTlGsOEbPvAa+8zgUn9BJljxSiOJa3bjHx3ebip3qtkCQy
         wpgu2a7r6aOpyWP2zHh4ltDRNaNi1bv4QedA+ic1QX0NQ/C1YH/3n53TA3fWsw6t6g/P
         tdle6bkbR1s7PZPJOjPqg1zXYLCtizQfFGYI7y1mVElp3E7fhYugJz281DWDGt4cdP0d
         Lrdg==
X-Gm-Message-State: AC+VfDwxekK4jWc3PJtqZbpqbzRzB3tM8gBNqG0tfQV9R30QAS4NowFd
        KerlBt25dhAwRizFqUKRz8XeNF7UHStFArxjM4A=
X-Google-Smtp-Source: ACHHUZ63xTOkFiXkoWRROMcB816Q3bSenq3egQfU//EAicHZ0hpIh5meyG4Jo9xlTtR1/42XWJGs78uFYBKAI6rI8MM=
X-Received: by 2002:a0d:d741:0:b0:565:dff1:d1e2 with SMTP id
 z62-20020a0dd741000000b00565dff1d1e2mr8584151ywd.18.1685584096224; Wed, 31
 May 2023 18:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531111518.396868-1-victorshihgli@gmail.com>
 <20230531111518.396868-4-victorshihgli@gmail.com> <55a83234-afa9-12de-d366-961b6909efaf@intel.com>
In-Reply-To: <55a83234-afa9-12de-d366-961b6909efaf@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Thu, 1 Jun 2023 09:48:05 +0800
Message-ID: <CAK00qKAW_Daihb-G9FP+Ldw3hPOUqEMF6_2R76zUi-KUY5_kzw@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] mmc: sdhci: Add VDD2 definition for power control register
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, May 31, 2023 at 9:27=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/05/23 14:15, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add new definition for VDD2 - UHS2 or PCIe/NVMe.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index f4f2085c274c..140a0c20d4f2 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -100,6 +100,14 @@
> >  #define  SDHCI_POWER_300     0x0C
> >  #define  SDHCI_POWER_330     0x0E
> >
> > +/*
> > + * VDD2 - UHS2 or PCIe/NVMe
> > + * VDD2 power on/off and voltage select
> > + */
> > +#define SDHCI_VDD2_POWER_ON  0x10
> > +#define SDHCI_VDD2_POWER_120 0x80
> > +#define SDHCI_VDD2_POWER_180 0xA0
>
> They should really align with SDHCI_POWER_330 etc
> above as they are all from SDHCI_POWER_CONTROL
>

I will update it in patch v5.

> > +
> >  #define SDHCI_BLOCK_GAP_CONTROL      0x2A
> >
> >  #define SDHCI_WAKE_UP_CONTROL        0x2B
>

Thanks, Victor Shih
