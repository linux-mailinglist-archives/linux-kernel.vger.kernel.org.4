Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39474E7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGKHHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:07:02 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16BBF;
        Tue, 11 Jul 2023 00:07:00 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36B5faVS013016;
        Tue, 11 Jul 2023 07:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=v+BNS1obzflaF1+rTu
        7QnR4QoaBuTx1QDSwu4Vpmuy4=; b=n+68v4kye0R0Ni5Eul/SyR71NQ7LSB4/ju
        rNeDPkVNdC9Uiy1nk0TUM0TeUtB0z/PQuMtxkVSLY51PrYvrAwGbjpUeVuCoa0dH
        94UFYGYH6V9k9KsRN0irpE92/+HmmNFfsqZgA+wyLzsGJNNFvCupylY3tkJouUN5
        mWDxMoBaMF4mPCLU1m2m/sYyoHgIt6rUggA6h22mGprd3aY+mJmRsWAqQjhXbD1o
        tVmLM9H/haTPZxigz3Z16M3JphPeMGD7vyHkw/i1UkrO3UHo015oqM71IvaEHSHr
        yh8e3ihElmbsS/+zwHoRjX6Rohc1hXMhVvPJxAM3gCr+hzgKrQPA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rpxs5a9dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 07:06:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txp3JBF2OP5DGYuMiqSNSrJnJGW92wYqt/K2oL9rNmEgtbogm2jRlrKpnJ0qhvHGqKK0XvLRyZknZzj/HJ8OXhaTm/Q/zxCqK6X4rrhK2wOjKvVyynxw+G9mXmqfIFZVbAAa4OGQzIodYjuJmbc7DryzmngQcIFGBRvOR3UXXRuwh+vYQGdcfDnaFt7jSBI7NQnoeMKOxyfZvd2aHlj0e/59hHgZdjiI19L/nDZT4rWoBIsIf42/SZ2vVedSX6PCQe37j76nYudscrgOZO12guTveuaEUaW7xWtRyWueOjzByADxKUw1CKahq+Se3sQxg/faGGhd7IpeQQ27JPMO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+BNS1obzflaF1+rTu7QnR4QoaBuTx1QDSwu4Vpmuy4=;
 b=WetBDwIzkJ90SQEEtyFGnnA6nTsb4fGHj2JItqieId7Isr9iI6Gi2stqtAkhgswLmAVuRnPblG+w6/S0D2zyBfRcB56v+t5OjYmww/ihPoKqjygySi8VlqQik3Z+Fykw4G62HaDZpVqxABfiouXFjb2XMLGNBG8NvSxa3Ak10A0Vowbh9zgIdDPESkSrjyDm7QL1SHqnJKDxla3leHomSwpUsvTtwpyd7WlTlRQnP61E4K/bhVpsrgS47ye5LJ8rDKMu17gSvwU0rzJ6ufSWjrgLR+DpsQABfGP70bOSa2dmzpibCkTblKVrWbT/4XtZYUjO3TyGcHd/3xboRR85QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21)
 by DS7PR11MB7836.namprd11.prod.outlook.com (2603:10b6:8:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 07:06:04 +0000
Received: from IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::e539:d1e3:e67e:54b2]) by IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::e539:d1e3:e67e:54b2%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:06:03 +0000
From:   quanyang.wang@windriver.com
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] coresight: etm3x: convert struct etm_drvdata's spinlock to raw_spinlock
Date:   Tue, 11 Jul 2023 15:05:36 +0800
Message-Id: <20230711070536.3944458-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To IA0PR11MB7402.namprd11.prod.outlook.com
 (2603:10b6:208:432::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7402:EE_|DS7PR11MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5e5713-89b8-4985-6841-08db81dd499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBl2yohBdDNVoEd8IBGQVeX6pc8sL4LwnIVpPaJtQGuzN77vQulrDg+nhO9Swjqobdqc1IAakeHtkSySmwzjbi5jwWHJ+R0EnpAgd8pQEGOk+ANonbV8uV0eUjwCL1Ucy6f519K+4URJFMYifQ58b3XcttsASwAFMsJnegfACl5dq0/CK45XX8SQsIvODkRTjVMgd1lwyCwy7Vc7kfGuh6GeEpgA+iYFhq2kWbxit1RDvZKzpl3ZwXK7InhmUFXNfGl8PIKxdNNduRLvERbZBIJaDSmxFN0XyLj7Z/L9vJ+/z0e6PxYsmruVfqZAjrbabp4ZFp3n/2VR0E6kA1cIzI0Rw4WdcQwx97XSTkXWPK72nL24vUZS+LNZrhYdJp90GIsPCUqQFgOkIT5eDhdNSx4dergX+tRnta4BiGTGd4CuS3gmjEj4F9n2vD4HXVx82kUe7sBfHar/IZMA/rX8jVDdMsK3ygcZStL1uTjFEWi0Iqg4YEeQggznRkgy8caHuSyA1sp9acwKfhL15NimFKQF/bnaa1kYGUznFbA8ErMFbBFgiKryKmzygfKXcmlFjlNVsuRcRMGN0xUdbjOlyDpDe4y3xKfWnACWZpZwZNoI5DDy30ZwVKFoE5o1HD4F/WDIfiYfGe2gpwpUGc8dCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7402.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(396003)(376002)(136003)(346002)(451199021)(186003)(6506007)(6512007)(2616005)(9686003)(26005)(1076003)(107886003)(478600001)(83380400001)(41300700001)(4326008)(6636002)(30864003)(66556008)(5660300002)(2906002)(7416002)(316002)(8936002)(8676002)(66946007)(66476007)(52116002)(6486002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sp1gVUNAnjfD4uDVrYKETUvK7L6UcxB2su+8+amH/wKpk74SGMKT4myZst31?=
 =?us-ascii?Q?sUmjXX8JjXNM2gpUFE96BQ5yKdKdsXewNt4+bzBNU+ohs0Qay58v+14jPguN?=
 =?us-ascii?Q?8noa0N7hp2jbyjjTWnexFAt07xPWTp6dwOE1vFr89FDb9n+kWOvxYZpBOxr1?=
 =?us-ascii?Q?vkZ1My7tFAF1swBsyMYvJEEE+XbelmW4xZi6g5EVkspxeY91dboctWLIqo20?=
 =?us-ascii?Q?79gjOsWc1nTUlrUPrC/uJh2dFYOLpNWS3iXw4Jwaogp8GmZf5oiSxhqD5kbN?=
 =?us-ascii?Q?1mdhEBv6waUzTRwy4mb+k19NWE5w5L1wvUNe0yWgL7BDAgBqtXCjP/QGVTwY?=
 =?us-ascii?Q?SYDo+SyQis2PjnBX/TzXaF6DA47sSxmrekMRWo8NIZ4dL3mVQ6MJDEvU0gan?=
 =?us-ascii?Q?UMh5ixOHMos8rPOxkJ77AAtE4N+rr+lh9rNvNA1Ir8vszOXFdwTxS2CBtIcJ?=
 =?us-ascii?Q?YzACowf+2oGH1bEY6zn0Pm2FsEBDVIsXG+Sehflru5pLCubbHcFNigw3aXO5?=
 =?us-ascii?Q?YTel159/E0BdBYlSLoZ+vtbfdPz4PzZa8vK6WWvAgeDy4AE7CdJmGSLQTjM/?=
 =?us-ascii?Q?ma8aaH7AgdbETi01N7bs7jt39eGiklbpPo59MdZbjzph7elevbABuv7394Ki?=
 =?us-ascii?Q?+ahYTJsRp6Xe98iyhZGw0jmJuLev3L7UVjXU1PpupgCAeZq7fGuUAhlldcEi?=
 =?us-ascii?Q?9hEnzsE1gUivESJhmE4Wy+iS3UXwZT/ZdEC74jPvBYaKEvQrTtjVx+/7qg+a?=
 =?us-ascii?Q?W1s3oNmDQx5ER4NfEnpT0G/Zd1jyZ1mrn4+pnpowg6hx6CCH9Vq+eFMKVlzz?=
 =?us-ascii?Q?OskFwYBQ1v7CblF/OJQ+T9v0nVBBIJ38DWBcUL9aamyfVflouVXk7EItLxgz?=
 =?us-ascii?Q?+MTSzqkp+LVGX1b1ZgamLIedJk0vhNfPFiYtd8xWH7iUoiaTCnIX4k0e5LU3?=
 =?us-ascii?Q?bHILksOO6IU9pX3m1A+HcCKn9u38o/OSnvDFX5Uoj40M4bSZWab++YOkS/kh?=
 =?us-ascii?Q?xO9SspN1bkHxnx9tbJvIqu4ASIfxq4NUqjcaNp+ZfPBRCi8MzsovokHGLaXA?=
 =?us-ascii?Q?5XdocP8pRobtbQ9mamexL3YbHBEGaGJHJVqmZxR6X0II40FSQfzHVlGTw2mC?=
 =?us-ascii?Q?V8CN0Dpkc1h7bH+HnLlgM49m+VkcghavGgduy74GCvb3friJVXjGrhhxqtsh?=
 =?us-ascii?Q?8bfnuOnOeGFwZHfHqCWYu8isy/CyuZ5ZIxewekTTqfvcw1QTcDhnIwvXTjL9?=
 =?us-ascii?Q?kGaxiQmyvaAwNPmEy90WtaOBWizdxuQmQkOFkOiECIHN2zG15qJVTTYSa3TL?=
 =?us-ascii?Q?HsD5wl8n8jHmbbNFWrCuqBkYf3WfyUPafGsiQQWyQf1GqJycNn/m5YezTus4?=
 =?us-ascii?Q?oOIxinIplcE3KuG3e1AmnO1CMNrkix2qRvXCHyiUFdP2UpsH25ftITb2xCKA?=
 =?us-ascii?Q?fQYjfTzICSfArMEWnxE0H4BVuoP8B7V+ntiPzAKjJNwomi8djq7ts/jaZozT?=
 =?us-ascii?Q?oZmwsVPI6gz61M4N7aVm6ZwC0cVCylqxbhIF05woBoh9nEXmC6wacWJrJwnb?=
 =?us-ascii?Q?1aEifjSeC+czr8pxxLtIJmNyJhOxFWwfTr177Sxp42luiefVo4Mi9KehFjOI?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5e5713-89b8-4985-6841-08db81dd499f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7402.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:06:03.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa54HxMd/l7aN+xNTm4JwKjSK8wOb85YvoWSQkiFxbtc2CoQ+hPuVFXMZWzSHj+g3QtVPxlpTbHRbTgDqAXSE5r4MksWG3dpe6YYerXxtIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7836
X-Proofpoint-GUID: 6u-znkPhl0QpRA49WBS4fpqkRqt9EFtK
X-Proofpoint-ORIG-GUID: 6u-znkPhl0QpRA49WBS4fpqkRqt9EFtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2305260000 definitions=main-2307110060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

For PREEMPT_RT kernel, spinlock_t locks become sleepable. The functions
etm_dying_cpu and etm_starting_cpu which call spin_lock/unlock run in
an irq-disabled context, this will trigger the following calltrace:

    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
    in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 25, name: migration/1
    preempt_count: 1, expected: 0
    RCU nest depth: 0, expected: 0
    1 lock held by migration/1/25:
     #0: 82a7587c (&drvdata->spinlock){....}-{2:2}, at: etm_dying_cpu+0x28/0x54
    Preemption disabled at:
    [<801ec760>] cpu_stopper_thread+0x94/0x120
    CPU: 1 PID: 25 Comm: migration/1 Not tainted 6.1.35-rt10-yocto-preempt-rt #30
    Hardware name: Xilinx Zynq Platform
    Stopper: multi_cpu_stop+0x0/0x174 <- __stop_cpus.constprop.0+0x48/0x88
     unwind_backtrace from show_stack+0x18/0x1c
     show_stack from dump_stack_lvl+0x58/0x70
     dump_stack_lvl from __might_resched+0x14c/0x1c0
     __might_resched from rt_spin_lock+0x4c/0x84
     rt_spin_lock from etm_dying_cpu+0x28/0x54
     etm_dying_cpu from cpuhp_invoke_callback+0x140/0x33c
     cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0xa4/0x104
     __cpuhp_invoke_callback_range from take_cpu_down+0x7c/0xa8
     take_cpu_down from multi_cpu_stop+0x15c/0x174
     multi_cpu_stop from cpu_stopper_thread+0x9c/0x120
     cpu_stopper_thread from smpboot_thread_fn+0x31c/0x360
     smpboot_thread_fn from kthread+0x100/0x124
     kthread from ret_from_fork+0x14/0x2c

Convert struct etm_drvdata's spinlock to raw_spinlock to fix it.

Fixes: 97fe626ce64c ("coresight: etm3x: Allow etm3x to be built as a module")
Cc: stable@vger.kernel.org
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/hwtracing/coresight/coresight-etm.h   |   2 +-
 .../coresight/coresight-etm3x-core.c          |  18 +--
 .../coresight/coresight-etm3x-sysfs.c         | 130 +++++++++---------
 3 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 9a0d08b092ae..55e1a9180557 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -233,7 +233,7 @@ struct etm_drvdata {
 	void __iomem			*base;
 	struct clk			*atclk;
 	struct coresight_device		*csdev;
-	spinlock_t			spinlock;
+	raw_spinlock_t			spinlock;
 	int				cpu;
 	int				port_size;
 	u8				arch;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 116a91d90ac2..af34fb82f4bb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -518,7 +518,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	struct etm_enable_arg arg = { };
 	int ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 
 	/* sysfs needs to allocate and set a trace ID */
 	ret = etm_read_alloc_trace_id(drvdata);
@@ -545,7 +545,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 		etm_release_trace_id(drvdata);
 
 unlock_enable_sysfs:
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
@@ -647,7 +647,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * DYING hotplug callback is serviced by the ETM driver.
 	 */
 	cpus_read_lock();
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 
 	/*
 	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
@@ -655,7 +655,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 */
 	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
 	/*
@@ -724,7 +724,7 @@ static int etm_starting_cpu(unsigned int cpu)
 	if (!etmdrvdata[cpu])
 		return 0;
 
-	spin_lock(&etmdrvdata[cpu]->spinlock);
+	raw_spin_lock(&etmdrvdata[cpu]->spinlock);
 	if (!etmdrvdata[cpu]->os_unlock) {
 		etm_os_unlock(etmdrvdata[cpu]);
 		etmdrvdata[cpu]->os_unlock = true;
@@ -732,7 +732,7 @@ static int etm_starting_cpu(unsigned int cpu)
 
 	if (local_read(&etmdrvdata[cpu]->mode))
 		etm_enable_hw(etmdrvdata[cpu]);
-	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	raw_spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
 }
 
@@ -741,10 +741,10 @@ static int etm_dying_cpu(unsigned int cpu)
 	if (!etmdrvdata[cpu])
 		return 0;
 
-	spin_lock(&etmdrvdata[cpu]->spinlock);
+	raw_spin_lock(&etmdrvdata[cpu]->spinlock);
 	if (local_read(&etmdrvdata[cpu]->mode))
 		etm_disable_hw(etmdrvdata[cpu]);
-	spin_unlock(&etmdrvdata[cpu]->spinlock);
+	raw_spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
 }
 
@@ -871,7 +871,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->base = base;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 2f271b7fb048..64660b47f068 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -49,13 +49,13 @@ static ssize_t etmsr_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	CS_UNLOCK(drvdata->base);
 
 	val = etm_readl(drvdata, ETMSR);
 
 	CS_LOCK(drvdata->base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -76,7 +76,7 @@ static ssize_t reset_store(struct device *dev,
 		return ret;
 
 	if (val) {
-		spin_lock(&drvdata->spinlock);
+		raw_spin_lock(&drvdata->spinlock);
 		memset(config, 0, sizeof(struct etm_config));
 		config->mode = ETM_MODE_EXCLUDE;
 		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
@@ -86,7 +86,7 @@ static ssize_t reset_store(struct device *dev,
 
 		etm_set_default(config);
 		etm_release_trace_id(drvdata);
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 	}
 
 	return size;
@@ -117,7 +117,7 @@ static ssize_t mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->mode = val & ETM_MODE_ALL;
 
 	if (config->mode & ETM_MODE_EXCLUDE)
@@ -168,12 +168,12 @@ static ssize_t mode_store(struct device *dev,
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
 		etm_config_trace_mode(config);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 
 err_unlock:
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return ret;
 }
 static DEVICE_ATTR_RW(mode);
@@ -299,9 +299,9 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->addr_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -315,16 +315,16 @@ static ssize_t addr_single_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -343,17 +343,17 @@ static ssize_t addr_single_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
 	config->addr_val[idx] = val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -367,23 +367,23 @@ static ssize_t addr_range_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (idx % 2 != 0) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
 	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val1 = config->addr_val[idx];
 	val2 = config->addr_val[idx + 1];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx %#lx\n", val1, val2);
 }
@@ -403,17 +403,17 @@ static ssize_t addr_range_store(struct device *dev,
 	if (val1 > val2)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (idx % 2 != 0) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
 	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -422,7 +422,7 @@ static ssize_t addr_range_store(struct device *dev,
 	config->addr_val[idx + 1] = val2;
 	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
 	config->enable_ctrl1 |= (1 << (idx/2));
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -436,16 +436,16 @@ static ssize_t addr_start_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -464,11 +464,11 @@ static ssize_t addr_start_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -476,7 +476,7 @@ static ssize_t addr_start_store(struct device *dev,
 	config->addr_type[idx] = ETM_ADDR_TYPE_START;
 	config->startstop_ctrl |= (1 << idx);
 	config->enable_ctrl1 |= ETMTECR1_START_STOP;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -490,16 +490,16 @@ static ssize_t addr_stop_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -518,11 +518,11 @@ static ssize_t addr_stop_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -530,7 +530,7 @@ static ssize_t addr_stop_store(struct device *dev,
 	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
 	config->startstop_ctrl |= (1 << (idx + 16));
 	config->enable_ctrl1 |= ETMTECR1_START_STOP;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -543,9 +543,9 @@ static ssize_t addr_acctype_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->addr_acctype[config->addr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -563,9 +563,9 @@ static ssize_t addr_acctype_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->addr_acctype[config->addr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -601,9 +601,9 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -616,9 +616,9 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_rld_val[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -636,9 +636,9 @@ static ssize_t cntr_rld_val_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_rld_val[config->cntr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -651,9 +651,9 @@ static ssize_t cntr_event_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_event[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -671,9 +671,9 @@ static ssize_t cntr_event_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_event[config->cntr_idx] = val & ETM_EVENT_MASK;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -686,9 +686,9 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_rld_event[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -706,9 +706,9 @@ static ssize_t cntr_rld_event_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_rld_event[config->cntr_idx] = val & ETM_EVENT_MASK;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -723,11 +723,11 @@ static ssize_t cntr_val_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	if (!local_read(&drvdata->mode)) {
-		spin_lock(&drvdata->spinlock);
+		raw_spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
 				       i, config->cntr_val[i]);
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return ret;
 	}
 
@@ -752,9 +752,9 @@ static ssize_t cntr_val_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_val[config->cntr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -947,13 +947,13 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	}
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	CS_UNLOCK(drvdata->base);
 	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 	CS_LOCK(drvdata->base);
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 out:
 	return sprintf(buf, "%#lx\n", val);
@@ -1012,9 +1012,9 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->ctxid_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -1034,9 +1034,9 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->ctxid_pid[config->ctxid_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -1066,9 +1066,9 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->ctxid_pid[config->ctxid_idx] = pid;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
-- 
2.36.1

