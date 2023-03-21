Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE536C3C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCUVFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCUVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:05:48 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88457D2A;
        Tue, 21 Mar 2023 14:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCJy9smisJkxPHR1NEoSdPHKj2d9kWQ+E/tGlI1NNMzMs3icnLkhb8takRfWHuIxkrb00Dseq0Ka7dOlul89/4/nEA6tVptuTMIMgOpnKE6oLdC34KY+fiCbsHLV0HXIJHUzmKn28Yd8efVXlUMfTzu1FgsU7syna3LAvhDQ9b/kn1hNSquMsRcjpSblVTQ/os0xUPqHR8fq3YayvZmifcORgyH6XCc5uSPT8P4jasnfDrCd8b9E2Stjv9rq/xLMcUYiP+vpstacWD4zEafEOE1/JW5N0mqw2lQ1WC2Z0mWoAcJ1TxEFfpi2VeQzxRd4Rr/H84WjtYL73gTnOowdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfIMH94uN9Yr+x0ZqWlvL4rgxXRC9kwoBBw0cYLyNPs=;
 b=ccwzsOaselWp0h6cto3+/yeGiJaGydfkZhv+i6vbxeWon0GCWAtyctK/oFSb7Ruv/E2kSNEHIaE+XE6Pb7y4Zvq6zwt7SCHW8sZwFEG0dae2+gXNkPAM7ZqPM7uE7mNSo2S+Z+ZTMDwjzDXMiz87JhOIqD+HZ7h0tKDbiKtPYdb3+Wd2YsmbHQf1NFODpdS1E1D2nTS5qVaVQZh1ykGECsmM2vBdgH5PZpuDeTd9ksUSE/TJHmaKUAdq/qq1T4y/UB3r4/mReC7bix9vgSLp8KtDH5M+K2vW3AVcC2z2zwLgegSWFlh0aIqMQDX+EJGEKEOxYksNUvonE5Aaxw3AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfIMH94uN9Yr+x0ZqWlvL4rgxXRC9kwoBBw0cYLyNPs=;
 b=srBtuZBr1jY4eUEaGg1YIxLiUl++6C2/kryJA0CmCZolW0XOZnYVEx7RdysppKiH90zP+cW6O4BBmUSmnWfoGJQyajvM9x7RNkirmYN9YD7uINipJRg89F7OAQayME9oa+KLMfibWxthyaR6ny9Y7nd3FZcxiNGZ6KlS6exP9t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 21:05:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 21:05:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] usb: cdns3: fix super speed mass storage gadget device failure at imx8qm
