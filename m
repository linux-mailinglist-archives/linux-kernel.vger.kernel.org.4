Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADADB63F24B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLAOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:08:27 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3812B55C97
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:08:27 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B15l1wq016609;
        Thu, 1 Dec 2022 08:08:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=OAeXJUG9JxNW9ViIVVYNmzT5WW5f5Y+/yMr6G1/gMN0=;
 b=PIMUZJ1PsXKYvd14axMh2bifD7D0i1fy9v8+5E95NI7pFBtk87lMs6QAgNbESYOpGQSQ
 G5AY7SNg0jpawSmncV3pDva/2imXOHH0YZ8zsyleujZzNiRtlVZdmcc0wzQNMBPUygS+
 Juut3u2uybJy8AFu2nwybHHadJJ1WZoKa7H0g96vgtfOKDqkVwtTAXUYKxh4lUYDAAR6
 IvTu0bbyfzgugVUmkK/7bj5w8LtoEoYgyD+TVW7ZHxI3F/fNb2R657n6OMldHYKABj9L
 ezdIP1BKTGZvPQzLTg/6fTHRihMVUJyUJu895ziKLOiQFAiDWgbm1xI8t2a0EY3HXYgG pA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rjwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 08:08:15 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 08:08:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 08:08:13 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2482DB10;
        Thu,  1 Dec 2022 14:08:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] soundwire: Remove redundant zeroing of page registers
Date:   Thu, 1 Dec 2022 14:08:11 +0000
Message-ID: <20221201140813.4062146-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v_PsVJysNjyRP6paHQlVdnfdSQ0y3tEG
X-Proofpoint-GUID: v_PsVJysNjyRP6paHQlVdnfdSQ0y3tEG
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

