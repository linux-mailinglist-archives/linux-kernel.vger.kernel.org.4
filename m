Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11B461FEE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKGTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiKGTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55C1BE8F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667850594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfstZJTiUDyeaBhCh0xWrV/hqY+utwsaONHljzcYKLc=;
        b=RYeH8/fRwwUnBG+VaIdtYbRuJJa1KevexWDiblJnO9bJZZBphLItDvnoKjAQWVyAPcQSSY
        1JpVG+4TTK6QUpkXkIc2GtwprHOv+C46XctkAMmIiUJZNrKY07oXEwUgUM3qgIvQ/Nov83
        r4A0Z0LGcv8xTkxKjB3t+qt1mucj1hY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-5J998IxEMXae5c8ilhRxwQ-1; Mon, 07 Nov 2022 14:49:52 -0500
X-MC-Unique: 5J998IxEMXae5c8ilhRxwQ-1
Received: by mail-ej1-f69.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so7010866ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfstZJTiUDyeaBhCh0xWrV/hqY+utwsaONHljzcYKLc=;
        b=W3k6lpqe25wuoKkPexiu/bGXxpvTjbtaLTOa+86bXmCykNMBemNHqXZQFvBpN82hbN
         Iwvgdn6whdWrjUdz97EyanKiKJJ9/sEtB82eIvqoGzwngtCV0nFrEvR9GaaU23WNVWer
         Eb32KNLxxBgWlTlyUFIz/0/Oqm02zB06catWVR3uNykFQpc2OLWY8peKAAkB61cPi+Bk
         nWseJfzDOcw6t6lJGn787LoaJuf7P1fFst4QZYFan3Uu5EwBroYGWwScdAKzovFqibI6
         ANGUYDc6cVZs5tJmnaBAzZjgNcsLCs/OBazcxRDMuVBLqDeUb6ggwZNA8zQgOL6S08HE
         0lCw==
X-Gm-Message-State: ACrzQf2ULHQc3cHohYeunq+lJ/tHyBHWJwqVTjq74CJafQ53DN+ZvWnx
        xhAIF5Lzo+cTzzYvMO2jG/RQMc9Lt6L/7/i9j75gl62oz6CRnGvdSsQPpOZJjl1mCz8O26Ii1J4
        ijMj8yvV7uKKcWvW8eH2X/xfv
X-Received: by 2002:a17:907:7e85:b0:7ad:bf64:b5de with SMTP id qb5-20020a1709077e8500b007adbf64b5demr48236531ejc.20.1667850591398;
        Mon, 07 Nov 2022 11:49:51 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4E1Fvtd8z51QzCn/rLExSTDJhJpiYEhAFEvj0h9q+IbHl+NSQVIvMRhMHtUTgh8PGVID8pBQ==
X-Received: by 2002:a17:907:7e85:b0:7ad:bf64:b5de with SMTP id qb5-20020a1709077e8500b007adbf64b5demr48236509ejc.20.1667850591165;
        Mon, 07 Nov 2022 11:49:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7df0e000000b00461e4498666sm4639195edy.11.2022.11.07.11.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:49:50 -0800 (PST)
Message-ID: <b84e5dfd-4908-ab85-469d-aed8af37ce91@redhat.com>
Date:   Mon, 7 Nov 2022 20:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Improve buffer handling
Content-Language: en-US, nl
To:     david.e.box@linux.intel.com, Armin Wolf <W_Armin@gmx.de>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221102212336.380257-1-W_Armin@gmx.de>
 <fc480d25aabaa3923f24bbaa9b0f329f78c40abb.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <fc480d25aabaa3923f24bbaa9b0f329f78c40abb.camel@linux.intel.com>
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

On 11/7/22 19:54, David E. Box wrote:
> On Wed, 2022-11-02 at 22:23 +0100, Armin Wolf wrote:
>> When the DDV interface returns a buffer, it actually
>> returns a acpi buffer containing an integer (buffer size)
>> and another acpi buffer (buffer content).
>> The size of the buffer may be smaller than the size of
>> the buffer content, which is perfectly valid and should not
>> be treated as an error.
> 
> Is there documentation for this that you can refer to?
> 
>> Also use the buffer size instead of the buffer content size
>> when accessing the buffer to prevent accessing bogus data.
>>
>> Tested on a Dell Inspiron 3505.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>  drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> index 699feae3c435..1a001296e8c6 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> @@ -129,9 +129,9 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device
>> *wdev, enum dell_ddv_meth
>>  	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
>>  		goto err_free;
>>
>> -	if (buffer_size != obj->package.elements[1].buffer.length) {
>> +	if (buffer_size > obj->package.elements[1].buffer.length) {
>>  		dev_warn(&wdev->dev,
>> -			 FW_WARN "ACPI buffer size (%llu) does not match WMI
>> buffer size (%d)\n",
>> +			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer
>> size (%d)\n",
>>  			 buffer_size, obj->package.elements[1].buffer.length);
>>
>>  		goto err_free;
>> @@ -271,15 +271,17 @@ static int dell_wmi_ddv_buffer_read(struct seq_file
>> *seq, enum dell_ddv_method m
>>  	struct device *dev = seq->private;
>>  	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>>  	union acpi_object *obj;
>> -	union acpi_object buf;
>> +	u64 size;
>> +	u8 *buf;
>>  	int ret;
>>
>>  	ret = dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
>>  	if (ret < 0)
>>  		return ret;
>>
>> -	buf = obj->package.elements[1];
>> -	ret = seq_write(seq, buf.buffer.pointer, buf.buffer.length);
>> +	size = obj->package.elements[0].integer.value;
>> +	buf = obj->package.elements[1].buffer.pointer;
>> +	ret = seq_write(seq, buf, size);
> 
> Okay, so the buffer may provide more space than what should actually be used
> according to the size field. This looks like a bug that should have a fixes tag
> on the original commit.

I have already merged this and both the original commit as well as
this fix will land in 6.2, so I don't think a Fixes commit is
really necessary in this case.

Also the old code checked that the 2 sizes matched, so it was more
strict and as such running only the original patch should not lead
to buffer overruns or anything like that.

Regards,

Hans


