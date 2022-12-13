Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A564B162
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiLMIp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiLMIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:45:18 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095919C38;
        Tue, 13 Dec 2022 00:45:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s9so10990903qtx.6;
        Tue, 13 Dec 2022 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qunzpz+8RxM5VKKxITd78CGRSvp1q8xv8RXascEDXK4=;
        b=LZ3Hl+lV4UhrIkWV7r0jHlJt+UatC6YGJU5EpWpYSljXC8G2nPrnxP8m2wZ4W8dI6t
         GP7Z78SJhsnYDmRnlXVNFv/HjcjKm30Jsl8rA1k09x2r1meekMocV1vjQMOm1Z/6Quke
         npaWcc5XVUYw4nTltf9YxGBZj5vy4h/pDTKMmm5LhYQGX4tBqLYYB0c38pgmX7BJu5pQ
         sPfAl9nLnxiCYulwSuow9batDJfjUdmn0mkKkkzJiw7BVrFXdI8OjAj5VXNx7iqtR7j3
         eQgEjRB3JRE59DqGO9NCQqHawgP9va8kzRVCyMK3KZrfybSmEDtw2t7f5mm4sI/DC14k
         i+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qunzpz+8RxM5VKKxITd78CGRSvp1q8xv8RXascEDXK4=;
        b=cYrkjqmJdPvsgnwEOfiPaXYLFmVRXTXabo3Gk8SNgbmqSj3f3ZdxkyeBSq2WkWd7p3
         XWmgv5nC66hxgkMYDgpzBYWEt93iGsL+XttTqJNLZ/tfU/v77xk/SOH4yQd9wmG8YtLr
         B4RQkJsxcPlTCOOqSlZYHoW4T5/eKP0+2qgVnbM1tAdmJ58QeC7HH4ohh5ppWS3VU+Y5
         b54j5+HtrxInShM7nRXp3j6+IaQFpP9TJfSHtqXVjmSrk5WV750AgxmCQlLXIldpJQnb
         1CvXuCk54W0wTRvYtz1MbpTuixlwQWhj4X0Gr333qioytCaSZGdXr07W1mQJx23c18Az
         BJmw==
X-Gm-Message-State: ANoB5plaHciDrb9FM8gzfcbFATglhyEsS+nv5pGPAEzmtRdzxB9TY6ZC
        Ypg2cEJQuAgbM6mdLbp/G99D4gyDln3i5z02epA=
X-Google-Smtp-Source: AA0mqf6WkrRL8MOAIN1lQa55gAHCevM/3twrGECeV38Usd6MWkgxQ+ExyIe+7ZayEFVWZn2nBXvlxLjDTGC8q7GV8lg=
X-Received: by 2002:ac8:1109:0:b0:3a5:ef4:675d with SMTP id
 c9-20020ac81109000000b003a50ef4675dmr73815700qtj.409.1670921113477; Tue, 13
 Dec 2022 00:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-8-victor.shih@genesyslogic.com.tw> <b807fa2e-78e4-cb32-cd2b-3a4d90eced08@intel.com>
In-Reply-To: <b807fa2e-78e4-cb32-cd2b-3a4d90eced08@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:45:01 +0800
Message-ID: <CAK00qKBmaKZjSTTrhFG71nCrGBtx9FqbS0BMbKJVkvg+DjTwpQ@mail.gmail.com>
Subject: Re: [PATCH V5 07/26] mmc: sdhci: add a kernel configuration for
 enabling UHS-II support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Nov 2, 2022 at 1:12 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> > in the following commits to indicate UHS-II specific code in sdhci
> > controllers.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> Please merge this patch with:
>         [PATCH V5 09/26] mmc: sdhci: add UHS-II module
>

I will update it in the patch#8 of the new [PATCH V6].

> > ---
> >  drivers/mmc/host/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index f324daadaf70..7e53cca97934 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> >
> >         This is the case for the Nintendo Wii SDHCI.
> >
> > +config MMC_SDHCI_UHS2
> > +     tristate "UHS2 support on SDHCI controller"
> > +     depends on MMC_SDHCI
> > +     help
> > +       This option is selected by SDHCI controller drivers that want to
> > +       support UHS2-capable devices.
> > +
> > +       If you have a controller with this feature, say Y or M here.
> > +
> >  config MMC_SDHCI_PCI
> >       tristate "SDHCI support on PCI bus"
> >       depends on MMC_SDHCI && PCI
>

Thanks, Victor Shih
