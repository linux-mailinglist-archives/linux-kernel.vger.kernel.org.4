Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134256BF03F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCQR5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCQR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:57:42 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54508E6FF5;
        Fri, 17 Mar 2023 10:57:39 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id cy23so23434223edb.12;
        Fri, 17 Mar 2023 10:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDgcAVjBczGkN4eerAmMX1c4Po3AXols1JIFfXaVzzU=;
        b=3qBdqtlD+dNbulJGZyAoWtPJ4bXureLydxQCZB1sI6OxXPYuHw0GBHyH8HNRXm7GHw
         1PxT+XEeIOBcjkdE2lmdcpWxhUJFZfYlruBvgspQuxgQLfIyscHDVpFLObvoykI/mCok
         mmBe8+PD5Otdn+XnovAaVxWbkVQ4Bhm2uPactiTGbiVZVzqE9h6jnQNcoSc/3gIVi+ey
         TFT7NNXCULblziEXwlhwK/RlvQ5na2VaJbiy/uxK7vUo0Ff7DPdDc4RLjbCAeR6y0ToP
         vWr+JXyLeGs6kpMO8cPpmFw8Yc8QDv5F3p+ykrutVh46BuA0NtjpXP/pVJE+ir77qd59
         qkAw==
X-Gm-Message-State: AO0yUKXbu/VP+SczdSnWIXLTNgpFe7+APQdsq34vVnrDCaRRwzGBua0e
        C0GLLfGDtEoX786f9uOoML9z/r0Jqq6b5W7Ivag=
X-Google-Smtp-Source: AK7set9yaiAcl1+k5BBNtiuntSNpH1nWsgFCTBeKpgmp296+3ytGQ5oVwLHHb4sEPcJ+i0yLkicvmd/Z13BklIgk2/A=
X-Received: by 2002:a50:d4cf:0:b0:4fb:c8e3:1adb with SMTP id
 e15-20020a50d4cf000000b004fbc8e31adbmr961317edj.3.1679075857719; Fri, 17 Mar
 2023 10:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230303195937.1835735-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230303195937.1835735-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 18:57:26 +0100
Message-ID: <CAJZ5v0joeZyohP6VWcbcqq3aGnVABxpNvCcVK-qkXkecGO4Geg@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/drivers/intel_menlow: Remove add_one_attribute
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:59 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The driver hooks the thermal framework sysfs to add some driver
> specific information. A debatable approach as that may belong the
> device sysfs directory, not the thermal zone directory.

Yes, this is questionable indeed.

Is there anything evidently broken by it?

> As the driver is accessing the thermal internals, we should provide at
> least an API to the thermal framework to add an attribute to the
> existing sysfs thermal zone entry.

Agreed.

> Before doing that and given the age of the driver (2008) may be it is
> worth to double check if these attributes are really needed. So my
> first proposal is to remove them if that does not hurt.

Honestly, I'm not really sure if that does not hurt.  Someone has
added them, presumably on purpose.

