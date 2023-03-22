Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12616C4D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjCVO2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjCVO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:27:59 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC035B2;
        Wed, 22 Mar 2023 07:27:58 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id w9so73798140edc.3;
        Wed, 22 Mar 2023 07:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3g7V0ZtaYCJ08ekmgYYgxlOXyguJ5wpLG7Fm+NVbfs=;
        b=Sed+AhcRktJIjBI3KNaQERm67qzRiuw3U2pZuGxxZzq0IzTSST7PWYY3VEsl8qqt1p
         XjLROe6rN3PQNaD7tIet4Nt2QwxJ5GJndjx01zsTrVyFnq+XzS0DvCpXIl6zoY2pUhl2
         NrJ8lUBFInppOmkUmM2a0MdzYDg9xdufmhqU+JVoKqfEzhidqF1kWwq93vmk2JQ3Qmmb
         Na6sxKfedSC8BuBue8clhFq4rT0PcFoKFNhXfqQZvixkNTK5NcSNMKk78PxnKSjoV1KA
         XjzZwMV37l8MsWaRnALJhsV4ZBsStAr4OpwCTUdt9DyzH4Hg0GT2jOuqkm//mIJlNTlb
         w/2Q==
X-Gm-Message-State: AO0yUKVYT5j8KvtxuFljSgG8hbFZjumt0BGWlTs1116QDpzQdusl05ZA
        D8apfQpsGRdQYjo1FWkCL1e0JboqhRtaXRIlVgE=
X-Google-Smtp-Source: AK7set99yZ5uGOciVCUzVwWAsJHFIwbKSK27uzSOVjBnuial2wp9366vcARstqlfqHBvumCxVCE47cKMecudCQ5E8O8=
X-Received: by 2002:a50:8d04:0:b0:4fc:ebe2:2fc9 with SMTP id
 s4-20020a508d04000000b004fcebe22fc9mr3682902eds.3.1679495276403; Wed, 22 Mar
 2023 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
 <20230322090557.2943479-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230322090557.2943479-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 15:27:45 +0100
Message-ID: <CAJZ5v0h_oTjn5FGuyDvGzewY9VDqo7U0YN1X+XZcsQqLhtNCSg@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] cpuidle: move to use bus_get_dev_root()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
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

On Wed, Mar 22, 2023 at 10:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> This allows us to clean up the cpuidle_add_interface() call a bit as it
> was only called in one place, with the same argument so just put that
> into the function itself.  Note that cpuidle_remove_interface() should
> also probably be removed in the future as there are no callers of it for
> some reason.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: - reworked cpuidle_add_interface() to exit early if dev_root is not
>       valid based on review from Rafael.
>
>  drivers/cpuidle/cpuidle.c |  2 +-
>  drivers/cpuidle/cpuidle.h |  2 +-
>  drivers/cpuidle/sysfs.c   | 13 ++++++++++---
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0b00f21cefe3..8e929f6602ce 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -808,7 +808,7 @@ static int __init cpuidle_init(void)
>         if (cpuidle_disabled())
>                 return -ENODEV;
>
> -       return cpuidle_add_interface(cpu_subsys.dev_root);
> +       return cpuidle_add_interface();
>  }
>
>  module_param(off, int, 0444);
> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> index 9f336af17fa6..52701d9588f1 100644
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -30,7 +30,7 @@ extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
>
>  struct device;
>
> -extern int cpuidle_add_interface(struct device *dev);
> +extern int cpuidle_add_interface(void);
>  extern void cpuidle_remove_interface(struct device *dev);
>  extern int cpuidle_add_device_sysfs(struct cpuidle_device *device);
>  extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 48948b171749..d6f5da61cb7d 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -119,11 +119,18 @@ static struct attribute_group cpuidle_attr_group = {
>
>  /**
>   * cpuidle_add_interface - add CPU global sysfs attributes
> - * @dev: the target device
>   */
> -int cpuidle_add_interface(struct device *dev)
> +int cpuidle_add_interface(void)
>  {
> -       return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
> +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> +       int retval;
> +
> +       if (!dev_root)
> +               return -EINVAL;
> +
> +       retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
> +       put_device(dev_root);
> +       return retval;
>  }
>
>  /**
> --
> 2.40.0
>
