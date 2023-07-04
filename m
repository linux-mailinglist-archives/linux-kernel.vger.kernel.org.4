Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F668746FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjGDLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGDLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69088E7B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688470427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AP906CQeKENtFxB9v3MuwBBwQNmL1xeBz24MopTkVu0=;
        b=bv5vIV1XQQbJBagB4E3mQVW+UaNTvgiHpeFoEs1fuRtCuAvjheJS0sfRlMQJZ0+sB4ujAr
        Et0+rbMgafgjfvL6U6F/fn/788+HXJDXxFo24zbXzaVklZ58vOMJ1gT6drldAxNmAU30oE
        asKDu/teBvT09UXyzqvy2ljyOll9iyo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-prylYMlXP9OY8gvCtpH2bQ-1; Tue, 04 Jul 2023 07:33:46 -0400
X-MC-Unique: prylYMlXP9OY8gvCtpH2bQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51ded16f8efso3005001a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688470425; x=1691062425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP906CQeKENtFxB9v3MuwBBwQNmL1xeBz24MopTkVu0=;
        b=R7ON8ZbMcHpkuOHigI0BoVPCc8VhU2RiUpe6Hs9RZHPJ4z0ngMNPoZmL1sKXHupXSc
         MUSfKZK8nI5EO7f5ZPhVRLmXkILSJnQyOVD9/e6g9YbEob7Ao+yKigYQc0y4T5L34QT5
         j03NWxV6fSmdSiztL8LojhnEBsAp6a5iZt87jROBUoyeRM5bX+XttTfw2ipl9oyG8PD9
         eZ83lf0Efao2S+xZdhUPF6mAqW4RhG7kN2IjHQccZ0Sbjuxb6ux1WtfwyWj7VWpdFpCv
         oLIzeE5eqO+0rDFUsS548bOwI/PYffYtuqlNNypPki2AEcP4I3ItaaTPv45AweHi5xZY
         HGyw==
X-Gm-Message-State: ABy/qLY80s0g9fp5zYGIrF3u7CL55ZVEArX/cqjcuhWfVoh7W/gmeSKM
        Ol3P/x5E8ObbmUgK1HchmJu9JhgjWyK6/qMlvEYNUYsgMDRcxpOWdSunNVnXGTp922mJnRYqhaA
        G6YC3erY7bnHA/87Wvoyi1kdC
X-Received: by 2002:a17:906:4e52:b0:992:3897:1985 with SMTP id g18-20020a1709064e5200b0099238971985mr8422642ejw.43.1688470425318;
        Tue, 04 Jul 2023 04:33:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6MTr9UljByURLngipchirENI4KQ2zstcPaJRBYMBgcxi0/BVxXFMfC4daFV7kmhsdphHcFA==
X-Received: by 2002:a17:906:4e52:b0:992:3897:1985 with SMTP id g18-20020a1709064e5200b0099238971985mr8422631ejw.43.1688470424989;
        Tue, 04 Jul 2023 04:33:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lw27-20020a170906bcdb00b0099315454e76sm4867174ejb.211.2023.07.04.04.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 04:33:44 -0700 (PDT)
Message-ID: <964c53a9-26bc-d8f6-05d9-032ce20e6b14@redhat.com>
Date:   Tue, 4 Jul 2023 13:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/8] platform/x86: asus-wmi: add support for showing
 middle fan RPM
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
 <20230630053552.976579-3-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-3-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> Some newer ASUS ROG laptops now have a middle/center fan in addition
