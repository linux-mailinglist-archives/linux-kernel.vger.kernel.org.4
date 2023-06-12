Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2362472C306
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjFLLiU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 07:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjFLLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:37:57 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34CD4480;
        Mon, 12 Jun 2023 04:22:00 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-974539fd9f0so81043466b.0;
        Mon, 12 Jun 2023 04:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686568919; x=1689160919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taXnRUDY7JOSpFWMZcgwWaSEWeCazS9Jqb/ELA153gw=;
        b=IVTo4VMm0/udU4rnoViSifIjmVHv6ZTqPhO0wHY2zrIr6Sf/2UAId3C7qGke0/lRMR
         8tF4P0eUr8/g9Tee4Jy7gSo+f1jKy33+ECprOryeslPKM5eScf4APu1o8GXI3newXrqB
         0MdpZ1U4VMF4VTDHY/SZ6Ma6PmFn8/YqhOpSjt7CC9h/g4kd0Nd4xvKBuT+gLzhU711N
         k7QsNs0/1dGhi/FJ3b2IoXdxVooKVGV58rms9IGiF4DjYqU6luU2frpT7CnoE2qnxcWz
         WhST+VtlmSEHRuaRl/D8l2GNoze9TDk3BwlWZiU5uAgSrEWNLZrozMnQr1U9FYqLUD3W
         AylQ==
X-Gm-Message-State: AC+VfDxA1M5WcBU8msN02SNM7lW/Sy3vCPwA7uHGtR/qi6bUSbcXh//2
        q/WCEa9tgK3GQvuAlYEFjDffgrJOFQtRZC7syR19OiIi
X-Google-Smtp-Source: ACHHUZ4usfZkeu1OYZW5XlPAMz8MOjk62Pc4PNSvOLe/ouIKTqlCgION7uOBp/iMtxEs0YjKYATUWMTIOUws4oAZsEQ=
X-Received: by 2002:a17:906:72d1:b0:97e:a7f0:b1d9 with SMTP id
 m17-20020a17090672d100b0097ea7f0b1d9mr4755796ejl.3.1686568919000; Mon, 12 Jun
 2023 04:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
In-Reply-To: <20230612090250.1417940-1-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 13:21:40 +0200
Message-ID: <CAJZ5v0g2SZF5cYWoBxsq7uCcGJJM0qtexK4Riv2vBa1XCLbrwA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
        pali@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        fengguang.wu@intel.com, dvhart@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 11:03 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. While at it, remove unnecessary assignment
> of NULL to device->driver_data and unnecessary whitespace, plus add a
> break for the default case in a switch.
>
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/platform/x86/dell/dell-rbtn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..e9b3f9c3ab7d 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
>                 break;
>         default:
>                 ret = -EINVAL;
> +               break;
>         }
> +       if (ret)
> +               rbtn_acquire(device, false);
>
>         return ret;
> -
>  }
>
>  static void rbtn_remove(struct acpi_device *device)
> @@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
>         }
>
>         rbtn_acquire(device, false);
> -       device->driver_data = NULL;
>  }
>
>  static void rbtn_notify(struct acpi_device *device, u32 event)
> --
> 2.40.1
>
