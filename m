Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C16A1A22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBXKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBXKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:23:46 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851A515C6;
        Fri, 24 Feb 2023 02:23:17 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id h17so3350805qka.11;
        Fri, 24 Feb 2023 02:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGBD2d67JCADOb9eMaZzaB1HzQKF2jV1ge5Xbpj5Io=;
        b=EjrbzsXFo67ShH2gb3/eDmC4uQPoNqu7H3Pas8D+AX5ClMSoIaq9DhVmoXWirM+LtT
         gd4+iHcW9hiRaYKlBwtkclJQK8JckpdCsHvNGoqMTXDYXVSxVRwC0ZvhEjBd4D3dKiLo
         LYGT50iXGzzGbqrEhljlmYoEPziTe0uJbn45oGcYOYkuIHsw5I83h9QYGgVZWYbEXOIC
         TlGN6qpE4Wet9SLL2TVX1YrsHzCJiwx1+hbS2U/ZA0Coap95y4adMjfmLtPoyJbZXn9V
         CTZrjkGPKiRSAB5STgMcoCBtwz9H/N/I05pbLdAvoDO7DGCV9F6HkegPxxuvulp2L/se
         B33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcGBD2d67JCADOb9eMaZzaB1HzQKF2jV1ge5Xbpj5Io=;
        b=Hw72ETdVKcpzFaiVkhx19VDOmMQFJm0IdayWmrtRRNRpVE9bFlkkwrXpoPnRb78OIm
         19qCDBBcjI6gHzm5b4hRD6/5Z19TzrcunGhu3/F17spHFUt4jEf6uTWGoGqctzkcMUY9
         dVfhSKuzeGXGhd7eU1Ih+il7ImiJzXEupisTQWHgr8dJp2SCitlXM2FV+IrImAjMLq4Q
         9I3WL5FnYlHYVpvfvRHocwPAqIfayf+O7KqkeEbznauwIgNBsvQYtH08MUyZcpIl/HRU
         RtGeEUpY71Abpg2pLvRImb/wkmMSUQW0eL8pejBPnvxBew7iZF6BnWRDsi7uZUGjO3xs
         U6Dg==
X-Gm-Message-State: AO0yUKWiUEmXgPeVmRv3tRCqCyTX8zqgQwgaHpsqRf0IH+Xvlz8rTt/N
        hfIifW4bbWFCe4Tx2QuJOm7d0amYXqe2nzPCfRw=
X-Google-Smtp-Source: AK7set/ZPTLStcBLfI6lLQB+9y7cji1KLv9nwniOyhFp8+NTqYn5bgDB+wicDb+Rh8uOhaJZ4xEKLDOx60AchxlEx9k=
X-Received: by 2002:a05:620a:2142:b0:71f:b88c:a646 with SMTP id
 m2-20020a05620a214200b0071fb88ca646mr2811768qkm.13.1677234196928; Fri, 24 Feb
 2023 02:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-23-victor.shih@genesyslogic.com.tw> <9841589c-757e-ea01-0c55-abe4a38fae03@intel.com>
In-Reply-To: <9841589c-757e-ea01-0c55-abe4a38fae03@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:23:05 +0800
Message-ID: <CAK00qKAAQhxBfFUmtb7PE61EqL8k4ATWC9As1tDn3vCzVe=gqA@mail.gmail.com>
Subject: Re: [PATCH V6 22/24] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
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

On Fri, Jan 6, 2023 at 5:31 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
> > to enable UHS-II support, at least, on GL9755.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index e5f64b38e339..4aac22b58d79 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -728,6 +728,7 @@ struct sdhci_ops {
> >       void    (*dump_vendor_regs)(struct sdhci_host *host);
> >       void    (*dump_uhs2_regs)(struct sdhci_host *host);
> >       void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
> > +     void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
>
> This gets called already in "mmc: sdhci-uhs2: add uhs2_control()
> to initialise the interface"
>
> Either move that line to this patch or vice versa.
>
> Please check compiling after each patch is applied.
>

I will update it in V7 version.

> >  };
> >
> >  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>

Thanks, Victor Shih
