Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA5666B57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjALHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjALHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:00:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34621B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673506854; x=1705042854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKXVqw2VdPj0WisqK61X35RcspvxrMGsNhD4PdMki38=;
  b=eVunNmpkGEI+5udLFq1N57UcdDR6HaWjT6X703PUcoKZXQIVE+/dbkcP
   Ma9mUXUzACjIFTUG/ZgsvdVkaHzb21AvcSC2GtJOrGBsI+g2GR2z1O5bs
   s4oOh4dxF0QBgFQvJ9qGfo2sgbUhYBtmq2z0LourbIHUO8I3OC0vMsmOf
   qZ7c2bfzEPwi3fWIHySbbkXPR1VNdaNyqxQJdKhIhOSYjne35VYgNMN3G
   OFAcoKG/tDFSNSmrQh618viZK/xg/Dt+ytQp4Fz8yCCvHhaL3gw6emLGA
   iSiu6JyvWHo4KuuXvHAkxUXCSDS/csi0X4HAQW/pvlXjiAyZluMu+yr0e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350856804"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350856804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:00:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765492049"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="765492049"
Received: from reillyco-mobl.amr.corp.intel.com (HELO desk) ([10.209.117.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:00:53 -0800
Date:   Wed, 11 Jan 2023 23:00:37 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20230112070037.q6cg23tn57onmxfi@desk>
References: <20221128153148.1129350-1-leitao@debian.org>
 <Y76wtwWN1+XPbnQx@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y76wtwWN1+XPbnQx@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:51:03PM +0100, Borislav Petkov wrote:
> On Mon, Nov 28, 2022 at 07:31:48AM -0800, Breno Leitao wrote:
> > Currently x86_spec_ctrl_base is read at boot time, and speculative bits
> > are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
> > CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
> > the mitigations are disabled.
> > 
> > This is a problem when kexec-ing a kernel that has the mitigation
> > disabled, from a kernel that has the mitigation enabled. In this case,
> > the MSR bits are carried forward and not cleared at the boot of the new
> > kernel. This might have some performance degradation that is hard to
> > find.
> > 
> > This problem does not happen if the machine is (hard) rebooted, because
> > the bit will be cleared by default.
> > 
> > Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/x86/include/asm/msr-index.h |  4 ++++
> >  arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 4a2af82553e4..22986a8f18bc 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -54,6 +54,10 @@
> >  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
> >  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
> >  
> > +/* A mask for bits which the kernel toggles when controlling mitigations */
> > +#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
> > +							| SPEC_CTRL_RRSBA_DIS_S)
> 
> SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.

The mitigation is enabled when this bit is set. When set, it prevents RET
target to be predicted from alternate predictors (BTB). This should stay
0, unless enabled by a mitigation mode.

> Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
> doesn't cost that much...

I guess this doesn't matter now, because this patch is resetting it by
default that keeps the mitigation disabled with no perf impact.
