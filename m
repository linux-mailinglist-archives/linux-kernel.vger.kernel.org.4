Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D10623329
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiKITID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKITIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:08:00 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBE2612E;
        Wed,  9 Nov 2022 11:08:00 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id ml12so12975472qvb.0;
        Wed, 09 Nov 2022 11:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m90qWsP9QUgMhaLVVQ3ljcP2B/8PqySGVmAv+ffgTyE=;
        b=JI63ea6dKKUKEHN2KL+C1Y86sYzUplUcsyn+WXJkZJ9MD1WJs6pC3BBTxU9KZEWHMV
         Z9rw6igiuJ30WXjoexUa4jHm50zORHlfezHRboxsLEIliqsplbHifyEkgtpEWgrndpVF
         s5+Fub7cBGIodDXHqm1wQo0A1js5PBeRrjgLkJ1GMGtmlIfvkTEZMH2Uq7ZOjyhsKwaE
         HN/3YAu2Govl4HHFuyZEspBLhUw/PLlC4qGoJhHshQSSMM2+wVVXhjJkzXhKof2rRhny
         NrjlPetRF+WaP9+95JIWKChYesm0SWx3mfabRc5ZkXN+GGY6ZkONXrDrsmwKUNnEBr1Q
         LJGg==
X-Gm-Message-State: ACrzQf22a91tRotXZkfNgxQQVQWC5IRF9MhjzDSIHP1q8oMc2J8bUQZY
        J5BreSe0H4LOExwgiqDwze+FVPoPhVackpTma2k=
X-Google-Smtp-Source: AMsMyM7glMwCZCne2pzTPDl08Wsgzx7UmlW8Fnyv/XQUH+Gg5jm6xHf47fW2S0l8NSERNNEmpX4KoRjzHvcuEMmx574=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr55956999qvb.119.1668020879136; Wed, 09
 Nov 2022 11:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-4-linux@roeck-us.net>
In-Reply-To: <20221017130910.2307118-4-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:07:48 +0100
Message-ID: <CAJZ5v0hcwCqfSh32U5zVnpBxmziJHYYCfhJ9uJLJ0gVvkrP-5w@mail.gmail.com>
Subject: Re: [PATCH 3/9] thermal/core: Ensure that thermal device is
 registered in thermal_zone_get_temp
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Calls to thermal_zone_get_temp() are not protected against thermal zone
> device removal. As result, it is possible that the thermal zone operations
> callbacks are no longer valid when thermal_zone_get_temp() is called.
> This may result in crashes such as
>
> BUG: unable to handle page fault for address: ffffffffc04ef420
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
> PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
> Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
> RIP: 0010:thermal_zone_get_temp+0x26/0x73
> Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
> RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
> RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
> RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
> RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
> R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
> R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
> FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
> Call Trace:
>  temp_show+0x31/0x68
>  dev_attr_show+0x1d/0x4f
>  sysfs_kf_seq_show+0x92/0x107
>  seq_read_iter+0xf5/0x3f2
>  vfs_read+0x205/0x379
>  __x64_sys_read+0x7c/0xe2
>  do_syscall_64+0x43/0x55
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> if a thermal device is removed while accesses to its device attributes
> are ongoing.
>
> The problem is exposed by code in iwl_op_mode_mvm_start(), which registers
> a thermal zone device only to unregister it shortly afterwards if an
> unrelated failure is encountered while accessing the hardware.
>
> Check if the thermal zone device is registered after acquiring the
> thermal zone device mutex to ensure this does not happen.
>
> The code was tested by triggering the failure in iwl_op_mode_mvm_start()
> on purpose. Without this patch, the kernel crashes reliably. The crash
> is no longer observed after applying this and the preceding patches.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_helpers.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index c65cdce8f856..3bac0b7a4c62 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -115,7 +115,12 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>         int ret;
>
>         mutex_lock(&tz->lock);
> +       if (!device_is_registered(&tz->device)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
>         ret = __thermal_zone_get_temp(tz, temp);
> +unlock:

I would do it this way:

if (device_is_registered(&tz->device))
        ret = __thermal_zone_get_temp(tz, temp);
else
        ret = -ENODEV;

>         mutex_unlock(&tz->lock);
>
>         return ret;
> --
