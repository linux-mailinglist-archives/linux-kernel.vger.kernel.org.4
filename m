Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADA738D94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFURth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFURtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:49:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D21718
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369774; x=1718905774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I08I0tFez5dKhmqeca820CtuAFLZd/1a4u1jpCZwwdI=;
  b=DqgwkkVDS+dRXP3TQqwa5oZhuBlWzkondIvEtjdOzTjrCEjMUaGn+vZN
   ZbSOo8BUbnqHuOqdN/TM9FhlHhjoGtGRLvMjM7eC/Xls7GpQ6vd//GYVY
   d/ZtShKUk1grGcZL8cmdRMQ9uLzOop4hzIXYfGtuxzphvCTA513dNa3DW
   k9hOoJrDEUVifkVMwD5Gjsj7HDGHet3bqoopbZXIqzmo7A+dPp+C8dPvp
   +5dFq76TijcRJJasAsp7CXXLfcAU8ggMUn172WEAQRXrwx2E81kt4/YVs
   aAM9HJvJoVryq97UB1p6aC6FnLtGwvbKoePTnKsrQVDjEn0OT8sMYdoiy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389819222"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389819222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="708807532"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="708807532"
Received: from rmathew-mobl2.amr.corp.intel.com (HELO [10.212.134.235]) ([10.212.134.235])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:49:32 -0700
Message-ID: <22bba771-f10b-8624-1874-5eb747e798dd@intel.com>
Date:   Wed, 21 Jun 2023 10:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in
 numa_meminfo_cover_memory()
Content-Language: en-US
To:     Liam Ni <zhiguangni01@gmail.com>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, rppt@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230615142016.419570-1-zhiguangni01@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230615142016.419570-1-zhiguangni01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 07:20, Liam Ni wrote:
> In a previous implementation,The ram page is calculated
> by counting the number of holes,
> however,the number of ram pages is calculated during hole calculation.
> Therefore,we can directly calculate the amount of ram pages.

What problem does this patch solve?
