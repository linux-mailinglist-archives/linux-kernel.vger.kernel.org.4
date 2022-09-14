Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FD5B8C24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiINPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiINPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:45:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D761710
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663170339; x=1694706339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2J58XWUXP07cyxLDmZJLpFnGymq3h5HGsgmtzg9SqzE=;
  b=jfW7T2ZB3a8l4GG9WJkmgciL+pvL/WvJwB+ioibTsWDrx2ikfKs3kYkq
   8fI8FW131jjaB6xpSebVe2ZxzhndBvdy5dBulKMETbdk8+OLH5Gz/TmaM
   Detu7Y+BeLmIyRjvuVofFaXwYx4gs5YMgeDc+OdIzZbGDJVVS3ITsbqhA
   iowvrv5IpxLuWCt8mlfO+02vFr6652buFo9YyS1jEd3tYo0r24rAG1SKj
   lgX/3Bqko1Oq50mtxKFxmrzdI/G7/Nun2qDRd1++AOGz5RYirUvO/vv8c
   K8kHsH8zUnx+GYN/TqRd/eYSmBf1dGBQK1+JdNaDpSOb3eIfYiLcRJiiU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362424197"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362424197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:45:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="650119021"
Received: from gcapodan-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:45:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0B5AA10466D; Wed, 14 Sep 2022 18:45:32 +0300 (+03)
Date:   Wed, 14 Sep 2022 18:45:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:31:56AM -0700, Ashok Raj wrote:
> On Wed, Sep 14, 2022 at 06:18:18PM +0300, Kirill A. Shutemov wrote:
> > > > > > 
> > > > > > The patch below implements something like this. It is PoC, build-tested only.
> > > > > > 
> > > > > > To be honest, I hate it. It is clearly a layering violation. It feels
> > > > > > dirty. But I don't see any better way as we tie orthogonal features
> > > > > > together.
> > > > > > 
> > > > > > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > > > > > What the API has to look like?
> > > > > 
> > > > > Jacob, Ashok, any comment on this part?
> > > > > 
> > > > > I expect in many cases LAM will be enabled very early (like before malloc
> > > > > is functinal) in process start and it makes PASID allocation always fail.
> > > > > 
> > > > > Any way out?
> > > > 
> > > > We need closure on this to proceed. Any clue?
> > > 
> > > Failing PASID allocation seems like the right thing to do here. If the
> > > application is explicitly allocating PASID's it can opt-out using the
> > > similar mechanism you have for LAM enabling. So user takes
> > > responsibility for sanitizing pointers. 
> > > 
> > > If some library is using an accelerator without application knowledge,
> > > that would use the failure as a mechanism to use an alternate path if
> > > one exists.
> > > 
> > > I don't know if both LAM and SVM need a separate forced opt-in (or i
> > > don't have an opinion rather). Is this what you were asking? 
> > > 
> > > + Joerg, JasonG in case they have an opinion.
> > 
> > My point is that the patch provides a way to override LAM vs. PASID mutual
> > exclusion, but only if PASID allocated first. If we enabled LAM before
> > PASID is allcoated there's no way to forcefully allocate PASID, bypassing
> > LAM check. I think there should be one, no?
> 
> Yes, we should have one for force enabling SVM too if the application
> asks for forgiveness. 

What is the right API here?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
