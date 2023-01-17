Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7500366D444
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjAQCcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjAQCcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:32:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D624107;
        Mon, 16 Jan 2023 18:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5+fQtrF7gC6/+K4Qj68qGVPpeAG6xGW9ivbQlwGVR/nfBOksUdDLq10nTt9IH82sAD7swBvD4u27fNPffqKDE3sWj6kcaq/3GbplXZEKrVu35gh5W99LhgBrsGeHX+JawDi3CQQrGAdWgCh6xjOu+iS7+8vGbwUAFLilrsPaboVmonfaM5rf36kDZSV4xqsTMQs1OhvK84EnxiFUuA5gQfilIM6pXil9dwS8zpijWsvVv4C9XvWWFzUR0dbWmXRHgbdZt0LEi5+TWC9R/7yNDIEYhSubSuSVAyyHi5pOJ/LRWWKBb5Pe7I50DM4d7cA1ombMt2z996yz5jLpi567A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TssVzuDy/1cF+tAGcddRyhQgwX5T66VEzp9nT+80AtU=;
 b=Uot0jJxCMh3S/dPNZuc5vEwpGkkysD+3AoT0gWyrUvDIkQ+skkQO5XCX6P8drdXGyAk2ybvGk7O/zlk/j/AC7H/ho5HkPysYNed+nTrj83HeK0A/VkT/59KqRgi2V9EWYfVlQbz31Qx+G9W0M/IS1GLayz+d3q3k76inyviCfJeXLcNtUnMmFjt3SCEPIQn5haTHjBjQTmoRaH6EPgWMxXrVDsaWRQDB5uIA1qK2ji3OSoptofohNZPBRXCtHahs67HKL1XyfkBhFaA2HgPt2kFkv/g3pxnG8Ua7tnebtR8jyu3zu9ZKWoT6zi07bNn6RvvEqegDJltjEpil/jnrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TssVzuDy/1cF+tAGcddRyhQgwX5T66VEzp9nT+80AtU=;
 b=bkcOYJZv+TTi8s1nid6EOIDrh1LZdybRff6IFumvpo4IerLJALUcZAUob9CnLvORujeVIQwYguqOzxCcuHvq8Lr2Nl2cCgvNeLBsz8+hlRhpAHUTIX5YJFESl1+8qY11TcJUdejyQrUBnEfD6GRpy7OTzMO9GY6UV+ZfXgsScDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 02:32:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 02:32:12 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] media: amphion: decoder add support to RealVideo
