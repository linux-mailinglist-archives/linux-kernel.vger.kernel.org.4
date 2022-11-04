Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0E619AED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiKDPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiKDPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:05:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17EBE0E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667574296; x=1699110296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RaXeA3lCHqq/I4+SahQVZ4hXUivbF7Ar5S6jFlTfNpc=;
  b=foU/OmiF/ylj4r6cJDuV3TjNcH0my2TsfnDMqj927jHZ2U4WrKpXU3+4
   DdFea6du2SiOYR7bW/a0vVo+wkjhrwlY+H2jxHKEUuBuWQ/Aor0oW2IR9
   eXIEqhvK6bwou/vtRpAAH6lt0fCFCqfY2f9x0KqQJX4uGc5iLjADS4zWH
   4eQxjA1LKUuSE1hC1XsXGuXbPBAemE4wImKv6Wq9i23lBvMKWAOllJMi6
   ByYBq3aigrLaENHb+/KFQ9si6aaRo3t9bW2IhFBe/KYjFNNxGwHNOWU4O
   /P1EoskOUMuuIi1gyoYB/WDrxhqgadqJcrMP4SUyfCQfso2wMRIKUi0R6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311106846"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="311106846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:04:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="777739712"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="777739712"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:04:54 -0700
Message-ID: <ad9ef7ad-f01b-a3f9-2d30-5cd405d26b2c@intel.com>
Date:   Fri, 4 Nov 2022 08:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 4/5] x86: remove X86_FEATURE_XENPV usage in
 setup_cpu_entry_area()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221104072701.20283-1-jgross@suse.com>
 <20221104072701.20283-5-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104072701.20283-5-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 00:27, Juergen Gross wrote:
> Testing of X86_FEATURE_XENPV in setup_cpu_entry_area() can be removed,
> as this code path is 32-bit only, and Xen PV guests are not supporting
> 32-bit mode.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
