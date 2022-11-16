Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2462B762
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiKPKNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiKPKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA42A240
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668593515; x=1700129515;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=GvNypQu57pyaZ739Rd5mWa7coT5VRJmIkuNoPDwdLRU=;
  b=ECk366PG2bHfSrhOBj3Fn6qGQlR8kfGkkrS/2tYgP/qDFsG57+8dKAeV
   S8Xu9XxKY/r7yiJlWkpsAIRrT+6rD3AoZ5YiG2IpqLv9xa+NfuNpd9PG8
   NURskrQqaj7KPmnJEE1NPBsMLs6dkmAhoJIfekfIFeGy0djHzABMAWUQu
   tHbaC4oKgCsrNUBLqo2jBtQYI1Y86Vxdzp4YYq9SJrHU31tOEQOTUu2c3
   n0UzqfGKAmMt5UvwAOmd9tkNutDV1aUztfD/0Mz8+xSA6plNijjfSNCfx
   AunpDEhwsi6e6NlyWawY0Ppb8BE0RvCgymQFd23knsjNDeWgCvj6frdoR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374640198"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374640198"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:08:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633576261"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633576261"
Received: from dariofax-mobl.amr.corp.intel.com (HELO localhost) ([10.252.59.5])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:08:30 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        DRI <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] How is the progress for removing
 flush_scheduled_work() callers?
In-Reply-To: <e170edc2-e5b9-4c8b-4ed3-7e2d7a2850dc@I-love.SAKURA.ne.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <e170edc2-e5b9-4c8b-4ed3-7e2d7a2850dc@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Nov 2022 12:08:27 +0200
Message-ID: <877czv2ov8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Nov 2022, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> We are on the way for removing all flush_scheduled_work() callers from
> the kernel, and there are only 4 callers remaining as of linux-20221104.
>
>   drivers/gpu/drm/i915/display/intel_display.c:8997:      flush_scheduled_work();

Thanks for the reminder, I've pinged folks to get someone working on
this. We do schedule quite a bunch of work, so it's not immediately
obvious (at least to me) what exactly needs flushing.

https://gitlab.freedesktop.org/drm/intel/-/issues/7546

>   drivers/gpu/drm/i915/gt/selftest_execlists.c:88:        flush_scheduled_work();

Removed by commit 7d33fd02dd94 ("drm/i915/selftests: Remove
flush_scheduled_work() from live_execlists") in drm-next.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
