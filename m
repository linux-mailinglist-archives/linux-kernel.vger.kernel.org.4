Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C062C6F3236
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjEAOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjEAOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:42:41 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F002E9;
        Mon,  1 May 2023 07:42:39 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341DpATH019921;
        Mon, 1 May 2023 14:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=8bptpwPNhEwdDfot7qALpC5WOfOQEXNN3LXhwBLR19Q=;
 b=fnNA0Y6hS0p/MzBPhTq55XyKsaIFvUsgUXbwMor2d4KsB55EFcaN3AmZt1JTUgBndavh
 jc+ab7K44G0JbH6244nXsmu39X+eus/i2Z0/U2wKQyP148u3sUGJkhJu3lKB5TSduBCG
 Pz9NVfX1H+rnheBzFWQqlieg+1GdueTYmqEYwchuN9iII8BwozU37FO04+N0tugWfIRx
 Aa0wCVHyirVcA5iEq9D00ZWYfKt4kZKTrPxgPUdNGtXIX5E94oGExj6V3GoJPZP9mGfM
 MHY8T+yrztWo7R6V5TorGmfyn7165B7vva+GK7Wrp3j82K9vooN3Bi59rOUdzZ/stFbi BQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qaahu85k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 14:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN3Cyo9DW0MOniK4YckippbNBHJVRtz7xSxsuRr8b7otRKMArEQ1yYdQVWuuWFFlJCI1JISrYuO/S+Zxd+94WH6WrI0YXe4j68mOedD/yEfS02L0RW9MFS8WxnmP2+o1D6SG7mRQs6oFuW9evoSS5oBEnrEsqprQ87H98bZToq4zD1hfpjiBOdOroixnIlE2/xwExFQuwS3DK3capVVvTv9zORCC9Y7C/ci1aGNQc2pWlFer62D0FulOpFe8USMPfYuVddPzH4LhtML1gbiHbvYI9aJdxUO/QhtQZD5S5GGx1imXvvr6DXqMgqVnQP0W7IOYDVAHktWj13WqJyTpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bptpwPNhEwdDfot7qALpC5WOfOQEXNN3LXhwBLR19Q=;
 b=fhPypb7dFs6v5i3dAf1GAUYybQw2V2SossWYd/yjKnkvTnzeoWHBrMgyCIlkTriAHFMmtlQzlx2JSTXR9syILbnLAoqwby8Bnu+tUDuD0OA5FOngoT2eTIzRmxz8xYK2LqD3AZdVYfWob7+DwpJLogfdJ4lAg1YVSbt+A11oT71MWh8Uv68hmVpBsvf2FzY0jtzF2dsAAL6jPFArzJzFVbTFWzXYVGSakW46/5/chG5BDl4bF1ldDT3W8TRET2xQ/va5FWTyJyzCoefCWUEnlMYgrWYqn+qGlGmIh/DkrfS9iXnJxecfOb/hNVxHkjr9o95KPH2PZRwBwtsTmL7nmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Mon, 1 May
 2023 14:42:12 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 14:42:12 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com,
        bartosz.golaszewski@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Mon,  1 May 2023 22:41:39 +0800
