Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104270E1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjEWQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjEWQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:18:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF540DD;
        Tue, 23 May 2023 09:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxOtFebtD7LTwnIvI2XmuLJd0v14aq2/gMQ2wVp1fPnXEKsMlcX4tTDei4f4aMXu54CZSL5OogVyntmzoNLad+uUxIQjjapwP9qfPg0XnHOEh1nemcTvunVzWUOY38IwFHRWvlKALwL5YDr9OZP+lLG1h7oDl4+vtS2Ll7X7t+AuE8opHGUydiSNlerXvexVQ5CgaPlMQTpRs0yuLqIxOATjYjK1BKTZzAUyPBC1Bnedveuf0PV0GwWeZJQtHNOA3q6oRxVOr0C7du9gmJl/hyCfwpiAGVkmCQ5wuXJ1TQb9gaxzvhgva60qZuc4rmeAuV6va2nNu+7PzJFBWNnOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRFT4XfAD+q2yRmGlT0vl0cf0uMaTKzaZPu22gcQzSE=;
 b=Fxg1H6utCen+U7XMelCjjIkH0+Syle+/99YZRzNJ1sQOlwAEvli8iqZ9TT4ki59c56PWPNCTPmTgefGEzlSGHmU0FHy4vuIcTvOb8Nqq8bg563EfZrMlMTntvU4uAP1K44i2/VItG2KreJ6oN6yu87wQraYXE4yqhU7l7qN2LnAaiD3bb7m9zMD7AuSSeSJHTyk2hbD4f8NFhRuobcetutqvNezWJ69vApeK/oy/jofbvuf8HlFgEUpVTeQvIwYLLhwHtceku1KWxiJNiQurbBJSHbP/bIET7yrqAidchsPay0xuUXGm6cDFjWAA57ZI4UkNZ8amy7CkX95PSXMvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRFT4XfAD+q2yRmGlT0vl0cf0uMaTKzaZPu22gcQzSE=;
 b=Oo6WCWVHYrRrRQCcN4nzadDr/7Wl0YSmf6O4XrhQGymVF05Qh2jUVBZ3JAp8E8uQN/enwYxqNjEgk+GmlkqaBxq+XoSEuAMZlZzA2BH8ASgnI3xZEXpkqy0FEuhO0mat5rxEX8AEenBuWeEF1IpY6/gROpQpeWtDr8B2pPUNMMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 16:18:46 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 16:18:45 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org, broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH 0/3] ASoC: da7219: Add jack insertion detection polarity
