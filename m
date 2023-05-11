Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71C6FED08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjEKHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbjEKHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD662115
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683790734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8V2QwKOyBLdpEe+T44KJG8tyl5eRHglc0YEq82GCmE=;
        b=O5F9sBhnW/i4lP3Qy+iGStNAgYoLYNizCbqx3602EnteLgZXZWinp6YXl7efjqIvNbY3U8
        WACfa/3f4sU5p1baNO1zUnhz0KxbOBe9QSEGdAc2QNrvwLzEsbGON+r6PSXJq48+k5W/Dz
        KoLPsWNqAIPD7kDD0LDbZPacNeKa9yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-cAzqYYDsM52c-0kzc-Bo_A-1; Thu, 11 May 2023 03:38:53 -0400
X-MC-Unique: cAzqYYDsM52c-0kzc-Bo_A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3078df8ae31so3203243f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790732; x=1686382732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8V2QwKOyBLdpEe+T44KJG8tyl5eRHglc0YEq82GCmE=;
        b=Ey6OhyqgX/2ojPSWF4iNZOBnlbAr47jElDEBJGqIWjoC6YZFxIc/AsNQTamqer9xLV
         oh6gyEaxNbWFlImI44l603wE4CrV55VKLycK2pOQABZ7eVMeXgseIGZaMsw1Kx6BUcrW
         q4kVxIf2T11VwH+PvWwO5XbnPPRfZDkHPv69UXaYTXvkb1j/AvHPZ3pNSYluO8OkZTtS
         OP/fVsFzEruN4E7ofX9NRPqNC1Lanc7anWzVNwbsq5IO2PmOHuh6hxaJjXK3DSPFUB/D
         3XvxC7wpFHTjyDBS7F0+UTwQq2kW12NoWugGbq7W9ewdLFSIcn/LOmRYOuM+SULm0JWa
         roiA==
X-Gm-Message-State: AC+VfDx275RQ1Fq3iNCe7sLYSXnyOvV7YsHAJ4lp3l9U8mWeelXJXVwk
        ssPOeORjsSy/bmnTgz0eYzxo+1yphGCmIXoHCD50oMvRvjMYPiupzL3u1d9bEKKW0T4n3LlB+Uy
        ZjYdOqLSmia2nJL8kHKg/3YRM
X-Received: by 2002:adf:db50:0:b0:306:2c01:4029 with SMTP id f16-20020adfdb50000000b003062c014029mr13772014wrj.5.1683790731848;
        Thu, 11 May 2023 00:38:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6x0IJBlDxk1RWKp0J3GN8GvUv8W7bVfSINnkrH9+VJR1VdtxEl1+FWChFsErbmp5oDi7Ey4g==
X-Received: by 2002:adf:db50:0:b0:306:2c01:4029 with SMTP id f16-20020adfdb50000000b003062c014029mr13771996wrj.5.1683790731594;
        Thu, 11 May 2023 00:38:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c? ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d67d0000000b002fae7408544sm19621051wrw.108.2023.05.11.00.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 00:38:51 -0700 (PDT)
Message-ID: <ae970fc9-dc05-ebcc-ce31-997462fd41ec@redhat.com>
Date:   Thu, 11 May 2023 09:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Content-Language: en-US
To:     Yan Zhao <yan.y.zhao@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kevin.tian@intel.com,
        yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
 <ZFkn3q45RUJXMS+P@nvidia.com>
 <20230508145715.630fe3ae.alex.williamson@redhat.com>
 <ZFwBYtjL1V0r5WW3@nvidia.com> <ZFyRlnXmEy6Enk4w@yzhao56-desk.sh.intel.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZFyRlnXmEy6Enk4w@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 08:56, Yan Zhao wrote:
> On Wed, May 10, 2023 at 05:41:06PM -0300, Jason Gunthorpe wrote:
>> On Mon, May 08, 2023 at 02:57:15PM -0600, Alex Williamson wrote:
>>
>>> We already try to set the flags in advance, but there are some
>>> architectural flags like VM_PAT that make that tricky.  Cedric has been
>>> looking at inserting individual pages with vmf_insert_pfn(), but that
>>> incurs a lot more faults and therefore latency vs remapping the entire
>>> vma on fault.  I'm not convinced that we shouldn't just attempt to
>>> remove the fault handler entirely, but I haven't tried it yet to know
>>> what gotchas are down that path.  Thanks,
>>
>> I thought we did it like this because there were races otherwise with
>> PTE insertion and zapping? I don't remember well anymore.
>>
>> I vaugely remember the address_space conversion might help remove the
>> fault handler?
>>
> What about calling vmf_insert_pfn() in bulk as below?

This works too, it is slightly slower than the io_remap_pfn_range() call
but doesn't have the lockdep issues.

Thanks,

C.

> And what is address_space conversion?
> 
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a5ab416cf476..1476e537f593 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1686,6 +1686,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
>          struct vfio_pci_core_device *vdev = vma->vm_private_data;
>          struct vfio_pci_mmap_vma *mmap_vma;
>          vm_fault_t ret = VM_FAULT_NOPAGE;
> +       unsigned long base_pfn, offset, i;
> 
>          mutex_lock(&vdev->vma_lock);
>          down_read(&vdev->memory_lock);
> @@ -1710,12 +1711,15 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
>                          goto up_out;
>          }
> 
> -       if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -                              vma->vm_end - vma->vm_start,
> -                              vma->vm_page_prot)) {
> -               ret = VM_FAULT_SIGBUS;
> -               zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
> -               goto up_out;
> +       base_pfn = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> +       base_pfn += vma->vm_pgoff;
> +       for (i = vma->vm_start; i < vma->vm_end; i += PAGE_SIZE) {
> +               offset = (i - vma->vm_start) >> PAGE_SHIFT;
> +               ret = vmf_insert_pfn(vma, i, base_pfn + offset);
> +               if (ret != VM_FAULT_NOPAGE) {
> +                       zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
> +                       goto up_out;
> +               }
>          }
> 
>          if (__vfio_pci_add_vma(vdev, vma)) {
> 

