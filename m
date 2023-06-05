Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88580722B06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjFEP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjFEP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:29:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69144AF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:29:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558sEEF030588;
        Mon, 5 Jun 2023 10:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=S1uQnmsd6XI75wdABbJ0fjbAZApoBOSHGSUOv9rvCkk=;
 b=dVtrbMyXYgCf4pul4d65ZGFaruSCWu/pqTUtKD/pbep5bu8ide2FFp5mDfXVSAJbuRPH
 hUO28lFwXB5H9IHnEdmaemODkRtKWTG5wAJaRd+IhYzfENYyYqY6rMJTz9dv1Z7XhPdI
 JOZJmzOJ4vhoZbVZJl/PXgJV8B/0Ci1YSaPHIvfuZXyM5EojmRaSyH0+8qTujOTMxyID
 24TbKPg4twUXhnxD6TsXNrYufiHLGB7pVU3rbor5trCGCUs8DpwuxBoUbfAPggs7JMKp
 myPz5ASYpkS6TX54I7o/E4OH9Fl/qEt7TecqDnXs09N07dfOHx5IC15egsjp5lkd3cIi qw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xna179-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 10:29:04 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 16:29:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 5 Jun 2023 16:29:03 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (NEWNC1SL3J3.ad.cirrus.com [198.90.238.20])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B4E3011AA;
        Mon,  5 Jun 2023 15:29:02 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/3] Fixes and cleanup for CS35L41 HDA
Date:   Mon, 5 Jun 2023 16:28:52 +0100
Message-ID: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ah15Nc8gmTzw_xqjB7ubQJvp2NZAMdxh
X-Proofpoint-GUID: Ah15Nc8gmTzw_xqjB7ubQJvp2NZAMdxh
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

CHANGES SINCE V1:
Patch 2:
- Removed unnecessary cast

Stefan Binding (3):
  ALSA: hda: cs35l41: Clean up Firmware Load Controls
  ALSA: hda: cs35l41: Fix endian conversions
  ALSA: hda/realtek: Delete cs35l41 component master during free

 sound/pci/hda/cs35l41_hda.c   | 32 ++++++++++++++------------------
 sound/pci/hda/patch_realtek.c |  2 ++
 2 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.34.1

