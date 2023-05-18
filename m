Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1270848F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjERPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjERPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9919A6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IBl9Gj018534;
        Thu, 18 May 2023 10:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=PzbNKkrCmjMmdURz8o4J0PDSkAM+7W10ivnlAga8Xug=;
 b=J4z8R9BIpvmUQiZdzpZYv0TyUDhrh/Nnly/TVJkFE23i/YkS5Mb1E3SC+tOgQdGgZgyA
 9R6Me61XXI3AJXWI5Ruziw2k+KYMby8QCuzEbkEDZ14P7Kc85zOnlzyaakBgvhjNivsG
 O9gIZcyd+qFDF7BwYPtXXBs3/weHSYUd//56FQ/JjHSSD0fp/kwR616LkkHoxCfHhRmo
 T3cB4JmsHkXG66H9C9DygZBIZYrlfJjkRL2A7bVuyFUKkasXvEYxJbUB358Oue/e/vSx
 NtHfkh2W84HgNuT6mK7d+h1NlNTYfJ9R0Ysau5WplNx4u4mvqSdNGLfbMi5WBrhfrH4M Mg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1ghum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:02:51 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 10:02:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 10:02:50 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1C51A11AA;
        Thu, 18 May 2023 15:02:50 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ASoC: cs35l56: Bugfixes and efficiency improvement
Date:   Thu, 18 May 2023 16:02:47 +0100
Message-ID: <20230518150250.1121006-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gomk2pLzyO6OLFycpvAZ3G1YC6WQa618
X-Proofpoint-ORIG-GUID: Gomk2pLzyO6OLFycpvAZ3G1YC6WQa618
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First two patches are bugfixes.
Third patch skips the overhead of rebooting the amp after applying
firmware files when we know that it isn't necessary.

Simon Trimmer (3):
  ASoC: cs35l56: Move DSP part string generation so that it is done only
    once
  ASoC: cs35l56: sdw_write_no_pm() should be performed under a
    pm_runtime request
  ASoC: cs35l56: In secure mode skip SHUTDOWN and RESET around fw
    download

 include/sound/cs35l56.h    |  1 +
 sound/soc/codecs/cs35l56.c | 65 +++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 19 deletions(-)

-- 
2.30.2

