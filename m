Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E136D00AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjC3KH2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjC3KH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:07:26 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91DB0;
        Thu, 30 Mar 2023 03:07:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id r11so74321125edd.5;
        Thu, 30 Mar 2023 03:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvEjtWJx3cZceF++2Dm4Xv1D1mJF+XmnWd+65BDo320=;
        b=LpoJgxrd7Nd8pcjMaBCO0HdVAQOp/dbwTIRgn2iIMKMu3pfORUYNF+JxhgZOmZ58FM
         z/471M562U9jr9d0oldkQP9Cdt6j+9G8XBvqrgObLuQ7g0qU47sAZtUaPNHPhD70IUOp
         vZBmLsXkmcL71xY7jY1c1kf58ExXz589Wyvx2lar26norE1qP32WiNtu4+wFLL3V7OJC
         ekfn6W3gMLhrH3t/BM4kLQt70fT3ZXaLrjcOLHgSjtHMIs5jqlYKmu6RmPAsIjtWxOK3
         2rIfq9CxFgMAdUs3yaPq5kXQ2rPgWisP4kepKVystduKqNXGZ6is/POH0kMAIh7CY5ST
         gxKA==
X-Gm-Message-State: AAQBX9foAPluwtIJn/UbezxJm05csKnM88JcdL5+/76xiPX6VSqP7RTb
        Bmjy03CYSjOlX0MQc2eL1gcxg6eZkliC+dw0TwY=
X-Google-Smtp-Source: AKy350bbIJNmv5v0ZMtWilvLjDEulMsgxu4uajx7iqvyQskJCnwCaqVHzla5TFM3ywhX815/ufBnAtO3e9M6OM0zesQ=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr12300921ejb.2.1680170844023; Thu, 30
 Mar 2023 03:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNcKc9BP0t1q=TaFF6fjjJU-MNcoLt_LT1rVKbHsUXiAw@mail.gmail.com>
In-Reply-To: <CABXGCsNcKc9BP0t1q=TaFF6fjjJU-MNcoLt_LT1rVKbHsUXiAw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 12:07:12 +0200
Message-ID: <CAJZ5v0jv0BYE1pgCEJDsadfzH0ZnZYfwJuScPMQcpFYSJPYL6w@mail.gmail.com>
Subject: Re: [bug/6.3-rc4/bisected] WARNING at cooling_device_stats_setup+0xac
 caused by commit 790930f44289c8209c57461b2db499fcc702e0b3
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     rafael.j.wysocki@intel.com, rui.zhang@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
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

On Thu, Mar 30, 2023 at 9:52 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> The release 6.3-rc4 brings new warning messages to log:

Thanks for the report, please see this patch:

https://patchwork.kernel.org/project/linux-pm/patch/2681615.mvXUDI8C0e@kreacher/

