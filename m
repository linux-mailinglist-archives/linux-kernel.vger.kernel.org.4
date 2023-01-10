Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A706647E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjAJR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbjAJR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:57:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0361B9FB;
        Tue, 10 Jan 2023 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673373373; x=1704909373;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=c69QDQ8jJjhQ1kZ5R4VbVRTklNvsikDqLG37OrYt+nE=;
  b=Hnw7Gd2Z/Jyv31nf+CL7nZ4nHzpm0HLBw3w6eaiUxaviiTVX7mmOJK3V
   cnt+GHe5OrtddnsWxIrAuUZ+3dZCzr4TdxCjFTzSCAu7jdeTbKX2z9Mqy
   XdUfV8d2iiOHJtlGwrPdRA2x/ebxR/iC13WRMyoPhZz1Oi1zQzOptJOAJ
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jan 2023 09:56:12 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 09:56:12 -0800
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 09:56:11 -0800
Message-ID: <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
Date:   Tue, 10 Jan 2023 09:56:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-6-quic_eberman@quicinc.com>
 <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
Content-Language: en-US
In-Reply-To: <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Add hypercalls to identify when Linux is running a virtual machine under
>> Gunyah.
>>
>> There are two calls to help identify Gunyah:
>>
>> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>>     hypervisor.
>> 2. gh_hypercall_hyp_identify() returns build information and a set of
>>     feature flags that are supported by Gunyah.
> 
> The first is a "service", while the second is a "hypercall".
> Can you explain the distinction?  The sentence at the top
> refers to both as "hypercalls".
> 

I learned more details about this to answer your question. "get_uid()" 
is a standardized call that is ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID 
defined in include/arm-smccc.h. I'll use that.

>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   MAINTAINERS                          |  2 +
>>   arch/arm64/Kbuild                    |  1 +
>>   arch/arm64/gunyah/Makefile           |  1 +
>>   arch/arm64/gunyah/gunyah_hypercall.c | 69 ++++++++++++++++++++++++++++
>>   drivers/virt/Kconfig                 |  1 +
>>   drivers/virt/gunyah/Kconfig          | 12 +++++
>>   include/linux/gunyah.h               | 25 ++++++++++
>>   7 files changed, 111 insertions(+)
>>   create mode 100644 arch/arm64/gunyah/Makefile
>>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>>   create mode 100644 drivers/virt/gunyah/Kconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 74e76e0ab14d..36698df6b0e5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8941,6 +8941,8 @@ L:    linux-arm-msm@vger.kernel.org
>>   S:    Supported
>>   F:    Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>   F:    Documentation/virt/gunyah/
>> +F:    arch/arm64/gunyah/
>> +F:    drivers/virt/gunyah/
>>   F:    include/linux/gunyah.h
>>   HABANALABS PCI DRIVER
>> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
>> index 5bfbf7d79c99..e4847ba0e3c9 100644
>> --- a/arch/arm64/Kbuild
>> +++ b/arch/arm64/Kbuild
>> @@ -3,6 +3,7 @@ obj-y            += kernel/ mm/ net/
>>   obj-$(CONFIG_KVM)    += kvm/
>>   obj-$(CONFIG_XEN)    += xen/
>>   obj-$(subst m,y,$(CONFIG_HYPERV))    += hyperv/
>> +obj-$(CONFIG_GUNYAH)    += gunyah/
>>   obj-$(CONFIG_CRYPTO)    += crypto/
>>   # for cleaning
>> diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
>> new file mode 100644
>> index 000000000000..9fbc720b6fb6
>> --- /dev/null
>> +++ b/arch/arm64/gunyah/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
>> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c 
>> b/arch/arm64/gunyah/gunyah_hypercall.c
>> new file mode 100644
>> index 000000000000..0beb3123d650
>> --- /dev/null
>> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/arm-smccc.h>
>> +#include <linux/module.h>
>> +#include <linux/gunyah.h>
>> +
>> +#define GH_CALL_TYPE_PLATFORM_CALL        0
>> +#define GH_CALL_TYPE_HYPERCALL            2
>> +#define GH_CALL_TYPE_SERVICE            3
>> +#define GH_CALL_TYPE_SHIFT            14
>> +#define GH_CALL_FUNCTION_NUM_MASK        0x3fff
> 
> A FN_ID is a 32-bit value.  Are all 18 high-order bits considered
> part of the call type?  It might be good to specify that explicitly
> by defining a mask for it.
> 

