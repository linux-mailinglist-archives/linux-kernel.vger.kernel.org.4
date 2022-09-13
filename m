Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40C5B6471
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIMAEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIMAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:04:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA07101F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663027487; x=1694563487;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e08DO+nESv5SUFPLV4pDZkpPx6WqURD0tlXib9o8nS0=;
  b=AYN57LV2U+T6tFGCvPKl+UK3P93K+dPxNI9EZK7dkJVxt3Pk+sM/5Cky
   9rlTzw6ufR8fjn6Vn0S6PI40BMUOUwZqoqGSGh3MzLIYiZ+fUSmJDBU7N
   7mnyr2kt5vVroztDoX+KVaIdGt0tzelExXQks3DhR90BHv/Q+GBGW5LoQ
   XPCW2db4+s12wrRFj/nm0LuezqeH44QvNwVnm90s8ZMt7exJrR9hYMJe9
   MDd8VRKfJII35lfJTtCwZJWGK7Ri+KCAQKjKkS3Viz6O6uX1x2bVCXWhY
   Kf/k6Azwyh5jZ5Sat5+2lStw8xwmsLq7px6G7RgWk7ifaV/VViDMz3KMR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278392163"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="278392163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:04:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646689982"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:04:46 -0700
Date:   Mon, 12 Sep 2022 17:08:09 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@intel.com
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220912170809.101fa976@jacob-builder>
In-Reply-To: <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
        <YxDvpLb77lwb8zaT@araj-dh-work>
        <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
        <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
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

Hi Kirill,

On Tue, 13 Sep 2022 01:49:30 +0300, "Kirill A. Shutemov"
<kirill.shutemov@linux.intel.com> wrote:

> On Sun, Sep 04, 2022 at 03:39:52AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:  
> > > Hi Kirill,
> > > 
> > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:  
> > > > Linear Address Masking[1] (LAM) modifies the checking that is
> > > > applied to 64-bit linear addresses, allowing software to use of the
> > > > untranslated address bits for metadata.  
> > > 
> > > We discussed this internally, but didn't bubble up here.
> > > 
> > > Given that we are working on enabling Shared Virtual Addressing (SVA)
> > > within the IOMMU. This permits user to share VA directly with the
> > > device, and the device can participate even in fixing page-faults and
> > > such.
> > > 
> > > IOMMU enforces canonical addressing, since we are hijacking the top
> > > order bits for meta-data, it will fail sanity check and we would
> > > return a failure back to device on any page-faults from device. 
> > > 
> > > It also complicates how device TLB and ATS work, and needs some major
> > > improvements to detect device capability to accept tagged pointers,
> > > adjust the devtlb to act accordingly. 
> > > 
> > > 
> > > Both are orthogonal features, but there is an intersection of both
> > > that are fundamentally incompatible.
> > > 
> > > Its even more important, since an application might be using SVA
> > > under the cover provided by some library that's used without their
> > > knowledge.
> > > 
> > > The path would be:
> > > 
> > > 1. Ensure both LAM and SVM are incompatible by design, without major
> > >    changes.
> > >    	- If LAM is enabled already and later SVM enabling is
> > > requested by user, that should fail. and Vice versa.
> > > 	- Provide an API to user to ask for opt-out. Now they know
> > > they must sanitize the pointers before sending to device, or the
> > > 	  working set is already isolated and needs no work.  
> > 
> > The patch below implements something like this. It is PoC, build-tested
> > only.
> > 
> > To be honest, I hate it. It is clearly a layering violation. It feels
> > dirty. But I don't see any better way as we tie orthogonal features
> > together.
> > 
> > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > What the API has to look like?  
> 
> Jacob, Ashok, any comment on this part?
> 
> I expect in many cases LAM will be enabled very early (like before malloc
> is functinal) in process start and it makes PASID allocation always fail.
> 
Is there a generic flag LAM can set on the mm?

We can't check x86 feature in IOMMU SVA API. i.e. 
 
@@ -32,6 +33,15 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
+
+	/* Serialize against LAM enabling */
+	mutex_lock(&mm->context.lock);
+
+	if (mm_lam_cr3_mask(mm)) {
+		ret = -EBUSY;
+		goto out;
+	}
+

> Any way out?
> 


Thanks,

Jacob
