Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2361572CB23
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjFLQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjFLQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:12:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDA118;
        Mon, 12 Jun 2023 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686586376; x=1718122376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IYt04gSUqk2jrpPKBFAhlqeGc+makPe+S7hTcL63yKA=;
  b=gYlSbBLTubETE886ni6fRCuGtHEDtvSVGP1lfjU7pAr8TPS0p4ERQf1M
   7SChy4LtG/I77zfwG5nTsFlaPBp0L4LwuWpz1h6CNQWnzDCYioP4ORJce
   yib/sj6JsSYLaEtPZssCMXUssIgGi9yUzIq8kqYzFzhINE/exX1Q4F5Zn
   WDoXPrQzcS3Q7vKnRjWcRC5/ey4Pic0d3kOKTfs2PpSn2tWDov/B3PUo8
   BGeupxmFk66NBVUC4kPShM8ef58rRiUVkvOvH2iAhSPQNgaqC2dphOj5Z
   +F/m2uhNSj0k3v3P8I9gU8aW3oLm7Dp/NHlz+5VMoklwvmGqTNg+sqnIM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360572675"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360572675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824031048"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="824031048"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 09:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C0544357; Mon, 12 Jun 2023 19:10:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 0/3] device property: Introduce device_is_compatible()
Date:   Mon, 12 Jun 2023 19:10:08 +0300
Message-Id: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new helper to tell if device (node) is compatible to the
given string value. This will help some drivers to get rid of unneeded
OF APIs/etc and in may help others to be agnostic to OF/ACPI.

While doing it, I have noticed that ACPI_DEVICE_CLASS() macro seems
defined in unsuitable location. Move it to the better one.

Last patch is an example of what the first two are doing.

The entire series can go, I believe, via ACPI (linux-pm) tree in case
the last patch gets tag from the respective maintainer.

In v3:
- added tag to patch 1 (Rafael), patches 2&3 (Sakari)
- made commit message text wider in patch 3 (Sakari)

In v2:
- updated commit message and added kernel doc for a new API (Greg)
- also replaced acpi_device_get_match_data() with the agnostic API
- tried to keep header inclusions ordered (to some extent)

Andy Shevchenko (3):
  ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
  device property: Implement device_is_compatible()
  ata: ahci_platform: Make code agnostic to OF/ACPI

 drivers/ata/ahci_platform.c     |  8 ++++----
 include/linux/acpi.h            | 14 --------------
 include/linux/mod_devicetable.h | 13 +++++++++++++
 include/linux/property.h        | 12 ++++++++++++
 4 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

