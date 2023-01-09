Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECE662810
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjAIOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjAIOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:05:19 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084642A2;
        Mon,  9 Jan 2023 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673273116; x=1704809116;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WgTYfSYdaLwQBeKjDZ79qcKrIi+QJDn2vkdsvCTF9KQ=;
  b=EcUAvOgIsoRGkfqOUisnfA/UT3PrqRmZgf1bCe6Un3Nyh5Mu7yDgS/Cn
   PCEK9rTBvLVhQH/xR+IfeGn3hS0QamdaR1Yfm/lnqROsH8qYtzSQb8K/u
   8Ym6k3etWAoR1OGkgCJlz28k2/szSdTosy7nJhyF9k5h+q3jFS65J3deu
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jan 2023 06:05:15 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 06:05:15 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 06:05:10 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V1 0/1] soc: qcom: dcc: Add QAD, Cti-trigger and Bootconfig support for Data Capture and Compare(DCC)
Date:   Mon, 9 Jan 2023 19:32:25 +0530
Message-ID: <cover.1673270769.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

This patch adds the Bootconfig, QAD and CTI-Trigger support for DCC.

1.Bootconfig

Bootconfig parser has been added to DCC driver so that the register addresses
can be configured during boot-time. This is used to debug crashes that can happen
during boot-time. The expected format of a bootconfig is as follows:-

dcc_config {
	link_list_0 {
		qcom-curr-link-list = <The list number to configure>
		qcom-link-list =  <Address as same format as dcc separated by '_'>,
	}
}

Example:

dcc_config {
	link_list_0 {
		qcom-curr-link-list = 6
		qcom-link-list = R_0x1781005c_1_apb,
				 R_0x1782005c_1_apb
	}
	link_list_1 {
		qcom-curr-link-list = 5
		qcom-link-list = R_0x1784005c_1_apb
	}
}

2.QAD

QAD can be enabled as a part of debugfs file under each individual list folder.
QAD is used to specify the access control for DCC configurations, on enabling
it the access control to dcc configuration space is restricted.

3.CTI-trigger

CTI trigger is used to enable the Cross trigger interface for DCC. On enabling
CTI trigger the dcc software trigger can be done by writing to CTI trig-out.
Also the hwtrigger debugfs file is created which needs to be disabled for enabling
CTI-trigger.

Changes in V1

*Fixed the W=1 warnings in V0 of the patch

Souradeep Chowdhury (1):
  soc: qcom: dcc: Add QAD, Ctitrigger and Bootconfig support for DCC

 Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
 drivers/soc/qcom/dcc.c                       | 284 ++++++++++++++++++++++++++-
 2 files changed, 304 insertions(+), 4 deletions(-)

--
2.7.4

