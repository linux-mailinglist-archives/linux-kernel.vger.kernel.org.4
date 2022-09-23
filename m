Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77E5E752E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIWHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIWHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:49:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8627D01DE;
        Fri, 23 Sep 2022 00:49:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N6lrSj013311;
        Fri, 23 Sep 2022 07:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8xyiXvZjbxXhCBSXY+hjWgeku7qnVeQ3Jkuvo1+Tu8Q=;
 b=eO6KkrrqLy4qpzKyIXTztc/hNsQY/YSvrdcM9xw5fCS2KKsRrtEg0ntogRddoa5g+WL0
 p9hsj/WU+RuPxHRKbYhd+Mz75C5eX49AQbevZoxjZDqiFMXBt4C59oaB++5eNfmk1UXK
 f7J+63YVrb6QqN+Jil5ir1XpAjY/000DUMbQCZSL9P+hDlQYSugBhKpZVMWPRa5ScSSV
 uNmI5YQj6q0l1jRqliv3rmOF64eb1gHVgEjt0Ya8I2FvMrXtoswGtF6zdS3c1ZwiB7iG
 SH2xcpZlVGSxG3ZRg76WeLEgVZ5GvDkjbnjfCTRxTl9oY7BMYfSgpUmCRH2E/spqkA4y JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrm0vugvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:49:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N7npUD025472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:49:51 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:49:49 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v1 0/2] Add changes to support SPMI resource protection
Date:   Fri, 23 Sep 2022 15:49:37 +0800
Message-ID: <20220923074939.2592244-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D3cyRIzgxEPvOxjXXKEqbWTtbHd4tdNH
X-Proofpoint-ORIG-GUID: D3cyRIzgxEPvOxjXXKEqbWTtbHd4tdNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=622
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a secure VM uses the SPMI PMIC arbiter driver to access PMIC modules
with secure access, such as in a trust UI feature when the secure VM is
accessing PMIC modules that supply to display power rails, the display
driver in primary VM (no-secure) needs to translate the SPMI address of
the PMIC modules and get the corresponding physical SoC register range
within the SPMI PMIC arbiter that is used to initiate SPMI write transactions,
and lend the memory range to the secure VM via a hypervisor call to prevent
any SPMI access to these modules from the non-secure VM. Hence, an API for
such SPMI address translation is added and exported.

Further, the secure-VM that loads the SPMI PMIC arbiter driver can't specify
the PMIC arbiter HLOS EE summary IRQ becuase it can't have the permission,
also the secure VM has no needs to use the PMIC modules interrupt, hence add
a change to make the interrupt support optional for the secure-VM to specify
the PMIC arbiter device node without interrupt support. The driver change has
a binding document change which has already been applied:
https://lore.kernel.org/all/YmxnIQ9niVbyASfN@robh.at.kernel.org/

David Collins (2):
  spmi: pmic-arb: add support to map SPMI addresses to physical addr
  spmi: pmic-arb: make interrupt support optional

 drivers/spmi/spmi-pmic-arb.c           | 149 ++++++++++++++++++++++---
 include/linux/soc/qcom/spmi-pmic-arb.h |  23 ++++
 2 files changed, 155 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/soc/qcom/spmi-pmic-arb.h

-- 
2.25.1

