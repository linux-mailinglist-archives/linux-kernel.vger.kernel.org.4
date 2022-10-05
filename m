Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14895F5784
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJEP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiJEP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:29:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE5AF;
        Wed,  5 Oct 2022 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664983773; x=1696519773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DzvXpY92dl8nC6GNWGmVSLtEet2B9qn61IBFwM95YnI=;
  b=X6HVCqGZqd/T5ZNg1CkuzPX4SYiqLEOBZ+OkiTgec/67CDFVDgMWy+rJ
   HKZ/l4U8XSkZ7G8KwFjzeO4HcNpVO6qXS9eVglOc8fM9luwtQHbxKQPoa
   aFMIEMYaYHf5UsQM14cN2aCIYtQAxJv2lMqBSKs8Iln4+kYiE28JYXQ2f
   /Z6ESjbmaquPi7pgRC66V9MuyBFlsRIyOQ1BzNqG0I3X5oXnmnRk/EHgl
   JYMYT1fzH0I8wQDMj/pyr6PdICZayL39Y1ViJ1HASA09FOfKZ1BQNkp5j
   2CPynBu9XC+lP56D2edbP8zmK8pnxYERQqMowDU8FktB3hFzjJZYsVkPC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301905841"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="301905841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 08:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="686993833"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="686993833"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2022 08:29:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 05724155; Wed,  5 Oct 2022 18:29:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 0/2] gpiolib: more cleanups to get rid of of_node
Date:   Wed,  5 Oct 2022 18:29:45 +0300
Message-Id: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more user outside of GPIO library and pin control folders needs
to be updated to use fwnode instead of of_node. To make this easier
introduce a helper in property.h and convert the user.

Note, the helper will be useful not only for the current users,
but any future ones that want to replace of_device_is_compatible()
with analogous fwnode API.

Changelog v2:
- placed new helper correctly in the property.h

Andy Shevchenko (2):
  device property: Introduce fwnode_device_is_compatible() helper
  soc: fsl: qe: Switch to use fwnode instead of of_node

 drivers/soc/fsl/qe/gpio.c |  4 +++-
 include/linux/property.h  | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.35.1

