Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5C6BD57B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCPQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCPQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:23:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F176A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:23:34 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDV56A018052;
        Thu, 16 Mar 2023 16:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=DGUvrfDfGZ0mbCeDP3/EhKDi0cTkzcFUFWcFAevMCBI=;
 b=juqyQqagh6XfT4n0bC6pdOcYosEk5GGDLFnh82f1MBoagZUbQxz9lLyDWQ4pZsk1/JOj
 lSYjCdulBRqIZ3l6YPJPoXuCZcqhehcA3GcIyeNeKYETigB7q/cECgAKyPGVpVOwFory
 ediP4M3yG8Y/L1p9i2i8/8gPIboEjtQD8ixnIqjAdDMOWnx4eT6z+0Y4wtDy2qEL3UaV
 YUoUdHl0YPcvIhoqMyjHAVS/f28nwLb6qrhvGdW9QFmYzGi7ecq0lBXZcU4STx2Dvc8J
 IkTGvoT0Ner7Yl813JH3pBsXMhUjZplntzp08yg8w/8+u3eHF6qNWZyO3kRdj4uUoFZw kQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbst923ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 16:23:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GGNABF019780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 16:23:10 GMT
Received: from hu-visr-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 09:23:07 -0700
From:   Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
To:     <quic_visr@quicinc.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: codecs:rx-macro: Fixing uninitialized variables.
Date:   Thu, 16 Mar 2023 21:52:49 +0530
Message-ID: <20230316162249.17044-1-quic_visr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PRpImEHXJKZHExf2lT0jZY0_lmw7rFrh
X-Proofpoint-GUID: PRpImEHXJKZHExf2lT0jZY0_lmw7rFrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=725 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the uninitialized variables to avoid any unexpected garbage
value to be propagated further.

Signed-off-by: Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a73a7d7a1c0a..0c8b79ff2fc5 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2219,6 +2219,8 @@ static void rx_macro_hd2_control(struct snd_soc_component *component,
 				 u16 interp_idx, int event)
 {
 	u16 hd2_scale_reg, hd2_enable_reg;
+	hd2_scale_reg = 0;
+	hd2_enable_reg = 0;
 
 	switch (interp_idx) {
 	case INTERP_HPHL:
-- 
2.17.1

