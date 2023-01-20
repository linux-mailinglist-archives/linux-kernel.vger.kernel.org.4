Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5A6752FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjATLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjATLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:06:32 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E1C26589;
        Fri, 20 Jan 2023 03:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674212791; x=1705748791;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=r4eVcY5PWTSkhuZjkCI/FpAddwZzhCktbJKHEhuYyT4=;
  b=hBKiuYbO0Fhq9Z6Mx4FlC1yahmtf+/3hZehK6jfnufglMb4OAzqzKbfA
   DJ4d5sp7GaSGNxHPNjeTZG59AEal/4yapihM648dixB0D/Y+T7Hrcw29H
   VCtHvA8WMkZBxaaKvRTZ13xbWvv+cQf3eUHp834vmWkE76dupm2B1wlYZ
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2023 03:06:31 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 03:06:31 -0800
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 03:06:25 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v2 0/1] scsi: ufs: Add hibernation callbacks
Date:   Fri, 20 Jan 2023 16:36:04 +0530
Message-ID: <20230120110605.9090-1-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds hibernation callbacks in UFS driver.
Please take a look and let us know your thoughts.

v1:
 - Addressed Bart's comments
 - Moved core and host related changes to single patch
 - Note to Bart: Regrading the comment to pass "restore" as an
 argument instead of adding a new member to ufs_hba structure, adding
 new function argument in core file (ufshcd.c) is forcing us to make
 changes to other vendor files to fix the compilation errors. Hence
 we have retained our original change. Please let us know your inputs
 on this.

Initial version:
 - Adds hibernation callbacks - freeze, restore and thaw,
 required for suspend to disk feature.

Anjana Hari (1):
  scsi: ufs: Add hibernation callbacks

 drivers/ufs/core/ufshcd.c   | 60 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  6 +++-
 include/ufs/ufshcd.h        |  8 +++++
 3 files changed, 73 insertions(+), 1 deletion(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

