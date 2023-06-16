Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395FB73252C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjFPCUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbjFPCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:20:43 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C82E2D45;
        Thu, 15 Jun 2023 19:20:40 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G2C3Eq021515;
        Thu, 15 Jun 2023 19:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=dnwQ3s36ttxjaS2Ajm3BKQzLqU0V1KG1CCD6jhszOGU=;
 b=CCE+ipENdSTGiiatAhdunSFs69B8yKwE37wDRLjimfwYcKi1t7HfKpZHXwldAjqp5wKN
 TqPO8nfGWWjvHFK0YN/lhLcJcCR1noS0uifBheuEWwlWk3tQnCmlBtyAFgPvyrqJDjq0
 G+6te2Q51OIdWlEfWGsKyH5hhx0oFMdjOWVNfxMhLelAqfXxTEil17lLoZlOzhKsDpXE
 yTsJxxlMph7l/3DmA/bue8i7qV34udX0+QWEoDvBYnS59R7t7VcsdNdYhJIE+jA6tOmQ
 sniKr+AnKYQ6xyDOTevQB9Ns59/dtfaxDUXu0qgP76QjhaD7EbZH93mCvqYOJOyy6qKH 4w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4mf35f2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 19:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGmEt/c9ZeEnEgvfonpAYbKWkm2xD6vck/TKLhdAR+Y7mbmCXqYCHpNg9tdmMEXA/SGa+4n4mQPX/B+DfF+ysE9YcigPUEbF6Sm6lXLVRxyt5D69uVI7P5t5DM5HIf5eJ5y7Xc5PC8cGtlUBt052EM+NPGEQbutgEhVL58LcLbLpB2jpZbvxTNry4E3Y6ttGnQehOMKHrwhX/coKFUoCtijjZt78PRDuC5V8R2PqJZV1ogUje21+RRLNErQ3gIWrrLW3pVVixCvfd9OFCDWrrK8m/gVtlUpMk1hUTcdF/N13ydOuISQ3wLGqawguI9evMBB8tHlaGLtCwapfuwFcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnwQ3s36ttxjaS2Ajm3BKQzLqU0V1KG1CCD6jhszOGU=;
 b=l3zw2InD9mIUgocGhSa0ZUbr0UPL6lm3uypfYUBisWBbvAVfGX4kOtRBhJryld68lFgdLHRmk43vUjAOKyd8R43C7wX5JbSPm4ypUtOzEGaRpbEtgNpXTomqOpIruGkEiinAbIa5EfzU4Kqsx+sjpz5JBvWEgmqagbBla+4Zgp8lhkQ6A3ACmHkGWQ55x/JKBhVg1wuon9J+8FnP4FGaISXfFkqHBSFagiTnUNE6lFjF6uWECwTqdS8eE5QT8hAx9dfka1X9d6uhnEXkqLhdfpWjvi/kE6v7hsqNKKWXMqa5YqYfl1h6HaSCWI7ThF8H0lbhbonyjA7Hbu4c/1nZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB6042.namprd11.prod.outlook.com (2603:10b6:8:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 02:20:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%5]) with mapi id 15.20.6455.030; Fri, 16 Jun 2023
 02:20:30 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: cdns3: Put the cdns set active part outside the spin lock
