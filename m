Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB556EE8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjDYUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjDYUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:03:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A619A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682453013; x=1713989013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=reHRQOre2NO1+iT/Sg5jDcvNmur/+KiCLnVwPnJYHxI=;
  b=DraTa1bSjYxfH1NEfFfhpnx762mNwWNhucPX5vmJp4u4fgaLfpNUuEz4
   f4c7A6JBNsVWYFDR/8s6dz5Qb9I+X35o/b6EpVpk9P0eyvXfVPvJC7QrT
   LbYxPjnm8zRQNeE3Qfjl1GbjgDPQAQj14m0lgd39PSF5gpSAQs3crYXVI
   e40ZSx4ma/n6JaXFDTV/LNfC1d+t194NaR2rUZYiabDJxzdmt8HriNZWQ
   2wepXrm2RAw6vx/XyJwWbckMLls5bQUiSHykJzt8BwQ7Zhr7RyB/CXsTL
   WvQdaBZcTxs0/FXY7dMVgYgCyvTH1G8WYt6uQtX/SEsOdLngxpTAqrl8W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="374837854"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="374837854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 13:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="687604650"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="687604650"
Received: from gchacko-mobl1.gar.corp.intel.com (HELO [10.215.145.52]) ([10.215.145.52])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 13:03:27 -0700
Message-ID: <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
Date:   Tue, 25 Apr 2023 13:03:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 12:26, Tony Battersby wrote:
> -	if (cpuid_eax(0x8000001f) & BIT(0))
> +	if (c->extended_cpuid_level >= 0x8000001f &&
> +	    (cpuid_eax(0x8000001f) & BIT(0)))
>  		native_wbinvd();

Oh, so the existing code is running into the

> If a value entered for CPUID.EAX is higher than the maximum input
> value for basic or extended function for that processor then the data
> for the highest basic information leaf is returned
behavior.  It's basically looking at BIT(0) of some random extended
leaf.  Probably 0x80000008 based on your 'cpuid -r' output.


