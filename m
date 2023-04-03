Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704B6D430A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjDCLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjDCLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:11:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4992D30FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680520232; x=1712056232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gXsYvqw9RPVvwxej0jm0sxGMXH6vFybKsaGhd9VshZQ=;
  b=G4gAwzXEd+ZKEes9tXnF/B+SkN5iol76P+08bJx1Be1Kse7oHFQocFoG
   jVCdobYesirh3l1kp6YM6QgQ8fW1Y/yDWDItjf3hUzJEVeurUBMkRtpLR
   /+8zDKEot43QtSeLVxcdWjKO6hA7iWfW66v+8ogP19wqfvMRAjlFtmRRT
   +A7tW4I8N/5oBvdMGiIWXb6HQcmmWyEgojMBdkJTxedkjhMKj/6VS89eq
   OmNjW5Aw3DjesOceglH0Nj4XTzLaCvG8ZOQMrSjgf6h1huLNUn/2qGtDR
   +POspHj3wpqH7g61jzhEqOzZ1LS3l8IkEoNPg+Ym5K5UabYAEsEVUAsay
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="330440419"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="330440419"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="860164459"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="860164459"
Received: from amomin-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.227])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:10:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E079A10D7B3; Mon,  3 Apr 2023 14:10:23 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Couple of trivial fixes for LAM vs. SVA interaction
Date:   Mon,  3 Apr 2023 14:10:18 +0300
Message-Id: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Do not allow to set FORCE_TAGGED_SVA bit for other process;

- Use EINVAL instead of EINTR for LAM enabling failure due to SVA;

Kirill A. Shutemov (2):
  x86/mm/iommu/sva: Fix error code for LAM enabling failure due to SVA
  x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA bit from
    outside

 arch/x86/kernel/process_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.39.2

