Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0582A6192C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiKDIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:31:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65327142
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667550666; x=1699086666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cAnFaZqCWM4hqUzOOmTBs/DxrnLkKG5XMrG3q6FMLnU=;
  b=D6+CXsKzUUUQ6fk7gptvdz096eAr18/0TZS5GEUgtng6OF60zOx7gXGa
   lbQiMeWTH/MIA55Fq2/nYowcnrd6DLR4p/zD+v6JD8TUPogJzg4qyvQiN
   zEPCBAzPluzv1KRU+vz43KGA044u8oCVFN0qVYO5+1O8z/rUp7ogWNqYk
   qKpPvnfdRljacfZCgxS+Emp/x97TCuIn/pMAR9TIXBGFxctpZi64rSqUf
   0+Ab+H5JWXu0Zu5WwiyLX0IHKChrxQ8S1ZMwofzQvTfLjNEnhaQow0bEd
   eJTbz0z+WCdtvtuhnHYyCslyS8FJR1JeUU1LVTa5fGGDcvwbrIswNZQg4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396214449"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="396214449"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:31:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="629651906"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="629651906"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.213.176])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:31:03 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/2] migrate: convert migrate_pages()/unmap_and_move() to use folios
Date:   Fri,  4 Nov 2022 16:30:18 +0800
Message-Id: <20221104083020.155835-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is quite straightforward, just replace the page API to
the corresponding folio API.  migrate_pages() and unmap_and_move()
mostly work with folios (head pages) only.

Changelog:

rfc -> v1:

- Change API to test transhuge and hugetlb, per Matthew and Zi's comments.

- Make THP related statistics for THP only, per Matthew's comments.

Best Regards,
Huang, Ying
