Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E465E6D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjAEI0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAEI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:02 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794B3E0FC;
        Thu,  5 Jan 2023 00:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmY5pbKh9cfOJKQs2gGRKTLLzs7resi+Pg/olrslY7iuDiZKyv1zj4BBf4W+P2p1s2WHxHqWpyBlkLxZUG5HOPFgenZUKzY9rryrB9fI9spY259LX2b1+iig/iYIZvckJlga1lp7MCsWLAW1DOaZ9mbFEHoR/zs/fl9gPbxuazqVjV0W1X6us/iZrsT3xNxXS/FiJxZMd6cmxufiwF5F8/iQ/7CTRva1TKWeOkWiPkSa9RMOuQGJfrCsON89kuPLEkCdgAHWE+zKqPsKX2knNeW7k1XeBQk+KC3Avy6nFA0H8u5DlNFda2zgMwyStO7BPKbysI9RmRInov7OuyhJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEsFfGEkFToT5Gu9Q6563Pke+P0ryz6JZWx2/xdw5vE=;
 b=AYbiwXD2tQN/Rf1DjXF9uXoI5bMr9z5pPY/RLaczs+vAnxmT+DLORojnQiGp1yXh6VbQWvL8PRSUKaQjpdoOKBJI574EaRgO0ZWmEAYBoJYQBvYDKUr8bu0skwyz8quNc1zJIUu2M20tY+4COMxmvOM0naiJ80gSFAfySWQ+dfS4XvUvxuzaIFLpR0eGzVgifiNG0WrOZJwNNRDd4BLrmC4hg0NvNG3RdyXrGUkMjqUgNaVR35TxMwbMIXoNyjMadu7Avik/hfqT1/6eYVmjS1swnxOI4oLC6ZRjm0+c3cGtD5rjNa89OMmXEkms7JcZ8CG4AppJupKZt6HAnKtZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEsFfGEkFToT5Gu9Q6563Pke+P0ryz6JZWx2/xdw5vE=;
 b=RFCCehVGaRXWIRyrJlOq5tZNiLTL2eA7rRhqeDrjAQ1+PLjcvPi+Lv2Ptc6T6YNSejG7cU5ne/0s0DDSrJ0JctY8mk/7J3e8cbpXcKJTBwRqC5e/17zPREpEntfd4ITB4k40iB/VdWQob3/23W+HZy6ibMazJoGKLNfKGHGGHTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB8771.eurprd04.prod.outlook.com (2603:10a6:20b:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:24:34 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 08:24:34 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, aisheng.dong@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] add device cooling
