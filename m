Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED831720F08
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFCJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:52:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D9E49
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 02:52:03 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5NvTqcwg0lhpt5NvUq1Ymt; Sat, 03 Jun 2023 11:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685785921;
        bh=sEkP4ZBCfBtKE6wbBKT/e+RFD7qcjLBvxrynGg1sMbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wnc+8hl0woXXEG7VOf6t6mLnvH6CnaRngUzo2mY6v8KlwbU938X7zOwebYSXMoVcS
         QQ0c2MfWTLU6IBLI/tdjRQcUOYSanAx6lt8Slgu8R/VzoUT4aSGygbZgmJG0UgmfsD
         lMaSdd/tzd/qipIDoaol96akAuiNiMK8Nlc1EsG0HSFW52OG5/7vJf/sCwvHHBC9aE
         r27PJ41kyv30Yzu2PZEgqnNiYVP1I30gRbnSsGejHSa5qRd6FtpqwTNWQEZyWdpGsB
         JsHIjSK0gqm8mOe41+hb/uBDr8V0BQhraE0sleDdb3dOzKtxsSjnbEXEh6FeRBOI3C
         04tglSdZ7fvIA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Jun 2023 11:52:01 +0200
X-ME-IP: 86.243.2.178
Message-ID: <70eaa9d9-4f0f-20b8-fcac-24b7074a084b@wanadoo.fr>
Date:   Sat, 3 Jun 2023 11:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] New module to add NCT6692D watchdog funtionality
To:     dober6023@gmail.com
Cc:     dober@lenovo.com, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        mpearson@lenovo.com, wim@linux-watchdog.org
References: <20230602163045.605774-1-dober6023@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230602163045.605774-1-dober6023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/06/2023 à 18:30, David Ober a écrit :
> The new module adds in the basic functionality of the NCT6692D
> watchdog driver. This functionality is added to support the
> Lenovo SE30 device
> 
> Signed-off-by: David Ober <dober6023-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/watchdog/Kconfig       |  12 +
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/nct6692_wdt.c | 690 +++++++++++++++++++++++++++++++++
>   3 files changed, 703 insertions(+)
>   create mode 100644 drivers/watchdog/nct6692_wdt.c
> 

[...]

> +static int nct6692_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nct6692_data_t *data = NULL;
> +	struct nct6692_sio_data *sio_data = dev->platform_data;
> +	struct resource *res;
> +
> +	pr_info("Probe NCT6692 called\n");
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +
> +	data = kzalloc(sizeof(struct nct6692_data_t), GFP_KERNEL);

Is it released somewhere?
Should this be devm_kzalloc()?

> +	if (!data)
> +		return -ENOMEM;
> +
> +	// init value
> +	data->shm.base_addr = 0;
> +	data->shm.report_addr = 0;

Harmless, but useless (kzalloc() above)

> +
> +	data->shm.base_phys = sio_data->base_phys;
> +	data->shm.base_addr = (u_char *)ioremap_cache(data->shm.base_phys, 256);
> +
> +	data->shm.offset_mod = SHM_WIN_MOD_OFFSET;
> +	data->shm.offset_cmd = SHM_WIN_CMD_OFFSET;
> +	data->shm.offset_sel = SHM_WIN_SEL_OFFSET;
> +	data->shm.offset_ctl = SHM_WIN_CTL_OFFSET;
> +	data->shm.offset_id = SHM_WIN_ID_OFFSET;
> +	data->shm.offset_dat = SHM_WIN_DAT_OFFSET;
> +
> +	// Base for REPORT Channel
> +	data->shm.report_phys = sio_data->report_phys;
> +	data->shm.report_addr = (u_char *)ioremap_cache(data->shm.report_phys, 256);
> +
> +	data->cfg.channel = NCT6692_CHANNEL_DEFAULT;
> +	data->cfg.mod = 0x10;
> +	data->cfg.cmd = 0;
> +	data->cfg.sel = 0;
> +	data->cfg.idx = 0x15;
> +	data->cnt.channel = NCT6692_CHANNEL_DEFAULT;
> +	data->cnt.mod = 0x10;
> +	data->cnt.cmd = 0;
> +	data->cnt.sel = 0;
> +	data->cnt.idx = 0x16;

All these "= 0" are harmless, but useless (kzalloc() above). Maybe it 
makes sense to keep them.

> +
> +	data->wdt.ops = &nct6692_wdt_ops;
> +	data->wdt.info = &nct6692_wdt_info;
> +
> +	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
> +	data->wdt.min_timeout = MIN_TIMEOUT;
> +	data->wdt.max_timeout = MAX_TIMEOUT;
> +	data->wdt.parent = &pdev->dev;
> +
> +	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&data->wdt, nowayout);
> +	watchdog_set_drvdata(&data->wdt, data);
> +
> +	watchdog_stop_on_unregister(&data->wdt);
> +
> +	return devm_watchdog_register_device(dev, &data->wdt);
> +}

[...]

> +static int __init nct6692_init(void)
> +{
> +	struct nct6692_sio_data sio_data;
> +	int sioaddr[2] = { 0x2e, 0x4e };
> +	struct resource res;
> +	int err;
> +	int address;
> +	bool found = false;
> +	u_long base_phys = 0;
> +	u_long report_phys = 0;
> +
> +	platform_driver_register(&nct6692_driver);
> +
> +	/*
> +	 * initialize sio_data->kind and sio_data->sioreg.
> +	 *
> +	 * when Super-I/O functions move to a separate file, the Super-I/O
> +	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
> +	 * nct6692 hardware monitor, and call probe()
> +	 */
> +	err = nct6692_find(sioaddr[0], &base_phys, &report_phys);
> +	if (err) {
> +		err = nct6692_find(sioaddr[1], &base_phys, &report_phys);
> +		if (err)
> +			return -ENODEV;

goto exit_unregister; ?

> +	}
> +	found = true;
> +	sio_data.base_phys = base_phys;
> +	sio_data.report_phys = report_phys;
> +

[...]

