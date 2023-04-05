Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC146D7F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjDEOfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbjDEOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2126AD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680705253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6maWokAKZGA7xI2Nh+FT6qosj5BQ+Zs1OLki0YvrHLI=;
        b=EssHGi2FD1lY+0Y+2LcA/zU71yIAViLEn7H8LZF2R0r0J+wVj43O0mueJXLOK83/V+Jdd7
        JN7QzBdehlsOBCZisk1UDOjcbFex0Zt1XEKmztiFfKOauYUJhA0ZqtNSib67h2E6Sb2pk3
        6BoISQutI2rz/CmlXjsuF3iT21HjjWU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-d-nGlpstNlu-lXD0mPdNdw-1; Wed, 05 Apr 2023 10:34:12 -0400
X-MC-Unique: d-nGlpstNlu-lXD0mPdNdw-1
Received: by mail-ed1-f69.google.com with SMTP id v1-20020a50d581000000b0050291cda08aso16622680edi.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705250;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6maWokAKZGA7xI2Nh+FT6qosj5BQ+Zs1OLki0YvrHLI=;
        b=Wsc9SJBSmf07naxXhay0qih4aNPisRAhBFBxpVMIQB2XpV3+V3Sr38Wn8jEOn10AkU
         3H85Cfqjg9inB+Zd9TPe7s123XpiKBe/dDpIh3KPfS9MnrwSRbT2Wa0+sGzqIqkQ3PIS
         Q7hhh00OYL78CdORoVWg008P41lUQP2WAW93V43b7O8vQc1C17eEEn/j3DmDVn5Yz6Ih
         MKVRA41QKsoxomhyL1ri76WvgoU78TOTO5kUaN6twKyjyAWg1pU480/x6X4sXIvzSOBs
         xZpITSyx2wNeT8z/upls1vV6fTErTxvceGTGCdRqU3gARwcxf6su+wV24AcfUqceIfoz
         MDcA==
X-Gm-Message-State: AAQBX9dlumdO42vtcQ7QBctC1FJzAeRvWbUtbihpiV1VLj2WTw4y98f2
        pG435pvJHh/4biFOWg1ZArak8RWExPdPdok3+0fTLZ02/z3JusfLxRS9Vx1r7xaaWtUTM1oCp3J
        +mZ5C4M08DiUePZ8yprDR1pK+
X-Received: by 2002:a17:906:4e56:b0:948:b988:8cc3 with SMTP id g22-20020a1709064e5600b00948b9888cc3mr2908465ejw.75.1680705249841;
        Wed, 05 Apr 2023 07:34:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYhg3LrVoA3qV+h/OnWQPd2oCRl/cnMGYHOaPSXVAsNY2M+Uh9QWgLV3nXh7N1RnGYNTaQKw==
X-Received: by 2002:a17:906:4e56:b0:948:b988:8cc3 with SMTP id g22-20020a1709064e5600b00948b9888cc3mr2908447ejw.75.1680705249570;
        Wed, 05 Apr 2023 07:34:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id cd9-20020a170906b34900b009353066595csm7442181ejb.136.2023.04.05.07.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 07:34:08 -0700 (PDT)
Message-ID: <8f33b1af-ffcb-9eb2-9294-9b3c5e4fee33@redhat.com>
Date:   Wed, 5 Apr 2023 16:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Khalil Blaiech <kblaiech@nvidia.com>, markgross@kernel.org,
        vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, davthompson@nvidia.com,
        linux-kernel@vger.kernel.org
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
 <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
In-Reply-To: <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/5/23 16:33, Hans de Goede wrote:
> Hi Khalil,
> 
> On 4/5/23 15:16, Khalil Blaiech wrote:
>> Add a new sysfs to initiate firmware reset in isolation mode.
>>
>> Reviewed-by: David Thompson <davthompson@nvidia.com>
>> Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
> 
> Why are you resending this less then 24 hours after the initial submission ?

Never mind, I see you added a missing Cc: platform-driver-x86@vger.kernel.org
which is good.

Next time please add a little note to the resend explaining why you
are resending it though.

Regards,

Hans



>> ---
>>  drivers/platform/mellanox/mlxbf-bootctl.c | 19 +++++++++++++++++++
>>  drivers/platform/mellanox/mlxbf-bootctl.h |  6 ++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
>> index 1c7a288b59a5..5e41c270195c 100644
>> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
>> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
>> @@ -244,11 +244,29 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
>>  	return buf_len;
>>  }
>>  
>> +static ssize_t fw_reset_store(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      const char *buf, size_t count)
>> +{
>> +	unsigned long key;
>> +	int err;
>> +
>> +	err = kstrtoul(buf, 16, &key);
>> +	if (err)
>> +		return err;
>> +
>> +	if (mlxbf_bootctl_smc(MLXBF_BOOTCTL_FW_RESET, key) < 0)
>> +		return -EINVAL;
>> +
>> +	return count;
>> +}
>> +
>>  static DEVICE_ATTR_RW(post_reset_wdog);
>>  static DEVICE_ATTR_RW(reset_action);
>>  static DEVICE_ATTR_RW(second_reset_action);
>>  static DEVICE_ATTR_RO(lifecycle_state);
>>  static DEVICE_ATTR_RO(secure_boot_fuse_state);
>> +static DEVICE_ATTR_WO(fw_reset);
>>  
>>  static struct attribute *mlxbf_bootctl_attrs[] = {
>>  	&dev_attr_post_reset_wdog.attr,
>> @@ -256,6 +274,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>>  	&dev_attr_second_reset_action.attr,
>>  	&dev_attr_lifecycle_state.attr,
>>  	&dev_attr_secure_boot_fuse_state.attr,
>> +	&dev_attr_fw_reset.attr,
>>  	NULL
>>  };
>>  
>> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
>> index 148fdb43b435..b48243f60a59 100644
>> --- a/drivers/platform/mellanox/mlxbf-bootctl.h
>> +++ b/drivers/platform/mellanox/mlxbf-bootctl.h
>> @@ -75,6 +75,12 @@
>>  
>>  #define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
>>  
>> +/*
>> + * Initiate Firmware Reset via TYU. This might be invoked during the reset
>> + * flow in isolation mode.
>> + */
>> +#define MLXBF_BOOTCTL_FW_RESET  0x8200000D
>> +
>>  /* SMC function IDs for SiP Service queries */
>>  #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
>>  #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
> 

