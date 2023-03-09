Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D96B1A48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCIEE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCIEES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:04:18 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05769CD6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:04:16 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32943g7q028914-32943g7w028914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Mar 2023 12:03:57 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v2 3/3] drivers/platform/x86/intel: fix a memory leak in intel_vsec_add_aux
Date:   Thu,  9 Mar 2023 12:01:07 +0800
Message-Id: <20230309040107.534716-4-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309040107.534716-1-dzm91@hust.edu.cn>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first error handling code in intel_vsec_add_aux misses the
deallocation of intel_vsec_dev->resource.

Fix this by adding kfree(intel_vsec_dev->resource) in the error handling
code.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/platform/x86/intel/vsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 13decf36c6de..2311c16cb975 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -154,6 +154,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
 	mutex_unlock(&vsec_ida_lock);
 	if (ret < 0) {
+		kfree(intel_vsec_dev->resource);
 		kfree(intel_vsec_dev);
 		return ret;
 	}
-- 
2.39.2

