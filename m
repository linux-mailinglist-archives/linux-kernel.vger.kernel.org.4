Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFD73781D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFUANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFUANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:13:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7011728
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687306413; x=1718842413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Py0WuD6QzcVfqClR14sSZEqYt9rmNf93zUffeC2+4+I=;
  b=Xdi03RDqeAmhSvIW5ZLzMQcGiglJKi6W5yzSuDOc/zdzZObaDzqHCuGc
   WOpP1/NypWlpOYN87mFtw/Y70aPI/c7/Z6+DRUYqPTy9CBrEHZl61oXGb
   +6/0HMN0E40i6WxsQRC0uBcWPU1rWwQlH5T1+UNCKkPtMlNx5B9E0myTX
   LL8OP2g/wKGHfWz49M58kfPYpMTxn2qYs8/+ErT0/4DeKCxa447Vdqx51
   uprnWjoIXcqXh+Fxz3s0DY0mQGKw2tcEsBWg68VdtJ/u7nrQjNusvM0Kh
   Zi8Ew6s+uagrKpudS4Do3Go2HKQnv8p1Szs0yblI5+vKzqk/PK3IWeZTs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389398238"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="389398238"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691643633"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="691643633"
Received: from rrwillia-mobl.amr.corp.intel.com (HELO desk) ([10.209.24.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:13:32 -0700
Date:   Tue, 20 Jun 2023 17:13:27 -0700
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
Message-ID: <20230621001327.qdyebewnx7r5aiy3@desk>
References: <20230616164851.2559415-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616164851.2559415-1-leitao@debian.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:48:50AM -0700, Breno Leitao wrote:
> There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
> compilation time. These mitigations are enabled even if
> CONFIG_SPECULATION_MITIGATIONS is unset.
> 
> Create a new KCONFIG option for each mitigation under
> CONFIG_SPECULATION_MITIGATIONS that allows these
> mitigations to be disabled by default at compilation time.

I don't think all mitigations are still controllable at build-time e.g.
spectre_v2 eIBRS mitigation will still be deployed irrespective of the
config.
