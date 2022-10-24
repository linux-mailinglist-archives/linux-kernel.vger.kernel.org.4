Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273EC60BF52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJYAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJYAPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138E236421
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666650867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfAUAmtuZAJ2/gdCGNu3yXanAGczpHvB4SK/U8ucWH4=;
        b=aLpNY0VOp0hz8nXm7npeVCqji2vbuBibykWTS33PYPhJuEiO9SjAubn4rcmthuU8jh1zbH
        nwXQgbq/PRh16FZSzLVr+QPIbCI/jFjNx/hs8w/BW3DZjPKvBdYJ8EBOq/mA65leRyU8kj
        CAkTxx+oabPp18ed6Bsj0D+Tx5sLx4M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-2h5LrTenN_mxYY3rj4-H6A-1; Mon, 24 Oct 2022 10:00:24 -0400
X-MC-Unique: 2h5LrTenN_mxYY3rj4-H6A-1
Received: by mail-qt1-f198.google.com with SMTP id cr15-20020a05622a428f00b0039cf1f8c94fso7070656qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfAUAmtuZAJ2/gdCGNu3yXanAGczpHvB4SK/U8ucWH4=;
        b=EBiHomeB/dlYjkCMMcvQHZVmZRz2qsv5AdGLckI7HL85kkR6x4zzjXCu+Ujd9FAJCI
         NPHz4mVSvEuPUBgb7s331/TT+jEisPKuBL80Nlpu0Z4CXPSlr/SWxZ39dPWC4JLZki7v
         lI8ALhvdXGUcTiTfAnFi+Vcbo+juaUo4SfKnjKOvIcw2qBwSHFSj4qyFAB4CFImH3u+N
         TLr+J/TM1hlv9Ggc7+/lQv+ueTQGf5DaD+RdQs1uGmBT8iirUsrz6lh7hfMPTaHKut0L
         ZZPyDVjkC5GvazQDEuj06E/8aBviiS6R6x3J4nukbZzjY/UpbwvrTTz2T168nQgC8WCs
         jnwg==
X-Gm-Message-State: ACrzQf1mKNmAVaIXwjHuKZG9fo2VpIxuzWqwkLApT+WxT2cKTEtTZI7V
        FtbExs6jjf0EjHQ+ksuiQ8f1zAgAyOm5pQcNZH6THw4UwHT+fOA80zFTFglozOSfgRLvw5qWqDT
        e7dqyeHpi171Tw4vmFbAp8SpP
X-Received: by 2002:a05:620a:4111:b0:6ed:ddf9:6955 with SMTP id j17-20020a05620a411100b006edddf96955mr22791751qko.19.1666620023282;
        Mon, 24 Oct 2022 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4b+bYbc6QWX6s1Eqnf4Y9AvCIRYdXACGADlzYGuUDmKZpTN1IFVNl7kD66DHjZw/UmufcYcQ==
X-Received: by 2002:a05:620a:4111:b0:6ed:ddf9:6955 with SMTP id j17-20020a05620a411100b006edddf96955mr22791716qko.19.1666620022904;
        Mon, 24 Oct 2022 07:00:22 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006ef1a8f1b81sm31248qko.5.2022.10.24.07.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:00:22 -0700 (PDT)
Message-ID: <3ca5f15d-7d14-2ab0-db1f-1c4384894e0d@redhat.com>
Date:   Mon, 24 Oct 2022 10:00:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
 <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 08:37, Petr Pavlu wrote:
> On 10/18/22 21:53, Prarit Bhargava wrote:
>> Quoting from the original thread,
>>
>>>
>>> Motivation for this patch is to fix an issue observed on larger machines with
>>> many CPUs where it can take a significant amount of time during boot to run
>>> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
>>> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
>>> attempt to load these modules too. The operation will eventually fail in the
>>> init function of a respective module where it gets recognized that another
>>> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
>>> is triggered for each CPU and so multiple loads of these modules will be
>>> present. The current code then processes all such loads individually and
>>> serializes them with the barrier in add_unformed_module().
>>>
>>
>> The way to solve this is not in the module loading code, but in the udev
>> code by adding a new event or in the userspace which handles the loading
>> events.
>>
>> Option 1)
>>
>> Write/modify a udev rule to to use a flock userspace file lock to
>> prevent repeated loading.  The problem with this is that it is still
>> racy and still consumes CPU time repeated load the ELF header and,
>> depending on the system (ie a large number of cpus) would still cause a
>> boot delay.  This would be better than what we have and is worth looking
>> at as a simple solution.  I'd like to see boot times with this change,
>> and I'll try to come up with a measurement on a large CPU system.
> 
> It is not immediately clear to me how this can be done as a udev rule. You
> mention that you'll try to test this on a large CPU system. Does it mean that
> you have a prototype implemented already? If yes, could you please share it?
> 

Hi Petr,

Sorry, I haven't had a chance to actually test this out but I see this 
problem with the acpi_cpufreq and other multiple-cpu drivers which load 
once per logical cpu.  I was thinking of adding a udev rule like:

ACTION!="add", GOTO="acpi_cpufreq_end"

# I may have to add CPU modaliases here to get this to work correctly
ENV{MODALIAS}=="acpi:ACPI0007:", GOTO="acpi_cpufreq_start"

GOTO="acpi_cpufreq_start"
GOTO="acpi_cpufreq_end"

LABEL="acpi_cpufreq_start"

ENV{DELAY_MODALIAS}="$env{MODALIAS}"
ENV{MODALIAS}=""
PROGRAM="/bin/sh -c flock -n /tmp/delay_acpi_cpufreq sleep 2'", 
RESULT=="", RUN{builtin}+="kmod load $env{DELAY_MODALIAS}"

LABEL="acpi_cpufreq_end"


> My reading is that one would need to update the "MODALIAS" rule in
> 80-drivers.rules [1] to do this locking. However, that just collects
> 'kmod load' (builtin) for udev to execute after all rules are processed. It
> would then be required to synchronize udev workers to prevent repeated
> loading?
> 

Yes, that would be the case.

>> Option 2)
>>
>> Create a new udev action, "add_once" to indicate to userspace that the
>> module only needs to be loaded one time, and to ignore further load
>> requests.  This is a bit tricky as both kernel space and userspace would
>> have be modified.  The udev rule would end up looking very similar to
>> what we now.
>>
>> The benefit of option 2 is that driver writers themselves can choose
>> which drivers should issue "add_once" instead of add.  Drivers that are
>> known to run on all devices at once would call "add_once" to only issue
>> a single load.
> 
> On the device event side, I more wonder if it would be possible to avoid tying
> up cpufreq and edac modules to individual CPU devices. Maybe their loading
> could be attached to some platform device, even if it means introducing an
> auxiliary device for this purpose? I need to look a bit more into this idea.

That's an interesting idea and something I had not considered.  Creating 
a virtual device and loading against that device would be much better 
(easier?) of a solution.

P.

> 
> [1] https://github.com/systemd/systemd/blob/4856f63846fc794711e1b8ec970e4c56494cd320/rules.d/80-drivers.rules
> 
> Thanks,
> Petr
> 

