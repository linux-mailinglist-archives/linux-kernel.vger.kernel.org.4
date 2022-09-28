Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE235EE641
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiI1T62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiI1T5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:57:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24952FD7;
        Wed, 28 Sep 2022 12:57:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SJE33P004332;
        Wed, 28 Sep 2022 19:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wCgfcmyARAg6EsfpjZdvHcXQvt5yyytPo2ZxS3RYuCs=;
 b=WDwLa4E0JsZO84LupQs2sM8hSockpV9c4lPuNDD1YFZgt0pCZpDfBv2B4ohguCx+A5rG
 XGdrPt1zGvCkwMhF3zqU+uisWQ3WGrZl0OdAOCoaAtIwSBvkC8gm4KAkWDOG8ZLSOzne
 5/ANbAA+tToRhuZppWA7DPbFvJm+A8s62lFE/0X+UyBvavsUoT5GmbuX3StbzKEidtHl
 9VNqqfscVcAvQVIukhyRqinYFKuwbyWq3OlqywEq6qHWNtFnwpqdPvL0mJGcac6GLWRM
 mV10ysNWLxKiLc6ZFq0yNSPX4y1uHRskkPeQEfMdYYgq4UflvCMcuWRtdKSgMcqZQZYp AQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvu78r4sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:31 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SJvU9r006633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:29 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported features
Date:   Wed, 28 Sep 2022 12:56:29 -0700
Message-ID: <20220928195633.2348848-11-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pUJGMMg_9P2Ys9jig0Tv6oGKrlLeQ9XR
X-Proofpoint-ORIG-GUID: pUJGMMg_9P2Ys9jig0Tv6oGKrlLeQ9XR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_08,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=892 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysfs node to list the features that the Gunyah hypervisor and
Linux supports. For now, Linux support cspace (capability IDs) and
message queues, so only report those..

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/ABI/testing/sysfs-hypervisor-gunyah | 15 +++++++++++++++
 drivers/virt/gunyah/sysfs.c                       | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
index 7d74e74e9edd..6d0cde30355a 100644
--- a/Documentation/ABI/testing/sysfs-hypervisor-gunyah
+++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
@@ -1,3 +1,18 @@
+What:		/sys/hypervisor/gunyah/features
+Date:		October 2022
+KernelVersion:	6.1
+Contact:	linux-arm-msm@vger.kernel.org
+Description:	If running under Gunyah:
+		Space separated list of features supported by Linux and Gunyah:
+		"cspace": Gunyah devices
+		"doorbell": Sending/receiving virtual interrupts via Gunyah doorbells
+		"message-queue": Sending/receiving messages via Gunyah message queues
+		"vic": Interrupt lending
+		"vpm": Virtual platform management
+		"vcpu": Virtual CPU management
+		"memextent": Memory lending/management
+		"trace": Gunyah hypervisor tracing
+
 What:		/sys/hypervisor/gunyah/api
 Date:		October 2022
 KernelVersion:	6.1
diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
index ec11510cbece..f8ec0553c197 100644
--- a/drivers/virt/gunyah/sysfs.c
+++ b/drivers/virt/gunyah/sysfs.c
@@ -25,9 +25,24 @@ static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, c
 }
 static struct kobj_attribute variant_attr = __ATTR_RO(variant);
 
+static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
+{
+	int len = 0;
+
+	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
+		len += sysfs_emit_at(buffer, len, "cspace ");
+	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
+		len += sysfs_emit_at(buffer, len, "message-queue ");
+
+	len += sysfs_emit_at(buffer, len, "\n");
+	return len;
+}
+static struct kobj_attribute features_attr = __ATTR_RO(features);
+
 static struct attribute *gunyah_attrs[] = {
 	&api_attr.attr,
 	&variant_attr.attr,
+	&features_attr.attr,
 	NULL
 };
 
-- 
2.25.1