Date:   Tue, 23 May 2023 16:18:18 +0000
Message-Id: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OS3PR01MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3167ece9-4cfb-47e9-4722-08db5ba96223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG14iCkdW3aHTpQXhkPWm4tI8G/Ok+rcHBRkie8lKoeqKCdsPvWIaDW/Wzq0ezw9vbKmuhMULhl4KViyp6IftSJXl6p1A2IGJSdIbNZscM7Yrct41rOHWP1d1eeclV/r41zQb7jBuVN1C+hVTOM+GJD4qSJXC2UicwXq13HMcdEUyYf39dQg0058J3qgjzXzi+3oHkAa8EUfdbT/df9vg9ddtd1fATa96rkZ+LhILLhbFeKiYscPW433126Rs035OmS5cL4pNypuhtTAdVgEeIa/66u8xucrLw+MGxC4i+sq1B78VnYoyx6naanXMvQu0ywoB79u+HVdHEmMgk/u8u3ZLMSKLy6INjnaqsDpqBf/aC80NcYpy10KrKCdYZDfqyWNCA9QDMC6pmw5YUK9mGv1J8rXuBYt30ieiREd4WFVsQiz31LOdtqGsFF1eqElQi0JSggLb3bwpTRgV43bZ4wbadBvEWG02qJ+VZ5iD6LrWqcjHcI1FHvYMHxo2jgA2OV7APkXIYD+Nx8jPf99062PCRHjC3Mr+rTI7swjCCbBoJQ6AIrzU9MT2a+q5gmuq1AfWM9nvO9VP0bVK5NrHWKBACOHUkzrrxEM9O8dVzLEChmbcYCWw7TPIE9jnxMT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(107886003)(6512007)(8676002)(7416002)(8936002)(83380400001)(103116003)(38100700002)(38350700002)(86362001)(6506007)(2616005)(4744005)(2906002)(52116002)(41300700001)(66476007)(66946007)(66556008)(4326008)(316002)(6666004)(6486002)(5660300002)(186003)(1076003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGh6FBcFewiLAdV7X97Jad7Kjv8N6xl0ZWFl/NoqUi5QhM+N1w+WX0nhJ2yR?=
 =?us-ascii?Q?+qW4mSQptXePdCotwxfS87ffxedLHFvKFgc32nQyExeYtt1LWOYlTcJzot+P?=
 =?us-ascii?Q?m1fanjoygUj1mKSkvfcCWEmZDqAKIYbJjOuoxkaOG7DdedggrdNkcsKn7B9+?=
 =?us-ascii?Q?PUvqCJbGKaDSXSKqx5Ewht8upJMQmwDtOWkxrjn0HVfjjTpgD9Q69OkjHblX?=
 =?us-ascii?Q?u91vJ5Xj0KuHOLSefIjYXl/6CfDL7zOxpiqi3X4x9E0mNVU3TpftjSvX0hX/?=
 =?us-ascii?Q?tycUDMTo2XE0V7DvyW80J5o1B5Em2FVexQd3k5v9XNTX5w5qQWGJQrdwJwst?=
 =?us-ascii?Q?LuQYky6+omMw/QISLaCme7P8XqPlvlYuNQHHlna0XPKZveU8ldIAZ0JdAkPk?=
 =?us-ascii?Q?ExXJGCTdf0Pqp1apDR3n7ucCgQQCWH/UN/wjGBW2T0OAkDWYDNZjsYbMK7tL?=
 =?us-ascii?Q?bRAfuORVFOCScLocxthhDWv62St9Meau58WufwQvNCsp2rFq+p3wlIYYtHxz?=
 =?us-ascii?Q?5T6kgGiVgX0Aa0AWWdp433Jw6MBNArkr8RAD/1I+FpJJ6azci8U2sF4iMNAX?=
 =?us-ascii?Q?5kUm25nnErj8VCfHN6dMcByokw7nlSLlpx7oV4mdLigg9tYMAgTiA993FOhS?=
 =?us-ascii?Q?VH1mdyOK3O3nz46sJ/vd9CquBbNejFV/ujWfGQGNXg6GL6sFmbsPvWMTDrI5?=
 =?us-ascii?Q?uxdPQCJrztP5LzshMy0ZXgiC/3UAyyawd1brWWCnwjfh0DYrN/38r8Q8JCYL?=
 =?us-ascii?Q?Ih0QZ5jsHJz+kzZqhiPj9JmEj86j36sv7BfwVXbXsYCuOA7lAmybkRX/vCF0?=
 =?us-ascii?Q?Ry1H+sW8VwILZ3dSakoSCqLlWhBE/qpHIWlXfCwXRekAJpmXmL7PXw87uzfX?=
 =?us-ascii?Q?wCRs7Tw9S9vS9J9NDVeStP5eu3Sx1Df/vHyr+VUTr8SSxiYOgPXHDw102Hu9?=
 =?us-ascii?Q?mDromejH/44XszZ0BcqwCOoIo9k74IHO9Zg6CFXmkK7jLtPm2JW5C+sxE4G9?=
 =?us-ascii?Q?45Qv7AMHRObcSMWwS4AW/m+WqEkecMCiv09Aqqv27WwUfig3/L3fJLbZlDYz?=
 =?us-ascii?Q?LknSood1USwa4ABzJPnN/zBOaWNhCckQRtXqdjRrWsaL8U1ZBqiaazW0yRaH?=
 =?us-ascii?Q?tRjpotT43+0ymR27Bef+/jCOICbbg4OK5bWX5dhFs6xbzMYko8E/1sa063k+?=
 =?us-ascii?Q?AXjDUnp1rE2GJ6EFf2P08nhU8frIabZfUwh5D5fm6Tv8HzFmrwHvEEMuNdQA?=
 =?us-ascii?Q?eMAppUvky4nRPKHMujPjWBjaaitW0RoSU6oQJfuV6+ZCJHLBlTOje7NupHjS?=
 =?us-ascii?Q?j67ebvQvUeslldKO4dbq9EKoxrAPh1w3TTYqDFamBCP5ebZwrImt0AjYWRJM?=
 =?us-ascii?Q?mp9uoSjjobHjJTXUd+06rviRFdw2WcjnXJlovCFgfES54DBEol0xo9+hMMk9?=
 =?us-ascii?Q?4JrnryK5oEDcqDmcr1Y4h/8HhnPmX50dr03HLdcYSvdATbVH9fBDueIA1XSx?=
 =?us-ascii?Q?ruCYiyFlPz5Z08d9owFYjalYZgPbdull9t6Wtx2o6hmGcAGevsDi0WC7oXiX?=
 =?us-ascii?Q?beOh/LjgDObXsrqSlUQXFxi4iGhSw83PLK6WFLTRwt7qge9MyS4Bq2vXFjZd?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3167ece9-4cfb-47e9-4722-08db5ba96223
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:18:45.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9J6rM6Z01wt2O/H0Ynqw1Xg5dTrhkAbVdE7cU8ZqdQYgJPmfpdfWyxGCPb23wI+lYJ7tDa2Shqc6xN5h8EPkOxg9B6fHAGy0n6MtwJFano=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
X-Spam-Status: No, score=-1.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the support of DA7219 Jack insertion detection
polarity selection.

The first patch replaces the old txt binding with a new schema binding.

The second patch adds `dlg,jack-ins-det-pty` property for Jack
insertion detection polarity selection.

The last patch adds the driver support for this topic.

The series has been verified on the DA7219 development kit.

David Rau (3):
  ASoC: dt-bindings: dialog,da7219: convert to dtschema
  ASoC: dt-bindings: da7219: Add jack-ins-det-pty property
  ASoC: da7219: Add Jack insertion detection polarity

 .../devicetree/bindings/sound/da7219.txt      | 112 ---------
 .../bindings/sound/dialog,da7219.yaml         | 237 ++++++++++++++++++
 include/sound/da7219-aad.h                    |   6 +
 sound/soc/codecs/da7219-aad.c                 |  42 +++-
 4 files changed, 281 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/da7219.txt
 create mode 100644 Documentation/devicetree/bindings/sound/dialog,da7219.yaml

-- 
2.17.1

