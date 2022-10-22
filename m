Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF05608E62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJVQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJVQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:12:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F126579
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666455164; x=1697991164;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3p+8NBkTUbFy4R5UzHnHF1Yyl5BTgdksK3WORtWcYY=;
  b=IGsiP/sOX+6JVr+egsCCju6cAO1S9rz8vaZRqEoBLkBrQmkjgvb70RIe
   H48OAxurnZTySGlMcdw6lWSFnJXIkX1cpE722C1XMyVaVP+nIEtaINg0Z
   e+q9/widPFaE8wt0zU6Ry1D9Y8O7NTFgjAB70j7WdDTKL294Tb1lwMN4o
   aSOmCjZTHpYyepZlKE04UXhI63KJRzxT4GFmVPze1MFvwAk49HOv9HFZI
   Z/Q0Z6Cz9GLPBh7OAEXO61AmyEHeNZeWiNDje+3AAz7Ne5eQyHQ5N1fzJ
   ZEdlFVgleBWuEMR1t6rXqr1PR1qhwIFT0WKRR15tzZM14F0ibwDdi+YH4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308878825"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="308878825"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 09:12:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="633271520"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="633271520"
Received: from xlv2-mobl2.ccr.corp.intel.com ([10.254.213.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 09:12:41 -0700
Message-ID: <6636557f617ea5a1a1ab6f30f7aea0ececdd2a36.camel@intel.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com
Date:   Sun, 23 Oct 2022 00:12:38 +0800
In-Reply-To: <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
References: <20221021062131.1826810-1-feng.tang@intel.com>
         <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
         <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 09:21 -0700, Dave Hansen wrote:
> On 10/21/22 08:00, Zhang Rui wrote:
> > I checked the history of '__max_logical_packages', and realized
> > that
> > 
> > 1. for topology_max_packages()/'__max_logical_packages', the
> > divisor
> >    'ncpus' uses cpu_data(0).booted_cores, which is based on the
> >    *online* CPUs. So when using kernel cmdlines like
> > maxcpus=/nr_cpus=,
> >    '__max_logical_packages' can get over-estimated.
> > 
> > 
> > 2. for 'logical_packages', it equals the number of different
> > physical
> >    Package IDs for all *online* CPUs. So with kernel cmdlines like
> >    nr_cpus=/maxcpus=, it can gets under-estimated.
> > 
> > BTW, I also checked CPUID.B/1F, which can tell a fixed number of
> > CPUs
> > within a package. But we don't have a fixed number of total CPUs
> > from
> > hardware.
> > On my Dell laptop, BIOS allows me to disable/enable one or several
> > cores. When this happens, the 'total_cpus' changes, but CPUID.B/1F
> > does
> > not change. So I don't think CPUID.B/1F can be used to optimize the
> > '__
> > max_logical_packages' calculation.
> > 
> > I'm not sure if we have a perfect solution here.
> 
> Are the implementations fixable?

currently, I don't have any idea.

>   Or, at least tolerable?
> 
> For instance, I can live with the implementation being a bit goofy
> when
> kernel commandlines are in play.  We can pr_info() about those cases.

My understanding is that the cpus in the last package may still have
small cpu id value. This means that the 'logical_packages' is hard to
break unless we boot with very small CPU count and happened to disable
all cpus in one/more packages. Feng is experiencing with this and may
have some update later.

If this is the case, is this a valid case that we need to take care of?

thanks,
rui