> [    4.590775] ------------[ cut here ]------------
> [    4.590783] WARNING: CPU: 2 PID: 1 at
> drivers/thermal/thermal_sysfs.c:879
> cooling_device_stats_setup+0xac/0xc0
> [    4.590799] Modules linked in:
> [    4.590806] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 6.3.0-rc3-08-790930f44289c8209c57461b2db499fcc702e0b3+ #87
> [    4.590819] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
> G513QY_G513QY/G513QY, BIOS G513QY.320 09/07/2022
> [    4.590832] RIP: 0010:cooling_device_stats_setup+0xac/0xc0
> [    4.590841] Code: ff 48 89 1d 9e 27 9f 01 5b 5d 41 5c c3 cc cc cc
> cc 48 8d bf 60 05 00 00 be ff ff ff ff e8 5c 16 3b 00 85 c0 0f 85 72
> ff ff ff <0f> 0b e9 6b ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
> 90 90
> [    4.590863] RSP: 0018:ffffa5a080107c60 EFLAGS: 00010246
> [    4.590871] RAX: 0000000000000000 RBX: ffff96fc51f6d800 RCX: 0000000000000001
> [    4.590880] RDX: 0000000000000000 RSI: ffffffffb9a7f591 RDI: ffffffffb9b325ce
> [    4.590889] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
> [    4.590898] R10: 0000000000000001 R11: 0000000000000001 R12: ffff96fc51f6d800
> [    4.590907] R13: ffff96fc51f6d818 R14: ffff96fc4b450000 R15: 0000000000000000
> [    4.590916] FS:  0000000000000000(0000) GS:ffff970b16a00000(0000)
> knlGS:0000000000000000
> [    4.590927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.590934] CR2: 0000000000000000 CR3: 000000034643c000 CR4: 0000000000750ee0
> [    4.590944] PKRU: 55555554
> [    4.590948] Call Trace:
> [    4.590953]  <TASK>
> [    4.590958]  thermal_cooling_device_setup_sysfs+0xe/0x20
> [    4.590967]  __thermal_cooling_device_register.part.0+0x13c/0x3d0
> [    4.590977]  acpi_processor_thermal_init+0x22/0x100
> [    4.590987]  __acpi_processor_start+0x7f/0xf0
> [    4.590995]  acpi_processor_start+0x2c/0x50
> [    4.591002]  really_probe+0x19e/0x3e0
> [    4.591010]  ? __pfx___driver_attach+0x10/0x10
> [    4.591017]  __driver_probe_device+0x78/0x160
> [    4.591025]  driver_probe_device+0x1f/0x90
> [    4.591032]  __driver_attach+0xd2/0x1c0
> [    4.591039]  bus_for_each_dev+0x8b/0xe0
> [    4.591047]  bus_add_driver+0x115/0x210
> [    4.591055]  driver_register+0x55/0x100
> [    4.591062]  ? __pfx_acpi_processor_driver_init+0x10/0x10
> [    4.591072]  acpi_processor_driver_init+0x3b/0xc0
> [    4.591080]  ? __pfx_acpi_processor_driver_init+0x10/0x10
> [    4.591088]  do_one_initcall+0x70/0x290
> [    4.591101]  kernel_init_freeable+0x3c5/0x580
> [    4.591112]  ? __pfx_kernel_init+0x10/0x10
> [    4.591122]  kernel_init+0x16/0x1c0
> [    4.591128]  ret_from_fork+0x2c/0x50
> [    4.591139]  </TASK>
>
> This message appears after each boot.
>
> Bisect blaming this commit:
>
> commit 790930f44289c8209c57461b2db499fcc702e0b3
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Fri Mar 17 18:01:26 2023 +0100
>
>     thermal: core: Introduce thermal_cooling_device_update()
>
>     Introduce a core thermal API function, thermal_cooling_device_update(),
>     for updating the max_state value for a cooling device and rearranging
>     its statistics in sysfs after a possible change of its ->get_max_state()
>     callback return value.
>
>     That callback is now invoked only once, during cooling device
>     registration, to populate the max_state field in the cooling device
>     object, so if its return value changes, it needs to be invoked again
>     and the new return value needs to be stored as max_state.  Moreover,
>     the statistics presented in sysfs need to be rearranged in general,
>     because there may not be enough room in them to store data for all
>     of the possible states (in the case when max_state grows).
>
>     The new function takes care of that (and some other minor things
>     related to it), but some extra locking and lockdep annotations are
>     added in several places too to protect against crashes in the cases
>     when the statistics are not present or when a stale max_state value
>     might be used by sysfs attributes.
>
>     Note that the actual user of the new function will be added separately.
>
>     Link: https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Tested-by: Zhang Rui <rui.zhang@intel.com>
>     Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>
>  drivers/thermal/thermal_core.c  | 83 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/thermal/thermal_core.h  |  2 +
>  drivers/thermal/thermal_sysfs.c | 74 +++++++++++++++++++++++++++++++-----
>  include/linux/thermal.h         |  1 +
>  4 files changed, 150 insertions(+), 10 deletions(-)
>
> All my PCs turned up affected by this issue:
> - CPU: Ryzen 3950X / MB: ROG Strix X570-I
> - CPU Ruzen 7950X / MB: MPG B650I EDGE WIFI
> - Laptop: ASUS ROG Strix G15 G513QY-HF001 (CPU: 5900HX)
>
> Unfortunately I couldn't check revert this commit, because after
> reverting the kernel does not build.
>
> drivers/acpi/processor_thermal.c: In function ‘acpi_thermal_cpufreq_init’:
> drivers/acpi/processor_thermal.c:149:17: error: implicit declaration
> of function ‘thermal_cooling_device_update’; did you mean
> ‘thermal_zone_device_update’? [-Werror=implicit-function-declaration]
>   149 |                 thermal_cooling_device_update(pr->cdev);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 thermal_zone_device_update
>
>
> Who wants to see the full kernel log could see an attached archive (for laptop).
>
> --
> Best Regards,
> Mike Gavrilov.