Message-Id: <20230501144139.985767-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 995b771f-7834-438f-3be4-08db4a524010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+PVVFLfP8jh/9Dz2pooOFWQwMy6s1NQWxKZQmrrtgxJge9bzJvpOC5Hm86VciEpcmxN1slxTisokCG1q1MuORyafRiCbQg/QD0jBL2CJmUs+9PrEeWqq+ncjP8UuaNqq69Z57CN0wKIrCK1xgd/p6vUCI99oI6m0yFhVrfUdK/aMREoZQHMStUFxRbvJDlAxIVmxf1bsbfV+3oiGsIqVwmZMKxtLFuzkU6Es4w8qxMd+KrJ2n8glyRVhppDoiYZhFhJIymx6uJ/O5K2cA7CkJz8RKXFVbAZH7fNu6hOxUOplxf1SbIGdwqTYvzSEpCtdBuUEZJSyUc9gjSruef5O7OgJnhV6cd+iBNF5lSZOOjS6tp7tERMcR3PPm3l248wykO88p/zhV0S62c3apF3+jEQ7q/SWsJK7my935OINLOgBwsQlB0CGgKddk66+0hEankxGAIiAbdxbwip2pTbfvxD0ZYc/wSlEslX2jzmM6NS00Xl3cxMSe1cz948WdGXuJtbtYjsVI/jXUoSg+stEcS/ymfUSB9eGGygJxhH/Rdr+Dj6FjG1XepqOcEJD3QrT2PXhBWT/hvQwVH2a62mBdXDL1xo683VpnwlIAW/8ScowwTtilp6pizwcnpSA6uO5e4NzroJSP0AHxvKROxOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(451199021)(36756003)(66556008)(316002)(66946007)(66476007)(478600001)(6486002)(6666004)(52116002)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(7416002)(921005)(38100700002)(86362001)(38350700002)(2616005)(1076003)(26005)(6506007)(186003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QeOsJcd6LIessgEyEGLsgR/VmWDrM+ikqdW8I1GDQaEhjWji//nsyqzSu9f?=
 =?us-ascii?Q?pzVum8aHQWTU+1q4XTxcQAxWgquexvTIEFZ2FcBiMZ4puFwpW0w9UTJJEFXH?=
 =?us-ascii?Q?q+rMMF/SHT+2ToDPa+4yrhw3HWsVLkMHCA8B7gOPSS9RlBA/QB9AhVQmDhVQ?=
 =?us-ascii?Q?g2pVim9wrldXgJGErhOp9IAtzZg4XsTwgK9FhDOcFJAh5+qhGG90fJUSHTqx?=
 =?us-ascii?Q?ldOkwvEIG+i2Qv2NYCOlDvPOeL5NNK0AgXSAWdei6VnHkTfcaiKiX8a9+sLX?=
 =?us-ascii?Q?XTSbLuj2oQlPq0RoFGeTjyRHziDv7XBY6yETiko2ads/LCam/AGZT5hkzLHC?=
 =?us-ascii?Q?W8tgiWE6l6IoV7v+dGeCTQEM0ZLH1Zm60U8E2/VKxqEd7FcsOypweyWjuXU8?=
 =?us-ascii?Q?ibXtOwws9fO6IYTcbFtlHJsz1am+wgTpJbh8J2BnXL1uwZYutGBI8Rfv0MF5?=
 =?us-ascii?Q?IPoXD1LEI3WB/3nBrPhorKuDKf7YiBmk9wUdqKqD7koFY1CvRUulUBKwCIbH?=
 =?us-ascii?Q?qhLRjwqnmkhX+zPwZ/NlpT4GLjHxHjX+M3FEBXp12m7lXsdfojf+ep3BronG?=
 =?us-ascii?Q?b6LugxQpdOQUZqc7/zkAQ09pFcP/qQFk51eGP5TulAw0ttQN/Dm2p3prZwVf?=
 =?us-ascii?Q?l/5hkWOj2Zb4Fs+165IJS90pVi76jFXNcrTyECWpZ686NAk3BWmsTXsfenHT?=
 =?us-ascii?Q?rDpjqxMTUHE/QXrJWcjOX5mkkEheLzEkSHsTLGyRz3lTTTdF6lfjz+T4A5yA?=
 =?us-ascii?Q?/bvcfBsEcvV+VkumwvuKvNVXK2AqeEELwgz0srFq0shkCmM8J+xzrjJUH+Z1?=
 =?us-ascii?Q?6JnRr9TIH5QanCU5Q2w65yDjuHPGyxkjp6ae02pfqDR8MMLJfmVBdajXGsR+?=
 =?us-ascii?Q?QR5Upn0wZvYkvY2d5OwXdCeqth4NcE/ASJiPKubeLkDDXQVa8dRc0DBBIQZr?=
 =?us-ascii?Q?KQY/FRdP/eMIjDmIjjac1+YcRxEIr2ads3FcRAdr8bfzoEct5hszcUvg7XyL?=
 =?us-ascii?Q?LfjBGnw+OHopNWM/FX/hnOi+pS4w6rz8nk6JxT6VKOg1aSPTgPLUBsOQ4tj7?=
 =?us-ascii?Q?KLZ9YhXm8JIzLKUGd6KNkFQGKlx0yx4mFUi0iUvYtzAbEAiKPguuDTqcyfOo?=
 =?us-ascii?Q?ZdlKc5ZS+3IHS55k2qcm2dW4hWb00c/g/a5bSY3XeNgnvkCP2GvPKXRVz5Dc?=
 =?us-ascii?Q?js3gX/fk1DljhH8cfafY3fKh1sn0/ZKdVdc7UQIQsCmzNjzvukWeWD9redPT?=
 =?us-ascii?Q?CMOJXp0vj67101iZ4nKd/n1egv61Es4DIz79gVFCncBxRknjeBC28l4AxQME?=
 =?us-ascii?Q?2qxXFo/T1/Nblo0VY3J11OUka5rVoQ/EKtbq5JQ04PpYC+VvtwxqXyJ2k+3V?=
 =?us-ascii?Q?Ju1TgMD2qG4x0BBKGMiRmGwB+ikizmnNaC9W4VgLxQV4/DsQ0KLnbxjaOmcx?=
 =?us-ascii?Q?V1d224mpG0YFVtbv3geCgLref6E0uDTGCkjwCoCx/0iLvyfpdlmOmhpvmVBf?=
 =?us-ascii?Q?CglJ3pA8Jbmwo3XReQVYmI/0n0nbGqSKQE3psu9oxypwTQUKJBNOH4brZC4T?=
 =?us-ascii?Q?tN5g/XvToTfyjwdQvRqYEQmoHKtOVaZuEzS1fsHOr4a38+5pY8SzfE9h6miS?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b771f-7834-438f-3be4-08db4a524010
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 14:42:12.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMEHyLg5bsz+8wltGQk021Qps2MQzpAyPawXjQNtGxNDMFmFcUW7jO2NKv7tJBTD9JOTpoVH9Ht3e7PWUjJh32JaNUn3W3AABkwONlikblI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-Proofpoint-ORIG-GUID: 8FdW1Acu81nitibClySK5_MDv-1mYdco
X-Proofpoint-GUID: 8FdW1Acu81nitibClySK5_MDv-1mYdco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=469 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
    state_store+0x90/0x120
    kobj_attr_store+0x48/0x64
    sysfs_kf_write+0x90/0xb0
    kernfs_fop_write_iter+0x1a0/0x2a0
    vfs_write+0x2b0/0x43c
    ksys_write+0xcc/0x180
    __arm64_sys_write+0x44/0x60
    invoke_syscall+0x60/0x190
    el0_svc_common.constprop.0+0x128/0x160
    do_el0_svc+0x40/0xf0
    el0_svc+0x2c/0x6c
    el0t_64_sync_handler+0xf4/0x120
    el0t_64_sync+0x18c/0x190

  Buggy address belongs to physical page:
  Page: 00000000c09aeabf refcount: 1 mapcount: 0 mapping: 0000000000000000 index: 0x0 pfn: 0x89df07
  memcg:ffff000811bdfd02
  Flags: 0xbfffc0000000000 (node=0|zone=2|lastcpupid=0xffff)
  Raw: 0bfffc00000000000000000000000000 dead 000000000122 00000000000000000
  Original: 0000000000000000000000000000000000000001ffffffffffff000811bdfd02
  Page dumped because: kasan: bad access detected

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

