Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B76DC91F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDJQRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:17:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F5E74;
        Mon, 10 Apr 2023 09:17:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ABgfSg013580;
        Mon, 10 Apr 2023 16:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UexAOkJHNJ4msc1Ix/hS5H7CGjrnU8Mihj2dQUk1RPQ=;
 b=VyLeC3kvdRXx2Zca0nU0RxiRB6FfNqKWqn9OJ4Scoz7IDXmIljQC+D4oHgXoLqfaNtKO
 jjyU7qfixwVE4WldGVkoxkKd6KjTJGZbqxQ9YQ3eM22ZU6lC3M72yU0qm+GycAaJCyC+
 CsbtUaDp230tGq6R8XlSJpziyqT45yc/8HcWLukZWCD0Vo5DprwgjosgmYqYU/AdJo0w
 9cmXW7R3xuPO4hU1BN+9pn1xxiECtcZIVLCkq2EQtCvqzZ8fxiWsoado4j90GVR2T5TL
 0yKwHwqxVgBSjqnVvA4NyVc6IH6DtNsT6juWNDJGTpiaF8/yK6RzdsRfCJYWDH5ZGGP3 vA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvgkggp1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AGHGn0029773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:16 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 09:17:15 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 0/3] mailbox: Allow direct registration to a channel
Date:   Mon, 10 Apr 2023 09:16:51 -0700
Message-ID: <20230410161654.1660757-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S9sBbu2aKvxjqHE_lwKeNdUKpe-WPJAH
X-Proofpoint-ORIG-GUID: S9sBbu2aKvxjqHE_lwKeNdUKpe-WPJAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=729 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100139
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two mailbox controllers have channel/client binding mechanisms that are
controller-specific and not using the devicetree binding mechanisms. Mailbox
channel/client is conceptually done in two steps: selecting the channel
and binding the selected to channel to a client. Channel selection is sometimes
controller specific (pcc and omap are examples). The channel/client binding
code is all the same.

This small series de-duplicates and refactors the channel/client binding
into a common framework function: "mbox_bind_client" which all of the
channel selection mechanisms can use.

I found this duplicate code while working on the support for Gunyah hypervisor
message queues [1]. I've only been able to compile-test omap-mailbox and pcc,
however it is a straightforward conversion here.

[1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/

Chagnes since v2:
 - Fix warnings in drivers/mailbox/pcc.c reported by lkp@intel.com

Changes since v1:
 - Rebase to https://git.linaro.org/landing-teams/working/fujitsu/integration.git/log/?h=mailbox-for-next
 - Add Tested-By from Sudeep (thanks!)

Elliot Berman (3):
  mailbox: Allow direct registration to a channel
  mailbox: omap: Use mbox_bind_client
  mailbox: pcc: Use mbox_bind_client

 drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
 drivers/mailbox/omap-mailbox.c | 22 ++------
 drivers/mailbox/pcc.c          | 84 +++++++++++++++--------------
 include/linux/mailbox_client.h |  1 +
 4 files changed, 118 insertions(+), 85 deletions(-)


base-commit: 6ccbe33a39523f6d62b22c5ee99c6695993c935e
-- 
2.39.2

