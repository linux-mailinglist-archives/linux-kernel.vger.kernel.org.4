Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE236BB391
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjCOMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjCOMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D99166F0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678884401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dxDu1EH9xzCVL/y99BM1/A0FCm7l89PRdNnkV8wtss=;
        b=HUorWWhgH9yNfmy3CrtOAzfcDF5Vl0fb6gHnwyGdHwYbN062+KnOWK0BOybcxFk0mEcv+V
        oTq74+evdaXOYTKYp+buO0/sQDU9j9kR0g9f3UsUgXxl/HUoS7PO59l9MbE4WBfCDMC1kg
        o7MdweSc0I2AaWA7GuORjgmic/rEqtI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-FlEEw1NLMvSzDKqQotuPmw-1; Wed, 15 Mar 2023 08:46:37 -0400
X-MC-Unique: FlEEw1NLMvSzDKqQotuPmw-1
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so17541083edz.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dxDu1EH9xzCVL/y99BM1/A0FCm7l89PRdNnkV8wtss=;
        b=xjppj6ACU6v0GIIVnVJLjCEiezXpC7445mAEswthaaC3lv5n1Qh6PSMqNnoI/OwxtR
         xIcGHhhX6zqvPFFiqFU+EQ9UTWAwnS/TFiuiwrsRYqE0FEpqtwSjSQ8MB+i1DkfKOFFD
         cMIHegzPwedD1W86DDOZ7FtIHZUdKv1U9JXcidgZrGyKFLvCiMhWRBum5N9qZj9Z14bh
         03DtOjkxh5OGZbIt562xeVojCfbD1Srs70L9JSK6MQDFPTfq498BA0bFihxaTMbcenJf
         Bvr5Acriktd3thzSa9VdYKIl4EAsucedueFAaEDTrGfq68RkinCwcH7B7he68X9o40zP
         p9kw==
X-Gm-Message-State: AO0yUKXrBQs+bUIcitxxAV29GwZlMk2UR1UXidAWERNasNbYZEQZXMk+
        wTWbcpEJRwSU0xzFy0GCNrLyp/XW8xBffr0h0rDat8GI4dUA51ZTR2mxZIoLaXpp5/6J4tcgXRG
        nAe36QDJtTULopDL1l4kArZEUfGP2KpKt
X-Received: by 2002:a17:906:1553:b0:92b:e330:a79e with SMTP id c19-20020a170906155300b0092be330a79emr6121005ejd.29.1678884395608;
        Wed, 15 Mar 2023 05:46:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set8IK7xy9Gyad0ICG5LXH/Wy/T1yn1gap9RxlbxLzdAkT7NnvZGJDrCG4PQyJJggyRytobddmg==
X-Received: by 2002:a17:906:1553:b0:92b:e330:a79e with SMTP id c19-20020a170906155300b0092be330a79emr6120995ejd.29.1678884395332;
        Wed, 15 Mar 2023 05:46:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906c08500b0092babe82cfesm2438183ejz.215.2023.03.15.05.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 05:46:34 -0700 (PDT)
Message-ID: <a0cab8a8-dbbf-9335-134c-c5b2751a81b4@redhat.com>
Date:   Wed, 15 Mar 2023 13:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/36] platform/x86: intel-uncore-freq: move to use
 bus_get_dev_root()
Content-Language: en-US, nl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-5-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230313182918.1312597-5-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/23 19:28, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

Taking this upstream through the driver-core tree is fine by me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index cb24de9e97dc..1a300e14f350 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -224,9 +224,15 @@ int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, u
>  	uncore_write = write_control_freq;
>  	uncore_read_freq = read_freq;
>  
> -	if (!uncore_root_kobj)
> -		uncore_root_kobj = kobject_create_and_add("intel_uncore_frequency",
> -							    &cpu_subsys.dev_root->kobj);
> +	if (!uncore_root_kobj) {
> +		struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> +
> +		if (dev_root) {
> +			uncore_root_kobj = kobject_create_and_add("intel_uncore_frequency",
> +								  &dev_root->kobj);
> +			put_device(dev_root);
> +		}
> +	}
>  	if (uncore_root_kobj)
>  		++uncore_instance_count;
>  	mutex_unlock(&uncore_lock);