Date:   Tue, 21 Mar 2023 17:05:21 -0400
Message-Id: <20230321210521.2806486-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 919b5af9-94d2-46f7-65f2-08db2a5007c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmMQI6nuDuEzdki+86rbaflg6DeKYsyiSKZj94rBGyqxqYP1QKSy6t38jE+yO1tAZFATmjKl9J8YcNH9mKI54Q1Aaj0dm/2Fyjxqa9Jb9rfnCUdq0J/dCJN75JpAfPIxT6iy3HX0MpeHXcjVOWT1c8dT8+yBcFO5NLqV7vUrtVm2i8h7aikUpN9Yv0EqW+jcGpFtmU0s3oebUDOZ3tLkRYlr0ocwO1da3pUAlWrXeHquNEVCZlsvYD/Ja2OfH0TCzEpGT2VKHJioMXd9Qn6RNiUCXy8lrfGkpXmlxgEwj8cyrdbysA6URoMU//PY91lR9iYwh+RWbuWkZcUmAHU9e3qaMwyxfyeLbXQGuxtaXoSuOpEM5MCf0CPSpiecwynU17u1nD83CXkGAYxAfvQZHfRMIngEoTLpkJcg6VUBFi6HhN59i/GNzUSP4o8usCRswj41Zu3LW3L2IrURCN/nFzXHUVn9Dl52Qe0KbgaNJsDC6YswMsxKVLoFImZ4H424DZ+Z+BBxCjaSEvw34VSyQ132dPUuUooIMOD8JZtoqf/IEVc9FmUKEyJEGJ9+joQjMERQZCTKfuYbFUtNymO/eYNZC8clx+wJe8rOKMfBin0QnNKi3mKoMsCL6ZH2AGkQw/Uuv8RsR8VrIvELaKQ6nbxEenbABT1KRL9MTE5nBLT79Nr92kIYzE0tn8/9Qe3wjpYyAMd/VH00Zr6FEgBDe2KWthPeC/oEoZfaVOkjM6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(6486002)(41300700001)(66556008)(66476007)(110136005)(478600001)(66946007)(5660300002)(316002)(8936002)(8676002)(4326008)(36756003)(86362001)(52116002)(6512007)(6506007)(1076003)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jhIuWoQCzCTcKfJOPRbyzbTNPxIKFRgwUCeflW16jdfGoVV2dzp1B6AHKrt?=
 =?us-ascii?Q?qKvqCfAKrwRW39CGWdIeVkalTqhy/VXuz9B6JRyjX/XkU6Xy2ybbs6La55CD?=
 =?us-ascii?Q?u5ciEByQHxD9GGUR1/XSq4SdAzfp1RDq+UjIfbqCsaHpfu6+EWfeUccbjSyN?=
 =?us-ascii?Q?2ToIgT8p/X4mcYeFAfGoJZZ4ir79pFvXmkBbnKRyot4GYYHZFaHhVpK1y6IL?=
 =?us-ascii?Q?FogolmSPHzLg9ysUUxv6pXmucQQ/Xw+/xuOK12sIgd+DaDEE2onN7ujNjjOk?=
 =?us-ascii?Q?XQSISc1wcIluiVIplNxCWV3D2J1m60hVNwIUraO1jl9GdwDY2JHYcjLwD15j?=
 =?us-ascii?Q?a6NIqu4ZI1+4X8FjD/gEZg6d09nIS0f/KyLSTvCppRFPTIWhqdTcgXW3g/TW?=
 =?us-ascii?Q?zGaSjOrRi7rXB3mQyo+cAT2nuMnmbRoLpNcgsaqTlyQ98QAsAXovcH4fJnMY?=
 =?us-ascii?Q?FLEQPulldX5Bkfs2eim4ou2JaEOl9VWKTXKQljKci+EBd9ED1ffl96VAXt0S?=
 =?us-ascii?Q?Dp0LzAtwjIl8/f3dD/W6WYzyoxqJzdq/9ONqGqgR8RV/qgf+qgQdj3vWmGBx?=
 =?us-ascii?Q?rYH4NlMV+XvGBIAqUfEIf+3JXUdSike4ZuP2mcHpghe+YxmnxTeJMHg1WyU4?=
 =?us-ascii?Q?vX4Yy+13EaQsD+6r3zrgwAK/V0WovaZbRmmuTD2n1T8KvF9XTqDhY3UKuB9d?=
 =?us-ascii?Q?ZN+Hzx9O2sQewplE35+JSUj4qh8z3cZg+uxwJg3+wbZ2surnayJhDa+DbpGR?=
 =?us-ascii?Q?+jwCq4DgNdw4AvKlNF8zSQzmHI/PdhRZ+8P+dzHPgGZTpUKErdIE/0or/YMD?=
 =?us-ascii?Q?n2hw/xfvhELpYnQNOYt1oPyiP+zuzEsYjjTupkHNMpzzf8AsxI5/qGzpS+Y4?=
 =?us-ascii?Q?VGTKff3G4tqZBmq2KoBvRhSbWoxPgNdNbmoVn846xjg3Q5LmMaM9eaflyZ1x?=
 =?us-ascii?Q?85JhG6nEBbtfD6q/J/rQ2XGXx3cN+uxoDGbeN1smpPFbRWkhEOGA/B0P8e17?=
 =?us-ascii?Q?pV+Zi0CUNOObP8k9nRfpC/5i9PrGec3zSIKcwLSk7ZwkqrpZ8Bt9Q6Dm9zKI?=
 =?us-ascii?Q?0OIzR16aiIotIp6lMHavlCOMXBqTp5SlC1PrsLOfoI6cU/BLbLmigfzR+7YE?=
 =?us-ascii?Q?o7Bdro+6fCVAtW5a5IYfQ7krIvw81uAHUNQuN/JGAU005acTiinlqVWx9msL?=
 =?us-ascii?Q?6ANGUPqSSDZQUc3Nvoa0ASmrnS1VfiEFfUtsYQA7wsmhrqvSPQa6N4J+/0DE?=
 =?us-ascii?Q?/6MaOkaJcIGmKnOXAPaRQAgfRJjQdQ2SYKdA/JUDn9K1jMTdAFgwzTgQVHVY?=
 =?us-ascii?Q?5uf5cX9RfEum2x2kBScHK199gEO5wk/Aj+6roXVCIH+0UOAVilv9FTl5ChUb?=
 =?us-ascii?Q?IOOm41+X6wn7bpmIZajEPncdlfuxY4bbuy7D5ST/ASCIBIQ0gbpy73LE1rww?=
 =?us-ascii?Q?JtaWQ85e2O2O/LF0XoeuuRVkj8B5/MyDnxkgNvbx/HG8GzdMMS2aVQLfMiHE?=
 =?us-ascii?Q?drFj0fO4x8zrzM+e554cL7KuPa0XsVPyeWk4+9EeNg6Rhj7unAfMY2elI0sF?=
 =?us-ascii?Q?YzNjIeSlVjRuJLOfTrM0odUHzbxJBxeqIzmmtWrP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919b5af9-94d2-46f7-65f2-08db2a5007c9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:05:42.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k4U/JDJn1MYS4I7mInQsK/xNjxK0LsepiHgZZsKR/9ZFNvUfDeeWKDHTpYxbMddm23lryLWzfFI0syQpDijZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mass storage gadget has one IN and one OUT endpoint. The below (Fixes)
commit aimed to utilize all hardware FIFO to support composited gadget
devices. This resulted in an ep_buf_size of 15 when a single gadget was
enabled, such as the mass storage gadget.

However, it was found that there are unknown limitations on the imx8qm and
imx8qxp B0 platforms. The device would fail to work if ep_buf_size
exceeded 9.

To resolve this issue, this patch reverts to the old settings used before
the below commit for the imx8qm and imx8qxp B0 platforms.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

I hope cdns engineer, such as pawell@cadence.com help identfy the root cause.
Look like old version ip use more memory then what ep_cfg show.

 drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5adcb349718c..497c8e87dabf 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3005,6 +3005,17 @@ static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
 			(priv_dev->onchip_buffers - 2) / (n_in + 1);
 
+	/*
+	 * There are unknown hardware limition: when work at super speed mode,
+	 * ep_buffer_size can't bigger than 9 for one IN and OUT case at i.MX8QM
+	 * and i.MX8QXP B0, which report there are 32k memory.
+	 * Rollback to original settings for the these chipes.
+	 */
+	if (priv_dev->dev_ver < DEV_VER_V2) {
+		priv_dev->ep_buf_size = min_t(u8, priv_dev->ep_buf_size, 4);
+		priv_dev->ep_iso_burst = min_t(u8, priv_dev->ep_iso_burst, 3);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

