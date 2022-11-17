Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22B62DDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiKQOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiKQOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25062054
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668694229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOfT5eurCDMRxlkmRM+KtqZ95XT89veQx2mLMpeWx5s=;
        b=CLSV3SpJGhwvtmUhPoWN6QciGKUlPdgWCFeM/Coxpp7UAtyMjhw4CQLJpO909I6zLqB86e
        W8BtOZ3BBn6ab/gJ3VZtSKk8HHR0BQcCXi1u7449mbldS4aCJLsY+P3q16M/Uss6PrL4c1
        UsTP9hpa0uhdZkb4s4lWjH+nkMiu1NA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-Ddu0Z2hKPXK9Bye0mYJsKw-1; Thu, 17 Nov 2022 09:10:28 -0500
X-MC-Unique: Ddu0Z2hKPXK9Bye0mYJsKw-1
Received: by mail-ed1-f70.google.com with SMTP id c9-20020a05640227c900b00463de74bc15so1304426ede.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOfT5eurCDMRxlkmRM+KtqZ95XT89veQx2mLMpeWx5s=;
        b=0xJWBl/v384ojCljClamt7reSkI+WwJZfPgX+LDHKm7/St3RjTnxL4EoNFh/bAkn6m
         0NQMN3HmhiZdZ/WJ3xMTxt2A+gOtii6KXSGddzxztbAu5Yce4UfiQmZoRcaUD8ACrCNw
         LKgf8ArL4Bz2tJsUCZmCqsQWc51tpLjogUbxQ5C0TY/fnNuu5xTi1dgorrJ5IX0Mj6z0
         obww9UWfjn/NO3yANG9gOP5UA0Tl9N4GyI+4AjQ8qVljXguPlOLZOQfWo5LIe7OR/YIt
         RlfeRdsWQ5272huS88bvuQUL7QCgQXJ9uEZiIU3vedWaVT4aKDoecdFCWP6eAIMZhk6l
         /+UA==
X-Gm-Message-State: ANoB5pn1jQcjQfDRPHt287+xCu5oj4SEXt/kt7MH61zaco2lGAzqlRJQ
        eKfm/Zbj73p5wAiJ+2jGBJrkcWkORKSq187EWS2FNV38fSuQTVqr1eMLJnrhSSCn/2dbOIoouSw
        wOgGwnhUGN/CPVgmofVFz5IcH
X-Received: by 2002:a17:906:a0d7:b0:7b2:7af0:c231 with SMTP id bh23-20020a170906a0d700b007b27af0c231mr2246812ejb.240.1668694227325;
        Thu, 17 Nov 2022 06:10:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5yZNP1T9Ajp8UDXy9301jUiAy463N9N6Tnb93rlCZ5crLe0F9/d4DGRRfgxna+qFpfi0BKgg==
X-Received: by 2002:a17:906:a0d7:b0:7b2:7af0:c231 with SMTP id bh23-20020a170906a0d700b007b27af0c231mr2246782ejb.240.1668694227137;
        Thu, 17 Nov 2022 06:10:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007acd04fcedcsm413829ejh.46.2022.11.17.06.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:10:26 -0800 (PST)
Message-ID: <de3aae46-58bd-7041-df49-10cfb6be1603@redhat.com>
Date:   Thu, 17 Nov 2022 15:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 0/4] Make it easier to measure % in HW sleep state
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>
References: <20221115200156.12218-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221115200156.12218-1-mario.limonciello@amd.com>
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

On 11/15/22 21:01, Mario Limonciello wrote:
> Sven van Ashbrook brought a patch to the kernel mailing list that
> attempted to change the reporting level of a s0ix entry issue to a
> different debugging level so that infastructure used by Google could
> better scan logs to catch problems.
> 
> This approach was rejected, but during the conversation another
> suggestion was made by David E. Box to introduce some infrastructure
> into the kernel to report this information.
> 
> As it's information that is reported by both AMD and Intel platforms
> over s2idle, this seems to make sense.
> 
> RFC v1 and v2 introduced two new sysfs files to report the information, but
> Rafael pointed out that there was already a file that could be used on
> Intel platforms: `low_power_idle_system_residency_us`.
> 
> RFC v3 creates this file for AMD platforms and also introduces another file
> that can be used to determine total sleep time:
> `/sys/power/suspend_stats/last_total`.
> 
> With these two files a simple shell script can be run after suspend to
> calculate the percentage.
> 
> ```
>  #!/bin/sh
> total=$(cat /sys/power/suspend_stats/last_total)
> hw=$(cat /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us)
> percent=$(awk -v hw=$hw -v total=$total 'BEGIN { printf "%.2f%%", (hw/total*100) }')
> echo "Last ${total}us suspend cycle spent $percent of the time in a hardware sleep state."
> ```
> 
> A sample run on an AMD platform that was just sleeping with this series on
> top of 6.1-rc5 shows the following:
>  # ./compare.sh
> Last 15699838us suspend cycle spent 98.63% of the time in a hardware sleep state.
> 
> Further discussion to be expected on this series:
> 
> * What last_total will represent from the suspend cycle
> 
> * Whether the semantics of all platforms will be the same for
>   `low_power_idle_system_residency_us`
>   - AMD platforms reset this counter before s2idle entry.  Do Intel? Others?
> 
> * Maybe the *kernel* should be responsible to do the calculation and export
>   a `last_hw_sleep_percent` file instead. Platform differences can be
>   abstracted then within individual drivers.

That (`last_hw_sleep_percent` file) is an interesting proposal,
I can see that being a better interface because as you say this allows
the kernel / platform-drivers to take care of any platform quirks /
weirdness, avoiding any userspace monitoring of this to possibly
give false positive warnings.

Regards,

Hans





> 
> Mario Limonciello (4):
>   PM: Add a sysfs file to represent the total sleep duration
>   platform/x86/intel/pmc: core: Drop check_counters
>   platform/x86/amd: pmc: Report duration of time in deepest hw state
>   platform/x86/amd: pmc: Populate cpuidle sysfs file with hw sleep data
> 
>  Documentation/ABI/testing/sysfs-amd-pmc |  6 ++++++
>  Documentation/ABI/testing/sysfs-power   |  8 ++++++++
>  drivers/platform/x86/amd/pmc.c          | 27 ++++++++++++++++++++++---
>  drivers/platform/x86/intel/pmc/core.c   |  7 ++-----
>  drivers/platform/x86/intel/pmc/core.h   |  1 -
>  include/linux/suspend.h                 |  2 ++
>  kernel/power/main.c                     | 15 ++++++++++++++
>  kernel/power/suspend.c                  |  2 ++
>  kernel/time/timekeeping.c               |  2 ++
>  9 files changed, 61 insertions(+), 9 deletions(-)
> 

