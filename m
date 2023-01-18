Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFB671AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjARLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjARLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D174AA77
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674039172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR4lu08dhpKLNLAmhLt8RYhLri3hR5H1H/boJl2s8Ew=;
        b=AzLnWyIPdG5DnKcgsTPtArHaL26KCuSiBoYb1wgA+6MEqHtNY36r0/cbr5N4ZYhzm9vCZI
        s/LDiX9Cb9jvCSIBxw99Cf/Lzmw0jX70AQmG/ihBOmVfW3aJ0oxFyCRh1m075MAZbneook
        K4M9McHsAR3+ttINfGPHGZsqdKl14xE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-MPbpyyaQOdeO0it9yRctNA-1; Wed, 18 Jan 2023 05:52:51 -0500
X-MC-Unique: MPbpyyaQOdeO0it9yRctNA-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402350f00b0049e42713e2bso2173083edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR4lu08dhpKLNLAmhLt8RYhLri3hR5H1H/boJl2s8Ew=;
        b=4qXKMQGJ55euQ1AtjtagVFcoHhEkTNd8eqPdtfeTjfrTAG+MvqF25qMINHdxoo7M6u
         EbyC1GbAYWDVpI/evqMFwFAotPte06rDwOywhsy05Rz5I+M3HgLhh+MkbsHcFKEVeIF6
         Fd2HyW4akBAcnQCwIJ0q/za3hQteNKlL15yZgBu04QsB95Br+Kf3tZwB+2g9p00U1lwX
         9joED4zFE1dVFwD4IMIqpWOgPPqS71JIyEP2VJj8pq/S8SMhEhJ7cYNmplV64QHWC052
         uEZjS74SrAPxXFnzmVDXoC3t9Vfdgf48FAFSOPJIOCqxGPgFIfn5TnD/GXOsuFHUXJxA
         /viw==
X-Gm-Message-State: AFqh2krItuDWmo1Jt6mPY31W5xNoOiGwTUp0KaIgwfr5rsaxht5D1QE5
        xIRBwMRNTi39EfFmVy6SiMhNdKuyONlXcX1ToSaIADkw0n9VolezxyWU96iWalrxOnFdBhUeDSS
        03l1E6lBZi22cMtyMIikeFVmU
X-Received: by 2002:a17:906:244b:b0:7be:fb2c:c112 with SMTP id a11-20020a170906244b00b007befb2cc112mr6178452ejb.66.1674039169563;
        Wed, 18 Jan 2023 02:52:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9ShTtWOgn2wmv2ilGuHcRACbdyeBsDeSxNQN/n8BHN+Zn8PMNKibiqd/bJ3maavu2TFU5Bw==
X-Received: by 2002:a17:906:244b:b0:7be:fb2c:c112 with SMTP id a11-20020a170906244b00b007befb2cc112mr6178440ejb.66.1674039169331;
        Wed, 18 Jan 2023 02:52:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00862497eafb2sm8408915ejj.103.2023.01.18.02.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:52:48 -0800 (PST)
Message-ID: <a9db708f-59a6-586a-8728-81622a93ef3e@redhat.com>
Date:   Wed, 18 Jan 2023 11:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C
 resources
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
 <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
 <CAAd53p5DFUMjMNAyp6YVONwCpGs8rRVORj0=OSgj+Z0f3QpeCg@mail.gmail.com>
 <CAAd53p5XXCniBN7x4uhp4XW=qr2U72_UntgAR0BV2viRtd+8EA@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAd53p5XXCniBN7x4uhp4XW=qr2U72_UntgAR0BV2viRtd+8EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/23 06:15, Kai-Heng Feng wrote:
