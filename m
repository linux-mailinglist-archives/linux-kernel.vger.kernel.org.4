Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A66B2848
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjCIPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCIPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:06:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E2BFEBDB0;
        Thu,  9 Mar 2023 07:03:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4CDFC14;
        Thu,  9 Mar 2023 07:04:33 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20CAD3F5A1;
        Thu,  9 Mar 2023 07:03:47 -0800 (PST)
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
Subject: [PATCH v2 2/4] hwmon: pmbus: Use devm_krealloc_array
Date:   Thu,  9 Mar 2023 15:03:31 +0000
Message-Id: <20230309150334.216760-3-james.clark@arm.com>
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

Now that it exists, use it instead of doing the multiplication manually.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..e7bee25a3706 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1190,9 +1190,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
 {
 	if (data->num_attributes >= data->max_attributes - 1) {
 		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
-		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
-						new_max_attrs * sizeof(void *),
-						GFP_KERNEL);
+		void *new_attrs = devm_krealloc_array(data->dev, data->group.attrs,
+						      new_max_attrs, sizeof(void *),
+						      GFP_KERNEL);
 		if (!new_attrs)
 			return -ENOMEM;
 		data->group.attrs = new_attrs;
-- 
2.34.1

