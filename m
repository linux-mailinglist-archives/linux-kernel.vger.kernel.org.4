Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED3F61142C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJ1OMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJ1OMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:12:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E11C8136
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666966350; x=1698502350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DWwpTWwtwW4AY5eM0SKQWWvutMyN281P3797YkcTUqE=;
  b=MoGcwSRkXNI68R36nRUxieh0bXDuBDHwCqZQ9TsXDQ0OrFns+aqjQLek
   R+o1T0+5DPqYbJakTPyZd/qRKUdxPQqrHWjL/h3pRfN+lpVQm3nY0i7RO
   sWcytwnkVCXxW7hZ9l2roBZv8ZeO72EJVd5awFl3l5ZF4DC3KAlGBd12T
   ehWO6cR+/N6ipTuQwUgyYQ26QRCpehXhE9xMLNABE/ZQdJFgreG+gW6ak
   ZPLj6nmW/ALH2LM6oaXQweFpfBqRVnG/i1UIsrXlpRhEaTTQMcOHv59W7
   yXChFly5X4T/75hKOf68fmARTm3w+4avQfia44Cao4KlNdG3RvfpLJVhP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="306108191"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="306108191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:12:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="610754879"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="610754879"
Received: from snehalde-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 07:12:25 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0C6DC104BA2; Fri, 28 Oct 2022 17:12:22 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] x86/tdx: Enforce no #VE on private memory accesses
Date:   Fri, 28 Oct 2022 17:12:18 +0300
Message-Id: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in 9a22bf6debbf ("x86/traps: Add #VE support for TDX
guest"), kernel relies on "no #VE on access to private memory" to keep
guest secure from attacks against syscall gap or NMI entry code.

SEPT_VE_DISABLE TD attribute controls TDX module behaviour on EPT
violation.

The attribute must be set to avoid #VE. Refuse to boot the guest if it
is not.

Kirill A. Shutemov (1):
  x86/tdx: Do not allow #VE due to EPT violation on the private memory

Kuppuswamy Sathyanarayanan (1):
  x86/tdx: Extract GET_INFO call from get_cc_mask()

 arch/x86/coco/tdx/tdx.c | 74 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

-- 
2.38.0

