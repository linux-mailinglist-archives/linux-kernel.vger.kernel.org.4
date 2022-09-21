Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8958E5BF377
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIUCaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUCaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:30:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928B3CBD5;
        Tue, 20 Sep 2022 19:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ielQesN5Uk3P2hcKbf+17hzs4aTVCzr8olzRgtpL4yFX2pLQ8C0+YPxAdNiM8FAtbJ1PUAD84RfBYem+naTa/RWSLQN+1SXJHURCZVMYLU9IINXrJ3x+Qew8MxsUyHxJZP8vZeeGbvNLM8BJ2+NwLHa6ZBC9ieBKvplVWKP9E/vI+HNr2WaIJoxIq+hmi5N3zoFz4sPGL9DPv+xZ7tm+CjBDSyWUkG13JW506xuARLSlcyNRGnhapgORgdw0YZg+SfNg6nqX7n1ghXJ5k18pNTuWL+WLyhnLARMosUokR5sCDSDl//pTVDpSV0zQxgtV2qkrEop/B5oXRDeAO76Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3vJr/pmEIPv2SSS0wWiexjJNAl2rugnxGKtfa6rujQ=;
 b=VIxd9M0/5m/kxkIjlzYxqSMf/2e5FBA2zn1+PJJ2FE8UCP6JQcthyBF953ZLaG74jW2FgFr7gVQZAjIiTBXZChgj58orjoxkNxLaYxF6wExl4e07IS2HW072307oGGEPbgZdW748J3UPn9KiK+Zw+I3e8ifGRKj2YH1PvFI3qq2cQrlB3MObhO+b2TVx0CIZ3nN4dwVz+leA8Xp9gwhDTkjTLbX98K35Nyd1cZ1DLjVRrv9JEymGvMwnlKdscTlD7jjQvTTFfZ/NiJ3ExndX8rKKv662ev+mHmf3D8R+HdfCg4ZDLxpTUBgz2uGe4ePuqzUNRib/rTlWB6kfVX2RTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3vJr/pmEIPv2SSS0wWiexjJNAl2rugnxGKtfa6rujQ=;
 b=M3DhP4SUqsCZqZi1K5t6CnVRYta6QTM9wGyX7AKzIPikPxH5imD54YPyYkRPAlpDfHdUMJM+yxFH+6WI9DWCqAzyEkqADpT2Vh4zbRllKlzGbEif5D6L1XcSUO43Vnoy7pAxDGelIdovND2tPmilXVQLB3zMPQiyvGKxwj9wDos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:30:09 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53%5]) with mapi id 15.20.5632.024; Wed, 21 Sep 2022
 02:30:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] media: imx-jpeg, Add support for contiguous NV12
