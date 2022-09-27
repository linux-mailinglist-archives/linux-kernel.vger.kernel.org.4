Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3145EC6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiI0Ouc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiI0Oth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3F7B29E;
        Tue, 27 Sep 2022 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290059; x=1695826059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p5Qv2eGvYShww3iG5RQvavskwhXcWdaFVSnEf+pwu2Q=;
  b=RsuvcpIiWPb/0vGUuj53YobuohMVgxsAm3IaZ4S+B2FPq8zs6vsItef6
   lfcsJs6P0GvIsc+R2FEOxaIQmH8dpYECCy27K4cooa56fS33fKBOWOx4r
   uEkq/KHSaEip/Vv/bbXY59Tjdlsw8VbFJK6WZcciw6OuFd9GZkE8dXkBj
   t45sJjBqILTEiSZlyfiyy+/s/XL3ZLTbNAJiUxtduOQRoPSccA8Og4U6J
   i+803f9iWl3mSlfPALo4Pm2U19E4IJCXsbMMKr0tp1yyL8PrLDU3Umx17
   6QncXVic+zbTz+9aTdMavIHXdvF3+YUXnqyu8FEgvzfEtzZcY7jYtYu4G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365377091"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365377091"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="796788628"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="796788628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2022 07:47:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CB1B7C; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 0/8]  pwm: lpss: Clean up and convert to a pure library
Date:   Tue, 27 Sep 2022 17:47:15 +0300
Message-Id: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changelog v3:
- postponed last patch until we have a new user
- added tags (Uwe, Hans)
- expanded commit message on why forward declarations are preferred over
  full header inclusions

Changelog v2:
- replace patch 1 by Uwe's version (Uwe)
- update NS patch to have a default namespace defined (Uwe)
- describe all changes done in patch 4 (Uwe)

Andy Shevchenko (7):
  pwm: lpss: Move exported symbols to PWM_LPSS namespace
  pwm: lpss: Move resource mapping to the glue drivers
  pwm: lpss: Include headers we are direct user of
  pwm: lpss: Use device_get_match_data to get device data
  pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
  pwm: lpss: Make use of bits.h macros for all masks
  pwm: lpss: Add a comment to the bypass field

Uwe Kleine-König (1):
  pwm: lpss: Deduplicate board info data structures

 drivers/pwm/pwm-lpss-pci.c      | 48 ++++++++-------------------------
 drivers/pwm/pwm-lpss-platform.c | 40 +++++++--------------------
 drivers/pwm/pwm-lpss.c          | 46 ++++++++++++++++++++++++++-----
 drivers/pwm/pwm-lpss.h          | 18 +++++++++++--
 4 files changed, 77 insertions(+), 75 deletions(-)

-- 
2.35.1

