Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5366066EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJTRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJTRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:19:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F221E3ED5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666286341; x=1697822341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qiepO4q83dpntJ7mlNaok9XWrDJes8Gjp55+tdgdXpo=;
  b=GZHr20Z87buwvbZ5ZRLVTFfGSUVg9zFaIplw3Rjh+sXvYjnpOrMtTjPB
   oMc2ugp0sB+H7RKQJer9JVQmr4s1S5MlFkk6N1FTd6NCVwEcwW26GCOX7
   HRRx1DXiF2pgpo5v9lRPyUEI3mMj7PCZD8RT7FtgyZqZWuDPeDMV7dGio
   VtsbZMtLodap+z8MvNcKtDFjZHlw0JQVFZBe4wEq6ReZr1+5DGVZ515oD
   LaHcFPsN0+RR444qpSNW8HSrlNlGmiVLuvOUOyAclzDL9xGOEidN/L8Td
   s5kuiVDDOqRdWCQHd9N/EkY4hS3AxtIMCETCkky/svNe7HuRpDbt/xcHT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290085762"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="290085762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:19:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875132653"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="875132653"
Received: from amancuso-mobl.amr.corp.intel.com (HELO [10.209.121.211]) ([10.209.121.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:18:59 -0700
Message-ID: <3d65c4cc-c002-9e6a-c6ea-fd776968a178@intel.com>
Date:   Thu, 20 Oct 2022 10:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] Add hardcoded crystal clock for KabyLake
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Rishabh Agrawal <rishabhagr@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        drake@endlessm.com, rafael.j.wysocki@intel.com, mingo@redhat.com,
        tglx@linutronix.de, vaibhav.shankar@intel.com,
        biernacki@google.com, zwisler@google.com, mattedavis@google.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
 <Y1GBtjcetPpTq0V3@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y1GBtjcetPpTq0V3@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 10:13, Peter Zijlstra wrote:
> And why, pray *WHY* can't Intel simply write the correct information in
> CPUID leaf 15h. I mean, they defined the leaf, might as well use it, no?

Is the data that's in the leaf just wrong?  Doesn't that mean that the
CPUID leaf on these models is violating the architecture contract?  That
sounds like something that deserves an erratum.

Is there a documented erratum?
