Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A33640AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiLBQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLBQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:37:25 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDBB0B45
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:37:24 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B28j12k022681;
        Fri, 2 Dec 2022 10:18:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=RIFCmyy6/4s76okPuZ7eQuTU58jGZcnvgrzMHZqxzxY=;
 b=mAE7Tqx7LOPHnchN2hJ3/2V2i231GtpO4kElveA8j+WCzOAc80n4NmkTlqEoSZD0gVnG
 be56TQwteIRDe1Z3RoOO+ZzPZ9x2RqzVIuAVjpiCy6wr01GfqAovyAUmSMbsWC2zqEul
 wzkWI1IetFJXQTCWNgNvRL6vc/JMi0nw3Gczy7Wvd6EmCQjXIia//LStczR2ubvptL++
 Ezf+OgYtsGM/M+pgpmUDYXtPRYx3RZXOMg9a0R03xnEBani+6dcboONc2WuZEV1nXJCR
 z80hHYo/z8EdTHeLpkl6+fd2cGSMF9Ehk3KqTALxsRYeQ3zDXH3cGoLjbajN5PJmjBHE aA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k2vt0n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 10:18:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 2 Dec
 2022 10:18:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 2 Dec 2022 10:18:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 71E17B10;
        Fri,  2 Dec 2022 16:18:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/3] soundwire: cadence: Fix oversized FIFO size define
Date:   Fri, 2 Dec 2022 16:18:09 +0000
Message-ID: <20221202161812.4186897-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: s3b6a1tc7ugk36PbSMbViYKf154AY-yy
X-Proofpoint-ORIG-GUID: s3b6a1tc7ugk36PbSMbViYKf154AY-yy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As determined by experimentation and asking a hardware person, the FIFO
in the Cadence IP is actually only 8 entries long, not 32. This is fixed
in patch #1.

As a bonus, patches #2 and #3 fix two other things I noticed while
debugging this.

Changes since v1:
- Rewrite commit message of patch #1
- Only reduce response_buf to 34 (32 + 2)
- Trim RX_FIFO_AVAIL to length of response_buf instead of expected
  FIFO size

Richard Fitzgerald (3):
  soundwire: cadence: Don't overflow the command FIFOs
  soundwire: cadence: Remove wasted space in response_buf
  soundwire: cadence: Drain the RX FIFO after an IO timeout

 drivers/soundwire/cadence_master.c | 46 +++++++++++++++++++-----------
 drivers/soundwire/cadence_master.h | 13 ++++++++-
 2 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.30.2

