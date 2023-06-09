Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9372A11D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFIRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjFIRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:19:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93472C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686331188; x=1717867188;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sLL1ExYky3YPxQPfY55OOknhjNzKxT1NpucHwkVjiD8=;
  b=oKVj3sbl4VaiD5Q7H5JApzSrVnWtUoT12dd3rvgoehs0E0EjiTcmpcdt
   VvR9O5FB8n6Gt4MTijrmyoLqhqCc8V5KVIeddJxK4mXJFEiVHOM++ShAz
   TX01itIRXtD+7tVYlU7ZYSiMHew93zKf/Gr3n8pYWRxUWMLbzDTnA2fnb
   BtdwFIRK/DsXpFsKg/BKmBhFwB1eCZ2fCUdFkQ1cD+A0h0y5LWAk6JgAd
   qUXa72XncOGAV2+mtlP6xo9cNVc8wveyQPy4VJqmKtTHKA8neE3RNvBeJ
   XLbN8bZiJUhTWFV+91aMKKQ8MmeE7UgcpdeF/K7eWj3y6F0hfp+E/1NYl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423527142"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="423527142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="660826666"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="660826666"
Received: from unknown (HELO localhost) ([10.237.72.184])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 10:19:44 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] x86/sev: Move sev_setup_arch() to mem_encrypt.c
In-Reply-To: <ZHZGkulyli8MvXRR@aschofie-mobl2>
References: <20230530121728.28854-1-alexander.shishkin@linux.intel.com>
 <ZHZGkulyli8MvXRR@aschofie-mobl2>
Date:   Fri, 09 Jun 2023 20:19:43 +0300
Message-ID: <873530zh74.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield <alison.schofield@intel.com> writes:

> On Tue, May 30, 2023 at 03:17:28PM +0300, Alexander Shishkin wrote:
>> Since commit 4d96f9109109b ("x86/sev: Replace occurrences of
>> sev_active() with cc_platform_has()"), the SWIOTLB bounce buffer size
>> adjustment and restricted virtio memory setting also inadvertently apply
>> to TDX, which just happens to be what we want.
>
> Hi Alexander,

Hi Alison,

> Can you offer more context on how this inadvertently applies?

Yes, the code uses cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) condition
for setting the bounce buffer size and enabling restricted virtio
memory, which is also true for TDX. I've added a bit about this to v2
[0].

> One bit below...
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/swiotlb.h>
>>  #include <linux/cc_platform.h>
>>  #include <linux/mem_encrypt.h>
>> +#include <linux/virtio_anchor.h>
>
> It looks like this #include can be removed from mem_encrypt_amd.c 

Good catch! This is also addressed in v2.

[0] https://lore.kernel.org/lkml/20230609171214.31846-1-alexander.shishkin@linux.intel.com/

Thanks,
--
Alex
