Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E46DFE17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDLS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjDLS4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A19D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:56:19 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CIiX8U002876;
        Wed, 12 Apr 2023 18:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A+AQ0VkVoNK1ioW6jyr48kGGbCTamlovvFjQCS+ekE4=;
 b=JfebaIP6gUvCDTgUIcAB2TLzRtMpSvMmURMt+Z0mjpHJRF9aAngkTr8gOI/Nny7vZsBY
 y8A5++36vfAYjuSSRvV4T45i0AhOeqWTEAiJqvLY0KJfMzAOpMnYXGkfrdtJGzFHInrG
 7FAsoH7ax/xqVnPLsekBi5GmThnyLVkRSmECM7quwzO2aiLRHv34dSRu4HTP5WnSivFN
 xRx/NU3HdX4lbQEdWlNTZikum19X4If7rM4GLhju9EI0wsT1XYp3HDpALhoKGlAf8P4X
 mFleYTf/1UoTnMhxxmAR4kIeq+I9G3tGFUMOL9Ercv+CttP8LrY0bK1OxZFkvVYwKAwi dQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3px0aamxbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CG0Zkk027951;
        Wed, 12 Apr 2023 18:56:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pu0jjdjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CIuAHP17105498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:56:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29CBE58061;
        Wed, 12 Apr 2023 18:56:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FA2D58066;
        Wed, 12 Apr 2023 18:56:09 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.16.129])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 18:56:09 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] fsi: core: Add trace events for scan and unregister
Date:   Wed, 12 Apr 2023 13:56:02 -0500
Message-Id: <20230412185602.1592629-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230412185602.1592629-1-eajames@linux.ibm.com>
References: <20230412185602.1592629-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4eydNhc6ZZzjaM04BpqFSyPGVLoI2OoS
X-Proofpoint-ORIG-GUID: 4eydNhc6ZZzjaM04BpqFSyPGVLoI2OoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more trace events for the scanning and unregistration
functions for debug purposes.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c     |  4 ++++
 include/trace/events/fsi.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 18d4d68482d7..2dc119ab073c 100644
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
 
@@ -1355,6 +1357,8 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
 void fsi_master_unregister(struct fsi_master *master)
 {
 	mutex_lock(&master->scan_lock);
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

