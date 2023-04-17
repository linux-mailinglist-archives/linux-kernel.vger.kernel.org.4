Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2932D6E4A22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDQNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjDQNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:41:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16C72A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681738868; x=1713274868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ioEVi0PkJBP6SHdN0OIps0cag5EDrbnKnbBrHndp9Q=;
  b=OPmgP+8b+hYA8kO2MetnpZCJvslK4nmVtYGDHRKXyMpv5CD8Pjo2LjAa
   oCz5SoGZJ8usA3ng47EqcWjljATbLWSqp2gRLiE0LFE+fPC4Yh5xO8L3c
   XY2yDGYbNLfbFYThW8uzGaQtIaDW6rW3QKkU46ksrJU8Cn5FqPKLRKdtI
   chX3GD2o7tQEyrWSOA1hTd4RoAIiq8htKF3Lc8UsWsWDOtHwDzEYkV6rB
   630Y6CXnNXxDF46k64itLJpZzzV3iCL+vjI4gbGWuZZJmqRa9ngR80s1n
   lJBaEw+oLz6LxcmehEh3iFzGxIa0S9CeBOiSA6vjHUG04P1lYO83fWPjV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="329061848"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="329061848"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 06:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="759952618"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="759952618"
Received: from macharje-mobl.amr.corp.intel.com (HELO [10.209.71.14]) ([10.209.71.14])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 06:41:06 -0700
Message-ID: <a7bf05bf-1253-ef9e-bbe0-47bb391ebbb4@linux.intel.com>
Date:   Mon, 17 Apr 2023 06:41:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
References: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
 <20230414220106.GC778423@hirez.programming.kicks-ass.net>
 <d53d4df7-d0b8-2fbc-4912-f89686b5d931@linux.intel.com>
 <20230417115516.GM83892@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20230417115516.GM83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 4:55 AM, Peter Zijlstra wrote:
>
>> to create groups. I thought one of the basic ideas of perf was to be able to
>> abstract those things.
> Yeah, the abstraction at hand is a group.

Okay then if we add perf record metrics and want to support this feature 
we'll need to replicate

the kernel scheduler in the user tools

-Andi


