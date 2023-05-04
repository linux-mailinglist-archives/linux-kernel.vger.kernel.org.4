Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F76F6CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEDNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjEDNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:16:31 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446076B2;
        Thu,  4 May 2023 06:16:29 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344BfwpS026274;
        Thu, 4 May 2023 06:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=CQlwkg+cDkug4U01WTOJ7aMecHTtNDaDoufJ8yNjjOo=;
 b=EeXiDB6bd2+fVmfZgAtX6BSRhdxO903O71RaYGZEbBDb0Ue2xkUfAZx4CN0zBPuNBauD
 DNikhKorv2ym2oSZGfGMWenLKP+Eo2Xj8jcHTSGyAnxniqwIYuuoegBSOu2hzED5hycV
 lq9RXsesYKczDlEr+kYH5u28enXX5XOlIAoNAnYPqZLy797Bc7u+B4IXRhOjCeOAJRT7
 24cCkuj3l7+rl7VY66rWHsw8GkRKUSvYSQk5io7XVGtWiWV+zVc6suOfe8MIMcu2UoLS
 Nbjhao3CdxVy49+PtVzgXmtWncmvZ1Vg2C7CTFQaYwlrnXyQ58m6fo+5FxsZlTpWOWv+ QQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3q92rnch93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkVXkWvB8RRn8jdRzIdizununuz+Ig2azk9d3yBhyR2lt+94oC3WJQMCibf9kWvLdgGdZLvDv9r3lxXkdB+3pRvEDwar9v9y/BX7mHzPoikaehx4Vi1s0prLoyabgnJbkb4+rCakL1FSfaSXpJ7i0tZgoZo/DWpF5Onpi7esSNA/20fgcE1eFt8uur0klIIrqfNdZvoNWJjvznBXm14SQUf/ojagssEgLgws6y+Lz0o/ho+ILZ4LcUZuQ1y7NiDNsTPHE9PMuBASEcTzmQyOd8iXVYkJtJn8Cnp2yW4t9H8vBzs4uJ1j4EDTdQE/MgKcOr6D4DVvx4YiKIGizYTVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQlwkg+cDkug4U01WTOJ7aMecHTtNDaDoufJ8yNjjOo=;
 b=kZ/8UwGQJzq3W3U3e5S9IRYN1O21MFHXpYJahS8hDCVO3+480FoU1MxvJBhb30LdGq45crKFEJDd8QnIjPmSSN+jQXAfbTQxioCECD8cFw5a51uUFqEv8FrX3GJHiJwgQimQqe2jqaiN/llQ6gU+f0ZnQ7jrkmM2znEWYqmHDfNw3gnlDkjZ/lad4FVVSjhZhuPBrcLlfqkBKw98MjIj0tiQ/itRaGJuzOvmqhPjkS/YF1UgwGV4SBjAmcMjbWxmtNWE4q996bzxzaQiB49HyUhbVT7Jwmh3yqStdZ0+xKhAGdTaaDL6I5E5sVw/FW1UwPJhDIgAyS/9UuebFNSYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 13:16:19 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 13:16:19 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the spin lock