Date:   Tue, 17 Jan 2023 10:31:53 +0800
Message-Id: <cover.1673922423.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 99090e76-8572-402a-0949-08daf8330a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8q58CyUmhtZg5ufR3Glmpg/4SQ2808cgMs83ZeD9gaZjyNnV/U3Z4O7ca8GMfg94AKMRe35wUmG1UEE7OgL1WCd0zlPL0408PoD6GdxUpm/ikXzvNVKx+xvuqSucHWLqh88PQQSgYubjNg02FJXbYugh0pgttkRUSNV0Y/q5Yjc6CBuToF7vQH/LsYLKbdczLj6oPtN7Py4xxYbk3/YQCcGIUzQ7sVEY59GbEJWlafq+oMICvIFTjd/7VhuPeD50HvKCHuHmHK1oeX+pME67KicVCN1pahqLn04Uglmg7TxXxrahhBqpvgRAS3i6JoEnU0yQc9toishIb34MC+XZVfZdKrJSVdz4KEBWieSrIo0ldc+K4mRdskPbQlc7vLCCufN2sH3l1aMXc52mYh8TsdeQsKj5dx3j4afAXHgu5ibEdxU/noCfrc4ncVo+/fx048qrnzIIyc6hRgqRBmw+/fFQA54iiXV4gNe5ldLAVMf6Q95IcDjfNzZB6HlQbiDDiBnUPNSFSb1o+f4fLb/+p9pB6iyZTFPXYdwm2jX8BlZpIE1NH9fvRwSUIwxGHLfvjB1AqvSP6OA/8T+h+ODXg6D+EKCP0Z5tZMxjdF4ihz2zzFb/FcLs2BqMC+XiYc46iLic6TXG9FnWXrqNbR1NjlJWQW1UDUPVnsR/bY5d1PtfOzOdIdYQfuGZQ5atELFNXc9hm/4qrKPzpl0h9lXKLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(86362001)(66556008)(41300700001)(2616005)(66476007)(66946007)(6512007)(186003)(26005)(8676002)(4326008)(36756003)(5660300002)(38350700002)(8936002)(6666004)(478600001)(52116002)(6506007)(316002)(4744005)(7416002)(2906002)(38100700002)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBpqkW4eIKgXd41s/Tg1NH7Ab7EWzil8g9M94RXRMUB3fQ3jIpd7ZFBcyQA9?=
 =?us-ascii?Q?rcCDgSNRM2uI+c31XnqrBA8RnIRcq6/XvCrlfo5S9X4bI2C5BWhPKXkoj7+t?=
 =?us-ascii?Q?xdRqlmbvJNGGTtwIhfdMHLZcj0q4dwOImvSKu9p/AVuhLUDKCpL5gjghPbOv?=
 =?us-ascii?Q?4CXNyZ7WTsIRyLIarb/nADRZF16jDbwhOWws1CQ1S7laUilU9jLUz/XMim6V?=
 =?us-ascii?Q?4cc5pqOazlSCjK4AOJ6gCF6tG5mkdwJfHCcMAcDqokJZmHkAlLmEfgsPQTPw?=
 =?us-ascii?Q?ZCGOmO4R4I671rLBmocVJw5oIlbChckcOUGcKUMNQSKWrJx20A6myzEyq9bb?=
 =?us-ascii?Q?8unE/etUjPqeaBxwMepb+aZu4mmllagYOI6dZBPsNCvZBqze5grodxdHj6iu?=
 =?us-ascii?Q?tC3b4A8nFVq+Oc4sbXgcKGY5rePZSo+6r/wvG+KcYLeJvRxheDsFkmzFzUaw?=
 =?us-ascii?Q?7Uwu/6qDdB0pQLmuC9AzVyEANckAR2R4pyY9IwnHUEaAiMoed9QlkhlQwOze?=
 =?us-ascii?Q?uHH+d+14XIglRm4wzH78GwPNyXhp4inDqaIFreKEPfy1XJ3iRQBdT7a2MMpY?=
 =?us-ascii?Q?7FfFaNKcsSYictKlqOGn2HBC190wW2K0e1LuyvSP1w93rWWX5XevjsnFGubM?=
 =?us-ascii?Q?ncg1NvayN+TRq6OSqeov+Pm2eC3K9ZsIzkkYtmfZp1Xhos0g+m6CgQihXcPF?=
 =?us-ascii?Q?1Xaq6CEcfYUJDGpo5cqp1L59jx1eC6bjQK8ihBxViT/8HSUsBBR4SfHdoNrY?=
 =?us-ascii?Q?5tvhyC4mylnO7TwFNbcFK5ySD63NRdZiUEEpZ7rx9/MSlq4jwoqessw0C3iu?=
 =?us-ascii?Q?endEzZE9E2hZRAIWII/t4NnU+w2kvwltOFN5fOM5hAloNi3ZgXA9L8SIMTHI?=
 =?us-ascii?Q?Cp0Axkp9HtQJ7XMYms+llw/iW6oyz7+is8JnK0V0XjZlHhlEUbsqwI/8QExT?=
 =?us-ascii?Q?RvqdlG1+hfqviuGkqJ7J40unIXOxdJUuREHloj7vdKaxaQcrTgobd0NWRXB5?=
 =?us-ascii?Q?mi69FXNlMQ2glbazxAU9x2Kc2c3pIq/7FGaFR77YRrRtdKEwtW6rGOq88omR?=
 =?us-ascii?Q?yt/kEz0r/AAh5y8uyOjWjvBQ1nVSGm1yP7783TceSkVWBNb7ngnnhUY7KdVE?=
 =?us-ascii?Q?vKCum0YxS4VtZDu7oqxh2+CwrUX30PRKSlN8YHcQiLmzLjjG26zzAdvWI8LU?=
 =?us-ascii?Q?DDKq2sfYfp3xQbRSA+qHg2S2YI/SgcDzclXJNEhTClk3WwGbyZr5rJbEXWdU?=
 =?us-ascii?Q?uBZprCKO9dm+oHyD7uGU3Uo2cMsZhEZW2ea2LZdAW02W38hB2cM+0G45fsH7?=
 =?us-ascii?Q?qkLGEjXT6Gk7dQ0PThIighzJwhnYDDMnPWMxScyzuXyF+3HRAMtd9+3qCa32?=
 =?us-ascii?Q?oU9MQ9xDpLSqwtZ7vAPURG/utDdtLfbOeBiR+DgZ0roNcQWx/CoTW9WNkWCv?=
 =?us-ascii?Q?r+2HGXoyuZuCDKriKFHqh698FtBqH2HToxVeWYkv3ml6g9bFNGlBzXvbCkzi?=
 =?us-ascii?Q?erCmkkax4BHuL84zoowVZlQiKJ/QHV+72sDKA6Teko3jZwQStbrKLVUPSnB0?=
 =?us-ascii?Q?jgb5wsjKiofYIJVbxrZAnBtrd90PfrDr/sIbgs9f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99090e76-8572-402a-0949-08daf8330a47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 02:32:12.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3HlN05bicSFwPd34kOo7nItxuWxR/PPQauudJQsP2RRnlwSFSZGoxGwkz4G/SNasP2sAfyR2kqF/GAH7SflSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RealVideo, or also spelled as Real Video, is a suite of proprietary
video compression formats developed by RealNetworks -
the specific format changes with the version.
RealVideo codecs are identified by four-character codes.
RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.

amphion decoder can support decoding RV30 and RV40 streams.

v4
- fix typo and improve style

v3
- define respective formats for RV30 and RV40

v2
- correct the format name from RealMedia to RealVideo

Ming Qian (2):
  media: add RealVideo format RV30 and RV40
  media: amphion: support to decode RealVideo video

 .../media/v4l/pixfmt-compressed.rst           | 20 ++++++++++++++++
 drivers/media/platform/amphion/vdec.c         | 14 +++++++++++
 drivers/media/platform/amphion/vpu_malone.c   | 23 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 6 files changed, 62 insertions(+)

-- 
2.38.1

