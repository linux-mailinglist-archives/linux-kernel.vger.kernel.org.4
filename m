Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D481F705042
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjEPOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjEPOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:12:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BB1FEB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684246356; x=1715782356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p//Oi8KFWV3p8tmVzK6hfruBSMZpioVqrybuO9EZXrg=;
  b=DCORlTABvjmxNvwjaD1Fr2jgsbU1MvxWZRvL4n4O1Ab0Mhe/o1s8Y42v
   kM9LDsWenPASumdBGS4Ws0vcT+sxRLkGtMmlJcRNGJuYP3plUX5ZtWh7i
   3oJHUicSi7iRPVVpce/OxZngu1YFDeYBLMK6Y9mPZu0GyUqH7pKc5g4jd
   14gWtoGQbn5c8Sa2glfbEaINylYlzvE4kcTviwLcn89xHKCFjzcq9+jHR
   Jm9VqIlvSQUTbXXRvAZ8zHul17B/MW5Sguup6lNUQsW4ayWC+pYwLJBuh
   piZqwH1QzyESQYNVZeQYSZT9K3o4ch157fkHSG6MfXkZ0P0mge7fui3xn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331849541"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331849541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 07:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="813446641"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="813446641"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 07:12:35 -0700
Message-ID: <56ea846e-bce8-2508-e485-1dada8c39643@intel.com>
Date:   Tue, 16 May 2023 07:12:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, tglx@linutronix.de
Cc:     Rong Tao <rongtao@cestc.cn>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 23:52, Rong Tao wrote:
> Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instruction
> rdtsc can achieve a 40% performance improvement with only a small loss of
> precision.

I think the minimum that can be done in a changelog like this is to
figure out _why_ a RDTSCP was in use.  There are a ton of things that
can make the kernel go faster, but not all of them are a good idea.

I assume that the folks that wrote this had good reason for not using
plain RSTSC.  What were those reasons?
