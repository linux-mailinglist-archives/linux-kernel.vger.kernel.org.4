Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AB6B6B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCLUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCLUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:50:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31C37F09
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678654216; x=1710190216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+IzZBIfnJCzKhgaZ0nfxa7IS9RZv4YliZ0tupFQJE4=;
  b=Ob7zzty5b10GlvB8Y1LuU2MczI2pP/uF3pFIMx4GUdVa8gg7oqtnEKKZ
   IxhshU5OaPWB1t5cObOWYJnP1zAFEvTiPpbkwaHLOdxizrc1/iyeM/mpW
   kyfDcqwNRnAYHr/j1NHzhSfFyENTSBd8C2aNhTn6YK1zbIbfwBf15J8QP
   ZC3pOV0b9EOkeJWXx2tngjF65AK5V8TbwBmL/CAJERbmncAcDnzCk2VM1
   LulpuDApVvBtviPTscgfMGnhZyZR9bh6TFn+eVnygT6v5W0gJUneHrz2X
   6VPUx79AYleqp8Xs8m4InZ403DSi0KDfo/Z9CUEtHoUe7vaxN2PCLOlgL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="364681274"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="364681274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 13:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="671677472"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671677472"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.251.15.107]) ([10.251.15.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 13:50:16 -0700
Message-ID: <4971d93b-6d06-5734-d1ed-8c09501e22e2@linux.intel.com>
Date:   Sun, 12 Mar 2023 13:50:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
 <8dc13cf0-42f4-9ef1-1e22-de58ff743a0d@linux.intel.com>
 <CANDhNCrLTBB6UaSxUhivGKv+ugnMYtCqDSDiz7o-DnE2MkC8jA@mail.gmail.com>
 <5dc37d95-493b-cb2a-1cc7-4ea80dc22740@linux.intel.com>
 <CANDhNCoj6SseKe=7La9YqRzvBdhO5zetfDKzOqpue4J0MtyVaA@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CANDhNCoj6SseKe=7La9YqRzvBdhO5zetfDKzOqpue4J0MtyVaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ersion. So the kernel internal mul/shift information has to be exposed.
> Ugh. Well, I think perf may have made a bad API choice here, so I'm
> still going to push back on exposting timekeeping internals to
> userland.

It's not about the perf ABI.

The perf mmap mult/offset if for PT, which always has raw TSCs.

Without it the PT decoder couldn't supply wall clock time.

-Andi

