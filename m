Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9A6CC67C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjC1Pfh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjC1Pff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:35:35 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7259C;
        Tue, 28 Mar 2023 08:35:34 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id h8so51410578ede.8;
        Tue, 28 Mar 2023 08:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S03XGyw3tSneSt4wS8/md52lGSHJdyFmoRVLM1Uorzo=;
        b=FFl1hCrR4IPqPxcyFVUrUn9Z4V8OLPVrwxglKQ0DA05itj1q/87Um9Z5MdQTztp1OG
         FxYa2zM85Lm1eWlaKqF1TrKqMnJWuu2XlTOjI1zHlwhEjxaqqcjEW8QiS31vSVydfJi6
         EQ/G9sOtTTXrlIU/gcc8aZBp5nP+ZR6IcYaIV2ovcCUtV6b5egaoVcDI0q5wTxv/4bfk
         KU3HT/6K0GdbLYIKV1+g0yvG98KyPoAc75v1F+3VaRcNvlk1RPi1qqVUWOlDrEXlOaRC
         Z6y9ySuZ1hcY0WTMG9g1MkoR5nVdrpKGhPajgdMJVe/Nd+nD9HWyC4ik+6DnjLNYahw+
         QBrQ==
X-Gm-Message-State: AAQBX9clY0Yaai1I/rQpaaFBJUnshlZmsJaWomELpAHzNsMqtxRYXxXF
        NgprDp9GSkaNN4A41Fd9y81Ib49E3Pii+IvHPp90Ckcm8jA=
X-Google-Smtp-Source: AKy350Ycdnkt0zM+ZjM612jMXQa+FSmfgRrY8JDpwsCJ5kSu/cdrdhPLqh+KB3+ZxDLWkKd3fcN6PsiIUXpbjFVzapI=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr8617564ejb.2.1680017732662; Tue, 28 Mar
 2023 08:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <10247847.nUPlyArG6x@kreacher> <ZCIDTLFt27Ei7+V6@ideak-desk.fi.intel.com>
In-Reply-To: <ZCIDTLFt27Ei7+V6@ideak-desk.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Mar 2023 17:35:21 +0200
Message-ID: <CAJZ5v0iguCBqJCkMTMWzkfak5cBryvuA0+9QyurO308n0pJA6g@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: core: Introduce thermal_cooling_device_update()
To:     imre.deak@intel.com
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
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

On Mon, Mar 27, 2023 at 10:58 PM Imre Deak <imre.deak@intel.com> wrote:
>
> Hi,
>
> this leads to the stacktrace below triggered by
> lockdep_assert_held(&cdev->lock) in cooling_device_stats_setup(),

Thanks for the report!

