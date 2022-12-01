Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2B63F1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiLANtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiLANtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:49:02 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE01AF01
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:49:01 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B17UFFc025878;
        Thu, 1 Dec 2022 07:48:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=gmXNj8zROSVD1MbqgWwzVfwby4Ly7Y38b4HHl5SlK/M=;
 b=HNvqyFZ5xufUCGcBuZv+RTCI7Q7LfQBvVhxoWS9srOdqaIUsN8uwtqujfejiqIlYzDer
 Mnt1p4Sm2W2vBzmDDguh65cLYqOMkBwYZUttzobqld7zXo5MHVUaSdXemzqJDyppM04z
 qbkawUNs8UZ8Qh1clict2RR4DxHln87qUtWmNRaXmb+AH3iH3Sz3pdqTFpnQXSCrAAeL
 AY/7XaqYyI82Qv7S2XXpB9jCdoaWY4J0gSCCzyhkhgw6HIQL/VuHx03uKHgVBR0iIYEk
 bxlLDGenJ/ne20poNxo0gFszX0lzY7eQAV4GVPVuCZIV39ahbLAluc0CoL8cCrospcJg XA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rhqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 07:48:48 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 07:48:45 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 07:48:45 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C8FFBB10;
        Thu,  1 Dec 2022 13:48:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] soundwire: cadence: Fix oversized FIFO size define
Date:   Thu, 1 Dec 2022 13:48:42 +0000
Message-ID: <20221201134845.4055907-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eEq9QWAMdEGspgc6f2zCYtGcS6UNNH_c
X-Proofpoint-GUID: eEq9QWAMdEGspgc6f2zCYtGcS6UNNH_c
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

Richard Fitzgerald (3):
  soundwire: cadence: Don't overflow the command FIFOs
  soundwire: cadence: Remove wasted space in response_buf
  soundwire: cadence: Drain the RX FIFO after an IO timeout

 drivers/soundwire/cadence_master.c | 45 +++++++++++++++++++-----------
 drivers/soundwire/cadence_master.h |  2 +-
 2 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.30.2

