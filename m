Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D043E65DC89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjADTHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjADTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:07:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA41B9E4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672859241; x=1704395241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XxNNflySTkyGkLpVJYRC4xsGOhNPakSQIFM+vaB9YCQ=;
  b=WxyhnPkdMi9a5XIoP9eD8TRfKu7L+ytgVoz+5hHWnC5liWdIE24L+wO6
   aIjcDMT0nDHH4geSq1gQUKniZZkiC4eTTMXhLG665HYJops/c7RIHUI5K
   /ZYBu3pcItHbFnxJC/lDCWhF/qhf8soakOJgwSj+NvkiX5/W0FX6Aavyo
   hnsqR5OrrlGgHFCdhoTwcyPOwT7ux3N0rTDNs5KErrToOKExpncLsOqUM
   JIogjo1+1PSjs8FC1QR4cPPjS+PITtF04L0py2hoaG+eTrYFtIc90u4Cs
   GP9pCmIg9LuSvItZd7M6GxG8Fyvkj50V5BMnlqUnx4XFcwx0Gr5xvgUt8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386453369"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="386453369"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:07:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="743959675"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="743959675"
Received: from cheungbr-mobl.amr.corp.intel.com (HELO [10.209.91.155]) ([10.209.91.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:07:15 -0800
Message-ID: <c093d5c7-a5c9-4dce-925b-78a27a70b4b9@intel.com>
Date:   Wed, 4 Jan 2023 11:07:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv13 01/16] x86: Allow atomic MM_CONTEXT flags setting
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221227030829.12508-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 19:08, Kirill A. Shutemov wrote:
> So far there's no need in atomic setting of MM context flags in
> mm_context_t::flags. The flags set early in exec and never change
> after that.
> 
> LAM enabling requires atomic flag setting.

Could you elaborate on this a little more?


