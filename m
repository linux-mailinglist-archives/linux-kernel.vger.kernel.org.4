Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D93692330
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjBJQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjBJQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854978D54
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676046091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/OYelhAxbUO/ZarJ72R6o4cW+B/TE8DQz5tj7Qg/eE=;
        b=bfuiBN8TJBP9LPoSKLAuZXW3o30JTuuDfvyxtouZJNkMx3+9Mkmoo1UyYXSk1nnlzH79Ea
        pKk3xFSKAnIYgyVd5B2P3POzZqTzdo4k9jN7NJpFcvnFNcKjFNInlqNEg3+4SFRQU5u24i
        cFIWdWEQggQdtj1B5/rgzJEqZoDE9+k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-Hag-RMu9OIKlKMl7S_E4tg-1; Fri, 10 Feb 2023 11:21:29 -0500
X-MC-Unique: Hag-RMu9OIKlKMl7S_E4tg-1
Received: by mail-ej1-f70.google.com with SMTP id z2-20020a1709060be200b0088b579825f9so3845175ejg.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/OYelhAxbUO/ZarJ72R6o4cW+B/TE8DQz5tj7Qg/eE=;
        b=qyIEFa0zALodz5SQG/jEde1kRcdfIY4I8Z1GhA7w/p7O/p7cWmB6fTTkGifUnZ9OSG
         +AWjZiIC8tWcFJdda0c1fJpY7djqDcDXeEJLCsLSVDyo5yW3Je10BtmNykVy7Z7SsAaU
         ssEk5rca/CPwfWXi7SKPAR8vtmLWU6daYgOTWpeQofia/bP8E9xkuu8MBtioJOXV8uKh
         SHhsvGWOjRp/CuJoNgjuUdvBe5hw25lKUO4GxluKgkRm4k92w6o2h/hOz50a4Le6+Orn
         jvRp+Jz7wjS3Ht0q83Cv4ZQ0xWSWAfXn/8mOiSqy+Bnqk6QXh9UxEU7jh7dg1TvSha3Q
         5Wkw==
X-Gm-Message-State: AO0yUKUq3cIZgu42CeeZCNXYO0mRprqChKqhsln71ZnNqbedBjjdeku3
        2Lo7Ls/ScxumJMtqgq0Rsiw6RqCgp819pArRGTpeE/1vvXszRw30JfKZEZFsHNOOHg4VkoOP0b1
        ZP1zmtPwHWeG9BdVzJy6M9wbi
X-Received: by 2002:a17:907:2142:b0:888:7d50:33b4 with SMTP id rk2-20020a170907214200b008887d5033b4mr15630139ejb.34.1676046088521;
        Fri, 10 Feb 2023 08:21:28 -0800 (PST)
X-Google-Smtp-Source: AK7set8gLFdqWlVKugyAC/tmezDqjsO71zweOWnYUVrFdsRLIGM+8qt0sJE38MgyssPd0DU6xl5gvg==
X-Received: by 2002:a17:907:2142:b0:888:7d50:33b4 with SMTP id rk2-20020a170907214200b008887d5033b4mr15630128ejb.34.1676046088372;
        Fri, 10 Feb 2023 08:21:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090640c900b008720c458bd4sm2585954ejk.3.2023.02.10.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:21:27 -0800 (PST)
Message-ID: <916f252b-ef7c-6d22-0c4c-ecd198d49fbf@redhat.com>
Date:   Fri, 10 Feb 2023 17:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel/vsec: Use mutex for ida_alloc() and
 ida_free()
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, david.e.box@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207125821.3837799-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230207125821.3837799-1-srinivas.pandruvada@linux.intel.com>
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

Hi,

On 2/7/23 13:58, Srinivas Pandruvada wrote:
> ID alloc and free functions don't have in built protection for parallel
> invocation of ida_alloc() and ida_free(). With the current flow in the
> vsec driver, there is no such scenario. But add mutex protection for
> potential future changes.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
>  drivers/platform/x86/intel/vsec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index b936fc5776d7..f1680b7e64f5 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -129,11 +129,16 @@ static void intel_vsec_remove_aux(void *data)
>  	auxiliary_device_uninit(data);
>  }
>  
> +static DEFINE_MUTEX(vsec_ida_lock);
> +
>  static void intel_vsec_dev_release(struct device *dev)
>  {
>  	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
>  
> +	mutex_lock(&vsec_ida_lock);
>  	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
> +	mutex_unlock(&vsec_ida_lock);
> +
>  	kfree(intel_vsec_dev->resource);
>  	kfree(intel_vsec_dev);
>  }
> @@ -145,7 +150,9 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
>  	int ret, id;
>  
> +	mutex_lock(&vsec_ida_lock);
>  	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
> +	mutex_unlock(&vsec_ida_lock);
>  	if (ret < 0) {
>  		kfree(intel_vsec_dev);
>  		return ret;
> @@ -161,7 +168,9 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  
>  	ret = auxiliary_device_init(auxdev);
>  	if (ret < 0) {
> +		mutex_lock(&vsec_ida_lock);
>  		ida_free(intel_vsec_dev->ida, auxdev->id);
> +		mutex_unlock(&vsec_ida_lock);
>  		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return ret;

