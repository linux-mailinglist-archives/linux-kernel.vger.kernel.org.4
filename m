Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7E5E7E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiIWPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIWPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:31:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A3143540
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663947091; x=1695483091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v96tuYGGMJYs8ptS79bcD/41j+v8We2inkrTBpBMyfk=;
  b=IDnVV9JUE8R0UiiXdQSUEtaSTqTpRDAxl0NUoI1vD7ytrMTUc+wU0Vfz
   QbGIR0I9qJOAaiQ+VzmZtPfnNv38hySnAuVi2H5EZCFYZfBp87BRaISRp
   FjLzEGyeZRuaOU6wwtdzLIPLAvKcDXJfqKN15ox27d7uwPWq1udfyxk0x
   6mjDp1QAnwcemR3H+QRyGi8CYHy980idFiyvXOIDGXPqJrK6iSiDk0bW+
   f0LtQwe5bVb8QDlfxq50SYfmZ7ov+mXMSlSGI0UrAoMx7V3mLxSV6LWtm
   s6vSM1/PhEBHXoz9pEJIJAHc8EEJGBAQimJ8OhUlmSqYwB4HqCwg85pHM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283714947"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283714947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="745829440"
Received: from hanjulee-mobl1.amr.corp.intel.com (HELO [10.252.138.32]) ([10.252.138.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:31:13 -0700
Message-ID: <c3fb5e4f-a906-bdee-7b34-533f36ba59f7@intel.com>
Date:   Fri, 23 Sep 2022 08:31:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
References: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
 <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 08:28, Ashok Raj wrote:
>>
>> I thought devices also cached address translation responses from the
>> IOMMU and stashed them in their own device-local TLB.  If the device is
>> unaware of the tags, then how does device TLB invalidation work?  Would
> This is coming a full circle now :-)
> 
> Since the device doesn't understand tagging, SVM and tagging aren't
> compatible. If you need SVM, you can only send sanitized pointers to the
> device period. In fact our page-request even looks for canonical checks
> before doing the page-faulting.
> 
>> all device TLB flushes be full flushes of the devices TLB?  If something
>> tried to use single-address invalidation, it would need to invalidate
>> every possible tag alias because the device wouldn't know that the tags
>> *are* tags instead of actual virtual addresses.
> Once tagging is extended into the PCI SIG, and devices know to work with
> them, so will the IOMMU, then they can all play in the same field. Until
> then they are isolated, or let SVM only work with untagged VA's.

But, the point that Kirill and I were getting at is still that devices
*have* a role to play here.  The idea that this can be hidden at the
IOMMU layer is pure fantasy.  Right?
