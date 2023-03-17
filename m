Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0406BF013
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCQRqG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCQRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:46:03 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818E4BEB7;
        Fri, 17 Mar 2023 10:46:01 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id er8so11684338edb.0;
        Fri, 17 Mar 2023 10:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K26auEMnTKuvwDj2KTkLuNYLs8JTlath/TrD8GdyZuY=;
        b=ftZt6PjaCERQlYfK2VxFxcRpauT6eNnks5ugIPX+w/Z2mct8QhhTbSL5LDckj8Jlhf
         8jCxURt79XmEGeyaW238zhrn1rs4KFDgKhPNslzQ+i8N8VB22ZIdentDGOOT+9hkR79j
         KSOAYW6PbKMlg1uFH8Gf7ScQ6JyXOX7mIOIxOY9wpEf1nG3fmV9IDeQggsjOzztrKUxT
         pZ6KjfGO6FSemc4RnMmVaq/7Y1OARmwHi9wuUGDaBlnpFNqI8oi9b6ai/GpiCLoJqbvb
         TmGFXesOwGteSvYsI7pRojhnrfWNxH+QWfe2HhvgSqf2SMSRc+i7WYMLo2mY0jpF7+5x
         3qrg==
X-Gm-Message-State: AO0yUKWfBDh9MDHq3q7Ag59tWGhAUeN62qb7TgQ9aWZIawDFjCrq29zg
        BoDwJjFFqCymUN28d2n/FrEqq/jQy79YWSPmEys=
X-Google-Smtp-Source: AK7set/BxPwqnQib4HdMApNSAvC73vRc2vG2UkPhjLk0SbUeAPoMoGX85KgLumZ06Sh3op65qz0MOcA6rWZdB4kODys=
X-Received: by 2002:a50:d0d3:0:b0:4fa:71a2:982b with SMTP id
 g19-20020a50d0d3000000b004fa71a2982bmr2139979edf.0.1679075159978; Fri, 17 Mar
 2023 10:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230217131726.12666-1-alsp705@gmail.com>
In-Reply-To: <20230217131726.12666-1-alsp705@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 18:45:48 +0100
Message-ID: <CAJZ5v0jsmshYESk2KX0SiUZKZTaNyrNqVy=GxMK4DkN3j6yPZw@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/kernel/acpi/boot: fix buffer overflow on
 negative index in mp_config_acpi_gsi()
To:     Alexander Sapozhnikov <alsp705@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 2:17 PM Alexander Sapozhnikov <alsp705@gmail.com> wrote:
>
> Variable 'ioapic', which may receive negative value by calling
> function 'mp_find_ioapic' at boot.c:465, is used at
> io_apic.c:128 by passing as 1st parameter to function 'mpc_ioapic_id'
> at boot.c:466

And that function uses the given value for array indexing without
checking it, right?

I would rather call this "out of bounds access"

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..abb78822f164 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -463,8 +463,10 @@ static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
>         mp_irq.srcbus = number;
>         mp_irq.srcbusirq = (((devfn >> 3) & 0x1f) << 2) | ((pin - 1) & 3);
>         ioapic = mp_find_ioapic(gsi);
> -       mp_irq.dstapic = mpc_ioapic_id(ioapic);
> -       mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
> +       if (ioapic >= 0) {
> +               mp_irq.dstapic = mpc_ioapic_id(ioapic);
> +               mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
> +       }
>
>         mp_save_irq(&mp_irq);

Is it still valid to call this if ioapic is negative?

>  #endif
> --
> 2.34.1
>
