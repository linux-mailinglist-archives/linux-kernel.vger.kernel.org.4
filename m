Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69266954F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjBMXs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBMXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:48:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECC126C7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676332129; x=1707868129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDoVpTAUfuRLKHuvAYJkruKvIjru3gmVTwuDctec5C8=;
  b=CSJRnkDpnb3DQ8a5puUCnCsCsMbESMZPLxJrwLRjvTd+x9q4unR6pm+/
   tPpzyPnDgUAkulDSj0ZD3SUeXHwdwGsBr//ZKa1Aa4Tmue/UDEv+tP4cw
   PuHH8TxnNzfjn3G2aNQQ551QJliOFvuB+ta1rbwemirRCKh90MOgKHA13
   w2IgVKM/VcZqWlw+WQZ5KV/ojprND8bk2tEasfeEjxSwPOh5YftRfxTeU
   cSM5CsCDlBokq9wYNdBlxV+wi+TrQJ7c26KQg0PX8wjI0FacxlT6tv28H
   ZPB324cwgd6tK47/x+B82BGR8wFWU/kXcQR3i/EIRj1bdoNTNWsMW2kEs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="329658419"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="329658419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668965311"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668965311"
Received: from iannetti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5BB7810CA33; Tue, 14 Feb 2023 02:48:43 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Kexec enabling in TDX guest
Date:   Tue, 14 Feb 2023 02:48:34 +0300
Message-Id: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The patch brings basic enabling of kexec in TDX guests.

By "basic enabling" I mean, kexec in the guests with a single CPU.
TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
doesn't allow to put a CPU back offline if it has woken up.

We are looking into this, but it might take time.

Kirill A. Shutemov (2):
  x86/kexec: Preserve CR4.MCE during kexec
  x86/tdx: Convert shared memory back to private on kexec

 arch/x86/coco/tdx/Makefile           |  1 +
 arch/x86/coco/tdx/kexec.c            | 82 ++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h           |  4 ++
 arch/x86/kernel/machine_kexec_64.c   |  2 +
 arch/x86/kernel/relocate_kernel_64.S |  6 +-
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c

-- 
2.39.1

