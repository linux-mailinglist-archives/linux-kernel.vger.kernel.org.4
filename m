Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4374CDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGJGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:54:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA22DB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688972054; x=1720508054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=StiLZhLWn7Z69DFoSKxAgS1TT5csxVbyfqe4weLYf7A=;
  b=KvcIZXVhndf3kjzfkZ7XyGzRk4Z6LO1JBg5ZxkqzhLAxFA6GkHpWwhz7
   97+FWkxtuPdS6QQ90CoIchucQ07pzfgqePSMYzpW+nrY/34RRUf8/TBHG
   awtqMvU2BlaH9C8PakEVBG/w0Y3Y08mSFpd+Ar/xakGnBYQfnIo6X8JG7
   Ffuk8cCHzz+w/Plf7mog+g+HiXSrA5tqRDQwe4ZeN9AP6QYeSqtxfoh00
   mLiC4++cUHqK9HRT+/avj6RBrBG59DqM5PsPSuAzNvpO5BHwKtG64nUVc
   jZXmjP2a9Pf/IKMnh4lkvYsyuyRSTXpkuv6DqJvk80HjZtz1ncyqTeVJS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427961482"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427961482"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750240533"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750240533"
Received: from zhanggua-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:54:10 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 0/2] mm: PCP high auto-tuning
Date:   Mon, 10 Jul 2023 14:53:23 +0800
Message-Id: <20230710065325.290366-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocation performance requirements of different workloads
are usually different.  So, we need to tune the PCP (Per-CPU Pageset)
high on each CPU automatically to optimize the page allocation
performance.

In this patchset, a PCP high auto-tuning mechanism is implemented.
The description of the algorithm and the test results can be found in
the patch description of [2/2].

Best Regards,
Huang, Ying
