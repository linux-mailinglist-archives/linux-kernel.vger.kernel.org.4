Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429E6F6D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjEDORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjEDORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:17:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A38A5F;
        Thu,  4 May 2023 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683209820; x=1714745820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=alLqm8q+Z/k28CAHkPUs4IcILNokb3SjUsDt/XZB/l0=;
  b=PWbqabxNx8avC3GDPWupOt1LokkIcPg6XPT2Tft1m666f89QZer4TpH3
   zyfssYYSO5iTcc5Tx1QugOL7EAilGqGTedyhimmqcmRP3i7esWonY8UHk
   QeiNvIH1crC9qgUa8EXe2RjJI0f5x1BZFqX6Yt438kzUXFmCHH8XIFl8b
   cWxi8IfOqHDCZt0ZY6AT+NFEMIUfoOHrNzgHvd6TNcAvSCZR7XfT/x1ZJ
   jiQELDzbV5OeHEFeaOTywlzwSQ75GjbG+t5cNQiUhExXQ1D6MpsXuazsP
   Wo7MyMftc8tcSGGF++NtRynjMWaOFtUqRcGahCMEwR66JvFXQrwpUH9b9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435251285"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435251285"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 07:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841181502"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="841181502"
Received: from khaunx-mobl.ger.corp.intel.com (HELO [10.251.217.147]) ([10.251.217.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 07:16:34 -0700
Message-ID: <d0ae6716-c87f-f03d-7b66-ea899eaa7258@intel.com>
Date:   Thu, 4 May 2023 07:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: manual merge of the tip tree with the origin tree
Content-Language: en-US
To:     Mark Brown <broonie@finisterre.sirena.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20230504131824.182744-1-broonie@finisterre.sirena.org.uk>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230504131824.182744-1-broonie@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 06:18, Mark Brown wrote:
> diff --cc arch/x86/entry/syscalls/syscall_64.tbl
> index 227538b0ce801,f65c671ce3b14..0000000000000
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@@ -372,7 -372,7 +372,8 @@@
>   448	common	process_mrelease	sys_process_mrelease
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>  -451	64	map_shadow_stack	sys_map_shadow_stack
>  +451	common	cachestat		sys_cachestat
> ++452	64	map_shadow_stack	sys_map_shadow_stack

Hi Mark,

This will break the shadow stack selftest:

	tools/testing/selftests/x86/test_shadow_stack.c

since it has:

	#define __NR_map_shadow_stack  451

This also missed bumping:

	#define __NR_syscalls 452

in include/uapi/asm-generic/unistd.h.


