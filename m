Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037815B76AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiIMQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiIMQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:47:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F3BD106
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:41:12 -0700 (PDT)
Received: from [192.168.2.145] (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 406746601AED;
        Tue, 13 Sep 2022 16:14:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663082041;
        bh=IZVMXPsmeNutgy635V9Tli9ZlfJKqiRfXqa1maMjnSY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F9agusurEwQkin8/M7bO6ZPajr+EN/VDICq0H+wCZcHg9qm4cCHU/7jvDfDzmwhCy
         7hjjiMm0ZsHj7K0YkZbgAKKlu40/x2FaITo80RHDFwtvn7Ly48mX4fUVfuqbVC5837
         KzPlF+ir503KeRcpWtlttmU4irfh63cuG1/8GUc6R48ESikyGWBjHSBQeGkxBXnyII
         +n7vhWUJiz8c4S5EV9XaQk/iuWnQgdFxYjYubdL9QpGdvo/ow3TckA7HerFQt+iOE8
         HM0Dbk/TcpxH9lcMf3qJ+nkLqu63LrOoHFLeSNIwM5XFnqo0nDIQozO9e9di3TEJGx
         Ed+2IW31eycpQ==
Message-ID: <a88168af-e072-2af6-fca4-0472d3277f68@collabora.com>
Date:   Tue, 13 Sep 2022 18:13:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE
 mode
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
References: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 09:20, Kai-Heng Feng wrote:
> Add SYS_OFF_MODE_RESTART_PREPARE callbacks can be invoked before system
> restart.
> 
> This is a preparation for next patch.
> 
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - New patch.
> 
>  include/linux/reboot.h |  8 ++++++++
>  kernel/reboot.c        | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index e5d9ef886179c..ba87cdef2335a 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -105,6 +105,14 @@ enum sys_off_mode {
>  	 */
>  	SYS_OFF_MODE_POWER_OFF,
>  
> +	/**
> +	 * @SYS_OFF_MODE_RESTART_PREPARE:
> +	 *
> +	 * Handlers prepare system to be powered off. Handlers are

s/powered off/restarted/

> +	 * allowed to sleep.
> +	 */
> +	SYS_OFF_MODE_RESTART_PREPARE,
> +
>  	/**
>  	 * @SYS_OFF_MODE_RESTART:
>  	 *
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3c35445bf5ad3..3bba88c7ffc6b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -243,6 +243,17 @@ void migrate_to_reboot_cpu(void)
>  	set_cpus_allowed_ptr(current, cpumask_of(cpu));
>  }
>  
> +/*
> + *	Notifier list for kernel code which wants to be called
> + *	to prepare system for restart.
> + */
> +static BLOCKING_NOTIFIER_HEAD(restart_prep_handler_list);
> +
> +static void do_kernel_restart_prepare(void)
> +{
> +	blocking_notifier_call_chain(&restart_prep_handler_list, 0, NULL);
> +}
> +
>  /**
>   *	kernel_restart - reboot the system
>   *	@cmd: pointer to buffer containing command to execute for restart
> @@ -254,6 +265,7 @@ void migrate_to_reboot_cpu(void)
>  void kernel_restart(char *cmd)
>  {
>  	kernel_restart_prepare(cmd);
> +	do_kernel_restart_prepare();
>  	migrate_to_reboot_cpu();
>  	syscore_shutdown();
>  	if (!cmd)
> @@ -396,6 +408,11 @@ register_sys_off_handler(enum sys_off_mode mode,
>  		handler->list = &power_off_handler_list;
>  		break;
>  
> +	case SYS_OFF_MODE_RESTART_PREPARE:
> +		handler->list = &restart_prep_handler_list;
> +		handler->blocking = true;
> +		break;
> +
>  	case SYS_OFF_MODE_RESTART:
>  		handler->list = &restart_handler_list;
>  		break;

With the above comment addressed:

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

