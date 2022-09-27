Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488005EB879
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiI0DQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiI0DPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:15:44 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D680517;
        Mon, 26 Sep 2022 20:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvEx5aMV0fBUZsKWcKorpsdSpslqJJovKyYEW/E/9cldscelbAb2pua0QDTC4+W483ioGH8sx6MtqtpoZeRJT7MPYitq1sMRZB+tAaR1Y307QKaE2iZa8jiZbAiZre5GRLT2g8Jy3ScPoFzE3dFxumR+mymmeYS++/A2g8+V1SsGqS6g0CXkFdtUoJhQTzFDo2SXKpO4c+gQ7k1QPpbVOHa0nQn3Wj1Y6Qart41p2vSk8MRMGoLaV6xDK6hjC3hH0/1dBgrnt/U/Gf/3mFzpmwXcXL91J03e+bKZctvIeYirj0mybdz5se/NzVYKibMIOXzq62/IDuEB8UOaD9uxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFemOgbH07rGETI1rxecZ2Vqjd4v/8YG1LomU2tjtRM=;
 b=JxFM3DrWgJrvrV5IR1CRltrJpkF2I8VSWcLVdTjweLr7O9fqopaE82ZbXYDeDjynLVnsHYBrBG/mK2k9tMuMER3eSBbv2OSwnFAkjUloMFPdM2rOGd/anzD8JcXDqLZdjd3ZBvfVSh2ixVr22lPp8BrcED/yNwlbjaljjUDDRqWxhI216W+ZZGmn/lKrvARSvxsPG8s/HMN4DaffsP8pZZ5ehmoOz/lEiSrhK3ZBYp6top0EyF3g5qMyYrQSxHTA5tiix+woRYjoqP0msk1zZ4aeCjtZAv5LDXm1UlYZhOatyP+0n2+OEPQw9RzLuj1yXEuUyCYEGlHBe55B+8m/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFemOgbH07rGETI1rxecZ2Vqjd4v/8YG1LomU2tjtRM=;
 b=Quj6NO8Yym2EgD0bAqZO6zT08F2TZklrfC4TPWVE9r82fSnSgnU3vgFNO/rofMl3Uoixn8PBiCbkKBu8FsM3tsz0q+pikrxy8RH93ipulHZ17hYtOSxAmeHIC4O74mnGskzHGG4IwyPbisd21RF6Z0HtIs+DYrmOVpjJDCaDAzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 03:13:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 03:13:41 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] media: imx-jpeg, Add support for contiguous NV12
