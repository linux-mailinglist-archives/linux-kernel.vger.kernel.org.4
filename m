Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A700B7187EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjEaRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEaRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:02:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774D13E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:02:44 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VGt5lG014447;
        Wed, 31 May 2023 12:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Q+bH1la1wWK9pGjCcwcHQ8LiJYhGaZp0HJpX1acTJyE=;
 b=UP0ZGQZ9fbFajE9OwZD4yhv2nHQUyRYunLvdXtjhUxQDzIfyY8ZAF+2hq6mT8XPrTNH/
 HWNi7xIEEPVK26/Dk/fKgVKTvluBe3Vz/n1sjFnfp4BfZespNfp+3qXnTfLXv+lCYtTv
 M3V8zaIAKcpiP/pdsgnb7aVDnm5KekrqLlwKqVBH1wdoemsfcTo3OmJDsLBvH3vhzlLP
 XWku8Jsxs9gGC+nfOPWceXZvAvJtL3ZVQWu9S46vK3eaDtfyRxo6elzWwNgh1+Q+l55+
 7t7l4y1mHgxk2DZWJvt0z8libeG0NyoIY+63tWg6QDf6ZGGlnj/JDew8YCSEwzB6KpJs jA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90vquq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 12:02:00 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 18:01:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 18:01:58 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9EEB45;
        Wed, 31 May 2023 17:01:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Log that a bin file was loaded
Date:   Wed, 31 May 2023 18:01:58 +0100
Message-ID: <20230531170158.2744700-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0qvnEfe6ssnlN3bUqX0tHfH3rHOW3NDt
X-Proofpoint-ORIG-GUID: 0qvnEfe6ssnlN3bUqX0tHfH3rHOW3NDt
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

Change the message at the start of bin file loading from
cs_dsp_dbg() to cs_dsp_info() so that there is confirmation
in the kernel log that a bin file was loaded, and the name
of the file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index e4ccfb6a8fa5..d7e46a57ecf9 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2059,10 +2059,10 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		goto out_fw;
 	}
 
-	cs_dsp_dbg(dsp, "%s: v%d.%d.%d\n", file,
-		   (le32_to_cpu(hdr->ver) >> 16) & 0xff,
-		   (le32_to_cpu(hdr->ver) >>  8) & 0xff,
-		   le32_to_cpu(hdr->ver) & 0xff);
+	cs_dsp_info(dsp, "%s: v%d.%d.%d\n", file,
+		    (le32_to_cpu(hdr->ver) >> 16) & 0xff,
+		    (le32_to_cpu(hdr->ver) >>  8) & 0xff,
+		    le32_to_cpu(hdr->ver) & 0xff);
 
 	pos = le32_to_cpu(hdr->len);
 
-- 
2.30.2