Date:   Wed, 21 Sep 2022 10:29:17 +0800
Message-Id: <cover.1663726876.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ba994c-4b9a-4147-49ad-08da9b793397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOPUgfCCn2zNZ3IoPb20YIEeJysDVDSpwlMNIwmWYAEKnC51+/0HkeZJKC52NgvLhFKtFb1bEqL1N1EgRmCaAw8yfRiGU0nG8A0IJpVeatgQNyE8yDygAaRPrhgj+tTJRCb0auXbZpK12VPlMD1hp32FuXhNMcZuYRAi2KC3AgCk4SgXJRM+YJNPSYGhwjG2UCZ9Zv0V/QQABULtL7ZZ1dx4kSkj9zDC2QEPEzai/WbkwS0cywmhsV+sEHQfN7bnE3AwW8svtKmjx/8imFQtKGYpfQGSBt0N+XYxLGd8x46RafAiAGCVRi0XBkXQTZffWFE5F0SwVDe2acI5ieJxrfK6HcR0qy5pC02nvlKhHeSCMMIkWCVLUjfIwp2C3/5JF7vW9zMtjjySQTc/8inPAmgwOlsffz2FTIB+Lt1RlopCkLJWKC7u4WESrdCmixpNgLdJRkKjGvc0CEgXxyXfZ7aEgNR00McD0dA38MjNf630dhGYYVthPBlli75xm8971IrwFZstNvmhbtVl+a0b8NG7qlYFCd1qXNF8KenKY5+ouYcQivl6BKmDw7CqCecQSd9mHfqBaYAw3DMi/5c1S0jaqTi2ZcPLtuZy5Ba9fSZnR8XKVCB9/ZQxlyMJLRGK24l7CrmsRYALh/Tvjl1j2MXYYldd67w/KJglYec0LDRFrpvksOgaGur8UTsqIyLuylkD5HRAWFb7fgUBXo8F4N76qL/epMBOBDEMIefrbpY+p4BAMro+/2bOzfrZAtIwp+L4QLd/s6Eus78O8MOn8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(6512007)(52116002)(26005)(66476007)(66946007)(316002)(86362001)(36756003)(66556008)(8676002)(5660300002)(4326008)(4744005)(44832011)(186003)(7416002)(8936002)(478600001)(38350700002)(6666004)(6486002)(38100700002)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvDR1GHA9GogrqYbV4EucV9snewpqit0mhSGFmjpXRn7D6JPFVyU3/EmcZN+?=
 =?us-ascii?Q?GlDnh55hUX3l4nPTIIeb8hGlVhaoct50qtzy+oDS+awxU6FNss921ENFxQOn?=
 =?us-ascii?Q?7Qa6PbCTjRmiuxA7eoyZwdHcfoSKf1qF9LzdcR313hmyGJ8ltdAx3bSZkgX5?=
 =?us-ascii?Q?KZWGdY/oubo7DU6/zQEljea6B+EA/uNhPPzmFI34Xsa/LX1pUcueE80Vt1CS?=
 =?us-ascii?Q?0x+Q93PhcIrEpeiRe3ZTNNtPd+THMjCCU1IeiL1CdWhdMVF5TEZBqdLNuePH?=
 =?us-ascii?Q?4dQEP8Qd8Lfwwh8DwbmyoZbuVw0pUBSgUEP9vzTkfS6ka4Tzd8q4NLqt+SW3?=
 =?us-ascii?Q?YOdSjD1ZwL9n8Au4co8KlEqBX6LOqXNDad7inEftD768IgYjNvyhjOdbefkH?=
 =?us-ascii?Q?pwSKx7/gvlaFA9e49sHkoLUIV+hmNt+CCdxtEwryTii+YDJfOpjIURav9gy3?=
 =?us-ascii?Q?UFxn7fahevlsoMup//LGFqsk6xnJVMFzg0h2gHkJVbk5F+Or+qZRa+WmCsEx?=
 =?us-ascii?Q?tyUxmacK5KcQd0cmwWayINq9ARo/gtPKqzirzEFsIkMbMGCnmLfdm5cIzmji?=
 =?us-ascii?Q?vCoP9km8HnLqhUdy+GMgg3V7oOg7zL2mmNXycrDMiJD8eNxUvFzCx/VTn0/A?=
 =?us-ascii?Q?hEMclM0SEOybRY1SF+AQ8wCOeG5ExVQvP0vcJlQQYll4OMiNOqKeCVVLZKdG?=
 =?us-ascii?Q?OU0yo0zqeYYUo3TwSTXNAxuZc4siNvU0tneU+S59Q6XL48+PNy2VN3B9+SKR?=
 =?us-ascii?Q?Hp5BmG2La5XA/dLotL32b+89LPOdObGk3AGATKFbkLbwYq4nyEmiVykiol/o?=
 =?us-ascii?Q?99In8Y6cWPrYHXz17UtVOPBmE8mSKk/KssIk/RSF1wQF9yWOl8c4fS2WZTWD?=
 =?us-ascii?Q?3WDZ01Wfqe0jJ8qFKEkAweLc7hdTFrl28IujiDAu2J9NVUzfYTxvoB7gB4DE?=
 =?us-ascii?Q?CcGxs6aYZzdeDVtJJwraVTo0xuF+krmmb95eAL78MSBP4BVFz/Xydb6Feo20?=
 =?us-ascii?Q?cMWK86VfcaqKhoAqwJ9u/pDWTf9P172CuhmTISO8oX6UlQXYLzQZR9kqbfgq?=
 =?us-ascii?Q?84cPUGX9gwOwADb2oEFJremys2+HSOUnQJ/OBtyimRzYbTcYekIeg3dJx4CM?=
 =?us-ascii?Q?yUz/FznwE1R4ZdxH082kTnymREEaZI7jQfhw49ZwXZK3dGi9bWHRWgvdaqF6?=
 =?us-ascii?Q?TRaFJGKDkCgIgOJQ6fe+GPM/eyJ6AsSOnnbMyVySXM2c8vSSzP9FABbC5Y8Q?=
 =?us-ascii?Q?oFMJSC82/k++uq/Ws0viLIeQlrpORtWjbxBsuqcTYXkYOjP4IXIhoJN9tWeV?=
 =?us-ascii?Q?+VRu3jT7/OlRjwgrp8g5AuR8lTbYeiiBzW8Ky7oDQL/qzZrwey/6+ap3U9RV?=
 =?us-ascii?Q?gNsG8YrLpR7fiwmCn15eFurUrwg+C29FnIBggESv+X6CCXtVT+9zC/CTDDoL?=
 =?us-ascii?Q?qauGOeGwktwrwYmHBeb0j25wIxoiyrSX8KZshVY51MP2XuwjXJPJHmnZTaY8?=
 =?us-ascii?Q?uYD3UsC64yfuK4ICSO7RCyPS55iVb+GLBXflZY6oTZn/OywjHyTcwzU2GoRR?=
 =?us-ascii?Q?OD77R6ma1QPyxjraXoukWuPzTd0Y8tn22qnXRQLg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ba994c-4b9a-4147-49ad-08da9b793397
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 02:30:08.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85IQICm7WnVUG9LwRJ3TFoPtk/8SzI3pEaothACseOe8YWUfTd1mP5JEyggC0RY3APo/hSaWCNSJFmCPqCyffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxc-jpeg supports non contiguous format nv12m,
and in order to compatible with the devices
who only supports contiguous format nv12,
jpeg can support nv12 and nv12m in the same time.

And client needs to calculate plane size for format NV12.
driver needs to report the aligned resolution,
otherwise they can't the correct uv address.
So driver needs to implement g_selection to report
the actual picture size.

v2
- correct the target V4L2_SEL_TGT_COMPOSE_PADDED of decoder
- add Fixes tag

Ming Qian (2):
  media: imx-jpeg: Implement g_selection and s_selection
  media: imx-jpeg: Support contiguous and non contiguous format

 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 545 ++++++++++++------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   8 +-
 2 files changed, 389 insertions(+), 164 deletions(-)

-- 
2.37.1

