Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7137162EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjE3OC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjE3OC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:02:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B045F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685455375; x=1716991375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IuOfuFXOUK55surV0YDa1ce7uDEpvN7Huet211HYSDA=;
  b=MmDODs2Z53gOYb+VqILPBKaBgk/1uBEH9wedvuBMTtng5kRAxonHvz48
   xmdiSXYfzy5k0lhV75QDHU4H+UijyWeS8SURbzRsKga4XGEvYUOfRipnS
   v7QDuxfvhDa8KfSKsFdaeK5jnyb/ckgSbKiKwZKjLwArv1KMfWsH9RQKE
   9k+Y2PE9YJVOs86RYNSAZyqvs2fVhllxrtyGKCkeo/dxUB6KCDcwGHrGX
   ye7oawqJvRfCWkO5+rsA4kAmFqk+Y8z7mNp+KlvE53Q2aXBRUY4z703MP
   lRvQSgPF9UAmg1nrRZ8YTa9pvAItRAA0ljbJOW6i5oy7ItKs9vAdj7nKJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383179381"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383179381"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953142966"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="953142966"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:02:52 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     hch@lst.de, andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Enclosure interface cleanups
Date:   Tue, 30 May 2023 16:02:21 +0200
Message-Id: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
While looking into adding Native PCIE Enclosure Management (NPEM) support
behind the existing enclosure ABI, I noticed a few opportunities for
cleanups.

Changes since v1[1] + internal review:
- Keep reporting the cached version of ecomp->active (Dan).
- Preserve cached values in ecomp, drop patch 2 (Dan).
- Add comment documenting cached ecomp->active (Dan).
- Move ATTRS macros close to appropriate _show and _store functions (Andy).
- Make comment shorter (Christoph).
- Update patch2 title (Christoph).

[1] https://lore.kernel.org/linux-pci/20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com/
[2] https://lore.kernel.org/linux-kernel/20230524111231.14506-3-mariusz.tkaczyk@linux.intel.com/
Mariusz Tkaczyk (2):
  misc: enclosure: remove get_active callback
  misc: enclosure: update sysfs api

 drivers/misc/enclosure.c  | 84 ++++++++++++++++++---------------------
 include/linux/enclosure.h |  2 -
 2 files changed, 39 insertions(+), 47 deletions(-)

-- 
2.26.2

