Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2996F4E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjECBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:22:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1932CC;
        Tue,  2 May 2023 18:22:13 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3430vrTU023736;
        Tue, 2 May 2023 18:21:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=+1RgkwJLdAJUJJO5LbJNMNCyEssUFb17iZLiwO/Y0dU=;
 b=KDm3uJ51AUPFGgoovx1Sp+oXjLJMu8q5MglI6w4lEsLBqBLrEZZhv7mts4JKV6kdfoWr
 B9ybUvUaPzgFIaaUx73q6yMLAJFmOlI1tI+m7h+q3xMehD0Q05P1M+iohLbwR+HtMc66
 EgtNpQTolqmA6TEHn82z3ZAsAgqNoTSa2FczgTSOTacNFmK92pYdAB2fLQftB1324xvL
 3NyAv7e7fQebOIrIaZL6VVQP+yjlEu9GY4vozt4MiitTeGyQ0aZtodGY5FibDame3iEx
 Yp8NK0W7Y/L2aNagz3t0zk3uXTVP9b/iqwi8FEwGgr3RXGMeVRTo4vdbuQsEXLxtTq2g Mg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3q8xh5k6sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 18:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzfMVN/yFGdq8Dg2W29hdn4t6opzLoP+uJskg+p31lLlzJb1IejnbaG/UjBFqh5ONXCNl9VL1l7qc0+n8YWzZfW4QwazpKY67MIf63KfD0C2j1d/btpRBahbiufwK4I/A2v1Fuf7ToPbmRHMFpjP8Knwr+7SueXvJ7T4rE1f6HqF3WAbMujnZcnJWjOt8lEpUWXzI+nBCGqopw9JXKLetLelgeLTpKFQUL2RJpTK2Zwck0WPGqXrcxko4kQvGtzQ8eC/dV/OHw6zi496dyPEMNdVean37aQv0Vo6JCSpH4HmBCMy4KNFrAom0+JH+xcNFoFv4hWorNxLsoD2YZiKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1RgkwJLdAJUJJO5LbJNMNCyEssUFb17iZLiwO/Y0dU=;
 b=JVLL5kFm32dhvvTVCp9aeG5QJa5sHqrGXu6nSbrJaOljOhv7lng1dDBASZlOuETqA+5Sx8Z7K4JJxlH5wcaaVJLAiPqHkPvRqICCp1gHvGDm/yt0mbHrGRX+RWcK4MtAvOLE5YKSy8j9Qm+trH1ChB+kHUkHUqDiCywEoVhzrLfCAYfIW+NQhL4pzGCv8rKRAcCP9UlC0eJ0CpfIiBM9OdKgJCZwTeP1Cfo4MAgTDzynjCY+YkEHrVgUS/5BazV/ZEE3gHfPr+VJ/QyKvIcfD7pVEnBZbBUXnlG+SnlPw4+5aNpZlBxi1+mczCgKsl5WSZWb1sqKlDrvPTv6RMc4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by BN0PR11MB5711.namprd11.prod.outlook.com (2603:10b6:408:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 01:21:54 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 01:21:54 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        shenwei.wang@nxp.com, bartosz.golaszewski@linaro.org,
        peng.fan@nxp.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2][PATCH] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Wed,  3 May 2023 09:21:27 +0800
