Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF3631D95
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiKUKA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiKUKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FA2CE1D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669024793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZZ6zgpefATpze9WYlIRp9zJc0FqIuf4c5sQsXmR1+M=;
        b=VVH6lMrcxxRhVo/TID0x9l8rcznw1WcpklgSHf/B8Zy7h/MIwnB8FzVvgUF5sIRWz3O3tp
        mzheJrmhhVz2Xs8hwtIw/kJ93vR4J6GRwHR8IWsrDktRhKX3/PmU04HVIDWBkpvCAopanV
        0BxUSXBIuXdGrNp/Sa2ma1/Te1Gwlh8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-e9tCnByBMgis35XZQ5JptA-1; Mon, 21 Nov 2022 04:59:52 -0500
X-MC-Unique: e9tCnByBMgis35XZQ5JptA-1
Received: by mail-ej1-f71.google.com with SMTP id qa14-20020a170907868e00b007ae24f77742so6292401ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZZ6zgpefATpze9WYlIRp9zJc0FqIuf4c5sQsXmR1+M=;
        b=I2p6WxFv+TmKZcB3SU7+/I6WkAammiNf6YYW7hQdv3pHEZOSmJjKEGfwUHu7wdBloR
         6RnWzPm/l1EiVwlmx/IytvjZdh/UQHji1YevCeqyfYX+7JNEBHotmc6s1h9X/WnMrZjm
         o/NrVzXG7h0izkjhodI4X3jDCN7vO3I00yRvzkfDB4Kms5DTY8mHepcQmOcA2CZVIYNu
         5XIJ0cYqDU/ulgbJpINbqtXSdRrV+CMsgUUABFyAoi9YSyHQD11aW5wXJJ+YKmZQwO/M
         zBNVAdBKDEL80TEnZKCaTfgzFgyuGWc5bx+yt0hYSB2lgSIuGCEzS7gjEYzyB4ztgdID
         oaaA==
X-Gm-Message-State: ANoB5pm5oLHhsl6i/8yrY2YOutWdkVtRoGeheNrmpAY1oTdYBOFSIVDD
        CZKyLwUecQu/czP7Y6bexRKgDjm/eXFY5XeOAjjwc1z4q5Fh6eEPxdy2xdeiA3pLxk+XSMNSa4K
        5FB2JfueNGVYEEauK1mAp8AJO
X-Received: by 2002:a05:6402:b8c:b0:463:b8dc:893f with SMTP id cf12-20020a0564020b8c00b00463b8dc893fmr15951395edb.28.1669024791252;
        Mon, 21 Nov 2022 01:59:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6JN0bg6YWzIrI4NnUXEaKbK3Bu8IDRyO6VBRpl+3DEoIZv/T0KL9yZoyPQvsGmRXIoOscybQ==
X-Received: by 2002:a05:6402:b8c:b0:463:b8dc:893f with SMTP id cf12-20020a0564020b8c00b00463b8dc893fmr15951384edb.28.1669024791077;
        Mon, 21 Nov 2022 01:59:51 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b0078135401b9csm4857209ejc.130.2022.11.21.01.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:59:50 -0800 (PST)
Message-ID: <494ebac4-27f4-c240-688b-072b8083136e@redhat.com>
Date:   Mon, 21 Nov 2022 10:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V2 0/9] Extend Intel On Demand (SDSi) support
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119002343.1281885-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221119002343.1281885-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/22 01:23, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is now known as Intel On Demand. The
> following patches do the following:
> 
> 1. Identify the driver/tools as Intel On Demand. Only text descriptions are
> changed. Kconfig and filenames remain the same.
> 2. Perform some attribute cleanup by preventing the showing of files when
> features are not supported.
> 3. Adds support for a new GUID. GUIDs are used to identify the layout of
> the On Demand registers in sysfs. Layouts are described in the
> documentation on github [1].
> 4. Add support for reading On Demand meter certificates in sysfs.
> 5. The rest of the patches modify the existing tool to support discovery
> and reading of On Demand registers and the meter certificate.
> 
> Link: https://github.com/intel/intel-sdsi/blob/master/os-interface.rst [1]

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
> David E. Box (9):
>   platform/x86/intel/sdsi: Add Intel On Demand text
>   platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
>   platform/x86/intel/sdsi: Support different GUIDs
>   platform/x86/intel/sdsi: Add meter certificate support
>   tools/arch/x86: intel_sdsi: Add support for reading state certificates
>   tools/arch/x86: intel_sdsi: Add Intel On Demand text
>   tools/arch/x86: intel_sdsi: Read more On Demand registers
>   tools/arch/x86: intel_sdsi: Add support for new GUID
>   tools/arch/x86: intel_sdsi: Add support for reading meter certificates
> 
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  47 +-
>  drivers/platform/x86/intel/Kconfig            |   8 +-
>  drivers/platform/x86/intel/sdsi.c             | 136 +++++-
>  tools/arch/x86/intel_sdsi/intel_sdsi.c        | 462 ++++++++++++++----
>  4 files changed, 516 insertions(+), 137 deletions(-)
> 
> 
> base-commit: 260ad3de718301ed8c22e28558e3a31c99f54cf6

