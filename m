Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA33E65DD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjADT5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjADT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:57:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A231C5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672862229; x=1704398229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2zTknYpDePyCGdRxM21xmth1IkLNDZuNNy0B5rcking=;
  b=ffRSoPZKR/HJvPKuE31mDJvfnpmv+05w6M7G4AI0HA22BTa5aLdpihIA
   yRLmc6AfwT3kswLShv48xo/Xs8JdH7SLl/n3LcZ/SxdC4/unFhsrMtXul
   FwFOStgLWR4HjOWRYzsKyNREn6NS69XFicQEjMEBAeC2aekp8GRgejo46
   AnsRbSgZ2D+6ejiiFeckz2eNOiiWeJBxcGueXCkTp8HCItFFaNH8PsD2F
   6vze9WBm297KwabGYqZylLcydg20wUuK9yLLs8YI48odBe/Nc9x9RanSx
   1IHCFLFM7mL0H3E+9ThesR2PII4GnR8nwMOzYeuLaZpmPrevnmB+sHl3j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="302398677"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="302398677"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="685855468"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="685855468"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2023 11:57:08 -0800
Received: from [10.252.212.169] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 48196580A8B;
        Wed,  4 Jan 2023 11:57:07 -0800 (PST)
Message-ID: <e6445b3e-302e-e25f-ea3c-b6c5dbfdc743@linux.intel.com>
Date:   Wed, 4 Jan 2023 14:57:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] Fix UPI uncore issue on SPR
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org
References: <20221129191023.936738-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221129191023.936738-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Happy new year!

Gentle Ping. Please let me know if you have any comments on the patch set.

Thanks,
Kan

On 2022-11-29 2:10 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The discovery table of UPI on SPR MCC is broken. The patch series is
> to mitigate the issue by providing a hardcode pre-defined table.
> 
> The broken discovery table can trigger a kernel warning message, which
> is overkilled. The patch series also refine the error handling code.
> 
> Kan Liang (5):
>   perf/x86/uncore: Factor out uncore_device_to_die()
>   perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
>   perf/x86/uncore: Ignore broken units in discovery table
>   perf/x86/uncore: Add a quirk for UPI on SPR
>   perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
> 
>  arch/x86/events/intel/uncore.c           |  34 ++++-
>  arch/x86/events/intel/uncore.h           |   4 +
>  arch/x86/events/intel/uncore_discovery.c |  60 ++++++---
>  arch/x86/events/intel/uncore_discovery.h |  14 +-
>  arch/x86/events/intel/uncore_snbep.c     | 158 ++++++++++++++++++-----
>  5 files changed, 210 insertions(+), 60 deletions(-)
> 
