Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6D6E26F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDNP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDNP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:27:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2CFF33
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:26:35 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDVEGn030487;
        Fri, 14 Apr 2023 10:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=kQnGTPoOoJ60c3e4evHJ+bJMKizBYsYUfwtuqCqRn8o=;
 b=BLl04glH8O2G2+Bay7G9VpW6ysoD8gmG9mKMqumqnjWXsvaUpO+Nb/1+CSfFclVOjWar
 t5bAUAcHiA3fdNjNVmTmIbs4Gn4uiz0C8ASPByC3UjUSaJnqqWlHiSe9h1qrqw5FeA6v
 MneueOl5XwOOLRWILOy5Neb4hTBExU0X8fIeF0Zwm0K/zRo7r/25cvKXZQx8+qh4o27L
 LcrIe98FQIJulsr60aWqP3lF3uG+Xh4vOWoBQ7wxPrKLHilTd0YAorAw0zx0uHrlvwpu
 hWfAaJ9Mhl8HGZLE2rhbj59mo4e20S0c1Q51peHd21z4eUWKmoQTlOwJ5/TpaeZ0JP61 ew== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pu5p3skxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:26:01 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 10:25:59 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 14 Apr 2023 10:25:59 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 15AFF45D;
        Fri, 14 Apr 2023 15:25:59 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/4] Fixes and cleanup for CS35L41 HDA
Date:   Fri, 14 Apr 2023 16:25:48 +0100
Message-ID: <20230414152552.574502-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -yXugJRosrL2NPHbAT-fHWDQFid_X_ns
X-Proofpoint-GUID: -yXugJRosrL2NPHbAT-fHWDQFid_X_ns
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several minor issues were found during additional testing and
static analysis. These patches fix these minor issues.

Stefan Binding (4):
  ALSA: hda: cs35l41: Clean up Firmware Load Controls
  ALSA: hda: cs35l41: Fix endian conversions
  ALSA: cs35l41: Fix default regmap values for some registers
  ALSA: hda/realtek: Delete cs35l41 component master during free

 sound/pci/hda/cs35l41_hda.c    | 40 +++++++++++++++-------------------
 sound/pci/hda/patch_realtek.c  |  2 ++
 sound/soc/codecs/cs35l41-lib.c |  6 ++---
 3 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.34.1

