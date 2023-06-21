Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA13173929B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFUWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFUWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:35:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F053173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687386954; x=1718922954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=arRQykyRvQ3HgEr5GE5iYhHj4FTPGnwjfQagWxDSJuM=;
  b=do+s8xZLN7CoP+XFv2KiEO/v83/70zqb2kZNT+XOrRqM2N1jVG+WRBWb
   D81ThS5+ttmiVFrntHTTP2iI0WUxiVxHXKz7JLpq/3cQKwSraST+rKqrN
   VR7YfM9ymxx8z9DtwfLvwkgaE9+JkX5SkV6cMe0lMc3LA4skzuiXliCNc
   4jVvbv45b3pBBksv6eYHFzKFF1Z4WU7HAHOZK7s/aO5mePsSWObFpO7Rk
   6aLzPsyNaQtdOuOjnG3iVZ/lNp6v9lGc96XFPjlSSboDhmHb31Ngvkk+F
   vI0bZmY1qLD8/9qv6a0XQ4/Au1Xbxka0CBPfbY1PDGF3HFqbjKuCxNqdx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339936509"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="339936509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744378906"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="744378906"
Received: from rmathew-mobl2.amr.corp.intel.com (HELO [10.212.134.235]) ([10.212.134.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:35:46 -0700
Message-ID: <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com>
Date:   Wed, 21 Jun 2023 15:35:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk> <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk> <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230621194101.bmwesljror2yqjxx@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 12:41, Pawan Gupta wrote:
> Yes, a single series (or a patch) that adds config for each mitigation
> would be good.

Do people _really_ want per-mitigation compile-time controls?  That
seems like kinda a pain.

I Boris suggested it, but it seems like a _bit_ of overkill to me.

Would a compile-time option that just defaulted _everything_ to
mitigations=off behavior work instead?  That way we don't end up with a
billion new config options.
