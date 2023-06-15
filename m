Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D14731611
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244961AbjFOLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbjFOLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:05:13 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F2271F;
        Thu, 15 Jun 2023 04:05:11 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FApR5X025669;
        Thu, 15 Jun 2023 11:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=HoI+Dvy6v4YxLp2OUbzRCPeyrIu9JBw3CtfaI3S894A=;
 b=j+jKmZb1wPthwdQD6Ygwnyrdf3r+yOAHuFOD4p/BMHXRU2pl5tS87CP4d1z//irowqQv
 XLRqmXLRffZn5bKcHPtkmu3AvjGiC7HfpAQP4wgmufsx0cXgVUxzn+uloQ35FOsMe00O
 YccE5AZiOnrzdW/VKas/83vA9EtpyaYSQsgJKPtb/p/ZlQEuxSxocI62AOF43yGiVJdm
 /ELMiL26eHVf71rAJExqXuHbULFL21jgPy86BQI0Cvui11XN+7ObSmbPJuSmHVvQTtTI
 MlsFBFJRc03guvq8VJ4vNGdA5wfJajpkUq1sCCGPN6M9/MDXm3pUfmR/hJaBNfBdJaji hA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4ed04vmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzGM93Osuuk2jK1fzWHJejA1dRffA3NLGTZgHpEbsPcMgYLPWYQNYnOLPUTp3jDm/ZqOGXPQvOhTqEbpKXAtwAJJ52SXb/P5h2TpxZXBbFJ7Y9D/SRV1oJEJSpFo99u74nguZnGyO5YZ462fGlLd5lni5g0QkgK+eCQoi73GK3VeBJ9QRXtwDeQc+H8jzMg6DiAfAlsCwarMDAn0IMirJ/6M47RkTX7oJsGqXO/VXA90FmjtAtS1QTMOld2p0JsMm1iHBeUfVE+o4ZtLUFrmmYbG7VhZrpwYj2ym6pOXIEJbz4mZmhnUSpKQ7DM9NuA0VkL2JhM5kViu9zzDpYY7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoI+Dvy6v4YxLp2OUbzRCPeyrIu9JBw3CtfaI3S894A=;
 b=f6BdTsW9tW9oo4AfKfL5hAGHw+sX4Ab8VTCzKP0tQ1v7SonNhzrJ6pJQBwTKZl2SY9KDn9GEZpz6ZbVrNGx/ejHplmRwLB3IIBBtUKj9iRvCITuC8amNNScCt31l5E1P9qzdZu5X30XKk5tSk5GD9CUtc5gefjbtjRCdh7UiIxf6ZKrsX9WbHsZalghimpxzZ+RM/4RIFd6KNHz4QLOnsNQTcoYZZuZ/AJLCS5oglQHp0yVgWGh55BoECw8hnxT33hX7tvbZdvD8sX8GaV17TNPC0Z/OjMPdQnX9LaNbM1r4I0x8DVSGwppKvh7NqbIJK2JLfL9zVugpmUpWdPcoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 11:04:52 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%5]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 11:04:52 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: cdns3: Put the cdns set active part outside the spin lock
