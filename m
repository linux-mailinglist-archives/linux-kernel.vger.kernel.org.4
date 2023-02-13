Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3D69489D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBMOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:50:32 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC41C320
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:50:28 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5UX5C028354;
        Mon, 13 Feb 2023 08:50:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=RFBJEatO/vsWNkGO54aXwHGrOOAWKM+ZNa81J3Z8pYQ=;
 b=CODnYzQ+wQhw60eQ/0MnEQP89Fxg3p4Bik0h6GNNDgAD9/HkN1tOIDiVVgWuTLPUBsWO
 KAj6n5IVvXRrCAEvGTyASfilcWhobNLHxz5bL2huG+rWcnREM4hKZH2JU1SNfZrleAiD
 xRx5Olbe9mHegeklMoURCGHFgI+4vWp9Mz4481o/5k/WF0h9xqFPcayHHY4XEntu77oE
 Jb8llVou1PxtNJU0X7t7xSkFD1QzCFm+1j3eXgGgPaYuJUKRCGEdYA1IZHow/k9QSUsG
 DOf5WEDSK53la+/XrJ8tWvQl4NDsTKiONRCtK3eqMnS036ei/0vs++hbFRChG+LbPvnr /g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3np9a72amh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:50:13 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 08:50:10 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Mon, 13 Feb 2023 08:50:10 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AF00EB0E;
        Mon, 13 Feb 2023 14:50:10 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/3] Fixes and Improvements for CS35L41 HDA
Date:   Mon, 13 Feb 2023 14:50:05 +0000
Message-ID: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zEjz3ARui3DbGe9xsOdn2PJLUMSlCXvz
X-Proofpoint-ORIG-GUID: zEjz3ARui3DbGe9xsOdn2PJLUMSlCXvz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes issue in calibration, where return codes were misinterpreted.
Enable High Pass filter to reduce pops and clicks.
Add improvement to ensure firmware and tuning files are always loaded
together. This ensure the firmware is alsways running with valid
coefficients.

Stefan Binding (2):
  ALSA: hda: cs35l41: Ensure firmware/tuning pairs are always loaded
  ALSA: hda: cs35l41: Enable Amp High Pass Filter

Vitaly Rodionov (1):
  ALSA: hda: cs35l41: Correct error condition handling

 sound/pci/hda/cs35l41_hda.c    | 109 ++++++++++++++++-----------------
 sound/pci/hda/hda_cs_dsp_ctl.c |   4 +-
 2 files changed, 56 insertions(+), 57 deletions(-)

-- 
2.34.1

