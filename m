Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF8708FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjESGoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjESGow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:44:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325912C;
        Thu, 18 May 2023 23:44:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwuPT031081;
        Fri, 19 May 2023 06:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=4oNhK5bI3ELvlGqoTiZpXVakPRt4I4zhn01DypkCTuU=;
 b=vHpJsLtOCuGjDVvI+Grka5J69Lq73Mo5k1ajAMUbJlV6/cigVbSQDK9PwrdCaXhcQ2Zq
 Ep/RqTrmUhXvU/AtokzjlzJNidDEsJM3aRfTPZzFxRrUQV7fEq1DjboyRJUFUWMoE/x4
 yyalZGSFJTxL9lau1Xo1tHpCE1RzbatfQ+44pv7ax0qYQu/sQZGh4rpd1b3Mz+/owabY
 4pnVZeH1pW9+lipLHGLoPwQh/ke8jW5R4lqb+kXs9PJrfCCQDbOueioD0QDl3CXN+6nv
 u7qBCd/xn0yRdbpuHYbXGlHtOCt9BIAt43k4gdVHRTOGpdE250T2/QG9rZrjBXaHyrAg HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye9dw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 06:44:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4sQX0032130;
        Fri, 19 May 2023 06:44:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10ds5s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 06:44:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J6i9Sp020634;
        Fri, 19 May 2023 06:44:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10ds5rg-1;
        Fri, 19 May 2023 06:44:09 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Jyri Sarha <jyri.sarha@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     harshit.m.mogalapalli@oracle.com, error27@gmail.com,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoC: SOF: Intel: hda-dai: Fix locking in hda_ipc4_pre_trigger()
Date:   Thu, 18 May 2023 23:44:01 -0700
Message-Id: <20230519064404.1659637-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190057
X-Proofpoint-ORIG-GUID: wCdIePPxMFhs_7bZc9g6lp4a3Jb7qIx4
X-Proofpoint-GUID: wCdIePPxMFhs_7bZc9g6lp4a3Jb7qIx4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hda_ipc4_pre_trigger() has two issues:
 1. In the default case, we are returning without unlocking the mutex.
 2. In case SNDRV_PCM_TRIGGER_STOP: when ret is less than zero it goes
    to out, unlocks but returns zero instead of a negative value.

Fix this by changing the final return value to 'ret' instead of zero,
and initialize 'ret' to zero in the start of the function.

Fixes: 225f37b578a9 ("ASoC: SOF: ipc4-pcm: reset all pipelines during FE DAI hw_free")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested. This is found using static anlysis with Smatch.
---
 sound/soc/sof/intel/hda-dai-ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index 5a508e118e3d..1e58256c8003 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -183,7 +183,7 @@ static int hda_ipc4_pre_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cp
 	struct sof_ipc4_pipeline *pipeline;
 	struct snd_sof_widget *swidget;
 	struct snd_soc_dapm_widget *w;
-	int ret;
+	int ret = 0;
 
 	w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
 	swidget = w->dobj.private;
@@ -208,11 +208,11 @@ static int hda_ipc4_pre_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cp
 		break;
 	default:
 		dev_err(sdev->dev, "unknown trigger command %d\n", cmd);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 out:
 	mutex_unlock(&ipc4_data->pipeline_state_mutex);
-	return 0;
+	return ret;
 }
 
 static int hda_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
-- 
2.31.1

