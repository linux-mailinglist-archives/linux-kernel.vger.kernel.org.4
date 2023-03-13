Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3486B80FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCMSp7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCMSp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:45:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4D2E81E;
        Mon, 13 Mar 2023 11:45:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so52552909edb.10;
        Mon, 13 Mar 2023 11:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS/WyNiPbCZftoU6jgkGbodsREzbGi5V+aiW+aiHpfA=;
        b=L2zhJEiOkmGDymsZjBs+793MRdgIfMPYM6EP9R10kjvxHwtrYF+EGlFP/SuG7x/rD7
         qrODHLPtywPjZeDtb9DhOJu/Du6VIliBwhMgxfhG7DLaBcL9DYY9zNlDv4KKkSBbxKAd
         CX4Gt8+gaJaJDO2EJVTQs8+LpYmkBT11Fv0yAi1Pqulteamu0RS90cTlKMMpL6aBZKw2
         1aJCDwKz8WpQ18jqZht722aIlwjKcCM6LDhtPKc1mP1sXtDqwK5LgFtNCSHXwuu+r1Rs
         Fg7A0XoIUj9CEPJMjGOaT00XHwcEuKq1lAXGWGHKQPbEdP9ca8SFhqMhjfKLndemN9zA
         EQsw==
X-Gm-Message-State: AO0yUKU4CwT+j0FoHuK3Xi1O6FmEs9wjSbBBSOFNTCWsgCbxfApwnwNg
        fN/fegrD+Z+Ftm4yJ1x8K3ueG29GV9ERRxbzXQ5s39R24pQ=
X-Google-Smtp-Source: AK7set/9f3wmhPrJ2AbY8kRIKM7r2Mh0TR/vaBbfcqgioIPTgCA78PHXksCgzdFKVdangTjqQPxoNfQjQE3moFrkiPM=
X-Received: by 2002:a50:d59a:0:b0:4fb:f19:881 with SMTP id v26-20020a50d59a000000b004fb0f190881mr3581486edi.3.1678733013460;
 Mon, 13 Mar 2023 11:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org> <20230313182918.1312597-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230313182918.1312597-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 19:43:22 +0100
Message-ID: <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
Subject: Re: [PATCH 02/36] ACPI: LPIT: move to use bus_get_dev_root()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 7:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
>
>  drivers/acpi/acpi_lpit.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index 3843d2576d3f..73b5c4800150 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -98,6 +98,8 @@ EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
>  static void lpit_update_residency(struct lpit_residency_info *info,
>                                  struct acpi_lpit_native *lpit_native)
>  {
> +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> +

This can return here right away if dev_root is NULL, because it will
not do anything useful in that case anyway.

>         info->frequency = lpit_native->counter_frequency ?
>                                 lpit_native->counter_frequency : tsc_khz * 1000;
>         if (!info->frequency)
> @@ -111,15 +113,18 @@ static void lpit_update_residency(struct lpit_residency_info *info,
>                         return;
>
>                 /* Silently fail, if cpuidle attribute group is not present */
> -               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> -                                       &dev_attr_low_power_idle_system_residency_us.attr,
> -                                       "cpuidle");
> +               if (dev_root)
> +                       sysfs_add_file_to_group(&dev_root->kobj,
> +                                               &dev_attr_low_power_idle_system_residency_us.attr,
> +                                               "cpuidle");
>         } else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
>                 /* Silently fail, if cpuidle attribute group is not present */
> -               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> -                                       &dev_attr_low_power_idle_cpu_residency_us.attr,
> -                                       "cpuidle");
> +               if (dev_root)
> +                       sysfs_add_file_to_group(&dev_root->kobj,
> +                                               &dev_attr_low_power_idle_cpu_residency_us.attr,
> +                                               "cpuidle");
>         }
> +       put_device(dev_root);
>  }
>
>  static void lpit_process(u64 begin, u64 end)
> --
> 2.39.2
>
