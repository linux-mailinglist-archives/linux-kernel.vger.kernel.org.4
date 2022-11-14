Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C46284A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiKNQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiKNQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:08:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DB2CDF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442098; x=1699978098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NB3+fJoMKwqzysWsqmJs5pf4ZiLQUSeEqva5IN0eC34=;
  b=fE+9r3J5+Rf+kVLqceslL1Yr/Gpr+2hraTvCOORVtNdfvU81wlQGHRcU
   PQQjPdXRjK04zr7CuIWcyAx1FVOTU4KYSRZkHUEGMEvDwCKl/F+b+uUy7
   w7MYsKCWr6HMHyfKHFaOOV80xlHRpq3dAPVj2eKLPDOMWu7ZOA+/zHb2/
   h64NfZpsmGQ4BvpIed+zdqiuMcjWpdPYdPh0fWjU0WS9D5lJ9zJLdVWnf
   QMuOJGf3zxCRx4+tdS2RpISK0R+qcBhOVOsjCVdotNFEjOB8KShGDysux
   u+fGotvpr6EpT9Lk63ue9s20TA9wunVMSzUhK+HF3YV4g3zwNf0GoXXvC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309635671"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309635671"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:08:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669710321"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669710321"
Received: from satyanay-mobl1.amr.corp.intel.com (HELO [10.209.114.162]) ([10.209.114.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:08:16 -0800
Message-ID: <333d37c3-7a9f-ac86-1a19-b5d61e1f59eb@intel.com>
Date:   Mon, 14 Nov 2022 08:08:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/4] x86/mm: Inhibit _PAGE_NX changes from
 cpa_process_alias()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        oliver.sang@intel.com
References: <20221110125253.240704966@infradead.org>
 <20221110125544.594991716@infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221110125544.594991716@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 04:52, Peter Zijlstra wrote:
> There is a cludge in change_page_attr_set_clr() that inhibits
> propagating NX changes to the aliases (directmap and highmap) -- this
> is a cludge twofold:
> 
>  - it also inhibits the primary checks in __change_page_attr();
>  - it hard depends on single bit changes.
> 
> The introduction of set_memory_rox() triggered this last issue for
> clearing both _PAGE_RW and _PAGE_NX.
> 
> Explicitly ignore _PAGE_NX in cpa_process_alias() instead.
> 
> Fixes: b38994948567 ("x86/mm: Implement native set_memory_rox()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Debugged-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks sane.  It's also nice how the checkalias stuff continues to fall
out of there.

Acked-by: Dave Hansen <dave.hansen@intel.com>
