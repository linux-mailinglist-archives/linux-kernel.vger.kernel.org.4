Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB5742A40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjF2QHK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2QHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:07:06 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ADB9E;
        Thu, 29 Jun 2023 09:07:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98502b12fd4so21919866b.1;
        Thu, 29 Jun 2023 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054824; x=1690646824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xfZ/TTJf1ZjgTOZZ4dAslTfGuQT8e+I59Ry3r/mWbg=;
        b=DHC0ItaunOYyYiLiXT9d+ZU2Bsumj+biUGQnF5bHbxubDZhcqlztNcXp3iuPbIUSlm
         2zVnfK+r7YeFjg9rXqFNLHNE5XS1BNrpjUsDCbGelQiiW+zPb+CEfDhVmdWEP8BnK+Bv
         XzXwJfIKxCMlxLlrMIKBS8BnfDnfnIfBfOxAaHP+x8hRoge1DXXxo6dBNB+Go8xFPLNb
         ZbU80++txJxNr1INtpeuYvWIkGUZbVAydWdZWh0HCvJ3bun53OOOyQKp9q2eqaXIc5mO
         +Phnurq3S+z6Fp3y1HoQs97nA/E158WwYNVk8WfHqc/Ea6/oISRCE1raahZYvfEdJPx0
         fUgA==
X-Gm-Message-State: AC+VfDyx/MwxYpoyvlh20HKu/jUx0vpKaiDTqSDsRCC7DtvoUSe4avG2
        YLprZruo5pldZ65WJ2rOOa3xreH6H/g/pJFSyY4Os61q
X-Google-Smtp-Source: ACHHUZ7cgRYS8YYVr3hCgsEpgcP5bbQZjvy53V/YLYKMqwUMwZxw17sb6Umt8V35dOqpNIQVa2PqIZJi+LLWZLBY/tI=
X-Received: by 2002:a17:906:7a45:b0:988:8e7a:d953 with SMTP id
 i5-20020a1709067a4500b009888e7ad953mr2397442ejo.1.1688054824132; Thu, 29 Jun
 2023 09:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-8-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-8-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 18:06:53 +0200
Message-ID: <CAJZ5v0jjwk+jVsULD8nyguc7p00Sn3Hyxq7=PLNzpj-Fz6H6sg@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] acpi/nfit: Move acpi_nfit_notify() before acpi_nfit_add()
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> To use new style of installing event handlers acpi_nfit_notify() needs
> to be known inside acpi_nfit_add(). Move acpi_nfit_notify() upwards in
> the file, so it can be used inside acpi_nfit_add().
>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..aff79cbc2190 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3312,6 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>
> +static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> +{
> +       device_lock(&adev->dev);
> +       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> +       device_unlock(&adev->dev);
> +}
> +
>  static int acpi_nfit_add(struct acpi_device *adev)
>  {
>         struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -3446,13 +3453,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
>  }
>  EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>
> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> -{
> -       device_lock(&adev->dev);
> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> -       device_unlock(&adev->dev);
> -}
> -
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>         { "ACPI0012", 0 },
>         { "", 0 },
> --

Please fold this patch into the next one.  By itself, it is an
artificial change IMV.
