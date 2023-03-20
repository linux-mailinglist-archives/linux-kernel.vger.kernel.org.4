Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18C6C1484
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjCTORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjCTORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94491B322
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679321791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7BNvZSyMFUXXKRAM/3Wh/LR1t8hMCWVcf495H/VX+E=;
        b=dZTEHAEXWIo6L7/jRBvOAfuk0YKGlYEdp/w6DAQkn3y736XGuyfg/4v1pXnIvjxsRRJ1NH
        gEPH4YFVE1Xu+QHWGoc/JRy3T1tvUt+JuhYPlFRlXUySs4dqyo9evu6dBl27tOHFn65wa0
        41DuuwjyJLltl+sO7xc8BojST59ii7I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Ps6YSPaXNqChiEeZ8ClvmA-1; Mon, 20 Mar 2023 10:16:30 -0400
X-MC-Unique: Ps6YSPaXNqChiEeZ8ClvmA-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so17440330edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7BNvZSyMFUXXKRAM/3Wh/LR1t8hMCWVcf495H/VX+E=;
        b=FNtXD1JEbP3jqZr2iUfSOt7R89vGDtfUAMHc/5mqMSAjzjhMFOArAqkY1xX4jNV/03
         h0onsvgeyJigtIVM1PnVhLgBStAQgSwDFaDM0pryRa5NBUESUVDX6fIJVMDnubEjGsp2
         WVgimPv7QSxOhVtshw9uJBiZKL2eRDfAXxDKb2RmBnu5iqjGSIGElRg+r0eufbJgZpOf
         HtWTyT5rFiZRfTak4sJxbdGeIK3xmFwUJ8dSEbMura/ld6c9qIKzLS/rLdcGfMDwms07
         VaADiHJjvrY3R5L5rXbzjQPdtc3PuUqUwDGo0BCGATCFLprWSkjtG9PbhMZfW8yEPVU7
         AI2w==
X-Gm-Message-State: AO0yUKVEWTDrXPrJLGN7o27376r5g0ttEjseibF9PBTVbXFgZeqLGJFE
        mbdnLKuYTPdStvUCaEqzabWMQrK/kwrn8FkfcYSUS60X+M2EW0vSt3ZvpDMoLdcD5BbhI8Bn9BX
        CR5B10rKTK5I5+DJUY4JOFdrV
X-Received: by 2002:aa7:dccc:0:b0:4ff:7116:189e with SMTP id w12-20020aa7dccc000000b004ff7116189emr14021369edu.31.1679321787638;
        Mon, 20 Mar 2023 07:16:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set+H120Djw7WvYyeT8Kn2j8G+Xjsj756GGqI7rfs2MEdgJjxp3Ui95PHJDZM2/f6rPnjh2FrAw==
X-Received: by 2002:aa7:dccc:0:b0:4ff:7116:189e with SMTP id w12-20020aa7dccc000000b004ff7116189emr14021348edu.31.1679321787367;
        Mon, 20 Mar 2023 07:16:27 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q3-20020a50cc83000000b004fc86fcc4b3sm4950765edi.80.2023.03.20.07.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:16:26 -0700 (PDT)
Message-ID: <b85be6b8-c19b-6d35-5d65-686adf990c73@redhat.com>
Date:   Mon, 20 Mar 2023 15:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] platform/x86/intel/pmt: Add INTEL_PMT module
 namespace
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230316225736.2856521-1-david.e.box@linux.intel.com>
 <CAHp75VcB9vokGSZ6ZCqyuNGfVWpn8vdTeLyHSO9MiuSoXR8tqw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcB9vokGSZ6ZCqyuNGfVWpn8vdTeLyHSO9MiuSoXR8tqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/17/23 14:34, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 12:57 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
>>
>> Since the currently exported symbols in pmt_class are only used by other
>> Intel PMT drivers, create an INTEL_PMT module namespace for them.
> 
> Makes sense.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you both for the patch and review, I've applied this
patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> ---
>>  drivers/platform/x86/intel/pmt/class.c     | 6 +++---
>>  drivers/platform/x86/intel/pmt/crashlog.c  | 1 +
>>  drivers/platform/x86/intel/pmt/telemetry.c | 1 +
>>  3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
>> index 46598dcb634a..0b96d75f5924 100644
>> --- a/drivers/platform/x86/intel/pmt/class.c
>> +++ b/drivers/platform/x86/intel/pmt/class.c
>> @@ -33,7 +33,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
>>          */
>>         return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
>>  }
>> -EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
>> +EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
>>
>>  static inline int
>>  pmt_memcpy64_fromio(void *to, const u64 __iomem *from, size_t count)
>> @@ -327,7 +327,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
>>         return intel_pmt_dev_register(entry, ns, dev);
>>
>>  }
>> -EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
>> +EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
>>
>>  void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
>>                            struct intel_pmt_namespace *ns)
>> @@ -343,7 +343,7 @@ void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
>>         device_unregister(dev);
>>         xa_erase(ns->xa, entry->devid);
>>  }
>> -EXPORT_SYMBOL_GPL(intel_pmt_dev_destroy);
>> +EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_destroy, INTEL_PMT);
>>
>>  static int __init pmt_class_init(void)
>>  {
>> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
>> index ace1239bc0a0..bbb3d61d09f4 100644
>> --- a/drivers/platform/x86/intel/pmt/crashlog.c
>> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
>> @@ -328,3 +328,4 @@ module_exit(pmt_crashlog_exit);
>>  MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
>>  MODULE_DESCRIPTION("Intel PMT Crashlog driver");
>>  MODULE_LICENSE("GPL v2");
>> +MODULE_IMPORT_NS(INTEL_PMT);
>> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
>> index 5e4009c05ecf..71cdef42084a 100644
>> --- a/drivers/platform/x86/intel/pmt/telemetry.c
>> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
>> @@ -160,3 +160,4 @@ module_exit(pmt_telem_exit);
>>  MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
>>  MODULE_DESCRIPTION("Intel PMT Telemetry driver");
>>  MODULE_LICENSE("GPL v2");
>> +MODULE_IMPORT_NS(INTEL_PMT);
>>
>> base-commit: 79df06733435e2773eb5e9ab9c0ce13c23e4cd88
>> --
>> 2.34.1
>>
> 
> 

