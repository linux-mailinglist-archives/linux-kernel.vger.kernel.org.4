Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5233774A520
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGFUtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjGFUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:48:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869E1999;
        Thu,  6 Jul 2023 13:48:51 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366KjTLe017117;
        Thu, 6 Jul 2023 20:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=b79BcXvQmnlmQlBDw6mPCA6xTXg5Ay/WPEH8NQCJFI0=;
 b=UWOLGpqCIeXmZuOllJtf7+TR6nJA314toKOBgN/RSH3ft8/UHhCA7cw142ayOaHYuu5X
 WErfJ353HgszS6oJqERQGjulD9nAURnW9zUmFRZ5Ym7In68YAOnledPwzkB6WSmNS1Is
 ZxowvcJzldjmPIzHKgy5jGPLrjpiLbShYYeMffKbXrTayDsH9oeDN9fw+Wv/9W1rGheh
 6lfQ0XxIH7WvL6bwaD9InFED6ewslLeHwi6rg0eadadW0bYs9Upss49Ai3cmad8NKlkW
 oesfjXxc9cURR6+HlI6MpdTde3EmhUvoUmzPeHYvNLB4fL2Q3+JLRnH6Eb25hWY/TjUJ Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn152mkyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 20:48:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Kmg5e012429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 20:48:42 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 13:48:41 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Subject: [PATCH v4 0/6] Add support to print sub-block registers in dpu hw
 catalog
Date:   Thu, 6 Jul 2023 13:48:31 -0700
Message-ID: <20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAop2QC/4XOwU7EIBAG4FfZcHYMBYXWk+d9hDXGwDBsSYRWa
 MmaTd9dujdj4h7/yfzfzJUVyoEKezlcWaYaSphSC08PB4ajSWeC4FpmggvJlRDgqOKUya1x/pj
 NgiM4r6n3yjslBWs9awqBzSbhuDePJ4glQqLLAp9rNOd9Z87kw+V29+295TGUZcrftzdqt0//u
 1g74CCtQIeozLNWr19rwJDwEafIdq+Ku4ZoxkADN712cpD+ryHvGrIZvVS8s1qQVfq3sW3bD/u
 1WglgAQAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <quic_jesszhan@quicinc.com>, Ryan McCann <quic_rmccann@quicinc.com>
X-Mailer: b4 0.13-dev-8a804
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688676521; l=2532;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=PgNP3gzdyaYFYW3q6PGzg06XWo8vkrVTmwP22RidTms=;
 b=KeBm4c1gni399zPePKnOzEuxzrjvdvx+Th5QzdDHN7ICoBvjn0zxyn2IWblWzk4jAHqvMj1E1
 p/xqmd2hbp7CNLG6tXLpFEJQDT4DjUmc78JXwAuyqD518Xn7JcwGvNH
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HmikSv82Um0JpEXK7lUC1GkUjlpqPFzw
X-Proofpoint-ORIG-GUID: HmikSv82Um0JpEXK7lUC1GkUjlpqPFzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=955
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is to add support to print the registers
of sub-blocks in the DPU hardware catalog and fix the order in which all
hardware blocks are dumped for a device core dump. This involves:

1. Changing data structure from stack to queue to fix the printing order
of the device core dump.

2. Removing redundant suffix of sub-block names.

3. Removing redundant prefix of sub-block names.

4. Eliminating unused variable from relevant macros.

5. Defining names for sub-blocks that have not yet been defined.

6. Implementing wrapper function that prints the registers of sub-blocks
when there is a need.

Sample Output of the sspp_0 block and its sub-blocks for devcore dump:
======sspp_0======
...registers
...
====sspp_0_scaler====
...
...
====sspp_0_csc====
...
...
====next_block====
...

---
Changes in v4:
- Added review tags
- Link to v3: https://lore.kernel.org/r/20230622-devcoredump_patch-v3-0-83601b72eb67@quicinc.com

Changes in v3:
- Split sub-block changes and main block changes into two commits
- Corrected typo in comment located in DSC for loop block
- Eliminated variables mmio and base
- Dropped unnecessary "%s"
- Link to v2: https://lore.kernel.org/r/20230622-devcoredump_patch-v2-0-9e90a87d393f@quicinc.com

Changes in v2:
- Changed spelling "sub block" to "sub-block" or "sblk".
- Capitalized DPU.
- Eliminated multiplexer/wrapper function. Inlined instead.
- Changed if statements from feature checks to length checks.
- Squashed prefix and suffix patch into one.
- Link to v1: https://lore.kernel.org/r/20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com

---
Ryan McCann (6):
      drm/msm: Update dev core dump to not print backwards
      drm/msm/dpu: Drop unused num argument from relevant macros
      drm/msm/dpu: Define names for unnamed sblks
      drm/msm/dpu: Remove redundant prefix/suffix in name of sub-blocks
      drm/msm/dpu: Refactor printing of main blocks in device core dump
      drm/msm/dpu: Update dev core dump to dump registers of sub-blocks

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 90 +++++++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 94 ++++++++++++++++++-----
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |  2 +-
 3 files changed, 120 insertions(+), 66 deletions(-)
---
base-commit: a0364260213c96f6817f7e85cdce293cb743460f
change-id: 20230622-devcoredump_patch-df7e8f6fd632

Best regards,
-- 
Ryan McCann <quic_rmccann@quicinc.com>

