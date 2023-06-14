Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8373013E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbjFNOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbjFNOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:07:37 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA691BC6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9dBGmboSAquOzq5merOpnDWeucjFFUW5avUtVMJHuknmQOjblCoDTyTlWHDwgyOFGhAI3j9oKrE1nSAkrYaXwwJlCldgG3t/4zGrC/MWGb9R6p+8hak05Sxxbt6NNsI34s3mFZV95da+J892+q1BVl1qwbzqNTWikCX7ThcLfF9Ud57wDtSnBrFWgHqemzflvQ3gvxeXQZjwIy1shyLvgyYI1DzHl2sraOd1YuZiYJaHQvH5sV+WE2kHTBQykEjDmh7S4TQi1B8efeTToiKr2cPGgY+UlaDtgY2ZadobtOr/D48sLc3/F9fIFf9ngwvy6Drv7dh7GG+G0UdldXvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaYh+WATvL0iBsYu3pcyIuQ2v8LR3j4orLEr/DbsPHo=;
 b=HeRM3nG2bcwW8oZ7mT78RnEsZdecgkGAYy2RifmQ0G6cTpEAHA7RGaJ3sKrWD3HT1eELyycdgiFzY8/c2qgOWEdbFHGHQO/OsYIjU7EOpnib4+VTSfXU60rdZrGKoXnk2YkivZk64L/HcxdFS4KEM0FY7WalGVC5T6HVKKlAuF3fVezOW2XmprxJYq/IKQnsPuxt44Oz0R+YZVarzSv/N/TR+dSFacGhfErPOqknrazgQTrItoO6W64BlBB5PJunbvGmCTUd5f0tBKk8tjzAoSzLG8hls+Gs/+lFUTCGOYJddkz86yDZaTi/EVFoREzGhnwPEYJhOuyR+JXxobykBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaYh+WATvL0iBsYu3pcyIuQ2v8LR3j4orLEr/DbsPHo=;
 b=k7ov9tv/J8Tue1zZQ/CYVE0E6vhTACb3WmJBmEWyKbfTS6YcFnt/Y2CbSfWKv8Hcn6i6ed01qhSLhq1f2ryBsCS0Vuf3nVzsUq0zM+iQXGF5xbCnVGMBtUSQZByrXrHQFVviS7WxY9D16d8pK264RG0AXJfQrcGKTMPhPjmFzbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 14:07:31 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::2ee8:3c86:f44c:44c]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::2ee8:3c86:f44c:44c%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 14:07:31 +0000
Date:   Wed, 14 Jun 2023 17:07:27 +0300
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     laurentiu.tudor@nxp.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND v3] bus: fsl-mc: don't assume child devices are all
 fsl-mc devices
