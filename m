Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E15C0522
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIURLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIURLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:11:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023879AFFA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663780310; x=1695316310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DiEGsbtLgITtlM9yaoGvIKChT6L0JZ2Jt6gnaU2GdQM=;
  b=n5lKGhyEqp/GGuvlIn75qht5n/pE1FSe5a7XqbgLxm2QjbtkuA02CIKI
   D9kilLxpi89UdkI0e5LELpM8qnpehYsM0AnW7V8fkiXl/rdWwl+NFR86i
   HHIhWTFrK1fLeZzTDbat7ttgziRE2G3iNUjfUN6KF7tDs2qpJSyGsoqa7
   gxwvvYhlQDcWb+XryHWL0qOx5qh3wyx+7edQC0mr4rFiZYA4j7CAt6XA8
   eCo06doMt/L/OWcKLXMPFuNi8uBWzKLoXfacAro8ggqiKep3iOUOVs6Ke
   CgY3+4aj6C6mU6/+jxksWeYyhuhmsWKv7kqlJFlIy4683TeAuVFf/D1Hb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283114628"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="283114628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:11:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948240024"
Received: from nchaplot-mobl1.amr.corp.intel.com (HELO [10.209.89.231]) ([10.209.89.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:11:47 -0700
Message-ID: <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
Date:   Wed, 21 Sep 2022 10:11:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 10:08, Ashok Raj wrote:
> On Wed, Sep 21, 2022 at 09:57:47AM -0700, Dave Hansen wrote:
>> On 9/15/22 10:28, Kirill A. Shutemov wrote:> +	/* Serialize against
>> address tagging enabling *
>>> +	if (mmap_write_lock_killable(mm))
>>> +		return -EINTR;
>>> +
>>> +	if (!arch_can_alloc_pasid(mm)) {
>>> +		mmap_write_unlock(mm);
>>> +		return -EBUSY;
>>> +	}
>> Shouldn't this actually be some kind of *device* check?
> The device will enable svm only when its capable of it, and performs all
> the normal capability checks like PASID, ATS etc before enabling it.
> This is the final step before the mm is hooked up with the IOMMU.

What does that mean, though?

Are you saying that any device compatibility with an mm is solely
determined by the IOMMU in play, so the IOMMU code should host the mm
compatibility checks?

