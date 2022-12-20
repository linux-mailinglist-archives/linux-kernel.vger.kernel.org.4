Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3E651C71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiLTIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:39:49 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833D1A1;
        Tue, 20 Dec 2022 00:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqjEq25d8jNkGEhcl+umCvFsyZ4EuwnApppAueeZLCEoFAEL06as9Cn4YZAEQNFJEZ2Y9o+BLCQHy4ssif70VJSwa87FiQUIR6bRn6ci6X49HbOUClQoJPBme/+eIVrp4a3SGpYju6DdWfem38cVt42XRiYw+QEHHaw26eHXbWd3c+Smj6a/mSPaJ/PrxxGCVb+QcEv8/evilDytrDGFrSFi2V7jXMRkQIGnAdhxkNmd6EdxYR9fIaV6HFKj4bwcpmknvDQB7FHysgQq7MO48T3x0ZmdPUu89amm/zsYbu0ToRjNTRhoqhWeOwGdgexYIsv/Qywyh6vKztgiYSQ8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fDr8Y1q/g27Sw4wXkFU2GzdqXQmFIhwcmywSd4Gqrw=;
 b=nYZj6v2/dmLIB2X8LGRPDDCUQEz9nKvbZj9nCxqKgEWVoWB0QuKDHbPmOVjGS1HlAy406bY351iSguCrp41uq9fAiAu3PBPxovbmMTDY3lLynhkjdMveqqUcFnpoB/niiii49YncY9UVGqDK7OTIARBrHrRmyoTtfPj4sDIOwEY351lhQLtbijt4DkT+vPeBd96vvOtit8vnkWT6RZaBi3N/+ja483bYPmeuXbEzN+gZnunJsBPGe2UlJs+JjIdsz+u5Pdv2vI3yM8bqDOjS7w3BEBWdi/2I7Szv6WNNeceGbeWcW38lUjDDDwtm4MFOanrP6juTiK+r8ceTZT+PHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fDr8Y1q/g27Sw4wXkFU2GzdqXQmFIhwcmywSd4Gqrw=;
 b=k83CZdTtqvgHdppbyyTxA5V9VPtgeCFPpcqbm45NYi+iZvDbFEFdFPjvDspvVsP+3lv6aUubd+HVhm6c42GprEENkKp0i8oOZcb9cdTq93I9Hk5Anltxjdr7L8t1lD/RgrtzCfDCZm4UAEC9cbW84d2GGQwmD+01qGMt81t+fGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 08:39:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 08:39:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] media: amphion: decoder add support to RealMedia
