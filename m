Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8558728B39
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjFHWsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjFHWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:48:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F762D5F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:48:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565a63087e9so10651757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686264496; x=1688856496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SevHFuFvWiWBIFRswg9uj8IfEdbzTFJ6Jca5wyhSDJw=;
        b=ECOhaM3p975Kr+3/aj2t5kmM5aiRRvok5V6OB95fKgNEnL8JxKL3JB4ZtcCnnv86+d
         FgNkJD+sRQ7gZ0EY5ug+pNVmupLrGTzp6KDVW6x7B8oGluqsTm1i8J3m9/epq1kGt3qD
         BbUiwiRxEZ59N6evbnQzDZjz18Ei0fV9HkOOs43Erb0vgMLLAnCJSKmMJnnO+N0EqfT8
         M5q8i5Cuj/kkT68fJCJRG81FQLJEXDzIKwj/OwbR56Oq7TiYcR0X8rIpuNJGWv+agS6F
         GkPkuXMkMVbgEbtfwPG15yrZHhO6IqZL/OXHYsEPci1qHtaeQn4UTC9c9f0guZEgWQIQ
         3uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264496; x=1688856496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SevHFuFvWiWBIFRswg9uj8IfEdbzTFJ6Jca5wyhSDJw=;
        b=cI52B7dQFtgtOpW3bCdq0HVkE/XgLNRXmBW9phse3D0ARiqBxdnA/0qUmiygJNECj2
         KateqieNPoXnlxs41bW9LBntGOxnSw3PPnJEL1mAJkHbTlWyiHWJ1qiJhVc4dsdJjTij
         zIF8mTvhs5XY+VrJWwt3f5b7m82QDU+tIHA+S27vFaIABp2JIylhaeU6Wtm2ODpFN5gx
         IC8/aP8vOW6QIG0W2npZU/IjUUB8bBCcRWSl2KlUK5sNEeDNniMtoots/ZxsN3Ro3JqT
         LonSSyhvAnh4UiD79CcziVc7GhLtHZJ9dWZay4OuWA8YfBZsg8+c0EkDguU4KIkGrKV1
         znUw==
X-Gm-Message-State: AC+VfDwgi9oQp11H3xw21HYzyKi2MWdJqgSvVSRTiyyDoghXSckbMaVo
        QPmjmzguHDElsC4GmRzHtclrj1Z/ttBSjsu+ty9PsA==
X-Google-Smtp-Source: ACHHUZ6sg68tAvFst1nqZ5DMkn1OuhQZZTbeAVJLKGxB6g8cUNAHdkwHMsxryq4bL5XnmKBOXrRNIMQ0KdwxEmFUKFs=
X-Received: by 2002:a81:92cc:0:b0:561:cb45:d7de with SMTP id
 j195-20020a8192cc000000b00561cb45d7demr987980ywg.31.1686264496190; Thu, 08
 Jun 2023 15:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230601015115.406002-1-victorshihgli@gmail.com> <20230601015115.406002-3-victorshihgli@gmail.com>
In-Reply-To: <20230601015115.406002-3-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 00:47:40 +0200
Message-ID: <CAPDyKFrq1U1R+tvz3WLZCv2m5ta09L1ozoV4w-H5w38qX91BKw@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz
 and enable SSC for GL9767
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 03:51, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Set GL9767 SDR104's clock to 205MHz and enable SSC feature
> depend on register 0x888 BIT(1).
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 135 ++++++++++++++++++++++++++++++-

[...]

> +
> +static void gl9767_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
> +{
> +       u32 pll;
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> +       pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV |
> +                PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV |
> +                PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN);
> +       pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV, ldiv) |
> +              FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV, pdiv) |
> +              FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN, dir);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> +
> +       gl9767_vhs_read(pdev);
> +
> +       /* wait for pll stable */
> +       msleep(1);

According to Documentation/timers/timers-howto.rst, this should be
converted into usleep_range instead.

[...]

Other than the minor thing above, this looks good to me!

Kind regards
Uffe
