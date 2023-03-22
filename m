Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E66C52E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCVRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCVRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3A4FCF4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679506908;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6GCfilh0cZKB8DQRhLDL4RZochnv+xVhcOUE0oDoD0=;
        b=GKv5EXWhx1InC+JqVlzvIySHolPNgmvgmEIWvdXbF+NQFneG5SZ57z0gGfnfa3ncYH/Pfd
        FtVnn1lK3ZmSgAzhrWPRQSV/bOauX0y2UDsHu3uz19SW8sDu2aHOG5Yhi6hLtpzDFZP3/u
        JtNXiYnU7wuJRwHr93RzULa2jCDFGwo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-8dWE7wYwOnOsFcCCwvRkSA-1; Wed, 22 Mar 2023 13:41:47 -0400
X-MC-Unique: 8dWE7wYwOnOsFcCCwvRkSA-1
Received: by mail-qk1-f198.google.com with SMTP id s12-20020a37a90c000000b007468eaf866aso4399268qke.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6GCfilh0cZKB8DQRhLDL4RZochnv+xVhcOUE0oDoD0=;
        b=v+HvCi/V0yIreDDNb9iRzlgNjvESB/KyeTQPwNvpgBFiSBEiAEy8C24RmSB/KXIo2i
         skdsB2Aj1aM4/joFfmt7WJlH1xcTLYO8WlGiMVX77w4hE4n1oA6E0SCSxGDL26ujpLbV
         ML57MpXeQ+CQcvr1oiYxt4DoSdSFo6C5fKYDLWKhUBB1kR9yGksM3n4FRB1f9NIoBgo3
         WFkKolvwE005r09mZPI0CZInFIzBumOgqnp4dKwhqbgJkLwb7JJwp6HovRHgRvBqT0Mp
         tsDRTJavaJACdfOXXhgHuzC2pLgYZjKNLhyppYsjIGyjmRF7rTyQNAIT0nqKjVULTlGd
         +sXA==
X-Gm-Message-State: AO0yUKU1iBuxdPlNb6opIFngVCO2OvaJxyyKSb4wuzkNLKCklCd2KfM3
        9CTFen6zBTFwQyZHRRRJKUE2/dvJHjzDIyVYEib2gaGPsZEKFPe2U+/QfU0MUwxsmefB+tbcCrx
        OGYSDJSGQGg8ZzDe4UrCM+18H
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr7054145qvh.23.1679506906940;
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set++hcwOGZwKk/07mSyw88ezcgv4USpopnCaUqdkAzomtduECxyPJGmLRRVrQqNYnB5Xmc40DQ==
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr7054121qvh.23.1679506906665;
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p17-20020a374211000000b007428e743508sm11708821qka.70.2023.03.22.10.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
Message-ID: <bcab0150-bd42-8acf-f0ec-85ce19699a57@redhat.com>
Date:   Wed, 22 Mar 2023 18:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
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
References: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZAti8wy9wXwtIqLT@nvidia.com>
 <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
 <ZBs0ifAVwWvOt2b5@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZBs0ifAVwWvOt2b5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/22/23 18:02, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 05:07:39PM +0100, Eric Auger wrote:
>
>>> It seems like Eric's issue is overly broad if we just want to block
>>> RID reassignment that doesn't impact MMIO layout.
>> IORT spec says
>>
>> "
>> If reserved memory regions are present, the OS must preserve PCIe
>> configuration performed by the boot
>> firmware. This preservation is required to ensure functional continuity
>> of the endpoints that are using the reserved
>> memory regions. Therefore, RMR nodes must be supported by the inclusion
>> of the PCI Firmware defined _DSM
>> for ignoring PCI boot configuration, Function 5, in the ACPI device
>> object of the PCIe host bridge in ACPI
>> namespace. The _DSM method should return a value of 0 to indicate that
>> the OS must honour the PCI
>> configuration that the firmware has done at boot time. See [PCIFW] for
>> more details on this _DSM method.
>> "
> I would say this spec language is overly broad. If the FW knows the
> reserved memory regions it creates are not sensitive to PCI layout
> then it should not be forced to set this flag.

But do we have any guarantee the bus numbers can't change. I thought the
guest was allowed to re-number at will? While further thinking at it,
all RID ID mappings should be affected by this concern, I mean not only
RID 2 RMRs? What do I miss?
>
>>> But, still, why do we care about this?
>>>
>>> The vIOMMU should virtualize the vSIDs right? So why does qemu give a
>>> vSID list to the guest anyhow? Shouldn't the guest use an algorithmic
>>> calculation from the vRID so that qemu can reverse it to the correct
>>> vPCI device and thus the correct vfio_device and then dev id in the
>>> iommu_domain?
>> I don't understand how this changes the above picture?
> We are forced to use RMR because of the hacky GIC ITS stuff.
well we are not obliged to use RMRs. My first revisions did not use it
and created a non direct S1 mapping. This is just a commodity that
simplifies the integration and was nicely suggested by jean.
>
> ITS placement is not sensitive to PCI layout.
>
> ITS is not sensitive to bus numbers/etc.
>
> vSID to dev_id should also be taken care of by QEMU even if bus
> numbers change and doesn't need to be fixed.
agreed, hence the above question.
>
> So let's have a reason why we need to do all this weird stuff beyond
> the spec says so.
>
> If there is no actual functional issue we should not restrict the
> guest and provide RMR without the DSM method. Someone should go and
> update the spec if this offends them :)
>
> Jason
>
Thanks

Eric