Date:   Thu,  4 May 2023 21:16:02 +0800
Message-Id: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:404:29::21) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a761a84-ce4d-4c95-1aeb-08db4ca1bf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXVY+vzhYNBkMiXXiwAQBrxjdDD73a6XcU8mgthxcgBPtBuhAwjoGo08WRhvw3YwIkAXeKQEZ/OpkVnKYR6065PX1l7Z4tBPfG70JqIwboQ0steFrcfiOXoCLKT4jZTFukkHPf1VQJC1O0xSAxzf3UuC0Iax1V968dRQQ39gE0oUzFGEjwSiZTA2iz7TjmQ75phDAbpvbjoG2IUYC3by6KT6yL3deZEUY0BZc0vshNNO8loqDVLvWqiGMqHQ4w8G+zQSUUGihv+OAy9VETWi/wIAMjHtnZl9NOPkR5CFSfXu9vNsjUZ/3xAAC2GQXmMPQ/KKCf5yH2DfvjkzWkD51AdUlQ3iMb28APGuUqv9hjUnMWnOr1CSjxOFBdtIsHTU87iYXMNdF8+QV2dleqd4xuNBjwRUtVamWOqXODZi5DTPdAdSmxLC5jaKUmAwuKymu2LvYcefjuI3JHPgv4qXwOWvBtO4DDs50g9GpkftYb4bv0aEGNS/fjeOiD3aNknFxEJS2M1cbsFj7o+Is3llwTAXiEmyNf3+X7bc6Wko2a+hz7vYgZRsZfbkBfBipha+bx1nJ2Y7maT61/4akj4imb4PS8M2YVe/rmifHNpUET8FV4hg51sorwZrEy9SseX5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(376002)(346002)(396003)(451199021)(1076003)(478600001)(6666004)(2906002)(44832011)(8676002)(8936002)(5660300002)(36756003)(4326008)(316002)(66946007)(66556008)(6506007)(66476007)(26005)(6486002)(52116002)(41300700001)(83380400001)(6512007)(38100700002)(38350700002)(186003)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQs6BZ6z57KEbCs0pRxe1hmpzZaguEmWcU5zMOLvRtlNP8JVtepsHKrV7+yt?=
 =?us-ascii?Q?a4pC21hZLFs2Z/ET+IjCEWBnIcHQjZNq0wDLI+prh+bXCjipKnl8ShUlSvCt?=
 =?us-ascii?Q?VHynIjT0XQ3o8mq6kRGrTTAmkJR6ZWk2FwF5p57id0dzL8NHHgQD9Ov38AHJ?=
 =?us-ascii?Q?pXXJie2m+akpBJs6HGILT3aoJoFxfOs1gZ+pAhjEt3GZNvYSg24nKTGFNTgh?=
 =?us-ascii?Q?WgPZQPuykAmFpBqUD9Zh26Zp/lZwc8d5PRo6faZstmd4q2egzeP/LiYyGe5i?=
 =?us-ascii?Q?w2m6OvTLaHfHcjjGpzXyksMbNcqsD03DXoTbqsX+48qiRQIlSFXbErRh4Bzb?=
 =?us-ascii?Q?SMbLWu1CRpVao50xXfd2pyd6cMpQRx2x1SiEpqVnPGe9QYoBf+kNmpJKrpOt?=
 =?us-ascii?Q?YWnuPFdL61CSfuAFS4tjz6rI4nG5xyO9VIzkukDnCDz/MqiB5yt8cmB2Ecit?=
 =?us-ascii?Q?AupICLtYW7iM0FpC8sdZaBLFHnODeoW3w/06TD7E4m7VoBmBk2cdZCqPJaEp?=
 =?us-ascii?Q?5Q9LHwwoNApQ/YaVDG+mGBfHKS17MWPbKoA3PxVbYMvKbzx9W3caX5PiEqYE?=
 =?us-ascii?Q?DZPTdyyQ2bbJQIu6IuoEA50u65iYXUbPKAgxivtrkum9UTShbA590sgxobsc?=
 =?us-ascii?Q?0KK/PGf+NmG9H3GGv/4a6ruZQflOgkiHaS7+BMaVADRuaWTdLhCdSG2f/KGH?=
 =?us-ascii?Q?pzH6ly4Zl1YFOmXGOhhWpStOSb0k9NuYJ5bLtfPI8F/AT7nwdXJm1IOmFi77?=
 =?us-ascii?Q?v/yOAWuzzhKEFwu19yqkEZcVttYRpoeqxp2YpCG/Ew2lO9YYpJK4u2pxd+wp?=
 =?us-ascii?Q?dPwgUiDjkGtpHdLFfuWeZ/GOCALDjyTEKsERLiqsbJ6nwpjy5mOmUshzPfa0?=
 =?us-ascii?Q?MsolQ2iLZjDe8q9mPAgvegHzKdwuXuOVOlNZtc2MGVGzIAV4mzcS4GrkKxae?=
 =?us-ascii?Q?7Jn3UfWzsxaBUV12j9NtPOfgQieZ3sujZR/5j2bQnIxzwLPTaQqkzRhI7EwA?=
 =?us-ascii?Q?l2NCG9RGShtJZjrJMxY1VEG+GeZwS0wU2Y3C2dlzArxOrSZ/QVhCQNdPgpKX?=
 =?us-ascii?Q?Ton+NNCRymQ0IJtaXXQ/jwTqwUG7sE5woCs7XuAi8+4Y5ke8eVBfzVvHKrnB?=
 =?us-ascii?Q?w5fi8BknBgZweKUPYBBqNLUZC7OSKtCmOTAl1YTQgOamY/LGBI18DZIAtYT1?=
 =?us-ascii?Q?vIuOVbx9Zn8Y63zzYxdS1T4ylWklFfgaFIn0ANgQVqINz5lPN3Fu1Fw0rBbN?=
 =?us-ascii?Q?KB3U7WDx8ttyaU5nLET1HZ2dFGz0kE5z0IbzCaMRaq38IwLw8spXKoxvtBHJ?=
 =?us-ascii?Q?9TfqPc8CKIQn1c1Z3rfrjNsO3bPYcYkO5bt6oZGBHMOFPRqjeNb+WRMR4g5X?=
 =?us-ascii?Q?+XOJUwuGC8d96RfMxu79GbVPZ5iJojq9Np9qj021aZe3Scwo41rPQi/hUgz0?=
 =?us-ascii?Q?+nOiYtpKdH8HWMNipvOLS7fLLcFnzyK89u8lbfeH8KltBn5Pa2bRFtcGwmRp?=
 =?us-ascii?Q?sO/kFFQ7gtZNCHp/56PuiZLZWyBwD3inzecfETZ1+O+QuTxv9T+8v1ivHUeG?=
 =?us-ascii?Q?d7ohssj3D5smyhjYnSO9bvti8+e5XR3JPAM8PzGv2lVUBhi9hEUTNcCxWTHs?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a761a84-ce4d-4c95-1aeb-08db4ca1bf64
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 13:16:19.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D09OmX0KH0NFZOv+k37pkMfa2zBLaS2MI5eyLo1X5bsTH/9hA9rjgBA7MN8aNZLWhzWnQwmNUELBbyUXeSH9ycAqVsX60foz9r0RQERCKso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-Proofpoint-ORIG-GUID: ej1BYPRj7d6WZWPz6AdP7lr1FXv7X7bE
X-Proofpoint-GUID: ej1BYPRj7d6WZWPz6AdP7lr1FXv7X7bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_09,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/cdns3/cdns3-plat.c |  3 ++-
 drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
 drivers/usb/cdns3/core.c       | 14 +++++++++++---
 drivers/usb/cdns3/core.h       |  3 ++-
 4 files changed, 17 insertions(+), 6 deletions(-)

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
index dbcdf3b24b47..661d5597fb68 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -522,7 +522,7 @@ int cdns_suspend(struct cdns *cdns)
 }
 EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns_resume(struct cdns *cdns, u8 set_active)
+int cdns_resume(struct cdns *cdns)
 {
 	struct device *dev = cdns->dev;
 	enum usb_role real_role;
@@ -556,15 +556,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
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