Date:   Thu,  5 Jan 2023 16:22:32 +0800
Message-Id: <20230105082234.16962-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|AS8PR04MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: de0bab16-4114-4b42-f31c-08daeef646b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np97NNi8TzOKB280rGMN9TGp4h91YWG8Ugr9yOzSi9Grl7FROBJMa+UJFz3kQbeSbWUnhqboeFrhEWr1pm+2PjqlGHJI7qSHZgmCuCO2hkbE9KLcpgP2FT56ibOgxCWN6N9V2G9wJGM6+2esXf5Qmk4tEsqcr6KnODPGwzwMVzJOcME1Pq4biNMTfkGqeo1PcLMaOng7LiG77HiZOV1YBrmK+7+FPnVwUMYfCAOow/UDcMV5ZofAnUnru0W+IFjFYQpUitOX9gqjchq2PGZY8S2BidygnVMr73RT5l6uDvXNClWrq6TzJgP/bXzRpqS9OA2rB7Nk+SN3zSlDDzmjeFjHox8tGn733MCAqek6V0IDWnyF71Xcns67tmZYG7I6C22kI+72UkSF4pVLcZR+yz28zUyujiCDX37eXMf2qJJDewupLNWrBwcXcXsoaXxEnjUkx7k4OLI5oS09BegQlK44DxlcpTwyL/cj97maeED2HeDP0KFjoweKmREnw/HbYLhLT75Wz/gL7T1OySkhxq5BB1QPMJckLQGI4uSGCJGrwWqUuq3cgKJkOYlhl4/dJwt8YPyiaLLBSb/lHfO0V+eWev51MdoYp67gVvwfVr+UZeAtCkkx4LdKAQC9gt+BRa6r5B5uoqwhlP6BhP+FyBabuH3OxZR04o5vmzn+bxVACozhxv/wXfFXGUgWJcAhjrgZZJPezWHo6MNrcMNycA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(5660300002)(4326008)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(8936002)(2906002)(6506007)(52116002)(478600001)(6486002)(6512007)(186003)(26005)(86362001)(83380400001)(1076003)(2616005)(38350700002)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XkR8q7LFBhJLBLMkpatZDudgLPtcJ8f11alpUV6GG3gciubTXbFI6AnkXK3?=
 =?us-ascii?Q?sw1fy0YHAYvkTTZVdFfo6Ai9or9g4nTVBr3OU6pPumtMNaf8iUHYqotE0fqh?=
 =?us-ascii?Q?c4z18xSSOO+xQD5JwRjDTPjZ4nZPPJ8fBa51qfzgp/VkbAE3CNItbAcRVkep?=
 =?us-ascii?Q?VpZuXnqiV1/np77ShenFtDcC6CFfF1godhrXXsCGnDBw+olKdm8bqGgoJxg3?=
 =?us-ascii?Q?UuKp9mZwqNMgg/jcZhawBmUOBA46HTu4zaxppk8SSh5leFonsAB8GNu0grxd?=
 =?us-ascii?Q?D02777PmIlGAgV4kIqw7EkL7ghNdDWuugQmpV/sobQfKFmhZ1otj5+sFzqUz?=
 =?us-ascii?Q?f8Oplo8aTI08Gjy1vRXG5oGN1YB0lVzsaVST5VdqS1Fla6ieAumJ18uAjl2A?=
 =?us-ascii?Q?M6gFOBDe30MSmdSgO3Z4hiQbpqjGSnxvLMp+vMnzmkKN9bqy0Pdas+CsiuZj?=
 =?us-ascii?Q?hDSxf+05TIFldPZGIgKaNwKyZbnE9ClRi6XlHdArNTtAWU69fGygo/fYQg8E?=
 =?us-ascii?Q?onr05/oTf8M2igEG20QfJ3jABNV1iSJc6vb+yZnbd3yytUIy/st23kIToV6h?=
 =?us-ascii?Q?5CxcoU4JS0qS3VEXcPB2VP+2Bx+imLV87S9S39uY4927fIJ+SRMT1Rxlf1za?=
 =?us-ascii?Q?M/eRyKoBXdoxOklxKegSgefGu1LS4o+iqvAxjgLHFZIGVRZk1ygjUbawwoTU?=
 =?us-ascii?Q?+967DRFBamvrVlN37aPQjju/ZS+sokqYHIBx4UQ/rvs9F50XdFADY+fZGD6n?=
 =?us-ascii?Q?bryj8IZhWNVcnTgNSzX58U7fUFVW2UNOEM3fihx4JiF39/N/3LpAVeBviWNj?=
 =?us-ascii?Q?WDVU5p+suvZBH30kyQat59g0AVspHv1yjgPde5ThICcs4Lgkb+vPikOsPdW9?=
 =?us-ascii?Q?BW8DFGRAMzAwN89s7kfVdvaUVidCc74nfXSqrwKuJ+xelL7dmqYCGv6xi6w1?=
 =?us-ascii?Q?zGem3DxWpzs2vZ9XpleDHMhbvMeScM6dYi4MyA9a6UxsVt1Xc5PtId5ycn0s?=
 =?us-ascii?Q?nc7V13qhFV07/Q7NDKFuZYAsqOcgIR0ZEbGMTpGKRNYE43lw9MsPFFlfyclv?=
 =?us-ascii?Q?1biaLrFVcxG796sK3EdLigrrACjYYT3sa1llsi5l6dtVV8UNOklcN6fydNXn?=
 =?us-ascii?Q?tw9nvAktfnFflFgArIsIpFtgIizVWBq+JXnVrR6v7Rnl6+o23UQy9NnUr1hC?=
 =?us-ascii?Q?/Ia+mR68yexa+KeJwlwhgZ7e+p1djN5gpI8c7IKhlZz5iEWHzcbDBi585Gv2?=
 =?us-ascii?Q?nB0dkzWAk1bVi1IvlfQg7pKQ5l9bUpAtWSpBLT2MON4VO7919wau1KbY2nh6?=
 =?us-ascii?Q?FSLN9EVkpkgNip/DqBtk4p2eyU4RUXRQw3bVJs+sn7zTdbtNr1LDVXlNQtuv?=
 =?us-ascii?Q?FZpDzW5Qd+JA1HvG265KJc09IX/iNXMpg9UIJcPi/oTth5XMvv46fPnCfuVI?=
 =?us-ascii?Q?5nB47zZUA4LGlUyxlfJYyFcGZWaqnrl65qiSYggjNyNxSV8oJiBaCp8HpVQI?=
 =?us-ascii?Q?jC6+0/nHtpf0F/ukhq9yiw++kwpRGrBxizGdNPo4zK+tX6NKS3YxCH3Q/G+0?=
 =?us-ascii?Q?MBya1F9PniMvGkPTBNukdORF7u7tBsVjdzPQdkoA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0bab16-4114-4b42-f31c-08daeef646b2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:24:34.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK0+sJ26FmtJ+jj2HO9YEFUDRjMJ2QNvuYTgy0F33MfAOP036YSBleDFNdzEDdaZCAjfG1pfn4CXCgCcJsp7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8771
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Anson Huang (2):
  thermal: Add generic device cooling support
  thermal: qoriq: Add device cooling support

 drivers/thermal/Kconfig          |   7 ++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/device_cooling.c | 154 +++++++++++++++++++++++++++++++
 drivers/thermal/qoriq_thermal.c  |  83 ++++++++++++++++-
 include/linux/device_cooling.h   |  46 +++++++++
 5 files changed, 290 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/device_cooling.c
 create mode 100644 include/linux/device_cooling.h

-- 
2.17.1

