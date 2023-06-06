Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA945723E83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbjFFJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjFFJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:56:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D4E6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686045393; x=1717581393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z2Dvf4mA1VzzTZjfh3y1HywjdJsGHa7T3oAn6+kI0iA=;
  b=lrJtaNNnH7FWLmvZEEXbkZAFk8ytjcBEkJ2Ib4EqFMFrn62OEC21CQKD
   33J9nQDw+cEDLfV6mN+qFAHhkc0kzel5UZQR1A0wVNg1NQS60bH0UX74e
   emCSiyUUVVslko9h7woka7NCPhPbpgRDRjJTnOX6F3wEPsAn/wBHQgplw
   QYJP7g1NNiNfeIQBy/Ouy3+geak7uaY/salg/l1BTpcLB8WPsOX6k15ZR
   OrcrR2Vq+FM2k6CvZ77n82f3cRrorbyxJqC3nPClwFt12sT+Fs9U4gLGe
   /KEUnzomyMVIPaGzDuZSHSucXJwQAfSIyz8e4mw1kyvj1YPynxcacXlFl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336249090"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336249090"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853348525"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="853348525"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9F11F10A6A4; Tue,  6 Jun 2023 12:56:26 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad() issue
Date:   Tue,  6 Jun 2023 12:56:19 +0300
Message-Id: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During review of TDX guests on Hyper-V patchset Dave pointed to the
potential race between changing page private/shared status and
load_unaligned_zeropad().

Fix the issue.

v3:
 - Fix grammar;
 - Add Sathya's Reviewed-bys;
v2:
 - Add more info in commit message of the first patch.
 - Move enc_status_change_finish_noop() into a separate patch.
 - Fix typo in commit message and comment.

Kirill A. Shutemov (3):
  x86/mm: Allow guest.enc_status_change_prepare() to fail
  x86/tdx: Fix race between set_memory_encrypted() and
    load_unaligned_zeropad()
  x86/mm: Fix enc_status_change_finish_noop()

 arch/x86/coco/tdx/tdx.c         | 64 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/x86_init.h |  2 +-
 arch/x86/kernel/x86_init.c      |  4 +--
 arch/x86/mm/mem_encrypt_amd.c   |  4 ++-
 arch/x86/mm/pat/set_memory.c    |  3 +-
 5 files changed, 69 insertions(+), 8 deletions(-)

-- 
2.39.3

