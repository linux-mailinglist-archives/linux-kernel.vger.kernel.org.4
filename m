Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53A6FF21E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjEKNHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEKNHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:07:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62D3C23
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810432; x=1715346432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHirkZi6x2ogboF84Ab8qzaYKBiYOy11T/lXNOHxwh8=;
  b=WhuwgUBZbRB2Rmf5E4ajWxO8kQcMayvIMeTACjnuG/UM28qagQmd7SoI
   A4ZjjqZefmpftpDbrEyKzPa7EcvL79yZC5lYxfvhD3JQo9IW2qARu9tzu
   i1k/17sNww/kr+24CA2RUYlsR7OoPyKjc5OpEJeJaaYybNGXlen/t7Ch4
   gPJfrCDVftg+FUjV9omXBj2Y9GJQtVMFshovqcaMR/n7u/5oo8KcmJEkJ
   ncZxvrrfI6KRacuNvVc6+xcEOhDDh4OqUYEqLOjvXwoWHwxwa41C7ZiqD
   4gQq0jSYcYr/jjHa+R74VXXJrwNxWazKfHvhFoTsV+uRddtr9nx6dBEPe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378617172"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378617172"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="699706177"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="699706177"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.79.85]) ([10.209.79.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:07:08 -0700
Message-ID: <9ebd85b6-61da-c868-240d-0ea99c8e147d@linux.intel.com>
Date:   Thu, 11 May 2023 06:07:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230511065607.37407-1-ying.huang@intel.com>
 <20230511113009.00004821@Huawei.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230511113009.00004821@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 3:30 AM, Jonathan Cameron wrote:

> Hi,
> 
> Interesting idea.  I'm curious though on whether this can suffer from
> imbalance problems where due to uneven allocations from particular CPUs
> you can end up with all page faults happening in one zone and the original
> contention problem coming back?  Or am I missing some process that will
> result in that imbalance being corrected?
> 
> Jonathan

Well, the first line of defense is the per cpu page lists...
it can well be that a couple of cpus all in the same zone hit some high frequency
pattern... that by itself isn't the real issue. Note the "a couple".
It gets to be a problem if "a high number" start hitting this...
And by splitting the total into smaller pieces, this is going to be much much
less likely, since the total number per zone is just less.

