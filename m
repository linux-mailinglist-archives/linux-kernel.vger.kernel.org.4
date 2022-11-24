Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D351F63784C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKXMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKXMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FCACB9EC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669291276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7HcxW31PlGqZ7LlVewBN3n/M3SlRfqDtsg/jo2QUmA=;
        b=bOmzpeg2yvMvk3B5f3xZtyRUDItBwCdy3OdO9NJsf2pPa/zIOeLiWPeEQh11/rGrcpRhjV
        ISG/1/ScKb2aGkMeeHCaCSTVa74e2xUlnrYgIPnPhmMIAjvR7GGJVZ3PN03RidyYFwcOYH
        kKwieQo44//OYum7WwX29b9ayIQ9fcQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-OncNju1zPcihagbHZT9-mQ-1; Thu, 24 Nov 2022 07:01:15 -0500
X-MC-Unique: OncNju1zPcihagbHZT9-mQ-1
Received: by mail-ej1-f70.google.com with SMTP id qa14-20020a170907868e00b007ae24f77742so1074509ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7HcxW31PlGqZ7LlVewBN3n/M3SlRfqDtsg/jo2QUmA=;
        b=z2kbn14Ioq7BYXDB7wiMeRik2lRHhSTUHWmS81BYg0foXY8rNE4Ne+8svsvbKkOpCQ
         2k6Wjfn9FGPiVAK7kjZdFC0n/RyF0IW4elODClhReXvYE0IPBBIxeFMuPiKrR3NLIvGB
         asLLJ1uCyQK4GgQqI1lXaUmV2FwZn1w5MUHZhfFjJWGqvMXGCASH5GU5HMkLphEy67Hx
         gsmtMoH52IDmSCGITwKuv8x+YS6bj8KLWY8noTT/UKhVPVUX6dULIY+P1+bohJxZfn6s
         bJsIR0BE3D5+36C0J7HjgufzESue6+27vRyu0jciLm3n+MNHD/KMg9E6KIcgjUkPc2Xo
         +Hgg==
X-Gm-Message-State: ANoB5pkVAql/9uicVZMnbve2TawHD9jI7Xga/RBYO040Uc1tIXP+AeTi
        TMmHyd3nNXya9UU8BEJsEin6uOEpqI27dwVRAb9yiz1SyY+zrmOIqT22g3CBvsL6rd9aJMnhLi/
        sY7r7E9dU4uj5hYOmR1/YwSY9
X-Received: by 2002:a17:906:d297:b0:7b8:4c22:2d6c with SMTP id ay23-20020a170906d29700b007b84c222d6cmr10938681ejb.144.1669291274165;
        Thu, 24 Nov 2022 04:01:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4x9Sj81lq09gOSoHAzFPNhr4rAt+DBUjnmtvn9lIcQAf+nTTggjtPgq7oHPmWJVGJcaL1OIw==
X-Received: by 2002:a17:906:d297:b0:7b8:4c22:2d6c with SMTP id ay23-20020a170906d29700b007b84c222d6cmr10938668ejb.144.1669291273909;
        Thu, 24 Nov 2022 04:01:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709064e4800b007a97a616f3fsm344759ejw.196.2022.11.24.04.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 04:01:13 -0800 (PST)
Message-ID: <72d5aa86-c097-d022-942a-f7299e8aa1ef@redhat.com>
Date:   Thu, 24 Nov 2022 13:01:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] platform/x86: serial-multi-instantiate: Set fwnode
 for i2c
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20221124110718.3925934-1-sbinding@opensource.cirrus.com>
 <20221124110718.3925934-2-sbinding@opensource.cirrus.com>
 <1b548284-baa3-26e0-2e8f-a8d853788e5c@redhat.com>
