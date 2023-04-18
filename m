Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303D6E6642
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDRNrQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjDRNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:12 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069C10DE;
        Tue, 18 Apr 2023 06:47:09 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso39005866b.1;
        Tue, 18 Apr 2023 06:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825628; x=1684417628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0it5Gyywpzjx656E1BMStY14yZFRaPYvlQ79aq7Hjk=;
        b=HKOt+PK4qRisGc9TFtL0FoiFbOrQSe4xPOo9q8jT/DUPbiVMbU1ad/JynOVR6td9CJ
         C7CgPYRrErraTeZsIMuSuoUTgBo/veXHfO3NXKSjKj+ypSRKplfmAqmWgsccA67H54VM
         OUjuQ2hMM6ipB1icMYtIKkWE69oUdNm1UGOuYtceWX7Z25UmYG9jQXdxwtyHU8EzO4zf
         csElmGiudNg7bB3meGVkLN3rBFk7R2t+5zNmYe2oAQZoQQOuTeeI3ycjF3giJbkJEX9S
         CKtyIZW8FYNZ56UzI3P0iw21iQwY2ayyKDuTWVKFChnYLzvIB2JAHdtM+m+sJsfUgTsH
         jn4A==
X-Gm-Message-State: AAQBX9efBn3RqMCyt/4CeQi9EW8E2Oju2ZfrpHXGogFUynJw+CCI1yxN
        ai6SUN3cH5Ea+8cZ+BQoyFiLo9oZtPNFFI2SbiQ=
X-Google-Smtp-Source: AKy350YPVqsMmtOPbj1y0kixCmJ+eNSXg9nqWCx7kernImrZCqven+WrbT9XEVcFyouKMo0j6y3buROtpEHrfy2GKbA=
X-Received: by 2002:a17:906:74c8:b0:94e:d688:fca6 with SMTP id
 z8-20020a17090674c800b0094ed688fca6mr11454390ejl.0.1681825627987; Tue, 18 Apr
 2023 06:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org> <20230413114647.3878792-7-daniel.lezcano@linaro.org>
In-Reply-To: <20230413114647.3878792-7-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:46:56 +0200
Message-ID: <CAJZ5v0jTC4v+gPey8Yp_U2H4cp8-p-tTRNv4RT1=rsQ6kD_5fA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] thermal/drivers/intel_menlow: Make additionnal
 sysfs information optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
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

On Thu, Apr 13, 2023 at 1:47 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The Menlon thermal driver creates specific files in the thermal zone
> sysfs class. It is specific to Menlon and these entries look debug
> code. It is probable these are not needed.
>
> Let's make the code optional and disable it by default.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/Kconfig        | 11 +++++++++++
>  drivers/thermal/intel/intel_menlow.c |  3 +++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index cb7e7697cf1e..1405d9cd2bab 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -112,6 +112,17 @@ config INTEL_MENLOW
>
>           If unsure, say N.
>
> +config INTEL_MENLOW_SYSFS_ADDON
> +       bool "Enable thermal sysfs addon"
> +       depends on INTEL_MENLOW
> +       def_bool n
> +       help
> +        Enable sysfs extra information added in the thermal

This should be something like "Enable extra sysfs attributes in the
thermal zone."

> +        zone. This is specific to this driver. By default those are
> +        disabled and are candidate for removal, if you need these
> +        information anyway, enable the option or upgrade the
> +        userspace program using them.

The above part of the help text doesn't add much value IMV.  It would
be far better to say what the extra attributes are for instead.

> +
>  config INTEL_HFI_THERMAL
>         bool "Intel Hardware Feedback Interface"
>         depends on NET
> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> index d720add918ff..a169d7e4f537 100644
> --- a/drivers/thermal/intel/intel_menlow.c
> +++ b/drivers/thermal/intel/intel_menlow.c
> @@ -374,6 +374,9 @@ static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
>         struct intel_menlow_attribute *attr;
>         int result;
>
> +       if (!IS_ENABLED(CONFIG_INTEL_MENLOW_SYSFS_ADDON))
> +               return 0;

IMV it would be cleaner to put all of the relevant code under the
Kconfig option, so it is clear that it goes away when that option is
not set.

I'm not sure what the compiler will do with it in the current form.

> +
>         attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
>         if (!attr)
>                 return -ENOMEM;
> --
