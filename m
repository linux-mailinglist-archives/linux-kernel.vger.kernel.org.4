Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973796DDF93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDKPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjDKPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F914C15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:36 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5cuXH012801;
        Tue, 11 Apr 2023 10:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VR8dS9XHi/tcgg98tMyvu5oqdaqQI1zEFWEB3e2GIBY=;
 b=Rdn+cz2PuBzL5/nLw7ZZd+bzotn5bAQU7bm7EuXWXvgYoH/upMoYC6qDk5Abml4ndy4v
 cyHFtHdwxs4Otgq4BRmxkDBoUMLbKPBbAGDUdhX74rD20VEHeBLSxtygp1UscMXrYb8+
 6/0UbjZ7capl9N97eQhA4fSl6TAaX7l38P711OEAeBwwY8D27mE4/pXCxtvmQ540AxOO
 y+p2Py6Jv/on7ImAJZCpLKMvGxOoLQnzY0bPDQ1KAaGYv8E7k5yWywsEq2OOENX4dhRz
 3kgBXZyz4g6bmiiUq3gSJy22bJht4Pxz/5eYqnjnx0XHY0KX0IGa230Ftk3ds7xtxdKY Fg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EED115B6;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/6] ASoC: cs35l56: Skip first init_completion wait in dsp_work if init_done
Date:   Tue, 11 Apr 2023 16:25:25 +0100
Message-ID: <20230411152528.329803-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j7ttbEAZI4NGRR5EORvwAyFKfnenpTWr
X-Proofpoint-ORIG-GUID: j7ttbEAZI4NGRR5EORvwAyFKfnenpTWr
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the start of dsp_work() only wait for init_completion if !init_done.
This allows system suspend to re-queue dsp_work() without having to
do a dummy complete() of init_completion.

A dummy completion in system suspend would have to be conditional on
init_done. But that would create a possible race condition between our
system resume and cs35l56_init() in the corner case that we suspend right
after the SoundWire core has enumerated and reported ATTACHED.

It is safer and simpler to have cs35l56_init() as the only place that
init_completion is completed, and dsp_work() as the only place that
it is consumed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 997a5c5acaab..62c44276c121 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -866,7 +866,8 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	unsigned int val;
 	int ret = 0;
 
-	if (!wait_for_completion_timeout(&cs35l56->init_completion,
+	if (!cs35l56->init_done &&
+	    !wait_for_completion_timeout(&cs35l56->init_completion,
 					 msecs_to_jiffies(5000))) {
 		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
 		goto complete;
-- 
2.30.2