With above in mind, I decided to simplify the macros and drop the TYPE 
field.

>> +
>> +#define GH_FN_ID(type, num)    ((type) << GH_CALL_TYPE_SHIFT | ((num) 
>> & GH_CALL_FUNCTION_NUM_MASK))
>> +
> 
> Is there any need for the endianness of these values to be specified?
> Does Gunyah operate with a well-defined endianness?  Is there any
> chance a VM can run with an endianness different from Gunyah?  I
> see that the arm_smcc_* structures are defined without endianness.
> (Sorry if these are dumb questions.)
> 

All of the data transfers for hypercalls happen via registers, so 
endianness doesn't have impact here (there is no "low address" in a 
register).

>> +#define GH_SERVICE(fn)        ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, 
>> ARM_SMCCC_SMC_32, \
>> +                           ARM_SMCCC_OWNER_VENDOR_HYP, \
>> +                           GH_FN_ID(GH_CALL_TYPE_SERVICE, fn))
>> +
>> +#define GH_HYPERCALL_CALL_UID            GH_SERVICE(0x3f01)
> 
> Perhaps 0x3f01 could be defined symbolically.
> 
> However if this is the only place it's ever used, doing so
> doesn't add much value (meaning, just do it the way you did).
> 
>> +
>> +#define GH_HYPERCALL(fn)    ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, 
>> ARM_SMCCC_SMC_64, \
>> +                           ARM_SMCCC_OWNER_VENDOR_HYP, \
>> +                           GH_FN_ID(GH_CALL_TYPE_HYPERCALL, fn))
>> +
>> +#define GH_HYPERCALL_HYP_IDENTIFY        GH_HYPERCALL(0x0000)
> 
> Will there be a growing set of well-known hypervisor call functions?
> Perhaps 0x0000 should be defined symbolically.  (Or not if it's only
> used here.)
> 

Yes, we would add growing set of well-known hypercalls. 0x0000 would 
only be used here.

