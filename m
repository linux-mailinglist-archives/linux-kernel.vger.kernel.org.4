Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAE72A0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFIRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFIRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:12:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3351FFE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686330760; x=1717866760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ie+Bhj1N8EkFJvCkDe8BVuLNzwjQbe52gKt6eY6latA=;
  b=hF0d3SXaFPl/RgFAGOZl+siEWUJPYa80AUN4Du0D1qMXRgwNAeTemMbq
   evVEwvlVdQ8Z4+NXffUjCCL3T+ojwt5kvdOmGwSECu7UkwZUAvSH5aOl4
   UA44lJiDU8ahaoW0stNMy5YXpDVV3lk+/N57mcCMkm+7abMrpTnqWZLwr
   lF0N1JZa5p4s3wXgOd46QWPASAoE/Lx+Psd44c2M0zOc9iUiWyaX4Sj5p
   tf/0h0O6BgzKPUsNooZ7eR7A/k4vEwtT6z7KhgMwSWFfWooqHUMBvIeSV
   5yXKDhVKyymYRfdhpynuRG4BKellUT4/X4Y/fEPFopckpNAv/kAAUgyTm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357647299"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357647299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="660824608"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="660824608"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 10:12:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 0/2] x86/sev: Generalize sev_setup_arch()
Date:   Fri,  9 Jun 2023 20:12:12 +0300
Message-Id: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since previous version [0], I added 2/2, which is a minor cleanup.

The main intention of this is to move sev_setup_arch() to mem_encrypt.c
to reflect the fact that it's not SEV-specific, but covers TDX as well,
although unintentionally.

While looking at it, I also noticed that mem_encrypt_amd.c still
includes virtio_config.h, which was needed for the code that since got
moved to a different place (and even there doesn't require the include
any more).

[0] https://lore.kernel.org/all/20230530121728.28854-1-alexander.shishkin@linux.intel.com/

Alexander Shishkin (2):
  x86/sev: Move sev_setup_arch() to mem_encrypt.c
  x86/sev: Drop unneeded include

 arch/x86/include/asm/mem_encrypt.h | 11 +++++++--
 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/mm/mem_encrypt.c          | 34 ++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c      | 36 ------------------------------
 4 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.39.2

