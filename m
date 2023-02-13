Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD514694C08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBMQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:08:31 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4C10E6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:08:30 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id w3so6607508edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEk14IX8OBEnadnSZ7mxlUnO/tCZHJfsJCqshML/DVc=;
        b=jWtO0PL3U+WpGpqaHCQeXjnP3Nj3zr1ZzvEc+03gof97f+cwmkKfIuz4N+7nDEjht+
         475MUS/SqRIz1AaH31tf59UUEf6cWif9TDQkjnBoeRghcaCon7YlEj2akF52+MGohVlx
         Ly0/BsFkDqfS1/eeWaqp3pCljXvai+DQm6DdVU9AIk/NJzGLVBToA2PgPftAIDelnzr+
         dQHyIVbcMhX/s2uicbvbpcz/h7qcVpnuV9DxcA+RuVL2Tr85JJ7t4pimxAakKV5scogc
         i6fYSJtSL8kl6BoURKdlMVHUO76USYNlL1JJAqrL2+sJon+xslmcC/cZ4cNXXlCOWw29
         JEbw==
X-Gm-Message-State: AO0yUKVL+trj+O5SzhM+yRRu8E/HpumqcMOuHYBGoLRAplZ4BJS/xvhn
        WujZYVR39PUU6xRC3Rh7KC4gBowFk1i4vK0yi3w=
X-Google-Smtp-Source: AK7set/RxnNpHZNitmG9Ak9OVKQCCDrzcjdAhd1d7TWMoxezaf6PsnJrHCR0K2j+3r0Aoy8wPH24vhSkCE3dB+z8NK4=
X-Received: by 2002:a50:8ade:0:b0:4ab:4933:225b with SMTP id
 k30-20020a508ade000000b004ab4933225bmr4296766edk.6.1676304508631; Mon, 13 Feb
 2023 08:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20230210102408.1083177-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230210102408.1083177-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 17:08:17 +0100
Message-ID: <CAJZ5v0g2aYidVctPzCzM8QHU8Ueti9qS3PcL27y=PKDq22AqYA@mail.gmail.com>
Subject: Re: [PATCH] driver core: cpu: don't hand-override the uevent bus_type callback.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:24 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Instead of having to change the uevent bus_type callback by hand at
> runtime, set it at build time based on the build configuration options,
> making this much simpler to maintain and understand (and allow to make
> the structure constant.)
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

LGTM:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/cpu.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 8bb623039bb2..182c6122f815 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -125,17 +125,6 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>  #endif /* CONFIG_HOTPLUG_CPU */
>
> -struct bus_type cpu_subsys = {
> -       .name = "cpu",
> -       .dev_name = "cpu",
> -       .match = cpu_subsys_match,
> -#ifdef CONFIG_HOTPLUG_CPU
> -       .online = cpu_subsys_online,
> -       .offline = cpu_subsys_offline,
> -#endif
> -};
> -EXPORT_SYMBOL_GPL(cpu_subsys);
> -
>  #ifdef CONFIG_KEXEC
>  #include <linux/kexec.h>
>
> @@ -348,6 +337,20 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  }
>  #endif
>
> +struct bus_type cpu_subsys = {
> +       .name = "cpu",
> +       .dev_name = "cpu",
> +       .match = cpu_subsys_match,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .online = cpu_subsys_online,
> +       .offline = cpu_subsys_offline,
> +#endif
> +#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
> +       .uevent = cpu_uevent,
> +#endif
> +};
> +EXPORT_SYMBOL_GPL(cpu_subsys);
> +
>  /*
>   * register_cpu - Setup a sysfs device for a CPU.
>   * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
> @@ -368,9 +371,6 @@ int register_cpu(struct cpu *cpu, int num)
>         cpu->dev.offline_disabled = !cpu->hotpluggable;
>         cpu->dev.offline = !cpu_online(num);
>         cpu->dev.of_node = of_get_cpu_node(num, NULL);
> -#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
> -       cpu->dev.bus->uevent = cpu_uevent;
> -#endif
>         cpu->dev.groups = common_cpu_attr_groups;
>         if (cpu->hotpluggable)
>                 cpu->dev.groups = hotplugable_cpu_attr_groups;
> --
> 2.39.1
>
