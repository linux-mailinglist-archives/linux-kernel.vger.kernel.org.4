Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E475BF440
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIUDXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIUDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:23:30 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03196050E;
        Tue, 20 Sep 2022 20:23:28 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L32WE0013456;
        Wed, 21 Sep 2022 03:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=Ijbvz/IWBPcmRZQD9ho6dej2gc55tymCtJ7KYeOYGN4=;
 b=VknB3pacId2m2EiUpRCU/p6a9i32HRoD9jsjKuWcTb5gJC2ZbkoxWBBmHh2GpvqcLFTU
 bsUvstrTYd3xXiTPizONywAvnrancEcypVZsKJ1PXl/OJBwAZ3XxYBV1THPzeXlN0jk4
 7Cfut29ijh0hEaBkh3IDd8bDH2C+EguYfQDOvSapLiC72qUE55+IzfHM13XZU7+06gdx
 ejOZ3fugzSdFwTCp7xVm8b78IUrNenBTR9sswFluvuy0mR+burP1bqKUaYjDZ5gffSnf
 Cyi+oSt2l2BBKhMkDjdxMKARgrB++sEkoLbOTa0JNHD844qbS06oXiPl/HCZc6GVm5RK 5g== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jn57a34q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 03:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT7T4IKoomT7T5QNjoo/e88gEEnMLh1i6UTCQy5ITcEz7vWaNcn8M5nYDZzKy//2Hcv8e4e4jieWlZn2wCUQ6yFa+i//yB8ZlyU13mUbBuY16r1l1QMoQIdkPwTM764etEauW3QzOP3zvmI7BKZKNphQXbb3Qsi3ntE/Gt7HWvR4c4QP1TVWEtDgqT3DrJjEjqXtP0taHtWNj9hosiP/9ATxQIHaqOGEBEgYTBi7kDl9STki8lcxCJ3RHhM0opjkXQeHFT3n5XUEJTqXNoaDUyjX2qJmyoWPpkmyWhRfv7IG6+/Qqn9Jx631JiugO9uc899fUebHEkcAs6kgkxXXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijbvz/IWBPcmRZQD9ho6dej2gc55tymCtJ7KYeOYGN4=;
 b=Q9WZYc+NPvgWlva7e4kAyIok/ld+Pe9+MMHdtIgJLo7s5WeShkaGDjMRpKOIacQ6Ka6fpEAGn5n7WyT6oXWb9CAMU68KSpzbymzmHuvGZwt19PWBdUTOlSzFScdx8PVZGgxrDVH5qekF4mj48m26z9cGi/0u0m2wR62hl0E7960CEy6PNli4IkGkkpthAa48xGGwD0/fLk7AtEIQnk7M0godYz+AaptxJVBsJTEuvBrfPIGbVWa/mJAw0cr8hRDFygb06f8m2vUXsAxmXm0eu1l56/eCGptUw5IflR75k08LalI64VHrokOBY+3IlMcf4g3auNw0zJcj1tNJtv5SJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 03:23:23 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::f03a:4b6d:66ad:b23]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::f03a:4b6d:66ad:b23%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 03:23:23 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, warthog618@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     meng.li@windriver.com