Message-Id: <20230503012127.4157304-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|BN0PR11MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e9c5d2-84fd-4276-f8f6-08db4b74c7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQvwfVctGDcdOJjZrYC8Lgv+KbzAzamOgkDqJv6ocFJGEoAJM2x4IWEADKSzXnWjDnWLKSBapE5HpMcT0X/SIfALSzea91NgVvOS5x7AmMpzYua1LRtn8QRLzBRPsusZohSovtzpiQoNqjZ0kv4sdA9ojWhX7+6g2fyFVJ+7FN30O+HLKWl27b5Aaksx++5APEbz0/uAW3nvTlKE+95wrILDxWUQ3W0QgW3CTa8ivIugafcScprBeG80J9/Je5uX6YzP/8P2kcfYFhJ2c1eRmqlxA69Pfq4p4CJfmPVVFEWtPjyl80cuWD6NfUouUeqrGUvyk3pcPShtPHpGAR7ppyO2JPKRiEMlpn5D9OzNi2uz3mvZ3DptcUzZ1sxWJ2YfZ9STkzvrwtKOQyZB+GBJdNnrfGQ1vZwqwljjnPfIpA6Z+A5TNr3/nLTi8iJd/Us9VJWQZxOqtnUBqWiqTnP4KLJ+tctalu+lf10kv8AokliFsa29Go0i3x/o3dZDyNlrLA+D78n7biOJDwLvO0pOYcsAN4BBI9pfKhW/znjzSO7WWjgzM/ER+ltkLbtHC5Jv7gqqdqGMG40sLU4mG4aCn1FJ7uP/hO7nzW5UdFULHk/jF5wCteriOvHnAtUNlZYIARVbHDkWoiEHEuM2x2dMHN85DcAIiRMhQe68onqnzjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(346002)(376002)(396003)(451199021)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(38350700002)(66946007)(66556008)(66476007)(316002)(2906002)(44832011)(7416002)(86362001)(186003)(6512007)(1076003)(26005)(6506007)(6486002)(52116002)(4326008)(6666004)(83380400001)(36756003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMZ7iVZr5M4dG24LzrjBdwbvIaX4qsFhL3dXZg9ycTk/L4nj5aoH8hCv8Iqf?=
 =?us-ascii?Q?aZFSIp6mH3IGKiomTJ5YXn3egJ86Qdt7nBt788//dayCQNqnPhXiYwyamQP1?=
 =?us-ascii?Q?pVJwjGJhqE+vO5wBMlPL3X75jaLBY/kqGueM6mLg3PYPe1H0vEwyauBibvSa?=
 =?us-ascii?Q?tepm7lgqWTUEaY1IVDAra/Ugn2i3w7L9mVpAoyR6OSaGK+kTJn7EfkCf+p5G?=
 =?us-ascii?Q?7gQt3X1sfS/5wJ6PuVFE8nx2Ypeqs7XnEMzJwQTQdf9omXHpNGwLeLj38Vmv?=
 =?us-ascii?Q?Bpyi9qycrEOkw4oE27XPlnMiAs8b25DOqM9WRzp04OexzGRMSiwevsCoKNUk?=
 =?us-ascii?Q?/ivFjFiEMBQ5HOb8eUonyxaTFfolHGBfwmYViMUor71shKJxJcn1CQKJi2GH?=
 =?us-ascii?Q?ztvGO9zyo65KoY0IYXnazSIIy+2WFxa09BWmJA2/rLHFcvZBmtaIr6rpWXAz?=
 =?us-ascii?Q?C+4pWRE5jgJ6lIGdVCn5/mAiD/AaSr5FtRLwI3Z6yA5wOyYbu1+pKhCPu7eU?=
 =?us-ascii?Q?kHS3Gcry6FxaX7RJjJI5PaP/2ES105Nqv8kGzUky+5ipkNHtJF2pTvBo+Lhn?=
 =?us-ascii?Q?FFQsnlQMKP4AsQUd7g2wMI1sehgZvGOPgBJrstaolha7MMFu2Ian8C+jMBis?=
 =?us-ascii?Q?xK9vMxtqQwsS+KlKzOJblGPsx8gymaVKV5LIEjeYrcyR2xf3bQx57AdTeU67?=
 =?us-ascii?Q?av4Co3p8JY3g/4nu7B9b2HR/ilVquGuXsJuVfWKezdSXyU94U79wFXYbYpT/?=
 =?us-ascii?Q?A1lfT4tURct2jaEiTAJGIdNvttPOigSJRYnteQnShY+ufaWRWN1GKPOwYsXC?=
 =?us-ascii?Q?nxrGLhL/3n7sbrXqG00lTUC2ypTAm+7HDbfRu2rGhA31YCQWmWEOsNVpxiK7?=
 =?us-ascii?Q?l/fQCK/R4k43OYV7FvHelSpCf3jVXiTEYk6Tr0r3vME+52U4NJ7JEWqhySKY?=
 =?us-ascii?Q?TgfYQG5+Qt331O0OZEBhCbPFnp+sQVy7SZInvwWarIwNxDhMtUvBB3CuNkD5?=
 =?us-ascii?Q?zkfyNNzQs/88JwPrfnc5kKanQwcBC9vGo8XQi+EQ5tlP8JFt7aB188Ain42V?=
 =?us-ascii?Q?499gHMGFYoFO3wAihdoHBBtzsIAFZTkrbL+x+x8xsMClHiFASSRT/04nM17c?=
 =?us-ascii?Q?jagqhObI6vLuzLF1qU8CkVL3BH3Ji97Jgtt81sxY0a66lITmNcd5LRs1n3xS?=
 =?us-ascii?Q?XcsXZEtZIJe0aHkw7yhaE2p6b8l8ugMt7CRrt7VJGzq6RmhZnz1rWnqFCF1d?=
 =?us-ascii?Q?r8Hp0xDt+n8Jvx0shft4yV6SYarmsb3wjaKgQwPnd1rzaT/VgbniB3gNbBYw?=
 =?us-ascii?Q?hIPmKY74H6CUwIgGWOrcdqn+qZhsskSKChCZbtuUZAaAVXWzfAYW0BwUNlm0?=
 =?us-ascii?Q?U9l1HcB4QAvCIwcp1anB0PfLVMqppedNwS7aZLFK4LxvvSmcmxz6IvOavHBv?=
 =?us-ascii?Q?2taozG9y3Y31FmLoW4FjeAd/yLOI3tgNWCkTMCvwD4qVIAvp4NGbi4nZIo8H?=
 =?us-ascii?Q?KKvlkHHmrHzVrRqKHQ8TmHLSBm2e/gkGpDRbnyrF2nkzrAuitWrJCNVmoSVa?=
 =?us-ascii?Q?HKidAia3pmwq0ItOu1Tx/gBPz5PAhJmJFmLWNk+kHDniCwkRKM874JMCAR85?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e9c5d2-84fd-4276-f8f6-08db4b74c7d1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:21:54.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjPE3ccb0ldYqO/EsqqN0HBQO7paD8nsIGjwI8/RbGlJgUAkSSnWRlbDHCp8/8D6BUn4/oex+8qChB5sN6jbnQaTMzsSqWTD5P+l8jynnsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5711
X-Proofpoint-ORIG-GUID: iXhrNyVLBJ4qkcJjRqCTKc2TSY_LDZ53
X-Proofpoint-GUID: iXhrNyVLBJ4qkcJjRqCTKc2TSY_LDZ53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=590 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config passed in by pad wakeup is 1, When num_configs is 1,
configs[1] should not be obtained, which will generate the
following memory out-of-bounds situation:

BUG: KASAN: stack out of bounds in imx_pinconf_set_scu+0x9c/0x160
  Read size 8 at address ffff8000104c7558 by task sh/664
  CPU: 3 PID: 664 Communication: sh Tainted: G WC 6.1.20 #1
     Hardware name: Freescale i.MX8QM MEK (DT)
  Call trace:
    dump_backtrace.part.0+0xe0/0xf0
    show stack+0x18/0x30
    dump_stack_lvl+0x64/0x80
    print report +0x154/0x458
    kasan_report+0xb8/0x100
    __asan_load8+0x80/0xac
    imx_pinconf_set_scu+0x9c/0x160
    imx_pinconf_set+0x6c/0x214
    pinconf_set_config+0x68/0x90
    pinctrl_gpio_set_config+0x138/0x170
    gpiochip_generic_config+0x44/0x60
    mxc_gpio_set_pad_wakeup+0x100/0x140
    mxc_gpio_noirq_suspend+0x50/0x74
    pm_generic_suspend_noirq+0x4c/0x70
    genpd_finish_suspend+0x174/0x260
    genpd_suspend_noirq+0x14/0x20
    dpm_run_callback.constprop.0+0x48/0xec
    __device_suspend_noirq+0x1a8/0x370
    dpm_noirq_suspend_devices+0x1cc/0x320
    dpm_suspend_noirq+0x7c/0x11c
    suspend_devices_and_enter+0x27c/0x760
    pm_suspend+0x36c/0x3e0

Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/pinctrl/freescale/pinctrl-scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index ea261b6e7458..3b252d684d72 100644
--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -90,7 +90,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	struct imx_sc_msg_req_pad_set msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	unsigned int mux = configs[0];
-	unsigned int conf = configs[1];
+	unsigned int conf;
 	unsigned int val;
 	int ret;
 
@@ -115,6 +115,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	 * Set mux and conf together in one IPC call
 	 */
 	WARN_ON(num_configs != 2);
+	conf = configs[1];
 
 	val = conf | BM_PAD_CTL_IFMUX_ENABLE | BM_PAD_CTL_GP_ENABLE;
 	val |= mux << BP_PAD_CTL_IFMUX;
-- 
2.25.1

