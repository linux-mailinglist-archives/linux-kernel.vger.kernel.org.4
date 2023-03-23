Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF156C6E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCWQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCWQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:59:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA3BDA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:58:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NGhxFR029981;
        Thu, 23 Mar 2023 16:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=k0nkBOpBPQn3qEZsCqp0qC0xkDKC3vHQpmGwoMe+jmo=;
 b=0PtONMNRTTgheSl+oucIktTj3HqdJ9DHo5WegQEn7fJlll+6Fc3ZyHq2LikK7z1b95OO
 ZhmYRUs1sNXh3D0TpRZxdLkxocI53rkwPIkji3pEpOAAdo++mzKmUurUDWj6VHX2MQB5
 ZtzlvKjwKb0/VVEMPbu9Kefkd6CGh1R3rfg+PActM+EavLRZaqYyMXA4wr3XdBBejYHc
 N7cybiRGrS8Vr7McQXlNCriE/Hgc5SPV1gujO/IEd1MOnZbsJts30LgDWBjw54mhTtjj
 PvxKizOfFPtO0Bn/VSmSTmDmhMyHWFs3GTO6HMq6Zj6DDAWcSZPGPfcQDfvHGz59q0G0 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wtcbug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:58:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NGsQoc028052;
        Thu, 23 Mar 2023 16:58:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgtpvg4bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:58:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NGwTr4040712;
        Thu, 23 Mar 2023 16:58:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pgtpvg49s-1;
        Thu, 23 Mar 2023 16:58:29 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH next] ASoC: cs35l56: Fix unsigned 'rv' comparison with zero in cs35l56_irq()
Date:   Thu, 23 Mar 2023 09:58:25 -0700
Message-Id: <20230323165825.1588629-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230123
X-Proofpoint-GUID: LMFp-spo0qJRomp9eCU3LxurxeNtTS1d
X-Proofpoint-ORIG-GUID: LMFp-spo0qJRomp9eCU3LxurxeNtTS1d
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rv' is of type unsigned int, which can never be less than zero.

	rv = pm_runtime_resume_and_get(cs35l56->dev);
	if (rv < 0) { // can never be true.
		...
	}

As pm_runtime_resume_and_get returns integers, change the type of 'rv'
to int to fix this.

This is found by static analysis with smatch.

Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.
---
 sound/soc/codecs/cs35l56.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 90fc79b5666d..b3772005668a 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -321,7 +321,8 @@ irqreturn_t cs35l56_irq(int irq, void *data)
 	struct cs35l56_private *cs35l56 = data;
 	unsigned int status1 = 0, status8 = 0, status20 = 0;
 	unsigned int mask1, mask8, mask20;
-	unsigned int rv, val;
+	unsigned int val;
+	int rv;
 	irqreturn_t ret = IRQ_NONE;
 
 	if (!cs35l56->init_done)
-- 
2.38.1

