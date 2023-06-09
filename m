Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA75729F16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbjFIPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbjFIPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:49:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A28359D;
        Fri,  9 Jun 2023 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325738; x=1717861738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kOCx0QRpqvaaVLOmLE4ZMvn4JCpJBQVlhraQgfxDKLE=;
  b=XS57XqNKFxynEclagnQwort/ASNV4+6pnEbSmoWnkwpK8Q07vq+DVFGV
   NmgvurQKsCAq1qjU9w7Dwsw0sEPgAkamPgUY1S7x2Zgc4mWPhXLsd5/8w
   qAEdbo20HmGM4NwPhT9ikRx/v9Rokf6fCD4efh8HUCvvZKkDRCzRxnBIJ
   d8N2W2E4d9fbNkqAtpLZ8Upl82sdXABldq1GRIMmJv9bQZHHCwyuKisP0
   GPfH/iqUC6YEZ+ruupIhHI0fQNby0Ls05uh61F0wwvNxO3UDNoBGoL6PK
   pyU/Trn5mL3gVpmUKTdfPKaNik/URLgl90jDTAZopW9zR5ymWlcker2aK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423504352"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="423504352"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854785635"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="854785635"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 08:48:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4ECA234C; Fri,  9 Jun 2023 18:49:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Subject: [PATCH v2 0/3] device property: Introduce device_is_compatible()
Date:   Fri,  9 Jun 2023 18:48:57 +0300
Message-Id: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
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

