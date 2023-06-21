Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14D4739048
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFUTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFUTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:41:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78950171C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687376468; x=1718912468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GIezgd37pTI6LXKw1SI7h5jfqmOPU2vrDOcKboJC5RI=;
  b=nZ7QMmZDfIhTX/YsCFYgHOZOXh0J4Pciy/7pqozDstSN6tCOrHo3T3B6
   iuW/LUulh7VysE1T3MKlzhMu91TVZzVATTmQZ3hgjNMi2G1IAVoFGVUAD
   XHlGSUU9jURqRzpG3dFEaOKklbth8dJGYbvxX2LzYb3wj5kGaNqaxRNem
   8w4PFf/1nBHMlwCiJbTxAsfLmegdT2Sj3XVDRllLNKfDe2QneTwP4FMAO
   TdiFX0BJc7s1U0kn53AOKKukXuf/gi0gNfBjogzD/3XqK9YjTp67BJtHB
   oUuZ4/NuWq99JHbmMTheUpDJu5P/8l5OkxZ83I1uOlo7AV9pZcQ0QblDa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360299946"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="360299946"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888812841"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="888812841"
Received: from absteel-mobl1.amr.corp.intel.com (HELO desk) ([10.212.231.126])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:41:07 -0700
Date:   Wed, 21 Jun 2023 12:41:01 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <20230621194101.bmwesljror2yqjxx@desk>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNDRSUZuZ2L+pwo@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:36:53AM -0700, Breno Leitao wrote:
> On Wed, Jun 21, 2023 at 10:31:35AM -0700, Pawan Gupta wrote:
> > On Wed, Jun 21, 2023 at 08:54:17AM -0700, Breno Leitao wrote:
> > > On Tue, Jun 20, 2023 at 05:13:27PM -0700, Pawan Gupta wrote:
> > > > On Fri, Jun 16, 2023 at 09:48:50AM -0700, Breno Leitao wrote:
> > > > > There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
> > > > > compilation time. These mitigations are enabled even if
> > > > > CONFIG_SPECULATION_MITIGATIONS is unset.
> > > > > 
> > > > > Create a new KCONFIG option for each mitigation under
> > > > > CONFIG_SPECULATION_MITIGATIONS that allows these
> > > > > mitigations to be disabled by default at compilation time.
> > > > 
> > > > I don't think all mitigations are still controllable at build-time e.g.
> > > > spectre_v2 eIBRS mitigation will still be deployed irrespective of the
> > > > config.
> > > 
> > > Right. This patchset only cares about MDS, TAA and MMIO. I am more than
> > > happy to send a new patch to also disable spectre_v2 eIBRS.
> > 
> > What about Retbleed, L1TF, SRBDS etc? I thought the goal is to control
> > all speculation mitigations?
> > 
> > To be consistent CONFIG_SPECULATION_MITIGATIONS should control all
> > speculation mitigations.
> 
> If I understand where you want to go, you think we should create a
> single patchset that creates a CONFIG_<MITIGATION> for each mitigation,
> and move get it under CONFIG_SPECULATION_MITIGATIONS.

Yes, a single series (or a patch) that adds config for each mitigation
would be good.
