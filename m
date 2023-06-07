Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1452725CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbjFGLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFGLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:16:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A0192
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686136618; x=1717672618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiKSAp5BVygTV9wZE+ojPjExOYqMBatij4nulCuDqV8=;
  b=H9PNDlMgL8OjrOaTi9Ch9V/i/K6+SZaXgYigPQ9RMezkQMIXLWDKybL/
   SVGFSBs8aWp6gdl5mRc5f3lgny+pNhg08hBtG7a0Pi5nrwCf9lkecdgBm
   rm3++FNtQE1e2uNtIqOzB2PWpi67ZDzfJT5gBUMmwDYgNrB8WJIEKUSV8
   GtacUdWjQAKnoS/pPdzRYe9wGaVpJAnuDFKLdZ09KGPBnwgLJpNwb/7Az
   6mGNDi2ufdyKKnyxA7qRZT/gFVAmSzN5BN4jYZHOu1Ca05RgvDTvseAjK
   KGvpxYwIsgvk3iBnd4XXwd88Wn6VXwv/59AD8rrR/GkjOWFsZYzNtX+H2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356968095"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="356968095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853844424"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="853844424"
Received: from akuporos-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.211.72])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:16:55 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7550E10F0D2; Wed,  7 Jun 2023 14:16:52 +0300 (+03)
Date:   Wed, 7 Jun 2023 14:16:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, decui@microsoft.com,
        rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Message-ID: <20230607111652.iydtlf2iqwg2zeid@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
 <f7f82377-6127-79e3-07d8-def490c4e35c@intel.com>
 <20230606183718.i3iqwbk7gdomiq5s@box.shutemov.name>
 <1eaf32e1-f808-320d-2643-387682cf7ea0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaf32e1-f808-320d-2643-387682cf7ea0@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:29:15PM -0700, Dave Hansen wrote:
> On 6/6/23 11:37, Kirill A. Shutemov wrote:
> >> Heh, that must be really important info to have it in the changelog twice!
> >>
> >> I'll fix it up when I apply it.
> > Ouch. Please fix the comment in the code too.
> 
> I couldn't help myself and rewrote the changelog and comment.  Please
> let me know if it looks OK:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx

Looks good. Thank you.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
