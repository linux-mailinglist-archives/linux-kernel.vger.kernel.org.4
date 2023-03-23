Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC86C70DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjCWTQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCWTQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:16:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082A46BD;
        Thu, 23 Mar 2023 12:15:53 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9c24I012513;
        Thu, 23 Mar 2023 19:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=E6sRcFYLj/ODfv6xpWX7Y3ex6yAZfSKdj+3I1ftGCPc=;
 b=dfjtRitVi3rHkCqy7A5ssteI91mhJT2f4u1NhkO7Ce56wZVpWjhBe5KYb5aw9Slr7fEH
 kLnuvup0DlsiXh7km5HOrq0FXJ4QiwQUgtsILGMg/9b5DtdH5lSaYLCiISxjsj7iLBYP
 EIwpJY/CWMsJGQdW69qzJvSE0x7nPXuWcdWg+XVLhqimZuIlhMaIi4YMSA9xr/9ST2ap
 S+Ca4szjlgiwbDGeLJE8Q2+fUkC8bJu+vbe2zH32jDyZzJKe3xJf3z++W3JukK+SnVQy
 iR4IFbE7iwBuVYYElwkWoWOAYqk6ox7HbQEob7C+vjD9joX927BlJSKahgIeLz8PBQOV Iw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgm9x9g2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 19:15:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NJFnqC002479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 19:15:49 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 12:15:48 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/3] mailbox: Allow direct registration to a channel
Date:   Thu, 23 Mar 2023 12:15:24 -0700
Message-ID: <20230323191527.1472695-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NLQngCub2PMNedec7vYB8ohVtuvdcKrQ
X-Proofpoint-ORIG-GUID: NLQngCub2PMNedec7vYB8ohVtuvdcKrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_12,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=709 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230141
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

Changes since v1:
 - Rebase to https://git.linaro.org/landing-teams/working/fujitsu/integration.git/log/?h=mailbox-for-next
 - Add Tested-By from Sudeep (thanks!)

Elliot Berman (3):
  mailbox: Allow direct registration to a channel
  mailbox: omap: Use mbox_bind_client
  mailbox: pcc: Use mbox_bind_client

 drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
 drivers/mailbox/omap-mailbox.c | 22 ++------
 drivers/mailbox/pcc.c          | 82 ++++++++++++++++-------------
 include/linux/mailbox_client.h |  1 +
 4 files changed, 118 insertions(+), 83 deletions(-)


base-commit: 6ccbe33a39523f6d62b22c5ee99c6695993c935e
-- 
2.39.2

