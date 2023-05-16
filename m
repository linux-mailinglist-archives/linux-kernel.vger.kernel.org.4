Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB2704AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjEPKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjEPKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFA35A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684233121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldJAwQ03NcYgecnaiXu03CB4z5Xlzg7y/f8JQdCj9Tw=;
        b=iOageQe1oUwlpqk/Y3oXy+WgYjloy0EJBab/fctjwozmmqxXK/gsSrKUfGdkQKTQMyaeo4
        mTMD+uHXBWu1cfc0m8kN5xAa7plSDseZfz01W9NWRQwnLnxqhr9iz9BBnFLPDp6CppqBnT
        9pvIFhJOSeBnMUQG9C6lvk1LenH+/t4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-QQSNaXNxPAWMGvmSMOYFGw-1; Tue, 16 May 2023 06:32:00 -0400
X-MC-Unique: QQSNaXNxPAWMGvmSMOYFGw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-969c36898d4so944169166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233119; x=1686825119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldJAwQ03NcYgecnaiXu03CB4z5Xlzg7y/f8JQdCj9Tw=;
        b=Nq5u5iOyhZMqCrJz/8TJlJ1bGT3OJm4OvLXe0vE+R8z+Ixll1pWX8KEHCPoeBDt/Tl
         c7hetW/5LFd9BCcBYD+7JZoKiTBeFdF/zd5YgJ6oAGK9mcDokd0lSO6dYH1rlLbEyPNn
         K2Tr9tH7RyQ6VZTS9l/pyjIHPbX1kSPs0T6s2pvFr6lsvQK1KqDFNRUg0eCS77VwnI1w
         zp/N05x5U4pPnetSskzbXAV4C808VaAzkdSnRtXnZEz1WO9xff7rkjHczmjvFBCYLE0Z
         zZL2ehn3K4wpMjgOIpeADPkBRw4fkJ1xB6Rcrvyinh2DbGOzQ4Lezb+189EnWcUPknC0
         v8QA==
X-Gm-Message-State: AC+VfDzkuq3SRus62S3crjD5Ml0zQ1F6iwJTFAgU/1Q502qnTG6qM+uM
        ks8XInb7r0GFN5asJRTTigRE0sYQOo8TT1IThAPTSy89XBf0+THdXudSQy60nPQH4Q+6t2Bh/+h
        vhlBdHrAZFlTcxgo5F9beh5nB7+5bJcz4
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id be6-20020a1709070a4600b0094f2b80f3b4mr30320549ejc.69.1684233119073;
        Tue, 16 May 2023 03:31:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/vOdBrxzhK0bPUcojC0tC8K2RU1vfbKtrH2AFzzZSpm+KWCxjAARaILIpHqyWHLYt7w7WqA==
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id be6-20020a1709070a4600b0094f2b80f3b4mr30320533ejc.69.1684233118770;
        Tue, 16 May 2023 03:31:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906534200b0096b4c3489e6sm2276626ejo.177.2023.05.16.03.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:31:58 -0700 (PDT)
Message-ID: <f665b082-6114-d132-915b-e5b45f52af99@redhat.com>
Date:   Tue, 16 May 2023 12:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ACPI: scan: Reduce overhead related to devices with
 dependencies
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <12223415.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12223415.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 5/16/23 12:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: scan: Reduce overhead related to devices with dependencies
> 
> Notice that all of the objects for which the acpi_scan_check_dep()
> return value is greater than 0 are present in acpi_dep_list as consumers
> (there may be multiple entries for one object, but that is not a
> problem), so after carrying out the initial ACPI namespace walk in which
> devices with dependencies are skipped, acpi_bus_scan() can simply walk
> acpi_dep_list and enumerate all of the unique consumer objects from
> there and their descendants instead of walking the entire target branch
> of the ACPI namespace and looking for device objects that have not been
> enumerated yet in it.
> 
> Because walking acpi_dep_list is generally less overhead than walking
> the entire ACPI namespace, use the observation above to reduce the
> system initialization overhead related to ACPI, which is particularly
> important on large systems.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Hold acpi_dep_list_lock around the acpi_fetch_acpi_dev() invocation in
>        acpi_scan_postponed() (Hans).

This looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

with the remark that this obviously is going to need a lot
of testing in case this somehow breaks some weird corner case.

I'll add it to my personal git kernel tree with all my
pending work right away, so that it will get tested on
various devices as I test other patches on those devices.

I'll let you know if I hit any problems which seem to be
caused by this.

Regards,

Hans





