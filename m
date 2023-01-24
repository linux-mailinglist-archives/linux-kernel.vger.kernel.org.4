Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506B679D84
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjAXPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjAXPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:31:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C2213A;
        Tue, 24 Jan 2023 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674574268; x=1706110268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYBqnbp7RgPa9rBpiZ++vb4CG6oJaSkh3E7AYQvH3A4=;
  b=Gdn2Vwxr7uhMjBKoWAM2XD5rhtxs7tXIc414MJupihAX87kxDnkDTQf0
   ZLN56a3Ns52JiXmoACOIeR4sJE3rqDn31oNjVNjEP0X7AP8cOadBtifzy
   yJhIVK/blCzr9e+ceHm5GoGr+RRvJNQZjfuhyIY1yIhG5hpOsLJ9N7OAD
   9CBv+KI3PYSOQnBYSQDMszZiOpHgH8JBYLwLlfm6CssQqUjkKgIwMVViM
   0oR0nClAWc9I61SzkJRa/qmi4vYiIUPoVCsfQP+fNAE8U+stt3t3MLK2N
   lAtfdIlOfJaECO/aNqFmzx7suwTtlRCQuKfrbID94ySNdfTLZ45TZJcUe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="327575987"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="327575987"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770356043"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="770356043"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2023 07:31:03 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8254B580B9A;
        Tue, 24 Jan 2023 07:31:01 -0800 (PST)
Message-ID: <8eda340a-8c5d-a801-54eb-501c44a68d89@linux.intel.com>
Date:   Tue, 24 Jan 2023 10:31:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
 <Y8rQJf3ki8a1aRjW@google.com>
 <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
 <Y8r604tRexxWlF8F@google.com>
 <e161b7c0-f0be-23c8-9a25-002260c2a085@linux.intel.com>
 <67facb87-f835-abcd-3d1b-527531b26e52@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <67facb87-f835-abcd-3d1b-527531b26e52@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-23 8:04 p.m., Andi Kleen wrote:
> 
>> If I understand correct, the workaround in KVM is to add a white/black
>> list to filter the events. I think we can do the same thing for the
>> hybrid machine for now.
>> https://lore.kernel.org/lkml/CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com/
> 
> 
> This will make everyone who actually wants to use the PMU sad.

Yes, but we still have all the architecture events work. I think it
should be good enough as a short-term solution, when the hybrid is not
completely supported in KVM.
> 
> It's reasonable if the vCPUs are not bound, but if they are bound it
> would be better to expose it with a suitable CPUID for the types.
> 

Yes, and also the CPUID leaf 0x23H support to enumerate the PMU features
of each types.


Thanks,
Kan

