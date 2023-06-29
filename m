Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF1742A14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjF2P4n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjF2P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:56:07 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE633A90;
        Thu, 29 Jun 2023 08:56:03 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98e2865e2f2so21875366b.0;
        Thu, 29 Jun 2023 08:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054162; x=1690646162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NanhwP3ZvzSNrv3gc9fvxwRqCsfI8QWgmtWgVz7PxTU=;
        b=YTLmTlkdlS9ylsynXd7KtjOACz1XZKC9RSL/7ktLInuNOdD2Aac/HqeXil21nEVQHD
         pP5uzaeeSsGxzR96VMkYIcqLVrSfZQYxXPXC+/ZlAdHrZTNQCMNQz0OnfSo5TjoXMhsu
         TVASknNN0R5Jq1I1jv0d0/zjSvfUUII2F+zhFNbkI8WWy+IHG1eaJUh1t1MV0yyi/F3f
         425bPXXhyMrjyJggD0v34+6fVIOrR+i2D0/gsR3a/RebdywSAGlhzN29BalLIQ7Q4vjR
         VrVQZro0JSTQPQ4LaNcEILK61lY28YGlM/RtfQdljLedIxYpiIArkZ8IzTuc9YlCt4nC
         Q2Tg==
X-Gm-Message-State: AC+VfDzXcgp5DAIr0gKaK9mtrSU0Hz9twBcK0NfmK/1PE0324oDCiaPz
        mfpepqG/FchPeJS2e3z9IuQSmjQV4EhLAMoCmmzzdduc
X-Google-Smtp-Source: ACHHUZ6JS90WyEgMYObZ9p9DRC2xaF5Mo3SHtPTnXmhMUmPa+3yMH2tHtxa/bayz2xhkDknvPVpKxFBXvXNpMQ8USYc=
X-Received: by 2002:a17:906:7496:b0:988:815c:ba09 with SMTP id
 e22-20020a170906749600b00988815cba09mr2452887ejl.4.1688054161659; Thu, 29 Jun
 2023 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-4-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-4-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 17:55:50 +0200
Message-ID: <CAJZ5v0ippMo1Haa-YFszyWZNgUE_pPUtkFngQWjUyjJe4tm94g@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] acpi/ac: Move handler installing logic to driver
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
>  drivers/acpi/ac.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 1ace70b831cd..207ee3c85bad 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
>
>  static int acpi_ac_add(struct acpi_device *device);
>  static void acpi_ac_remove(struct acpi_device *device);
> -static void acpi_ac_notify(struct acpi_device *device, u32 event);
> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
>
>  static const struct acpi_device_id ac_device_ids[] = {
>         {"ACPI0003", 0},
> @@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
>         .name = "ac",
>         .class = ACPI_AC_CLASS,
>         .ids = ac_device_ids,
> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>         .ops = {
>                 .add = acpi_ac_add,
>                 .remove = acpi_ac_remove,
> -               .notify = acpi_ac_notify,
>                 },
>         .drv.pm = &acpi_ac_pm,
>  };
> @@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
>  };
>
>  /* Driver Model */
> -static void acpi_ac_notify(struct acpi_device *device, u32 event)
> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_ac *ac = acpi_driver_data(device);

This line doesn't need to be changed.  Just add the device variable
definition above it.

And the same pattern is present in the other patches in the series.

> +       struct acpi_device *device = data;
> +       struct acpi_ac *ac;
> +
> +       ac = acpi_driver_data(device);
>
>         if (!ac)
>                 return;
