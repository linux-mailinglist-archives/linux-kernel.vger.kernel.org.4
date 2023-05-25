Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED8711A64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjEYW7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEYW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:59:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB134EE
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685055560; x=1716591560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=90QN9MOkS/N7Bw42xC/dedonZY2s6ldSuLXYV7xGbaw=;
  b=Ov2R7EDFhD4h0bEPW3KVXesDdoPJ6oOqBy45BaP3H63kLsgeDgUQskbn
   sVAY5DisROxS4zbpsBmdv1I/3I63KCoW/ifyJMkmJwjSjn4wrPAayOnkQ
   kW+qLcnm0CCZ9mq+VhntXTYtXbhFfSG/pvHZKKs0Pxyx2YuelwthKJOlE
   ZAm9exd68LK4oK3RfKeZDYfNWr+kSsf0iUyNB2blA73cRgPZlsm2to4No
   66t+LsUb6vwnesdPhItChY4K3HMPmEqGmp/wV6090kaYC9wye6MndH/ec
   tdy0RZYufOTZUZqIqupUwzXbX2xTbh2gfdul0rBki1D54G8WPXg/x8efO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356434713"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="356434713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="849363622"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="849363622"
Received: from daubin-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.39.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B29E310C61D; Fri, 26 May 2023 01:58:57 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] x86/tdx: Fix one more load_unaligned_zeropad() issue
Date:   Fri, 26 May 2023 01:58:45 +0300
Message-Id: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During review of TDX guests on Hyper-V patchset Dave pointed to the
potential race between changing page private/shared status and
load_unaligned_zeropad().

Fix the issue.

Kirill A. Shutemov (2):
  x86/mm: Allow guest.enc_status_change_prepare() to fail
  x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()

 arch/x86/coco/tdx/tdx.c         | 56 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/x86_init.h |  2 +-
 arch/x86/kernel/x86_init.c      |  4 +--
 arch/x86/mm/mem_encrypt_amd.c   |  4 ++-
 arch/x86/mm/pat/set_memory.c    |  3 +-
 5 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.39.3

