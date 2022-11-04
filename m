Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7955D6190AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKDGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:09:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3C178B8;
        Thu,  3 Nov 2022 23:09:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so10645941ejb.13;
        Thu, 03 Nov 2022 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Tr/8hi5G7RL1UIjwqgzK0lAVGdQMoS2Pg25E/W9mMA=;
        b=j47wp55XIfHt/4ShZQhg6PwD0qLIXnfGr8DblGzC564u4/ZP8LKISgmism26QTukkz
         MiZcUXoboPKpeMG8nc8RPx/iXHluu08o1fX2xsHOYJbWI1TEjEcLu2BLDqzT+q6MUnvF
         E6k9Ln/b/nV9qbOPQKSviQgz9Gw4dxZoaOQKryAahiSMwHq2jkyGO0pqdchJVtfgNMLj
         Bn+JtuhfuQGtDYXguOID8sob9ZKuWaCOHQerkdGQ6x8qC4YAJRNFaX7GiQUZhMZdQgrT
         7TKbH7AJq4JvHe1FAodjMRIGojve/FDHs7exu/EcmHirWgg25o3Y0yK/XhqFaB4Mkscn
         CeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Tr/8hi5G7RL1UIjwqgzK0lAVGdQMoS2Pg25E/W9mMA=;
        b=QYXmQ2LzlTnmuX4sJLd7iJNbdRuhxeTP0ulxkYDNDGEJ4GM1wb6TtHRe/SnF3ZRp7o
         jE9sEtJHQ3PylFl3sXN92SfJ0+9bxs54NOfFbm1zsV0DKW2SeUJrtLEraJmpwzoJX/3f
         vXejnNeoVmQ8v0NIHvszqcGmykyj9FvapQnzTyY8BNEtvhH608om/DacsUh5mK2WW1k+
         G8yp4k84Ws1OyiUWdZE0irexuyuaWlA4swfArc4awUFg2+cl5Oy78MCxxYmEe+PSDbIK
         m82ECBQ4iohh4HQSgcI7w+PuGJuSynunLp6+ThdP8DLYZgKw56mJ+yxW0sZhHBn2pnZp
         3U7Q==
X-Gm-Message-State: ACrzQf0vf2AkNO0BoTb/yQYuGuMN3LEvL0LRTrnYuOt2Q7RJ9iOlMRcC
        csLGiFFmzNgmbcEW3ei0x3tCxZeRn+M78w==
X-Google-Smtp-Source: AMsMyM7hve8hRJtZwRoCWB82qjULQJwqJkd4zxtaiGuBlB8BhuG7A+PxHy1rT30oWU4f04ZlKqQerQ==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr33622937ejb.487.1667542191538;
        Thu, 03 Nov 2022 23:09:51 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id m11-20020a170906258b00b0078dce9984afsm1331503ejb.220.2022.11.03.23.09.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 23:09:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too
 frequently
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
References: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667332425-12536-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <ce999c0b-342d-6a29-6a16-b69cf8a1db9d@gmail.com>
Date:   Fri, 4 Nov 2022 08:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1667332425-12536-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has issues (calling enable_irq() from timer function), will 
send v2 that uses delayed_work.

On 1.11.22 г. 21:53 ч., Ivaylo Dimitrov wrote:
> It seems that low battery irq may be generated tens of times per second,
> leading to userspace being flooded with unnecessary events.
> 
> Fix that by preventing such events being generated more than once every 30
> seconds.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/power/supply/cpcap-battery.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> index 4676560..2659df7 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -137,6 +137,7 @@ struct cpcap_battery_ddata {
>   	struct power_supply *psy;
>   	struct cpcap_battery_config config;
>   	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
> +	struct timer_list low_timer;
>   	u32 cc_lsb;		/* μAms per LSB */
>   	atomic_t active;
>   	int charge_full;
> @@ -914,9 +915,14 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
>   		dev_info(ddata->dev, "Coulomb counter calibration done\n");
>   		break;
>   	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
> -		if (latest->current_ua >= 0)
> +		if (latest->current_ua >= 0 &&
> +		    !timer_pending(&ddata->low_timer)) {
>   			dev_warn(ddata->dev, "Battery low at %imV!\n",
>   				latest->voltage / 1000);
> +			mod_timer(&ddata->low_timer,
> +				  jiffies + msecs_to_jiffies(30000));
> +			disable_irq_nosync(d->irq);
> +		}
>   		break;
>   	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
>   		if (latest->current_ua >= 0 && latest->voltage <= 3200000) {
> @@ -1087,6 +1093,19 @@ static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
>   	return error;
>   }
>   
> +static void cpcap_battery_lowbph_enable(struct timer_list *t)
> +{
> +	struct cpcap_battery_ddata *ddata = from_timer(ddata, t, low_timer);
> +	struct cpcap_interrupt_desc *d;
> +
> +	list_for_each_entry(d, &ddata->irq_list, node) {
> +		if (d->action == CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW)
> +			break;
> +	}
> +
> +	enable_irq(d->irq);
> +}
> +
>   #ifdef CONFIG_OF
>   static const struct of_device_id cpcap_battery_id_table[] = {
>   	{
> @@ -1118,6 +1137,8 @@ static int cpcap_battery_probe(struct platform_device *pdev)
>   	if (!ddata)
>   		return -ENOMEM;
>   
> +	timer_setup(&ddata->low_timer, cpcap_battery_lowbph_enable, 0);
> +
>   	cpcap_battery_detect_battery_type(ddata);
>   
>   	INIT_LIST_HEAD(&ddata->irq_list);
> @@ -1185,6 +1206,8 @@ static int cpcap_battery_remove(struct platform_device *pdev)
>   	if (error)
>   		dev_err(&pdev->dev, "could not disable: %i\n", error);
>   
> +	del_timer_sync(&ddata->low_timer);
> +
>   	return 0;
>   }
>   
> 
