Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032A365373C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLUTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDE22B01
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671652357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCRroI44SL1bzd88GS4250dP0iBh1wXxtn3imTbgqCw=;
        b=P+2P3lxATgkhzlhZ8/o/jypDQo+c2GGp6phxVMMGhHIc1GOKR7IQ5Ez+55n2MmM2uphlEI
        3P1+yoK8Yaed6dX6YKEch22qZHytp9MrPsLqmB2lhHRW2hIWEHEvJ5SiGXlil6dqqd42VG
        jHgcto4ApxWkkvMVkiTCuH5IkIHsKiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-ZW4PwtIIPuSiOe98Q-IKKA-1; Wed, 21 Dec 2022 14:52:35 -0500
X-MC-Unique: ZW4PwtIIPuSiOe98Q-IKKA-1
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso8295478wms.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCRroI44SL1bzd88GS4250dP0iBh1wXxtn3imTbgqCw=;
        b=Uyy7dSBwKAmEAlCZp6jLFl/ibjYxRVodJlAe4mVaujQwoNA/9F2ehF2AhgIasIttnS
         CC4yEcvOoMYUC6PmfjcxkZPJpYtkuSkyrvMvS1URux4D+WHvnG8DFUsmzKBfzg9fRCqS
         niwIJu9kJTqYEe0k/FWflASFV4QX4tO0VIk7Ro5d8dXJ6tYwYa146jFVEq9J3kzQrwQV
         DnW7DS/MPdsbRtM2vc0lZdARF+HXolhTGi5F+ksU0CUnqx43g3/vmzfWGfI17/iwpOPB
         72ax/Q7FPv4FogZPdYLmvOKsJvSeRD06vFxHjIdMIKRnefb2JASgO1EvUR0OLDexujnM
         HXGg==
X-Gm-Message-State: AFqh2kohAHIst9/DMVScZSsRvgiW7V6ZYXr1bS8apI3GfhX51VzJXDeA
        wQ1wqUKo/HwSYYLCGJP4vo2Y50l2Y3YOxWaTMGPCDZMHEeF66eJTd0YkKGdUb7iBexRTvWWe4y7
        iK4hzwehzBIJd8aOHrSgRy9k=
X-Received: by 2002:adf:e68e:0:b0:242:46f1:1d90 with SMTP id r14-20020adfe68e000000b0024246f11d90mr2006886wrm.64.1671652354616;
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsYTsLQroYHNhvkvJ8N4wSAZ8lt8zgb+cx3Jled8AKwHjoG1PTmnLW9Nq9JA9jIVolC/TUIHw==
X-Received: by 2002:adf:e68e:0:b0:242:46f1:1d90 with SMTP id r14-20020adfe68e000000b0024246f11d90mr2006880wrm.64.1671652354430;
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe0d0000000b0025d9d13c7e1sm12930371wri.105.2022.12.21.11.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
Message-ID: <70c7daf8-379e-1479-aba5-4476c4a93b9f@redhat.com>
Date:   Wed, 21 Dec 2022 20:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
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
 <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
In-Reply-To: <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
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


On 2022-12-21 18:26, Marco Pagani wrote:
> 
> 
> On 2022-12-20 18:09, Andy Shevchenko wrote:
>> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add a Device Feature List (DFL) bus driver for the Altera
>>> 16550 implementation of UART.
>>
>> In general the code here looks good to me, but one thing to discuss due to
>> comment to the previous patch(es).
>>
>> ...
>>
>>> +	u64 *p;
>>> +
>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>>> +	if (!p)
>>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>>> +
>>> +	p++;
>>> +	uart->port.uartclk = *p;
>>
>> So, here and the below is using always the second u64 from the returned data.
>> Does it mean:
>> - we always skip the first u64 from the returned buffer and hence... (see below)
>> - we may actually return the second u64 as a plain number (not a pointer) from
>>   (an additional?) API? In such case we would not need to take care about this
>>   p++; lines here and there.
>> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
>>
> 
> I also had the impression that this method of getting and incrementing a pointer
> to the beginning of the parameter block is a bit more error-prone than necessary.
> Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
> the access logic into a helper function like:
> 
> u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)
> 
> that directly provides a copy of the parameter's data into a pointer provided by
> the caller and returns the parameter version or an error if not found?

Please ignore the last part of my reply. The diagram in the documentation made
me think that parameter data are always 64-bit wide. Since the parameter data
"payload" size depends on the version and ID, an eventual helper function could
then return a pointer to the data payload and the version number to the caller.

Thanks,
Marco
 

