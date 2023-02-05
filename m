Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8868B12A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBESLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBESLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:11:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FF17CCF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675620705; x=1707156705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e1opZqKkh+952WgoqPDknLF4hNPbO/hMnwuC2MKLUlA=;
  b=Z1icy1lN9P8DbugI0LxgCjaDOFZ4SXNxtsv7XSBewtt/+CIxNVhEZC/r
   BMZvUyx4V8HjqWdaH1NrHDPqWyojOHzICEiHmVI1xTbrqfOYPtq6jd+J8
   mTVF20TiE6ql72ha9HIayyQeERTluNPd4MLR/+vBNRs4XvM0sXlnNTu0u
   nKM+Jsv74hGl+k0jj/PUuBsurRpohDIOorALSiD844uMZ0R7H83xq6CCK
   2ForyKSAGA7F32k55A5Z/K/+J9FXv9aFzZ3/ilAQWkGVxtF+8m0ijLcXG
   JMAzIDmtHMzFuHve+S88b/cPnBv27B0RExWlypgJ6IincltfolK4J0rEg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="326762222"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="326762222"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 10:11:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="666286294"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="666286294"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 10:11:42 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 0/2] mei: gsc proxy component
Date:   Sun,  5 Feb 2023 20:11:30 +0200
Message-Id: <20230205181132.191064-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC Proxy component is used for communication between the
Intel graphics driver and MEI driver.

V2:
1. Add missing patch from the series
2. Use device information instead of driver name
   to identify the aggregate device.

Alexander Usyskin (2):
  drm/i915/mtl: Define GSC Proxy component interface
  mei: gsc_proxy: add gsc proxy driver

 MAINTAINERS                                |   1 +
 drivers/misc/mei/Kconfig                   |   2 +-
 drivers/misc/mei/Makefile                  |   1 +
 drivers/misc/mei/gsc_proxy/Kconfig         |  14 ++
 drivers/misc/mei/gsc_proxy/Makefile        |   7 +
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 208 +++++++++++++++++++++
 include/drm/i915_component.h               |   3 +-
 include/drm/i915_gsc_proxy_mei_interface.h |  36 ++++
 8 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mei/gsc_proxy/Kconfig
 create mode 100644 drivers/misc/mei/gsc_proxy/Makefile
 create mode 100644 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
 create mode 100644 include/drm/i915_gsc_proxy_mei_interface.h

-- 
2.39.1