Date:   Tue, 20 Dec 2022 16:39:18 +0800
Message-Id: <cover.1671525379.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b189ed-614b-45cd-6a4b-08dae265bf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YQC0UYvdl7sYNPm4/BHtNaHU9ttbMhFz09CV7v4UTVVmc5yAvbYnWoZHadfHVCclMZM1g/5peQtfbfyWRt48OYF8Ih56OlG7gIMpVQR3bKXcJZvDgJdfjBjry7hf+LdJVd/kw1y/t+8gtW7rhu/uw1zr7WEdlmfhTBxHabH+VNKYB5x6LTrh/mBcrcb+MUhTOKDowbMetBEuVSxXmGXtk96b0UPtYNSZVxH2/zsuNo8PukQYd+A6zfPIhLqiIBggs36Gp20vYVP3KLmUBKoEwD6lIs96HDaXMbbwiKusgIf9eeqLUjHQyUx48U4uSBxbncdn59gzb6xACwTWW2TcANzDFqgqGcMfh7f7vZS7v8j+Oe8Kol23mtY78op8bll+Z+EdSjXByJrvQGVJLOCTDnyGywvp58m/0OxfM5gIVozUMOYCn85HkWCATBzDrJnMeEWl3zypy16BrjoOF5qAptX/tJkPBWlP5jOrHJfxs/6P6KU0NKi3jAiKEnF08L64Pt/6XThuK9Hq0mCEv08hZas6krKM1CFnjcncCGhB1aVIgkQ/aO11WCdllWMmb1o7P3kc0EVHNOxXgTSvLn7FdUJTaSGfld2X7IjNzpDJbXfLQ2+4hFe5gcWmhNVxMvbcyIHWrqHoPgRG6wnP2VFLKUKZcWKc0j6v6ZY2I1pq00vYaogh9S5eboUIRn1wdg31B1UXQMtHHYRt9GltI+LAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(5660300002)(7416002)(86362001)(6512007)(52116002)(186003)(26005)(316002)(4744005)(6486002)(44832011)(36756003)(6506007)(478600001)(66476007)(38100700002)(66946007)(2616005)(38350700002)(66556008)(2906002)(8936002)(4326008)(6666004)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMr4pjKj5x4FBoHRzDCGK88k0QmUoKubG+7yFQO+yhsxw3AkX8BM60iCKB+n?=
 =?us-ascii?Q?A0VAbluArFFrFtkmeplihYskW2WWMHPNWlbQYpfaHP1HEZmqW8W/+Gl3JUC5?=
 =?us-ascii?Q?owyWeIyBwmaAmRwAuD09kbMrgP7U5vTiiwQg3nddkihVGWpdS7Ghw2sB9yPN?=
 =?us-ascii?Q?5zzYl8aQfmXmgrL3WNz0XzWXVb9aBX+TLa5PA0EoTUTi5wRPC5qekJ8oPT3P?=
 =?us-ascii?Q?79sWDtHjd4AWzvILeNlNLeNSzRnKC/2ERpH9O3Y2xGdBlj01ZIUPrPzjxj3P?=
 =?us-ascii?Q?TWioSgHKexsB+Byo4aR4wjW5kH7haTtNpj5+7LuCSp+aDnaOmyVkLvM6dN8P?=
 =?us-ascii?Q?EnwTs5e6ra9782rdrgrGRyhobUbYq6SxRq0mOiYoXhy7wTBIRDyRGJnW/tY5?=
 =?us-ascii?Q?fiEfDBxlQSyu/CPx7HxFMDpd/d3NObBHWAZwL80yRvieWYlMjAfX6WityWgy?=
 =?us-ascii?Q?i+PQlyhT1+2K7GlVdfRTPoaMz68zgzTWelmShwrWGXtWpfI9ZKazd4sR8Mpf?=
 =?us-ascii?Q?RbBhjYtIQcyEK+PTddordoDAeYxGuHiqJs0GcnVouADGil8ryWyVqRn9oArq?=
 =?us-ascii?Q?o7F5hkdLCNfo4wj8fBmX7qZdbNc9N7SKEFxD1qUSQJdA6uNnuvaAymT8aXMG?=
 =?us-ascii?Q?7yb9nu95XGz8g/3B/zxv3auMfJ/U98hj1fYu/+6fUtnmELkNzznUr/bjKEKz?=
 =?us-ascii?Q?wyHW9xYv20z/a2UC0XaFdHp3XAPss9EXqqtzjUI0ukchXvEEG3yy2enrlBpR?=
 =?us-ascii?Q?pH3mzmNTXDKSIDoAKi4bj8JWv2na0BrvI50PqY097shxV7AXkveXnXA4betZ?=
 =?us-ascii?Q?sY6gTrzBQlrHMSyoq41MkAXmhuJlvf8fPnha/YjDO78Zum3YLqlZTY3Klz6j?=
 =?us-ascii?Q?nUbaGYDvz8SIPCxdoEzdJZqU8W0SHIeHzh/IMJZ1mFtdQzK2+4aCcuhTZHt1?=
 =?us-ascii?Q?I1X/74DpdwWgubW+dkes+KGvdTXtXB6duyXi9+noPkdRuuAw9dJ8J/SyTSY/?=
 =?us-ascii?Q?/QDBCWBriATH/v4HbhtBM3gW8gn3NCkrdzuEQV3/D4JDsq2zMI1MH4QDttEZ?=
 =?us-ascii?Q?ym5gL9AXq4QL2hxe9bJgOR2r9RTLFY1UEBuIlH3TUQX2aOfpO8L5kubGf2Sv?=
 =?us-ascii?Q?2mGdkQgRx9RuDEBTIJ1Q3+gp0bsrNyzW04cv9OLJ0+LwtTbIrAK5SXM61Kjs?=
 =?us-ascii?Q?cBGHGE++UiRwohBdLcr58OJLV4tg168jtcxqPypBY2fLwGxa9Xtfwts4G2X8?=
 =?us-ascii?Q?1c0WSY3DZ3vSgHu3fnQ2JqlhD/sGiCAf/88p4oorOcQtJ203IBCYUHz/pmi5?=
 =?us-ascii?Q?5hhLfmCM4y0kuM+VqHmrc6P+YodcYfL6h4zmxuG3s45i2D1cnfw0YNBT8d6j?=
 =?us-ascii?Q?hK1ccbB/OY+bfibjP5jjfjXmWgniijlUVzSj7JA3AQQhwYHBzUyDn3PCbLdU?=
 =?us-ascii?Q?SWE/re8OVVf7w64+Q2CyZp8YWdlzWtzA0tDPwDAd32gacFA0Jgvv6JdmhoaB?=
 =?us-ascii?Q?gpBGEdH9haYc17bJyrSss5EtrudcyfI9uHX3L43Pyn2Bt5oqGDXXDkgYfS2W?=
 =?us-ascii?Q?JYTEHpOPUu5Z5HLdNsnmkNopZGZHBohpUtgcbpHo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b189ed-614b-45cd-6a4b-08dae265bf07
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 08:39:45.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROfIAi4V2UJb2KaO/Dez25qF7gHlhSU5NA+mknD8BDSmB66kwcjJ19cqnITZTH6qqPTgA3w76yBpmz65q6Ydnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RealMedia is a proprietary multimedia container format
created by RealNetworks with the filename extension .rm.

amphion decoder can support decoding this video format.

Ming Qian (2):
  media: add RealMedia format
  media: amphion: support to decode RealMedia video

 .../media/v4l/pixfmt-compressed.rst           | 11 +++++++++++
 drivers/media/platform/amphion/vdec.c         |  7 +++++++
 drivers/media/platform/amphion/vpu_malone.c   | 19 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 6 files changed, 40 insertions(+)

-- 
2.38.1

