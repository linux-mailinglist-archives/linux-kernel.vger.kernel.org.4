Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF5640E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiLBT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiLBT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:26:19 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569EAF289C;
        Fri,  2 Dec 2022 11:26:18 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id y15so6577550qtv.5;
        Fri, 02 Dec 2022 11:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxqOAYX+EWKb+h7rdw206KR111U/KmrZPjRc5PMfRR4=;
        b=I5D1xoKretWOe3Vq7nyv/48xRYdDZWxr+zOj6Nub8d5XOpaKTkELKyMUiCJ68NF/yb
         tLqnir8Jd0JdulU+BDrSGq06Sn//09P+ZYscpsqbA5SsLiijaIwjwYEomx65PKPu1ksv
         LtgwBc/AQMQd1ALdnGmWLqn4p7rhPm5K5ywsaHeN5ExrMX3TuR9nK87QtFnsXTNH03H4
         8mYLDDVoDppWtl6m9Ny46kPZz4K54X0D7uTtGreGTT0Z9mgEk+Yf7iDfYsv+4OiAhP4e
         ph2L3ntI2j1Bk170PGUNhhsTkZN5nOZPQUHsdTGnmPKlhCBB/n9QntbSS2iwM7rQOa+y
         9jZg==
X-Gm-Message-State: ANoB5pmkJ5xKlBvWxkxr/dDkpai49BnsZS9QBdcq6o9eT1YufEaFT1Xa
        RjeS8rqMs0r1sIUFW2x+1fpO5dDYPlYNiMLdS6LHjBoS
X-Google-Smtp-Source: AA0mqf5qRcVxiUk+3OCh7k/4kSqbN0qJ+Aui0tH4wysuxXxOeIC9P5KNmBIrvMDkP5jJciwsdj9Mzega48EiefoWVGc=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr47184706qkb.764.1670009177509; Fri, 02
 Dec 2022 11:26:17 -0800 (PST)
MIME-Version: 1.0
References: <202211301616083499042@zte.com.cn>
In-Reply-To: <202211301616083499042@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:26:06 +0100
Message-ID: <CAJZ5v0gGy6nbW1DxBZORA=fYLFPjkrsojL=8V1cxWCmupqAvdw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: use sysfs_emit() to instead of scnprintf()
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

On Wed, Nov 30, 2022 at 9:16 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v1 -> v2
> combine patchs in drivers/acpi/.
>  drivers/acpi/acpi_pad.c  | 4 ++--
>  drivers/acpi/cppc_acpi.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
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
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..0f17b1c32718 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -148,7 +148,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
>                 if (ret)                                                \
>                         return ret;                                     \
>                                                                         \
> -               return scnprintf(buf, PAGE_SIZE, "%llu\n",              \
> +               return sysfs_emit(buf, "%llu\n",                \
>                                 (u64)st_name.member_name);              \
>         }                                                               \
>         define_one_cppc_ro(member_name)
> @@ -174,7 +174,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
>         if (ret)
>                 return ret;
>
> -       return scnprintf(buf, PAGE_SIZE, "ref:%llu del:%llu\n",
> +       return sysfs_emit(buf, "ref:%llu del:%llu\n",
>                         fb_ctrs.reference, fb_ctrs.delivered);
>  }
>  define_one_cppc_ro(feedback_ctrs);
> --

Applied as 6.2 material, thanks!
