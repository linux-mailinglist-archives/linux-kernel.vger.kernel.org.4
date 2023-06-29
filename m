Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58A742A75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjF2QSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF2QSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:18:16 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD6CF;
        Thu, 29 Jun 2023 09:18:14 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-991f9148334so25016866b.1;
        Thu, 29 Jun 2023 09:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055493; x=1690647493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKddrYb9Xcx4IoLqdTI5tk2rwMAekQcgu+s3gWevaEw=;
        b=ThG38RP32xKZ+PWuCnCBfiwPRYgc1M/xWk/BMrEJaV8BYcfwGNK7Zm1kwoPueRNhgn
         z+f0qmxed7ySjDgTfMV8UXFJkvhlaUrpkYNSek1CxICQKdk61BZvUOfmfjc5cO2YiL2u
         a7sP10kS++uf73AesejacvimbX/1KQoVg+CqeauxXjQMsJHYmHROdF1NCpFVPQ31B6ZO
         dggMDDj0r41P1T9W71lSM/tNkmvGRks28G62aM+rB0GrWXFeSedoSBppgDQ343dHaFg3
         ZiH/WTrPjt2WV8d6jZ7QKPMN80GDVBLYtqc0bWCMh4JzGE9RCeiQifpY325UE3dUIDf2
         bzqQ==
X-Gm-Message-State: AC+VfDzs/sZ/KwpCuMucAdBh7MsYJbIS111fhulSrDbsDH1kr7opOUu5
        va45CAyC7IDfmKtLSToTXLx8/tjNZzM0ANseTc8=
X-Google-Smtp-Source: ACHHUZ7k8Ks89MOBgWSXswK1HxhhFvMe9nfbQWVunQafLyVDNv7RaVKtwd8bkxTgNnzA6i5b6d/Dmbk3eD5wOPYod2M=
X-Received: by 2002:a17:906:73dd:b0:989:1ed3:d00b with SMTP id
 n29-20020a17090673dd00b009891ed3d00bmr21389315ejl.4.1688055492790; Thu, 29
 Jun 2023 09:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-10-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-10-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 18:18:01 +0200
Message-ID: <CAJZ5v0gcokw72q5uX-3pbBEZtJdCaWHN1vat8yPNQ3SXMgeD4g@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
>
> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify function to match with
> what's required by acpi_install_notify_handler(). Remove .notify
> callback initialization in acpi_driver.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 95930e9d776c..a281bdfee8a0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>
> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       device_lock(&adev->dev);
> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> -       device_unlock(&adev->dev);

It's totally not necessary to rename the ACPI device variable here.

Just add

struct acpi_device *adev = data;

to this function.

> +       struct acpi_device *device = data;
> +
> +       device_lock(&device->dev);
> +       __acpi_nfit_notify(&device->dev, handle, event);
> +       device_unlock(&device->dev);
>  }
>
>  static int acpi_nfit_add(struct acpi_device *adev)
> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
>
>         if (rc)
>                 return rc;
> -       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +
> +       rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +       if (rc)
> +               return rc;
> +
> +       return acpi_dev_install_notify_handler(adev,
> +                                              ACPI_DEVICE_NOTIFY,
> +                                              acpi_nfit_notify);
>  }
>
>  static void acpi_nfit_remove(struct acpi_device *adev)
>  {
>         /* see acpi_nfit_unregister */
> +
> +       acpi_dev_remove_notify_handler(adev,
> +                                      ACPI_DEVICE_NOTIFY,
> +                                      acpi_nfit_notify);
>  }
>
>  static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
> @@ -3465,7 +3478,6 @@ static struct acpi_driver acpi_nfit_driver = {
>         .ops = {
>                 .add = acpi_nfit_add,
>                 .remove = acpi_nfit_remove,
> -               .notify = acpi_nfit_notify,
>         },
>  };
>
> --
