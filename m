Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0B6FE3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjEJSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:15:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540285FCB;
        Wed, 10 May 2023 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683742516; x=1715278516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRRcKEJybIKi6JSwS3z5FwNCds3NlR66blTEjXfOaBI=;
  b=TZAiOhzI1WOJtnpj/lgESUm/8z14x2Ukek2Qc49bTO/fq8Yto0UOJrDh
   LJv95YcPaiyxRJkiaw4rz4DgA1R5mGDGy8N8izqruosoxa9h/I6HNxlkP
   YQ/BEIFP4ei9J5LN6RI/F+9nEpEAVcqjn52UFbb+/GqyOcDCLXqgxDow0
   hYDN1ux+/p02wnHjb8wnvvYRnV4dJERSCLj+Fs8E/c03gp8g2IPzL+03m
   J9WEj0Ms9BiWTN8Qbujsg+fX9Pl1linsXg2lRWO8XtGXapFBxMRQE7WJV
   HsSo6bJJvJ6euQm3fEYtzlrP9rzMbDQs3KvrifIoEemImbJ6Y5JurdXUA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436608149"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="436608149"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="768993899"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="768993899"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2023 11:15:15 -0700
Date:   Wed, 10 May 2023 11:18:15 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org
Subject: Re: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Message-ID: <20230510181815.GA18418@ranerica-svr.sc.intel.com>
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
 <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
 <55343361-d991-c157-4a88-843947aa45ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55343361-d991-c157-4a88-843947aa45ff@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 09:42:36AM -0700, Dave Hansen wrote:
> On 4/20/21 03:46, tip-bot2 for Ricardo Neri wrote:
> > +#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
> > +
> > +/**
> > + * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
> > + *
> > + * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
> > + * a hybrid processor. If the processor is not hybrid, returns 0.
> > + */
> > +u8 get_this_hybrid_cpu_type(void)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> > +		return 0;
> > +
> > +	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
> > +}
> 
> Hi Folks,

Hi Dave,

> 
> Sorry to dredge up an old thread.  But, where does this information
> about "If the processor is not hybrid, returns 0." come from?
> 
> What is there to keep cpuid_eax(0x0000001a) from having 0x0 in those
> bits?  Seems to me like 0 is theoretically a valid hybrid CPU type.  Right?

My reasoning was that according to the Intel SDM the only valid values were
0x20 and 0x40. 0 was meant to be an invalid value.

I read the SDM again. It seems that cpuid_eax(0x0000001a) already returns
0 when the leaf does not exist.

Probably the check for X86_FEATURE_HYBRID_CPU is not needed.

Still, callers need to check for a valid value, IMO.