>> +
>> +/**
>> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah 
>> hypervisor
>> + * @uid: An array of 4 u32's (u32 uid[4];)
>> + *
>> + * Caller should compare the resulting UID to a list of known Gunyah 
>> UIDs to
>> + * confirm that Linux is running as a guest of Gunyah.
> 
> I presume that, if the returned UID isn't well-known, then no other
> Gunyah-related calls are meaningful.  Is that correct?
> 

That's correct.

>> + */
>> +void gh_hypercall_get_uid(u32 uid[4])
>> +{
>> +    struct arm_smccc_res res;
>> +
>> +    arm_smccc_1_1_hvc(GH_HYPERCALL_CALL_UID, &res);
>> +
>> +    uid[0] = res.a0;
>> +    uid[1] = res.a1;
>> +    uid[2] = res.a2;
>> +    uid[3] = res.a3;
> 
> I see in the definition of struct arm_smccc_res that the four
> fields are unsigned long values.  That differs from the u32
> array passed as argument.  Are the resource IDs guaranteed to
> be four 32-bit values?  I personally prefer being explicit
> about the upper 32-bits being discarded (though some don't
> agree with that convention).
> 

Done.

>> +}
>> +EXPORT_SYMBOL_GPL(gh_hypercall_get_uid);
>> +
>> +/**
>> + * gh_hypercall_hyp_identify() - Returns build information and 
>> feature flags
>> + *                               supported by Gunyah.
>> + * @hyp_identity: filled by the hypercall with the API info and 
>> feature flags.
>> + */
>> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp 
>> *hyp_identity)
>> +{
>> +    struct arm_smccc_res res;
>> +
>> +    arm_smccc_1_1_hvc(GH_HYPERCALL_HYP_IDENTIFY, &res);
>> +
>> +    hyp_identity->api_info = res.a0;
>> +    hyp_identity->flags[0] = res.a1;
>> +    hyp_identity->flags[1] = res.a2;
>> +    hyp_identity->flags[2] = res.a3;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 87ef258cec64..259dc2be6cad 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -52,4 +52,5 @@ source "drivers/virt/coco/efi_secret/Kconfig"
>>   source "drivers/virt/coco/sev-guest/Kconfig"
>> +source "drivers/virt/gunyah/Kconfig"
>>   endif
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> new file mode 100644
>> index 000000000000..127156a678a6
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config GUNYAH
> 
> Maybe config QCOM_GUNYAH?  Will this ever run on hardware
> other than Qualcomm's?
> 

Yes, Gunyah can run on other hardware. We have support for QEMU and 
other hardware support is anticipated.

>> +    tristate "Gunyah Virtualization drivers"
>> +    depends on ARM64
>> +    help
>> +      The Gunyah drivers are the helper interfaces that runs in a 
>> guest VM
> 
> s/runs/run/
> 
>> +      such as basic inter-VM IPC and signalingmechanisms, and higher 
>> level
>> +      services such as memory/device sharing, IRQ sharing, and so on.
>> +
>> +      Say Y/M here to enable the drivers needed to interact in a Gunyah
>> +      virtual environment.
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> index 824e20a11d27..2765d2b40198 100644
>> --- a/include/linux/gunyah.h
>> +++ b/include/linux/gunyah.h
>> @@ -6,6 +6,7 @@
>>   #ifndef _GUNYAH_H
>>   #define _GUNYAH_H
>> +#include <linux/bitfield.h>
>>   #include <linux/types.h>
>>   #include <linux/errno.h>
>> @@ -71,4 +72,28 @@ static inline int gh_remap_error(int gh_error)
>>       }
>>   }
>> +#define GUNYAH_API_V1            1
>> +
>> +#define GH_API_INFO_API_VERSION_MASK    GENMASK_ULL(13, 0)
>> +#define GH_API_INFO_BIG_ENDIAN        BIT_ULL(14)
>> +#define GH_API_INFO_IS_64BIT        BIT_ULL(15)
>> +#define GH_API_INFO_VARIANT_MASK    GENMASK_ULL(63, 56)
>> +
> 
> How are the GH_IDENTIFY bits below used?  Are they encoded
> in the three 64-bit flags fields in the response structure?
> Does that mean only the first of those three is (currently)
> used?
> 

That's correct.

>> +#define GH_IDENTIFY_PARTITION_CSPACE        BIT_ULL(0)
>> +#define GH_IDENTIFY_DOORBELL            BIT_ULL(1)
>> +#define GH_IDENTIFY_MSGQUEUE            BIT_ULL(2)
>> +#define GH_IDENTIFY_VIC                BIT_ULL(3)
>> +#define GH_IDENTIFY_VPM                BIT_ULL(4)
>> +#define GH_IDENTIFY_VCPU            BIT_ULL(5)
>> +#define GH_IDENTIFY_MEMEXTENT            BIT_ULL(6)
>> +#define GH_IDENTIFY_TRACE_CTRL            BIT_ULL(7)
>> +
>> +struct gh_hypercall_hyp_identify_resp {
>> +    u64 api_info;
>> +    u64 flags[3];
>> +};
> 
> Again I'll ask about endianness.  This is a response coming *from*
> Gunyah.  Is it guaranteed to use the same byte order convention as
> the running operating system (Linux) guest?
> 

Yes, that guarantee is there.

Thanks,
Elliot
