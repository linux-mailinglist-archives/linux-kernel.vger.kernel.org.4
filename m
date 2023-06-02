Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C071FEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjFBKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjFBKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:12:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A238C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:12:07 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3529pNL4008786;
        Fri, 2 Jun 2023 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BTOTTJsN7I2l8z0ulkqfI6NnphC4S4LDmAiJC+e0M4k=;
 b=BmLckQfCGiRPgUG00hU0t+BQGZiEQlhT8iN+alyjqAVfwtB6CBCtM7u0M86kz6oPo676
 R+0MB4dE80GdXKM3aNpW1omZg1x9lDaMZUHW70ZEWPazL/G3Ue6XKA9eXvXbYZS3f9ZN
 UNw//+QrxkqwKOHOdvzC9q5LoDKkGIm1dsYZoGlz5uIDWy1eJeZPYzkxHksBAtYvA6je
 optHCv7y5jjptr4vTDTVGh4p/QxT1FnlIrJx8QCyUE13YxMEHekglGTNGHklwOHbJY5j
 iwogYYsuzfEXjMkfnpwSnIQHGLRw5fWs5J52JWhSC6ZJoHHhmLPAASbTvJ32SRevmDdK pQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y83v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 05:11:42 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9DA8A468;
        Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/5] soundwire: stream: Add missing clear of alloc_slave_rt
Date:   Fri, 2 Jun 2023 11:11:36 +0100
Message-ID: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -nkIT4ZhmyRip5gK4eOuyv4GAWhgwrlz
X-Proofpoint-ORIG-GUID: -nkIT4ZhmyRip5gK4eOuyv4GAWhgwrlz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current path that skips allocating the slave runtime does not clear
the alloc_slave_rt flag, this is clearly incorrect. Add the missing
clear, so the runtime won't be erroneously cleaned up.

Fixes: f3016b891c8c ("soundwire: stream: sdw_stream_add_ functions can be called multiple times")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Added missing fixes tag

Thanks,
Charles

 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index c2191c07442b0..379228f221869 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -2021,8 +2021,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt)
+	if (s_rt) {
+		alloc_slave_rt = false;
 		goto skip_alloc_slave_rt;
+	}
 
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
-- 
2.30.2

