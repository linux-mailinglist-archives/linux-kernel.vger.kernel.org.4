Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06E624925
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiKJSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiKJSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:13:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D1B1E8;
        Thu, 10 Nov 2022 10:13:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u24so4284169edd.13;
        Thu, 10 Nov 2022 10:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY/ynAFUt6xV5jtU1HFvLU4KzvnGIXAlHi4AEy5swMw=;
        b=oqPWWzEI4e/GAJJSphQE0f/l51W08aabzFPwlqjU6aXR4qcZPCvmiCZRAxK8+FBrNr
         JIIo4dGvyvjRuJBK5U92dZBEUBjx589PsdnlNloYPR//iuPBoTuDCvR4k7KX+4DuzzC6
         CiEm1JoCROmX+paQ2FcjwHqldaIWIkmLMU2WO4Zi963susArgk8iLveKu2uw0CbKuF/H
         JU4eZ6O2835rr5IWHkFqazRN6+lLOVc0IUwdTtdcT7eLixELAKyrOEi4ZEhjJtSMb3r2
         iP/pL1/JLNIRAJbSIm968y98M13+h4NzGELYt3qL9i//PRpXWNGgImsDVQJuvAGCtF8W
         iMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY/ynAFUt6xV5jtU1HFvLU4KzvnGIXAlHi4AEy5swMw=;
        b=xTpysD/hXhPwIFkWGNRbeubPWSP2cl8eXM5p4JMNnDItBLFA85fBzK5GT+wIu3GhkP
         tk66/7U3Nk4GSm4hoVI8SBK4VDzI+V38Hnig/4kgaWq1uDcoJYox1w7BJyABe1NUPtEV
         hhmCsENmVj85Z8Bd+aNlvjRvCF/FU1DTQGQFXNJSwjg+DCGVP2a30NhDb4soNxJCg8+Z
         +7g4bwNXRQZVsxwRDoO5foHnmHNHCe5u3oh55jyyZHZ6kT/Mge5vulq6SYmQ+FdcQHMT
         Q8VkF7IxRdfBRnHS3M+CLtmbvFPkn14+XNZB6CqaeRdAwoWKuyEYTjqr9k5Qr5Uzd1DG
         xH0Q==
X-Gm-Message-State: ACrzQf0aKQIGWRsKesZUowUA2J4xS4TcLnsASKsHQMHB1GN+ktfHOV6n
        hlrxy5leQqQsKRv5RFvlVLU=
X-Google-Smtp-Source: AMsMyM45aguoUhFP6GR7YJUOwitPLA+53uATFntDqAHLc1YrwWzhPP2KWYtzMfVzuoLs5uI61Xec5A==
X-Received: by 2002:aa7:c70b:0:b0:459:9e3:c0b0 with SMTP id i11-20020aa7c70b000000b0045909e3c0b0mr2848522edq.279.1668104000411;
        Thu, 10 Nov 2022 10:13:20 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170906300900b00781b589a1afsm7544113ejz.159.2022.11.10.10.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:13:19 -0800 (PST)
Subject: Re: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too
 frequently
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110155510.tobdbaabjoe7ugvl@mercury.elektranox.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <bd1d5ece-7665-a116-f37d-c21061030997@gmail.com>
Date:   Thu, 10 Nov 2022 20:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20221110155510.tobdbaabjoe7ugvl@mercury.elektranox.org>
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

Hi,

On 10.11.22 г. 17:55 ч., Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Nov 05, 2022 at 01:25:42PM +0200, Ivaylo Dimitrov wrote:
>> It seems that low battery irq may be generated tens of times per second,
>> leading to userspace being flooded with unnecessary events.
>>
>> Fix that by preventing such events being generated more than once every 30
>> seconds.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
> 
> Concept looks ok to me, but the code is slightly racy, since the
> thread is flushed before the IRQ is disabled in the remove routine.
> 

I did that on purpose, to have matching disable_irq()/enable_irq() 
calls. Maybe I over-engineered it, but my understanding is:

