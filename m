Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B961FF4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiKGUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKGUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:14:02 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77C2B62C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o13so2118207pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/CPP2cwdDGdhfrnlXwHQ/NO9Q58jsLemjM9t2jp4EA=;
        b=x0R6EwqFYarF2NtrhuhPxZzLW/aZRfANHzpmffijkvmOtNd9TFuTJdaTON3eAeuFVJ
         FSbBVTzqoMvnR6NCgN/+sQW/QFrgrdCTb/LEeb+mMJcHkRPe77Bk7sHwkqkTJiCgA8lX
         mOR/PoqFE6ygzoMN0l4xt+C1C5+0Q5kSrDuB4LKF4fwWgVqurdMpDewqv9yGUFgSQFqI
         9AXom6nDsh1uAcVr/fSOmb/SvOgRWpydnALPS8N4g3TrI6i7ckwuIoqDyrrNxr6QFbdh
         slN11MtYCk0Rf9iFgvu1SzXXQGMp0xKRSDFWd36ulWdJLXLnfTup0CJxAsc0AzcjJJPU
         D+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/CPP2cwdDGdhfrnlXwHQ/NO9Q58jsLemjM9t2jp4EA=;
        b=me2SE0by0wG4VgZeutLCCh5r8n3SQbCebX9BzYcECVpLx3AaoBry/tabPQGC1CHCH4
         tANIG6INYTn/bRyMzL29zN7FVSlFzsRjvPE0qTIOKZYhkOTeAP/uH3+ATWnHbYtMiP+p
         YYVuuMsJNGj9slsbah7Py8V8gfTNqkM+CuFNY6PaKvQe042muRE3VbVwESBpTvInGPJ/
         7zvQY+jkiIK7PKEXz2UKw+JvysVL+JNtk/kSnu3q0wMGjnYxAvE8kXnnAwv2knhVuwYL
         dkk8CS8n6xltmhk1EaV/SywZ4xECLft08uOsrSfFJ6cnSU5mLKpAkF7RAkbiHAL2qjZ7
         P4sg==
X-Gm-Message-State: ACrzQf0AjPp3Gpu29xFGiK01H3IcdUujdG4WpYrrQvfZptQaHMUFa+1X
        Bcv7c31+v/SYrjMK1MQjrO0JGPUf48hJFPphrxwb0w==
X-Google-Smtp-Source: AMsMyM4sHwwndAJfkWUAGPVDKn1smFhxb++y7Ys6RG3wC2+fkvLJQ8Pts5QilKzk0AYmG/GZlIJcsxyJDD1nNN8rAgs=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr46115677pgk.595.1667852035052; Mon, 07
 Nov 2022 12:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20221104095512.4068-1-chevron.li@bayhubtech.com>
In-Reply-To: <20221104095512.4068-1-chevron.li@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:18 +0100
Message-ID: <CAPDyKFqaQyQ0rViHUZoN8NzcPu51utu4KhC2KsY4p2s_sua=kQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail issue
 caused by CD# debounce timeout
To:     Chevron Li <chevron.li@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        louis.lu@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 10:55, Chevron Li <chevron.li@bayhubtech.com> wrote:
>
> The SD card is recognized failed sometimes when resume from suspend.
> Because CD# debounce time too long then card present report wrong.
> Finally, card is recognized failed.
>
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in V1:
> Adjust bayhub chip setting for CD# debounce time to minimum value
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index ad457cd9cbaa..bca1d095b759 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -32,6 +32,7 @@
>  #define O2_SD_CAPS             0xE0
>  #define O2_SD_ADMA1            0xE2
>  #define O2_SD_ADMA2            0xE7
> +#define O2_SD_MISC_CTRL2       0xF0
>  #define O2_SD_INF_MOD          0xF1
>  #define O2_SD_MISC_CTRL4       0xFC
>  #define O2_SD_MISC_CTRL                0x1C0
> @@ -877,6 +878,12 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 /* Set Tuning Windows to 5 */
>                 pci_write_config_byte(chip->pdev,
>                                 O2_SD_TUNING_CTRL, 0x55);
> +               //Adjust 1st and 2nd CD debounce time
> +               pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL2, &scratch_32);
> +               scratch_32 &= 0xFFE7FFFF;
> +               scratch_32 |= 0x00180000;
> +               pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL2, scratch_32);
> +               pci_write_config_dword(chip->pdev, O2_SD_DETECT_SETTING, 1);
>                 /* Lock WP */
>                 ret = pci_read_config_byte(chip->pdev,
>                                            O2_SD_LOCK_WP, &scratch);
>
> base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
> --
> 2.25.1
>
