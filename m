Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39530690C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBIPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBIPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:01:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58439A0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675954913; x=1707490913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/+xWAVVPl6YOh/i5Jh/m3nRXHie4D7DLrU2F06Zxyyg=;
  b=c5vAAKmufmBhEphQI3f/Z937JGRT3Ta6SMzzm5s1gZHTpPNbet9zhtjh
   h9+37EVZ5y+M6ZBSObT8ACrTl077QAz2bdPvMV3P0Jgb72So7sOlKdr3k
   nO0m3nmGsOuwUrVrH0gTXhF6sz5jArccqB8Ec3YEilNjs04huPdfae/va
   1wHqXAv+0Bwt4/duB2qXtqMwdpEGS5ugeGEH0m83VoBpeSq7KOQFHZa3h
   pHReLzjErjIzamRaK1BeMlTidcSbGFOcFmrzBGSZucxBxjpcF0/W45te1
   AJa7UN7MprwQmkamyYMYrA25GwL10uxlCTaryCAsVTaX/qQZi+gy5FqIi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331420885"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="331420885"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 06:28:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="791610358"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="791610358"
Received: from davidsan-mobl3.amr.corp.intel.com (HELO [10.209.22.211]) ([10.209.22.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 06:28:09 -0800
Message-ID: <9848226e-2574-b8e0-4fb4-316957f57fb5@intel.com>
Date:   Thu, 9 Feb 2023 06:28:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
 <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
 <369bef08-92cc-9b55-823f-1fe780532967@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <369bef08-92cc-9b55-823f-1fe780532967@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 22:04, Bharata B Rao wrote:
>> First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
>> the PEBS records.  They had to be translated back to host addresses to
>> be usable.  That was extra expensive.
> Just to be clear, I am using IBS in host only and it can give both virtual
> and physical address.

Could you talk a little bit about how IBS might get used for NUMA
balancing guest memory?

