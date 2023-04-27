Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682296F0C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbjD0THd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbjD0THb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:07:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA772694
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622441; x=1714158441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OgQAqO99SmndNjrWe+916u5vGrg8g9TMY8iNMFotTeY=;
  b=SwSwA7k0Ee2yhe0yU/NT9bt/1uOAywt5UyavmpqA5QJFgcDKSZqnGfx+
   4W3s2e0qY7fmkLlc8hfYJ0EAL8IlWwtuEDpNCOeKXZhagA7CTBoH+8a4j
   GiDr3FY/2UnMXuWTyQYWgCPy06HC3en6dpE6h/1fwywiQQNMyJtFEsdHj
   PjQJSLY0+0GvD4h46IN3AdDgzPqxb0fdkczfvdJAM2mc5M2eja9m71R8w
   LiRwDfBlnrhQ/rfS1G+4d0hesmisoP//8JINZztQNIiq0fDr3G1V51xVS
   CB0yAa80ZTg1vV0bxhNM9Me5xEXloehDAOeXWS2w2fkyamH30D2oVVGAq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347562924"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="347562924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="940777452"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="940777452"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2023 12:07:20 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.4 (take 2)
Date:   Thu, 27 Apr 2023 12:06:53 -0700
Message-Id: <20230427190653.1076577-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a single x86/tdx change for 6.4.

The original assembly here took two flags in %RSI to tweak its behavior
at runtime.  PeterZ recently axed one flag.  Kill the other and tweak
the 'output' mode with an assembly macro instead.  This results in
elimination of one push/pop pair and overall easier to read assembly.

This "take 2" has a proper signed tag in the tip repo instead of an
unsigned one in my test repo.

--

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.4

for you to fetch changes up to 7a3a401874bea02f568aa416ac29170d8cde0dc2:

  x86/tdx: Drop flags from __tdx_hypercall() (2023-03-22 11:36:05 -0700)

----------------------------------------------------------------
 *  Do conditional __tdx_hypercall() 'output' processing via an
    assembly macro argument rather than a runtime register.

----------------------------------------------------------------
Kirill A. Shutemov (1):
      x86/tdx: Drop flags from __tdx_hypercall()

 arch/x86/boot/compressed/tdx.c    |  4 +--
 arch/x86/coco/tdx/tdcall.S        | 66 ++++++++++++++++++++++-----------------
 arch/x86/coco/tdx/tdx.c           | 18 +++++------
 arch/x86/include/asm/shared/tdx.h |  5 ++-
 4 files changed, 51 insertions(+), 42 deletions(-)
