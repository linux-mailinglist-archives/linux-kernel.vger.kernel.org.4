Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E416E9AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjDTRYp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDTRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:24:43 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1D173A;
        Thu, 20 Apr 2023 10:24:41 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-94a34c299d8so28787066b.1;
        Thu, 20 Apr 2023 10:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011480; x=1684603480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iIIpr3W3RWkrIppsbMQbHuNurNbmAo22mJOSut58cc=;
        b=Mwadu2LZiWrC0BDLO1Z479kkkVPdGMd8YDcYwMmI/BNmQdBSad0vXEMV4Q4p51Znyu
         DL5ivtVMInrfSdT9dV2oGS9akWT+Y7Db4iKPQSoPuU2ApO8F3lnW/uuSRuxj9oGoix6l
         R9tJ5eN7Lkx/Sp2WUqPODEyW+DBm1qi5C9ydNG8vepJDAs0/DiX8/aDMJ/uwkmblr1Sg
         eQiVorZgT/0aoa/BXasiBWidmxF3Ilgg+5+xIgrP9iE2+fap5w+qBh+MkDqzMyPBi+V5
         YlyQaYYztsT5RFaxQmyireVVjSDphmRnhk2byibskbue/H+NKSCCxTpplwYp0UsHeBVD
         7l9A==
X-Gm-Message-State: AAQBX9deB3lepldijj08thB1iwUnrpH2NPq1/ApDP4BDE5WTAKi3BkFG
        4dJg2gpQbSZ4IKh1h8im6nSJ9blAmkyUoiqCJ/I/jV+Cwa4=
X-Google-Smtp-Source: AKy350bUWcXmfpU6WhYxjKYRrXtUdge10MBFsWbeSl3sbcBFnG6JErF08gOeB2mA4yjowjFmzrfcmZJde8ykKuE65vw=
X-Received: by 2002:a17:906:82c1:b0:92f:27c2:13c0 with SMTP id
 a1-20020a17090682c100b0092f27c213c0mr2306018ejy.6.1682011480013; Thu, 20 Apr
 2023 10:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230419083343.505780-1-daniel.lezcano@linaro.org> <20230419083343.505780-7-daniel.lezcano@linaro.org>
In-Reply-To: <20230419083343.505780-7-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Apr 2023 19:24:28 +0200
Message-ID: <CAJZ5v0gi4j=kJBnXCotQ8_+t39CzOFSBie9Yc6x8BV=TYxsjPQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] thermal/drivers/intel_menlow: Make additionnal
 sysfs information optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Wed, Apr 19, 2023 at 10:33 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The Menlon thermal driver creates auxiliary trip points in the thermal
> zone sysfs directory. It is specific to Menlon. Actually these trip
> points could be generalized with the generic trip points in the future.
>
> Let's make the code optional and disable it by default so we have a
> consistency with the attributes in the thermal zone sysfs
> directories. If that hurts we will enable by default this option
> instead of disabling it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/Kconfig        | 11 +++++++++++
>  drivers/thermal/intel/intel_menlow.c |  9 +++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index cb7e7697cf1e..ef7ffe6b56a0 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -112,6 +112,17 @@ config INTEL_MENLOW
>
>           If unsure, say N.
>
> +config INTEL_MENLOW_SYSFS_ADDON
> +       bool "Enable extra sysfs attributes in the thermal zone"
> +       depends on INTEL_MENLOW
> +       def_bool n
> +       help
> +        Create auxiliary trip points in the thermal zone sysfs
> +        directory. This is specific to this driver. By default those
> +        are disabled and are candidate for removal, if you need these
> +        information anyway, enable the option or upgrade the
> +        userspace program using them.
> +
>  config INTEL_HFI_THERMAL
>         bool "Intel Hardware Feedback Interface"
>         depends on NET
> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> index d720add918ff..605983be516c 100644
> --- a/drivers/thermal/intel/intel_menlow.c
> +++ b/drivers/thermal/intel/intel_menlow.c
> @@ -367,6 +367,7 @@ static ssize_t bios_enabled_show(struct device *dev,
>         return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
>  }
>
> +#ifdef CONFIG_INTEL_MENLOW_SYSFS_ADDON
>  static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
>                                           void *store, struct device *dev,
>                                           acpi_handle handle)
> @@ -398,6 +399,14 @@ static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
>
>         return 0;
>  }
> +#else
> +static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
> +                                         void *store, struct device *dev,
> +                                         acpi_handle handle)
> +{
> +       return 0;
> +}

After looking at it once more, I think that this driver isn't really
functional without the additional sysfs attributes, so if
CONFIG_INTEL_MENLOW_SYSFS_ADDON is set, the driver effectively becomes
dead code.

That's rather unfortunate and I'm not sure how to deal with it ATM.

I can queue up the rest of the series for 6.4-rc1 (in which case it
will be pushed in the second half of the merge window), but this
particular patch requires more thought IMV.

> +#endif
>
>  static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>                                                 void *context, void **rv)
> --
