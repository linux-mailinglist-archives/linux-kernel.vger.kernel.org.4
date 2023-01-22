Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B371D677032
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjAVPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:36:43 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4622017
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK+2w8/AmSr9RW1TIaa7sapKXj4h9NWQXWjS1eTs1pD9tfnmXqIDZJWKS8slQlFapvhC0U3J3FvixzlePiX/a/CZiumCVZIy95RxLAhP4r6f2xU4vdZvy0wfcKS+Utx9CGvxXHKG8ls4JK+DmQ5v4D6Ubn7cX3ONtrjPGLtVH+y3J9x2hOdPEMqLENpsezeCJEyzmNwh+d/1imHeQDMwsBBEe2sYnzyPjWOyPevSaF6IPNsVPdOuTYDpeLOylASoE2nzdn82kW+8qg2BuVXRLKHzs7yjeTYzOwsWeeJOnUA4goSwW+IK8R7tIDdn6eg3uhdnsS22YQPaDBmDNxMPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU88Qgp8Gk9+VsEUbTvac4/6+o+e0MtIneaxHAfF3Zw=;
 b=nsMNWDOYartGipKAq/M5NHM+9jjMJZJUMWdySVeYl+842qwmAgmvcNdu5EJ2jLzRRTo0IqLB4iG4w1De4uY5pcQE40JmqewtHhh+is8m7sYIxQN92XLqqNBKkzjkjWpeYKzmz3E5BnnXLUUHdVO2JA2Ya9k0X+wrlzIdY3B3DAYLNSiXBFVJkVVpFp3oe8ifTelwNbJupNcBGxW5d4nxhIFXjzocoQIngZ1jV8KY0nCnN1wXvhbVfZvErYTvhLuDwXkhEnaG7alia5tkQYUEyYKu+yG1KRq3jMhYn7g2jaFcwVHCbD/RxvN9J96/Z2QH9a1AvGN5puzIL4MuRUlMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU88Qgp8Gk9+VsEUbTvac4/6+o+e0MtIneaxHAfF3Zw=;
 b=BY7OcHjnGhiT+gVh6X3KJMbMZublOIgxWtYsU78Qn+tY8WhXOqnEuYCzqI9jwmDszuHzJYjX+QJBeGCZXfUuRwYyzYzxApruXp1Gv3gWYYHUvn2KA0Sy6NqYV6rM0AdbaTnNIrdvpEQSFr+lo8eSWnjKixJD5G1zK93hAREpVzlh3vlKrXzbdiWnYw5r8wNOKS6sGcBNO960MOhuYrKS8Btb66Dfv2kRZqLApFKfxG04ywR7/KF+fsgMCgGvFzDxfSs+sgsrbuPicZ/knwd4rbPF/Iuy5DUD+KbksegwZ0NZfdjuThL3yDTb1UnwLiZlsfa/1JdDh0fejsdTqx53fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4297.apcprd06.prod.outlook.com (2603:1096:4:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Sun, 22 Jan
 2023 15:36:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6043.009; Sun, 22 Jan 2023
 15:36:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: f2fs: add F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl
Date:   Sun, 22 Jan 2023 23:36:28 +0800
Message-Id: <20230122153628.70625-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230122150049.66607-1-frank.li@vivo.com>
References: <20230122150049.66607-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf9d0c9-7657-41d8-ebf4-08dafc8e72a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lni8LsQau6PslOhAKY1PfHNxjE2J3Iub1SLDQnLygiKHA6D/jALDOlmseutBGGThPWdTHMukphYdVJeKgdI/UWfWYEegRAYfaq0e357wuVJaLS3s0vZaTI2EUmKcFnE2RCdYChYvjUG6Fs/L2PLt4WMNw7JueMKHS2d51S+CbPEJAoMc5viNBGApWQj9D4dpmQf2AgCAiegRvd7Gdhd+7v5CeqGBDeCebs1anoaGHkfSRxt53g1P4/JAjbvrawnnKQnzL8pq2WIxJb66sgPNW639erWww+YmwllqJatuEZhGKEqPj6htW94ytx0G8rDZQ60vg1EEkokVxribNQunHMdo9zudvFfu/FKmzZgFrayGW5mxOdhl5DR1QKq0sX1H+J6SAaiWJASfRfSUmem0aSvWeO3fMqYRyDlFALxbyZc+7tEcflPaT/D0i/EHEPVM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(451199015)(38100700002)(38350700002)(558084003)(86362001)(8936002)(6486002)(66476007)(4326008)(66556008)(8676002)(2906002)(66946007)(6666004)(41300700001)(2616005)(1076003)(6506007)(186003)(26005)(6512007)(316002)(52116002)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SjLNmLypV2Rd65jlOX5aUVJlSw7gGu1xQOeSsCWlZWkqgescOJ0H+tCR7Vsj?=
 =?us-ascii?Q?3eWdJGc23jYhE+GGzWIkTN7fZfbfdJqGtrXYOwBJ/AP3eTDAobBe1vc5OqWA?=
 =?us-ascii?Q?fFZROFWl95Uv8tHs3+IRg2MbxJW6azNy2IEj6B1mtvV1j9ZCsd661BJA683n?=
 =?us-ascii?Q?o+Xy1+Gj0Is4fpqfxtm6IDfuhHPdYLJAYA0QUUrEtxhHqSyXqhxD8f7OI/SO?=
 =?us-ascii?Q?lcG+jWCZtzBB7zHmhMRtXA0Uk2DR/co/M/ML9t5ZN9OwM/+wiPXJUcvBVTzM?=
 =?us-ascii?Q?xx7RjdbRAG6PZf/HWc5kI55H0LFf9WOcaIyktg11MCfM2aCWV394wAy+e9de?=
 =?us-ascii?Q?TykKL5NBe1h/n8LKWPi3R483h3d+LjjioWAHZBVujffZoCgImOKxGCQnHq3y?=
 =?us-ascii?Q?hsLe83IaERyi63fNg48h+RuqXVSgJckr6YSiLXTrRGnWQDIjHnXczF2XO6de?=
 =?us-ascii?Q?qp65uXoO79Q7xZU6Q2g0gsynLraa1Fx2ka8C7a6LZiP7ciTouDtUOyW96l1J?=
 =?us-ascii?Q?YfTnfvsGpXRpGxacAdzvy1JQzSUnCncZQp+b+KK9qL+KkbwSRDDsALPxs9G2?=
 =?us-ascii?Q?JrP5M6JWBJuxyJNxxspeMrDK+E+nfJ8vu0JmMc76qDRIH9DIOCsLmm2u9Wk7?=
 =?us-ascii?Q?AasLXvS8alJesvY7zYFQGMDXp+5If+qKF+ovO8Qwpn/f+FP6VNviRoYLKGu4?=
 =?us-ascii?Q?Ad8taW+jmDLXfoNpEyyUDaYF4MC+WEWc1AYKnpVHVeGeiTmvpNpqymIMNQoN?=
 =?us-ascii?Q?gQCMftdIn8teirTE+tgQ/YZtDk2Te0U6ewUMwRoGpX1DE+7GgS2tdj7QOUGT?=
 =?us-ascii?Q?/DrGP/UblWSkNZi5bZXLiSh0YRhaRpYY9DllFjJLKf2lko3L1hvZ3aATzsCZ?=
 =?us-ascii?Q?lLRu2KDhZjd4ToLO1001+1FMzsuy5RZp1J7DXx63gDxd9ivatCdOKwXyuWnp?=
 =?us-ascii?Q?orFIWXZlqt/r3zumaPEyF2qqB4S2SYLJ6j/98tLtHp0QBju8PMGIX/rfuAmu?=
 =?us-ascii?Q?l3DTteUjhmvzeSJuk2OoWJ1i1zCkYSEFs6XGLTsj62stSSm/Pll3a5jLm8p9?=
 =?us-ascii?Q?fEdLHpbHoek4qlllTBAtP2A5OJIjZCWQK8sslRrmjeRxdiv/rm9QHjWN69IB?=
 =?us-ascii?Q?c5lP2ZntSzxDIilim6ld+IHu+sczFfswyWm9lxZ2FTY3DwTRO9uJBAXl7ASL?=
 =?us-ascii?Q?gzepEDT0P6d/nS4jwdaLvpAMkY0zMeUu2oKIlI8+bQq4q8reYwAx/pa2jQJh?=
 =?us-ascii?Q?AeW9QP/VmE324u1gSRZg4E/TKVe10RWLlQQ6iLRajYKxwgtoGKz15yuygMko?=
 =?us-ascii?Q?0wPVdpxCr95XdyPi0y82NFDi3VVBMxyMBWIZ+V52nFqbnAjM+IANZLAdWmJy?=
 =?us-ascii?Q?v8qXqbB9FSpz2Uwflx09Zabs7NJAEmw8tDPTC/wGI51FDoZbzu8zfMZpLFFU?=
 =?us-ascii?Q?uZoCTcA4ia49k0lKrAbRBP0MzbntMX9UniWfBQbcVtPgzWhcsAwjYf3tFFGL?=
 =?us-ascii?Q?8NNOqNE0XHuOYOZ8+Fst+bIeiVU2UKKyFVD11y0oRSd46Esnoo0pA5D1DFtf?=
 =?us-ascii?Q?yWH/0PmEbArEzlsEP4fKxHcFxHUW9vFhIH07OG86?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf9d0c9-7657-41d8-ebf4-08dafc8e72a3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 15:36:36.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFUmRuMuEEzJzNihbLFBOYasK0TF2R4+bhepxy4g7fQYE1YLIFtLwT7+KnrAsKX6w9SBBsAFU4NPEEd3YFq1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Nick Terrell
