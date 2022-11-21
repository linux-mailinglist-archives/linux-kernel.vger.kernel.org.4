Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE4631874
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKUCEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKUCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:04:51 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEAE13CC4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:04:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VVDR92k_1668996282;
Received: from 127.0.0.1(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VVDR92k_1668996282)
          by smtp.aliyun-inc.com;
          Mon, 21 Nov 2022 10:04:46 +0800
Message-ID: <51d486c9-4689-c2d6-0db4-4e3754a058db@linux.alibaba.com>
Date:   Mon, 21 Nov 2022 10:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
To:     dave.hansen@intel.com
Cc:     ak@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, isaku.yamahata@gmail.com, jun.nakajima@intel.com,
        kai.huang@intel.com, khalid.elmously@canonical.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        marcelo.cerri@canonical.com, mingo@redhat.com,
        philip.cox@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tim.gardner@canonical.com, tony.luck@intel.com, wander@redhat.com,
        x86@kernel.org, "Du, Fan" <fan.du@intel.com>
References: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
 <a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com>
In-Reply-To: <a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Kindly ping for any comments here?

Sincerely,
Guorui

在 2022/8/9 14:20, Guorui Yu 写道:
> To my opinion, virtio-vsock is a wonderful way to achieve the 
> comunication between the host and the guest under traditional scenario.
> 
> But from secuirty perspective, virtio-vsock itself may involve too much 
> of components, which may lead to considerable attack surfaces. In order 
> for virtio to work properly, the guest must maintain several vrings 
> placed in shared memory, which in turn depends on swiotlb in current 
> codebase. As this flow is NOT designed for confidential scenario, there 
> are some on-going/existing works on virtio hardening [1] [2] [3].
> 
>  > Do we *REALLY* need specific driver functionality for this?  For
>  > instance, is there no existing virtio device that can send blobs back
>  > and forth?
> 
> And we may indeed have use cases where virtio is not used at all, such 
> as when we consider Intel-TDX/AMD-SNP protected VMs as a SGX enclave 
> replacement. In such use cases, end users may expect a smaller 
> dependency on the GetQuote interface. It doesn't seem natural that the 
> GetQuote interface cannot be used because virtio-vsock is disabled (via 
> kernel compile options or the upcoming device-filter), since GetQuote 
> doesn't inherently depend on it.
> 
> Thanks,
> Guorui
> 
> [1] 
> https://lore.kernel.org/lkml/20210603004133.4079390-1-ak@linux.intel.com/
> [2] https://lore.kernel.org/lkml/20211012065227.9953-1-jasowang@redhat.com/
> [3] 
> https://lore.kernel.org/linux-iommu/d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de/
