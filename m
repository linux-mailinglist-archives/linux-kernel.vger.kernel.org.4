Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE55FA356
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJJSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:24:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230911165;
        Mon, 10 Oct 2022 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665426279; x=1696962279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lV/sOxd9UMgNF8rqRvEeaHHOWcvWfkCR7DG0x3ALpa4=;
  b=euqbn5BzqcxrH7uaA0OULUoiQEDEoVhdVa3kv+BZEwFBLdYQUiolynhf
   XauWSgFaXc7ee/O5Z5HRJKaGGgTkWfumTjA117AJxkLBStTioct4iESNj
   mhIuuohJw4+N3R1xvYTFy5/tchPQfcv4nY2AspxLPn+YNcrLmv3jvVb/V
   ysQQYWirt4MXrMtBCMe7omuLapgjHPGDUr0RaLQCRZnIfRt7nHX6TQnUN
   GIPiXAaWcp9S1Q9gLqNEgf9kn7pn48dNX00/q+td4GYJ+rICpM2Xwx0Zu
   pBgUVf56c2FLRIr7UOiU5fPPC3YFityh+Bq44n4Dlibj68rj0l4HJwEVB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291592274"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291592274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 11:24:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="751448870"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="751448870"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 11:24:34 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] Change the I2C slave address for ds4422/4424 to its correct value
Date:   Tue, 11 Oct 2022 23:54:37 +0530
Message-Id: <20221011182437.662719-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet states that the slave address for the device is 0x20
when the pins A0 and A1 are ground. The DT binding has been using
0x10 as the value and I think it should be 0x20 as per datasheet.

Let me know if I am wrong about this.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---
 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index 264fa7c5fe3a..1955b1a97cd6 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -38,7 +38,7 @@ examples:
 
         dac@10 {
             compatible = "maxim,ds4424";
-            reg = <0x10>; /* When A0, A1 pins are ground */
+            reg = <0x20>; /* When A0, A1 pins are ground */
             vcc-supply = <&vcc_3v3>;
         };
     };
-- 
2.34.1

