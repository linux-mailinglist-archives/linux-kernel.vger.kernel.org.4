Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC1A6C4FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCVPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCVPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7B2311F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679499863;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZIHbC1jKIv3NYKUx6Nn7yCA5ucJgii75H8IU1+fvP0=;
        b=Wc//+DkRrjOkdqQHz4AtLasC/kzRffDKwvTrGt5YOnaLm0q+iB1PSXRQnEmXh8wq4iXYay
        tuUUq4mwpu7ei7GEtN4ID5W+JnDS6bKhi7UUFLyY97CIwM0kx2sI8KZw5HCpsGuKHzJy81
        MrEsOiba7Yx7vf0Uoy8FXc0lPD5B9vI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-m4BGkadQM0up_8I7rFIDEQ-1; Wed, 22 Mar 2023 11:44:22 -0400
X-MC-Unique: m4BGkadQM0up_8I7rFIDEQ-1
Received: by mail-qt1-f199.google.com with SMTP id l17-20020ac84cd1000000b003bfbae42753so11024879qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679499862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZIHbC1jKIv3NYKUx6Nn7yCA5ucJgii75H8IU1+fvP0=;
        b=QH8KiSh/CO+CrCwLVp+M4/7ejzrPnbPp8bC0Rexu8arq6fAkikShDs29ii2bB2lmrn
         dqwMfSGGCmPnqz6G4mSfQz3b5kmYNjNBhsYO/vHj0UgRENILn/ze2TSzCHeSe3/5LhCc
         vMsdQ5em1mVf4qZKQ8zgacRCNu7uyW6b++OhW4kVVH57wciVxF6ILZolfbCYEXH2TU2+
         dcDbacCGXRF8FW76yKG9kET54WQXXdh+B4+ku/+4UJJKmy/zxamHlzYn19mGe7dxfWdr
         5Iq4b4qXOcXNbPk3SkU+xm2IKHdsv0TvnLCkvS3tlYpdThWovmvo+t5tu7+A0lNPWxzJ
         ZVfw==
X-Gm-Message-State: AO0yUKUn5PJsNKmn+0jxePjHfKjsMRf43wBqeOTXkfFE6EN+60ZWDWZw
        vMS46MiMqwnIIuGq/MZc/w1XrN/C/oNQPphN3F/AJ7Xb4goAoY80rPIlZRG70f0ewLMZA4wwBvt
        BJ5skIQfBUMQfRaQuyL0IkjKG
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr6941526qtb.58.1679499861964;
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
X-Google-Smtp-Source: AK7set+RH2BMItYbAt2KqAiNRrua7O4bQqwB0gh9+pYTDfQ8E/VuxgTCp94Ekrs3nTeE9zMxbpgelg==
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr6941492qtb.58.1679499861710;
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t21-20020ac87615000000b003e0945575dasm6282416qtq.1.2023.03.22.08.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
Message-ID: <799e9f32-8102-649c-bb79-c8582d070f96@redhat.com>
Date:   Wed, 22 Mar 2023 16:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-US
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
 <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
 <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
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

Hi,

On 3/16/23 20:56, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen [mailto:nicolinc@nvidia.com]
>> Sent: 16 March 2023 19:51
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Eric Auger <eric.auger@redhat.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>; robin.murphy@arm.com;
>> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
>> joro@8bytes.org; jean-philippe@linaro.org;
>> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
>> helper
>>
>> Hi Shameer/Eric,
>>
>> On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi
>> wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>>>> Sent: 10 March 2023 16:21
>>>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
>>>> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
>>>> kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
>>>> jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
>>>> iommu@lists.linux.dev; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v1 01/14] iommu: Add
>> iommu_get_unmanaged_domain
>>>> helper
>>>>
>>>> On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
>>>> wrote:
>> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shame
>>>> er
>>>>>>> ali.kolothum.thodi@huawei.com/
>>>>>> So "boot configration" is more like "don't change the RIDs"? Ie
>>>>>> don't
>>>> enable
>>>>>> SRIOV?
>>>>> Yes. Don't think it will work with SR-IOV if you can't guarantee
>>>>> the RMR
>>>> specified
>>>>> SID.
>>>> So I think we are probably good them because vSR-IOV is already not
>>>> supported by qemu, so it impossible for a VM to change the PCI
>>>> configuration in a way that would alter the RID to SID mapping?
>>>>
>>> Provided we fix the issue mentioned by Eric. This was discussed here
>>> previously,
>>>
>>> https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-65290
>>> 78da97d@redhat.com/
>> Have we fixed the issue? I saw Lorenzo replying in that thread:
>> https://lore.kernel.org/linux-arm-kernel/Yi8nV8H4Jjlpadmk@lpieralisi/
>>
>> Or, what's remaining here regarding this topic? Is it a blocker?
> [+Lorenzo]

I am not aware of any change in the situation.

Thanks

Eric
>
> Not sure it is fixed yet. Also, assuming we take RMR path, do we plan to support 
> DT base Guests at all?
>
> Thanks,
> Shameer
>

