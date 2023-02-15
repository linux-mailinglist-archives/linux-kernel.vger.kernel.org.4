Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB48E69729A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBOARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBOARm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:17:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B18301A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:17:41 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id u75so11379787pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49K1SGeEsD5aesWP7FDsHkUnjeFT5dcvalIp3zIlHsw=;
        b=V75C9Q3Zm3+1G94MWsxwQyX/S8btV8YDkSy1akRXEGYEIgk3KLv7c+Ayz+TUK2uTjj
         4CAViuS2sz7D9Em8sIJN7RHh/zbZ53GwpJCfoQIzy3t1eperCII0C7R+NHQ2Qt/EsVn7
         M3pB5/FqUsdCJFr5L5iNf3ZKIqxHH5Bi9XVTqQAmh4hY+b7+FFcu6fRyl5LCsXsuQHhd
         KNn3IunLqPf4247WiVmqeNmcWVcBXEbu1NRqsCC+FchYUK6GyMslgAFFtvIwvrQBEHF7
         0PFnHupEbDbWR2mfphUcCRicvASoYa60Vw6PF0ebypXP95cGGwj7YRUt4C3WRYbklisc
         DodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49K1SGeEsD5aesWP7FDsHkUnjeFT5dcvalIp3zIlHsw=;
        b=Pog+s54X06Y5Ob4TW1OgVWUgn5/4CEgusD+7fbbBjWYojV+fSvQNgeVZUk0cJx7zF1
         SlDS78gRZz3JwyeZO/sEYNasO07vnWp9crikqxVz2qdtjSV+3jqt3Bx4VpqI8De4cDjg
         yJ7xN/wdZSlPeKkzal+qcYU7EqVi3JYsRgDABoN39hALCCxVTmvq4zqV9twkpG8WdzF5
         BByuuF+nzmdHgwegoIZzlFNjDXR34rSVtQWpRlSRmBlgYl0I8FhPKnFaC+y5uZmD2MiJ
         qcAW/pS+rKy0Mw8u8MHOBU7PQIFG7wgEKR44AUWmjZU7J7uIjCN2p0w8WU4IILKhEYzp
         zOrQ==
X-Gm-Message-State: AO0yUKXDqSIltvxunjZ3ISkdwd1IOchjlkZI7YfvzYcS8kvudfKTkVKg
        70WLX8rGOXbsNMvYd4m1Ekx2jg==
X-Google-Smtp-Source: AK7set+FcSEX2KIayzVpc9dxLfpS02jLRApEgFCsNa/U9uiRYyh5Z/vDMFwT1L+IQS6a1lGdYiDcuA==
X-Received: by 2002:aa7:9886:0:b0:5a8:46b0:8269 with SMTP id r6-20020aa79886000000b005a846b08269mr3732865pfl.31.1676420260501;
        Tue, 14 Feb 2023 16:17:40 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id a20-20020aa780d4000000b0058d54960eccsm10293954pfn.151.2023.02.14.16.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:17:39 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:17:39 -0800 (PST)
X-Google-Original-Date: Tue, 14 Feb 2023 16:17:22 PST (-0800)
Subject:     Re: [PATCH 1/3] kernel/reboot: Use the static sys-off handler for any priority
In-Reply-To: <20221228161915.13194-2-samuel@sholland.org>
CC:     dmitry.osipenko@collabora.com, rafael.j.wysocki@intel.com,
        samuel@sholland.org, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        geert@linux-m68k.org, heiko@sntech.de, kai.heng.feng@canonical.com,
        mcgrof@kernel.org, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng@uniontech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-fbf5d10c-239d-4e47-bf52-3e1255cbe5e0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 08:19:13 PST (-0800), samuel@sholland.org wrote:
> commit 587b9bfe0668 ("kernel/reboot: Use static handler for
> register_platform_power_off()") addded a statically-allocated handler
> so register_sys_off_handler() could be called before the slab allocator
> is available.
>
> That behavior was limited to the SYS_OFF_PRIO_PLATFORM priority.
> However, it is also required for handlers such as PSCI on ARM and SBI on
> RISC-V, which should be registered at SYS_OFF_PRIO_FIRMWARE. Currently,
> this call stack crashes:
>
>   start_kernel()
>     setup_arch()
>       psci_dt_init()
>         psci_0_2_init()
>           register_sys_off_handler()
>             kmem_cache_alloc()
>
> Generalize the code to use the statically-allocated handler for the
> first registration, regardless of priority. Check .sys_off_cb for
> conflicts instead of .cb_data; some callbacks (e.g. firmware drivers)
> do not need any per-instance data, so .cb_data could be NULL.
>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  kernel/reboot.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..38c18d4f0a36 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -327,7 +327,7 @@ static int sys_off_notify(struct notifier_block *nb,
>  	return handler->sys_off_cb(&data);
>  }
>
> -static struct sys_off_handler platform_sys_off_handler;
> +static struct sys_off_handler early_sys_off_handler;
>
>  static struct sys_off_handler *alloc_sys_off_handler(int priority)
>  {
> @@ -338,10 +338,8 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
>  	 * Platforms like m68k can't allocate sys_off handler dynamically
>  	 * at the early boot time because memory allocator isn't available yet.
>  	 */
> -	if (priority == SYS_OFF_PRIO_PLATFORM) {
> -		handler = &platform_sys_off_handler;
> -		if (handler->cb_data)
> -			return ERR_PTR(-EBUSY);
> +	if (!early_sys_off_handler.sys_off_cb) {
> +		handler = &early_sys_off_handler;
>  	} else {
>  		if (system_state > SYSTEM_RUNNING)
>  			flags = GFP_ATOMIC;
> @@ -358,7 +356,7 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
>
>  static void free_sys_off_handler(struct sys_off_handler *handler)
>  {
> -	if (handler == &platform_sys_off_handler)
> +	if (handler == &early_sys_off_handler)
>  		memset(handler, 0, sizeof(*handler));
>  	else
>  		kfree(handler);

Sorry for being slow here, I'd been assuming someone would Ack this but 
it looks like maybe there's nobody in the maintainers file for 
kernel/reboot.c?  I'm fine taking this via the RISC-V tree if that's OK 
with people, but the cover letter suggests the patch is necessary for 
multiple patch sets.