> 
> ---
>  drivers/acpi/scan.c     |   81 ++++++++++++++++++++++++++++++++++++------------
>  include/acpi/acpi_bus.h |    2 +
>  2 files changed, 63 insertions(+), 20 deletions(-)
> 
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -289,6 +289,8 @@ struct acpi_dep_data {
>  	acpi_handle supplier;
>  	acpi_handle consumer;
>  	bool honor_dep;
> +	bool met;
> +	bool free_when_met;
>  };
>  
>  /* Performance Management */
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2029,8 +2029,6 @@ static u32 acpi_scan_check_dep(acpi_hand
>  	return count;
>  }
>  
> -static bool acpi_bus_scan_second_pass;
> -
>  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>  				      struct acpi_device **adev_p)
>  {
> @@ -2050,10 +2048,8 @@ static acpi_status acpi_bus_check_add(ac
>  			return AE_OK;
>  
>  		/* Bail out if there are dependencies. */
> -		if (acpi_scan_check_dep(handle, check_dep) > 0) {
> -			acpi_bus_scan_second_pass = true;
> +		if (acpi_scan_check_dep(handle, check_dep) > 0)
>  			return AE_CTRL_DEPTH;
> -		}
>  
>  		fallthrough;
>  	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
> @@ -2301,6 +2297,12 @@ static bool acpi_scan_clear_dep_queue(st
>  	return true;
>  }
>  
> +static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
> +{
> +	list_del(&dep->node);
> +	kfree(dep);
> +}
> +
>  static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
>  {
>  	struct acpi_device *adev = acpi_get_acpi_dev(dep->consumer);
> @@ -2311,8 +2313,10 @@ static int acpi_scan_clear_dep(struct ac
>  			acpi_dev_put(adev);
>  	}
>  
> -	list_del(&dep->node);
> -	kfree(dep);
> +	if (dep->free_when_met)
> +		acpi_scan_delete_dep_data(dep);
> +	else
> +		dep->met = true;
>  
>  	return 0;
>  }
> @@ -2406,6 +2410,55 @@ struct acpi_device *acpi_dev_get_next_co
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
>  
> +static void acpi_scan_postponed_branch(acpi_handle handle)
> +{
> +	struct acpi_device *adev = NULL;
> +
> +	if (ACPI_FAILURE(acpi_bus_check_add(handle, false, &adev)))
> +		return;
> +
> +	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> +			    acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
> +	acpi_bus_attach(adev, NULL);
> +}
> +
> +static void acpi_scan_postponed(void)
> +{
> +	struct acpi_dep_data *dep, *tmp;
> +
> +	mutex_lock(&acpi_dep_list_lock);
> +
> +	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> +		acpi_handle handle = dep->consumer;
> +
> +		/*
> +		 * In case there are multiple acpi_dep_list entries with the
> +		 * same consumer, skip the current entry if the consumer device
> +		 * object corresponding to it is present already.
> +		 */
> +		if (!acpi_fetch_acpi_dev(handle)) {
> +			/*
> +			 * Even though the lock is released here, tmp is
> +			 * guaranteed to be valid, because none of the list
> +			 * entries following dep is marked as "free when met"
> +			 * and so they cannot be deleted.
> +			 */
> +			mutex_unlock(&acpi_dep_list_lock);
> +
> +			acpi_scan_postponed_branch(handle);
> +
> +			mutex_lock(&acpi_dep_list_lock);
> +		}
> +
> +		if (dep->met)
> +			acpi_scan_delete_dep_data(dep);
> +		else
> +			dep->free_when_met = true;
> +	}
> +
> +	mutex_unlock(&acpi_dep_list_lock);
> +}
> +
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
>   * @handle: Root of the namespace scope to scan.
> @@ -2424,8 +2477,6 @@ int acpi_bus_scan(acpi_handle handle)
>  {
>  	struct acpi_device *device = NULL;
>  
> -	acpi_bus_scan_second_pass = false;
> -
>  	/* Pass 1: Avoid enumerating devices with missing dependencies. */
>  
>  	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
> @@ -2438,19 +2489,9 @@ int acpi_bus_scan(acpi_handle handle)
>  
>  	acpi_bus_attach(device, (void *)true);
>  
> -	if (!acpi_bus_scan_second_pass)
> -		return 0;
> -
>  	/* Pass 2: Enumerate all of the remaining devices. */
>  
> -	device = NULL;
> -
> -	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
> -		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> -				    acpi_bus_check_add_2, NULL, NULL,
> -				    (void **)&device);
> -
> -	acpi_bus_attach(device, NULL);
> +	acpi_scan_postponed();
>  
>  	return 0;
>  }
> 
> 
> 

