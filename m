Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B66A1D49
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBXOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:12:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DDA12B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677247932; x=1708783932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wbHiZmYpOxEtl62leTc5hC5LH7H7mGhZv9YLmgqKKdE=;
  b=BvC4wCm8dN36wSjUbBPRfkEaBLBWQLYcxdCHq5o0ushvH1anyxiGyKOO
   4EI/oqNWNT3Ud5L3DsnvbASClGLEVAMlRG7NG+jII087SgJnN+lUY7MXD
   iMijdpF26HN0W7ErXgmvae7kkyCM1dXFKpxexzIobdvI34akFyJ+7rBWJ
   cU1+4UmJcqVmSvdDaCh7qR1Zwfs8z54Ex800rYoh9mLazr707A0lchouw
   QxgTT1vQ1BlvRg97GNuVe72dUU037dLiqAXrkCxD/gQAl+4qV+YuDz6kz
   abZpm2d0JdTikxnPtU7Y53w4w3Mc1mV3LOahebTdUvCgofINuNVwd/2Fm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332167657"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332167657"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741684622"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741684622"
Received: from bingqili-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:07 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/3] migrate_pages: fix deadlock in batched synchronous migration
Date:   Fri, 24 Feb 2023 22:11:42 +0800
Message-Id: <20230224141145.96814-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two deadlock bugs were reported for the migrate_pages() batching
series.  Thanks Hugh and Pengfei.  Analysis shows that if we have
locked some other folios except the one we are migrating, it's not
safe in general to wait synchronously, for example, to wait the
writeback to complete or wait to lock the buffer head.

So 1/3 fixes the deadlock in a simple way, where the batching support
for the synchronous migration is disabled.  The change is
straightforward and easy to be understood.  While 3/3 re-introduce the
batching for synchronous migration via trying to migrate
asynchronously in batch optimistically, then fall back to migrate
synchronously one by one for fail-to-migrate folios.  Test shows that
this can restore the TLB flushing batching performance for synchronous
migration effectively.

Best Regards,
Huang, Ying
