Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C662B032
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKPAoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKPAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:44:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB474B7D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559444; x=1700095444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bqLkNfBeyVu6ZozHb3GDCMkCiQN1T0vQC8Er0Ni6co=;
  b=ckR1A22wisWD7grOrfgTE1plaFcT27Zspk96BRPR+q6syqMdkKoPjpD/
   OoOK7bt7x9Tbwy6GTJ4d0M/M0TmJE52UP2+L7JyUxSmGhShxJ/DbWb+CK
   QDgb9/hD42GJ7UsPxpcjJHerd/Gt4M14iMViKv2dd/7+pkhtQnkp85fOg
   1r4yVlXpATG5ldCrfsMsgjpzMd28rhGylyvkX+iwy96MdFQ9gMAs1757w
   3JH7ZTsp1e0kHyU8DHUVT1MgmvrPjgp6q0Er08dXxvLCY+x8l4uvuop/c
   p7J7CkLqxgvqYw92bpWz+6PawzydG+5vmJjXthm+lpcuH8spQ8xXCcgPV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292800213"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292800213"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968210386"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968210386"
Received: from nrobin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.45.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:01 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 125161042A8; Wed, 16 Nov 2022 03:43:59 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill@shutemov.name
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        jejb@linux.ibm.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        martin.petersen@oracle.com, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org
Subject: [PATCH 0/2] x86/mm: Fix sparse warning due to LAM patchset
Date:   Wed, 16 Nov 2022 03:43:51 +0300
Message-Id: <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reported new warnings due to LAM patchset.

Fix them.

Kirill A. Shutemov (2):
  scsi: Fix get_user() in call sg_scsi_ioctl()
  x86/mm: Fix sparse warnings in untagged_ptr()

 arch/x86/include/asm/uaccess.h | 10 +++-------
 drivers/scsi/scsi_ioctl.c      |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.38.0