> and
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 566df4522b885..132175b14814f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -918,7 +918,9 @@ __thermal_cooling_device_register(struct device_node *np,
>         if (ret)
>                 goto out_cdev_type;
>
> +       mutex_lock(&cdev->lock);
>         thermal_cooling_device_setup_sysfs(cdev);
> +       mutex_unlock(&cdev->lock);
>
>         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>         if (ret)
>
> fixed it up for me, but not sure if it's the correct fix.

There are other cases when the lockdep_assert_held() annotations may
trigger, so it is better to remove them from
cooling_device_stats_setup() and cooling_device_stats_destroy() and to
put one into thermal_cooling_device_stats_reinit().

I'll send a patch to do that later today.

> [    4.662358] ------------[ cut here ]------------
> [    4.662361] WARNING: CPU: 3 PID: 1 at drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xb4/0xc0
> [    4.662370] Modules linked in:
> [    4.662375] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G          I        6.3.0-rc4-imre+ #771
> [    4.662379] Hardware name: Intel Corporation Shark Bay Client platform/Flathead Creek Crb, BIOS HSWLPTU1.86C.0109.R03.1301282055 01/28/2013
> [    4.662382] RIP: 0010:cooling_device_stats_setup+0xb4/0xc0
> [    4.662387] Code: 89 1d 58 52 36 01 5b 41 5c 41 5d 5d c3 cc cc cc cc 48 8d bf 18 05 00 00 be ff ff ff ff e8 f4 d2 3e 00 85 c0 0f 85 6f ff ff ff <0f> 0b e9 68 ff ff ff 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
> [    4.662390] RSP: 0000:ffff9f48c0057b30 EFLAGS: 00010246
> [    4.662395] RAX: 0000000000000000 RBX: ffff8fc381ca9800 RCX: 0000000000000000
> [    4.662398] RDX: 0000000000000000 RSI: ffffffff94ad1d28 RDI: ffffffff94b58cc6
> [    4.662401] RBP: ffff9f48c0057b48 R08: 0000000000000004 R09: 0000000000000000
> [    4.662404] R10: ffff8fc381c77cd0 R11: 0000000000000000 R12: 0000000000000002
> [    4.662406] R13: ffff8fc381ca9800 R14: ffff8fc381b0a000 R15: 0000000000000000
> [    4.662409] FS:  0000000000000000(0000) GS:ffff8fc6b5580000(0000) knlGS:0000000000000000
> [    4.662412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.662415] CR2: 0000000000000000 CR3: 0000000283856001 CR4: 00000000001706e0
> [    4.662418] Call Trace:
> [    4.662421]  <TASK>
> [    4.662427]  thermal_cooling_device_setup_sysfs+0x12/0x30
> [    4.662433]  __thermal_cooling_device_register+0x195/0x410
> [    4.662442]  thermal_cooling_device_register+0x19/0x20
> [    4.662446]  acpi_fan_probe+0xd7/0x5a0
> [    4.662458]  ? acpi_match_device_ids+0x12/0x20
> [    4.662464]  ? acpi_dev_pm_attach+0x41/0x110
> [    4.662473]  platform_probe+0x48/0xc0
> [    4.662481]  really_probe+0x1be/0x420
> [    4.662487]  __driver_probe_device+0x8c/0x190
> [    4.662493]  driver_probe_device+0x24/0x90
> [    4.662498]  __driver_attach+0xf7/0x200
> [    4.662503]  ? __pfx___driver_attach+0x10/0x10
> [    4.662507]  bus_for_each_dev+0x80/0xd0
> [    4.662516]  driver_attach+0x1e/0x30
> [    4.662522]  bus_add_driver+0x11f/0x230
> [    4.662530]  driver_register+0x5e/0x120
> [    4.662534]  ? __pfx_acpi_fan_driver_init+0x10/0x10
> [    4.662540]  __platform_driver_register+0x1e/0x30
> [    4.662545]  acpi_fan_driver_init+0x17/0x20
> [    4.662549]  do_one_initcall+0x61/0x280
> [    4.662559]  ? debug_smp_processor_id+0x17/0x20
> [    4.662568]  kernel_init_freeable+0x411/0x640
> [    4.662582]  ? __pfx_kernel_init+0x10/0x10
> [    4.662589]  kernel_init+0x1b/0x1f0
> [    4.662594]  ? __pfx_kernel_init+0x10/0x10
> [    4.662599]  ret_from_fork+0x2c/0x50
> [    4.662615]  </TASK>
> [    4.662618] irq event stamp: 506869
> [    4.662620] hardirqs last  enabled at (506875): [<ffffffff9338e2d8>] __up_console_sem+0x68/0x80
> [    4.662625] hardirqs last disabled at (506880): [<ffffffff9338e2bd>] __up_console_sem+0x4d/0x80
> [    4.662628] softirqs last  enabled at (504698): [<ffffffff932de49f>] __irq_exit_rcu+0xbf/0x140
> [    4.662633] softirqs last disabled at (504689): [<ffffffff932de49f>] __irq_exit_rcu+0xbf/0x140
> [    4.662636] ---[ end trace 0000000000000000 ]---
> [    4.662779] ------------[ cut here ]------------
