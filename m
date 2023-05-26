Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04371260A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbjEZLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjEZLyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:54:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F80128;
        Fri, 26 May 2023 04:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685102075; x=1716638075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OXaA/82mpWbwoIsPrGVE3HyCLxIMqdtM/0KKQU63C2s=;
  b=VHb4WPeM7okwJzUHdOK1J/eDI4q2RXmXF4NQVzk+CC2QOb9HyiEmBrNT
   Eh8DFkkMBUKBUISEhTb/Eq9lwUCYfdvznA3gwF7Wb2WEvWw3x18Ijd6Vt
   Qhi7OU3q+BGkgR79KqHWTjNDaCreBjaa3xtJU0ErNpfEuRKkaxri/ggkN
   Wpq9CNDM1Qy8xw+0U/xK92Kb2hO6ps1baC0aWQOKL+z8+wgWd8rtiUzRL
   7Xw1HaLvwSaf/JSIdOYPi/SV5mXW731lkugpjUpUSWh74Umr+QeDpzVzS
   3Z94JyQtTrJq1NPaxyIipjFN3E/ZGwV+qDBOdlVQUBjNbtDFCboGhc+D3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="334536815"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="334536815"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 04:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951851702"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="951851702"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.169])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 04:54:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4BAE210C61D; Fri, 26 May 2023 14:54:26 +0300 (+03)
Date:   Fri, 26 May 2023 14:54:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, decui@microsoft.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/tdx: Fix race between set_memory_encrypted() and
 load_unaligned_zeropad()
Message-ID: <20230526115426.k64df56qywql5mel@box.shutemov.name>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
 <20230525225847.28592-3-kirill.shutemov@linux.intel.com>
 <ec1553a9-4412-b624-4f10-93ef332f12d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1553a9-4412-b624-4f10-93ef332f12d9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:40:00PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi, 
> 
> On 5/25/23 3:58 PM, Kirill A. Shutemov wrote:
> > Touching privately mapped GPA that is not properly converted to private
> > with MapGPA and accepted leads to unrecoverable exit to VMM.
> > 
> > load_unaligned_zeropad() can touch memory that is not owned by the
> > caller, but just happened to next after the owned memory.
> > This load_unaligned_zeropad() behaviour makes it important when kernel
> > asks VMM to convert a GPA from shared to private or back. Kernel must
> > never have a page mapped into direct mapping (and aliases) as private
> > when the GPA is already converted to shared or when GPA is not yet
> > converted to private.
> > 
> > guest.enc_status_change_prepare() called before adjusting direct mapping
> > and therefore it is responsible for converting the memory to private.
> > 
> > guest.enc_tlb_flush_required() called after adjusting direct mapping and
> > it converts the memory to shared.
> 
> Do you mean .enc_status_change_finish() here? Isn't enc_tlb_flush_required()
> called before adjusting the mapping?

Yes, I copy-pasted wrong callback :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
