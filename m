Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF95B63D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiILWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:51:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D721264
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663023099; x=1694559099;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5aFaUUfrEqzjVBCB+0ZmxzBuRHaP2jCVI3JIfFSraI=;
  b=Q1dXuv2Ky8+5UoFetH5r9Onyvg6CgPdLaRyytgx4tH3EOjl77sp797Fm
   2s6NqPdkuYN4Zf+KIzZPbZDGzyQCmRklSV6s9uTuuEXKYPxR8FhozyZ9N
   jdAACBdFErPskMEEZnxKPUKebC1isxVCTA0KE23plMtRR6iolPN4XBIue
   n84r+J3mqB5kD8y7hLkASURvJLsHKbFeJrzimCZ7d8Zi1Fhp6dpfQTCej
   B/HmLwLM6TGpQJRZ23YI9oCd9wM9DOE4T8bQDjJhh6njcG7VWe8mKZ9YV
   Lg2kLMN3Hr9U4pC5TJaxagcPkbaLyBk03kFgNQUdVSRuzXBVumXESbZa1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361940052"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="361940052"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:51:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="611928407"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:51:39 -0700
Date:   Mon, 12 Sep 2022 15:55:02 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@intel.com
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220912155502.0087a993@jacob-builder>
In-Reply-To: <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
        <YxDvpLb77lwb8zaT@araj-dh-work>
        <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
        <Yxtk4gMbcVgTKzKg@araj-dh-work>
        <20220912133935.3bb3e247@jacob-builder>
        <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, 12 Sep 2022 14:41:56 -0700, Dave Hansen <dave.hansen@intel.com>
wrote:

> On 9/12/22 13:39, Jacob Pan wrote:
> >>> +	if (pasid_valid(mm->pasid) && !forced) {  
> > I don't think this works since we have lazy pasid free.  for example,
> > after all the devices did sva_unbind, mm->pasid  we'll remain valid
> > until mmdrop(). LAM  should be supported in this case.  
> 
> Nah, it works fine.
> It just means that the rules are "you can't do LAM if your process
> *EVER* got a PASID" instead of "you can't do LAM if you are actively
> using your PASID".
Sure it works if you change the rules, but this case need to documented.

> 
> We knew that PASID use would be a one-way trip for a process when we
> moved to the simplified implementation.  This is just more fallout from
> that.  It's fine.
> 
Is LAM also a one-way trip?

> > Perhaps, we could introduce another prctl flag for SVA, PR_GET_SVA?
> > Both iommu driver and LAM can set/query the flag. LAM applications may
> > not be the only ones want to know if share virtual addressing is  on.  
> 
> I don't think it's a good idea to add yet more UABI around this issue.
> Won't the IOMMU folks eventually get their hardware in line with LAM?
> Isn't this situation temporary?


Thanks,

Jacob
