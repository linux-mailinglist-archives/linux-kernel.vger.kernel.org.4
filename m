Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38335E70C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIWAmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIWAmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:42:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3610D66B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663893767; x=1695429767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JPr5lgzjsIUArFY+Xndl+vflTPFS3DcvwMPckr4tPVQ=;
  b=l5Hq5x5v1KFk3jRijDQYOVrvbrvlfMkQBBRk9QsSI2v/x6pXBLAcCYaA
   zXdyacjVplhKo8I0ZTmlch65qXKMfgTxz6oHHm1jYLkVzkOBaaYnhV1Ue
   ls4FxFcpTY3qjOmjCv6zKw0LswtdaNohx4Ab6zBppRR6ohbhCs76EjkoH
   Cq9zSBlmo2ALpzcCMQsYzHZlHnZLddXqsb4IRIOeLVxR9N/0Ahmoaugss
   tjM6Lonz0XWxJj0fpqxjLE2e7CqaiL3yPv/AkklMcseC6RQMFMD6tPatD
   i9SLY/znj8N6LKMvzqEzHdfN79ZGZagOudH7Gp10ctCLSGWM1AYEif6Jl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301351635"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301351635"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:42:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="682462250"
Received: from dnessim-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.60.183])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:42:42 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 617501044E2; Fri, 23 Sep 2022 03:42:39 +0300 (+03)
Date:   Fri, 23 Sep 2022 03:42:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
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
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
References: <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytT1hfRZdb9GYQK@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 03:11:34PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 21, 2022 at 10:11:46AM -0700, Dave Hansen wrote:
> 
> > Are you saying that any device compatibility with an mm is solely
> > determined by the IOMMU in play, so the IOMMU code should host the mm
> > compatibility checks?
> 
> Yes, exactly. Only the HW entity that walks the page tables needs to
> understand their parsing rules and in this case that is only the IOMMU
> block.

But device has to know what bits of the virtual address are significant to
handle device TLB lookup/store correctly, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
