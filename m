Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20E719C83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjFAMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjFAMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:49:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD2123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:49:17 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3517gbC6006318;
        Thu, 1 Jun 2023 07:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Hx1i5w0nyq9m1kcDij6XJIcwI5RdLT1oMRmwl9V+aAY=;
 b=BOE56TmRBFMI+h6wValPkdM4oEacJCxKpdOREBByZ+4f1ztrUCDpQnWsFtTMUQ50+I4p
 6T1K/km7UApK4Zud9SV8j/Hvz7tzhcfaEbV8ftyYfTsxBVGptNXdUgoKAQV6R3s6UdSj
 k29Zd+I/mcVv1OrWU9YWgQjivsJstnrF+l0XIXqbNKvupP2NtabZLPOhWR/rjWQBB0J+
 f2XLUE2gj4K8l4aYC0ZiwKC6+H29btrTpE6B/iqJGMtL+sY4YibXFcbd+qVn97brCx1A
 JDbc9JoDQnx6wlDrHSnlwdY8Vd5saRc/8CQwXaFCO+KH3toALLZakadyaze2nam4Ghvl yw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mx9sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 07:49:09 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 13:49:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 13:49:08 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EE916468;
        Thu,  1 Jun 2023 12:49:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Remove NULL check from cs35l56_sdw_dai_set_stream()
Date:   Thu, 1 Jun 2023 13:49:07 +0100
Message-ID: <20230601124907.3128170-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NABGbYFSE8FDOgVXM9iuPK9CV-Gr3zMT
X-Proofpoint-ORIG-GUID: NABGbYFSE8FDOgVXM9iuPK9CV-Gr3zMT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma pointer must be set to the passed stream pointer, even
if that pointer is NULL.

Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 3c07bd1e959e..c03f9d3c9a13 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -704,9 +704,6 @@ static int cs35l56_sdw_dai_hw_free(struct snd_pcm_substream *substream,
 static int cs35l56_sdw_dai_set_stream(struct snd_soc_dai *dai,
 				      void *sdw_stream, int direction)
 {
-	if (!sdw_stream)
-		return 0;
-
 	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
 
 	return 0;
-- 
2.30.2

