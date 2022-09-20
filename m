Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975825BEAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiITQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiITQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:06:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC356AA38
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663689995; x=1695225995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/IbS34qABdYU+pzJELnjyiOd+1PbjbFNJt+H4c8Kcrk=;
  b=lmJ/chtdUwUN017rbr9WLjwV1lGrWQexeHCmcIZ/MEnvxK4DCPHsKSMs
   o9+VdBM1QGNMGKNkrcXamGGEajSZoaaus9BH1Gn8s6Thg8Vbcd4294q6G
   D6dob4EmGPoOSeXdaRBtNiKOSws4i4VChWkfDTbcYBxjqyEOdZD9X/bnV
   IcWi1V9cbmiWeH1qlfPba2snOFULvuPNpAA25shkm1IBppTjoJ1HiJ6Hw
   GWKk42ah9CaVwgeNVzUZlsOI4/e/lPzW7Fn21ZVq6Xvj+8PJ8pVN4El0y
   lW2rX2w2u1Fz5pCfRNmxq9I558Cd9I79BsAGL4OiTJYDWQcrJ9IZizqpH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="286787639"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="286787639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 09:06:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="687470775"
Received: from smidatha-mobl.amr.corp.intel.com (HELO [10.212.180.25]) ([10.212.180.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 09:06:33 -0700
Message-ID: <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
Date:   Tue, 20 Sep 2022 09:06:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
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
References: <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <Yym8zsuXbYaW3alU@nvidia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yym8zsuXbYaW3alU@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 06:14, Jason Gunthorpe wrote:
> For this I would rather have a function that queries the format of the
> page table under the mm_struct and we have enum values like
> INTEL_NORMAL and INTEL_LAM as possible values.
> 
> The iommu driver will block incompatible page table formats, and when
> it starts up it should assert something that blocks changing the
> format.

That doesn't sound too bad.  Except, please don't call it a "page table
format".  The format of the page tables does not change with LAM.  It's
entirely how the CPU interprets addresses that changes.

I guess someone could make an argument that, with LAM, there is a "hole"
that can't be filled in and _that_ constitutes a format change, but
that'd be a stretch.

The thing that matters when LAM is on is that some CPU might be stashing
addresses somewhere that only have meaning when you interpret them with
LAM rules.  That's really a property of the mm, not of the page tables.

Oh, and please don't call things "INTEL_WHATEVER".  It looks silly and
confuses the heck out of people when a second CPU vendor needs to use
the same code.
