Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09906B3DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCJLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCJLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD305A6CD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678448001;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4S3SJNUbgNLYyhpATwshP+7xAKmJ12/+l9BB0p8/V4=;
        b=Yd6El9QNxLh8IUlVjANYkis+KIYQQuZX4dp0V9WuezOUwle19VpYeOgw/6O0hvhnwL2PMZ
        oipY+GPaBM9AtOsasLcohhdDwnDn3JRknBhjd66Vgi6IeE6ep5Fxg5giuiCYwNDNhF3EMl
        /Tflzswq03bMtLMz7hDHfGQSdD4TqJM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-UW2-zTXaMS2cz_zEMuJ-sQ-1; Fri, 10 Mar 2023 06:33:19 -0500
X-MC-Unique: UW2-zTXaMS2cz_zEMuJ-sQ-1
Received: by mail-qk1-f200.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so2912318qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678447998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4S3SJNUbgNLYyhpATwshP+7xAKmJ12/+l9BB0p8/V4=;
        b=Obmw//ZtxrKZ79Hs3araAs3ifsoW79k+126quaQnqD9h7oz2umcIjnLW083ihwU61q
         FKE3R973SDiCaf5HBDwg6+X930brR/4WT/APxHMIauPJQnSlMlYuwu9t32K767tXFM45
         pfST+wc8bdLMBEHmVVQFxbph2/efurXiXcfeWTbRCguC4Bjc/Ipo3ZWsynVreQKHWR26
         e5lkq4xc8HB1TT/wv55jSt/bgxHJgYWzGsZ46NX1FifcSkgBv0fwoQtPY5wygYBI1tbX
         TpxCidmvAuP7qDsfwGI2LeFnk6BpmGJm5jezW5oyDzsHav0zNikwsbykd4W9+zL9Bj94
         YvDQ==
X-Gm-Message-State: AO0yUKVfiN2N9yOb2M4ttQ7Wd8U60m05D9KVapcFcvyTwpTVXdX8K99g
        rJKQg85WPhKCkeQ6wlTv9erhmNeHQVAYi6bWyXPAQAaoPOalWBP+zR0nA3l87kDWpruBY9KSxOB
        PscsTGwnEQ2tfCI4qlCa/pWPBqsHsL2vd
X-Received: by 2002:a05:6214:252c:b0:56e:fb4c:c1c4 with SMTP id gg12-20020a056214252c00b0056efb4cc1c4mr17633047qvb.14.1678447997935;
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
X-Google-Smtp-Source: AK7set+ObrN18F32cy+WpRBzCha3lX+Kgx4jipHI9s53RhcUyjRx5aXFaUu+xqai/SF8up4rIR787Q==
X-Received: by 2002:a05:6214:252c:b0:56e:fb4c:c1c4 with SMTP id gg12-20020a056214252c00b0056efb4cc1c4mr17633010qvb.14.1678447997662;
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b0074308a0124asm1152231qkj.50.2023.03.10.03.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
Message-ID: <5288c0e9-b806-370d-e7de-8d69d5b8e902@redhat.com>
Date:   Fri, 10 Mar 2023 12:33:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     jgg@nvidia.com, robin.murphy@arm.com, will@kernel.org,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230309134217.GA1673607@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 3/9/23 14:42, Jean-Philippe Brucker wrote:
> Hi Nicolin,
>
> On Thu, Mar 09, 2023 at 02:53:38AM -0800, Nicolin Chen wrote:
>> Add the following data structures for corresponding ioctls:
>>                iommu_hwpt_arm_smmuv3 => IOMMUFD_CMD_HWPT_ALLOC
>>     iommu_hwpt_invalidate_arm_smmuv3 => IOMMUFD_CMD_HWPT_INVALIDATE
>>
>> Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
>> to the header and corresponding type/size arrays.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> +/**
>> + * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table data
>> + *
>> + * @flags: page table entry attributes
>> + * @s2vmid: Virtual machine identifier
>> + * @s1ctxptr: Stage-1 context descriptor pointer
>> + * @s1cdmax: Number of CDs pointed to by s1ContextPtr
>> + * @s1fmt: Stage-1 Format
>> + * @s1dss: Default substream
>> + */
>> +struct iommu_hwpt_arm_smmuv3 {
>> +#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */
> I don't understand the purpose of this flag, since the structure only
> provides stage-1 configuration fields
>
>> +#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */
> Doesn't this break isolation?  The VMID space is global for the SMMU, so
> the guest could access cached mappings of another device
>
>> +	__u64 flags;
>> +	__u32 s2vmid;
>> +	__u32 __reserved;
>> +	__u64 s1ctxptr;
>> +	__u64 s1cdmax;
>> +	__u64 s1fmt;
>> +	__u64 s1dss;
>> +};
>> +
>
>> +/**
>> + * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
>> + * @flags: boolean attributes of cache invalidation command
>> + * @opcode: opcode of cache invalidation command
>> + * @ssid: SubStream ID
>> + * @granule_size: page/block size of the mapping in bytes
>> + * @range: IOVA range to invalidate
>> + */
>> +struct iommu_hwpt_invalidate_arm_smmuv3 {
>> +#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF	(1 << 0)
>> +	__u64 flags;
>> +	__u8 opcode;
>> +	__u8 padding[3];
>> +	__u32 asid;
>> +	__u32 ssid;
>> +	__u32 granule_size;
>> +	struct iommu_iova_range range;
>> +};
> Although we can keep the alloc and hardware info separate for each IOMMU
> architecture, we should try to come up with common invalidation methods.
>
> It matters because things like vSVA, or just efficient dynamic mappings,
> will require optimal invalidation latency. A paravirtual interface like
> vhost-iommu can help with that, as the host kernel will handle guest
> invalidations directly instead of doing a round-trip to host userspace
> (and we'll likely want the same path for PRI.)
>
> Supporting HW page tables for a common PV IOMMU does require some
> architecture-specific knowledge, but invalidation messages contain roughly
> the same information on all architectures. The PV IOMMU won't include
> command opcodes for each possible architecture if one generic command does
> the same job.
>
> Ideally I'd like something like this for vhost-iommu:
>
> * slow path through userspace for complex requests like attach-table and
>   probe, where the VMM can decode arch-specific information and translate
>   them to iommufd and vhost-iommu ioctls to update the configuration.
>
> * fast path within the kernel for performance-critical requests like
>   invalidate, page request and response. It would be absurd for the
>   vhost-iommu driver to translate generic invalidation requests from the
>   guest into arch-specific commands with special opcodes, when the next
>   step is calling the IOMMU driver which does that for free.
>
> During previous discussions we came up with generic invalidations that
> could fit both Arm and x86 [1][2]. The only difference was the ASID
> (called archid/id in those proposals) which VT-d didn't need. Could we try
> to build on that?

I do agree with Jean. We spent a lot of efforts all together to define
this generic invalidation API and if there is compelling reason that
prevents from using it, we should try to reuse it.

Thanks

Eric
>
> [1] https://elixir.bootlin.com/linux/v5.17/source/include/uapi/linux/iommu.h#L161
> [2] https://lists.oasis-open.org/archives/virtio-dev/202102/msg00014.html
>
> Thanks,
> Jean
>

