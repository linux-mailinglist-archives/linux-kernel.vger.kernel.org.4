Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675116B96CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjCNNuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjCNNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:49:59 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853351F96;
        Tue, 14 Mar 2023 06:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIpsRtHwB2gJAObphMtNPADfXaDHmSkMIJ9Kfvb9HjJi7cdIKJ2YHpwC1c11Lq/oHc+0i6HadpSi1e4VAP3h349U6CNwfD4mqrGc6/POcZSKOOQn37IyU95laJKNrYxLIon+Ancju2aSuRd0rlrFRFEKtgaWiSnxwHN+VtGp560P23LtE+t4iEAnVbpPSijEslbqgdIwWznKtwWHJwcG+whqNlj8Wew9YXtZPulKDWvmY4CIFh+oe3+v5b/eKA//eo2K0kGu8HoT6y1gfc4rO6D2iXHqmoGxbFnUK1xnsuk2uK1WWsncgH9OPEzWkFzn7kRoT+hxO0E2ZPHuvij3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cBIt1WqE2UiM3KlVqdMpaMQA6j7oznkc0jMtmYbWSM=;
 b=Weq6+QY/2v4fGjX2F2+6Ij9/Js1CsiTkGfs3wVR61PT9MRZGcffZPuUzcE2WweSWPLoybGSttVKFP/c8nQ8sx7p5ASd3mR6luP9oMFA5qTjy1UjHLyi4y6v/6ZH08KlKvAayiCprMFo5eu2mFgoAGT0mGqIQg8Xb4w6txwuQpGo8WgZf6+6OhAyKMAmDK8VjHHXP3rtIVV/S8RloU8CXXw2/H9BhKMtMPKJYq+ylF4jHdzc9hxWOwHZepayiDZ0nPGA4Lon8Yc6X2jeNkvcnsjYsHcQw7FlJUl1zAFFF9YUI6cpo+/vJxO7T2ooVKQjukELDtBfdQw99q5zbsYPKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cBIt1WqE2UiM3KlVqdMpaMQA6j7oznkc0jMtmYbWSM=;
 b=zTCMk2xRbp9GpHvrqG3iUZWOVjoI87QDbv8/QXSIuYeefuqDteW7wAOX4bCZEGyklMgrrySHADvpxEiLOh+C3SvDRQSUX8uH/RggA+NA8moyTww+z1jI7ZBYBSFp+7L5NDCMZE/twqzvwzXc9nAh9sjw0e2yNoiJarerfucI8QmRs3CXow3JVezOO1BeTX3uKkdxHQ3lGzjl4BDyDdNyOBXknYlXMGxhrQM/z69YW04CRVsyz1w7e1b1FdbzrLdSUYl9OivVzkagIHaSaClgl4xuftgSmTMZSzDs+70F+BDaPrkOSga529KqdFtXcM14MKIoEdxEA/ZlGhah37mvZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AS5PR04MB9895.eurprd04.prod.outlook.com
 (2603:10a6:20b:651::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 13:46:56 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::2b1f:7e5:94d0:3ba9%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 13:46:56 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 0/3] pinctrl: s32: driver improvements and generic struct use
