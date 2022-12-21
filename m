Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A765351D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiLUR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLUR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA96414
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671643612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=UEyL5cmLiTs6BVItbEfqAYnMfOl4X0sDbNVxqAQK8GFWgkVvbcsQF/eI9mA8usrwJUO3UE
        qAjq4BiICdwDTBfmnpMAkTATH64UaIiH+k0KrccrerpRNjLLy3JQgf0qJgAk3+oc0Qw2gf
        hmHLcAzDwVUCMwJiZBsI/ijlskyRBes=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-iKbVSEwaNMq-GXxh9iUVYw-1; Wed, 21 Dec 2022 12:26:50 -0500
X-MC-Unique: iKbVSEwaNMq-GXxh9iUVYw-1
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfb1d5000000b0026e4c198a43so283396wra.20
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=Qz4mCk7RzsnxmWa8IpGZvnkjppccu0xLfOl/dmC+fkxzvUezCvAeQGyQFYL0JXvtyM
         /CITZ0LfJhqT8dJ9U1+x2425C+f3/2B+6l+YuQcf8ILjrwuwr0dA49pdONRwWVUTLuz7
         TzRsUAwlc7PP9VZPV3PEfq6B5sijt7VeLKpbgki873vkdw7ItFZkZifqpnbysSXOXevn
         sQAa3foHt1agi0PziT4tBWhdbCSLQ9tyIF1oNPNHopZ3uLt5Q5fya3cNW15ONAJKCIcq
         MdemYhGUGj45OQQCDWm48OXM6l3rXy9nwH1nuVvjypXvQ11I5CZN4+MAxpY+W9yTzKFT
         CeyQ==
X-Gm-Message-State: AFqh2kpSGygMG3laFkCVlFIcADapcs/4n5klm2crME1m5Pft09YnyEDw
        RUfQN8Zt0zkgLYWzR6rwWomIhLyb5ejWHNL+0EJZzBnJIcW4wz1MZF3mGKEY4ekdEGeIrLebqZ/
        Gew80npYCerUY4Y2gRxIFp7U=
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334952wmb.33.1671643609336;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtmCCrwZo4nu1X4aGkuZsQZJ+WKxm5A/pgzSMDNUisKMUrHcMJkTIyFUzoV5mJaknfoOilw9A==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334924wmb.33.1671643609137;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm3174983wmo.37.2022.12.21.09.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:26:48 -0800 (PST)
Message-ID: <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
Date:   Wed, 21 Dec 2022 18:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        bagasdotme@gmail.com
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-5-matthew.gerlach@linux.intel.com>
 <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-20 18:09, Andy Shevchenko wrote:
> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
> 
> In general the code here looks good to me, but one thing to discuss due to
> comment to the previous patch(es).
> 
> ...
> 
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (!p)
>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>> +
>> +	p++;
>> +	uart->port.uartclk = *p;
> 
> So, here and the below is using always the second u64 from the returned data.
> Does it mean:
> - we always skip the first u64 from the returned buffer and hence... (see below)
> - we may actually return the second u64 as a plain number (not a pointer) from
>   (an additional?) API? In such case we would not need to take care about this
>   p++; lines here and there.
> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
> 

I also had the impression that this method of getting and incrementing a pointer
to the beginning of the parameter block is a bit more error-prone than necessary.
Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
the access logic into a helper function like:

u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)

that directly provides a copy of the parameter's data into a pointer provided by
the caller and returns the parameter version or an error if not found?

Thanks,
Marco

