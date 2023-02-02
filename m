Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAA6883C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBBQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:09:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81B68AE2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:09:30 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3128sUna006230;
        Thu, 2 Feb 2023 09:42:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=xMHV4CLWUb6PJcec7V3W92cUq1tvU/om/xhGtlKhqIA=;
 b=L26ceYX7gAK7obVwfsL0dtxJ/AmXLFjAQC4P94IQZvIU2Ew25J/p8ULb6WUiRRhxUyn2
 pdiJcKyZKU/J1udfHVnNBD0848Lxn9B/A3MuQwccBnXN7fV3K3lFmwu1Ctgo722WQIpB
 Pe5g4cursqi/woFf4XnGG5NeDsCfur+FWEIQ0/kwMU1s8501ICBvcDSWLYV/N7ONW959
 VGcosf7Dngq6tQrtRLL2OyjGuMUJnLwIOyMkTt0CHm2QEOtXu99DcqVv5GwhE2cm0z4r
 XKQi4Z7QGuoXIE9WuH49ZwKZxh+FVFldj5jlYxKfvN5WY3oVZEB8XCDYXzhnKWKpXchV QQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nfqvj1qk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 09:42:14 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 2 Feb
 2023 09:42:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Thu, 2 Feb 2023 09:42:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 157A32A1;
        Thu,  2 Feb 2023 15:42:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] soundwire: bus: Prevent infinite loop in sdw_ch_mask_to_ch()
Date:   Thu, 2 Feb 2023 15:42:10 +0000
Message-ID: <20230202154212.1098736-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: diV5BAf5ozNS9-SugnjdEbV_Sq1BrcxD
X-Proofpoint-ORIG-GUID: diV5BAf5ozNS9-SugnjdEbV_Sq1BrcxD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_ch_mask_to_ch() would loop forever if bit 31 of the mask was set.
The entire function is unnecessary because the existing standard
function hweight32() already does the same thing, and hweight32() is
safe. But the change has been made in two steps.

Richard Fitzgerald (2):
  soundwire: bus: Prevent infinite loop in sdw_ch_mask_to_ch()
  soundwire: bandwidth allocation: Use hweight32() to calculate set bits

 drivers/soundwire/bus.h                          | 11 -----------
 drivers/soundwire/generic_bandwidth_allocation.c |  3 ++-
 2 files changed, 2 insertions(+), 12 deletions(-)

-- 
2.30.2

