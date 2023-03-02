Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C86A897F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBT3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:29:22 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A612822D;
        Thu,  2 Mar 2023 11:29:21 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id f13so1342109edz.6;
        Thu, 02 Mar 2023 11:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzNXwDIp4k4ggsPIp85maMqW+jQ4SxcHrsy0lA0clAc=;
        b=o6hvPh8TeHu+vJyoWjpX24fnmlWWaqFTNP16fW4dcXd/K7fvCWQhM9saP8XkDn2XNW
         sSpMm9u0sZoasMqYJTKhLr4eDSk+OXClputZdY0jyBsMd7FEuFCW876LfFs5v8o11+OB
         el0UlpB8p9zgsDEhpW7dO7hnTNwAxGhVITeKwk4ZXjLhx1ToTS5Da/9YxLQMZqMbEosR
         EP49Mc/679wEn2fqY2DS/jhsE3zWfy99tljZo2t8WlzALaIKzdRvAcjdFcvrryFeGrvt
         p5uZwg5Rb2q45f7SZoaLgcVPAwmJIeGXCcZBdLDRQXnzIRFPj9iWfR/oEI4b+wy97Fl8
         yq7w==
X-Gm-Message-State: AO0yUKVQfliBK6ccIOV+Zxyz01TUDZ3DktfS7WsO4IqAUgGITHJAsPgb
        0eoTJQvZPz4VGrD3WzGXFF0r/NAp2vdR/jfNqpzwAc05
X-Google-Smtp-Source: AK7set8IbZQKevSi0064SjOEgjyHdLcBI7RyWN7U4jQvfvoc/HkanTJ0UrmuCXhGCxjJBXnRHeh7IvQtJHOuH87reyI=
X-Received: by 2002:a50:cc88:0:b0:4ae:e548:1c6 with SMTP id
 q8-20020a50cc88000000b004aee54801c6mr6726660edi.6.1677785359892; Thu, 02 Mar
 2023 11:29:19 -0800 (PST)
MIME-Version: 1.0
References: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
In-Reply-To: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Mar 2023 20:29:08 +0100
Message-ID: <CAJZ5v0gwusznVACJ6etnDCNBPLFuq9r-wroq5JARfoTzgQZAfQ@mail.gmail.com>
Subject: Re: [Regression] cached max_state breaks ACPI processor cooling device
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, Feb 25, 2023 at 6:30 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Hi, All,
>
> Starting from commit c408b3d1d9bb("thermal: Validate new state in
> cur_state_store()") and commit a365105c685c("thermal: sysfs: Reuse
> cdev->max_state"), the cdev->get_max_state() is evaluated only once
> during cooling device registration.
>
> This is done to fix the below Smatch static checker warning:
>         drivers/thermal/thermal_sysfs.c:656 thermal_cooling_device_stats_update()
>         warn: potential integer overflow from user 'stats->state *
> stats->max_states + new_state'
> reported here https://lore.kernel.org/all/Y0ltRJRjO7AkawvE@kili/.
>
> But this actually breaks cooling devices which could have dynamic max
> cooling state, like ACPI processor cooling device.
>
> acpi_processor_driver_init
>         driver_register(&acpi_processor_driver);
>                 acpi_processor_start
>                         acpi_processor_thermal_init
>                                 thermal_cooling_device_register
>                                         processor_get_max_state
>         acpi_processor_cpufreq_init = true
> The driver doesn't count cpufreq as cooling state until
> acpi_processor_cpufreq_init is set later.
>
> As a result, without the commits above,
> /sys/class/thermal/cooling_device10/cur_state:0
> /sys/class/thermal/cooling_device10/max_state:3
> /sys/class/thermal/cooling_device10/type:Processor
> after the commits above,
> /sys/class/thermal/cooling_device10/cur_state:0
> /sys/class/thermal/cooling_device10/max_state:0
> /sys/class/thermal/cooling_device10/type:Processor
>
> In order to fix this, there are something worth clarification IMO.
> 1. should we support dynamic max_state or not?
>    ACPI processor cooling state is a combination of processor p-states
>    and t-states.
>    t-states are static, but p-states can vary depends on processor
>    frequency driver loaded or not.
>    I'm not sure if there is any other user like this, but still this
>    is a valid use case of dynamic max_state.
> 2. how to handle dynamic max_state for cooling device statistics in
>    sysfs?
>    IMO, when max_state changes, the definition of previous cooling
>    device is changed as well, thus we should abandon the previous
>    statistics and restart counting.
> 3. anything else needs to be handled when max_state changes?
>    Say, as the definition of each cooling state is changed when
>    max_state changes, should we invalidate and re-update the
>    thermal instances of this cdev in each thermal zone device?
> 4. how to detect/handle max cooling states changes?
>    Should we do this as before, which invokes .get_max_state()
>    everywhere and do updates when necessary ,

No.

>  or
>    a. cache max_state like we do today
>    b. introduce a new API for max_state change
>    c. invoke the new API in the cooling device driver explicitly when
>       max_state changes
>    d. update cached max_state value, statistics sysfs and
>       thermal_instances in the API
>    e. remove .get_max_state() callback as we register and update the
>       max_state with a fixed value each time.

Yes, IMO.
