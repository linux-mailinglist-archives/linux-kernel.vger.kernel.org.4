Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7C60FB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiJ0PRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiJ0PRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:17:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC341A045B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666883568; x=1698419568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8A/YviDx8iqyRdDwX9h7ESPZbhw7TVDZ5xd3lzXfDHw=;
  b=doCXullkCOXOr9qTAW9rIbVAnRT92MNHgvkWQpP2ly5OM9Zcics75aou
   zrn8G2Diq8mramiz+a9ExhN848uKK3fU12qA3K1AAm4zOPFBnVQE4jK1c
   AfMl+DqcDBtWLmMUGmGJqljzd7pY0fpGYctpnl+JOsPl8nFzAFQV2s+KP
   gkZ8YAO+8V3nMgWdAlKvIOSc2R71zjqENdliHrQL1bTQPcfajyBbqcZs+
   awirFzruYlS7myqB9zdzp1/62ck2V5j92jM/Kc3pRDwiK+Ic7hL1Olcat
   GXe03xgwq6LCFtJc/RWEQaVUk9Un2CLZWuKUlzvQK3ORY20tVek476fXb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="287965967"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="287965967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:12:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="701378321"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="701378321"
Received: from vstelter-mobl.amr.corp.intel.com (HELO [10.212.214.108]) ([10.212.214.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:12:28 -0700
Message-ID: <864b4fbe-4462-9962-7afd-9140d5165cdb@intel.com>
Date:   Thu, 27 Oct 2022 08:12:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip:x86/mm] [x86/mm] 1248fb6a82:
 Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page
Content-Language: en-US
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, "Yin, Fengwei" <fengwei.yin@intel.com>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
 <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
 <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 08:39, Andrey Ryabinin wrote:
> KASAN tries to allocate shadow memory for the whole cpu entry area.
> The size is CPU_ENTRY_AREA_MAP_SIZE/8 and this is obviously fails after your patch.
> The fix this might be something like this:
> 
> ---
>  arch/x86/include/asm/kasan.h |  2 ++
>  arch/x86/mm/cpu_entry_area.c |  3 +++
>  arch/x86/mm/kasan_init_64.c  | 16 +++++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)

Andrey, if you have a minute, could you send this as a real patch, with
a SoB?

Alternatively, do you have any issues if we add your SoB and apply it?