> to the CPU and GPU fans. This new fan typically blows across the
> heatpipes and VRMs betweent eh CPU and GPU.
> 
> This commit exposes that fan to PWM control plus showing RPM.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index f23375d5fb82..375d25ae0aca 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -72,6 +72,7 @@ module_param(fnlock_default, bool, 0444);
>  
>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>  
> +#define ASUS_MID_FAN_DESC		"mid_fan"
>  #define ASUS_GPU_FAN_DESC		"gpu_fan"
>  #define ASUS_FAN_DESC			"cpu_fan"
>  #define ASUS_FAN_MFUN			0x13
> @@ -229,8 +230,10 @@ struct asus_wmi {
>  
>  	enum fan_type fan_type;
>  	enum fan_type gpu_fan_type;
> +	enum fan_type mid_fan_type;
>  	int fan_pwm_mode;
>  	int gpu_fan_pwm_mode;
> +	int mid_fan_pwm_mode;
>  	int agfn_pwm;
>  
>  	bool fan_boost_mode_available;
> @@ -2129,6 +2132,31 @@ static ssize_t fan2_label_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", ASUS_GPU_FAN_DESC);
>  }
>  
> +/* Middle/Center fan on modern ROG laptops */
> +static ssize_t fan3_input_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int value;
> +	int ret;
> +
> +	ret = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_MID_FAN_CTRL, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= 0xffff;
> +
> +	return sysfs_emit(buf, "%d\n", value * 100);
> +}
> +
> +static ssize_t fan3_label_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", ASUS_MID_FAN_DESC);
> +}
> +
>  static ssize_t pwm2_enable_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -2175,6 +2203,52 @@ static ssize_t pwm2_enable_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t pwm3_enable_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", asus->mid_fan_pwm_mode);
> +}
> +
> +static ssize_t pwm3_enable_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int state;
> +	int value;
> +	int ret;
> +	u32 retval;
> +
> +	ret = kstrtouint(buf, 10, &state);
> +	if (ret)
> +		return ret;
> +
> +	switch (state) { /* standard documented hwmon values */
> +	case ASUS_FAN_CTRL_FULLSPEED:
> +		value = 1;
> +		break;
> +	case ASUS_FAN_CTRL_AUTO:
> +		value = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = asus_wmi_set_devstate(ASUS_WMI_DEVID_MID_FAN_CTRL,
> +				    value, &retval);
> +	if (ret)
> +		return ret;
> +
> +	if (retval != 1)
> +		return -EIO;
> +
> +	asus->mid_fan_pwm_mode = state;
> +	return count;
> +}
> +
>  /* Fan1 */
>  static DEVICE_ATTR_RW(pwm1);
>  static DEVICE_ATTR_RW(pwm1_enable);
> @@ -2184,6 +2258,10 @@ static DEVICE_ATTR_RO(fan1_label);
>  static DEVICE_ATTR_RW(pwm2_enable);
>  static DEVICE_ATTR_RO(fan2_input);
>  static DEVICE_ATTR_RO(fan2_label);
> +/* Fan3 - Middle/center fan */
> +static DEVICE_ATTR_RW(pwm3_enable);
> +static DEVICE_ATTR_RO(fan3_input);
> +static DEVICE_ATTR_RO(fan3_label);
>  
>  /* Temperature */
>  static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
> @@ -2192,10 +2270,13 @@ static struct attribute *hwmon_attributes[] = {
>  	&dev_attr_pwm1.attr,
>  	&dev_attr_pwm1_enable.attr,
>  	&dev_attr_pwm2_enable.attr,
> +	&dev_attr_pwm3_enable.attr,
>  	&dev_attr_fan1_input.attr,
>  	&dev_attr_fan1_label.attr,
>  	&dev_attr_fan2_input.attr,
>  	&dev_attr_fan2_label.attr,
> +	&dev_attr_fan3_input.attr,
> +	&dev_attr_fan3_label.attr,
>  
>  	&dev_attr_temp1_input.attr,
>  	NULL
> @@ -2221,6 +2302,11 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
>  	    || attr == &dev_attr_pwm2_enable.attr) {
>  		if (asus->gpu_fan_type == FAN_TYPE_NONE)
>  			return 0;
> +	} else if (attr == &dev_attr_fan3_input.attr
> +	    || attr == &dev_attr_fan3_label.attr
> +	    || attr == &dev_attr_pwm3_enable.attr) {
> +		if (asus->mid_fan_type == FAN_TYPE_NONE)
> +			return 0;
>  	} else if (attr == &dev_attr_temp1_input.attr) {
>  		int err = asus_wmi_get_devstate(asus,
>  						ASUS_WMI_DEVID_THERMAL_CTRL,
> @@ -2264,6 +2350,7 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
>  static int asus_wmi_fan_init(struct asus_wmi *asus)
>  {
>  	asus->gpu_fan_type = FAN_TYPE_NONE;
> +	asus->mid_fan_type = FAN_TYPE_NONE;
>  	asus->fan_type = FAN_TYPE_NONE;
>  	asus->agfn_pwm = -1;
>  
> @@ -2278,6 +2365,10 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL))
>  		asus->gpu_fan_type = FAN_TYPE_SPEC83;
>  
> +	/* Some models also have a center/middle fan */
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MID_FAN_CTRL))
> +		asus->mid_fan_type = FAN_TYPE_SPEC83;
> +
>  	if (asus->fan_type == FAN_TYPE_NONE)
>  		return -ENODEV;
>  
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index f90cafe26af1..2c03bda7703f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -80,6 +80,7 @@
>  #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
>  #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
>  #define ASUS_WMI_DEVID_GPU_FAN_CTRL	0x00110014
> +#define ASUS_WMI_DEVID_MID_FAN_CTRL 0x00110031
>  #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
>  #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
>  

