Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D95B6472
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIMAGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIMAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:06:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA84B4BA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663027598; x=1694563598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uvw6V9KjV6Vb8eX5TMVrCqR2Yi0yPi5W4S9MFXY9hpk=;
  b=azhnkSR4tFaI+SXZVmNajL24WpI8ixOpFqgh0M6YWPTauN+U2tNvRxcD
   qDKDtDSw3FbAo/KP0+aPf4VHzek4c44NviZLi1zAtT31/cfISHfXxJi2u
   wQKToetqXCU8B/JA8/ET9RFb0Xw/qw4F7cz+KckDgcCiM7Yq9orITUzA9
   xCUEUox/EuajfW1YWp+LmfxLG6xOB/8i6Hb+M+VK9ib3Z2+XvDACb5Q/I
   abxlN4Bw4UQcS8VCohe3brLZBDRdsj5kW2fokA8fN45Mvc2CSMB58c0ms
   j+xjoHkGtuBTuRuvKa7i7mmUBT4hOuCwTtKL+6eQ/zkRpYePkpHrQb+vP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384295266"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="384295266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="944838249"
Received: from aburgsta-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.142])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:06:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3177910455B; Tue, 13 Sep 2022 03:06:32 +0300 (+03)
Date:   Tue, 13 Sep 2022 03:06:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220913000632.2o4alsekgskof2x2@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <Yxtk4gMbcVgTKzKg@araj-dh-work>
 <20220912133935.3bb3e247@jacob-builder>
 <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
 <20220912155502.0087a993@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912155502.0087a993@jacob-builder>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 03:55:02PM -0700, Jacob Pan wrote:
> Hi Dave,
> 
> On Mon, 12 Sep 2022 14:41:56 -0700, Dave Hansen <dave.hansen@intel.com>
> wrote:
> 
> > On 9/12/22 13:39, Jacob Pan wrote:
> > >>> +	if (pasid_valid(mm->pasid) && !forced) {  
> > > I don't think this works since we have lazy pasid free.  for example,
> > > after all the devices did sva_unbind, mm->pasid  we'll remain valid
> > > until mmdrop(). LAM  should be supported in this case.  
> > 
> > Nah, it works fine.
> > It just means that the rules are "you can't do LAM if your process
> > *EVER* got a PASID" instead of "you can't do LAM if you are actively
> > using your PASID".
> Sure it works if you change the rules, but this case need to documented.
> 
> > 
> > We knew that PASID use would be a one-way trip for a process when we
> > moved to the simplified implementation.  This is just more fallout from
> > that.  It's fine.
> > 
> Is LAM also a one-way trip?

Yes.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