When remove() is called, if we have delayed work pending, that means 
that lowbph IRQ was disabled in cpcap_battery_irq_thread() and we have 
to re-enable it. If delayed_work is not pending, flush_delayed_work() 
will do nothing, IIUC.

Maybe I shall protect schedule_delayed_work() and disable_irq_nosync() 
calls with a mutex and wait for it before calling flush_delayed_work() 
in remove? That way there will be guarantee that if delayed_work is 
pending, IRQ is disabled too, while now maybe there is a small time 
window remove() to be called between schedule_delayed_work() and 
disable_irq_nosync().

>>   drivers/power/supply/cpcap-battery.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
>> index 4676560..8869067 100644
>> --- a/drivers/power/supply/cpcap-battery.c
>> +++ b/drivers/power/supply/cpcap-battery.c
>> @@ -137,6 +137,7 @@ struct cpcap_battery_ddata {
>>   	struct power_supply *psy;
>>   	struct cpcap_battery_config config;
>>   	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
>> +	struct delayed_work low_irq_work;
>>   	u32 cc_lsb;		/* μAms per LSB */
>>   	atomic_t active;
>>   	int charge_full;
>> @@ -914,9 +915,13 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
>>   		dev_info(ddata->dev, "Coulomb counter calibration done\n");
>>   		break;
>>   	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
>> -		if (latest->current_ua >= 0)
>> +		if (latest->current_ua >= 0 &&
>> +		    !delayed_work_pending((&ddata->low_irq_work))) {
>>   			dev_warn(ddata->dev, "Battery low at %imV!\n",
>>   				latest->voltage / 1000);
>> +			schedule_delayed_work(&ddata->low_irq_work, 30 * HZ);
>> +			disable_irq_nosync(d->irq);
>> +		}
>>   		break;
>>   	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
>>   		if (latest->current_ua >= 0 && latest->voltage <= 3200000) {
>> @@ -1087,6 +1092,21 @@ static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
>>   	return error;
>>   }
>>   
>> +static void cpcap_battery_lowbph_enable(struct work_struct *work)
>> +{
>> +	struct delayed_work *d_work = to_delayed_work(work);
>> +	struct cpcap_battery_ddata *ddata = container_of(d_work,
>> +			struct cpcap_battery_ddata, low_irq_work);
>> +	struct cpcap_interrupt_desc *d;
>> +
>> +	list_for_each_entry(d, &ddata->irq_list, node) {
>> +		if (d->action == CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW)
>> +			break;
>> +	}
>> +
>> +	enable_irq(d->irq);
>> +}
>> +
>>   #ifdef CONFIG_OF
>>   static const struct of_device_id cpcap_battery_id_table[] = {
>>   	{
>> @@ -1118,6 +1138,8 @@ static int cpcap_battery_probe(struct platform_device *pdev)
>>   	if (!ddata)
>>   		return -ENOMEM;
>>   
>> +	INIT_DELAYED_WORK(&ddata->low_irq_work, cpcap_battery_lowbph_enable);
> 
> use devm_delayed_work_autocancel() and put it directly before
> cpcap_battery_init_interrupts().
> 
>>   	cpcap_battery_detect_battery_type(ddata);
>>   
>>   	INIT_LIST_HEAD(&ddata->irq_list);
>> @@ -1185,6 +1207,9 @@ static int cpcap_battery_remove(struct platform_device *pdev)
>>   	if (error)
>>   		dev_err(&pdev->dev, "could not disable: %i\n", error);
>>   
>> +	/* make sure to call enable_irq() if needed */
>> +	flush_delayed_work(&ddata->low_irq_work);
> 
> and this can be dropped afterwards.
> 

Ok, but what will happen if we have lowbph IRQ already disabled? 
Wouldn't that cause issues, because of unbalanced 
disable_irq()/enable_irq() calls?

Thanks,
Ivo

>> +
>>   	return 0;
>>   }
> 
> Thanks,
> 
> -- Sebastian
> 
