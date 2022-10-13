Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624F5FE224
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJMSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJMSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:54:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B5196B41;
        Thu, 13 Oct 2022 11:52:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h24so1970178qta.7;
        Thu, 13 Oct 2022 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmkQjLsGTa1MzUj9V4OJ+4Yb6u89KcVySd17USewG7U=;
        b=eYaJVOvkIMtBzIZfA4LJDtn2BdoljWneeuMreDgn4Na/MElUYBdSM6mSdI2rGJbf8J
         7fJvh2xrc0yg8jTAh2X+hVAoGteatzNcOcxqkDL5xCys4f51xK22hvWW7Pao3by4Lwua
         hAyGxppuCRpQAkdP/8VXwH1eNQ/Uz10w6B1My+zfV6eCe8nWtAOPNHNE0+KEwp9/cV0Y
         3saEpAU+CcPZm6OWlVxfTzrpFDsDLXq7BOlLcgFfmFuEcJfc1k5I+L6iVuHTM3EvaLOQ
         RZ9JMiIUMbXnEIFfU9EePjS1nzpCZZaf7ShPwZOYizII7vCRFkVrp+X/vRCsnwP9LEv4
         Cv2w==
X-Gm-Message-State: ACrzQf1WoAxh+EtpytEGzKfFW5K62ZFwwtYU1TOQOwOkgmqeJVbzoX7X
        aV0eBEE3vOnSQRpc52oUYeP7A1gC36Tky6YGwQQ=
X-Google-Smtp-Source: AMsMyM4uCEx0KIHzVLVm2PGrG3UzQ7PmNnyRmRL8CiwYYpQ9LIA/bhLxkuuPMDhDEzMxt2r6BIa2QPu0ulnlK9PwuRk=
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id
 d1-20020ac85ac1000000b0039a123c9df5mr1099723qtd.27.1665687087910; Thu, 13 Oct
 2022 11:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221004103341.12646-1-jirislaby@kernel.org>
In-Reply-To: <20221004103341.12646-1-jirislaby@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 20:51:15 +0200
Message-ID: <CAJZ5v0jQvzMh98SO0gZpvPiPWxhumY7e58-4MJRNF1JLRtGDHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Fridrich Strba <fstrba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 12:33 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> LENOVO IdeaPad Flex 5 is ryzen-5 based and the commit below removed IRQ
> overriding for those. This broke touchscreen and trackpad:
>  i2c_designware AMDI0010:00: controller timed out
>  i2c_designware AMDI0010:03: controller timed out
>  i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  i2c_designware AMDI0010:03: controller timed out
>  ...
>  i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
>  i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with error -61
>
> White-list this specific model in the override_table.
>
> For this to work, the ZEN test needs to be put below the table walk.
>
> Fixes: 37c81d9f1d1b (ACPI: resource: skip IRQ override on AMD Zen platforms)
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1203794
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: Tighe Donnelly <tighe.donnelly@protonmail.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Fridrich Strba <fstrba@suse.com>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/acpi/resource.c | 42 +++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 514d89656dde..8d13e94bb921 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -424,17 +424,31 @@ static const struct dmi_system_id asus_laptop[] = {
>         { }
>  };
>
> +static const struct dmi_system_id lenovo_82ra[] = {
> +       {
> +               .ident = "LENOVO IdeaPad Flex 5 16ALC7",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
>         unsigned char triggering;
>         unsigned char polarity;
>         unsigned char shareable;
> +       bool override;
>  };
>
> -static const struct irq_override_cmp skip_override_table[] = {
> -       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> -       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> +static const struct irq_override_cmp override_table[] = {
> +       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +       { lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +       { lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> @@ -442,6 +456,17 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>  {
>         int i;
>
> +       for (i = 0; i < ARRAY_SIZE(override_table); i++) {
> +               const struct irq_override_cmp *entry = &override_table[i];
> +
> +               if (dmi_check_system(entry->system) &&
> +                   entry->irq == gsi &&
> +                   entry->triggering == triggering &&
> +                   entry->polarity == polarity &&
> +                   entry->shareable == shareable)
> +                       return entry->override;
> +       }
> +
>  #ifdef CONFIG_X86
>         /*
>          * IRQ override isn't needed on modern AMD Zen systems and
> @@ -452,17 +477,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>                 return false;
>  #endif
>
> -       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
> -               const struct irq_override_cmp *entry = &skip_override_table[i];
> -
> -               if (dmi_check_system(entry->system) &&
> -                   entry->irq == gsi &&
> -                   entry->triggering == triggering &&
> -                   entry->polarity == polarity &&
> -                   entry->shareable == shareable)
> -                       return false;
> -       }
> -
>         return true;
>  }
>
> --

Applied along with the [2/2] as 6.1-rc material, thanks!
