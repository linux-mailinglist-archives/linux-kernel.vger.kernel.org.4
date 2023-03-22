Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5901D6C4D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCVOP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:15:25 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE161523;
        Wed, 22 Mar 2023 07:15:19 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id eh3so73561261edb.11;
        Wed, 22 Mar 2023 07:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc9u0QRSHAZ1FQIFQqSfH1qMlFht2R0YM5EtqXriUHE=;
        b=kE7kA8ZSuPB0wF57vRNvAJo+ai6Y5j/BRN1T9KJI14hye2dvMEI/1HS9gKH39jw7gS
         EcRbk+h/N8AaR1+h220Td5wYrDAwA05BrVf41COOC93zjIYVW+mU7VJzpDIIHDzgnomF
         NuUrgNeRBmnGYAi/cvek1Tf3QGMk2Kn1AoQbeGLZXSZVtt9HznDpW7Q3tyBoq7FHmtTd
         8Nps6u5Pp799c1xsHRzw3pzFctU/JLpmy3FmBGSPfcYu/KFiypy56qHysuLVZou/93w0
         ZvX4bjZ5wpjxKumbp6+f2O9Rqv4jdij9SZwv0W2E7aSJAgljUJZ9pBDcEjb7qfg0R7YK
         3VwA==
X-Gm-Message-State: AO0yUKWowRMV+JCClC/6q6BAVkhibOprMPcON86lQR/3NQ+wGT9mkl5u
        F4P78hIdu2nXu8MWvpjOxPeyIDCUWTnw1RP+JRM=
X-Google-Smtp-Source: AK7set+sFvi2b9JHlrh82lzop6CBs+RArXGCZqOerIKmyfaW5wrAJy2Jcf3NeARQruIklHezo9aFnjJyye6iajCp1m0=
X-Received: by 2002:a17:907:7da7:b0:8b1:3298:c587 with SMTP id
 oz39-20020a1709077da700b008b13298c587mr3405064ejc.2.1679494517779; Wed, 22
 Mar 2023 07:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
 <20230322083646.2937580-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230322083646.2937580-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 15:15:06 +0100
Message-ID: <CAJZ5v0jk=Kow_YrB5HgO2gd-bHcNx+6GKTXThf5js_ZjxaAM8w@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] ACPI: LPIT: move to use bus_get_dev_root()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:36 AM Greg Kroah-Hartman
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: - change logic to test for dev_root at the beginning of the function
>       and error out then based on review comments from Rafael.
>     - fix error handling for ioremap() call to properly drop the
>       reference on dev_root if it failed.
>
>  drivers/acpi/acpi_lpit.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> index 3843d2576d3f..c5598b6d5db8 100644
> --- a/drivers/acpi/acpi_lpit.c
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -98,6 +98,12 @@ EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
>  static void lpit_update_residency(struct lpit_residency_info *info,
>                                  struct acpi_lpit_native *lpit_native)
>  {
> +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> +
> +       /* Silently fail, if cpuidle attribute group is not present */
> +       if (!dev_root)
> +               return;
> +
>         info->frequency = lpit_native->counter_frequency ?
>                                 lpit_native->counter_frequency : tsc_khz * 1000;
>         if (!info->frequency)
> @@ -108,18 +114,18 @@ static void lpit_update_residency(struct lpit_residency_info *info,
>                 info->iomem_addr = ioremap(info->gaddr.address,
>                                                    info->gaddr.bit_width / 8);
>                 if (!info->iomem_addr)
> -                       return;
> +                       goto exit;
>
> -               /* Silently fail, if cpuidle attribute group is not present */
> -               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> +               sysfs_add_file_to_group(&dev_root->kobj,
>                                         &dev_attr_low_power_idle_system_residency_us.attr,
>                                         "cpuidle");
>         } else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
> -               /* Silently fail, if cpuidle attribute group is not present */
> -               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> +               sysfs_add_file_to_group(&dev_root->kobj,
>                                         &dev_attr_low_power_idle_cpu_residency_us.attr,
>                                         "cpuidle");
>         }
> +exit:
> +       put_device(dev_root);
>  }
>
>  static void lpit_process(u64 begin, u64 end)
> --
> 2.40.0
>
