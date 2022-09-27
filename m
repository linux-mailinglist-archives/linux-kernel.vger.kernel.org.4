Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430D5EC964
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiI0QYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiI0QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D8615E452;
        Tue, 27 Sep 2022 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295849; x=1695831849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I821oPWsGcmxj3gsCbxwKODNxXvvamxrISBk/ugf4To=;
  b=MOazgV0HQjyT9a7zoOMi9hn4ttklSPIBMSiPlPN/Li8IoIS+hbluCJxG
   gWk/k9rgahT8egqDfsbpL0OQhD7ThdQsv2SEtfmnWVpj06zuZY0ShudVL
   JhgPwiHM6y+iCCKJXujmdi8DMOy1CxG8JMy6qrBEZ4rUl1qYV8vrha1tX
   FkGxngikfA/x5GSkm5OLCReKie2qCXdaJQvDIFTsYKKlHABZww/30USJB
   sL3Ga3t+bo/AsPZMn4EtK9dKlkuAc1tnlTsGRlFC5s5Ak+VgNdMDCh0a3
   mU0+Y25ZPKbaQ7ac27izYjA3tYSjJDmd1ljjNGR9fIuZWAa+D0K6QEeUQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719511"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719511"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="763935895"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="763935895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2022 09:24:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F92D7C; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 0/7] pwm: lpss: Clean up and convert to a pure library
Date:   Tue, 27 Sep 2022 19:24:14 +0300
Message-Id: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, a set of cleanups and code deduplications (for better
maintenance) to the PWM LPSS driver.

Second, we may (re-)use the core part as a library in the future in
the devices that combine the same PWM IP in their address space. So
convert the core file to be a pure library which doesn't require any
special resource handling or alike.

Changelog v4:
- dropped the forward declaration use patch, seems too many questions to it

Changelog v3:
- postponed last patch until we have a new user
- added tags (Uwe, Hans)
- expanded commit message on why forward declarations are preferred over
  full header inclusions

Changelog v2:
- replace patch 1 by Uwe's version (Uwe)
- update NS patch to have a default namespace defined (Uwe)
- describe all changes done in patch 4 (Uwe)


Andy Shevchenko (6):
  pwm: lpss: Move exported symbols to PWM_LPSS namespace
  pwm: lpss: Move resource mapping to the glue drivers
  pwm: lpss: Use device_get_match_data to get device data
  pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
  pwm: lpss: Make use of bits.h macros for all masks
  pwm: lpss: Add a comment to the bypass field

Uwe Kleine-König (1):
  pwm: lpss: Deduplicate board info data structures

 drivers/pwm/pwm-lpss-pci.c      | 48 ++++++++-------------------------
 drivers/pwm/pwm-lpss-platform.c | 40 +++++++--------------------
 drivers/pwm/pwm-lpss.c          | 46 ++++++++++++++++++++++++++-----
 drivers/pwm/pwm-lpss.h          | 12 ++++++++-
 4 files changed, 72 insertions(+), 74 deletions(-)

-- 
2.35.1