Date:   Tue, 14 Mar 2023 21:46:39 +0800
Message-Id: <20230314134642.21535-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d59da02-70e9-453c-2dab-08db2492933c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2vUD+yOy4vh2vi5aGP6UFpJWjg+xBg+db278o5CocdlKX0YnhFdrsGfotIJtRuV017iQ7IGxDIERH7UxIQRLb8u6g5Jo0NQEyBKLXpyeencxKAagxukELkiErjfXH64fQq0MOtweXOaU1hYiOyuSV4zUmMu3kSmUGzEkuqaRgwJ/hgb1EcSIEgcB5Oa0YWNUKRm86IMZAJIg5O0sJCxqnkOLzA9hVS40CEROvY9XH0gOlqLi4kBeoH6HmqT3h8iiOTt+AX0aoDsq4pIls1rt9X9Vx7Tx5OBc4g4SkKQZgUS6a1YtVrgv/p3X9r9VXsMvVubUUXhzLBy8L2jYu+K6jiiNdP95u7snBnSRWHXhoX/RtstkPG+bBRJwhUM+crVaoaU+oGeU7jSuJy7UKKLg1cU6UzykfMHjrSg2UpthK8znF0hpu6DqIwqn68VgeiaLfpXOn8JewbNUepYpKq4lKQmPELyldOBKhWXDvraozp3HMjEsWZoOQ75kBqUtsk1fQ4fOMRtc9h6tes5/3rB9S+NP+KtFlth7DkFTD5bIHWgE40EwaD6bcO6QNSUj4mwc46rsiHK3ykk5LenjLm7TkSHg1vp7ZbsOmPEZVXVThhp82Zdru+OywjxMBm5qmRg1aNn8139nmT3274nAilf/oYDKE+OXMyDVusif8ksc5CrI5KxIIxv7iUTAZ6YsG2z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(8936002)(36756003)(54906003)(478600001)(110136005)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(7416002)(41300700001)(2906002)(4744005)(5660300002)(86362001)(966005)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(107886003)(186003)(2616005)(38100700002)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZZF+7z3ru+f43/tyX+ngp+y+WSmvQOTkdXlbOFNC/hC2MHqHvTXjny9v85/?=
 =?us-ascii?Q?z2IcxdreYlxPFNuk4pnAg9V3B5Co1+1Hu/ok0/UKEfGWE0x/PB0YLimztK2o?=
 =?us-ascii?Q?tswfFEDnx84Ept0b9OvE28mn+j0CMVNudYLJ0dHEC7oJuCQkSXRj7MMdu73n?=
 =?us-ascii?Q?D0JI3r6bLb+7pSpI2ag72mMSRPLUs1lauzRIta5StI78pM2HdjZOs8uePxwF?=
 =?us-ascii?Q?9Pgs7rA8PQ+pwaz45XMM8oocGefRtF9HnKTY7G1cGtKQuWuJmz0mx40SbVmU?=
 =?us-ascii?Q?Xab3c86mK2CqPRZ87xhHQl9wd8LhE1By0B/c3nNvk/tcoFHePoORpCqEmFTs?=
 =?us-ascii?Q?15l3CzDmRs0Yyazpod57QNnQtXhG4cXX2xAOwKwjhodpLUMJjxKOaRVmtXFS?=
 =?us-ascii?Q?lKXplAYUphHwfQ1zFUX7fclfBTPwxScrgXu90FkYtppbkF3bjoiAirUHY393?=
 =?us-ascii?Q?zwZdLphkJfGW4qWqf42XhN88FTWluNGEPJm3WF7qgMsUAToPDUhHHWrKW6ka?=
 =?us-ascii?Q?mKGFozFtTdj9EiFnJK6SWu1dXS7k1zcj5HGI5uKkkdhztE5Beb4HWe2ZiMVY?=
 =?us-ascii?Q?yZ/7WNHvAer7KJzplucD/xbYkS0BqAyBjHO3SIs0znK9KiX4cvOCokhphxWS?=
 =?us-ascii?Q?AlPI04mX8/GeZHQqqMPA1NtGRB2KnKvmJuN+pkegt/lTP6MRuX0Gg65XXqAr?=
 =?us-ascii?Q?aY6Ak5NOZnru7c/xAR7CevKd+SXxJcttzX5LJgpIg03xFdlxtvDXdfRghtP5?=
 =?us-ascii?Q?uFooJy3RdHf5oZfBVX4GysKgJooMM7IvQaESYzmEunikphfCZOeR+NxHKH9l?=
 =?us-ascii?Q?fwsUeWK7RQ8mQdNENn62CDo1X8e5zIFeRRWWfMVnSbZubIgN9gW/XKaX797w?=
 =?us-ascii?Q?KtMPsbS6+8MHUl/iukwvoQcxrfnyhkA0skBUEE052jRliB1RdXxNcGkbmsRE?=
 =?us-ascii?Q?N2e/mT3CaL98kMZowqLIF9p5SwPFUtMGMOI9WNKNLb7JtXsrOpDQJRRFOqKw?=
 =?us-ascii?Q?3om384emgM7PtZvLu35lcbf1+wr8O7+fxKMmVNDBofdzZYPKXNTMWzIYSwK8?=
 =?us-ascii?Q?EIQP4vPc9KwGj1U4sgWK25tKokHDhHNcNH1BjIDAKeYwfKKM0EJzJWgWJJUn?=
 =?us-ascii?Q?5PlIyXI9DGLRu5pw2thdyFN6Qz+FpxYphF+oGMXCIdhTVej57TdKS3CrqKgp?=
 =?us-ascii?Q?9TZ2OQ8FxZ3Fm49djlyYG1rJ9iOVGqQVIHARj2E5cUI5feZBy49bo6OvFIrw?=
 =?us-ascii?Q?/1nAP8blS8He10XiPOyQz/Lo8UEsYdznI+ObtXYNUNRYtBh7zWVJf8RAtISZ?=
 =?us-ascii?Q?r5klb9h2In118rFVrDz0a4huIjxzVBHxCvbqV43SICbUyuFteGEhBWa4iqPD?=
 =?us-ascii?Q?+uG+qPe7uHchmnF7R9oV/ZVtkY7cZlnhd3szBgBjhkzPQ7gVMxW+W0gIb8xi?=
 =?us-ascii?Q?dZl2vILI+CmyfTXuL5FKLpoKGXWe3A1PsqumV1e8IxMWGb36QVUc+VIrtUmk?=
 =?us-ascii?Q?bTCUEwlOX6TXLGCK2kELR6XA4niaa6yywg8tqRtw054eSD4hyG7WYwA81qGy?=
 =?us-ascii?Q?OXc6gDWepateMlEklfg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d59da02-70e9-453c-2dab-08db2492933c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:46:56.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4z4UefDGRpZ1lmIK/KEwMZfmLpxwPR2af2sRSJp6ysl3EuhKrjaa2y5R4oPndJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series contains some improvements for s32 pinctrl drivers suggested
by upstream[1], such as

  - Fix error shadowings and improve return value handlings.
  - Fix print format.
  - Remove unnecessary blanks.
  - Use proper macros and helpers to simplify codes.
  - Refactor config param parsing and remove config arguments that are never used.
  - Use generic struct pingroup and struct pinfunction to describe pin data.

Regards,
Chester

[1] https://lore.kernel.org/all/20230220023320.3499-1-clin@suse.com/

Chester Lin (3):
  pinctrl: s32: refine error/return/config checks and simplify driver
    codes
  pinctrl: s32cc: refactor pin config parsing
  pinctrl: s32cc: embed generic struct pingroup and pinfunction

 drivers/pinctrl/nxp/pinctrl-s32.h   |  22 +--
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 283 ++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |   8 +-
 3 files changed, 168 insertions(+), 145 deletions(-)

-- 
2.37.3