Date:   Fri, 16 Jun 2023 10:19:51 +0800
Message-Id: <20230616021952.1025854-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 16034d8d-14f6-451d-4ac2-08db6e1041ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 927VGLoPGwj7rrc3Ktn2WkKXlzCkK5V0fjEvEqBnxZXB/yWeiHI2ZHPE63InNPg++yo6BA7CAUIxFXCoCnxdr4MgYKdY4IvScfRM6cTCOc3oQIreDmiEQV74tXJRXmPwN2q/K2NiHVjgMkpMuwmVaL9BAVYnhYGv1fWwu8lJ8eyzsabQCb0qCZKZ0F27iiftBtFOvOWz8iRVZG3W/e41TK8hjO5HZplQe6jDVUF729kQf3Ux08bTW33F/uL3xB5MbZbWKvE/RD+nS7bvxD797DYII1jppn8I3AUZeaeJV2FhsWfgjRCbXB8r831pQnf6onA+KfFhseamw5vyfoA9eiPHr+QTgsHk0M1BZp+qcay6uvyAVVqCk/Z4vZ/0U9qSKeIs6oq1nIm+ZXsMmkRXe3umsUGJgJegZJlwBAL3esWX402bzH3AJ218GTqhlIlP64P3vkj/LzAx03YfYq5A4Z4ttFMYrP2tTYAR99F0xZiwx/WgqTNlZNs7IVhqtjtWv9vnB4KgLwfzn8u6HjXm1ARaZkMGXgH1bFG+BkpvKN4O8xynBZZY2JAGvzh4XJ8WMvts7F2TMwDEuxAohr0MB2wFbzRdK7iJRArPZz4EiiuGRmUGbcwYQt1YfYIS3kIK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39850400004)(366004)(376002)(451199021)(5660300002)(478600001)(8936002)(41300700001)(316002)(8676002)(6486002)(52116002)(1076003)(44832011)(186003)(6506007)(4326008)(66476007)(66946007)(6666004)(66556008)(26005)(6512007)(2616005)(83380400001)(2906002)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fiuk4vfh3WvaQ+8ZxDUZ6NC5VYBnrzsCuvFXF+7nmTHIT1gPIyneItVZCQdU?=
 =?us-ascii?Q?UFKv/B2ZpNpwF31oCTg5GXx6AttPhBhxqyr0lomycpV/cNZSbtxxEDjiagTZ?=
 =?us-ascii?Q?i0hqqrZQ8w19dgfSkZqp9eVCbzxJ/0/YfgY35kMfNOJ/V2OA0fFtUZbpAOm4?=
 =?us-ascii?Q?2Xqd6ngTPJ+HoRNhxH+Q6Tco5ZHoyb1YS4U4X7+YzreHAVsL2YB/SQLS9DiP?=
 =?us-ascii?Q?FSgCsVMdphk5J7ojnMlNvkp+CoOEqSmBAa6jfqrkfyg1aYznjnx/H5zZAi+h?=
 =?us-ascii?Q?GLqGG3JMrHN501lX/YZgKbJwJnYiLauWmRFHDfIuPGqk2uQFHSCao+Pi6Yzr?=
 =?us-ascii?Q?QpHtrLnGPPfO3GvF1c/h6RhlnrnR2cpbzIvB0clcSMpJb/xzpVwkOZ3xMFri?=
 =?us-ascii?Q?JJYTkGHZSTTtnG6f6CHQ6WexbljtOVQZ+CI+45DKwd4gmTVlLyH69rwzFPMJ?=
 =?us-ascii?Q?02T2EfMok27B/rVE44AmgpWRVWaSzaZohPpf6jLd5Thhl0jvrzIZURQXFMpi?=
 =?us-ascii?Q?t+O8e72UX+bBUISVhlnJ9zwv8vY049duDP9g2X7QODv3C+JhpaEa7P+qReP+?=
 =?us-ascii?Q?rtexqdJePQ0DviAWOQdDgp0fW0dsDI5HOTUhCA9f6YVHuTFXOc6ceKeoF+Xi?=
 =?us-ascii?Q?GjUm9sYPf1mF8pwV/T4SOlDI70io1bYNqD554Pd2UCGPrUz0IGf0jdR0RjzS?=
 =?us-ascii?Q?jigjrODsPfsyDR6sfZIu7trk4A7Zk+b4+BY+ts46Tl077hmo+F6VqaqqIwHz?=
 =?us-ascii?Q?WIu+csDU9Wud29ZLPWr+NIVGzEw78YJ6j4fPSZaQK0Rdtlmcjz8uHWbto0LA?=
 =?us-ascii?Q?qhuiCaDMKjqBzChsPurx/NaTsmMIeO+C+nl1p4g3M6vpwOF13x2v2JonMyja?=
 =?us-ascii?Q?wvCEa2LyWUTYdTUWYCH37NehUgN6MpIUL8ni5y/1c6kiLgGkJ69gOEuzliyu?=
 =?us-ascii?Q?wPyH+bmURFtKvgJPoe6yH+4Ki3h3WdCYzuxXy1ORifVFW9nhoBT3UmwRYbaU?=
 =?us-ascii?Q?vL+M9r4t9aOww0+B5IAw+p26Ry9YNeb3gQkY9cbq0AbRH2VpdMAum2Tc3y+N?=
 =?us-ascii?Q?qji/pV6OJi58XskE5nZ8KsGa1ENve1SeSeGz5KeyDMfg7ye1wT4c9dRO9Crr?=
 =?us-ascii?Q?/moiPnIJ5ahIoTfe0V0A8CIpWAN2U7HL/kb8PPR8Mb1rMke6MWlqAcYXAGFs?=
 =?us-ascii?Q?Z8gREyDeY71NqWbXbTnJjhuMdQ3lwnL51R1z7s7hbYOLLXAZeme6A6P0OToS?=
 =?us-ascii?Q?YM1k0B494SfrfeSbHVs3bmMrwRsQp0zh/xbEpd5abOCzYVu3PQPn9MVQsE3e?=
 =?us-ascii?Q?dXB0iYvjqN16EGSamCeSpP9fK3tTk4Ts+ora4IqeqxK58ospanHEJT+Q/1ZD?=
 =?us-ascii?Q?YRZDR3XkY8wxGEmgVWMrM3J9wq6621Nj/1x1y0Uxw5Bc8TLM2PqfYGQs1IkF?=
 =?us-ascii?Q?5z2zC5TteFS7B0+V0IAYTE9O6cm1YwHqDEjK8uDUUqYTKFYZnotcEQjZmRpY?=
 =?us-ascii?Q?4KUnOm4Lp2IeitgppDcdWgEmlWTODRoAmISZOQKwhSs3+s3NC6XI1PsOYlZf?=
 =?us-ascii?Q?xjU2VBx4ngq6Tyc9Gn3+DnOiNg6KNCSRqNmmCFptMRuoUkiqsIpS19p+yFbS?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16034d8d-14f6-451d-4ac2-08db6e1041ab
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 02:20:30.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/AW+Z5Ea6muHIAfgy6sMwwyaTqZk42MOwI3IHtDeG9XGIYugiedBTq/7KJ2JuYL6g0qxr/Exb8Q6zLU+VA6mQLHxDID77snEDhWjdhlcms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6042
X-Proofpoint-ORIG-GUID: vrpxncbU6EeTi2rzGgrAMRPaegDtUPCG
X-Proofpoint-GUID: vrpxncbU6EeTi2rzGgrAMRPaegDtUPCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device may be scheduled during the resume process,
so this cannot appear in atomic operations. Since
pm_runtime_set_active will resume suppliers, put set
active outside the spin lock, which is only used to
protect the struct cdns data structure, otherwise the
kernel will report the following warning:

  BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
  Hardware name: Freescale i.MX8QM MEK (DT)
  Call trace:
    dump_backtrace.part.0+0xe0/0xf0
    show_stack+0x18/0x30
    dump_stack_lvl+0x64/0x80
    dump_stack+0x1c/0x38
    __might_resched+0x1fc/0x240
    __might_sleep+0x68/0xc0
    __pm_runtime_resume+0x9c/0xe0
    rpm_get_suppliers+0x68/0x1b0
    __pm_runtime_set_status+0x298/0x560
    cdns_resume+0xb0/0x1c0
    cdns3_controller_resume.isra.0+0x1e0/0x250
    cdns3_plat_resume+0x28/0x40

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 v3:
  * Fix build error:
    cdns3-plat.c:258:18: error: too few arguments to function call, expected 2, have 1
     258 |         cdns_resume(cdns);
  * use 'cdns_resume(struct cdns *cdns) { return 0; }' instead of 
    'cdns_resume(struct cdns *cdns, u8 set_active) { return 0; }'
    and add 'static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
 		{ return 0; }'
 v2:
  * Fix build error: unused variable 'dev'
  * delete unused 'struct device *dev = cdns->dev;' in cdns_resume()

 drivers/usb/cdns3/cdns3-plat.c |  3 ++-
 drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
 drivers/usb/cdns3/core.c       | 15 +++++++++++----
 drivers/usb/cdns3/core.h       |  7 +++++--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 884e2301237f..1168dbeed2ce 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -255,9 +255,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
 	cdns3_set_platform_suspend(cdns->dev, false, false);
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
+	cdns_resume(cdns);
 	cdns->in_lpm = false;
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
 	if (cdns->wakeup_pending) {
 		cdns->wakeup_pending = false;
 		enable_irq(cdns->wakeup_irq);
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 7b151f5af3cc..0725668ffea4 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
 	int ret;
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	ret = cdns_resume(cdns, 1);
+	ret = cdns_resume(cdns);
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, 1);
 
 	return ret;
 }
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index dbcdf3b24b47..7b20d2d5c262 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -522,9 +522,8 @@ int cdns_suspend(struct cdns *cdns)
 }
 EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns_resume(struct cdns *cdns, u8 set_active)
+int cdns_resume(struct cdns *cdns)
 {
-	struct device *dev = cdns->dev;
 	enum usb_role real_role;
 	bool role_changed = false;
 	int ret = 0;
@@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
 	if (cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_resume);
+
+void cdns_set_active(struct cdns *cdns, u8 set_active)
+{
+	struct device *dev = cdns->dev;
+
 	if (set_active) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
 	}
 
-	return 0;
+	return;
 }
-EXPORT_SYMBOL_GPL(cdns_resume);
+EXPORT_SYMBOL_GPL(cdns_set_active);
 #endif /* CONFIG_PM_SLEEP */
 
 MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 2d332a788871..4a4dbc2c1561 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
 int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns_resume(struct cdns *cdns, u8 set_active);
+int cdns_resume(struct cdns *cdns);
 int cdns_suspend(struct cdns *cdns);
+void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
-static inline int cdns_resume(struct cdns *cdns, u8 set_active)
+static inline int cdns_resume(struct cdns *cdns)
+{ return 0; }
+static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
 { return 0; }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
-- 
2.25.1

