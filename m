Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E86D9703
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjDFM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDFM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F87E5B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680784090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7AnMsWo/iJ5OTsTaA2l0gb9MT+nu7FOs61UeuJ4cHE=;
        b=JAIc1235KmsfkKttIUU0RB2q8k2IlSUTZquNSERRuFOlf4lCpGOJgwirqSynZPQ297umYP
        /UQhTLPro3O7ObOuB4aACDo51qipXcC/rQW+5nMCsDNX/XOQyk+74+7d/mQqd/TPTkqLge
        OIHaoybT3OKF3diF53PJLdlHXYOj8Oo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-txBL1CcjMxeR8SkGvjuLOg-1; Thu, 06 Apr 2023 08:28:09 -0400
X-MC-Unique: txBL1CcjMxeR8SkGvjuLOg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-4fe9239a2f7so857604a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 05:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680784088; x=1683376088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7AnMsWo/iJ5OTsTaA2l0gb9MT+nu7FOs61UeuJ4cHE=;
        b=pxRJrXbeRF//t1tuGNA65iSlTpdMrHW6m3hCclcIfCRP9o76N/oYa75hHt2woj+ib7
         Dp9+/fVIsLVbA0W8AZOIMPsU5MwQTZq21fHF1X0g/5gVw5GcfbkWpdcsLTTPFquXc2CX
         bbvvL6HK3IwAoiOjLF19hMVRCC5T9DehiU7iISF4gAWA1p2tySDCcEnAw9qnnN/TnR7t
         kRolE9rWoAVi2LkaGAxpO8Iyird1A1cBDj6c2lzu5KItOACyNL9LBe1IWLTepBOb3TxC
         J9U0/QZjN2c4r+xjPvpvF55xl/gV1Jsox3igFIu1vQ5XlCc97bYOYHeWVsK8MR9HpDg8
         y2IQ==
X-Gm-Message-State: AAQBX9frpdfUmqqzlMAvS7P8ttYnL4PAcT5g6PwEV1TJRjNIrt70b97C
        g7JPEwOKAJMnuhQKOcjrumgVbgLx+Ao5YASYpNAWkXhX6JQzncRKmiMkV7/z9rDpce0r8huwd/M
        5seqB4Vl/Hyrhoq18rxrcGeOS
X-Received: by 2002:a50:fe8f:0:b0:502:3376:dbe1 with SMTP id d15-20020a50fe8f000000b005023376dbe1mr5331214edt.15.1680784088039;
        Thu, 06 Apr 2023 05:28:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350aJA72xs/8X3yGFMyNsV6577vfrcW9WcRoy9xzkdV6qKMs6UuoqQgClvcnyLctjkzdOLZld2Q==
X-Received: by 2002:a50:fe8f:0:b0:502:3376:dbe1 with SMTP id d15-20020a50fe8f000000b005023376dbe1mr5331193edt.15.1680784087727;
        Thu, 06 Apr 2023 05:28:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a24-20020aa7cf18000000b005023aaf52desm668444edy.95.2023.04.06.05.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:28:07 -0700 (PDT)
Message-ID: <a872def2-9738-cdc2-51ff-74ae3a27de4b@redhat.com>
Date:   Thu, 6 Apr 2023 14:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Content-Language: en-US, nl
To:     Khalil Blaiech <kblaiech@nvidia.com>, markgross@kernel.org,
        vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, davthompson@nvidia.com,
        linux-kernel@vger.kernel.org
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/5/23 15:16, Khalil Blaiech wrote:
> Add a new sysfs to initiate firmware reset in isolation mode.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
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
>  drivers/platform/mellanox/mlxbf-bootctl.c | 19 +++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h |  6 ++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1c7a288b59a5..5e41c270195c 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -244,11 +244,29 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
>  	return buf_len;
>  }
>  
> +static ssize_t fw_reset_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long key;
> +	int err;
> +
> +	err = kstrtoul(buf, 16, &key);
> +	if (err)
> +		return err;
> +
> +	if (mlxbf_bootctl_smc(MLXBF_BOOTCTL_FW_RESET, key) < 0)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(post_reset_wdog);
>  static DEVICE_ATTR_RW(reset_action);
>  static DEVICE_ATTR_RW(second_reset_action);
>  static DEVICE_ATTR_RO(lifecycle_state);
>  static DEVICE_ATTR_RO(secure_boot_fuse_state);
> +static DEVICE_ATTR_WO(fw_reset);
>  
>  static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_post_reset_wdog.attr,
> @@ -256,6 +274,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_second_reset_action.attr,
>  	&dev_attr_lifecycle_state.attr,
>  	&dev_attr_secure_boot_fuse_state.attr,
> +	&dev_attr_fw_reset.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
> index 148fdb43b435..b48243f60a59 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.h
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.h
> @@ -75,6 +75,12 @@
>  
>  #define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
>  
> +/*
> + * Initiate Firmware Reset via TYU. This might be invoked during the reset
> + * flow in isolation mode.
> + */
> +#define MLXBF_BOOTCTL_FW_RESET  0x8200000D
> +
>  /* SMC function IDs for SiP Service queries */
>  #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
>  #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01

