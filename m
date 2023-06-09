Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B674B729E49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbjFIPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbjFIPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:25:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7EC359A;
        Fri,  9 Jun 2023 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324310; x=1717860310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qtaVsvzDvJRlb72B8amTkVRnjCIA4psIcmOP5FzGYL4=;
  b=EhGSr0SUm8Z82+s0D5WQeuXJxq1pBaMT8JX+rS5betEx/IGmxI1xaYaX
   Auh2MLR/jsh7pe9kXaReOfvm2pIXpa00Iu7IQ/MJso5x8KIWXaK5tl5jQ
   jSjz9kYCNRrgejpMlxshe8qkKyHCop1GtD5qUAM/KzhBMLJgqmx0z+JPR
   Um1rAJJ4Y2RRse3KWpLsd9yMlr3r7NLVBTxxkCUeJIVg3GPAZRHBiGxZ+
   rZU6IMYcqPxp2RcLmS2qOU/WofIxRWoFdTDMLm89N7BVJVcJHWQ+YM86M
   dkaLXzT/BBEL1FzmTccilJQDguV4A2/uJDnBxPI33b0TVp/O2zhULw9dq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357623168"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357623168"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="775532600"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="775532600"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2023 08:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59DD134C; Fri,  9 Jun 2023 18:25:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 0/3] device property: Introduce device_is_compatible()
Date:   Fri,  9 Jun 2023 18:25:04 +0300
Message-Id: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Andy Shevchenko (3):
  ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
  device property: Implement device_is_compatible()
  ata: ahci_platform: Make code agnostic to OF/ACPI

 drivers/ata/ahci_platform.c     |  6 +++---
 include/linux/acpi.h            | 14 --------------
 include/linux/mod_devicetable.h | 13 +++++++++++++
 include/linux/property.h        |  5 +++++
 4 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

