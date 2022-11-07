Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84F61F64F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKGOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKGOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5812AD0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667832002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIV7vTHfSEDhPuKiIHyuGI+SN25V+GeNVs7hK16ZTWo=;
        b=NCmHpckRQ1FwXViZzwSeVkuoiEtN2cEXTuEQ18guX6ppHYifpX29MSEeVwDdSVgACsDglj
        5zRfAa24jzbr9lrX2k3231etuxoN6pHF92wI4OEzgw78XJtESLOuV8hY7axeO3bEXsQ6Qw
        73T8raLi6S/CI37c6ZrCsRKscKa8CqA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-jP6GsFPCNfiluyXwmV1QhA-1; Mon, 07 Nov 2022 09:40:01 -0500
X-MC-Unique: jP6GsFPCNfiluyXwmV1QhA-1
Received: by mail-ed1-f72.google.com with SMTP id q13-20020a056402518d00b00462b0599644so8616757edd.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIV7vTHfSEDhPuKiIHyuGI+SN25V+GeNVs7hK16ZTWo=;
        b=DbFyylaUfx+p1eXsfJeM6CYzdwk1VZpNIfbvlnxSYcIdtH7e2XvFoOY0PNMoUMB/5U
         26qOzCdmAKpR3V8j+8k4Q7d7cEXe21P6bHi6/IFGJm2/hGD6pjUsmPrX2E8pR4LbhpEr
         ihy6GETlfK1h35TPqiJ/JlxOXVMo4tMFeNraYgtPSQdqmP2oB0oeMsSdN2MzSgyzKcFj
         0abQK/Q8VY6x10+nyObLyuAnv3S7d6sdrdFNzeFLjudXVSgVyvvQVdAd5VHNsJW1ZxSI
         xBQognFsF8sOEF+Rjs24/4HilndAL+PRmqN3HJtDi1lbhq/BFjR2dFpNxWDKZb48oizB
         mw6w==
X-Gm-Message-State: ACrzQf3sbIBtyQ68eRNy6xttRPW6FwJSFgWFGVG/8phmHTDbwTv/hnw7
        2a4IT8IPaCq0Zb1FMAkoe8i2OH/SmTrNdmx3ZTsCuwssum46YXmMhOxpHvi9v/bN9cKytIhgVwJ
        mRUVmzJpkRUfuUcnS15/FC8sr
X-Received: by 2002:a17:907:788:b0:741:4d1a:595d with SMTP id xd8-20020a170907078800b007414d1a595dmr47454405ejb.737.1667832000127;
        Mon, 07 Nov 2022 06:40:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5UuCE6gKwXd7BPEQWXtgyxuPI+UrMCN3cveCwSawRky1Cf9tjEpwZVc7SEWEHV8Eay3qqE9g==
X-Received: by 2002:a17:907:788:b0:741:4d1a:595d with SMTP id xd8-20020a170907078800b007414d1a595dmr47454391ejb.737.1667831999954;
        Mon, 07 Nov 2022 06:39:59 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g26-20020a056402321a00b00463bc1ddc76sm4294827eda.28.2022.11.07.06.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:39:59 -0800 (PST)
Message-ID: <30f78533-45f3-e1b6-44b1-f349b8c9bea6@redhat.com>
Date:   Mon, 7 Nov 2022 15:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Improve buffer handling
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221102212336.380257-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221102212336.380257-1-W_Armin@gmx.de>
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

On 11/2/22 22:23, Armin Wolf wrote:
> When the DDV interface returns a buffer, it actually
> returns a acpi buffer containing an integer (buffer size)
> and another acpi buffer (buffer content).
> The size of the buffer may be smaller than the size of
> the buffer content, which is perfectly valid and should not
> be treated as an error.
> Also use the buffer size instead of the buffer content size
> when accessing the buffer to prevent accessing bogus data.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 699feae3c435..1a001296e8c6 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -129,9 +129,9 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_ddv_meth
>  	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
>  		goto err_free;
> 
> -	if (buffer_size != obj->package.elements[1].buffer.length) {
> +	if (buffer_size > obj->package.elements[1].buffer.length) {
>  		dev_warn(&wdev->dev,
> -			 FW_WARN "ACPI buffer size (%llu) does not match WMI buffer size (%d)\n",
> +			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer size (%d)\n",
>  			 buffer_size, obj->package.elements[1].buffer.length);
> 
>  		goto err_free;
> @@ -271,15 +271,17 @@ static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_method m
>  	struct device *dev = seq->private;
>  	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>  	union acpi_object *obj;
> -	union acpi_object buf;
> +	u64 size;
> +	u8 *buf;
>  	int ret;
> 
>  	ret = dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
>  	if (ret < 0)
>  		return ret;
> 
> -	buf = obj->package.elements[1];
> -	ret = seq_write(seq, buf.buffer.pointer, buf.buffer.length);
> +	size = obj->package.elements[0].integer.value;
> +	buf = obj->package.elements[1].buffer.pointer;
> +	ret = seq_write(seq, buf, size);
>  	kfree(obj);
> 
>  	return ret;
> --
> 2.30.2
> 

