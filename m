Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B8736D30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjFTNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjFTNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:22:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAAE1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687267323; x=1718803323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=//6nDkfKtxwUrmAE9sDBlISnk9pJuZNcILsoeTfza6o=;
  b=L1JIytbxqmULPx02hdQL86sRarCl4xhRKRu4Jziql6p1uisi3fRzAG+k
   zRUH2LX86C74TLbXNudQ5Z0zh89rW+V2MbIk7xKkjGA4xOraBaQiEEzEx
   mYnuBOzbYo6i9g2yMuqd63q3bgVtIgDVQ9afOL3v5RXgKMUQdauXykdsG
   MP3L56yUqS7Rr64iHpVA5wESCkDUOeRmM1URgP2Tw+0K7vPUjquArWTlD
   T9cZDRQc0wUGU+tSQJDB7qBtJ7mQEyMJmyue/TWFLAK9ewgcYPoYRlbRn
   2Cjhyy3e35/WR/CQyfvyRNefAjdX/RtFecFtexyI5T+fUYjGMA7JiqyqJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349588269"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349588269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691426914"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="691426914"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:19:58 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] mtd: prepare for dynamically removed devices
Date:   Tue, 20 Jun 2023 16:19:03 +0300
Message-Id: <20230620131905.648089-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare mtd subsystem for devices that can be dynamically removed,
like memory on PCIE card.
Use refcount to prevent crashes when underlying device
removed unexpectedly and reshuffle __get and __put functions
to allow underlying device to clean it memory according to refcount.

Alexander Usyskin (1):
  mtd: call external _get and _put in right order

Tomas Winkler (1):
  mtd: use refcount to prevent corruption

 drivers/mtd/mtdcore.c   | 86 ++++++++++++++++++++++-------------------
 drivers/mtd/mtdcore.h   |  1 +
 drivers/mtd/mtdpart.c   | 14 ++++---
 include/linux/mtd/mtd.h |  2 +-
 4 files changed, 56 insertions(+), 47 deletions(-)

-- 
2.34.1

