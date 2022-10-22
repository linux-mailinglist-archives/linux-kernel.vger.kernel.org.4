Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8086082FF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJVA4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJVA4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:56:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E48290E31
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666400163; x=1697936163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VbvVfIkXddcH14JhonMhDC3Kd+/OvqiI4ShilOGfdAg=;
  b=jZlANukD/2xVJBceDLKg06NKhlKo1J6fUX2te1YEDBWxkT+b0RCns5m6
   UYWNy8ryghJpRNz/ltShmZFPCBg/4L30uAQ7rnO04zbbViA086XU4bk7+
   lhurbgj7xjE93NlYZbRc4n1wbGQ7uSY9xPDV9uPz01yLZDEAIzkI+Zakx
   AXeFy3W8SPgkALL4xwKOfG/kkG1iMK0jSo1s6vVF20BPlrYR3MLSuTFoL
   j60+SrBZkuW/MzPVi7ULPST4dEOriE/E/eXuM/cPbZSjY9VFp1ppV2QR2
   2mbOaYUNAIACZh4TbpO/3GJhaSt0daJ49eErmM8TJ/hv2iHiwZuY+E6im
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308234068"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308234068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:56:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="630696236"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="630696236"
Received: from thnguy1-mobl2.amr.corp.intel.com (HELO [10.209.91.210]) ([10.209.91.210])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:56:02 -0700
Message-ID: <dbc0ad82-28dc-a7c5-8973-4ddae671a2ae@intel.com>
Date:   Fri, 21 Oct 2022 17:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip: x86/mm] x86/mm: Randomize per-cpu entry area
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>
Cc:     Seth Jenkins <sethjenkins@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022000010.1802-1-hdanton@sina.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221022000010.1802-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 17:00, Hillf Danton wrote:
>> -#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
>> +#ifdef CONFIG_X86_32
>> +#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU +		\
>> +					 (CPU_ENTRY_AREA_SIZE * NR_CPUS) -	\
>> +					 CPU_ENTRY_AREA_BASE
> My vi editor finds un-paired bracket here.
> Feel free to ignore it if nothing hurt.

Thanks for finding that!  Looks like Peter and I need to dust off our
32-bit .configs!

I just fixed the issue and pushed a new commit out to tip/x86/mm.
