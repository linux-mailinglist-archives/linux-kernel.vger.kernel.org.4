Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B025E6F1328
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbjD1ITZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjD1ITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:19:21 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA12735;
        Fri, 28 Apr 2023 01:19:17 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1879fc89e67so6344115fac.0;
        Fri, 28 Apr 2023 01:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682669956; x=1685261956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32SVb4nZWg5Zd5LVG7qY5JY+5EueYLDPSaxp0RwjSqo=;
        b=UHxZ8MFZYYNZ5HMnZxspNcBkY4rP133r9OLXzTNJTH3JV2myttLWPUJwT6O7/SMR2A
         R/jkyPo4Vk7BaiNCDC/POpk/cMQXofivd9zoSwlX+lUbUK0SCnFmv/nZslZBEuyB08Ln
         xugGs8rCEx9G3hg6TIhnje9hFzKwm91kn2njS8EJ7PjOzZ3l5D66YdHGDW2FvRi+rUyU
         lEh11LKcDYBWjRRW369iKX3nTcfFLaIGZlS81yuTM7sriW5ZDNK2PsL37fP8kbSxxbuT
         oy9ZuT8xfXcDz3D+mzO2jC9z6A8qzx/vovCItbTkpegDX8ZW1TgiNCfoZuSl6x7HtDAH
         TZOQ==
X-Gm-Message-State: AC+VfDzJjkzgOToLcz9bNfh2zn3XdVoVXvKPvSePAYjQiI9EHW5zaZlE
        Odk+Ymjjbxx1Wh/K+LrHT4vwmvaNUvBm9A==
X-Google-Smtp-Source: ACHHUZ7r1zsC+B75tMcb50ctWzYr+gzclJMNRtrSr81i3DjuSXFiHcf9B8N3YM8uxesgFrg1s6waIw==
X-Received: by 2002:a05:6870:c79d:b0:17a:b378:8e1d with SMTP id dy29-20020a056870c79d00b0017ab3788e1dmr2409417oab.0.1682669956251;
        Fri, 28 Apr 2023 01:19:16 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id j11-20020a4a888b000000b00524fe20aee5sm9330680ooa.34.2023.04.28.01.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 01:19:16 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6a5ef766282so7339571a34.0;
        Fri, 28 Apr 2023 01:19:15 -0700 (PDT)
X-Received: by 2002:a0d:d581:0:b0:545:81ff:a0bc with SMTP id
 x123-20020a0dd581000000b0054581ffa0bcmr3280343ywd.13.1682669652892; Fri, 28
 Apr 2023 01:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230313132636.31850-1-nipun.gupta@amd.com> <20230313132636.31850-5-nipun.gupta@amd.com>
In-Reply-To: <20230313132636.31850-5-nipun.gupta@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Apr 2023 10:13:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com>
Message-ID: <CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] cdx: add MCDI protocol interface for firmware interaction
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        cohuck@redhat.com, song.bao.hua@hisilicon.com,
        mchehab+huawei@kernel.org, maz@kernel.org, f.fainelli@gmail.com,
        jeffrey.l.hugo@gmail.com, saravanak@google.com,
        Michael.Srba@seznam.cz, mani@kernel.org, yishaih@nvidia.com,
        jgg@ziepe.ca, jgg@nvidia.com, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, masahiroy@kernel.org,
        ndesaulniers@google.com, rdunlap@infradead.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com,
        pablo.cascon@amd.com, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nipun,

On Mon, Mar 13, 2023 at 2:28 PM Nipun Gupta <nipun.gupta@amd.com> wrote:
> The MCDI (Management CPU Driver Interface) is used as a
> protocol to communicate with the RPU firmware. It has
> pre-defined set of messages for different message exchanges
> between APU and RPU.
>
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

Thanks for your patch, which is now commit eb96b740192b2a09 ("cdx:
add MCDI protocol interface for firmware interaction") upstream.

> --- /dev/null
> +++ b/drivers/cdx/controller/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# CDX controller configuration
> +#
> +# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> +#
> +
> +if CDX_BUS
> +
> +config MCDI_LOGGING
> +       bool "MCDI Logging for the CDX controller"
> +       depends on CDX_CONTROLLER
> +       help
> +         Enable MCDI Logging for
> +         the CDX Controller for debug
> +         purpose.
> +
> +         If unsure, say N.
> +
> +endif

As there also exist config symbols SFC_MCDI_LOGGING and
SFC_SIENA_MCDI_LOGGING, perhaps MCDI_LOGGING is too generic, and should
be renamed to CDX_MCDI_LOGGING?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
