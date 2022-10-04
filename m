Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C407B5F3F68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJDJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJDJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D84BD3D;
        Tue,  4 Oct 2022 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875277; x=1696411277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pt0n1aB0LMPRDjsyTB7IIWaL5FA8Ek48kf3cB2KqDzQ=;
  b=eV1WFqx1yh5UC7BtS8UO0diTBc/fLBVHo+v4BqAkm2eH0rJbZrGstqhx
   CelhAlwBxmj8ZKR6JgnzPMsPBukVVGyYcZGWodbOXzJk3qv39gIgtFU+B
   aI82Sqm6pzVnLiP+CnUWEbCGJ95JIy9w8URNRURPN5BDdkPxeBS9Iw+uS
   jbxxM4GSsezbaldLJ0XSrDghgs7VKC9AvGY7gSaz5ozeV3xm5wtvWjNET
   3UKZhvTwZcH1WSatVcJcPMntjJV2McYYx5QYIe1fHseNVno8RnD3uG1CP
   swmpc0PEth5yfgQmeMjrtw/RBRt8u29C0OtMCZ5tpUPt/05mRZkJ1RLV6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303824989"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="303824989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623865974"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="623865974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2022 02:21:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 746A7D0; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 0/5] device property: Consitify a few APIs and
Date:   Tue,  4 Oct 2022 12:21:24 +0300
Message-Id: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property.h has inconsistency in how we annotate the parameters which
are not modified anyhow by the certain APIs. Also dev_fwnode() needs to
be rectified in sense of the handling const qualifier.

This series improves the above with only a couple of APIs left for now
untouched (PHY, which I believe doesn't belong to property.h to begin
with).

Changelog v3:
- used _Generic() to hide the _const API (Sakari, Greg)

Changelog v2:
- fixed USB Type-C compilation issues (LKP)
- added tags (Sakari, Heikki)

Andy Shevchenko (5):
  device property: Allow const parameter to dev_fwnode()
  device property: Constify fwnode connection match APIs
  device property: Constify parameter in fwnode_graph_is_endpoint()
  device property: Constify device child node APIs
  device property: Constify parameter in device_dma_supported() and
    device_get_dma_attr()

 drivers/base/property.c     | 29 ++++++++++++++++++-----------
 drivers/usb/roles/class.c   |  2 +-
 drivers/usb/typec/mux.c     |  8 ++++----
 drivers/usb/typec/retimer.c |  2 +-
 include/linux/property.h    | 34 +++++++++++++++++++---------------
 5 files changed, 43 insertions(+), 32 deletions(-)

-- 
2.35.1

