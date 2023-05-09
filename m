Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47BB6FC32E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEIJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjEIJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:50:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7997AD9;
        Tue,  9 May 2023 02:50:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8220106F;
        Tue,  9 May 2023 02:50:44 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.83.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D40323F67D;
        Tue,  9 May 2023 02:49:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux@roeck-us.net, michal.simek@amd.com,
        Jonathan.Cameron@huawei.com, James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v4 1/4] devres: Provide krealloc_array
Date:   Tue,  9 May 2023 10:49:38 +0100
Message-Id: <20230509094942.396150-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509094942.396150-1-james.clark@arm.com>
References: <20230509094942.396150-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no krealloc_array equivalent in devres. Users would have to
do their own multiplication overflow check so provide one.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 include/linux/device.h                           | 11 +++++++++++
 2 files changed, 12 insertions(+)

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
index 472dd24d4823..58f4f5948edb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -223,6 +223,17 @@ static inline void *devm_kcalloc(struct device *dev,
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
+
+	return devm_krealloc(dev, p, bytes, flags);
+}
+
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-- 
2.34.1

