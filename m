Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246946574EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiL1JtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiL1JtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:49:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F07EB49D;
        Wed, 28 Dec 2022 01:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672220942; x=1703756942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yU+IUmQfSh+UET7NDCHWOSlIxzsrLUTzFQXUM3vCfV8=;
  b=T4GGucjpqJQB5roGyH9QGg8hhWBc4W+sc50QiHvtwDQfTw0IUMObtXpl
   b70AkGSVDT+88PzqmAhdIMQWZ/6bR6TWQbMY6UjVztomSQOTBu9cLcaF4
   0dhYk8KfrZrT3n91EgnrlYuaBOdOmLgvEyjGpv5yuDwCQ4dYHP429UzV2
   rBU7qf1NuIg9BnzdEIEpCA4HmKJDRkMf8qQ5bPTuMXun4xMWLCdNhA+lW
   IBjUO58GVmRC1fYM0MV7+tBOMQMOM2MOXw5HmIm4J145aVueGLuca7FaD
   pmmPFJcpgzl6H5PqHAvnetCb11u5FXHR72/9I1DcMMvJUyz8D42yKd5af
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322823319"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322823319"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="685655145"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="685655145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Dec 2022 01:48:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4906EF8; Wed, 28 Dec 2022 11:49:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v3 0/4] software nodes: Get rid of rarely used APIs
Date:   Wed, 28 Dec 2022 11:49:18 +0200
Message-Id: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single user of software_node_register_nodes() and
software_node_unregister_nodes(). Convert it to what others use and
remove the unneeded APIs.

Since we have maintainers' tags applied it can be routed either through
driver core or media tree — whatever you prefer.

v3: added tags (Sakari, Greg)

Andy Shevchenko (4):
  media: ipu3-cio2: Don't dereference fwnode handle
  media: ipu3-cio2: Convert to use software_node_register_node_group()
  software node: Switch property entry test to a new API
  software node: Remove unused APIs

 drivers/base/swnode.c                      | 61 ----------------------
 drivers/base/test/property-entry-test.c    | 30 +++++------
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 27 ++++++++--
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  5 +-
 include/linux/property.h                   |  3 --
 5 files changed, 39 insertions(+), 87 deletions(-)

-- 
2.35.1

