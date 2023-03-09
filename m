Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFC6B2845
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCIPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCIPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:06:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98104E4C73;
        Thu,  9 Mar 2023 07:03:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF6CEFEC;
        Thu,  9 Mar 2023 07:04:29 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5324F3F5A1;
        Thu,  9 Mar 2023 07:03:43 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 1/4] devres: Provide krealloc_array
Date:   Thu,  9 Mar 2023 15:03:30 +0000
Message-Id: <20230309150334.216760-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309150334.216760-1-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no krealloc_array equivalent in devres. Users would have to
do their own multiplication overflow check so provide one.

Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 include/linux/device.h                           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 4249eb4239e0..8be086b3f829 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -364,6 +364,7 @@ MEM
   devm_kmalloc_array()
   devm_kmemdup()
   devm_krealloc()
+  devm_krealloc_array()
   devm_kstrdup()
   devm_kstrdup_const()
   devm_kvasprintf()
diff --git a/include/linux/device.h b/include/linux/device.h
index 1508e637bb26..0dd5956c8516 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -223,6 +223,16 @@ static inline void *devm_kcalloc(struct device *dev,
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
+static inline __realloc_size(3, 4) void * __must_check
+devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+	return devm_krealloc(dev, p, bytes, flags);
+}
+
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-- 
2.34.1

