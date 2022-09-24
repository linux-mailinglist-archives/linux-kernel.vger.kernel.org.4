Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F55E889A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiIXFpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiIXFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:44:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360881F9F1;
        Fri, 23 Sep 2022 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663998278; x=1695534278;
  h=from:to:cc:subject:date:message-id;
  bh=90ic6Xwsrn9o/rFQdPQwmjtmJExTdJ/6twfK18KNT38=;
  b=FsTQYwCETtHvurkPABgBWArkUR2N+jx6ofsOxOLjVEmehZduDuSgF5+h
   lxZqeh4gSW2aEXKS74idIRt7Nlq5T74qZSFG0jI9TCPfnYKaPwA07QS21
   c3pUeCCB5cFw1gWCmAbKPiZOUKwARzWvhKCI5FYrywzzhJyG5YqC8blnc
   HUI1t6KXB2w7+FmZP4MDkXnJg+t7MQaeMnGGij4HzB2LLYUJ120H4wZXg
   SWEm1zkDJ36WArwyJhOcK3Whn7V6KHVycXy9kcq+qCOutmXKFCPbTxLY7
   D3WtYKp40fM4bZHtt+qHKyAau9MoQTbSI6sc8LOD+Uq1urFYUVnu31zVf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299470282"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="299470282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 22:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="651207759"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 22:44:33 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com
Cc:     mingo@redhat.com, linux-pm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: [PATCH 0/3] driver/tool fix for SPR Dram RAPL Domain
Date:   Sat, 24 Sep 2022 13:47:35 +0800
Message-Id: <20220924054738.12076-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
Dram RAPL domain, starting from HasWell-X.

But on SPR, this changes.
The Dram RAPL domain uses 61uj energy resolution, which follows the
standard energy resolution as described in MSR_RAPL_POWER_UNIT.

There are a couple of places that have implemented the energy unit quirk
for SPR Dram RAPL domain, including intel-rapl driver, rapl perf pmu and
the turbostat tool.

This patch series fixes them all, although they belong to different
components.

thanks,
rui
