Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A36F0BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjD0SP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjD0SP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:15:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286FE40C4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682619356; x=1714155356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=785UCBXwGM5bsA0zPWVgzoLulCD7I5nsw2bYhst8zvE=;
  b=JXbtr7LYFgQYqbJRSfWNvY+IBCXXRJXHwVSZsbfqQbpE87Z9ooDVki1J
   ZQWl5dGAi9xHqt5IdNSuESYsE8AMtrAldBzFWZq+PsanqPkc9wqQUxRrw
   oWJU48w0a+XHvus5nN+04xe85E4N02nuYhYiPm0Qpd/88Wo61j5KiadLo
   Obdv8Ro2Q9J3XJKtAZSMMos4kxh3O8lI+FrqBpAltJk2LrZvae5IBVABL
   EkBn8lKLXl/Fwjwqq4Qc9vrtkUbebTmHol4WjUSxEjE9oX8oUMnEYfUR4
   h++/RKv6QjKq3VDEYgwFP7+xJ6427xGcpgqZlxWxR9Y0bXo1K7WAgNqRQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331808611"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331808611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="644792056"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="644792056"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2023 11:15:55 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.4
Date:   Thu, 27 Apr 2023 11:15:48 -0700
Message-Id: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

--

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git tags/test.1682619270.x86_tdx_for_6.4

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
