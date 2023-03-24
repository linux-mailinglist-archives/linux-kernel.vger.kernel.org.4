Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A326C7FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCXOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCXOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:37:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BCE10EB;
        Fri, 24 Mar 2023 07:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ1odqTm9wAiVm8jgnWSwTuwRokr+9WZCxvBxTxezJpj91gpkoQYS4mOO8kVBMxgQewI8CtTjDFEN9+ugJbuA7ryDIF/kE7IBQMSg+XNc2V50Thkf4yLQV5YMKyTfaFntk5MtKoCnE78Zvo0ZO5DcRpcdKlEsE5mCtOJ/lRYvQG6hBmNjNcwE93m9glRsoaN38nTUEH215/jmI/pIatJtuNfGZjh+NeSrpmcGmFEeDUA9wmftWi6Q6SUkHCvVzJzuj/yUxcYN7kQ+1RHMuoYq6RByHph5hjTAOTLCe35ideand76kX3A+ZlskO+uztvlRHh7whbjbgtPy28BFZricg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVsHlmmOZnH5Pscvqqk8V4t+npY30iT2/Gs3LMFbQbg=;
 b=Oe8MKqE1TdxcwtzZbKK2VsHKQWHZKOPzEPR2U6sHQZ95hunFDuzU+uMW9297dZYmv9tW7LZjxtxYXWo2V+XftXYbD5RcN1XlpEaqJF+cWkWuqYqAkYUxA+xG8bG0PDpRsAhLuHZbs7sEZcJwAP36rn7T5gHCjZ4VnFDPb+gbNqDkNCEor06fcOuvIlVbAUG2KYucF+i1FtWv3EPnJu0Y8TrTtZaZ97FnqG+NOc3rlFLA3/WyTUK9kDLaOFttGBClqrljgWQS94K2+g/BoBV+Wl3IUTYCprq4DiVaK5Bj6qDw+mhoT/iljWWaJ76zP5JLSQ1fREw9slZG0HZ2JTZGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVsHlmmOZnH5Pscvqqk8V4t+npY30iT2/Gs3LMFbQbg=;
 b=Ni80TAgACUJJFGEIXp94w1fT7TGwh5g+YfAPl0FhKE8Armo1sbRNpPaCaR3ZbfQEX4lOCn8UcQ9ZijM7drULp4Wzp4D9RsCDWPL9acIdNATRWdlJOrUT6lbS19raMXfZMUgWCLPWMrBla4K3MNHqJSIImv5BeqzEtC4poREG/IAGJtooWQO6RntEVBy4ILWWs99L58d5lu2cjilk9bg/Ta/fVjUH+dt7txy+hcRrCBz32U0fbBt58V4ffWViM9xzFtGReaHDAOYmwrS2lRiiwtnIzFAvpj6E6zTuDAkVjNmgQGB0ksyHg301kLfOOc3j+esv4LfrEjyWKjQmVMZiIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:37:01 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:37:00 +0000
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
Subject: [PATCH v4 0/5] pinctrl: s32: driver improvements and generic struct use
Date:   Fri, 24 Mar 2023 22:36:21 +0800
Message-Id: <20230324143626.16336-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8923ee34-99b9-4cc8-538b-08db2c753a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkwYg5EAx4GJ9gxthv7W/1gE7z8CX+7GJjS9Z775QBtq99XSTMYlTQ91mo5bs2qZucSTQHb4WFR0NKTLwtrhdS5lA0iRL0wpaUZ1HYxpHLpFpTbY+LB+hmMLE0CIJ2CuA8l4Ra5LWtkHYCSGFmTyPWvssf4NgIPBOmDy5GIgjZumM8Vl/776rK/8L6gaF6RQl6bSUB8TQY2R8Kios/e8geux1Bx3SDKxNKgiro8/Z+E+QXtjYcXryGuX2Z2ukJGnDwAo+ieCELPW5kKyJIkSs9FrF29ZzPGbbjPPlMg+4SZU4ni3otBrdw85xxyHJ1lbCcoyg7xpEt1Obk6n3R6IdBnN1geHWymXFSmil4YlU+fGtrX68008eEHSTTrNN6kb8RJodgtr3tkZfTq9ypLOrugpgQorMW8nmKAqMN8374aepto3HuBBB//XgxvATkUPnKJpI7b0Wrv2rwtW48ifR0afaNvaEw7I2xflL/md9213PP4AvLK/18e4Ye/0rwIwiH5TCfUA+E7uG8USRysFIlClCp6Gm9BJNeY0q/kf9wkRkwJs0U6Bnlkg77SlxIbGZ+rhOait2oqEccmdQ67stmje/0j0ZLurMPKZ5OZXNIZMJHJ1+jUYYiT479W1bBtyy6+/zYXb5JbuV8rVSQqUnFQgJn/pJ9+3T+DEuACwCE5XGDRWa59B+W8M16BUDJmUasZvIM41BNfIKw9Qh3CfOMBhZlyTuOjWSJ+pDGCSOzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39850400004)(451199018)(8936002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6506007)(1076003)(6512007)(6666004)(26005)(83380400001)(186003)(2616005)(107886003)(316002)(6486002)(54906003)(110136005)(478600001)(966005)(5660300002)(7416002)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NY+p1HaURysRTaeClMHR/6ZI0aLXTgCvd0YuoDyeJOMXDdcTKs7Mzoqy4esi?=
 =?us-ascii?Q?vKhPcpaX077Mny4DcvdD+O0qAxRRf6a6gYBFL7rdaBQoMzpyX31vEI2PHlbg?=
 =?us-ascii?Q?oNaOll89v5QcJzTUo4T/IT587XfpkzP2MaEcXTI5SI9gna/lReYT7LeYexS0?=
 =?us-ascii?Q?S8u1Xna1GoVwOcKuIIVrcv5YVLvRnHWHKyOxdV+cgMwrDvvD3oKEXCLYSo1t?=
 =?us-ascii?Q?xtBzYV2KA7xTRIiomLp4/tsMMsbjzvPiZKwVxSplHiGMGNMMfIrSDrEopjhp?=
 =?us-ascii?Q?N2783vYXv6Pp1OOEVUDDa888heT4n4jMDFX/JmzUh+LmGuhveT7u5KbV3r8O?=
 =?us-ascii?Q?1uEpM19aWV9iyIroLE5Wn9dzpBW6fCXz3AslsvvLxfEawHNEwE7AEsjgJQjF?=
 =?us-ascii?Q?hi+2dsH8SX59SjuZXRPvY6/qe74qmxq2xapBXkXRKJCNot8oDIzNeewAKY0o?=
 =?us-ascii?Q?s6GOt5ALgjmMWMdxEZL4VffkuwAuGBHuF+lfnNyO0Wn/WW9aZO8hNdmZVVvT?=
 =?us-ascii?Q?WeXzhTT2McRKQrmbNIyB1x+anUGPOScEUTFSepZOsU1wKP+PD/AdnLvwlYbK?=
 =?us-ascii?Q?Hyz3mmxS93m6robAMbTVxplwuBaR8ZgQ7tw0cXsgvS0gZ1/U8oVgo2wBMyIx?=
 =?us-ascii?Q?HLQiHc8dRre0DU1pZrqZ2pNMtFcUyEaUuj7dxkoGy6HVXO1xmwWdWrLA0e3Q?=
 =?us-ascii?Q?7/Oo1lmx37t+n5eTGbdxL4RVk94XTrSEkVblxgrL1Bt29OJWYeu95Hkt204m?=
 =?us-ascii?Q?rbUNI+ofiG9fIH6PqU9reWkermdQZoNhyXlIWtYt+Ip1UeXKwMv8Ih8CUlNQ?=
 =?us-ascii?Q?YZtRuU/0RDITaqlYZsWZhrTMDerXqz/MZREh70GBCGi+WTYqwIDzH4dIk7Og?=
 =?us-ascii?Q?cxwgwAUvIC+rohc4AQyXes/WOUlOFa0JrEaJtskyDmh5c+pGWd+HzMneGRQA?=
 =?us-ascii?Q?og076HENOkEN6gU33rxt9gKhyBcGa+g2i0PCcTQvxPC4+uOjxyr3moBHBmhm?=
 =?us-ascii?Q?Dj1JXK5Tmj3M22DKLZQddZ25cziKldLTv7yJH7+3csOqg7s4Wws3Oh8QN+wd?=
 =?us-ascii?Q?y01ZfxGeS1OlfQ6GV7q3rwdALNWx511tam9mpd12LLxqg8FRP6EhOawaKMLT?=
 =?us-ascii?Q?NbQGv0OX6/vKhQBsj4l9fHRmHAa58H4htoJoFk82HF2NKIqgcvZeBW/GKpyq?=
 =?us-ascii?Q?gxQcIHeceSCw7q0o6h+XJ3x0bZpV3BTSOdxg0bJxdOSJKZ2FK0wFgoGxu1iJ?=
 =?us-ascii?Q?t8nGzYgNM7LNLRVdeMASZV9xF2ZvcdqLQz4ZOqN0WrFeplhVsrvwZE9SyxqP?=
 =?us-ascii?Q?n9yrxP9b1CNF54qVMgCC/pd8OW1WCA0qt0jjbsYDCFM5VErujZ0LNvJ9UTpH?=
 =?us-ascii?Q?NVy5kEKHCpX9hTygsIvpX2lagT0AhmH6UgtsH/b7guN76WodAlIAL/TUM0KX?=
 =?us-ascii?Q?Mp8nJ1Dn2QFbkdu1eIVtYswM7rbVfN1V5bDd/L0wTmLd5PvHWLZl3LaJa5eQ?=
 =?us-ascii?Q?4JhABmocDQrzEIx83pJ2k251TuG29/Z+5utC6IaCoqclVDHaKf0uLuh1zKYw?=
 =?us-ascii?Q?140xdgZD7xlVKg+3oFk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8923ee34-99b9-4cc8-538b-08db2c753a5a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:37:00.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgqlkK4GL8XgUiILzgfizpzHJaZML/RAA/vHC+djtBZ0BhXwyhzyvr7DT5bOdZ2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v4:
