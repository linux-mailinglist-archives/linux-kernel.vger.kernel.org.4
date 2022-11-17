Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7762DDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiKQOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKQORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:17:47 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBD39A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:17:45 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHEHLJX006137;
        Thu, 17 Nov 2022 08:17:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=9yEHp/egchWRfHPnT1xfyvIZ2mplZmfmfcqa1wi4iyI=;
 b=OLvFHa3mhy1anDktf9WTk24BAR4+pwMUMpySk914z0E4QI9xTislS7qibaipa7fOx/ZS
 ovPCwnGSmAMK1/N4DR2RKVRR4RIBLnJQh0Tjp4f2VmRPkPWRDA/sV8t0zQWxWNfFBDAU
 LNg+/vkH0KDlJDXDJrFsdXVSavhFWNzvA91mTvCS/x02c2myIrmsnGpgLocsICtizs3+
 IjeIVrVFXaG+AzSIqb/0uzmDvpKf5mbx6Ct7Bn8yZGJ/wSxr3xKWc+QYsLcE0qnXmDiq
 ilOwDxgc0QmxafVGX21ABvIbkL7fhZ1hl7mIgppSXzFjPVg8tlvpjO27cUdvH7n0GjpI WA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kv73yk9j9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 08:17:30 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 17 Nov
 2022 08:17:27 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 17 Nov 2022 08:17:27 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA1D3478;
        Thu, 17 Nov 2022 14:17:27 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 0/4] Minor SoundWire clean ups
Date:   Thu, 17 Nov 2022 14:17:23 +0000
Message-ID: <20221117141727.3031503-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dOSossOFU5T-aHQuMsYooKw9VR_n5awR
X-Proofpoint-GUID: dOSossOFU5T-aHQuMsYooKw9VR_n5awR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some minor tidy ups and preparation for starting to upstream some
Cirrus SoundWire devices. The first three patches are pretty trivial,
the last patch which moves the remaining core over to using the no_pm
functions could probably use some careful review.

Changes since v1:
 - Update commit message on the debugfs to more explicitly mention the
   PM runtime reference, rather than implying the PM would turn on/off
   each time.
 - Added some reviewed by's

Thanks,
Charles

Charles Keepax (3):
  soundwire: Provide build stubs for common functions
  soundwire: debugfs: Switch to sdw_read_no_pm
  soundwire: stream: Move remaining register accesses over to no_pm

Simon Trimmer (1):
  soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions

 drivers/soundwire/bus.c       | 10 ++--
 drivers/soundwire/debugfs.c   | 11 +++-
 drivers/soundwire/stream.c    | 30 +++++------
 include/linux/soundwire/sdw.h | 94 +++++++++++++++++++++++++++++++----
 4 files changed, 114 insertions(+), 31 deletions(-)

-- 
2.30.2

