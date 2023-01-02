Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A665B67D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjABSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjABSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:12:00 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83133CC7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:11:58 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id CPHtp1H73IwEfCPHtp43d1; Mon, 02 Jan 2023 19:11:55 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jan 2023 19:11:55 +0100
X-ME-IP: 86.243.100.34
Message-ID: <ee53c6c9-4bd3-09ef-9b78-4eaf1f9ca682@wanadoo.fr>
Date:   Mon, 2 Jan 2023 19:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] thermal/acpi: Add ACPI trip point routines
Content-Language: fr
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
References: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
 <20230102180112.1954082-2-daniel.lezcano@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230102180112.1954082-2-daniel.lezcano@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/01/2023 à 19:01, Daniel Lezcano a écrit :
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The ACPI specification describes the trip points, the device tree
> bindings as well.
> 
> The OF code uses the generic trip point structures.
> 
> The ACPI has their own trip points structure and uses the get_trip_*
> ops to retrieve them.
> 
> We can do the same as the OF code and create a set of ACPI functions
> to retrieve a trip point description. Having a common code for ACPI
> will help to cleanup the remaining Intel drivers and get rid of the
> get_trip_* functions.
> 
> These changes add the ACPI thermal calls to retrieve the basic
> information we need to be reused in the thermal ACPI and Intel
> drivers.
> 
> The different ACPI functions have the generic trip point structure
> passed as parameter where it is filled.
> 
> This structure aims to be the one used by all the thermal drivers and
> the thermal framework.
> 
> After this series, a couple of Intel drivers and the ACPI thermal
> driver will still have their own trip points definition but a new
> series on top of this one will finish the conversion to the generic
> trip point handling.
> 
> This series depends on the generic trip point added to the thermal
> framework and available in the thermal/linux-next branch.
> 
>   https://lkml.org/lkml/2022/10/3/456
> 
> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

[...]

> +int thermal_acpi_trip_psv_tc2(struct acpi_device *adev)
> +{
> +	acpi_status status;
> +	unsigned long long tc2;
> +	
> +	/*
> +	 * _TC2 (Thermal Constant 1): This object evaluates to the constant _TC2

Hi, should there be a V3 (or if/when the patch is applied):
Thermal Constant s/1/2/?

CJ

> +	 * for use in the Passive cooling formula
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_TC2", NULL, &tc2);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return (int)tc2;
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv_tc2);

[...]
