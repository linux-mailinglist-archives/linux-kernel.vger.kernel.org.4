Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3836FE46E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjEJTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEJTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:17:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4485255
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683746251; x=1715282251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75dGGtHMQ8FdwfGHnsegDYBoFOE0eghlGa3Ibvz1Xa8=;
  b=V1mZHeT5fzfIsnIGE0CfZ0Cq0gBzlU5I6ypl6U8sJdUAeXXdEj48mkfH
   Tss7YBL5X+Mk0uvqUUO3/AmK1rD98y5Qduzhes5Ubt3qVPBXeyh0+/T1Q
   puuAmDeQvJi7IFt8ISFKbgWj96pRECs/QTaSx4EEkf6JpEn0vgoPRZLOb
   PZLskcTPJwTtPrXVXNlELVr47Uh8w4kiLQ3vPbVJ4Ya8cKqjX75DiWAC1
   U4QPnDf4WBdR0jmQq+dQl/rjCywUh15ZghL/+pzialFMZMsbXWJekyBFt
   k5sB9cdwZW9iRSGKMDDj7llOyH/ctt/nyJJmFdbNQQTlqcn8KtGZCBtaI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="349134518"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="349134518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 12:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="945812897"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="945812897"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 10 May 2023 12:17:30 -0700
Date:   Wed, 10 May 2023 12:20:29 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20230510192029.GB18514@ranerica-svr.sc.intel.com>
References: <20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 05:19:54PM -0700, Ricardo Neri wrote:
> Hi,
> 
> This v2 of now a patchset to set the number of cache leaves independently
> for each CPU. v1 can be found here [1].
> 
> These are the changes since v2:
>   * Dave Hansen, suggested to use the existing per-CPU ci_cpu_cacheinfo
>     variable. Now the global variable num_cache_leaves became useless.
>   * While here, I noticed that init_cache_level() also became useless:
>     x86 does not need ci_cpu_cacheinfo::num_levels.
> 
> These patches apply cleanly on top of the master branch of the tip tree.

FYI, I see a NULL pointer dereference when I apply this patchset on top of
v6.4-rc1. I started a discussion here[1].

[1]. https://lore.kernel.org/all/20230510191207.GA18514@ranerica-svr.sc.intel.com/