In-Reply-To: <1b548284-baa3-26e0-2e8f-a8d853788e5c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/22 12:47, Hans de Goede wrote:
> Hi Stefan,
> 
> On 11/24/22 12:07, Stefan Binding wrote:
>> This allows the i2c driver to obtain the ACPI_COMPANION.
>>
>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>> ---
>>  drivers/platform/x86/serial-multi-instantiate.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
>> index 5362f1a7b77c..15ef2f3c442e 100644
>> --- a/drivers/platform/x86/serial-multi-instantiate.c
>> +++ b/drivers/platform/x86/serial-multi-instantiate.c
>> @@ -194,6 +194,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
>>  		strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);
>>  		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
>>  		board_info.dev_name = name;
>> +		board_info.fwnode = acpi_fwnode_handle(adev);
>>  
>>  		ret = smi_get_irq(pdev, adev, &inst_array[i]);
>>  		if (ret < 0)
> 
> I'm afraid that making this change is not as straight forward as it looks.
> 
> I know that I have tried to do this in the past and it failed.
> 
> IIRC there were 3 problems:
> 
> 1. I was expecting this to also allow the driver for the instantiated
> i2c-client to be able to bind using an acpi_match_table but that
> unfortunately does not work. acpi_match_table matches only work for
> the first physical_node linked under
> /sys/bus/acpi/devices/xxxx:xx/physical_node and that is the platform
> device to which serial-multi-instantiate.c binds. The i2c_client becomes
> the second physical node.  Note this is not really an issue,
> just something to be aware of.
> 
> 
> 2. This causes the i2c-core to use the first IRQ resource in the ACPI
> fwnode as client->irq for any clients for which we do not set an
> IRQ when instantiating. Which may very well be wrong. Sometimes that
> IRQ is only valid for the first i2c-client which we instantiate; and
> not for the others! And sometimes it is a problem because it may
> point to an irqchip for which we never wrote a driver leading to
> all probes of the i2c-client failing with -EPROBE_DEFER, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d1d84bb95364ed604015c2b788caaf3dbca0262f
> 
> Note that patch has been reverted since that specific -EPROBE_DEFER
> issue has been solved by making the ACPI core instantiate a
> platform_device instead of an i2c_client (in this case we
> did not need the actual i2c_client at all).
> 
> The current i2c-core code has a (!client-irq) test guarding its
> code of trying to use the first ACPI fwnode IRQ resource.
> 
> So we could disable this by setting client->irq = -ENOENT in
> serial-multi-instantiate.c when (inst->flags & IRQ_RESOURCE_TYPE) ==
> IRQ_RESOURCE_NONE). But that will introduce a new problem. Many
> i2c-drivers check if there is an IRQ for them to use by doing:
> "if (client->irq) request_irq(client->irq, ...)" but then with
> error checking/so setting client->irq to -ENOENT will cause
> the request_irq to fail, leading the probe to fail.
> 
> So before you can write a patch setting client->irq = -ENOENT
> when (inst->flags & IRQ_RESOURCE_TYPE) == IRQ_RESOURCE_NONE),
> you would first need to patch all i2c-drivers for clients
> instantiated through serial-multi-instantiate.c changing:
> 
> 	if (client->irq) {
> 		...
> 	}
> 
> to:
> 
> 	if (client->irq > 0) {
> 		...
> 	}
> 
> Note this is not as bad as it sounds, since there are only
> a few drivers for clients instantiated by serial-multi-instantiate.c .

Possibly a  nicer way to fix this would be to make the i2c-core change
client->irq to 0 if it is -ENOENT before calling the i2c_driver's
probe method, thus fixing things centrally for all i2c-drivers without
needing to audit/patch them all. Specifically in:

drivers/i2c/i2c-core-base.c: i2c_device_probe() change:

	if (!client->irq) {
		...
	}

to:

	if (!client->irq) {
		...
	} else if (client->irq == -ENOENT) {
		client->irq = 0; /* Drivers expect 0 for "no-IRQ" */
	}

And maybe as Andy suggested, handle at least the IRQ in
i2c_acpi_new_device_by_fwnode() by adding something like that there:

	/* Disable the i2c-core attempting to get an IRQ from ACPI itself */
	if (!board_info->irq)
		board_info->irq= -ENOENT;

I also agree with Andy that setting board_info->fw_node would be done
there ideally too. But then you would need to extend the audit of
impacted drivers mentioned below to also include drivers for
i2c-clients instantiated through other code-paths calling
i2c_acpi_new_device_by_fwnode()  (of which there are not many,
but there are a few others).

> 3. Some drivers may check for an ACPI companion device and then
> change their behavior. So all drivers for clients instantiated
> through serial-multi-instantiate.c will need to be audited for
> this (and a summary of this audit needs to be added to the commit
> msg).

Regards,

Hans




