Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF96745CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjASWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjASWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:20:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44722A11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674165830; x=1705701830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F0xqbEr3PuGUdUHAmGE6wA96qhwe45z1cUhXP8pY/T0=;
  b=S9tzwsxQVzNudYsgNfHE0j1NtOWyBrlplxP5/xNGMnDMeZcVex9cPKS8
   4pgW2Y9SFjhhMlNUVGdm6pyp/pUQaojucm2qPyCEa48VYWIB1iO72fXUR
   CYDgikNYFCt+TebkQQGM4/JnrCtuHEnTczcTbdhkENvFI7nH5fgtmqGDd
   u/HVjgzs+nAT/Ww7oNe4wPCCA0VOpYfTYg/wo43KKTr1hf+rEBagZDOkl
   pjPSADO8hx1pUraBZLxP92shHBwWn+cR6VcR4k/pg//f2Gf5/Ni2bEGNB
   9OkjXLndEHdRmm83T/UB4BTz0/BdmLjdF7tjRVCUWxHtVkBCYcG0F/C1q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389956201"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="389956201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610223641"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="610223641"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 14:03:40 -0800
Received: from [10.209.115.195] (kliang2-mobl1.ccr.corp.intel.com [10.209.115.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07526580AFF;
        Thu, 19 Jan 2023 14:03:38 -0800 (PST)
Message-ID: <81c169dd-1b8a-b324-c845-4edb97295884@linux.intel.com>
Date:   Thu, 19 Jan 2023 17:03:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 0/5] Fix UPI uncore issue on SPR
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Michael Petlan <mpetlan@redhat.com>
References: <20230112200105.733466-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230112200105.733466-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter & Ingo,

Gentle Ping. Please let me know if you have any comments on the patch set.

Thanks
Kan

On 2023-01-12 3:01 p.m., kan.liang@linux.intel.com wrote:
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
