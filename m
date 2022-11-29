Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A531063C6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiK2RzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiK2RzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:55:02 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082427140;
        Tue, 29 Nov 2022 09:55:02 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id i12so10260621qvs.2;
        Tue, 29 Nov 2022 09:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YxSPJfS6d/gmK4QLzUcrA+Y294XjTdBn85ShTK96vw=;
        b=EzfqeG+BZdGMrx7vN+YxAJdCVzfjJucxXPN+TLWrFKbDExEIUxNyVZ8TvpX1aims8o
         yj9UWeI7NIPUpw3uuwhjMxgEI+hcd1MqS1sRY58wvRUDJcfmxWGZzpUiqaxpnZf12wCc
         T6+BFbTvPmYjSjAx5zhndRK2B26LT7xgZ1dJ26V1asz8vYmVPAvMzIYLWV8vVWTDkclb
         bkuUV3t5rkF4RI14OSUNj8aRLWfKoKXQeu768nBEwC+co7m89uBlq4Qe7aK4akWNqAqT
         st+sRBaKX2skCXMbj+CqcCKhiB9tjW3UWMlMbf7f8iWTa4Y/i+2OztU/e6v4QeHh8Pt9
         docA==
X-Gm-Message-State: ANoB5pmbm7UEaS06ycIcvnRylAKT6ryZRsKPFZr1GcRVPH7INDLAB+yo
        r1TWIRk/6dCCGLpVgNawxAp7OGx5/eN5aaDleyo=
X-Google-Smtp-Source: AA0mqf7sSJE6wcOd0MhD5LYYC6V3lfb+I6WMzBDLs0ONT/VQea52rB7wpBk5kdFjobtiUveV4olQYvSqtUW4azgiIek=
X-Received: by 2002:a05:6214:451b:b0:4c6:bf45:38ad with SMTP id
 oo27-20020a056214451b00b004c6bf4538admr33686656qvb.73.1669744501215; Tue, 29
 Nov 2022 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <202211291931593806484@zte.com.cn>
In-Reply-To: <202211291931593806484@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Nov 2022 18:54:50 +0100
Message-ID: <CAJZ5v0ivJXmkW8eogRrNekkTP67UJY6kcp1QYJNuSHv+qdOzhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PAD: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:32 PM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Can you please send one combo patch for this for all of the affected
code in drivers/acpi/?

> ---
>  drivers/acpi/acpi_pad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index edbb28faee2a..02f1a1b1143c 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -287,7 +287,7 @@ static ssize_t rrtime_store(struct device *dev,
>  static ssize_t rrtime_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", round_robin_time);
> +       return sysfs_emit(buf, "%d\n", round_robin_time);
>  }
>  static DEVICE_ATTR_RW(rrtime);
>
> @@ -309,7 +309,7 @@ static ssize_t idlepct_store(struct device *dev,
>  static ssize_t idlepct_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", idle_pct);
> +       return sysfs_emit(buf, "%d\n", idle_pct);
>  }
>  static DEVICE_ATTR_RW(idlepct);
>
> --
> 2.25.1
