Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A0614498
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKAGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKAGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:22:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F515FC8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667283761; x=1698819761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FHNWw3yNYbnjvEUD6v5MeX3IamjwsD8jl6R6ZXAIZWg=;
  b=UyAkC0Ck9H15p5jGbZnhlv2BkjE5px+qlyKw8qsze7dOtt/UeR/KERkH
   qmHlexE9loKBvjowFRve77a9S6WYBAtapWcNVoE6qVxDk3GuMk1a+L/eY
   nYNnaYhi94zQy5zFkgYh+0Q/dOC8EUYn2nRxbMcTf1YbKsknacA2dn5Kl
   gSA+uRWGqLRByqGLVyqPmkV1oXZDiRnzR3BMZg9BFVgoEmxtz9NqdcG5Q
   thrME5G7MwIveljKVffSrihjsaerZPl3Wfwa3qiQfuHB62s6JUImpKlhw
   zp/qQfzoe8NiA6fweRiCkoaHwJpiwSZaCkaAfBlRl5uoXMu64ktUkiO8s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395388675"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395388675"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 23:22:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878998335"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="878998335"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 23:22:38 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC 0/2] migrate: convert migrate_pages()/unmap_and_move() to use folios
Date:   Tue,  1 Nov 2022 14:21:35 +0800
Message-Id: <20221101062137.83649-1-ying.huang@intel.com>
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

One question is about THP.  Which is converted to large folio in the
patchset.  This is generally OK, because the code can work with
arbitrary order large folio at most times.  But some THP related
statistics (such as THP_MIGRATION_SUCCESS, etc.) are converted for
large folio with arbitrary order too.  Do we really care about the
order of large folio?  Do we need to be backward compatible strictly?

Best Regards,
Huang, Ying
