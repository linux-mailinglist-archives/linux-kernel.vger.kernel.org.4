Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0F6C5055
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCVQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCVQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:18:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CC422F;
        Wed, 22 Mar 2023 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679501888; x=1711037888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GxnyaeprblyISryT2qF5P+Px8gWsxIIA48GZP8Apwvg=;
  b=OCvBAOQxETqfBEtd8QFhIyMlNvHe4jwP8tRQi8/kRcKU4IkXLNjmyX63
   reEsOZh60NvtqqoEYnyEhchK8HdV2svvEQXRz7+j+lQapsq1SOiUx2u0e
   e9Cic4JTqEDnpR88ASJocMJ6Cssf2EOWLDeA6uZi/0wbOUMbg5fMSxj00
   jbMFp4mR2Q/K1Djn6ZdYMYjT7HVX/3rj8BSleKh13JUIxPJnnbO9OCbaD
   U1fmZyW0R0aUBE3zSE9Dc0qpy/Y731xkP0p7S5VLXRHJ8t/ZUtIeUFBEV
   1aFUsK9pbu3l5A6KwZdRsvsnKC4oJqE6LrU8cxMjKBdkbIMzoeKnzU+/M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425547449"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="425547449"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675344533"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="675344533"
Received: from mtfreder-mobl1.amr.corp.intel.com (HELO [10.209.35.23]) ([10.209.35.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:16:55 -0700
Message-ID: <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
Date:   Wed, 22 Mar 2023 09:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZBneELQuakjva1xa@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 09:40, Matthew Wilcox wrote:
> On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
>> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
>> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
> Is it possible to have one node with memory and a single CPU, then
> another node with memory and no CPU?

It's _possible_ for sure, just unlikely.  The most likely place these
days is probably a teensy tiny VM that just happens to have some
performance-differentiated memory exposed to it for some reason.  Maybe
it's got a slice of slow PMEM or fast High-Bandwidth memory for whatever
reason.


