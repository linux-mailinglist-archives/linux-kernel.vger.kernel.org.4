Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E156F5EDABF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiI1K6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiI1K6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:58:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461B27CF8;
        Wed, 28 Sep 2022 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362653; x=1695898653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tj6y2wR4OOWe+GceNfoaIX0k9DWCy81qn2nGdhvw8h4=;
  b=Z1ZXMrYo3YfAxKQBEzgqEEzoff9Ys6EtgV3do1glAUR0u7yv45GgMQ46
   bZImIHrX25iH/NUhjlMFpHtBT/MS/fJmskqX9MAzId559vTaUVExIt13j
   cMQUaZ3TCG2LyqTYeF2TKWwNB8a59OvOGkrwtVRspKqhD8rvTtbtPANsK
   faiPax/UBdGY/GdWr5LCCShHhbhXmjS781oIeRXd/S0UYafQtc8MZoq2x
   DJkiPd9mex2APRYvWq+c7OmNy1GM/WwfpkkRgcjSp5fWnSuXaj5R5to4g
   qolHpdy6GHJrrNyV1yU8myRL05KVzaftHxoo0pE5A7wb+WUyJG3GZkTuL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300288924"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300288924"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="572995037"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="572995037"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 03:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF9D6101; Wed, 28 Sep 2022 13:57:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/5] device property: Consitify a few APIs and correct dev_fwnode()
Date:   Wed, 28 Sep 2022 13:57:41 +0300
Message-Id: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changelog v2:
- fixed USB Type-C compilation issues (LKP)
- added tags (Sakari, Heikki)

Andy Shevchenko (5):
  device property: Keep dev_fwnode() and dev_fwnode_const() separate
  device property: Constify fwnode connection match APIs
  device property: Constify parameter in fwnode_graph_is_endpoint()
  device property: Constify device child node APIs
  device property: Constify parameter in device_dma_supported() and
    device_get_dma_attr()

 drivers/base/property.c     | 39 ++++++++++++++++++++++---------------
 drivers/usb/roles/class.c   |  2 +-
 drivers/usb/typec/mux.c     |  8 ++++----
 drivers/usb/typec/retimer.c |  2 +-
 include/linux/property.h    | 32 +++++++++++++++---------------
 5 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.35.1

