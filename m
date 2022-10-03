Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A065F3894
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJCWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJCWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:04:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44012701;
        Mon,  3 Oct 2022 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664834679; x=1696370679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KTzlPVkfGDUFOn2h62BFHsL/RD/kLej7Z/kkW3Qz++8=;
  b=IpHJ6xOry/a5mvX1mKNALL/4wr+AnKgqbzN6LbZuDzNLRzc8NpL3f3to
   RQjCAGUn6X/qrNMuMEvL14lFg8MkDq+C5dhA/EjMN0LXGzsNqckVCgxPl
   0/Yqx3V/WDSyMEWglVVm5Gmi92H2X7HaXzl4BcdQDCSag/R5orfc5onun
   M8KtVYwcLjM3zI0V4DyqmglFhHkgjOqw6WO36e1EWvZ2eG4HrEBwc4O3H
   p1O22032cCWTsoZd6ZXdqLj7OIaLXE6RwtSmz+XEHNNRduNgVlZY8JXNy
   f+L5IomR81oOANpARpJiu6Id3vfru5NcF5z4OxIK9qsjP3y10w4boD3mY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366869166"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366869166"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686310943"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="686310943"
Received: from jparcemo-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.93.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:04:37 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Minor improvements to sgx_init()
Date:   Tue,  4 Oct 2022 11:04:26 +1300
Message-Id: <cover.1664834225.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.37.1
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

Hi,

Patch 1 and 2 are the improvements around EPC page reclaimer (as I
mentioned to do couple of weeks ago).  Patch 3 is the RESEND of a
previous patch to add a missing error check.

This series is based on latest Linus's upstream tree, but not
tip/x86/sgx, as the latter doesn't have 2 patches that Dave sent to
Linus for 6.0-rc8.

Kai Huang (3):
  x86/sgx: Start the ksgxd() at the end of sgx_init()
  x86/sgx: Only run the reclaimer when the native SGX driver is enabled
  x86/sgx: Add xa_store_range() return value check in
    sgx_setup_epc_section()

 arch/x86/kernel/cpu/sgx/driver.c | 13 ++++---
 arch/x86/kernel/cpu/sgx/driver.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c   | 58 +++++++++++++++++++-------------
 3 files changed, 44 insertions(+), 28 deletions(-)


base-commit: f3dfe925f9548a4337883926db542ccf4ca55fe1
-- 
2.37.1

