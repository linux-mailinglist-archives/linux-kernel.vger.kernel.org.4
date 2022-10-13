Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC8D5FE2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJMTiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJMTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:38:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197318027A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665689926; x=1697225926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gnqFiQQECFMm+qmrQKdCPq7kmpdCWVwx6zWjN+DAumk=;
  b=WLEHwh2NmhK4n5vf/X0YCD9KMcZqVviuiyRas/md+citpOPD+bX5a1mE
   j67lhTiWViIDmq6Izr/TgY+r/P6FjdiDW8/M448SlTdM/Jfe889AaYTmS
   Nk4CNV11EcKR++/dlxja6BcJv0yXaqkqm203r4Onat0RMVijtGZZlvjJl
   qKdYalGFJ5sQlB8k+aGGaG97nYOHBpJqzEKdKAawQZg4KBXlh9ey0aW6r
   2R95wlXehyjs9g0qycDNYiVgLlEyhTpCPot3BhVUxI+zrCYIt5Neih7Tl
   ivLmn3Ab6KN/0PESbvkdK22oGaLTafOPSSQTztHGEK8itdmJYieAVc8a2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="288444851"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="288444851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 11:04:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="660433894"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="660433894"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 11:04:39 -0700
Message-ID: <16c5d292-f215-0b97-4c8f-18986ba2c15a@intel.com>
Date:   Thu, 13 Oct 2022 11:04:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-US
To:     "Yao, Yuan" <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 20:35, Yao, Yuan wrote:
> Below trace is observed on host kernel with this patch applied when create VM.
> 
> The reason is __copy_xstate_to_uabi_buf() copies data from &init_fpstate when the component
> is not existed in the source kernel fpstate (here is the AMX tile component), but the
> AMX TILE bit is removed from init_fpstate due to this patch, so the WARN is triggered and return
> NULL which causes kernel NULL pointer dereference later.
> 
> I considered 2 possible ways to fix this without big change:
> 1. For such non-exist component, we can fill the buffer in target fpstate to 0 and don't WARN if the bit is not set
>     in init_fpstate.
> 2. Enlarge the init_fpstate to content the dynamic components and still keel fpu_kernel_cfg.max_features
>     in init_fpstate (but still remove the dynamic bit from new cloned thread), so we can use it safely in above case,
>     but near 2 pages (8K) is wasted.

There's a bigger problem here.

Removing the AMX bit from xstate_bv just *TELLS* the __raw_xsave_addr()
about the buffer being too small.  Before this patch, __raw_xsave_addr()
was probably reading crap out of whatever is past 'init_fpstate' and
copying it out to userspace.

This mess makes me want a guard page after 'init_fpstate'.

Anyway, this isn't really a separate bug.  It's just more nasty fallout
from xcomp_bv being wrong in the first place.
