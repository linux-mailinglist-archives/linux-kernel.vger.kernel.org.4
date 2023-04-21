Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D06EAD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDUO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjDUO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C3514F60;
        Fri, 21 Apr 2023 07:58:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C877D1480;
        Fri, 21 Apr 2023 07:59:10 -0700 (PDT)
Received: from [10.57.23.51] (unknown [10.57.23.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8010A3F6C4;
        Fri, 21 Apr 2023 07:58:24 -0700 (PDT)
Message-ID: <4bd8ce51-5874-0aa3-bc82-fec0cee9b8f1@arm.com>
Date:   Fri, 21 Apr 2023 15:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Content-Language: en-GB
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
 <20230328040724.GB25506@lst.de>
 <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
 <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
 <20230407055704.GD6803@lst.de> <20230407121555.4290a011@meshulam.tesarici.cz>
 <20230421150349.35966e0b@meshulam.tesarici.cz>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230421150349.35966e0b@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-21 14:03, Petr Tesařík wrote:
> Hi Christoph!
> 
> I'd like to follow up on this sub-thread:
> 
> On Fri, 7 Apr 2023 12:15:55 +0200
> Petr Tesařík <petr@tesarici.cz> wroe:
> 
>> On Fri, 7 Apr 2023 07:57:04 +0200
>> Christoph Hellwig <hch@lst.de> wrote:
>> [...]
>>> (Btw, in case anyone is interested, we really need to get started
>>> on moving the dma fields out of struct device into a sub-struct
>>> only allocated for DMA capable busses)
>>
>> I like this idea. In fact, my WIP topic branch now moves the swiotlb
>> fields into a separate struct,
> 
> As you have noticed, I have removed that commit again in v2.
> 
> The reason is that I'm not sure about the intended goal. I have looked
> around for examples of moving fields out of struct device and found
> different approaches:
> 
> A. struct dev_msi_info
>     The MSI fields are merely grouped in a separate struct, which is
>     defined in device.h and embedded in struct device. I don't see much
>     benefit.
> 
> B. struct dev_pm_info
>     This struct is also embedded in struct device, but it is defined in
>     <linux/pm.h>, which is mentioned in MAINTAINERS. The benefit is that
>     further changes are reviewed by this maintainer. The downside is
>     that device.h includes pm.h.
> 
> C. struct dev_pin_info
>     This struct is merely declared in device.h and defined
>     pinctrl/devinfo.h (which is not included). Only a pointer to this
>     struct is stored in struct device. Of course, the pointer must be
>     initialized (and released) somehow.
> 
> Here my question: What did you want for DMA fields?
> 
> A. Only grouping those fields in their own struct?
> B. Or move the definition to another include file (cf. MAINTAINERS)?
> C. Or store a pointer in struct device?

dev->dma_parms is already this, and IIRC still has some very old 
comments somewhere about consolidating the other DMA-related fields in 
there.

> Since you mentioned "allocated", it sounds like you want to achieve C,
> but:
> 
> 1. Is it worth the extra dereference for every use?
> 2. How should the struct be allocated? Presumably not with kmalloc() in
>     device_initialize(), because I don't know how to determine if a
>     device is DMA capable this low in the call stack. So, should it be
>     allocated together with the containing structure? AFAICS this would
>     mean changing nearly all device drivers...

The bus code knows whether it's a DMA-capable bus or not, and as such 
should already be providing a .dma_configure method and/or performing 
some initialisation of DMA fields. Many of the ones that would need to 
are already providing dma_parms, in fact.

Thanks,
Robin.

> 
> As you can see, I need some more guidance from you before I can start
> working on this. ;-)
> 
> Petr T
