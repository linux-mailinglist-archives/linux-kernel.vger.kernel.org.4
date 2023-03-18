Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EED6BFC59
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCRTPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:15:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72995298D3;
        Sat, 18 Mar 2023 12:15:41 -0700 (PDT)
Received: from [192.168.2.157] (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2743B6602EAB;
        Sat, 18 Mar 2023 19:15:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679166938;
        bh=oMWY8M1N3xc2OMZ3Qxr9ENMzgfszuvvxzezKMnicu0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q6H5YMSx3iNxeU5PJBBDI+Q+fchPTAUH6zzv9r7zzuVp4J5+9YRWxFm2VfE8T68wI
         c6am+uWobUQQuBfLdTZsRS844uUei3wtmY7ds1Dw/HeG/XVflX612dR3qNMJkYVc/o
         gWLeyD1S4H/yBxuYdHjBOx/p2nSgPI1HlNHbMEF7var5hFyoTU8a2a0yrkzKGoFj3P
         wcvnSCdJZpsiEhDJL16CONrisoCITL1dsa6EkJ4ri9EsxT6ipcDS4oF3DA44y80AW2
         wnb1qUzDSLWXPrgAaZoXVUPrxZqf5VLH7x9Kfu3SzZtzTCoClByJ7YBR7IS19NJa2q
         hTZq9au/4v/SA==
Message-ID: <0c2913b7-b393-e7d8-604e-fbf127e7d26a@collabora.com>
Date:   Sat, 18 Mar 2023 22:15:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mfd: tps6586x: register restart handler
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, lee@kernel.org
Cc:     digetx@gmail.com, jonathanh@nvidia.com, treding@nvidia.com,
        richard.leitner@linux.dev, benjamin.bara@skidata.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316164703.1157813-1-bbara93@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230316164703.1157813-1-bbara93@gmail.com>
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

On 3/16/23 19:47, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The TPS658629-Q1 (unfortunately the only TPS6586x with public data sheet)
> provides a SOFT RST bit in the SUPPLYENE reg to request a (cold) reboot.
> 
> Use it to implement and register a restart handler/notifier.
> The DS does not clarify if only writing the SOFT RST bit has side effects.
> Therefore, regmap_update_bits() is used.
> 
> Set an appropriate system_state and disable the IRQs to activate
> i2c_in_atomic_xfer_mode(). This avoids the following WARNING:
> [   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
> [   12.676926] Voluntary context switch within RCU read-side critical section!
> ...
> [   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
> [   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70
> 
> Tested on a TPS658640.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/mfd/tps6586x.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index 2d947f3f606a..e40c664b5f64 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -15,6 +15,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/irqflags.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -22,6 +23,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  
> @@ -29,6 +31,7 @@
>  #include <linux/mfd/tps6586x.h>
>  
>  #define TPS6586X_SUPPLYENE	0x14
> +#define SOFT_RST_BIT		BIT(0)
>  #define EXITSLREQ_BIT		BIT(1)
>  #define SLEEP_MODE_BIT		BIT(3)
>  
> @@ -466,6 +469,23 @@ static void tps6586x_power_off(void)
>  	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
>  }
>  
> +static int tps6586x_restart_notify(struct notifier_block *this, unsigned long mode, void *data)
> +{
> +	/* bring pmic into HARD REBOOT state, disable IRQs for atomic i2c RCU */
> +	system_state = SYSTEM_RESTART;
> +	local_irq_disable();
> +	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SOFT_RST_BIT);
> +	local_irq_enable();
> +
> +	mdelay(500);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block tps6586x_restart_handler = {
> +	.notifier_call = tps6586x_restart_notify,
> +	.priority = 200,
> +};
> +
>  static void tps6586x_print_version(struct i2c_client *client, int version)
>  {
>  	const char *name;
> @@ -559,9 +579,16 @@ static int tps6586x_i2c_probe(struct i2c_client *client)
>  		goto err_add_devs;
>  	}
>  
> -	if (pdata->pm_off && !pm_power_off) {
> +	if (pdata->pm_off) {
>  		tps6586x_dev = &client->dev;
> -		pm_power_off = tps6586x_power_off;
> +		if (!pm_power_off)
> +			pm_power_off = tps6586x_power_off;
> +
> +		ret = register_restart_handler(&tps6586x_restart_handler);
> +		if (ret) {
> +			dev_err(&client->dev, "register restart handler failed: %d\n", ret);
> +			goto err_add_devs;
> +		}
>  	}
>  
>  	return 0;
> @@ -582,6 +609,13 @@ static void tps6586x_i2c_remove(struct i2c_client *client)
>  	mfd_remove_devices(tps6586x->dev);
>  	if (client->irq)
>  		free_irq(client->irq, tps6586x);
> +
> +	if (tps6586x_dev == &client->dev) {
> +		tps6586x_dev = NULL;
> +		unregister_restart_handler(&tps6586x_restart_handler);
> +		if (pm_power_off == tps6586x_power_off)
> +			pm_power_off = NULL;
> +	}

There are newer devm_register_power_off/restart_handler() helpers in
kernel [1]. Will be great if you'll use them in v2.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/reboot.h

-- 
Best regards,
Dmitry

