Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52D613EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJaUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJaUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:10:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C40C6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667247047; x=1698783047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVin2FQfBiKKdgB/2PC5DT5M96qnAGhQxw1TWFWq2qw=;
  b=SWgcSZWEobek8XaeFnKCNF0MGbFE4mcGJIWCnuqKvwcWcmPxrSiwdF6Z
   L9MUaF8DOb1EICDw8DjGC7FM3zy3Tx5mo4QluvaNUGFR39YZGP/vW/yXz
   ad7EAZLI+sbPPfkKAw8KNY8wMLd473ALqpE5nsUmp86uiGmoIaSuN3NiO
   btzqEJxOD68WsZlhpLBplRY29jeOUmfpevBCrT6BAdEkmhuPR9jjDgxPs
   2ZV/evkbbluEyvgKfzGWRHHC1ycI8ddYndDXeJZbfRmncvJo2pgflN3Tg
   GVdrrOeTpdHJ+sEePwZuMn3rG99YSHBQI1J8T5V1pQK9w/kxZtwLCPZUQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="335651889"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="335651889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:10:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="722931438"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="722931438"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:10:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 0/2] Copy-on-write poison recovery
Date:   Mon, 31 Oct 2022 13:10:27 -0700
Message-Id: <20221031201029.102123-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021200120.175753-1-tony.luck@intel.com>
References: <20221021200120.175753-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recover from poison consumption while copying pages
in the kernel for a copy-on-write fault.

Changes since v3:

1) Miaohe Lin <linmiaohe@huawei.com> pointed out that a recent change
by Alexander Potapenko <glider@google.com> to copy_user_highpage()
added a call to kmsan_unpoison_memory().  Same is needed in my cloned
copy_mc_user_highpage() ... at least in the successful case where the
page was copied with no machine checks.

2) Picked up some additional Reviewed-by and Tested-by tags.

Tony Luck (2):
  mm, hwpoison: Try to recover from copy-on write faults
  mm, hwpoison: When copy-on-write hits poison, take page offline

 include/linux/highmem.h | 26 ++++++++++++++++++++++++++
 include/linux/mm.h      |  5 ++++-
 mm/memory.c             | 32 ++++++++++++++++++++++----------
 3 files changed, 52 insertions(+), 11 deletions(-)


base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.37.3