Subject: [PATCH] gpiolib: cdev: Set lineevent_state::irq after IRQ register successfully
Date:   Wed, 21 Sep 2022 11:20:20 +0800
Message-Id: <20220921032020.25398-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|DM6PR11MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f0dbe9-c02b-4d8f-15b0-08da9b80a3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TQyAhQgKFdOwdhvT4mAjeer69uZJZ5vlF7xM8jFHZPoEQhs+5OFCCyaI9TpvZnDPNs7Uml7erzZzugm7eltOUOLn2tSOUcg76wJG+MOQlDjVz0UMCR+Ck3Ip+zFuZPdQo6TIAvMdATW4eWBk5xG25+PIl22jHlGGZPh0eaObHcAxaR3LvRWaSU+hKagalov+gfu3qJBu4E0KZ8+m6emNd7Cwl3eeot+OpEmWWGFig+OuuOWRELmT7Qcyx+7eZKDAzmXwR0mh0Brgl+/DGZKHj0xvTFQN3TmwGMUO71KtlYjr2CajkwthFzYjNDtOn15blZG9CuO2Cnhohv6M3o0iBEJqQzro9pNFbipDU8Z/UJcoSsM6+v7IK3jVSG/BeQpEZz0meU9AYCUo4jHkOQSJEsikdojPp2sL/rTWxpVRZ/uQsZLkYQKjzosQxFeCHXE8uPKKBY6YWvUINX/MRziPAkW8cuSq2vKthZE0SI33MMvPoXF07r/f4eVNZOhvKFyjyOYRSIFn+zo+Ox4hvN6uDM3zlwfeeSIzi/RVVA1NGHwx7cPTDkM6xAbQkg26r0gv28bWSUx+Ci/oNGrKd9ortyyhV9HLo2VNNVfi9ab90E3ptzlbEgZWyWuH6GKtcIgPrWHdHA/pTEwOjwJaGaRkxCNukyRU6Ii/gRxpMpRPxOS3n6v4H7bwFDcIGFg+pj/RAh4Kllms7DHI4wfmOESfF1onC54HNXfONkFw7K5RiYwAwdKpB8xFRNX3QyL+B4b+rR2Q1H97uz3HfA30bYfDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39850400004)(451199015)(5660300002)(83380400001)(26005)(316002)(6512007)(2906002)(478600001)(6486002)(38350700002)(1076003)(38100700002)(186003)(2616005)(8936002)(36756003)(86362001)(41300700001)(66476007)(52116002)(66556008)(66946007)(107886003)(8676002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?has0VId6wkPgnaTyPIaWgDdiAoWydIQGIhOlkghC3t3vmSJHBFLZKDs8eoxV?=
 =?us-ascii?Q?lhP53045jN7mUIpflGhw5gFmdGvJ4pGpPfjH8m7JZRGS2rnhrMTVFklklaXv?=
 =?us-ascii?Q?++LwWuvGSm7+FMnAZ5PltUBX7zKjbvfmco/UnLukI1xn26GXIkck2YtHTo38?=
 =?us-ascii?Q?Dypsmz0nG4lUEcL+y4KgjDnKbF+zQA0pnQ6UGAVm5gUW0MwEZNfHYQfoj7Rn?=
 =?us-ascii?Q?GNxZIN/D/XwFPUXuk8bv5K7y+wzZf8GpKQhMDsMZuu18kmXslqXIsdV3JkrV?=
 =?us-ascii?Q?+k3Y2Akg82Peg5uOh3C4tun2RierWV58tbDMLW6gO/2Y7rexVncnCgbRVKko?=
 =?us-ascii?Q?cbcBaI5KRU44S4dxktb/G6MwkN78xNdMlLKJ7hpF9QHR/GHSp+kbMprtQmMe?=
 =?us-ascii?Q?UJTzIKdR8kAb1mIk2Wut1CMsLV1xtpa6YgddnNshKS9gY2u/nghpjfM2eX2m?=
 =?us-ascii?Q?48XSfVWzCXOqak6VliNganWdxRcWYynTc9cyv5TOtnfM7gpsZulrRUWNObfG?=
 =?us-ascii?Q?2rhqPQF28pE96tPDxkbOkXWn4GLgryxH7qKcdFXcogGJoNB0T+jfnSUQCk3F?=
 =?us-ascii?Q?Kbvgdc60YRih2h+AC2fYH69GLFE8uHFptbZnBkJslgUW0qRwwOfswlWu+6U9?=
 =?us-ascii?Q?39lehhyAoOYF3w99mQ50C5X0h8zXoTYhm9Xvw9zVR+jxOiS4IBaaAQD2H6Vm?=
 =?us-ascii?Q?0KsWrWU+ltOH715g32qGiY1zaY7JIuN3xwv0DHmUucyBRMRk0e3lEcvCQBpm?=
 =?us-ascii?Q?zVwaJMeRL3DJRwctGEUEieHmNu/kA8w7sGmKqagU3eBJpdEIKoLTcokuDV2Y?=
 =?us-ascii?Q?c8s+83ie4PIW5EFuvmrw+Ss6M5gZXSMfelP4R837eITTXDS6RFItrfLBjsR6?=
 =?us-ascii?Q?GeXFVc1oylvJqW2NLHRavicL7s4fxA54kl2pdhYwdshhy+4byJIrSVSnaN3N?=
 =?us-ascii?Q?OH9B6B/ZJTN2BiSVXAQZP3M+pcoEUSunenYn4FNdE7AKiLP1ODCL5NmV3jHA?=
 =?us-ascii?Q?hVTIB9eNDXbx7Q4alR9wChHraswShDWgB5186zLaLEgu1jdibrErAiC4+EFw?=
 =?us-ascii?Q?oPI6+XQFuOPRmORjgK6tDNrWrqQsMwuf8JwhmlGtIGDb+3Vuzol+UpMw1XhW?=
 =?us-ascii?Q?vKZp0IWqsam8M2YZORBVFhUJvNXc3Jf86AVb7ROyoh7VVY13Ib91CtDXcL84?=
 =?us-ascii?Q?ZToCVX3boWntSgdYyfPAZyA9tOND8WplnxX9LQvtbV4ySqPLQq5hxlBb58sX?=
 =?us-ascii?Q?YlyV3hp9WX1Q8OqsYaIPCjreeXnHP4MiCmiPHAsnkwImG7D57zCeUoWcBEmR?=
 =?us-ascii?Q?pievMjG7KNQ1euJPqAMBHudin9/yI4UEIaBFWZnG7Wnt5HdYBnC3N/oexMmD?=
 =?us-ascii?Q?IZVytJWvflFqnQGkC/0s7gBNdEB7aZhjyuQUrNt0wAHiyU30DnepNep6fCXh?=
 =?us-ascii?Q?6UVD+6d33vy4MQy0EIzInX5/zX+fLWSrjTqWSUW9UZqcwjyRVeeSp0BgUDT3?=
 =?us-ascii?Q?QeqmZkFJSCEH62gk3XeNi0+yzPplBRlfWu/pBYeHEA5N3aE59E+gxp2/QlJJ?=
 =?us-ascii?Q?JeK2iWeK/jN/+8qJxLkKv3/NO/hMEQpf8SooE/DGRa6kxyzYjM94dMIOYRJ7?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f0dbe9-c02b-4d8f-15b0-08da9b80a3ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 03:23:23.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt7c8pnQH35eWq7Wb8BuC7F3snTr1q3l5WzO/ANYI0CZIgeZmCHk5SFlEmBwSUA9r1bksHSbRH/7f8k8xkjZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-Proofpoint-ORIG-GUID: FAn6jvT6-TatgKWkF8tIKCxzUzQeQcFF
X-Proofpoint-GUID: FAn6jvT6-TatgKWkF8tIKCxzUzQeQcFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_02,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running gpio test on nxp-ls1028 platform with below command
gpiomon --num-events=3 --rising-edge gpiochip1 25
There will be a warning trace as below:
Call trace:
free_irq+0x204/0x360
lineevent_free+0x64/0x70
gpio_ioctl+0x598/0x6a0
__arm64_sys_ioctl+0xb4/0x100
invoke_syscall+0x5c/0x130
......
el0t_64_sync+0x1a0/0x1a4
The reason of this issue is that calling request_threaded_irq()
function failed, and then lineevent_free() is invoked to release
the resource. Since the lineevent_state::irq was already set, so
the subsequent invocation of free_irq() would trigger the above
warning call trace. To fix this issue, set the lineevent_state::irq
after the IRQ register successfully.

Fixes: 468242724143 ("gpiolib: cdev: refactor lineevent cleanup into lineevent_free")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/gpio/gpiolib-cdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ffa0256cad5a..937e7a8dd8a9 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1784,7 +1784,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		ret = -ENODEV;
 		goto out_free_le;
 	}
-	le->irq = irq;
 
 	if (eflags & GPIOEVENT_REQUEST_RISING_EDGE)
 		irqflags |= test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
@@ -1798,7 +1797,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	init_waitqueue_head(&le->wait);
 
 	/* Request a thread to read the events */
-	ret = request_threaded_irq(le->irq,
+	ret = request_threaded_irq(irq,
 				   lineevent_irq_handler,
 				   lineevent_irq_thread,
 				   irqflags,
@@ -1807,6 +1806,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_le;
 
+	le->irq = irq;
+
 	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
-- 
2.36.1

