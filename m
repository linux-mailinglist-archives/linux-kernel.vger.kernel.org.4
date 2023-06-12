Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A576472CFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjFLT5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F910F9;
        Mon, 12 Jun 2023 12:57:17 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJqfKp024974;
        Mon, 12 Jun 2023 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dWDtZcUOcpdXqOdxgV8A174M9rHaNyLBSCJnuRYzgcw=;
 b=AeW4w+N+zkSxHLgHPqe8uOJMPnhVZQrVk5avuyIeBaouqbjJuV3LnoAmjC56Dab2DZs8
 TM85BPTXVtA+WPtujTFPVRAOGryQsA5IJgbkACqv/78Vjo+Pf8qWtspsdditF5/tDXG2
 Jx9+HNWWnh0mZVHFmdWQ+fb+rYB9p8RaFyXbr1shbgNwfui31mNE2Bwj36JL++tMJ0GF
 sTFfaSMo1f9YT/aRH66ukLrEhibkafn/gPAUNS/4dEuy2gvUlm3DN05D/8klR90WwLH3
 vzqHIGGEX7+qhz3TFRYZG2wTu02p2JmcVfjXXc7wR7ApOq4QsYu2dDqRJ40O+Al4qbbY KA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69wgr319-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:02 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHiUff002850;
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5cm97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv06I37290454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D3458055;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3485805E;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 08/14] fsi: core: Add trace events for scan and unregister
Date:   Mon, 12 Jun 2023 14:56:51 -0500
Message-Id: <20230612195657.245125-9-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TlOGmbcfCvSmwOdRYZjHC-4uAX4tHyDs
X-Proofpoint-ORIG-GUID: TlOGmbcfCvSmwOdRYZjHC-4uAX4tHyDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more trace events for the scanning and unregistration
functions for debug purposes.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c     |  4 ++++
 include/trace/events/fsi.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index ca4a9634fbc3..47e47c16d5ed 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1220,6 +1220,7 @@ static int fsi_master_scan(struct fsi_master *master)
 {
 	int link, rc;
 
+	trace_fsi_master_scan(master, true);
 	for (link = 0; link < master->n_links; link++) {
 		rc = fsi_master_link_enable(master, link);
 		if (rc) {
@@ -1261,6 +1262,7 @@ static int fsi_master_remove_slave(struct device *dev, void *arg)
 
 static void fsi_master_unscan(struct fsi_master *master)
 {
+	trace_fsi_master_scan(master, false);
 	device_for_each_child(&master->dev, NULL, fsi_master_remove_slave);
 }
 
@@ -1349,6 +1351,8 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
 
 void fsi_master_unregister(struct fsi_master *master)
 {
+	trace_fsi_master_unregister(master);
+
 	if (master->idx >= 0) {
 		ida_simple_remove(&master_ida, master->idx);
 		master->idx = -1;
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index c9a72e8432b8..5ff15126ad9d 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -122,6 +122,37 @@ TRACE_EVENT(fsi_master_break,
 	)
 );
 
+TRACE_EVENT(fsi_master_scan,
+	TP_PROTO(const struct fsi_master *master, bool scan),
+	TP_ARGS(master, scan),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	n_links)
+		__field(bool,	scan)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->n_links = master->n_links;
+		__entry->scan = scan;
+	),
+	TP_printk("fsi%d (%d links) %s", __entry->master_idx, __entry->n_links,
+		  __entry->scan ? "scan" : "unscan")
+);
+
+TRACE_EVENT(fsi_master_unregister,
+	TP_PROTO(const struct fsi_master *master),
+	TP_ARGS(master),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	n_links)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->n_links = master->n_links;
+	),
+	TP_printk("fsi%d (%d links)", __entry->master_idx, __entry->n_links)
+);
+
 TRACE_EVENT(fsi_slave_init,
 	TP_PROTO(const struct fsi_slave *slave),
 	TP_ARGS(slave),
-- 
2.31.1

