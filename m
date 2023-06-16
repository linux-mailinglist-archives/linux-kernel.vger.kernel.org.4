Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69567732863
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjFPHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjFPHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:06:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A433359B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686899191; x=1718435191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M0OygmRxLHAfZzm9jNjkf3WbF1uCya+4PDPVrbfQybk=;
  b=KNMSy3ecGDIrEsR8yGwth22GyL0itpN3PKHoGVVKQ0kxhBcVL9JfEWPC
   9Uy7yowLJ06PgiFHpMevqNgQGsGdBPn+Cx0K3bw8sdGajlwv6/8N9cp/1
   TZzIDqzUCpQnW/wD/nL9dAgySZRTU5GFTrplchwx+v0rNeLfyrnryspJg
   1FORgz1RpcNBZEI6SQazgai1j/4xq+zthhQegmITcxD3QgrkBQKboHCbt
   1DOojfAILTG75kjKVifw9vlsfIPkS6B3l1NcQYrNO2uicvrA8KEK7wHcE
   9F41LuP/1nbFUcSIuaTQlYPupNO0zbDas+A9h6chfTTyUt5lzJngxgDDB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361668661"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361668661"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782783457"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="782783457"
Received: from cpeng15-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.216])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:06:04 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [RFC 0/4] memory tiering: calculate abstract distance based on ACPI HMAT
Date:   Fri, 16 Jun 2023 15:05:34 +0800
Message-Id: <20230616070538.190042-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the explicit memory tiers framework to manage systems with
multiple types of memory, e.g., DRAM in DIMM slots and CXL memory
devices.  Where, same kind of memory devices will be grouped into
memory types, then put into memory tiers.  To describe the performance
of a memory type, abstract distance is defined.  Which is in direct
proportion to the memory latency and inversely proportional to the
memory bandwidth.  To keep the code as simple as possible, fixed
abstract distance is used in dax/kmem to describe slow memory such as
Optane DCPMM.

To support more memory types, in this series, we added the abstract
distance calculation algorithm management mechanism, provided a
algorithm implementation based on ACPI HMAT, and used the general
abstract distance calculation interface in dax/kmem driver.  So,
dax/kmem can support HBM (high bandwidth memory) in addition to the
original Optane DCPMM.

Best Regards,
Huang, Ying
