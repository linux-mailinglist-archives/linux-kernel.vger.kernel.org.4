Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D517750065
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGLHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGLHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:49:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3421987
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689148156; x=1720684156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4myecPwu5Ccazp290GdECvXjfGsVAVkoX8NsXNv5t8M=;
  b=ZlAl7rGgfkNG6voUNZFABF0rhIGrEhcsqQaRr8LN8NCdtQRpeRp6VJxn
   KCeuiZMppz7Qmqloe8/6RPdM7oF6YwkFe3sTGebtK97BvAHqkMztJBryt
   C+5eGEf3QI1wJQJ9+pLRKs6TlY37ixeJIrZNvUSe2PoZx10z/Kpl7ypP9
   7DxpnoMbRM7HCBL4wsGMdgbMMxTPqc3w8V6P6TCjtz4IqXl41IZwPqLV7
   vg+ViGCi8zZmJo0xc0YGNVppZ0A01RHdvW9wHkWvZ4Az0WuPGLB7W/5NO
   d/kZ6WksEhNXhTotCuQrndzT+KBVs5r+hMuzVRyRSVLy90j0MqppRihIz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354734482"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="354734482"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698744813"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="698744813"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:11 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
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
Subject: [PATCH 0/4] memory tiering: calculate abstract distance based on ACPI HMAT
Date:   Wed, 12 Jul 2023 15:48:56 +0800
Message-Id: <20230712074900.404064-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Changelog:

V1 (from RFC):

- Added some comments per Aneesh's comments, Thanks!

Best Regards,
Huang, Ying
