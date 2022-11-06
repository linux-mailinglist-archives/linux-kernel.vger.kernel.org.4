Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E198661E6DF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKFW27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKFW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:28:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066779FCD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:28:55 -0800 (PST)
Received: from [192.168.2.238] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2481E660226C;
        Sun,  6 Nov 2022 22:28:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667773733;
        bh=aLC82hYUdpoSkhtiTndL8qGiojFW9ZfDhBbsDDusSNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Py9eb5IKIzJFg3JgXl5J76l4OcKs0nnM4Bn3M5aiuU1i6PLyutFzFakokzChDdsnA
         ofIXxZBOho1h98aaTTw5yzMvmk0413A5qcCuhI4gVyOYffHgM/qrB3pjBPsZkn6RQh
         UODpDqtFyPXI0PxaCS0nTlJDK1T7/r3tr0PpD9nT2f/CZ3PbY2HitBndAscuVBVMch
         S82KoD0A6MQlZ7tQKoEJc8L0vObrqV14Vjlv7WERo0vPJrHkitxEn/5YPH1yQK3lSF
         ibhuNlg2eaNnb/ljS+XP4IotSHCMeaw6Ag2+sTfVTqAcWBMzl6vK5SxTTg+AWMbEG3
         SGWn8KTc/YHWw==
Message-ID: <02d127e1-adbb-3cc0-5da2-de3f961918a3@collabora.com>
Date:   Mon, 7 Nov 2022 01:28:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] kernel/reboot: Use the static sys-off handler for any
 priority
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221105214841.7828-1-samuel@sholland.org>
 <20221105214841.7828-2-samuel@sholland.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221105214841.7828-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 00:48, Samuel Holland wrote:
> commit 587b9bfe0668 ("kernel/reboot: Use static handler for
> register_platform_power_off()") addded a statically-allocated handler
> so register_sys_off_handler() could be called before the slab allocator
> is available.
> 
> That behavior was limited to the SYS_OFF_PRIO_PLATFORM priority.
> However, it is also required for handlers such as PSCI on ARM, which
> needs to be registered at SYS_OFF_PRIO_FIRMWARE. Currently, this call
> stack crashes:
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
> conflicts instead of .cb_data; some callbacks (e.g. firmware) do not
> need any per-instance data, so .cb_data could be NULL.
> 
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

