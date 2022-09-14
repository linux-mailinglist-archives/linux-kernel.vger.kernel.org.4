Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD35D5B9052
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiINV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINV6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:58:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4916BCC5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663192725; x=1694728725;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QNg8wCNjqUDjTWu32yFBNgDL6CzIfFQmnJ8u1wkscK8=;
  b=PIb34rcgrOG7aJHBKDqyMlWLhrFz7EfqOs9cC/5wGYtpIZHp31iZ/btD
   rhsxahYuDl6BF8uqllXNEPuMV7wWFHb51CO4LY2OpDtsXVxYu7JDl01nb
   yDc+Bo0NT+6Crpg9ebthfw04akchN7fi9GsJX4WeE++HouCNq1ZSA+kTt
   rLYJIw5TY8XKXXEh5+VmquOLZ6jcBK7IDA7Jdmv3RuBNZl+GSC6YnO3uY
   S00a/3bGxDF8LYPHke3XqJkwtWTzVOBqSN3Xje6CVq6aZXkSxWUuNK6NN
   Ab3vuMX1oK/KlTIMxfJ0G1yRb90OgaBerwV8Ib2X5rPX1QH3CGokxuVlz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296140875"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="296140875"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:58:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="612660507"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.26.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:58:45 -0700
Message-ID: <dd0faa6599c4503b2cdcb96234ec6b4f49a9a512.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/5] sched/fair: Ignore SIS_UTIL when has idle core
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 14:58:44 -0700
In-Reply-To: <20220909055304.25171-2-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
         <20220909055304.25171-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
> When SIS_UTIL is enabled, SIS domain scan will be skipped if the
> LLC is overloaded even the has_idle_core hint is true. Since idle
> load balancing is triggered at tick boundary, the idle cores can
> stay cold for the whole tick period wasting time meanwhile some
> of other cpus might be overloaded.
> 
> Give it a chance to scan for idle cores if the hint implies a
> worthy effort.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> 

