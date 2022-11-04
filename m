Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FED619A48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKDOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiKDOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:40:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87132BB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667572699; x=1699108699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BDW2rlh59H9OsdW2Tw7Cz4tXSOMyT1tD39twyGaGg0=;
  b=KT20S8E63IuuPGyCAsGrT9NJHHiQFEEPmMbCR6U9zQlMvCYyViG0ZxTA
   SENoSCh1NTUCyUJevQFcIJ+lCW8CWHgzlkN3653mcKa3alzUr5d+VGNam
   WcAVyu5qUbWlNZhVB+SE1OKjF+B6lSLs1zcOvLpwObv4EIeV5NRrOLP8T
   6hy9IJeksgt4IbGM4tb25jApbyzXnM6+5YAMWBDNB12N4lP8jY20SyQQr
   4pu4/s6ndiRsLlaqvzCk0tmMY339m54prMvTGZVj+O9+9+4yBswEJoQbk
   o8mnh3uc/B1vcCzQUgkni3pAMohwfNbl/xiqOLQMmQI5piSQgr025ImaW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="309969285"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="309969285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:38:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668373765"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="668373765"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:38:18 -0700
Message-ID: <1c9a1b86-efef-fa56-4451-ac3348b678bf@intel.com>
Date:   Fri, 4 Nov 2022 07:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v2 4/5] x86/crash: make the page that stores the LUKS volume
 key inaccessible
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221104113000.487098-1-coxu@redhat.com>
 <20221104113000.487098-5-coxu@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104113000.487098-5-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 04:29, Coiby Xu wrote:
> +	if (kexec_crash_image->luks_volume_key_addr) {
> +		start = kexec_crash_image->luks_volume_key_addr;
> +		end = start + kexec_crash_image->luks_volume_key_sz - 1;
> +		page = pfn_to_page(start >> PAGE_SHIFT);
> +		nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
> +		set_memory_np((unsigned long)page_address(page), nr_pages);
> +	}

Why does this go pfn -> page -> vaddr?  What good does having the page
do?  Can you just do phys_to_virt() on the start address?  Maybe:

 	start_paddr = kexec_crash_image->luks_volume_key_addr;
 	end_paddr   = start_paddr + kexec_crash_image->luks_volume_key_sz - 1;
 	nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/
PAGE_SIZE;
 	set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);

Also, if you resend this, please just cc the x86 folks on the series.
The other patches and cover letter have desperately needed context
around this.
