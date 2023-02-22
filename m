Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C969FCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBVUEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjBVUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:04:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6722020
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677096236; x=1708632236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TTkt4GO+BGUlOPV2gGepj7m2bOBpEDZqi5l7D3NsoJE=;
  b=dU1LAC6ActVAqXFV6m8Po+SSbohH2tfWPu3zHhhTjCm+eyLyn8WNKxpY
   awOGZ+r1ZyzD3WDV8+VRzz21+762+RiFVC9447a9d4dB6jRQludik5Nai
   kAQujjbzwZbi4yTms25Fz760iQywsqP21lOS0uoJ8+W5vdLvpYr7wjO33
   Fnp7geEZV3+pqezNXt80+qbv8A7ipp1M0uRebtj5HQz6uEdeGokaNfT66
   21SeqAaLQsaoHa7umMkJ0n9gpt4nepwMX/sXJaolUxsSjhm32m//7G0vU
   wXVA/C34qnBy3Y5VTbq54wu1LN792PobOwwHMEvMukRD8dMQ7BCShmB+D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="397719442"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="397719442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 12:03:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="781576973"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="781576973"
Received: from tzinser-mobl.amr.corp.intel.com (HELO [10.209.49.182]) ([10.209.49.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 12:03:54 -0800
Message-ID: <7016f30f-65dd-b1a1-a44a-fb7af689959b@intel.com>
Date:   Wed, 22 Feb 2023 12:03:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/1] x86/mm/pat: Clear VM_PAT if copy_p4d_range failed
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de,
        toshi.kani@hp.com, suresh.b.siddha@intel.com,
        syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com
References: <20230217025615.1595558-1-mawupeng1@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230217025615.1595558-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 18:56, Wupeng Ma wrote:
> dup_mm
>   dup_mmap
>     copy_page_range
>       copy_p4d_range
>         copy_pud_range
>           copy_pmd_range
>             pmd_alloc
>               __pmd_alloc
>                 pmd_alloc_one
>                   page = alloc_pages(gfp, 0);
>                     if (!page)
>                       return NULL;
>     mmput
>         exit_mmap
>           unmap_vmas
>             unmap_single_vma
>               untrack_pfn
>                 follow_phys
>                   WARN_ON_ONCE(1);

What's the point of that warning in the first place?  I can certainly
imagine follow_phys() failing for sparse mappings, for instance.  Is
there some requirement that VM_PFNMAP can't be sparse?
