Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87CC73B85E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjFWNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjFWNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9F1FF5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687525464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6jWWQrwh2hHtedtzxrNhDIjAs17Rbx7BLQgx2TQ9mc=;
        b=VhZz1g8DoUztheVJkyNwStMKpOScXwxCOunKXpFdTEza69jAgKNd+kRUNN6fxCrYmcrasQ
        PExjbhuIt/zVEYUDaGSWcsf2UAoFlFQHblJtl8Y/Ev9jgO4hfuLX3uZdA5uhsZEO5X0PEA
        d3z6kYsoSwtLpnm9EZ7xM0+KHwDdIog=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-6-9b88BEMZuhV9AKFLN2vw-1; Fri, 23 Jun 2023 09:04:22 -0400
X-MC-Unique: 6-9b88BEMZuhV9AKFLN2vw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76548fab0b2so73143385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525461; x=1690117461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6jWWQrwh2hHtedtzxrNhDIjAs17Rbx7BLQgx2TQ9mc=;
        b=g069KbODhWHbA6BP1xfjcti1HX6ZpW9pQ4pJNWLvr6pUdcJEUPV9benZsMVY693osm
         kLZbUp3MaAu8/zgoB0CE18lbH2914xOENzMuxoHfeSKqgQdp54v+VvQSQPlL6lBajyIP
         T+2YndXTrfNL7wboUilvYWx97VLeFoySarCmulgIFGPATcANgZX+yvebLKxxGzqXuG6X
         +FWhVhjoEDniFT/Xi6tiDUIqEt5UxvWfhXQGXxu8dht1W3+lJX7IDcvLSFCIH176N4QI
         MFWaZSDgkdVCpuuXdYMJBgD6z2b7A8i37O0tYbeuy8LdcYQO0DKLmRrPd85NyRnOWybR
         qVnw==
X-Gm-Message-State: AC+VfDzIOP4wSPPW0H+IpPo0+9mR+7VzEHqM2W99tlQh9y6nOxiQCJ1a
        585jdG+7Js7ausKh4fzSxlh7v6BlJShjAl0xX0hsV4y4u4mprRLLjlbDl9o07gFkWK5VDSEOYs7
        1LYInMgQezYIs/3qDvdk0zTPC
X-Received: by 2002:a05:620a:2a12:b0:765:4855:26db with SMTP id o18-20020a05620a2a1200b00765485526dbmr2333882qkp.10.1687525461490;
        Fri, 23 Jun 2023 06:04:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fITNun0HWeriRaUUuh7u2rwGbcPWH3qyy+c0xKPKWKIGejgArsHRo+XF3UWsOU0qXZUi25Q==
X-Received: by 2002:a05:620a:2a12:b0:765:4855:26db with SMTP id o18-20020a05620a2a1200b00765485526dbmr2333855qkp.10.1687525461253;
        Fri, 23 Jun 2023 06:04:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id bs14-20020ac86f0e000000b003f6b58b986fsm36489qtb.41.2023.06.23.06.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:04:20 -0700 (PDT)
Message-ID: <62dcff6b-852d-4a85-dfd4-0ce1f324602e@redhat.com>
Date:   Fri, 23 Jun 2023 15:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] vfio/nvgpu: Add vfio pci variant module for grace
 hopper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, alex.williamson@redhat.com, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622030720.19652-1-ankita@nvidia.com>
 <46a79333-12f6-229f-86f9-1e79bdba7d11@redhat.com>
 <ZJWGbsaMzHvqqewi@nvidia.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ZJWGbsaMzHvqqewi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 13:47, Jason Gunthorpe wrote:
> On Fri, Jun 23, 2023 at 08:27:17AM +0200, Cédric Le Goater wrote:
>>> +	req_len = vma->vm_end - vma->vm_start;
>>> +	pgoff = vma->vm_pgoff &
>>> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>>> +	if (pgoff >= (nvdev->mem_prop.mem_length >> PAGE_SHIFT))
>>> +		return -EINVAL;
>>
>> you cound introduce accessor macros for nvdev->mem_prop.mem_length and
>> nvdev->mem_prop.hpa
> 
> Accessors are not the usual style..

I meant something like

   #define nvgpu_mem_size(nvdev) (nvdev)->mem_prop.mem_length
   #define nvgpu_mem_pa_base(nvdev) (nvdev)->mem_prop.hpa

This is minor.

> 
>>> +static const struct pci_device_id nvgpu_vfio_pci_table[] = {
>>> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2342) },
>>> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2343) },
>>> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2345) },
>>
>> It would be good to add definitions for the PCI IDs.
> 
> The common form these days is to have a comment with the marketing
> name, we stopped putting constants for every device a while ago.

OK then.

Thanks,

C.

