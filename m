Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AF6883B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBBQIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:08:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46D4EDD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:08:42 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312BYUTG028651;
        Thu, 2 Feb 2023 09:42:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Mn4lAOTs+GTgL2RAnuWKoGB9jj5s+bhKNye0fFsP4NM=;
 b=RXJzRnQFj1S/gXEszIi/ota6zhQaNoKlF7VkEzwJrFw9CJ8SJKD7DHKQvoG5n2tA9+YQ
 nxyaMMA6T59WpVq+NpRfzRDbAzDv22U7O0WeFf0HE5KuOUXWnpIXEMepP4MBRWTQhpSE
 EHRUZbmH3G3wdtrtOSKcKiolPS7epJZbh9+jdDWzIubNTt8UdtGU7F2pQ9ycG+hP7big
 JDzqzVKkb02u4jBWGzTPMqkeWVqLbfDMoPyVfiS+KssHuLgjYynYSMb1mXflSqWw66we
 8HmOHrJWGPIszUPYE3quKZNWmlGUepyouJPcX/trfpLryJ/cCG8aycm8I53zTKwbwp1l Qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nfqv9j15f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 09:42:13 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 2 Feb
 2023 09:42:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Thu, 2 Feb 2023 09:42:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25FF1B06;
        Thu,  2 Feb 2023 15:42:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: bus: Prevent infinite loop in sdw_ch_mask_to_ch()
Date:   Thu, 2 Feb 2023 15:42:11 +0000
Message-ID: <20230202154212.1098736-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230202154212.1098736-1-rf@opensource.cirrus.com>
References: <20230202154212.1098736-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: a5gOryFcbXVJmWujMZzjE485Q9BkEFzX
X-Proofpoint-ORIG-GUID: a5gOryFcbXVJmWujMZzjE485Q9BkEFzX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the ch_mask argument of sdw_ch_mask_to_ch() as an unsigned
so that the shift right is guaranteed to eventually make the
value of ch_mask==0.

Previously ch_mask was defined as a signed int, but a right
shift of a signed value preserves the sign bit. So if the sign
bit was 1, ch_mask would never become 0 and the for loop would
be infinite.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 7631ef5e71fb..28bedc919b78 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -160,7 +160,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
 
 /* Retrieve and return channel count from channel mask */
-static inline int sdw_ch_mask_to_ch(int ch_mask)
+static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
 {
 	int c = 0;
 
-- 
2.30.2

