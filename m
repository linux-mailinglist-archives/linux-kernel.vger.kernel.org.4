Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44C738A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjFUPun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFUPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:50:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C729C0;
        Wed, 21 Jun 2023 08:50:40 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LFSPb1019257;
        Wed, 21 Jun 2023 15:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ApW7QKwFmZ2+/cQsgFVRC7YnEf5TnKE2evhfKwNIank=;
 b=HNj76NOwhQFfFuLuc+Ek7NohLDHBv9zdkcRqClBwApizJ4vSR9YalXz6MfSnVgU6RbgI
 K5ds4dlS1+bHWr6HIMnYiArTd08DZ9hsMX29GI3ZEd4jUn5PtkcvmTkrN8pHbOQSUj1E
 Z2G1ZKWTzvaJPYbOHVodWnNklvUIGJJ5IskH7BZciqr7ixenFNy+qWEBsnp+NO+/zY+7
 GqpX/65iIE4P+7yPqOxHnkPttsI8bO9xbt0obZpa16kWmWf4LSs5m9xH8m2bpm+3vijy
 oxH/WiYA6ZPMUnW8KrvUMTTj/udIKin0zsZQTXK/NiSGRykeTxzY6k5zIPYHXZkOdWDB Kw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc3vn0ta8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 15:50:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L97h1X017775;
        Wed, 21 Jun 2023 15:50:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a578-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 15:50:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LFoUQ021496404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:50:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89DD42004B;
        Wed, 21 Jun 2023 15:50:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA5720040;
        Wed, 21 Jun 2023 15:50:28 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.112.18])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 15:50:27 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com,
        tsahu@linux.ibm.com
Subject: [PATCH v3] dax/kmem: Pass valid argument to memory_group_register_static
Date:   Wed, 21 Jun 2023 21:20:25 +0530
Message-Id: <20230621155025.370672-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tV9BvsWNFqM54FmnW5_1TUU7WqWGftns
X-Proofpoint-ORIG-GUID: tV9BvsWNFqM54FmnW5_1TUU7WqWGftns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_group_register_static takes maximum number of pages as the argument
while dev_dax_kmem_probe passes total_len (in bytes) as the argument.

IIUC, I don't see any crash/panic impact as such. As,
memory_group_register_static just set the max_pages limit which is used in
auto_movable_zone_for_pfn to determine the zone.

which might cause these condition to behave differently,

This will be true always so jump will happen to kernel_zone
    ...
    if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
        goto kernel_zone;

    ...
    kernel_zone:
        return default_kernel_zone_for_pfn(nid, pfn, nr_pages);

Here, In below, zone_intersects compare range will be larger as nr_pages
will be higher (derived from total_len passed in dev_dax_kmem_probe).

    ...
    static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn,
    		unsigned long nr_pages)
    {
    	struct pglist_data *pgdat = NODE_DATA(nid);
    	int zid;

    	for (zid = 0; zid < ZONE_NORMAL; zid++) {
    		struct zone *zone = &pgdat->node_zones[zid];

    		if (zone_intersects(zone, start_pfn, nr_pages))
    			return zone;
    	}

    	return &pgdat->node_zones[ZONE_NORMAL];
    }

Incorrect zone will be returned here, which in later time might cause bigger
problem.

Fixes: eedf634aac3b ("dax/kmem: use a single static memory group for a single probed unit")
Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---
V3<-V2
1. Removed skip characters.

V2<-V1
1. Added more details to commit message


 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 7b36db6f1cbd..898ca9505754 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (!data->res_name)
 		goto err_res_name;
 
-	rc = memory_group_register_static(numa_node, total_len);
+	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
-- 
2.31.1