> On Wed, Jan 18, 2023 at 11:29 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> Hi Hans,
>>
>> On Wed, Jan 18, 2023 at 1:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 1/17/23 17:09, Kai-Heng Feng wrote:
>>>> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
>>>> with 2 I2C resources") creates a second client for the actual I2C
>>>> address, but the "struct device" passed to PM ops is the first client
>>>> that can't talk to the sensor.
>>>>
>>>> That means the I2C transfers in both suspend and resume routines can
>>>> fail and blocking the whole suspend process.
>>>>
>>>> Instead of using the first client for I2C transfer, store the cm32181
>>>> private struct on both cases so the PM ops can get the correct I2C
>>>> client to perfrom suspend and resume.
>>>>
>>>> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
>>>> Tested-by: Wahaj <wahajaved@protonmail.com>
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>
>>> Thank you for this fix. I had looking into this on my todo list,
>>> since I have been seeing some bug reports about this too.
>>>
>>> One remark inline:
>>>
>>>> ---
>>>>  drivers/iio/light/cm32181.c | 11 +++++++----
>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>>>> index 001055d097509..0f319c891353c 100644
>>>> --- a/drivers/iio/light/cm32181.c
>>>> +++ b/drivers/iio/light/cm32181.c
>>>> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>>>>       if (!indio_dev)
>>>>               return -ENOMEM;
>>>>
>>>> +     i2c_set_clientdata(client, indio_dev);
>>>> +
>>>
>>> Why move this up, the suspend/resume callbacks cannot run until
>>> probe() completes, so no need for this change.
>>
>> The intention is to save indio_dev as drvdata in the first (i.e.
>> original) i2c_client's dev.
>>
>>>
>>>>       /*
>>>>        * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>>>>        * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
>>>> @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
>>>>               client = i2c_acpi_new_device(dev, 1, &board_info);
>>>>               if (IS_ERR(client))
>>>>                       return PTR_ERR(client);
>>>> -     }
>>>>
>>>> -     i2c_set_clientdata(client, indio_dev);
>>>> +             i2c_set_clientdata(client, indio_dev);
>>>> +     }
>>>
>>> And moving it inside the if block here (instead of just dropping it)
>>> is also weird. I guess you meant to just delete it since you moved it up.
>>
>> Doesn't i2c_acpi_new_device() creates a new i2c_client (and its dev embedded)?
>>
>> So the intention is to save indio_dev for the second (ARA case) i2c_client too.
>>
>>>
>>>>
>>>>       cm32181 = iio_priv(indio_dev);
>>>>       cm32181->client = client;
>>>
>>> Also note that the ->client used in suspend/resume now is not set until
>>> here, so moving the i2c_set_clientdata() up really does not do anything.
>>>
>>> I beleive it would be best to just these 2 hunks from the patch and
>>> only keep the changes to the suspend/resume callbacks.
>>
>> Yes, it seems like those 2 hunks are not necessary. Let me send a new patch.
> 
>         if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {
>                 ...
>                 client = i2c_acpi_new_device(dev, 1, &board_info);
>                 ...
>         }
>         i2c_set_clientdata(client, indio_dev);
> 
> It means the indio_dev is only assigned to the new i2c_client->dev's
> drvdata, the original dev's drvdata remains NULL.
> So we need to assign it before the original client gets replaced by
> the new one, otherwise we can't get cm32181 in PM ops.

You are right, my bad. The original code has a bug where it indeed was
making the i2c_set_clientdata() call on the wrong client device.

So the i2c_set_clientdata() call needs to be moved up.

There is no need to also call i2c_set_clientdata() on the dummy
i2c-client though. That one does not have a driver attached.

The suspend/resume callbacks are made on the original client-dev,
not on the one of the dummy-client (which is the one which we
actually use to communicate).

>> But I do wonder what happens for the removing case? Will the second
>> i2c_client leak?

Yes it does, good point. That should probably also be fixed, but
that needs to be a different / second patch.

Regards,

Hans



>>>> @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
>>>>
>>>>  static int cm32181_suspend(struct device *dev)
>>>>  {
>>>> -     struct i2c_client *client = to_i2c_client(dev);
>>>> +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
>>>> +     struct i2c_client *client = cm32181->client;
>>>>
>>>>       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>>>>                                        CM32181_CMD_ALS_DISABLE);
>>>> @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
>>>>
>>>>  static int cm32181_resume(struct device *dev)
>>>>  {
>>>> -     struct i2c_client *client = to_i2c_client(dev);
>>>>       struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
>>>> +     struct i2c_client *client = cm32181->client;
>>>>
>>>>       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>>>>                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
>>>
> 

