Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B6718E70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEaW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEaW1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:27:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B211F;
        Wed, 31 May 2023 15:27:35 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLRdWq010495;
        Wed, 31 May 2023 22:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=rDJr7OT5DoV+Im0NhTFprT7s2ELhcPhDLHAUmYimpo8=;
 b=SS4YWWGPvpwK6BWb3cr0Q/VN1rM7hHa6cfoE+T9Mxn8gGIhbFmityntRsyJP533fR7eC
 ZsnhY+7v3PpE1gwmQ1AQE/0dQP9ETeIXEiX0pYccE+f+jmv70d7hgPLI739KIECs4iCX
 tyzTJUbLSXtlFDFHKvmtrFnRYjXxDJXmBNa7plhsnUjF6PTM/q2GgmAjly2Q63HfssrO
 DjXWiBcY/aTiMBucyNVhNX8xrxE2ucQhjwEgiM3BRbzrtrfF/Fbhd7WUsaBIsO/irj2s
 Eg91PIHWrjvM5EV/7okUTMH655YtRj/HOSQg12u2nePf1CADHXMyMVbJn5cu4OMo1Uik zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx5pxhe4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VMRVOq009725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:31 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 15:27:31 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 0/2] Avoid re-initializing XHCI HC during removal
Date:   Wed, 31 May 2023 15:27:17 -0700
Message-ID: <20230531222719.14143-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BQB1MT9-MDh7TRAyu9ckjjMqoS1OySFo
X-Proofpoint-ORIG-GUID: BQB1MT9-MDh7TRAyu9ckjjMqoS1OySFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=331
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra amount of overhead being adding to XHCI HCD removal
cases when the HCD needs to undergo a runtime resume.  The xhc_reinit
logic will attempt to restart the HC if there is a HCE observed during
resume.  However, in the removal case, this is not required as the
XHCI stop/halt will execute the same operations.  In addition, it isn't
needed that the HC be placed back into the running state if it is being
removed.

Changes in v3:
- Update xhci-plat to set the removal flag before issuing the runtime PM
get

Changes in v2:
- Fixed spacing issue

Wesley Cheng (2):
  usb: host: xhci: Do not re-initialize the XHCI HC if being removed
  usb: host: xhci-plat: Set XHCI_STATE_REMOVING before resuming XHCI HC

 drivers/usb/host/xhci-plat.c | 2 +-
 drivers/usb/host/xhci.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

