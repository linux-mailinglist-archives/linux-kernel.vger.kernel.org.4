Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2813743E55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF3PNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjF3PNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:13:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1847B2728
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688137984; x=1719673984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C3J4cmJDKoEAB7b2b4iKIntxZH2Y9GInYTplY/D4tbw=;
  b=nvolEt3+c9QCr1c6meB4G5c07hhDMXqlsP+ddZUZPxWK87HzZgDBgPcx
   kkJnqR5A1YjYe4T00c0DlUCi/sdQc+sKcom22FHvTfGYy7168seCB1P/W
   BWKy4dhw8KTovOIUP5P11c3rYhZu4D6Jiof77CrgfJuPf18iToqWna4Z7
   hhvKpamjI0qC2WzCw/JeUCP3s7rysLRp91rqHOTNmzu949GHJRxBTXFhH
   cnAfOof7S4uGxxM7q+gjYamcVhYBxcrk6rpqZMlw+FgiidmWf7RvvaxlO
   GrBZ3dKYq1WAy7y+z3HqeSI1sSIUeuFIzXOFYnLTF7rC2tBr2xEktXYms
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="341999662"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="341999662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 08:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="807802479"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="807802479"
Received: from amuruge1-mobl.amr.corp.intel.com (HELO [10.252.133.96]) ([10.252.133.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 08:13:02 -0700
Message-ID: <be68956c-d0d7-cede-1f09-575b98c3ea5d@intel.com>
Date:   Fri, 30 Jun 2023 08:13:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/aperfmperf: Fix the fallback condition in
 arch_freq_get_on_cpu()
Content-Language: en-US
To:     Keyon Jie <yang.jie@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>
References: <20230626193601.9169-1-yang.jie@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230626193601.9169-1-yang.jie@linux.intel.com>
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

On 6/26/23 12:36, Keyon Jie wrote:
>>From the commit f3eca381bd49 on, the fallback condition about the 'the
> last update was too long' have been comparing ticks and milliseconds by
> mistake, which leads to that the condition is met and the fallback
> method is used frequently.

Could you do me a favor and walk me through the units of the variables
that you're talking about?  What is in ticks and what is in milliseconds?
