Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AC5B87D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiINMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiINMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:10:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226CD1AF11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:10:12 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EBk1kU005558;
        Wed, 14 Sep 2022 07:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=EOARaYc2S+ew884K44tVuUsKMHmr9kDDFDJICHbqRuw=;
 b=l+Z6LGJpyrg6aGFoytXcWMNHV4l4ajfAbdv/CL93dNCO6ob5A9oQVZq+vAIOgzItD+oS
 59geBN7k4dnoT9/EFdZct9vl4eHAWLWESvu1Zrp4tgcBKRxiqbDpsqCRbbWTYel+y1rN
 rowk806DNZX1htXImHzhub6RTRLZiL1UNw61TbwFMKyZCf2oG6JLx0HLlUhRUvrVh4FN
 UpiBfN9x1OWZNKC5jei3kcKmrdAipmIOekZJ+3+0mpvmvjK3AocoEDdJFOeiLXLLrnQ+
 N2Er75hWTuaeUtmaaZLAeswph1GALO3Vb+hcHnm1h6o0QVT+i9dB/huK9KVJazwWRuxR QQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05gy54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 07:09:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 07:09:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 07:09:56 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 76B6B468;
        Wed, 14 Sep 2022 12:09:49 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 0/5] soundwire: Fixes for spurious and missing UNATTACH
Date:   Wed, 14 Sep 2022 13:09:44 +0100
Message-ID: <20220914120949.747951-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iKkd_DNj7wn3UYxCoMjXCKVBSqaTZNhp
X-Proofpoint-ORIG-GUID: iKkd_DNj7wn3UYxCoMjXCKVBSqaTZNhp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus and cadence code has several bugs that cause UNATTACH notifications
to either be sent spuriously or to be missed.

These can be seen occasionally with a single peripheral on the bus, but are
much more frequent with multiple peripherals, where several peripherals
could change state and report in consecutive PINGs.

The root of all of these bugs seems to be a code design flaw that assumed
every PING status change would be handled separately. However, PINGs are
handled by a workqueue function and there is no guarantee when that function
will be scheduled to run or how much CPU time it will receive. PINGs will
continue while the work function is handling a snapshot of a previous PING
so the code must take account that (a) status could change during the
work function and (b) there can be a backlog of changes before the IRQ work
function runs again.

Tested with 4 peripherals on 1 bus, and 8 peripherals on 2 buses.

CHANGES SINCE V2:
#4 Add a comment explaining why INTMASK isn't cleared when going around
   the update_status loop.

#5 Leave the existing error handling in sdw_program_device_num(),
   instead of suppressing the error return.
   Add a comment in sdw_handle_slave_status() explaining why the error
   is ignored.
   Re-word the explanation of why sdw_handle_slave_status() must only return
   early if it programmed a device ID.

Richard Fitzgerald (4):
  soundwire: bus: Don't lose unattach notifications
  soundwire: bus: Don't re-enumerate before status is UNATTACHED
  soundwire: cadence: Fix lost ATTACHED interrupts when enumerating
  soundwire: bus: Don't exit early if no device IDs were programmed

Simon Trimmer (1):
  soundwire: cadence: fix updating slave status when a bus has multiple
    peripherals

 drivers/soundwire/bus.c            | 44 +++++++++++++---
 drivers/soundwire/cadence_master.c | 80 ++++++++++++++++--------------
 2 files changed, 80 insertions(+), 44 deletions(-)

-- 
2.30.2

