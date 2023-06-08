Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC1727EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjFHLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFHLZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:25:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6E269F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686223552; x=1717759552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wrjeCJhJ6fktJm5KxRZjxmwIgTcfO038Nx7zeCVzf1g=;
  b=NpR4QF2+oQ/e0m52Gndj1SNAE9ouU3ewyAhlyp4prPhV5j0InLIeFrXt
   orZZZqGcdiS1OLz5ODyyWKwgtbD7/YqmxkV9fkUvWB2zeCAiN5ttHlQ3W
   HUOFGnJyH0UpE5KHgFnKYhDTeiCTRuBCd/QB4qTqY0SBmLlPqPUoQ7I3m
   1J3+T0tRD9bC6iJc+Z90BlI3V3UHepT8UgB7x7Yv2uLaPkKujOabT5ulZ
   e4xSW1wSXAp7Pj9JD5DnnttdkTMf+CUovP1xgHzLBPV2nt7GMd7VQCBhZ
   LDlixaJP4ePrDNdmX4+rsAKysh0hnS8n9Qv1GmguvLgHRK6qoDSP4EIJ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337637360"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="337637360"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 04:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709940339"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709940339"
Received: from fgorter-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 04:25:48 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F33D010A676; Thu,  8 Jun 2023 14:25:46 +0300 (+03)
Date:   Thu, 8 Jun 2023 14:25:46 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Wilk, Konrad" <konrad.wilk@oracle.com>
Subject: Re: [PATCH] x86/kexec: Add a comment to relocate_kernel() for better
 readability
Message-ID: <20230608112546.y7djwgebpuv32tzt@box.shutemov.name>
References: <20230607103910.407779-1-kai.huang@intel.com>
 <20230607111957.sppocwpkhfb2e2vf@box.shutemov.name>
 <538335b164bf8b84b8a55c5654ed15d849479388.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538335b164bf8b84b8a55c5654ed15d849479388.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:41:37AM +0000, Huang, Kai wrote:
> On Wed, 2023-06-07 at 14:19 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Wed, Jun 07, 2023 at 10:39:10PM +1200, Kai Huang wrote:
> > > The reason to save %rcx to %r11 before calling swap_pages isn't that
> > > obvious w/o looking into the swap_pages itself.  Add a comment to
> > > improve the readability.
> > > 
> > > Signed-off-by: Kai Huang <kai.huang@intel.com>
> > > ---
> > >  arch/x86/kernel/relocate_kernel_64.S | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > index 56cab1bb25f5..97deae3c5e6c 100644
> > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > @@ -169,6 +169,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > >  	wbinvd
> > >  1:
> > >  
> > > +	/*
> > > +	 * Save the preserve_context to %r11 as
> > > +	 * swap_pages clobbers %rcx.
> > > +	 */
> > 
> > Line split is not needed. It fits nicely under 80-characters.
> > 
> > +	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
> > 
> > Otherwise, LGTM.
> 
> Sure.  Will do.
> 
> With above change, may I add your Acked-by ? :)

Sure.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
