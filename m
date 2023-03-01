Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8A6A6C88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCAMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCAMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A683CE05
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677674553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rpnH98wTLhNce/b0NogbnAHOQzjLCiRqXJRNeyc7CY=;
        b=Q//deFSA8PVQo/T7MbtwBC2K5S1mRh9l/fB1CfpIbJTVusy+K0LrJB9PZAzEO7+O+rtKEt
        JTKuc8c+SiVbeAvDfjwL/OD0No6YL5ZOHtrIZk4wHdTtYaJJEz6dJRxzcYbFoXxasA54yZ
        wLj3htifVn6KgkVin7YdcUyQW6Q/H1s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-Ki9rsKZJOLyRiejQA6Yr9g-1; Wed, 01 Mar 2023 07:42:32 -0500
X-MC-Unique: Ki9rsKZJOLyRiejQA6Yr9g-1
Received: by mail-ed1-f72.google.com with SMTP id fj7-20020a0564022b8700b004bbcdf3751bso3440691edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rpnH98wTLhNce/b0NogbnAHOQzjLCiRqXJRNeyc7CY=;
        b=7oMbmIuWx8MR0U5IVvQHn540/acer08so1GkCqi7tcV5+LH6FOhfCl0f4KORA5KCaC
         rcR/b8YT1DHNKDFtbZC5ruTNzQY5HdiuXsB1Vz1T6blZjOxXTmiJt3sjTGcAmBQ/ExSZ
         QSNPlgxZDCmMMGMeKb9CDeNC+Qb3lXI3Cjz2f9lASyjFCiSsA02x6BlW6tf4fBZDCDTt
         eNIK1vM867AYePkp+d9YtjwA3nrVlkOD6kW5h5yU1zII27WUsP3qau/U2dUFoIv6Ns5M
         IMAjMDItRPGX449dIgPk28FxTmmqfa5Tj4PH5gfO3IZBFx4KNhaGmvZ8EVtkJauxGE6i
         X0DA==
X-Gm-Message-State: AO0yUKWY0EcSXYhLo2FFSieCR1JZ5WwZ5iSN1WLZ6laj2ZipDu8YDG9o
        9TQ1ZDHTJDxCnKO7iD1Qwn04K7Wq6mkHTeeCu1flWeYt1lvvmqzutnEUJb4/UWX+Ebr+bo4B61f
        VgWYk4gplTpU6cITEV5bGIrs7ER1vpg==
X-Received: by 2002:aa7:cd91:0:b0:4af:6aa6:12d3 with SMTP id x17-20020aa7cd91000000b004af6aa612d3mr5821566edv.40.1677674550476;
        Wed, 01 Mar 2023 04:42:30 -0800 (PST)
X-Google-Smtp-Source: AK7set+35lIRUpEO8j+kI01CSCd8mMNqTzPQI81CfWsGcFawLY1xZR54rOk8kDowbztoLzP8EEc88Q==
X-Received: by 2002:aa7:cd91:0:b0:4af:6aa6:12d3 with SMTP id x17-20020aa7cd91000000b004af6aa612d3mr5821551edv.40.1677674550206;
        Wed, 01 Mar 2023 04:42:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z9-20020a50cd09000000b004ac54d4da22sm5622325edi.71.2023.03.01.04.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:42:29 -0800 (PST)
Message-ID: <984e2340-6d9d-f7b6-a638-b70a3ed40a32@redhat.com>
Date:   Wed, 1 Mar 2023 13:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel/tpmi: Fix double free reported by
 Smatch
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20230227140614.2913474-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230227140614.2913474-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/23 15:06, Srinivas Pandruvada wrote:
> Fix warning:
> drivers/platform/x86/intel/tpmi.c:253 tpmi_create_device()
> 	warn: 'feature_vsec_dev' was already freed.
> 
> If there is some error, feature_vsec_dev memory is freed as part
> of resource managed call intel_vsec_add_aux(). So, additional
> kfree() call is not required.
> 
> Reordered res allocation and feature_vsec_dev, so that on error
> only res is freed.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/platform-driver-x86/Y%2FxYR7WGiPayZu%2FR@kili/T/#u
> Fixes: 47731fd2865f ("platform/x86/intel: Intel TPMI enumeration driver")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, I've applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

Regards,

Hans





> ---
>  drivers/platform/x86/intel/tpmi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index c60733261c89..c999732b0f1e 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -209,14 +209,14 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	if (!name)
>  		return -EOPNOTSUPP;
>  
> -	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
> -	if (!feature_vsec_dev)
> +	res = kcalloc(pfs->pfs_header.num_entries, sizeof(*res), GFP_KERNEL);
> +	if (!res)
>  		return -ENOMEM;
>  
> -	res = kcalloc(pfs->pfs_header.num_entries, sizeof(*res), GFP_KERNEL);
> -	if (!res) {
> +	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
> +	if (!feature_vsec_dev) {
>  		ret = -ENOMEM;
> -		goto free_vsec;
> +		goto free_res;
>  	}
>  
>  	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
> @@ -239,6 +239,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	/*
>  	 * intel_vsec_add_aux() is resource managed, no explicit
>  	 * delete is required on error or on module unload.
> +	 * feature_vsec_dev memory is also freed as part of device
> +	 * delete.
>  	 */
>  	ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
>  				 feature_vsec_dev, feature_id_name);
> @@ -249,8 +251,6 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  
>  free_res:
>  	kfree(res);
> -free_vsec:
> -	kfree(feature_vsec_dev);
>  
>  	return ret;
>  }