Date:   Tue, 27 Sep 2022 11:12:15 +0800
Message-Id: <cover.1664247957.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: beacf73b-1f7b-417a-1c4f-08daa0364708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvjkEo4znpdPqg6eUk3WQkKidO75IKw4olVpRmHVLgMUOvE+mOq8LV5/ZGgC8nltnht03lsk2dNnbeAcpRz8Dydg7CmX+b4rsoZxuDQHYxHvl1IlfjHD0d0bgt1QA3FskPh+VhXQCl653JVa2MDUx28tE04HqQuBBlTbQ1/KRoI5o2s/1SSFLKLnQfOb8TYvYfzp/7ud3+vCX+CWQs236QtmV2jqQTYSgnmNuBKKoxz/mSA6q2jDJyBjSMFkyumzcuaZ71vZtGXTAE6almmiLfLYhaohalMNfhz97yY/ELRYEJaMODLTco1vCfRbVNoWE3vRodeEC9NUvD17HX4Nc5mS3lRE5W7tu+sv7exb0rkpdhNz+cW4J7fmzb0qPb3x1lR6SZFVwP0sMf7kb8qRVxCwIIUxZOIbCHPo43RyxBIuvFqH2oFyrNc56KDPupAnSUI991AtUwv02b/MbSf+r5Z9P8IJsvonDvh94GqECQ99M7RcUuHmHe673Zsi8PhYoMtdB0JvooSotuLp6EcT8gLkVrPrbLu1aDZaZj1eg7sT38Xt7KEk2dGbg4xeehPXYt07NoCxe5Mec1eLXdr+Fe+9Q1jOWVAXeHUU8oKPeFbb9/eaiLMA+U97jVmuw1mEEH43lbXWKqquM9wIwMkTWo36hDWuVLS4FsKzFKte7WfnVcP1geIFeySCRD9Muhayv9BFIQLA1vZXiYZfODnRhbXdhx1gqtApFJAmAWn4h5lhhsvvE5ZCeBkGMcSS849FU5k5imV6dwwW4+Jglkr9cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(186003)(2616005)(83380400001)(38100700002)(38350700002)(86362001)(4744005)(44832011)(5660300002)(66476007)(66556008)(66946007)(8936002)(41300700001)(2906002)(7416002)(6666004)(478600001)(6506007)(8676002)(26005)(52116002)(4326008)(316002)(6512007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIjixmkSr0aEIHURFGo2ijNS+QibDvs0kjs8qkHXw82gwmcczqNWR13RNaiW?=
 =?us-ascii?Q?RhYWkdHy1D9l4ZuiGTiEjOeg+ve5pLOebVksN1Dvtw/3ymN1qRseI7/ZP5WN?=
 =?us-ascii?Q?4CJnZjAQ1AdOomB1DaTU6LrfCIua0xzTZ0N+IGH5bEJH3QHFwTCRZNuSxudv?=
 =?us-ascii?Q?MHCGvTm3/jURbdzHNRAwpQD2W2nlC4qyqvr9YWaSfhJWDP8C31Mob7oOKgKl?=
 =?us-ascii?Q?FWKt8YrmR5HkMGPv5DagzcOLHQpBvtpxCJZEqCiN/BKjV0fUk3wCqjXaSg+r?=
 =?us-ascii?Q?kYlyTLUT8xjLc9vfJeuqsbaJ41AaqFiWBX7kwmyoTasnq/BEn2byw+dVqUd4?=
 =?us-ascii?Q?4VRRWdeoToc/h5W4k073KykDypTqsxy2VKYCOILgfOhnGQ1JaEu2Kr3trJrR?=
 =?us-ascii?Q?pAzpZNZFISp12nCHfee8uqycLu1NQVM+Fuiw6drKYeNPsWA/tt2N+XqfgsT8?=
 =?us-ascii?Q?inSGFlRoRk/ldFlQwyebHDBwpb6gWN4Q+9Prn8CSgA2t1w0Y648mHNb68bUW?=
 =?us-ascii?Q?JWQwHKv+4jmw4eMIvlABw0ANHSjIC9gsPk7skL2Cz/JLYu5Cg1NxAufaD0CE?=
 =?us-ascii?Q?Ao3Q4pOU6ct0JHqePcDDC6JXGq6F6iqJ1Y8ZcJk7NWvVVK8Y4454F9EVyxLH?=
 =?us-ascii?Q?uPYVg3mnxRDpMcP3p2e2Vpk08IIjU9IL8GHw8Il4FiGdehHxA0tFB9z8Md3E?=
 =?us-ascii?Q?dkH4O1l8GLk1bKExBc/oLMuzQHJvvMdwO3k7/jZibl+SgDeNRGUB3AVkL2EE?=
 =?us-ascii?Q?vMl/H410bZ3dQfnyF9sCMQOnhfrOZ+JrFadPMg9ppmigLMRSYGl8GfzUOt0b?=
 =?us-ascii?Q?kvVKMxSSk8+5E1z2vRWyanTaU7TZMKLlsBJYtfxMDKQV6KD066TmFkTlGB4g?=
 =?us-ascii?Q?qXu5zpTOmN8dQ1zXOzGwtYiltvGPiKVB7RRLjH6rVM6sgk7qnBWC4TX07Rfk?=
 =?us-ascii?Q?l3L6YhA+8Yr7Z2n3uYFt0UXq51bS2E1eiDa9QpYsTD0ssmeOusfM8pdH7TvE?=
 =?us-ascii?Q?+D8eZdaUp3kJAWXnmgzGt1hH3iz/IHr518GE7P+COdk7JU/4bHM8FPBw3N1f?=
 =?us-ascii?Q?zBevxcd2I90Df0G6G2OuDDMYtJkvF+mckl/Kxb5GNrmyddsEQOLV5njtRZXe?=
 =?us-ascii?Q?H9IbThgWmRnFgZsqP5mzC2gzwNyexcTuJH1fW03CgyJX6vNUZQKxFrE4Nan7?=
 =?us-ascii?Q?j3guEFQWNyEa1mwXWv7puVkMw3384prKmdhsmDxV+iYFmB60br1HW58aKput?=
 =?us-ascii?Q?+HyluVdGsqa8LD2CefYW4Rj3Pg4E8tKSZQWpSbP6MqBIp0rfQ0gfijfuiaiW?=
 =?us-ascii?Q?Xzr+V0SMpZbUEXpjcmCkmrDHASMWryNb1KWvQ7Fvitu8XQbrXCVdM0Qj+n5A?=
 =?us-ascii?Q?qzoawjoJJ/sAsY0cw3ZCxxUw9YhAJXfEz6Xsn0LaLamUxTkyBNg+nJDO4xeO?=
 =?us-ascii?Q?FHFiwRgz5dVmRJ6mbyqUvE8GrGSL2pqWQVrVPUzmyxqlsLfRSpjSmV3+gt38?=
 =?us-ascii?Q?n3575MJeeygk3MKSewY4e7n2Wo2QBLRVizsONyMCWF3be4DlkH23Xvpu2BcD?=
 =?us-ascii?Q?/XbzbS50ROg1vXss/41pkEQDzlPVFdOl+7yuAB33?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beacf73b-1f7b-417a-1c4f-08daa0364708
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 03:13:40.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pNnfb0DVgxbaPrqfBf1MM7JHICEmV81dtNz3zc0b8/tNZ5RJnTmA+W1aVU0PhoWCnL71qefPNcAcougEyXmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811
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

v3
- correct the strm_bufsize of encoder

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

