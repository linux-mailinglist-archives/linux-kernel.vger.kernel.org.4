Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A866A61EEE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKGJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKGJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430117AA0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667813055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zudUvGHItJCXzYsNesQp/1KXLKVzgoLhNyUkkrXfU2g=;
        b=bSYnSrJziPC7ixuEt8Q3dVB1ccofUquC7xTjbBZPWKnTYFIbLv3bKFpl0W6hzxftCLgOql
        SpofdvlYPdqMH/JcruHKtwpq5NMjbZz3KPtRNXxSMlIk5KlfWBz6wEoUdtJm/SLvsFidfj
        gmvHKraSn9XzZAKsjbbcDtTJfQTzdgI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-DnpndvbjOCSgmlw8bPnobA-1; Mon, 07 Nov 2022 04:24:11 -0500
X-MC-Unique: DnpndvbjOCSgmlw8bPnobA-1
Received: by mail-ed1-f70.google.com with SMTP id dz9-20020a0564021d4900b0045d9a3aded4so7999106edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zudUvGHItJCXzYsNesQp/1KXLKVzgoLhNyUkkrXfU2g=;
        b=VsZ4gr6Evg1otQcVeTZtMmhqinYJR0bnA+0aPK77Ypt46a5XS1k+f+hRHZzoBs07d0
         yEhO2+yiiBTf6U+ILAxMFsMTUiDfxXbZZLwHiFJX9YCUtL/EUwe0wphQJg5mvximlrek
         Xi/ZUKFrn5CDRZpDk6ok4Nlz5WGBDYJ5MEoutHq9+JbCahVGLe28AC5nZ7QiZ+c20fFa
         Loyi9C+Xmavzq8ZJV0kW8EbH3UEL6OIgXAD4EAkWBcdFv3BDxhBbofZiFeTg4svqjWsN
         eKOZc7S82d2M+7jl0aUdgooEw21d+O26b50qxKg9/d/a3Bw2APhQNDLgXHdC7LRJC72B
         udRQ==
X-Gm-Message-State: ACrzQf3Xd2rh+6PnJx5qAot3C/ridwCofAJzEGMemVnLfca5Q4tqSHi+
        2Mk7jzzlBPAZRcT5CjbDbZHTZPjoT80YPBEWT2wuNpBqLf4V0XrJ+S9/I9wNfzIb7MA/1y9oA39
        W4MbfAXMXXX6zh8poypg3WcKB
X-Received: by 2002:aa7:d80a:0:b0:462:2c1c:8716 with SMTP id v10-20020aa7d80a000000b004622c1c8716mr50284535edq.185.1667813050605;
        Mon, 07 Nov 2022 01:24:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4S4Q/hBP1vxV5dzFKqqTCIw//NzGSBJYV52hQFwokS603v6ovdGyaOynySBQ+vHfE+4fwKxg==
X-Received: by 2002:aa7:d80a:0:b0:462:2c1c:8716 with SMTP id v10-20020aa7d80a000000b004622c1c8716mr50284526edq.185.1667813050439;
        Mon, 07 Nov 2022 01:24:10 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b00738795e7d9bsm3105053ejc.2.2022.11.07.01.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:24:09 -0800 (PST)
Message-ID: <ef0df3da-c8b1-b996-edfc-d14956f953f4@redhat.com>
Date:   Mon, 7 Nov 2022 10:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/14] IFS multi test image support and misc changes
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
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

On 10/21/22 22:33, Jithu Joseph wrote:
> Initial implementation of IFS driver assumed a single IFS test image
> file with a fixed name.
> 
> Subsequently, it became evident that supporting more than one
> test image file is needed to provide more comprehensive
> test coverage. (Test coverage in this scenario refers to testing
> more transistors in the core to identify faults).
> 
> This series makes the driver aware of multiple scan test image files,
> modifies IFS test image file headers to make it fully compatible
> with microcode headers and adds a few other bug fixes and changes.
> 
> Patch organization:
> Patches 1, 2, and 3: bug fixes
> Patch 4: Removes image loading during init path 
> Patch 5, 6 and 7: exports a couple of microcode/intel.c functions
>                   for use by driver
> Patch 8: Adds Meta-data support in microcode file
> 
> Rest of them are IFS driver changes
> Patches 9 and 10: IFS header format changes to make it fully compatible
>  to intel microcode header format
> Patches 11, 12 and 13: native support for multiple scan test image files
> Patch 14: reverts the broken flag

Thank you for your work on this. Due to personal circumstances I have
been unable to do any pdx86 patch review for the last 2 weeks.

I see that there have been lots of comments on this series already please
send a new version 2 addressing all the existing comments. Then I will
review version 2 once posted.

Regards,

Hans





> 
> Ashok Raj (1):
>   x86/microcode/intel: Meta-data support in microcode file
> 
> Jithu Joseph (13):
>   platform/x86/intel/ifs: Remove unused selection
>   platform/x86/intel/ifs: Propagate load failure error code
>   platform/x86/intel/ifs: return a more appropriate Error code
>   platform/x86/intel/ifs: Remove image loading during init
>   x86/microcode/intel: Expose find_matching_signature() for IFS
>   x86/microcode/intel: Use appropriate type in microcode_sanity_check()
>   x86/microcode/intel: Expose microcode_sanity_check()
>   platform/x86/intel/ifs: Use generic microcode headers and functions
>   platform/x86/intel/ifs: Add metadata validation
>   platform/x86/intel/ifs: Remove reload sysfs entry
>   platform/x86/intel/ifs: Add current_batch sysfs entry
>   Documentation/ABI: Update IFS ABI doc
>   Revert "platform/x86/intel/ifs: Mark as BROKEN"
> 
>  arch/x86/include/asm/microcode_intel.h        |  25 ++-
>  drivers/platform/x86/intel/ifs/ifs.h          |  27 ++-
>  arch/x86/kernel/cpu/microcode/intel.c         |  81 ++++++--
>  drivers/platform/x86/intel/ifs/core.c         |   7 +-
>  drivers/platform/x86/intel/ifs/load.c         | 174 +++++++++---------
>  drivers/platform/x86/intel/ifs/runtest.c      |  10 +-
>  drivers/platform/x86/intel/ifs/sysfs.c        |  41 +++--
>  .../ABI/testing/sysfs-platform-intel-ifs      |  30 +--
>  drivers/platform/x86/intel/ifs/Kconfig        |   4 -
>  9 files changed, 243 insertions(+), 156 deletions(-)
> 
> 
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff

