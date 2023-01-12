Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A3667D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjALSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjALR7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:59:13 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774417DE10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:18:55 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CF7JfB026944;
        Thu, 12 Jan 2023 11:18:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=8fSn5PYok2HyiBJHUX0VCw/NoxuoKaAtRo9nnHocTh4=;
 b=q7770HfMMnuPHtZaMAFtcGESlFdlVhICD4Yw3hZRa4yPHGhjfdwt4sm3JmlbuS816/Ff
 hkRqzrRqGzr6ePdBzfHGjXUv4hemHAqzr7rPC4dzRXWNk2a9xrbX3oGGbrmr7nPGuV2R
 YwtLbcofTzsybeaP+dHXoj6erVWqOz70jvSs2vtNospnoxtFyxuDoCMSTJW+3piJDzVI
 oAvN8LwoLCDtkDaN2NR88b1sEaxz5mjNEsGZILgmumWB1U8u07RqWdeGwoKseNxrL0JE
 cVG1Ut1RiJCg8uCbOiOREukPg6TbY13inWj5R8xACe0hCcqM3ejL55bn0iuxqs0rz10e Tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n1k582d2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:18:42 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 12 Jan
 2023 11:18:40 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 12 Jan 2023 11:18:40 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 65BB7B06;
        Thu, 12 Jan 2023 17:18:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 0/2] Minor SoundWire Regmap Tweaks
Date:   Thu, 12 Jan 2023 17:18:38 +0000
Message-ID: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ySHobv6tXBNYeDEePWYeip3Cq5N0TR20
X-Proofpoint-GUID: ySHobv6tXBNYeDEePWYeip3Cq5N0TR20
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One minor correction to a comment and updating the allowed register
sizes for the SoundWire register map, to allow support of additional
hardware.

NOTE: The second patch requires the patch commit 62dc9f3f2fd0
("soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm
functions") from Vinod's SoundWire tree to build, so not sure if we want
to push these patches through his tree or merge his tree across.

Thanks,
Charles

Charles Keepax (1):
  regmap: sdw: Update misleading comment

Lucas Tanure (1):
  regmap: sdw: Remove 8-bit value size restriction

 drivers/base/regmap/regmap-sdw.c | 41 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 16 deletions(-)

-- 
2.30.2