Message-ID: <20230614140727.z2vhfefsbwprr2qi@LXL00007.wbi.nxp.com>
References: <20230613160718.29500-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613160718.29500-1-laurentiu.tudor@nxp.com>
X-ClientProxiedBy: VI1P18901CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::30) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: ab123bc0-6cb2-4466-4dd5-08db6ce0b174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8938jnMFTQLU67Ya1q33mqZj7lF1XT+g3D9PZ5YOCb5vh+gaU77X9fJ82JJKgv3ZTBX6OuoTz56YWGdHoE6A6guWglFEd+PCq6Ab5odm3aD+TV3FAl/Gq2Pb/ukUdWRPkxfB8PmqMQklpFFdQMhABaONbnlw3xQARhU0PtUGgTnSpAgNyUf/Nh7EBAudL78dEHzeQu0SmIzjZcTUOVAjcV3N5QU3J1KEhLEWqW+HaB4T1MWXzxKeGTS4tOY0DFctPMx1IT9UKqedBEhJ7s7tGCLUoViOQ6McJJN9HriKWJsevJ+mlbXGU9G2smlGsYWVATjW6v7HqwLk8Dfk0mLpB+axW1yELlciJ3N44O3MA1X25kRB/vwakVxiMJlfNbeBcMRBuZK8T94o4i/GD6Nlakf/6JZ5+hnklGYq5E3bpF/jI6w2GDR8qSfigRxCl2JPy33my4ZbzGQPxgdj9ePmM6+MCq4CoBbM90LifMsEuIRb1unZTNw4yHLO6PHNI7DrixBEoDuSgMeQPJEWw0OjvcNhm/pleZNggTL62Urw55c31MgNeahpjE+2wa/oIksk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(186003)(6512007)(6506007)(1076003)(26005)(86362001)(38100700002)(44832011)(2906002)(45080400002)(6666004)(41300700001)(316002)(6486002)(8676002)(8936002)(66476007)(66946007)(66556008)(478600001)(6636002)(4326008)(5660300002)(34206002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcdmXUhkAtgmY0Ys8We18fcFx90+Q/jHDRqSZjEKP3dQOSaU7TSbHtGCB1rX?=
 =?us-ascii?Q?aqIz0V3oohdqStM+A7KfzVwr5igkQU6hXO994aGSV4jB7cY3blRN78OH8mQM?=
 =?us-ascii?Q?oYcmLs5jq1R9qatjHNzWi8mHc30YoKnQ8hWgA8jy+bvvNDJbVpy3yn7hHc6A?=
 =?us-ascii?Q?lk1BLcU4KWMJN3hW0ieYrG7m8mbBIKc6yxsJ43dOM4rNmKxnQyg8HgStP5xZ?=
 =?us-ascii?Q?P0RzariNR6zq+nupA35rnreXVGl/MJPTwm35xZyAqTbM4o+d81isKVT7F+az?=
 =?us-ascii?Q?altnfskOEEHRikInAMMklg6jFYCEGuCwJBk6LE8d6UseIuzaD5jsRFbWE3du?=
 =?us-ascii?Q?jk1aGFq4fuBLqUAEmKMKOqzNWQPEnOZy8of9vK85IMIRfbXLVh4vPvV5Rbgd?=
 =?us-ascii?Q?zAmB8mOMH2BrmxisCdc2r+e8Apseuh0BKulVQ9q+4RlPZenfJa2N2O2VSg9c?=
 =?us-ascii?Q?TLK5AExqzl4GHs4ZdMf4r88jmL2fg8OUZ8dQVDx7sq5jxqh9D2iiJukqtiJS?=
 =?us-ascii?Q?c2W2U5/bjTPakGrQhG1rZZYhNYY+tMFqUx4nieOS2Oa0eA7bLjjf4wv4eV2q?=
 =?us-ascii?Q?vdddV/QPZalzWzdFzTIPiyJCYKAszhbL83SFHPKXNLPIHLhTnpIlnfkz45b/?=
 =?us-ascii?Q?JZU04np3TOAlo/rjQn+vTtInrv4CcF/iKHJAQ20B0XiZqLdYQZrRMgHnjRte?=
 =?us-ascii?Q?Ez/uMNH8GdR8kys10jxr9CHuAhY+C7la89SRjs1siNSgnxFkQzux9cBWU2Ia?=
 =?us-ascii?Q?2rVdrjmDutPwZt0RCbLdvCAcRDGjKqnl6O40eMHuym1WJ//k+/Fg74tlUKGh?=
 =?us-ascii?Q?BKWLHPsbTl9W7Os/BYYecQ8LuhxUoANQWdjcw/goINEExUp/TZgLLnv2Q8bL?=
 =?us-ascii?Q?G+CZvd7UQJgIj6wW2Wp27hpMO32KzGMtKwCPDgq0KAQK+vWED9ZX7nRl44TB?=
 =?us-ascii?Q?vm0U/JZLx3g19mh8npRt7hM9FAoIGAFI0KtcjMY3tjwWaALpI3ae+X9tbE3v?=
 =?us-ascii?Q?bI2aKq8s56DGBbCuUHYmBeWo8CSGfOWRMrneHZS+rIjx2+eRtzL+NQIdh8Kd?=
 =?us-ascii?Q?gClTO3up16tZu0g2OYvv4Rd/fmM2YrG+jzzsEST5Dg4Ak9w6J2GHqzBRFNqK?=
 =?us-ascii?Q?xPfadWeN6Rcr2FA/+255BQlXE/IDg22LHGZ+T1pcsAqXkMACtwwBqAxDoV+2?=
 =?us-ascii?Q?sliClRQykwPoRonS2Fk7Uh5rZWDXrq714+vj5hmt39U3VlqFPE3o5Q6wdaSw?=
 =?us-ascii?Q?sMeQF1+cJ1rsTCPuPaPW4Cv0pE59nb05saFGJfuP1AJW2Xh2EqFb40kgaS4q?=
 =?us-ascii?Q?Xg0CxvrbfaPP0djzXJZWjXtUS5rkxwSuL6deLhNtGGQkXF3kUUyrQBUmaj5q?=
 =?us-ascii?Q?kqDSWphWWykpPrCfGUmovokWtWaL2wJfjwiF68BxUj3A+rGbIzutScEMFo3/?=
 =?us-ascii?Q?oOwKKsz12moGUS09Jp6GDJ+DhoJtcFgOPPfN+VCw/PUYlnIypIbqaVZei7wl?=
 =?us-ascii?Q?SuZOF8bPlXUiWf8HipN+ca1heoezuo2je+zs3N8OA/uhH8lNosSIcKxvHbwn?=
 =?us-ascii?Q?TGwXpn3VL6JLB+mfBRw+4ONQu47gLzLn4L7nA79z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab123bc0-6cb2-4466-4dd5-08db6ce0b174
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:07:31.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdIeBDHEWJWKQNLpntHZdtopZeSR4qJOX603dnZvKMyDmNMlDryMlvUUxUU1YTVSyGJXrxk1dDXqsDY9tMkJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 07:07:18PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Changes in VFIO caused a pseudo-device to be created as child of
> fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
> device to VFIO. Fix this by checking the device type when enumerating
> fsl-mc child devices.
> 
> [1]
> Modules linked in:
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> CPU: 6 PID: 1289 Comm: sh Not tainted 6.2.0-rc5-00047-g7c46948a6e9c #2
> Hardware name: NXP Layerscape LX2160ARDB (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mc_send_command+0x24/0x1f0
> lr : dprc_get_obj_region+0xfc/0x1c0
> sp : ffff80000a88b900
> x29: ffff80000a88b900 x28: ffff48a9429e1400 x27: 00000000000002b2
> x26: ffff48a9429e1718 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffd59331ba3918 x22: ffffd59331ba3000 x21: 0000000000000000
> x20: ffff80000a88b9b8 x19: 0000000000000000 x18: 0000000000000001
> x17: 7270642f636d2d6c x16: 73662e3030303030 x15: ffffffffffffffff
> x14: ffffd59330f1d668 x13: ffff48a8727dc389 x12: ffff48a8727dc386
> x11: 0000000000000002 x10: 00008ceaf02f35d4 x9 : 0000000000000012
> x8 : 0000000000000000 x7 : 0000000000000006 x6 : ffff80000a88bab0
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000a88b9e8
> x2 : ffff80000a88b9e8 x1 : 0000000000000000 x0 : ffff48a945142b80
> Call trace:
>  mc_send_command+0x24/0x1f0
>  dprc_get_obj_region+0xfc/0x1c0
>  fsl_mc_device_add+0x340/0x590
>  fsl_mc_obj_device_add+0xd0/0xf8
>  dprc_scan_objects+0x1c4/0x340
>  dprc_scan_container+0x38/0x60
>  vfio_fsl_mc_probe+0x9c/0xf8
>  fsl_mc_driver_probe+0x24/0x70
>  really_probe+0xbc/0x2a8
>  __driver_probe_device+0x78/0xe0
>  device_driver_attach+0x30/0x68
>  bind_store+0xa8/0x130
>  drv_attr_store+0x24/0x38
>  sysfs_kf_write+0x44/0x60
>  kernfs_fop_write_iter+0x128/0x1b8
>  vfs_write+0x334/0x448
>  ksys_write+0x68/0xf0
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x44/0x108
>  el0_svc_common.constprop.1+0x94/0xf8
>  do_el0_svc+0x38/0xb0
>  el0_svc+0x20/0x50
>  el0t_64_sync_handler+0x98/0xc0
>  el0t_64_sync+0x174/0x178
> Code: aa0103f4 a9025bf5 d5384100 b9400801 (79401260)
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 3c28a76124b2 ("vfio: Add struct device to vfio_device")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

