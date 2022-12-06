Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25AF64425E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiLFLqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:46:29 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300441A21E;
        Tue,  6 Dec 2022 03:46:28 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id fz10so13501951qtb.3;
        Tue, 06 Dec 2022 03:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyElq22QQ1GTvetKhoZOh6R2a7rwbH/w+jb8Vqh0V0s=;
        b=x3Wk91o2B/cVPfgZ/s8dUVj088/sBmpwgradb6M4wv6NaU0oHKBL/gOuj33wLrh6Yp
         MQ8AMJHB3DldRiHDjRzkkdSmx47eIyalVddCf+dFHVD0q13mfPozZrtxM4TjGBaNaCs5
         sprVUd+9rlpxj4tL58w+9eSGes5VJcf3meOa/II+uvDIGvLcReV9XLfjbPqquF1s4hjo
         ZFO1DhGFogJc+VP54nZvdcvvQIuJ+UMuGUuWUcsiXPoHtNDQQbxtKKouYMs7QZrsN/3d
         qm9UzKnSjbzuW/eFLpB4QaSAVi35t4AzAF+VPr3cab12a7dEMkf4PUMedLc9i/T0p1qv
         9liA==
X-Gm-Message-State: ANoB5plS08q4/+8vpA7OHZSZVKGBsJ8xF8Gaqtf/0YR7bWxXz27HyTul
        iAKtPMjYzPliArv7rC4oKk5VBy+MvkMqIuabQsU=
X-Google-Smtp-Source: AA0mqf6OlPbSef1t/5ju5rMNOBN+/uViPbhBw37rlwY/UX7VSJp8+OHbFebQkhS1PtnHuS+a/uGp/39rcRQp0mn2pK4=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr80036675qtc.48.1670327187313; Tue, 06
 Dec 2022 03:46:27 -0800 (PST)
MIME-Version: 1.0
References: <202212061519451024396@zte.com.cn>
In-Reply-To: <202212061519451024396@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:46:16 +0100
Message-ID: <CAJZ5v0hjutr3w5f06hwSeGnavfP9ihaX184RSySJ=7051BX0xg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Convert to use sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 8:19 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/acpi/fan_attr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index f15157d40713..f4f6e2381f1d 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -27,24 +27,24 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
>                 count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
>
>         if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
> +               count += sysfs_emit_at(buf, count, "not-defined:");
>         else
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
> +               count += sysfs_emit_at(buf, count, "%lld:", fps->trip_point);
>
>         if (fps->speed == 0xFFFFFFFF)
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
> +               count += sysfs_emit_at(buf, count, "not-defined:");
>         else
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
> +               count += sysfs_emit_at(buf, count, "%lld:", fps->speed);
>
>         if (fps->noise_level == 0xFFFFFFFF)
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
> +               count += sysfs_emit_at(buf, count, "not-defined:");
>         else
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
> +               count += sysfs_emit_at(buf, count, "%lld:", fps->noise_level * 100);
>
>         if (fps->power == 0xFFFFFFFF)
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
> +               count += sysfs_emit_at(buf, count, "not-defined\n");
>         else
> -               count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
> +               count += sysfs_emit_at(buf, count, "%lld\n", fps->power);
>
>         return count;
>  }
> --

Applied as 6.2 material, thanks!

However, if you are about to send any analogous material to me, please
defer it until 6.2-rc1 is out, because it will be unlikely to get into
6.2 anyway.
