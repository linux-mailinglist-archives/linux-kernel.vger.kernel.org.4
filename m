Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E595E7CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiIWOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiIWOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:18:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766531296A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663942726; x=1695478726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZW7KOwhuGX8/vjus2UIoe6mKHPYuInZCvASKmTZu1I=;
  b=no2i8CjaoPZcsWUelYPEzTXxHEHTyInYaLGiLeihSNmpUy/f0by2mR56
   AyqOp6PH0z9EorhJopO4XVRp4JmwxlVicfzsi2srSQri+e6rtdPbHYS0C
   KmFmBHbBs61lLNfBt592zTfCnc1gYKXxhdl9643lwWggEhYikbpr8XtKr
   m9NwbgamIroyCajFPNnmdGjf3ZPqcIJysK3A5UnASR8wFfia4x0UJxuR7
   R2kjBKgKYjjO/gcq2CY73j2XYQhCFuPsQFiI0UMxYx/oWJcEQMcmiHTMl
   tAKNFDfoKYThIkrorqERhCWVUk5fkUUxCn0of6oumG3CjFTBz725C8MwM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="280964983"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="280964983"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:18:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="865306263"
Received: from hanjulee-mobl1.amr.corp.intel.com (HELO [10.252.138.32]) ([10.252.138.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:18:43 -0700
Message-ID: <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
Date:   Fri, 23 Sep 2022 07:18:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
References: <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yy2cfppqkf85hPT7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 04:46, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 12:38:26PM +0300, Kirill A. Shutemov wrote:
>>> So I would assume an untagged pointer should just be fine for the IOMMU
>>> to walk. IOMMU currently wants canonical addresses for VA.
>> Right. But it means that LAM compatibility can be block on two layers:
>> IOMMU and device. IOMMU is not the only HW entity that has to be aware of
>> tagged pointers.
> Why does a device need to care about this? What do you imagine a
> device doing with it?
> 
> The userspace should program the device with the tagged address, the
> device should present the tagged address on the bus, the IOMMU should
> translate the tagged address the same as the CPU by ignoring the upper
> bits.

Is this how *every* access works?  Every single device access to the
address space goes through the IOMMU?

I thought devices also cached address translation responses from the
IOMMU and stashed them in their own device-local TLB.  If the device is
unaware of the tags, then how does device TLB invalidation work?  Would
all device TLB flushes be full flushes of the devices TLB?  If something
tried to use single-address invalidation, it would need to invalidate
every possible tag alias because the device wouldn't know that the tags
*are* tags instead of actual virtual addresses.