Maybe make them depend on a Kconfig option or a module parameter or
similar to start with?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
>  1 file changed, 193 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> index 5a6ad0552311..5a9738a93083 100644
> --- a/drivers/thermal/intel/intel_menlow.c
> +++ b/drivers/thermal/intel/intel_menlow.c
> @@ -230,174 +230,8 @@ struct intel_menlow_attribute {
>  static LIST_HEAD(intel_menlow_attr_list);
>  static DEFINE_MUTEX(intel_menlow_attr_lock);
>
> -/*
> - * sensor_get_auxtrip - get the current auxtrip value from sensor
> - * @handle: Object handle
> - * @index : GET_AUX1/GET_AUX0
> - * @value : The address will be fill by the value
> - */
> -static int sensor_get_auxtrip(acpi_handle handle, int index,
> -                                                       unsigned long long *value)
> -{
> -       acpi_status status;
> -
> -       if ((index != 0 && index != 1) || !value)
> -               return -EINVAL;
> -
> -       status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
> -                                      NULL, value);
> -       if (ACPI_FAILURE(status))
> -               return -EIO;
> -
> -       return 0;
> -}
> -
> -/*
> - * sensor_set_auxtrip - set the new auxtrip value to sensor
> - * @handle: Object handle
> - * @index : GET_AUX1/GET_AUX0
> - * @value : The value will be set
> - */
> -static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
> -{
> -       acpi_status status;
> -       union acpi_object arg = {
> -               ACPI_TYPE_INTEGER
> -       };
> -       struct acpi_object_list args = {
> -               1, &arg
> -       };
> -       unsigned long long temp;
> -
> -       if (index != 0 && index != 1)
> -               return -EINVAL;
> -
> -       status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
> -                                      NULL, &temp);
> -       if (ACPI_FAILURE(status))
> -               return -EIO;
> -       if ((index && value < temp) || (!index && value > temp))
> -               return -EINVAL;
> -
> -       arg.integer.value = value;
> -       status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
> -                                      &args, &temp);
> -       if (ACPI_FAILURE(status))
> -               return -EIO;
> -
> -       /* do we need to check the return value of SAX0/SAX1 ? */
> -
> -       return 0;
> -}
> -
> -#define to_intel_menlow_attr(_attr)    \
> -       container_of(_attr, struct intel_menlow_attribute, attr)
> -
> -static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
> -                       char *buf, int idx)
> -{
> -       struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> -       unsigned long long value;
> -       int result;
> -
> -       result = sensor_get_auxtrip(attr->handle, idx, &value);
> -       if (result)
> -               return result;
> -
> -       return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
> -}
> -
> -static ssize_t aux0_show(struct device *dev,
> -                        struct device_attribute *dev_attr, char *buf)
> -{
> -       return aux_show(dev, dev_attr, buf, 0);
> -}
> -
> -static ssize_t aux1_show(struct device *dev,
> -                        struct device_attribute *dev_attr, char *buf)
> -{
> -       return aux_show(dev, dev_attr, buf, 1);
> -}
> -
> -static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
> -                        const char *buf, size_t count, int idx)
> -{
> -       struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> -       int value;
> -       int result;
> -
> -       /*Sanity check; should be a positive integer */
> -       if (!sscanf(buf, "%d", &value))
> -               return -EINVAL;
> -
> -       if (value < 0)
> -               return -EINVAL;
> -
> -       result = sensor_set_auxtrip(attr->handle, idx,
> -                                   celsius_to_deci_kelvin(value));
> -       return result ? result : count;
> -}
> -
> -static ssize_t aux0_store(struct device *dev,
> -                         struct device_attribute *dev_attr,
> -                         const char *buf, size_t count)
> -{
> -       return aux_store(dev, dev_attr, buf, count, 0);
> -}
> -
> -static ssize_t aux1_store(struct device *dev,
> -                         struct device_attribute *dev_attr,
> -                         const char *buf, size_t count)
> -{
> -       return aux_store(dev, dev_attr, buf, count, 1);
> -}
> -
>  /* BIOS can enable/disable the thermal user application in dabney platform */
>  #define BIOS_ENABLED "\\_TZ.GSTS"
> -static ssize_t bios_enabled_show(struct device *dev,
> -                                struct device_attribute *attr, char *buf)
> -{
> -       acpi_status status;
> -       unsigned long long bios_enabled;
> -
> -       status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
> -       if (ACPI_FAILURE(status))
> -               return -ENODEV;
> -
> -       return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
> -}
> -
> -static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
> -                                         void *store, struct device *dev,
> -                                         acpi_handle handle)
> -{
> -       struct intel_menlow_attribute *attr;
> -       int result;
> -
> -       attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
> -       if (!attr)
> -               return -ENOMEM;
> -
> -       sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
> -       attr->attr.attr.name = name;
> -       attr->attr.attr.mode = mode;
> -       attr->attr.show = show;
> -       attr->attr.store = store;
> -       attr->device = dev;
> -       attr->handle = handle;
> -
> -       result = device_create_file(dev, &attr->attr);
> -       if (result) {
> -               kfree(attr);
> -               return result;
> -       }
> -
> -       mutex_lock(&intel_menlow_attr_lock);
> -       list_add_tail(&attr->node, &intel_menlow_attr_list);
> -       mutex_unlock(&intel_menlow_attr_lock);
> -
> -       return 0;
> -}
>
>  static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>                                                 void *context, void **rv)
> @@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>         if (ACPI_FAILURE(status))
>                 return (status == AE_NOT_FOUND) ? AE_OK : status;
>
> -       result = intel_menlow_add_one_attribute("aux0", 0644,
> -                                               aux0_show, aux0_store,
> -                                               &thermal->device, handle);
> -       if (result)
> -               return AE_ERROR;
> -
>         status = acpi_get_handle(handle, GET_AUX1, &dummy);
>         if (ACPI_FAILURE(status))
>                 goto aux1_not_found;
> @@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>         if (ACPI_FAILURE(status))
>                 goto aux1_not_found;
>
> -       result = intel_menlow_add_one_attribute("aux1", 0644,
> -                                               aux1_show, aux1_store,
> -                                               &thermal->device, handle);
> -       if (result) {
> -               intel_menlow_unregister_sensor();
> -               return AE_ERROR;
> -       }
> -
> -       /*
> -        * create the "dabney_enabled" attribute which means the user app
> -        * should be loaded or not
> -        */
> -
> -       result = intel_menlow_add_one_attribute("bios_enabled", 0444,
> -                                               bios_enabled_show, NULL,
> -                                               &thermal->device, handle);
> -       if (result) {
> -               intel_menlow_unregister_sensor();
> -               return AE_ERROR;
> -       }
> -
>         return AE_OK;
>
>   aux1_not_found:
> --
> 2.34.1
>
