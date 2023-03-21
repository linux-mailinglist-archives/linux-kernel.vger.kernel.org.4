Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A76C27E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCUCM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUCMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:12:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099F367D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:12:24 -0700 (PDT)
Received: from [192.168.2.81] (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AAC66602179;
        Tue, 21 Mar 2023 02:12:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679364742;
        bh=w26D2PMKXRds0AgyYHD1BZOGWZk4ympnxzmlCnlXNJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g67TgC+cjuaHi/bVKYOSeovyCgznm1WdiNecz1JNC7FblDz/CXgiMbxtQcoHt0cz4
         eunFV0pyAOvT40XTcDXZ/bt5Nh7YRLpdSxWI/QsujARv6bEawYdkRJJ5Zs/nFMp2yr
         Bmaptfo6oN7ry5F+lg8iech3j5j7THRAUanOPN04kMkfN/kkXoLrSa6SOdFjLi1Nn4
         cRL2gTGzPs78gCT0pII8X1GWdYfGU3fY5ZD2aiU8K0aQlUa5/uWwEWNaDzyAPqIUFZ
         NvMVpZG5fGBljADGgsUzWbKDt+RGHzELeGLJQJIBBGfR02fSkiTVjFQ4wIa/Hdt83w
         w/r/Y7aW1ez8w==
Message-ID: <58a254d6-5bf1-5474-3bc9-10d0c9f9a0cf@collabora.com>
Date:   Tue, 21 Mar 2023 05:12:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] kernel/reboot: emergency_restart: set correct
 system_state
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, rafael.j.wysocki@intel.com,
        pmladek@suse.com
Cc:     mcgrof@kernel.org, paulmck@kernel.org, kai.heng.feng@canonical.com,
        tangmeng@uniontech.com, john.ogness@linutronix.de,
        yuehaibing@huawei.com, benjamin.bara@skidata.com,
        linux-kernel@vger.kernel.org
References: <20230320213230.1459532-1-bbara93@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230320213230.1459532-1-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 00:32, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> As the emergency restart does not call kernel_restart_prepare(),
> the system_state stays in SYSTEM_RUNNING.
> 
> This e.g. hinders i2c_in_atomic_xfer_mode() from becoming active,
> and therefore might lead to avoidable warnings in the restart handlers,
> e.g.:
> [   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
> [   12.676926] Voluntary context switch within RCU read-side critical section!
> ...
> [   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
> [   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70
> ...
> [   12.994527]  atomic_notifier_call_chain from machine_restart+0x34/0x58
> [   13.001050]  machine_restart from panic+0x2a8/0x32c
> 
> Avoid these by setting the correct system_state.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..6ebef11c8876 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -74,6 +74,7 @@ void __weak (*pm_power_off)(void);
>  void emergency_restart(void)
>  {
>  	kmsg_dump(KMSG_DUMP_EMERG);
> +	system_state = SYSTEM_RESTART;
>  	machine_emergency_restart();
>  }
>  EXPORT_SYMBOL_GPL(emergency_restart);

This patch needs to be paired with the i2c_in_atomic_xfer_mode() change.
Please also add the v5.2+ stable tag to the commit messages.

-- 
Best regards,
Dmitry

