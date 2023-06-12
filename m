Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1164472C45D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFLMfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjFLMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:34:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A637E4C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686573293; x=1718109293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=900EepEGCqAm9Htu/dHP8/9CKlaRD3lP1YDRn2rrpvg=;
  b=R2FWow8iT9MYlorSj0tg6hmov79tBpdFQUKGhHAh6SaECXLUhrrn3wpq
   cfTfnBf8h6tZrH184WRoRssnBBA/DS7bzSZMgxx6Cir1COBM841ffHutc
   g+niq4QHa+gjU4HgP79478gAWX6CdkIdsg/qYxbX73AkVm7lFYAhauXgc
   c185KDBTsRbyUAj6qOWZI2QXbXP5xAFBBMxvtG4ttzada9vjooo7fyjZf
   sar4hYBeCCnAccmqUM2pHuRfO1BRKqXDn5ZqYKylb5gB4xwSqZdNZURvN
   cTNusBvQHunjGfsuGIRv7REwBoXVy72EUvCJxQWm6Kr9MMH3v365F99y8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="356909259"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="356909259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 05:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776346130"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="776346130"
Received: from keramine-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.78.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 05:34:50 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, x86@kernel.org,
        jpoimboe@kernel.org, rostedt@goodmis.org, konrad.wilk@oracle.com,
        Kai Huang <kai.huang@intel.com>
Subject: [PATCH v2] x86/kexec: Add a comment to relocate_kernel() for better readability
Date:   Tue, 13 Jun 2023 00:34:38 +1200
Message-Id: <20230612123438.469673-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason to save %rcx to %r11 before calling swap_pages isn't that
obvious w/o looking into the swap_pages itself.  Add a comment to
improve the readability.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v1 -> v2:
 - Avoided line split in the comment.
 - Added Kirill's Acked-by.

v1: https://lore.kernel.org/lkml/538335b164bf8b84b8a55c5654ed15d849479388.camel@intel.com/T/

---
 arch/x86/kernel/relocate_kernel_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..fea1aed16142 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -169,6 +169,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 1:
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx */
 	movq	%rcx, %r11
 	call	swap_pages
 

base-commit: 409bf2895d71bb68bc5b8589036e5ed1ca30bada
-- 
2.40.1

