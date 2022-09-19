Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A05BCBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiISMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B3215A3C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663589921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0DSvgpZ4h6uehJTMxHzzvXh1HsmXnvIzwbdbIVtcjw=;
        b=WsZk18sJrl6Nd1XaKjGaoehLvuJib0ArAerp09qsVR6WcGJtzxkHbyiNlDTT19neczw3ZY
        IhYxOXqv7XFIwiDm1SbldY+C1xOuk6fPjaKs/o1unH40gfr0uGW38me2Z/SWwRNCvwxOak
        E1vOALCOu7Y/4aKTmcLAMbHlTJ2mQTo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-Au0uOT9IMXSwgs5gYCudcg-1; Mon, 19 Sep 2022 08:18:40 -0400
X-MC-Unique: Au0uOT9IMXSwgs5gYCudcg-1
Received: by mail-ed1-f70.google.com with SMTP id z9-20020a05640235c900b0044f0575e9ddso20098330edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G0DSvgpZ4h6uehJTMxHzzvXh1HsmXnvIzwbdbIVtcjw=;
        b=hWDTFWz0xZ5R2SEoklzSTB+2aj0Wrcz3UrCft3QTVvl6tn3lZXrUIXCYH3Rc+VfDXL
         8Uc198azb5/vCur9WEhaoZs9dQb16IPHmpRRwj0QTNXWlag10aF517NXCsSLGV4VU7m3
         SYEBlyNVbj16cfUbuhEd8ujtVmyXKJwqyJ3X0OLBh9QI3bxeRe9Gg2bm7T+Dgvhb7vb1
         C474bBDsDqkbPu4ttIZeBWRmPE07dhQbPGAg0WAgQGYomwGODhCM41WNoad8PW/wHK68
         FcRkyq9fZIGQ91F01eEGZ/HJ+t+Aq0Uf0BhO3zaKKUsvsCgQiuyytMxs++uoj8glXkP5
         ulkw==
X-Gm-Message-State: ACrzQf1QdyxNB8lKCfRecbwo4mpnlKuWAAFxa1qNa4wMzaYvt6jKqU7R
        paMgiCungd3WpJZDkrtHKyTXGTT8Mndfyv5+1xTEjjHRFAk/r9zk96jPrL4bma0BU6UQrt1Lu+I
        aM/A0KGopF9pGDFwSyXoz0eTB
X-Received: by 2002:a17:906:ef90:b0:77f:8f0d:e925 with SMTP id ze16-20020a170906ef9000b0077f8f0de925mr12304839ejb.622.1663589918974;
        Mon, 19 Sep 2022 05:18:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Vah5wh+rQnfBOmtQuW378vREh4+2MDpEX/5SEMBLmSfhDdy44YDwGEz5SJhjSkq8AL/3OJA==
X-Received: by 2002:a17:906:ef90:b0:77f:8f0d:e925 with SMTP id ze16-20020a170906ef9000b0077f8f0de925mr12304825ejb.622.1663589918787;
        Mon, 19 Sep 2022 05:18:38 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ee52-20020a056402293400b00453995b4c20sm6447617edb.73.2022.09.19.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:18:38 -0700 (PDT)
Message-ID: <4d55be61-e797-9eec-bf7e-ed675947b04d@redhat.com>
Date:   Mon, 19 Sep 2022 13:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] asus-wmi: Expand support of GPU fan to read RPM and label
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, corentin.chary@gmail.com, linux@roeck-us.net,
        jdelvare@suse.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220916004623.10992-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220916004623.10992-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 9/16/22 01:46, Luke D. Jones wrote:
> The previously added patch to add support for pwm change for TUF laptops
> also is usuable for more than TUF. The same method `0x00110014` is
> used to read the fan RPM.
> 
> Add two extra attributes for reading fan2 plus fan2 label.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 36 +++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ae46af731de9..7fe6ce25da0a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -72,6 +72,7 @@ module_param(fnlock_default, bool, 0444);
>  
>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>  
> +#define ASUS_GPU_FAN_DESC		"gpu_fan"
>  #define ASUS_FAN_DESC			"cpu_fan"
>  #define ASUS_FAN_MFUN			0x13
>  #define ASUS_FAN_SFUN_READ		0x06
> @@ -2078,6 +2079,30 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
>  }
>  
>  /* GPU fan on modern ROG laptops */
> +static ssize_t fan2_input_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int value;
> +	int ret;
> +
> +	ret = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= 0xffff;
> +
> +	return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);

As already mentioned since you & with 0xffff above the sign bit can never be
set, so the value is never less then < 0, so I have simplified this to:

	return sysfs_emit(buf, "%d\n", value * 100);

while merging.

> +}
> +
> +static ssize_t fan2_label_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sprintf(buf, "%s\n", ASUS_GPU_FAN_DESC);
> +}

And here I have done s/sprintf/sysfs_emit/ with those changes
I've applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> +
>  static ssize_t pwm2_enable_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -2127,9 +2152,12 @@ static ssize_t pwm2_enable_store(struct device *dev,
>  /* Fan1 */
>  static DEVICE_ATTR_RW(pwm1);
>  static DEVICE_ATTR_RW(pwm1_enable);
> -static DEVICE_ATTR_RW(pwm2_enable);
>  static DEVICE_ATTR_RO(fan1_input);
>  static DEVICE_ATTR_RO(fan1_label);
> +/* Fan2 - GPU fan */
> +static DEVICE_ATTR_RW(pwm2_enable);
> +static DEVICE_ATTR_RO(fan2_input);
> +static DEVICE_ATTR_RO(fan2_label);
>  
>  /* Temperature */
>  static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
> @@ -2140,6 +2168,8 @@ static struct attribute *hwmon_attributes[] = {
>  	&dev_attr_pwm2_enable.attr,
>  	&dev_attr_fan1_input.attr,
>  	&dev_attr_fan1_label.attr,
> +	&dev_attr_fan2_input.attr,
> +	&dev_attr_fan2_label.attr,
>  
>  	&dev_attr_temp1_input.attr,
>  	NULL
> @@ -2160,7 +2190,9 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
>  	    || attr == &dev_attr_pwm1_enable.attr) {
>  		if (asus->fan_type == FAN_TYPE_NONE)
>  			return 0;
> -	} else if (attr == &dev_attr_pwm2_enable.attr) {
> +	} else if (attr == &dev_attr_fan2_input.attr
> +	    || attr == &dev_attr_fan2_label.attr
> +	    || attr == &dev_attr_pwm2_enable.attr) {
>  		if (asus->gpu_fan_type == FAN_TYPE_NONE)
>  			return 0;
>  	} else if (attr == &dev_attr_temp1_input.attr) {

