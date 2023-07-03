Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E81745C13
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGCMTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGCMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:18:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A8115;
        Mon,  3 Jul 2023 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688386734; x=1719922734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKEsI2IZLID9V+jVyPeOLIm09S2eMx6zf5fhOw9OIoI=;
  b=YHqJwLJNb7/ukpW8F13QnQy/SFTrU5/IKJOttFJScWuHiddB6wlYWFme
   upzjd9wiy4KI7+2Lgf5nX/LGgKcOxmTb1m0UQJDwdyYRYG6RRx0DaVeoV
   nvOwQNYX4+Jy5t1OMbBzWXj+ZWFvGkBSE18SQaNTi9jyT8bvgUvMrJ1b8
   bt7zX7/DCgnJcP0GBoK72HYozYSokjW+aQm5Qe1wsZ3FAMysm+bEgzJVX
   F/EYyNY3l8Zwr7XqSC5ryAM6yg5JvsviBfOLOUempaleJUspdPJ5EjZHN
   lqFNgtwQ3gkK5238EoT4mvB9NKj6Z5SvcsUVYFxMZwkHq626OwtAjrHmE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="343200927"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="343200927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="831811639"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831811639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 05:18:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 133B1170; Mon,  3 Jul 2023 15:18:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 0/3] gpiolib: Avpid modifying GPIO chip fwnode
Date:   Mon,  3 Jul 2023 15:18:35 +0300
Message-Id: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally the GPIO chip data structure has to be constant.
In real life it's not true, but we can make it closer to
that. Hence the series.

Benjamin, would be nice it you can perform regression test for your
case.

Bart, the idea is that this series has to land immediately after
v6.5-rc1 is out so we will have longer time to fix any downsides
and regressions found, if any.

Andy Shevchenko (3):
  gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
  gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
  gpiolib: Do not alter GPIO chip fwnode member

 drivers/gpio/gpiolib-acpi.c |  2 +-
 drivers/gpio/gpiolib-of.c   |  6 +++---
 drivers/gpio/gpiolib.c      | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

