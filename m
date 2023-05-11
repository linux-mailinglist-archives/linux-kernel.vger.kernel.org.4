Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4986FEC08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjEKG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjEKG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841D6584
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788222; x=1715324222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5148VWt67GT1KAtmE4SFUCYsm8r3r4RYHgyw/Z4o9Gc=;
  b=GTFwZcaPHmzUdCt33Jy22vCc/fpXB2qBGf67qPv2kEHHBpO7UJFNNtnJ
   TsE/bBjcAzI+nCo8cT2UGR+ctj9KQRO3Wdpxgy6zwQnjS1RsYo+a/4+tg
   AqWNpu+PDFanaCPHuVU6ZvBpvHPZKNaX69J/7dStw8rG3yqAzCa9eghuY
   EEgIqKbids/1vAyQQp9ZAZ2kkEgQxx2tebvmzfYiLR2XI4oAHqWaUCAqg
   JZeoOqd+xWFYTZYZLg7kQaf/Msi7oiC/nPnenk5RIYg3hkxRkMPnL2H/X
   vr+E/mkKdpm4xONUc9uD/zfXYIc9tDOMG2/HBuyPgyJWPOpC/afyixMyI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744462"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855230"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855230"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:28 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 0/6] mm: improve page allocator scalability via splitting zones
Date:   Thu, 11 May 2023 14:56:01 +0800
Message-Id: <20230511065607.37407-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is based on upstream v6.3.

More and more cores are put in one physical CPU (usually one NUMA node
too).  In 2023, one high-end server CPU has 56, 64, or more cores.
Even more cores per physical CPU are planned for future CPUs.  While
all cores in one physical CPU will contend for the page allocation on
one zone in most cases.  This causes heavy zone lock contention in
some workloads.  And the situation will become worse and worse in the
future.

For example, on an 2-socket Intel server machine with 224 logical
CPUs, if the kernel is built with `make -j224`, the zone lock
contention cycles% can reach up to about 12.7%.

To improve the scalability of the page allocation, in this series, we
will create one zone instance for each about 256 GB memory of a zone
type generally.  That is, one large zone type will be split into
multiple zone instances.  Then, different logical CPUs will prefer
different zone instances based on the logical CPU No.  So the total
number of logical CPUs contend on one zone will be reduced.  Thus the
scalability is improved.

With the series, the zone lock contention cycles% reduces to less than
1.6% in the above kbuild test case when 4 zone instances are created
for ZONE_NORMAL.

Also tested the series with the will-it-scale/page_fault1 with 16
processes.  With the optimization, the benchmark score increases up to
18.2% and the zone lock contention reduces from 13.01% to 0.56%.

To create multiple zone instances for a zone type, another choice is
to create zone instances based on the total number of logical CPUs.
We choose to use memory size because it is easier to be implemented.
In most cases, the more the cores, the larger the memory size is.
And, on system with larger memory size, the performance requirement of
the page allocator is usually higher.

Best Regards,
Huang, Ying
