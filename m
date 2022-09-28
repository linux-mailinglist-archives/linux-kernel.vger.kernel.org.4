Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A295EDB55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiI1LIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiI1LH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4487372EF9;
        Wed, 28 Sep 2022 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363132; x=1695899132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPdA+Vj54wAFI0mdv+GFCa0+3HUZNcaM2unU7tyy9i4=;
  b=lxxSXuBaXASWxqCnsJTIlWVcns0mmil9zIXXaqEq/r5RjFxnTTxzShZv
   N9TqKRWsg+IxHd4ZcjM7V82XJ2mvuAtc2hu0JD/HlynTKYs65SvBvnlT3
   8T1q12fceJyDEfdLvqAJzMlM21lgyZY1v5f09SQksGk/LeNWrblFzlgl6
   4hKBVsoHbX2AzNC5wcWOMQ15Lcc1G878JnfY9yAWXGu5ftbzACKmGEcXI
   PzdMWscXxUqCYuOw4W9yWosgA2OYd2neynOWeUTwbLHgzxfYO2W/CulKp
   kFAYdHcsV7Ay+D5bi3X9k7iBIArwHTDeEuuZAUh4iaGFVt6jkkSdRc6wd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301548719"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="301548719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="624110588"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="624110588"
Received: from kjurkiew-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/4] Documentation: rs485: Mention uart_get_rs485_mode()
Date:   Wed, 28 Sep 2022 14:05:08 +0300
Message-Id: <20220928110509.13544-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to rs485 documentation that serial core prepares the struct
serial_rs485 when uart_get_rs485_mode() is called. Remove the wrong
claim that driver must fill it by itself.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/driver-api/serial/serial-rs485.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 513758a702a6..2951dacfb9eb 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -34,8 +34,8 @@ RS485 Serial Communications
    parameters in the platform data and in ioctls.
 
    The device tree can also provide RS485 boot time parameters
-   [#DT-bindings]_. The driver is in charge of filling this data structure
-   from the values given by the device tree.
+   [#DT-bindings]_. The serial core fills the struct serial_rs485 from the
+   values given by the device tree when driver calls uart_get_rs485_mode().
 
    Any driver for devices capable of working both as RS232 and RS485 should
    implement the rs485_config callback and provide rs485_supported in the
@@ -48,7 +48,7 @@ RS485 Serial Communications
    serial_rs485 structure matching to the current configuration.
 
 .. kernel-doc:: include/uapi/linux/serial.h
-   :identifiers: serial_rs485
+   :identifiers: serial_rs485 uart_get_rs485_mode
 
 4. Usage from user-level
 ========================
-- 
2.30.2

