Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C484681CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjA3Vhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjA3Vhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:37:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1C32E6B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:37:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UL3uD8004244;
        Mon, 30 Jan 2023 21:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=t7qcF4HWMxrV8l58tGxaDXS4xRP41Hcy7/t+u7kgys0=;
 b=iewcRZoL3kDhtcYYGSJ66GY8hW1qFJYpuZeLttuXAPc6MFcHtlS0nhgQxAok5BSMRyUE
 y3eiPgiax8qh6oD3w1aW8xpFet3Qg8UOFjU+QSVM26NTBkWOxcbBdO3w2sbWW5topVrD
 zSW7pwhtfIBjaLPsbfaC+mM6RoT5k0ZdcHaksS1N+NaEkZmcLPFlfTTtbbtZKAXzYWYo
 p4S6hEX0tBNiWzNqBG5ANGpBbtw/ZPTvJGCNyX3nm+C+xtE7r7cQ3/FlCXrD7Bypb7Zn
 517u8JXEayV5B/JSp7W4ApipT3IHEgYKbCCingNLEXa31DrqQqO16UErKkO+xxU2JTki eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwv3gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 21:37:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UK8hq2031798;
        Mon, 30 Jan 2023 21:37:22 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct54qa7f-5;
        Mon, 30 Jan 2023 21:37:22 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] virtio: VIRTIO_DEVICE_F_MASK for all per-device features
Date:   Mon, 30 Jan 2023 12:30:41 -0800
Message-Id: <1675110643-28143-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300200
X-Proofpoint-ORIG-GUID: t9Q0xg6tFlNqxE9pU81AP5Q1c_F5cLIM
X-Proofpoint-GUID: t9Q0xg6tFlNqxE9pU81AP5Q1c_F5cLIM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce VIRTIO_DEVICE_F_MASK bitmask used for identification
of per-device features. Feature bits VIRTIO_TRANSPORT_F_START
through VIRTIO_TRANSPORT_F_END are reserved for transport
features hence are not counted as per-device features against
the 64bit feature space.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/uapi/linux/virtio_config.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 3c05162..3bdc7ed 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -54,6 +54,14 @@
 #define VIRTIO_TRANSPORT_F_START	28
 #define VIRTIO_TRANSPORT_F_END		41
 
+/*
+ * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
+ * all 64bit features
+ */
+#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
+			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
+
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
  * suppressed them? */
-- 
1.8.3.1

