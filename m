Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D05C04E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIUQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIUQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:58:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B8E65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663779471; x=1695315471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KfeL1caenfC1WwBXXSUs1g5r/dvpabVdylm3CpznaYo=;
  b=IEUw5nnv0Lovu41xLWicKZGeodXV4zmmokViQk0XPE+IZv9Br0lhzYHk
   smwVct5GKExiE9MSdwFYz+ZZF5sIpkkl8j3R4YL6lhf+QShgdtX3g3J7X
   NpZnmJNJI8nlvjeBHN95YPU1xYXKSJehI6LVTqBQojY6HmGNPat4JSwfc
   dzTCipwpCJ96FB31twrJJYENUhvNSxD81IJbIp6uBOVfvfoj4C9/fFEsi
   fgRuYxepsVtMZf/9yiynpPkqC3Ixd2ur1oyEBUPllbfe+pYVQ/+/ff4iO
   4wgqI6fyFYtAjEadWcgwzmZJGmuZ0Tk6HzZ6I1d7XZStJfYvzAMU2V47s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386349243"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="386349243"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 09:57:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="723291831"
Received: from nchaplot-mobl1.amr.corp.intel.com (HELO [10.209.89.231]) ([10.209.89.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 09:57:48 -0700
Message-ID: <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
Date:   Wed, 21 Sep 2022 09:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
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
References: <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 10:28, Kirill A. Shutemov wrote:> +	/* Serialize against
address tagging enabling *
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
> +	if (!arch_can_alloc_pasid(mm)) {
> +		mmap_write_unlock(mm);
> +		return -EBUSY;
> +	}

Shouldn't this actually be some kind of *device* check?

The question here is whether the gunk in the mm's address space is
compatible with the device.

 * Can the device walk the page tables in use under the mm?
 * Does the device interpret addresses the same way as the CPUs
   using the mm?

The page table format is, right now, wholly determined at boot at the
latest.  But, it probably wouldn't hurt to pretend like it _might_
change at runtime.

The address interpretation part is, of course, what LAM changes.  It's
also arguable that it includes features like protection keys.  I can
totally see a case where folks might want to be careful and disallow
device access to an mm where pkeys are in use.
