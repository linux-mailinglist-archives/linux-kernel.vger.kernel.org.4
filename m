Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773555BFDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIUMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:19:09 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213B9751A;
        Wed, 21 Sep 2022 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663762747; x=1695298747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nx7suT77i0vv9jsbC1EL9C++ed10HTDGxOrFEJmIXWM=;
  b=jC0XaoYkak9M+ZrKkp8uZkHXtpPxEw7IwoyLOiSxuq4v6iLdhwB5qf05
   Cs/i57ThSzrwK8fmg1ZdWzXuCFUTZOe5AVoD/lr9EYmhXR03edv2qaLqF
   IeGsgeP8AXA1IytVx2Ddf20waC6OF+aZ7M1famXfIRrpZWkV6NUsLJ6Rw
   s=;
X-IronPort-AV: E=Sophos;i="5.93,333,1654560000"; 
   d="scan'208";a="1056600077"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 12:18:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com (Postfix) with ESMTPS id 7A902E014B;
        Wed, 21 Sep 2022 12:18:49 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 21 Sep 2022 12:18:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 21 Sep 2022 12:18:45 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 21 Sep 2022 12:18:45
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id A37F84AF7; Wed, 21 Sep 2022 12:18:44 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <sudipm.mukherjee@gmail.com>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v6 0/2] Variety of fixes and new features for mr75203 driver
Date:   Wed, 21 Sep 2022 12:18:42 +0000
Message-ID: <20220921121844.8059-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List of fixes:
 - Fix "intel,vm-map" property to be optional.
 - Fix VM sensor allocation when "intel,vm-map" not defined.
 - Fix multi-channel voltage reading.
 - Fix voltage equation for negative source input.
 - Modify the temperature equation according to series 5 datasheet.
 - Fix coding style issue.

List of new features:
 - Modify "reset" property to be optional.
 - Add optional "moortec,vm-active-channels" property to define the number
   of active channels per VM.
 - Add support for mr76006 pre-scaler to multiply the voltage result by 2.
 - Add support for series 6 temperature equation.
 - Add coefficient properties to fine tune the temperature equation.
 - Add debugfs to read and write temperature coefficients

---------

Changes between v5 and v6:
- fix undefined reference to `__divdi3' for 32-bit machines.

!!! Note: The patches of this series were pushed to hwmon-next and then
I got an automatic reply saying that these patches failed on some builds.
I sent separately an incremental patch which fixes the problem, and in
addition these two "replacement" patches for you do choose the option
you prefer. !!!

Changes between v4 and v5:
- 0004: Add detailed comment in code explaining the cast and the div instead of
  right shift or use of BIT().
- 0011: Fix typo in description (nou --> not).
- 0020: Return j coefficient to use debugfs_create_file() instead of
  debugfs_create_u32() because j is signed.
- 0021: Move the coding style patch to be last in the series (it does not fix
  the code), and remove the "Fixes:" tag.

Changes between v3 and v4:
*) Provide a Fixes tag for all fixes in the series.
*) Start series with fixes.
*) New patch to add description in moortec,mr75203.yaml.
*) New patch to add moortec to vendor-prefixes.
*) Fix moortec,mr75203.yaml checker errors.
*) Remove validation of device-tree parameters.
*) Fix per patch specific comments (detailed in each patch).

Changes between v2 and v3:
*) Add "moortec" prefix to all new device-tree properties.
*) Change order of patches.
*) Add explanations to better understand the changes.
*) Change "reset" property to be optional and remove the
  "reset-control-skip" property.
*) Split the patch for "fix multi-channel voltage reading" to two
   patches.
*) Change pre-scaler property format and fix typo (scalar --> scaler).
*) Fix voltage equation to support negative values instead of limiting
   value to zero.
*) Temperature equation - protect from overflow and add clamping.
*) Add new "moortec,ts-series" property to select between temperature
   equation of series 5 or series 6.

Changes between v1 and v2:
 *) Fix compilation error for patch 08/16:
    "warning: ISO C90 forbids variable length array"

---------

Eliav Farber (2):
  hwmon: (mr75203) modify the temperature equation according to series 5
    datasheet
  hwmon: (mr75203) add support for series 6 temperature equation

 drivers/hwmon/mr75203.c | 91 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 8 deletions(-)

-- 
2.37.1

