Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F896C9A17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC0DXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0DXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:23:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEB3C03;
        Sun, 26 Mar 2023 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679887395; x=1711423395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=46OuCpHR7I1TBuW4LEDNPfbhWolqhDpGbZEMvNDcTWk=;
  b=DPyQ5cVZrs0dOEV9RrwxMrfQ2LXl2BBdodBZKEjFizDZmaOhS3foZpyH
   85lOcdX75hg8u+p1ngBMXR9Fe7M0kEFUda6txRS2b+c9ElJywxZFeMItN
   x3EQZaAZl2Xdq2AxE3j5VezbBdcbUriklVGN50xd6+3RGfd9unSTP2WeW
   jG8dTMpKX49t9c8fCspI3WNZKrF8XsFLbbDYh//sCDsWymI0iZpg5Mc3r
   7D+81Zj/l5DIZ4/p6/R+NVHDQrfKCE0Je6WwEWIcgQAK/IY6BlisVnYx1
   y/97MgjERsQtunbKMPYKfBf3o16TAS9yht4rWgotVIvxGinA6VhGQ39Fu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367911076"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367911076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 20:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747837538"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="747837538"
Received: from atesfaye-mobl2.amr.corp.intel.com (HELO tmalhotr-NUC8i7HVKVA.amr.corp.intel.com) ([10.209.171.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 20:23:14 -0700
From:   Tanu Malhotra <tanu.malhotra@intel.com>
To:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        even.xu@intel.com, Tanu Malhotra <tanu.malhotra@intel.com>,
        Shaunak Saha <shaunak.saha@intel.com>
Subject: [PATCH] HID: intel-ish-hid: Fix kernel panic during warm reset
Date:   Sun, 26 Mar 2023 20:23:10 -0700
Message-Id: <20230327032310.2416272-1-tanu.malhotra@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During warm reset device->fw_client is set to NULL. If a bus driver is
registered after this NULL setting and before new firmware clients are
enumerated by ISHTP, kernel panic will result in the function
ishtp_cl_bus_match(). This is because of reference to
device->fw_client->props.protocol_name.

ISH firmware after getting successfully loaded, sends a warm reset
notification to remove all clients from the bus and sets
device->fw_client to NULL. Until kernel v5.15, all enabled ISHTP kernel
module drivers were loaded after any of the first ISHTP device was
registered, regardless of whether it was a matched or an unmatched
device. This resulted in all drivers getting registered much before the
warm reset notification from ISH. Starting kernel v5.16, this issue got
exposed after the change was introduced to load only bus drivers for the
respective matching devices. In this scenario, cros_ec_ishtp device and
cros_ec_ishtp driver are registered after the warm reset
device_fw_client NULL setting. cros_ec_ishtp driver_register() triggers
the callback to ishtp_cl_bus_match() to match driver to the device and
causes kernel panic in guid_equal() when dereferencing fw_client NULL
pointer to get protocol_name.

Fixes: f155dfeaa4ee ("platform/x86: isthp_eclite: only load for matching devices")
Fixes: facfe0a4fdce ("platform/chrome: chros_ec_ishtp: only load for matching devices")
Fixes: 0d0cccc0fd83 ("HID: intel-ish-hid: hid-client: only load for matching devices")
Fixes: 44e2a58cb880 ("HID: intel-ish-hid: fw-loader: only load for matching devices")

Signed-off-by: Tanu Malhotra <tanu.malhotra@intel.com>
Tested-by: Shaunak Saha <shaunak.saha@intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 81385ab37fa9..4f540906268f 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -241,8 +241,8 @@ static int ishtp_cl_bus_match(struct device *dev, struct device_driver *drv)
 	struct ishtp_cl_device *device = to_ishtp_cl_device(dev);
 	struct ishtp_cl_driver *driver = to_ishtp_cl_driver(drv);
 
-	return guid_equal(&driver->id[0].guid,
-			  &device->fw_client->props.protocol_name);
+	return(device->fw_client ? guid_equal(&driver->id[0].guid,
+				  &device->fw_client->props.protocol_name) : 0);
 }
 
 /**
-- 
2.34.1

