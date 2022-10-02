Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2C5F20B8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJBAXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJBAXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:23:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F05302D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664670209; x=1696206209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TKBgNBVRzfsXiUEeUIGKA2/xwBVx0bYjzBIB3V4QxOA=;
  b=c3GeGpZ09V1MypOQ/fRI4vrlRKkPorFkxvlmeZTTNDDzlcSceZ8ywcvW
   Jg5GwrCdfh53Nqkzbby2+3SCdPsvvQ+yCm8uvNQ/wPBg8wkrUK64F8wCW
   BE24eQWqud7FWRLWJxwQCIull3AUGcvIx7UtCvioibIEIQ7EaOLxKweEP
   JOuFUBCAyZ9r9ggqXbZ6v2eGj7WGGlPiJTUup3TR/kzA4LRzN+7U+XN4d
   zQEH8xvTqg7byBbnEClronynRo74o5/e+VonLLX4LqrxGNdAcmXypwlf8
   S16G5LPnBcEH4mJPARcCXqH9nz7iQSvD04BJY3dNGbUHi99P7JJMsK1ex
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="285564517"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="285564517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="656347024"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="656347024"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:23:29 -0700
From:   ira.weiny@intel.com
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/4] Remove get_kernel_pages()
Date:   Sat,  1 Oct 2022 17:23:22 -0700
Message-Id: <20221002002326.946620-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did not
need the functionality it provided.  Furthermore, it called kmap_to_page()
which we are looking to removed.

Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
does not have any need to support vmalloc'ed addresses either.  Remove that
functionality to clean up the logic.

This series also fixes and uses is_kmap_addr().

Ira Weiny (4):
  highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
  tee: Remove vmalloc page support
  tee: Remove call to get_kernel_pages()
  mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
 include/linux/highmem-internal.h |  5 +++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 -----------------------
 4 files changed, 19 insertions(+), 59 deletions(-)


base-commit: 274d7803837da78dfc911bcda0d593412676fc20
-- 
2.37.2

