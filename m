Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8C6C10B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCTLXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCTLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF702101
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6vbPo027039;
        Mon, 20 Mar 2023 06:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KSx4vfnoG0hKeX0+I8Xc6vC4Q61Hdoi1UYzczfNsx1Y=;
 b=BQNxWbGH7SKB3VY+kGUk3uN5aDgbnmRvb7obwKuA3UbVlwsyq9JpYQ9ZgZDgnzU343fl
 vy7tJdcy2+WDtvJyJTRAC8hYkQbgIFJ1Fb5R6PNyiqkW9GUXDdMF183Izbf91GLRFr3/
 kOeWy4ZstEoyikWzffg7T0Vurz+Y/p0f6CN+lrjDfL+RHkSp6AbHprLfCOyCFyVa0TCD
 U+oLPjH9BcgHHXUIf9laWxz7jlzVMp8h9LnxXQxTVDbCkUtLNq7zQ+fqVwiEYG0vSR/V
 5oW37KuyFqJMB+4nQrlfA9QG7SRfbVr+Y38oC96POiae0/w9DUtlFTqFOUSMJJaZpzmA +A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc81-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:47 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 20 Mar 2023 06:22:45 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B2B0511DF;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 3/8] firmware: cs_dsp: Support DSPs that don't require firmware download
Date:   Mon, 20 Mar 2023 11:22:40 +0000
Message-ID: <20230320112245.115720-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VVtWws-JhmrYTN5s-NHe_po4VymYe0KK
X-Proofpoint-ORIG-GUID: VVtWws-JhmrYTN5s-NHe_po4VymYe0KK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

When a DSP can self-boot from ROM it is not necessary to download
firmware during the powering up sequence.

A DSP that required firmware download would fail in a previous
configuration step if firmware was not available.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 97b73a254380..513136a924cf 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1301,6 +1301,9 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	int regions = 0;
 	int ret, offset, type;
 
+	if (!firmware)
+		return 0;
+
 	ret = -EINVAL;
 
 	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-- 
2.30.2

