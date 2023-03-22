Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170196C5131
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCVQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:49:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32439BB5;
        Wed, 22 Mar 2023 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679503790; x=1711039790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PmlDxcsDFapOGbfdlWh2GWhkkqitl+2PBEpJ4f3MM/Y=;
  b=aQrtXiaZV40d30HJtF8PITqUnrEyqWKf6bnSZTC7DlBsiUG7lb4bXehi
   svWmqgp0i5+AMBP+8nBuosYwwxJcGaaZvHjYx4v4ajetq+jeddsWQhIGe
   AEsCF+ukiXVRMtZ7bfNZy8RG0bneSJcI+cft52PTs9Qjjdabb8kds3fV2
   lMsNk74Cg25XEtId4bQ4mltblwhTr1A/vQzBvg+aNOIGNdSRerjXcm9yf
   gA5cMx9xaMfPA7gzh9VyiSzbAeBZK9ZW9LXRszbL2lB9Up1pzQPF4VXb6
   NiwSDJ8ZEjlYjMaTBIlr8GQPGeTRs9KaFszEtk5WyDiTS+xvq7jkGOUmN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="404159809"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="404159809"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="1011437716"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="1011437716"
Received: from mtfreder-mobl1.amr.corp.intel.com (HELO [10.209.35.23]) ([10.209.35.23])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:49:48 -0700
Message-ID: <d0bf2342-4f1c-bf2f-b912-a4558288a3d0@intel.com>
Date:   Wed, 22 Mar 2023 09:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <ZBneELQuakjva1xa@casper.infradead.org>
 <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
 <ZBsw9lRbJU4c2wLD@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZBsw9lRbJU4c2wLD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 09:46, Matthew Wilcox wrote:
> On Wed, Mar 22, 2023 at 09:16:55AM -0700, Dave Hansen wrote:
>> On 3/21/23 09:40, Matthew Wilcox wrote:
>>> On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
>>>> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
>>>> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
>>> I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
>>> Is it possible to have one node with memory and a single CPU, then
>>> another node with memory and no CPU?
>> It's _possible_ for sure, just unlikely.  The most likely place these
>> days is probably a teensy tiny VM that just happens to have some
>> performance-differentiated memory exposed to it for some reason.  Maybe
>> it's got a slice of slow PMEM or fast High-Bandwidth memory for whatever
>> reason.
> Right, you can construct such a system, but do we support the CONFIG
> options of NUMA enabled and SMP disabled?  It seems so niche that we
> shouldn't be spending time testing that combination.

On x86 we don't:

> config NUMA
>         bool "NUMA Memory Allocation and Scheduler Support"
>         depends on SMP
>         depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)

... which I think is fine.  I totally agree that NUMA without SMP is too
niche to care about.  Heck, !SMP is almost too niche to care about these
days.
