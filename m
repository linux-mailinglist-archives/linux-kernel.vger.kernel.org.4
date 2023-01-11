Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8705B665042
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjAKAN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjAKAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:13:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C685D5B157
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673396005; x=1704932005;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=rhBvEIso996KWiUYNT3v6A5OEIDRuz0ouJ0cSkwqISA=;
  b=SeaUjaXlKk+Me4ag+2tnt/OHPJ/oAIIVhh9JcMcMPOtlZxKzx9Fw/asQ
   aPn8UA1Vjt4Ylnja0oLYi+EAZUKI0kVeUhKmAAKO/QnC46FRkpTUh+yB/
   nW1SneYAf3yLOlw7YGmgBPwWmt1iVgj5ERMv1b4Qk1Eh5SbmMBjW9FEzf
   Nt7C64df4RZKXXhOuj32/6i4vnQn6knDJjf77BalTcub0//UB/BWK3OgO
   BLp+pKaynZbjewB7mdgrMfywo8OGg1MvG+pGUHrhtocinZvRjNGIKx0hq
   krycIfJFwszpoX5C6Z5T1FcU2uEleppx3EjTt9P3bu+8/ODsUV3MnV6da
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311101652"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311101652"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 16:13:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="725713580"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725713580"
Received: from svenka7-mobl1.amr.corp.intel.com (HELO [10.209.63.27]) ([10.209.63.27])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 16:13:20 -0800
Message-ID: <feab0dd1-2030-e31c-cbbf-9857c46d0c1c@intel.com>
Date:   Tue, 10 Jan 2023 16:13:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        Yian Chen <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
 <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 12:14, Sohil Mehta wrote:
> On 1/9/2023 9:51 PM, Yian Chen wrote:
>> LASS (Linear Address Space Separation) is a CPU feature to
>> prevent speculative address access in user/kernel mode.
> 
> Would it be better to say?
> 
> LASS (Linear Address Space Separation) is a security feature that
> intends to prevent unintentional speculative address access across
> user/kernel mode.

It's more than that, though.  The spec actually says this pretty nicely:

> Linear-address space separation (LASS) is an independent mechanism
> that enforces the same mode-based protections as paging but without
> traversing the paging structures. Because the protections enforced by
> LASS are applied before paging, “probes” by malicious software will
> provide no paging-based timing information

So, it's not _just_ that it can prevent some speculative accesses.  It
completely short-circuits paging itself and *ALL* of the baggage that
goes along with paging.

The TLB, mid-level caches, the page walker itself, the data cache
impact...  all of it.  Gone.

*THAT* is the important part here, IMNHO.
