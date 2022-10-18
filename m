Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1854603393
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJRTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B187FA0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666122790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gjlp1ChEhbJR54DHK9OqHbYPJ/qd9E8PKZoUzlq+2fI=;
        b=OPJSs9f0PMHLo+cT1GccP7sOYcP1+4kuRSvYWfjq/PK/og6YYYbzw0iAq3SnVybe2GxFLx
        PspdJRbjrYqme18Aj51p3WptrNiyMfmB9ECXJ7C0Z6EK30kzQ311isQ/J6Gc4r+IE/EDFi
        C/R9EtkovIwhkmdsO7yRKWV42KQXVGs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-BsjUb9nTMHCqfZ04Lz7wxQ-1; Tue, 18 Oct 2022 15:53:07 -0400
X-MC-Unique: BsjUb9nTMHCqfZ04Lz7wxQ-1
Received: by mail-qv1-f72.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso9283498qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjlp1ChEhbJR54DHK9OqHbYPJ/qd9E8PKZoUzlq+2fI=;
        b=1zdfhUjD7l0WW0w5xs2fQUgl8EkuEDnCwJQ04jChu82jwabDwLXd9Jcw1M20im70tY
         1T8zgPh4RfAilmlCl7T89ZwftjF+75OtzsFmWdlQieCdaQZ5qxfIn4RIU6ING4cLs/K7
         FEEdD7J3gYG9Abcq6RbIi+e5oXgvthmg+o9zVjuOv9ROMYmCgn58idQkI3+EQKhX7XMP
         kWaBo02XQl5oET4kss1tDYNkrA3DP4PfXOHUAE8twU10eSRzfR9ImzS/Ltt60si9qPzk
         LqiN+uu8M5UnjLAWDRaMqd32Gq6G/GIgdZB+GnA/KqK5zYqjSTuM4vE/xdfKHkP6LW2e
         cVYg==
X-Gm-Message-State: ACrzQf2Q3pim+08N7GK07d0+pMe4iheucrzfd1QJ7rDnxHFWZmJl8eeK
        900HUJjkr/u4WSALythke0762WQzt0s8oeQv21ytfu3ZYh7kNSy4Jl8N4maSG/WENsmGoOCLqQ6
        qpl+34Tdhk784pDedYR1qkg3A
X-Received: by 2002:a05:620a:4842:b0:6ee:8c09:d7cf with SMTP id ec2-20020a05620a484200b006ee8c09d7cfmr3014954qkb.662.1666122786445;
        Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XwZuYhnNt5pJ+Ga0p80MytSXoidzNh89WZ7owAHjc4vHBOYoRyunzaTS+DAUdRX0F2Nwrgg==
X-Received: by 2002:a05:620a:4842:b0:6ee:8c09:d7cf with SMTP id ec2-20020a05620a484200b006ee8c09d7cfmr3014943qkb.662.1666122786095;
        Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bl12-20020a05620a1a8c00b006bbc09af9f5sm3174222qkb.101.2022.10.18.12.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:53:05 -0700 (PDT)
Message-ID: <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
Date:   Tue, 18 Oct 2022 15:53:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 14:33, Luis Chamberlain wrote:
> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>> The patch does address a regression observed after commit 6e6de3dee51a
>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>> loading"). I guess it can have a Fixes tag added to the patch.
>>
>> I think it is hard to split this patch into parts because the implemented
>> "optimization" is the fix.
> 
> git describe --contains 6e6de3dee51a
> v5.3-rc1~38^2~6
> 
> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> right thing to do, but without it, it still leaves the issue reported
> by Prarit Bhargava. We need a way to resolve the issue on stable and
> then your optimizations can be applied on top.
> 
> Prarit Bhargava, please review Petry's work and see if you can come up
> with a sensible way to address this for stable.

I found the original thread surrounding these changes and I do not think 
this solution should have been committed to the kernel.  It is not a 
good solution to the problem being solved and adds complexity where none 
is needed IMO.

Quoting from the original thread,

> 
> Motivation for this patch is to fix an issue observed on larger machines with
> many CPUs where it can take a significant amount of time during boot to run
> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
> attempt to load these modules too. The operation will eventually fail in the
> init function of a respective module where it gets recognized that another
> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
> is triggered for each CPU and so multiple loads of these modules will be
> present. The current code then processes all such loads individually and
> serializes them with the barrier in add_unformed_module().
> 

The way to solve this is not in the module loading code, but in the udev 
code by adding a new event or in the userspace which handles the loading 
events.

Option 1)

Write/modify a udev rule to to use a flock userspace file lock to 
prevent repeated loading.  The problem with this is that it is still 
racy and still consumes CPU time repeated load the ELF header and, 
depending on the system (ie a large number of cpus) would still cause a 
boot delay.  This would be better than what we have and is worth looking 
at as a simple solution.  I'd like to see boot times with this change, 
and I'll try to come up with a measurement on a large CPU system.

Option 2)

Create a new udev action, "add_once" to indicate to userspace that the 
module only needs to be loaded one time, and to ignore further load 
requests.  This is a bit tricky as both kernel space and userspace would 
have be modified.  The udev rule would end up looking very similar to 
what we now.

The benefit of option 2 is that driver writers themselves can choose 
which drivers should issue "add_once" instead of add.  Drivers that are 
known to run on all devices at once would call "add_once" to only issue 
a single load.

Thoughts?

P.

