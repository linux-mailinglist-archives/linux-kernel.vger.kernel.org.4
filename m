Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61285678223
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjAWQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjAWQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:50:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43EB2943F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:50:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N91JmA009174;
        Mon, 23 Jan 2023 10:49:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=EEhuc1uSnv3B2TkErgB0IZM1Fy5T36RVXG2x8hfUnXE=;
 b=hBFPFsymmu3H+/BHZj3a529128yyGXpK8EB+hgapYnvSQKMhHyJqLf5KrYRjcCeZqjU7
 em+qzvG0wW0CKavGbkXclYwnxJUEFawB9BDF0/apmiikl7VOgSu1FmR1ZJOU9mX8muQQ
 PDe+7w3pTHh0fUySXP0MWWgqwTGHEfYqPve9Q9C4RJig9U2rnVK7uTRRzgESpGcOznZJ
 4JCQ0o6UMEsmZLYrolRfmg0Id+HTUv/kGVsH+2je397tmFhgWqZNGhaJLIjy68aMaf+8
 d5X1t4vjxlJl9hh+17iOfYshunl7WFKys8HJ1fcGLv1XrJiUdejOvmnJsEHLwYSpDKQt 2w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsknrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:49:51 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 10:49:49 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 23 Jan 2023 10:49:49 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 460382C5;
        Mon, 23 Jan 2023 16:49:49 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/2] soundwire: Remove redundant zeroing of page registers
Date:   Mon, 23 Jan 2023 16:49:47 +0000
Message-ID: <20230123164949.245898-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G-ubMUt4tlVURYgmRyjxWCcoLjCi4wnn
X-Proofpoint-GUID: G-ubMUt4tlVURYgmRyjxWCcoLjCi4wnn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing zero to the page registers after each message transaction can add
up to a lot of overhead for codecs that need to transfer large amount of
data - for example a firmware download.

There's no spec reason I can see for this zeroing. The page registers are
only used for a paged address. The bus code uses a non-paged address for
registers in page 0. It always writes the page registers at the start of
a paged transaction.

If this zeroing was a workaround for anything, let me know and I will
re-implement the zeroing as a quirk that can be enabled only when it is
necessary.

Changes since v1:
- Reworded the commit message to patch #1:
  - say that this is for devices that support paging
  - mention bit 15 as the paging flag
  - split a long sentence into two sentences.

No code changes.

Richard Fitzgerald (2):
  soundwire: bus: Don't zero page registers after every transaction
  soundwire: bus: Remove unused reset_page_addr() callback

 drivers/soundwire/bus.c             | 23 -----------------------
 drivers/soundwire/cadence_master.c  | 14 --------------
 drivers/soundwire/cadence_master.h  |  3 ---
 drivers/soundwire/intel_auxdevice.c |  1 -
 include/linux/soundwire/sdw.h       |  3 ---
 5 files changed, 44 deletions(-)

-- 
2.30.2