Date:   Thu, 15 Jun 2023 19:04:24 +0800
Message-Id: <20230615110424.4007675-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:405:3::14) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5738b820-a62b-4e3b-77a4-08db6d905832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgYiae+qLNJXMaFOEVk1zRaqpOkuoXP38IoktEtqf3iXFAHX1wD4NFOgbt6VORFuL6RgGysHt4mX3TOaDDm0gfzvJHon4fJVcecJdfeMlq1WAKHHjuZSkCqLLBXhF99jmf6+1qmi12oJ26QOPr79h2vWcSzX2zQddB/4I0d/3IxxIcZLAheUjhAcI05fIX7t1vZsyd7reWdh4BriqyO9WvadRrioi87uIgsECh9+gT9RhabFlk78yfxXYc4u7PsVQUaITA2uC7NgvRwELzCgVBEmPBE8otuTrpSAqgRpPIThscunVZfroFRwmqoKcu3XA7NYCVTToeQQMEKmCmVKoL9mPhbWlEsaZjUPfFpVqgKH2qhHeDOHBBPk3p09KSGMM8Q4cofp9BaLl7Piqi+ekdTi9Jp/0fp64ZwKSDeA1+5DW7wz/I7xj3pmNfIGLx1K7KhT7/9A3KU67C8dDacAOc0AV6VratimkamC5eG1PcukwhR4dqKqdM/w/sqAKuKUJFfgD7p6YN7y//XMbHTkoccX6sPtvp9Ggo8hDC+YGZ05HNv8dwwSfXFMO38SWxx0dh+rkQez22Eok40JqMinDAGD7D+hTwcoEDMf2aA1Wbici1AGhF5AnTCBuzZJGSAY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38350700002)(38100700002)(8936002)(8676002)(6486002)(52116002)(316002)(41300700001)(5660300002)(478600001)(66946007)(66556008)(66476007)(6666004)(4326008)(26005)(6512007)(1076003)(6506007)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ic3nWLXcEdTLHeEXI994kLUdCGogcukkGkuxr0/DkRL9yNyzL5MEvMpUN3Z6?=
 =?us-ascii?Q?GiazNkz9v7xnz9bDKThLaHdf0n51Pz9gf/8xcpBCR6ZLv+DC64QHAmwqV/Kh?=
 =?us-ascii?Q?djhkMOkttagWzyY77OJUNBzrVCXKID4ffXFqH1ZxycXnZW2E5kH346u1/Hjr?=
 =?us-ascii?Q?j5Tw8gA0WQk30rb+D+YG4h8nFp15+tVmELznn2TY+PznjqqHhMM1waNiDISx?=
 =?us-ascii?Q?/wkjTFAoXb+kwTj+lfxXsvIxDmK+zQ8A0WqmtasWTB1l3r+wJGucdPkuzIJK?=
 =?us-ascii?Q?S2oxd3xPSZtudM2prVKzOSIaaLdHMxevTfAD0WMZLXEmCbv7jen+fGwPR/yE?=
 =?us-ascii?Q?m6oCBJEbcW01z9VUblrFNG3IWUJpyHoaEnQiybpwLHmpymxA0nPiGu4tvtvd?=
 =?us-ascii?Q?0gd0HL5XXUFkwY5S/Cs2V/dJO3wOa/YJa//a8acGiINRw81NE2YRldyb1G9I?=
 =?us-ascii?Q?grc3xuk7EciAWvyNo+uPrWg8gX/BvgDkoJoYZwvfzyxdh75RXSpH9Ze+AZz9?=
 =?us-ascii?Q?kPiFD0RlLDIpx+FA1L9Lvkkxk2Ep65NBypG9Nrr1Nbf5ZcWMT76QlQz5IK8m?=
 =?us-ascii?Q?TN081RWiL5YKrl8IE6Aqk4a5JUUlmotI1vGRT4GSOE1zATAmXBHb3mv+yiIE?=
 =?us-ascii?Q?vkWtsnwwRbu/Z1FpPTL4UckGA8oCK1XJb8zak6BDSmqipbLMXluDVrOHR92d?=
 =?us-ascii?Q?dq00wwblJzjRrN3hIh7uvgddk1wVHnMrKrnv4qL+fpGzRzmth9FykogsEmOp?=
 =?us-ascii?Q?TVkLnLENTEvnsvq9lp0eJJzmGPsU60C9QDS7XaB4QD8hdYv57AIwYi+sD3qi?=
 =?us-ascii?Q?TrEIdKwlbjuy0ei+CbDH+B4anItFncUxzVXnezB+FvSYEJvMBxVCqebyOXlT?=
 =?us-ascii?Q?SL+wSo610yIVIu/lV/s+5uvs9vBpbkq1nbeLYwABuo9SMiK5UebXIngCkf4U?=
 =?us-ascii?Q?xecjaDgz62G6Y4BQAvOJs6hTpbxIDGIuqR3WMhbdKNzYxSpyGMV3g77y+j6w?=
 =?us-ascii?Q?a9y/GJvJE6Ixw2igRibY4SWDfzYXteeNlyinbpVSZy1q2R1e7P3h4Zotxfnb?=
 =?us-ascii?Q?mddy5dIxCYMwpYm+3Go5odPXtGnew9tWxyYceZR7UorMtSW481KfvGp0eOTh?=
 =?us-ascii?Q?hsxUZJt/PiaG6xpqnXLIReiZJdeaFyGlAwXMkvWmMW844t3B+Y3eipHaMR43?=
 =?us-ascii?Q?vAuwccrG/6kZPCufnriCHgkzn+sWjmXyOVUjQ/p444/aeeEktqbtbZCthd+9?=
 =?us-ascii?Q?XblwCGquVN9p1OIJwo/rZ6M0ev8P4XmJXZYssnA+9X6ycedjj6HmWMbk4wMB?=
 =?us-ascii?Q?F/pCrq0grpv2lrZfwEJ+yEdHYrNQlF1OJVHfNVRifRobh52Cj7M+Y1yPpzIe?=
 =?us-ascii?Q?wYjYK/RETaU1PGJYxQ+rqgifXgeXKvjlJIU0AQsGG0tfy27OFYOQNWCnShA1?=
 =?us-ascii?Q?2k4+e65CzN0hoTR6yJmAd3SNJL2VBsIG+vmnVNDEuwPSvMc/ZLxGkKILZ+a3?=
 =?us-ascii?Q?i5h1I0sINIGYs0gagiw7n2+rM7KEu5V1l2OFOa/CwNPbSWna3/A5Xm9hugWJ?=
 =?us-ascii?Q?3WOhM6pqhyZVYBcoWbCTauv2B9Q/8YkS06oaQF1bLSBKYYC8x8xYphXNMGEo?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5738b820-a62b-4e3b-77a4-08db6d905832
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:04:52.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2HvKBG1x+CcC81pimMDAAEnKvyAV25Mvc5zIT1bzgG67xYK0/ytHQ4lqO0SB58B+jS8CQdGWu0IPjwyI79PbLH0ROgMJzd5KRnE89nzqAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-Proofpoint-GUID: EfKSgwK8MtpnNmZlJ6EDrjN2DRgLWpEK
X-Proofpoint-ORIG-GUID: EfKSgwK8MtpnNmZlJ6EDrjN2DRgLWpEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since  v1:
 - Fix build error: unused variable 'dev'

 drivers/usb/cdns3/cdns3-plat.c |  3 ++-
 drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
 drivers/usb/cdns3/core.c       | 15 +++++++++++----
 drivers/usb/cdns3/core.h       |  3 ++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 2bc5d094548b..726b2e4f67e4 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
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
index 2d332a788871..0f429042f997 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -125,8 +125,9 @@ int cdns_init(struct cdns *cdns);
 int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns_resume(struct cdns *cdns, u8 set_active);
+int cdns_resume(struct cdns *cdns);
 int cdns_suspend(struct cdns *cdns);
+void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns, u8 set_active)
 { return 0; }
-- 
2.25.1