- Merge the of_device_get_match_data() patch [v3 1/6] into the last patch
  [v4 5/5, "pinctrl: s32: separate const device data ..."] in order to solve
  compiler warning properly.

Changes in v3:
- Link: https://lore.kernel.org/lkml/20230323144833.28562-1-clin@suse.com/
- Remove unnecessary type casting and correct type qualifiers.
- Split the previous generic-struct patch [v2 4/4] into two separate patches.
- Add a new patch [v3 6/6] to attach a real const .data with of_device_id.

Changes in v2:
- Link: https://lore.kernel.org/lkml/20230320163823.886-1-clin@suse.com/
- Use of_device_get_match_data() to get matched of_device_id data.
- Enhance sizeof() arguments.
- Fix blanks and remove unnecessary parentheses.
- Drop unnecessary marcos and s32_pin_config() implemented in v1 and set/clear
  mask/config values transparently.
- Put pull-function related cases together in s32_pin_set_pull().
- Simply use generic 'struct pinfunction' rather than having extra 'struct
  s32_pmx_func'.

Chester Lin (5):
  pinctrl: s32: refine error/return/config checks and simplify driver
    codes
  pinctrl: s32cc: refactor pin config parsing
  pinctrl: s32cc: embed generic struct pingroup
  pinctrl: s32cc: Use generic struct data to describe pin function
  pinctrl: s32: separate const device data from struct
    s32_pinctrl_soc_info

 drivers/pinctrl/nxp/pinctrl-s32.h   |  40 ++--
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 282 ++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |  17 +-
 3 files changed, 178 insertions(+), 161 deletions(-)

-- 
2.37.3

