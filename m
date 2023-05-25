Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CF711798
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbjEYTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbjEYTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B701AC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685043845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oE4/So5LeNg3LFo5KgJMJSE76TRPYlYOShUwOH/4MCk=;
        b=DSjQcNWSa5Ksx5Fuo+H8XefF4dgtO+U9rFt1KK3KpOL64e1l6zf+rIVRaqXxPFcVmXBG7f
        cxlXKJIauGhwGsvj4qLN0iYFQIslj96HFWM5KiRH8ttXHUocC/TF9Cthjr7HC8J1EqaBQj
        J/LOAA1XeE2farXjciRYujW6OdVMQHY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-kv1TurmMMt65le1tS_Nhlg-1; Thu, 25 May 2023 15:44:01 -0400
X-MC-Unique: kv1TurmMMt65le1tS_Nhlg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-510eb233a81so2645332a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685043840; x=1687635840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE4/So5LeNg3LFo5KgJMJSE76TRPYlYOShUwOH/4MCk=;
        b=QMYlxjW8PfxmPLscgxfhAY8jFQD7xtrKkgrq/bLqZ2C/HixECgP1u6aqyH4EkBluZC
         O+N4vBCuVDpfH8aZTDyiI75U2/kYGpRQ33gBiRcAZ7UOpKtc37wY5gDVtaMioxa0uaiJ
         J+8ufKUZU0Dt/9K0eF2OIbRG/FXuIdAcwD2HPTqfyurwhwp1zX/V5A/HHeQbLmAh4c5G
         Qhsc9lV8eLig8cq7IWkDabYA3lAKIhPoL2ac4WVlqmsF6wK7zBPzr6Ol7gkrJ4g3dH7J
         bbOnZdOAsvlITbcoptn9tTvbsDVS1WozhOgjo2Gn9dQ53bgRui8yGAsFyJGfjAxpLG8t
         9ytQ==
X-Gm-Message-State: AC+VfDzVui1KXblgsbXEv+v/4CkhHiwHaeiVeKHSi0BIPS124/FE6g50
        PAMlXw5H3u0G+5dx6z5I+8XmMtCTCXDUAwapWGTbAVxRrlsKbYVhF8Ct5S1wnrNdxurf8r/m5ys
        GAhbnxUwC3IkSbVmxUYuhuoGV
X-Received: by 2002:a17:907:9289:b0:933:868:413a with SMTP id bw9-20020a170907928900b009330868413amr2461154ejc.15.1685043840710;
        Thu, 25 May 2023 12:44:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Rrchj/ujtT0nSHQHC4MQvvsLCt6BwBsjFRmag2kyIMmu0HHwRHzCGf5cOvPhHT/1adDWBfA==
X-Received: by 2002:a17:907:9289:b0:933:868:413a with SMTP id bw9-20020a170907928900b009330868413amr2461147ejc.15.1685043840436;
        Thu, 25 May 2023 12:44:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gs8-20020a170906f18800b0096f4389714csm1219835ejb.55.2023.05.25.12.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 12:44:00 -0700 (PDT)
Message-ID: <e5c4c61c-a3a3-97d0-ad50-8c5b345dc334@redhat.com>
Date:   Thu, 25 May 2023 21:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] platform/x86: think-lmi: Correct NVME password
 handling
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-3-mpearson-lenovo@squebb.ca>
 <17963a3d-996f-4bb8-918e-aadba15be9bc@app.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <17963a3d-996f-4bb8-918e-aadba15be9bc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/25/23 21:39, Mark Pearson wrote:
> Hi Hans,
> 
> My apologies - I completely forgot to add the v2 tag on this patch series...had a complete brain fart.

No worries I did not even notice the v2 was missing,
my brain automatically added it :)
 
> I assume I should resend them all - correctly named.

Well I have some review remarks on patch 5/5, it would be good if you can address those (if you agree with them) and then lets jump straight to v3 to avoid confusion ?

> I also have no idea why they showed up out of order...I'm blaming that one on the email server.

The out of order thing is normal, this sometimes happens with email.

> Sorry :(

Again no worries / no problem ...

Regards,

Hans




> On Thu, May 25, 2023, at 3:31 PM, Mark Pearson wrote:
>> NVME passwords identifier have been standardised across the Lenovo
>> systems and now use udrp and adrp (user and admin level) instead of
>> unvp and mnvp.
>>
>> This should apparently be backwards compatible.
>>
>> Also cleaned up so the index is set to a default of 1 rather than 0
>> as this just makes more sense (there is no device 0).
>>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in V2: None. Version bumped in series
>>
>>  drivers/platform/x86/think-lmi.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index c7e98fbe7c3d..1c02958035ad 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -456,9 +456,9 @@ static ssize_t new_password_store(struct kobject *kobj,
>>  				sprintf(pwd_type, "mhdp%d", setting->index);
>>  		} else if (setting == tlmi_priv.pwd_nvme) {
>>  			if (setting->level == TLMI_LEVEL_USER)
>> -				sprintf(pwd_type, "unvp%d", setting->index);
>> +				sprintf(pwd_type, "udrp%d", setting->index);
>>  			else
>> -				sprintf(pwd_type, "mnvp%d", setting->index);
>> +				sprintf(pwd_type, "adrp%d", setting->index);
>>  		} else {
>>  			sprintf(pwd_type, "%s", setting->pwd_type);
>>  		}
>> @@ -1524,6 +1524,10 @@ static int tlmi_analyze(void)
>>  		if (!tlmi_priv.pwd_nvme)
>>  			goto fail_clear_attr;
>>
>> +		/* Set default hdd/nvme index to 1 as there is no device 0 */
>> +		tlmi_priv.pwd_hdd->index = 1;
>> +		tlmi_priv.pwd_nvme->index = 1;
>> +
>>  		if (tlmi_priv.pwdcfg.core.password_state & TLMI_HDD_PWD) {
>>  			/* Check if PWD is configured and set index to first drive found */
>>  			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
>> -- 
>> 2.40.1
> 

