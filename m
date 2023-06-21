Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41F738D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFURbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFURbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:31:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618DE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687368703; x=1718904703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMqvQECyIomaYC4b1lIKJwFmPlmJ/wDvy/xkGjZXTa0=;
  b=D0wbsUAWVzF7sGkoaaamWRvSGbHfCv/JMymPav2KCE5I504t06zlnD0K
   TmtgvGgwPnCfphrx8NnRu30U+p1NIEXlgpQlZDBTwD8q2tbTF5lwbvCiE
   J7KeuPqLWlE/aytIMcpydwmQfHdXCRWDmSB6k68Kc8RC1mXylA24JI4rw
   ZO5HP4XGGMk59pMvhFgklYO70ajeukK3zlQrLV8UdwJ+mZevJaK+kW5By
   a+dYFx8oyS9oCKimSOAf696a5E7EWhmui9NyUpUqiW64gfZOzryGdYA+I
   iHj/wT4xRd9GEWgG22czh5IKG94ANyY23FlEXmDUdZNllAzASsTKoJiyX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357749579"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357749579"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961281789"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="961281789"
Received: from absteel-mobl1.amr.corp.intel.com (HELO desk) ([10.212.231.126])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:31:41 -0700
Date:   Wed, 21 Jun 2023 10:31:35 -0700
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
Message-ID: <20230621173135.wiprtgzslhw5z5or@desk>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMdKUr98H8zPSAl@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:54:17AM -0700, Breno Leitao wrote:
> On Tue, Jun 20, 2023 at 05:13:27PM -0700, Pawan Gupta wrote:
> > On Fri, Jun 16, 2023 at 09:48:50AM -0700, Breno Leitao wrote:
> > > There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
> > > compilation time. These mitigations are enabled even if
> > > CONFIG_SPECULATION_MITIGATIONS is unset.
> > > 
> > > Create a new KCONFIG option for each mitigation under
> > > CONFIG_SPECULATION_MITIGATIONS that allows these
> > > mitigations to be disabled by default at compilation time.
> > 
> > I don't think all mitigations are still controllable at build-time e.g.
> > spectre_v2 eIBRS mitigation will still be deployed irrespective of the
> > config.
> 
> Right. This patchset only cares about MDS, TAA and MMIO. I am more than
> happy to send a new patch to also disable spectre_v2 eIBRS.

What about Retbleed, L1TF, SRBDS etc? I thought the goal is to control
all speculation mitigations?

To be consistent CONFIG_SPECULATION_MITIGATIONS should control all
speculation mitigations.
