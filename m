Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7226C501A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCVQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCVQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7265464
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679501265;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9Rnif2QXbiaghLODlyfTFhBazkHFsocz625fhcIzRQ=;
        b=Pt9gkxgGtcXSX4MyfcCrAMi5ljMhISVFWaY+ZRhf43HVBikaA1xfmXVq62piEeQILPYaDw
        V8OWCaugz4WB1/frRQx837/y6p5ykR8jZfRqFldDWomkVhdRdE9g0TcXi211C4EN3nKEeP
        /GmTxHCQEd8Rxs7L/MfCBdByj5lcsJs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-gx-GBKmRM-Ws66Kz8FmeWg-1; Wed, 22 Mar 2023 12:07:44 -0400
X-MC-Unique: gx-GBKmRM-Ws66Kz8FmeWg-1
Received: by mail-qk1-f198.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso3622207qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9Rnif2QXbiaghLODlyfTFhBazkHFsocz625fhcIzRQ=;
        b=49vQ7YJ6lPmJ3oJ1fdpFhNyFhaaLJr7yLr99cOUPXLCHJTFEIiFZ8mJBgG+t6oxcsR
         ib77Lr5B9KvS3kwVEBd6zcjLoDSofazXr+Esrl7use7Q2SUL0fsq6EesiOatn5li4D7b
         Za/gbGj0ZdU9Hn1nPCQHEe8Oqu59ooo6nEf3DGEIU89IpBsag7VQi6+eU4SQIHeOGAUl
         1iB0cmw7JOJce/zdUpJqV5tFyengXv6Z9pfuomeo2jWsWG1rhNgHl52hVcEX4ZWBip1n
         kp/ivQIJlwnH8tSJTfy6SFYW8QqcBrxGbvgXii7w3fAtTxA4Ux4KX1AqDmP7TD/cJT5B
         SAcg==
X-Gm-Message-State: AO0yUKWWM/mN5yoT6fbC+ru4QGFvZNERsyM10GlOf521bXVy+e/W2/eM
        KnoOqnPXlL0ygvBwUg8DD1nLCQAnBbRJdEIHXVbQ6a5aKmRGmhF3K9hmjFR12+0gzPaH1KoBfNM
        squt2FhQhjnEVNQaXzzfgHeky
X-Received: by 2002:a05:622a:1310:b0:3bf:b614:bcaf with SMTP id v16-20020a05622a131000b003bfb614bcafmr6250301qtk.67.1679501263468;
        Wed, 22 Mar 2023 09:07:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set906DViypKLlucpEBE7CpcCs/JBDemdLcWOHaJ9OOt7O2j1kTf+Z9HU87xcDSViISleQaf2pg==
X-Received: by 2002:a05:622a:1310:b0:3bf:b614:bcaf with SMTP id v16-20020a05622a131000b003bfb614bcafmr6250269qtk.67.1679501263144;
        Wed, 22 Mar 2023 09:07:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f16-20020ac86ed0000000b003e390b48958sm24348qtv.55.2023.03.22.09.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:07:42 -0700 (PDT)
Message-ID: <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
Date:   Wed, 22 Mar 2023 17:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZAti8wy9wXwtIqLT@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZAti8wy9wXwtIqLT@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 3/10/23 18:03, Jason Gunthorpe wrote:
> On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi wrote:
>>
>>> -----Original Message-----
>>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>>> Sent: 10 March 2023 16:21
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
>>> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
>>> kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
>>> jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
>>> iommu@lists.linux.dev; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
>>> helper
>>>
>>> On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
>>> wrote:
>>> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameer
>>>>>> ali.kolothum.thodi@huawei.com/
>>>>> So "boot configration" is more like "don't change the RIDs"? Ie don't
>>> enable
>>>>> SRIOV?
>>>> Yes. Don't think it will work with SR-IOV if you can't guarantee the RMR
>>> specified
>>>> SID.
>>> So I think we are probably good them because vSR-IOV is already not
>>> supported by qemu, so it impossible for a VM to change the PCI
>>> configuration in a way that would alter the RID to SID mapping?
>>>
>> Provided we fix the issue mentioned by Eric. This was discussed here previously,
>>
>> https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com/
> Ah, I see so that we don't renumber the buses during PCI discovery..
>
> It seems like Eric's issue is overly broad if we just want to block
> RID reassignment that doesn't impact MMIO layout.
IORT spec says

"
If reserved memory regions are present, the OS must preserve PCIe
configuration performed by the boot
firmware. This preservation is required to ensure functional continuity
of the endpoints that are using the reserved
memory regions. Therefore, RMR nodes must be supported by the inclusion
of the PCI Firmware defined _DSM
for ignoring PCI boot configuration, Function 5, in the ACPI device
object of the PCIe host bridge in ACPI
namespace. The _DSM method should return a value of 0 to indicate that
the OS must honour the PCI
configuration that the firmware has done at boot time. See [PCIFW] for
more details on this _DSM method.
"

Enforcing preservation was attempted in the past in QEMU and then
reverted due to the aforemented bug.

qemu commit: 40c3472a29  Revert "acpi/gpex: Inform os to keep firmware
resource map"

So if we want to rely on RMRs and re-introduce that change I don't see
how we can avoid fixing the kernel issue.
>
> But, still, why do we care about this?
>
> The vIOMMU should virtualize the vSIDs right? So why does qemu give a
> vSID list to the guest anyhow? Shouldn't the guest use an algorithmic
> calculation from the vRID so that qemu can reverse it to the correct
> vPCI device and thus the correct vfio_device and then dev id in the
> iommu_domain?
I don't understand how this changes the above picture?


Thanks

Eric
>
> Jason
>

