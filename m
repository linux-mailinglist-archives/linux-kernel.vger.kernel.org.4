Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298867047DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjEPIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C9F10F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684225923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CC1+LnWioCnymTFuT2N5MqSF3mYASkgMJBth5jnttMc=;
        b=Kl1YnPMg8OvUr6cdkbwx03EOfMrRpqD3ujxle8E7PbLUfzx/f/Bxfud6zGGGcleE5blZwz
        kwNjwX4Z2S8pnNy5xQ5zP9H6tUOAMuI6Mktrh1K/9+l136A+qK4R8sA67J1r6/6kcO16/2
        KwYNrQkf73Iq1OZ2Iii31z4j8m+OMTA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-vhLOnRASPtKQtGjt2y-GJQ-1; Tue, 16 May 2023 04:32:02 -0400
X-MC-Unique: vhLOnRASPtKQtGjt2y-GJQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5104a3f0a45so2675436a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225920; x=1686817920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CC1+LnWioCnymTFuT2N5MqSF3mYASkgMJBth5jnttMc=;
        b=bVak5UfbQvK03kqtvjAp/8mW9c0mp8sBE+DVwPaSEZhhl46BVQHnQwpGM6ONZ7yaEH
         +BDiXvYhfpNTO+UaBr3HJjBKYmlbEDZNdDNISLSqjKCiiFPUqAn1k0kw+n/mrmQvxxOz
         rBdjSgNZOivwMQAJf03J9tXROF3I3aQ5yNFpKlwectnD0eGYzJ8d++C3LaGUQMZqlVZZ
         6t5HWqhrW9KeqpzJEQybsI0lE/+tja+aToXoqoxD1Yp3SF3CG0XZg34I6ZPjDp52snhF
         C2HPMCvumqN9d8e5hp/LYxW6huGIXqQ6x7vkZslSxjidbb1Y/CieEwvwcRumfUWUrR0l
         kUNg==
X-Gm-Message-State: AC+VfDzjwCdHI8DTnocsa6agL56hA6dmXBvu/eDe0S7ltZq1oSuzzK2c
        A64+3cGA8HZNRp+bIZXh9FrkmB1id8vthEKRGH39lwCpW9xIINKPx8s7djWjdR7ud6gWXt+HsBm
        obQTlQ7xRihlZlYttF1T6c2ZxIczlLrUz
X-Received: by 2002:aa7:c546:0:b0:50b:d4e8:3173 with SMTP id s6-20020aa7c546000000b0050bd4e83173mr30245714edr.8.1684225920416;
        Tue, 16 May 2023 01:32:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k5QzvaE25vkNdDIHzpYPG2zuP0QWC8FKdmCrqUMe5TtheYmqT2Gm/bx+ZTnQHNHjHQBl+xQ==
X-Received: by 2002:aa7:c546:0:b0:50b:d4e8:3173 with SMTP id s6-20020aa7c546000000b0050bd4e83173mr30245703edr.8.1684225920071;
        Tue, 16 May 2023 01:32:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7c70c000000b0050bd7267a5csm7905686edq.58.2023.05.16.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:31:59 -0700 (PDT)
Message-ID: <b2082cef-2e23-253d-4833-542c3460972a@redhat.com>
Date:   Tue, 16 May 2023 10:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ACPI: scan: Reduce overhead related to devices with
 dependencies
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <2694293.mvXUDI8C0e@kreacher>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2694293.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 5/15/23 18:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
>  drivers/acpi/scan.c     |   79 +++++++++++++++++++++++++++++++++++-------------
>  include/acpi/acpi_bus.h |    2 +
>  2 files changed, 61 insertions(+), 20 deletions(-)
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
> @@ -2406,6 +2410,53 @@ struct acpi_device *acpi_dev_get_next_co
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
> +		 * Even though the lock is released here, tmp is guaranteed to
> +		 * be valid, because none of the list entries following dep is
> +		 * marked as "free when met" and so they cannot be deleted.
> +		 */
> +		mutex_unlock(&acpi_dep_list_lock);
> +
> +		/*
> +		 * In case there are multiple acpi_dep_list entries with the
> +		 * same consumer, skip the current entry if the consumer device
> +		 * object corresponding to it is present already.
> +		 */
> +		if (!acpi_fetch_acpi_dev(handle))
> +			acpi_scan_postponed_branch(handle);

acpi_fetch_acpi_dev(handle) does not need/take the acpi_dep_list_lock,
so you can avoid a needless unlock/lock in case acpi_fetch_acpi_dev(handle)
finds a device already, which will happen quite regular since devices
with _DEP lists regularly have more then 1 dep so they will be present
as consumer on the _DEP list more then once.

So maybe:

	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
		acpi_handle handle = dep->consumer;
		struct acpi_device *device = acpi_fetch_acpi_dev(handle);

		/*
		 * In case there are multiple acpi_dep_list entries with the
		 * same consumer, skip scanning the current entry if the consumer
		 * device object corresponding to it is present already.
		 */
		if (device)
			goto check_dep;

		/*
		 * Even though the lock is released here, tmp is guaranteed to
		 * be valid, because none of the list entries following dep is
		 * marked as "free when met" and so they cannot be deleted.
		 */
		mutex_unlock(&acpi_dep_list_lock);
		acpi_scan_postponed_branch(handle);
		mutex_lock(&acpi_dep_list_lock);

check_dep:
		if (dep->met)
			acpi_scan_delete_dep_data(dep);
		else
			dep->free_when_met = true;
	}

?

Regards,

Hans



> +
> +	mutex_unlock(&acpi_dep_list_lock);
> +}
> +
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
>   * @handle: Root of the namespace scope to scan.
> @@ -2424,8 +2475,6 @@ int acpi_bus_scan(acpi_handle handle)
>  {
>  	struct acpi_device *device = NULL;
>  
> -	acpi_bus_scan_second_pass = false;
> -
>  	/* Pass 1: Avoid enumerating devices with missing dependencies. */
>  
>  	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
> @@ -2438,19 +2487,9 @@ int acpi_bus_scan(acpi_handle handle)
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

