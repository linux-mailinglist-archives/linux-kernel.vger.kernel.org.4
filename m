Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33F46C1C68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjCTQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjCTQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:44:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080529435;
        Mon, 20 Mar 2023 09:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RapuTTW+Hhi64S2uTqoksFuy685cbgvdBbKfVerV0iG/d9gLmPsXhIrz6gyd1+aoEA3rHVG2YDAIoCaS2kuK1Zhf37dfI3u1B5WKnedfY6DCJHMrgMBsO3oZD2G4nKbjW/cMK+bC7jDsnttACx/KpkVwogiueVlIGflKZbEGlSyB93rjYkldmVH+jqePlJY/OF9H/Py1pXyXYIXzFTxsYxjhGEaYhEyZszitSYci478403rhgcKn/JYNc0U64zu6hdwgN+gis6BYPJGHiv/5Ju+IPe4w4UWv/X2wO0Ihqy4Oxrt+MfCnlN31Epbr+TFrp7vIOlKkGVveiOxXZj93ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1/lYKx6XJlKCa/VMlUTkuQqNZkUu7AuS0U48aEisBI=;
 b=J0s6XU1iAUEBPnlW6yCPA0k1caCuE5k347STV+wGIbhN8cZCSOUknZhgZzLS2qQtMEpWVggTljsGv4REYLDNi6I4fKqdHfvqA/giuPQRR0FtpfdeDMDIFI2s+XSGfLnXn5OgLKmWTTo3psQojBLoQeb2jIjG7foJCK95NYgiQsqnVTJjKE1JJ2T4RMXnqBbiLiuqm2BEK4WOqspq/tpbwaAcIePEx5demuWiCGSgahmNgfZu5TIEMKlGP+ONT8qFLHjtNKakvrSPZ4ceurGIkrh43PqZTcfEDRLwIy88rWop9dAdHT66mp9QNyG4f9R+MPJGnLEZskOvFVqaslYYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1/lYKx6XJlKCa/VMlUTkuQqNZkUu7AuS0U48aEisBI=;
 b=grA8k6Vc2DQREEu2WWlf6tczYZT4fbjXFvGneQWpHvLOBab+LOGC6bAp6ICY5xsbrUj3vWSHssf3IagKoowUaO8v2yH7zG2+luqIJShsVD4FHdyUz8+cM0HdcYa/GjeFhcZ0wkySe5rFaRFlT3HlsSrOlYsBGmTrnJGcNnNvOeD5cIiAHhMYrQ4FldZJUodPEgYrVKjDeqsy9LViu6xXUDs+aDcNw5Q88TVwbzqPv9KED0JKRwNOvVHqHELrD9kx869QHfwQGZVo3dk0MAofCrjLh6CWdQxdKowFmjAznlddd75LnZzMx+ihba+Rlb0T62+MdnY6vXgcnKDlWquv7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:38:53 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:38:53 +0000
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
Subject: [PATCH v2 0/4] pinctrl: s32: driver improvements and generic struct use
Date:   Tue, 21 Mar 2023 00:38:19 +0800
Message-Id: <20230320163823.886-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:3::28) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9ab4c1-0ac6-4b31-7743-08db2961973e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEBxv9LQBZS5aVm9pw0H6w6/LM4KjGwm758xA3bqzrCU00fwA422UVRTdEH8dFBoGpt19fGoimWhYg43lQKo+FLA63VDId1LojrU/smRkN5l9i+Yi/xoqDp8cKJhnLKheLhncLAvsshuz5/rFacZC9dZaQUFIUszynoP7Ksyp4iSOlbTcCc0oKsHdpugciTTfw0SnUawyisavNVxoLxDmaJJAySTfBZRgo1jQ9LHOfJvE0HqBoZ7qd+vEJQEM/lkFRQkycbfX2FXysRHYm1AaYoMYCK9lhi7rf13roGC4seY9dQl0aPD8AMMsu3jbUBSmfW3rGjQHgO7PdwQlMTrP8Uu76QULx9Xk8vL66pIIcrVFCWhUMPf9YKVXKilRVtTkFpwRBKZWVqttGdjdnFT+HFgOspZQ/hwWtb9mSGrVJRV5BCoLkoR29NAI8tdWCFzhSgTo2d5Fvy4NSsTLw9EUW/om9irDH4tDxBN7+Rv9BP1+o6LgmxrHA6l1BFEQGHRbsnJVRZqiT8b731J34PC5yH2RBQE0vBLvEB13Y4AKqz5RCFl+0nyD94INWty4xLgpNxCgJ15ttd7a3idmvuX+6miNeJjmRawhFrrBmxGXHY5xEsUi0TyV85pNvK4X6K8wPLL+9xmK2MJQ29HqLYUNoRB+5HP+RwiN8pslb/+4Dam/vyZv5XkDQZnQqlFFi5/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(5660300002)(7416002)(86362001)(38100700002)(2906002)(36756003)(4326008)(966005)(6486002)(83380400001)(478600001)(6666004)(107886003)(41300700001)(2616005)(186003)(1076003)(6512007)(26005)(6506007)(54906003)(110136005)(316002)(8676002)(66556008)(66476007)(66946007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/JkugyoDtCHCy0Q3oNlK6KztS6jI7RHuEi+t8phK9NplEneLQeEmYKEPIj3?=
 =?us-ascii?Q?scXVzkn+JeNvMp1vqK7L1GgKxKb64bhWAd1vUsmMYDZ5wNeyfxWqI4JzlWA7?=
 =?us-ascii?Q?PIYoe8P/ljCVPJ6d4CM/Ytk4kzLSlZ7ys5yi+dYKaQxLmc2XB/rTL6PxpAOa?=
 =?us-ascii?Q?ERccH3ozSne4boPhEIxTAB9p0xNueWJ1T9iqO/jmZHurv3ptSVPoqozd1XZ/?=
 =?us-ascii?Q?67IeQe717sYlmazQVhGLER+cuI3ZJRaHPB68NC9nbAQZ65kgutQrBCCfCmvh?=
 =?us-ascii?Q?a5ZIzx+e4TICF8HGiLjh0MrsxATvjTU3LKraNEPu2QmwcdGNy4MT+fQS4jHW?=
 =?us-ascii?Q?1S/VRWawXDHCLr8eY2Uri+Bes116WHgZ3ic4K0sevZdwUJjlYF+iydozo7xp?=
 =?us-ascii?Q?4vFCUObsi/DEM+Flalsg5awxbf/5R55wpf1bIXUsQBmEekiO4m3+A1afg9jD?=
 =?us-ascii?Q?qxNdPzn6DMWkXPFHPEPV+9iACwUxd8tsMA59Z6AO3iSCg/nh5cbuw4+yiSKT?=
 =?us-ascii?Q?O2aCslbTXrihqjaDPb0uco1L1Y8vUPvm5ddxxD//VhEZ2eEB3uOvmfQdTDsQ?=
 =?us-ascii?Q?Cf+arg0BydefVROVrTxNe7F/2p50KLXe8uwgP9s38bnJfwXWhh7yvsq7nn0h?=
 =?us-ascii?Q?1EPsOfh4B3MVrmQ9PHN3NEr9ZKnpF3iTe2ovM9bM4+RK0lFE+gSpCIiyV3YD?=
 =?us-ascii?Q?UW+E0FFmN6P5Um6H6K71cDwart7ZwGTHNmaZt6ary7meT4QkjVsWS8qUORgW?=
 =?us-ascii?Q?HCRvFPnVC373FeZPgJmOadh8KLPZk8pbSX08UZWA74D2e1tCAfdCcKuoeqtN?=
 =?us-ascii?Q?BQHKbRAT2BpIOsBSigYA1/ubCZd62eiQF5Mp2WPDZ6G2UM/jGjIP71G17Drr?=
 =?us-ascii?Q?/qFdvgXRKV8IKYWhQNyEK86KCoRaOR600e2FuvrqkMuKw0wmmY4KgtfnFlmq?=
 =?us-ascii?Q?CMPrD/c+JB1F5JilWpHstbEf+X6jG7JUDBIVOdnQZupaFklGkbGqZ3NI5aMZ?=
 =?us-ascii?Q?/0RwTUniqt3K1uLH2qsRem35X5pXLybADGzCx8fCcBwgCTxolRgkRfdjgXh9?=
 =?us-ascii?Q?yPrXnkWP7c58uqFujJysq4AIuK0McDVK33B0Mm0noUf5Bm3bDyt92q9xiITW?=
 =?us-ascii?Q?afJQBjeRKj0j++6wMrbTQiDRz5DfmCpNEfl53eeHHH9NpReuMSRY9YwTiSpr?=
 =?us-ascii?Q?Q56WWlF8wP5JNbFqv3osG6fZu73hcEl9f0QrsKcLRqfCXFs0xyepQcVCEwPy?=
 =?us-ascii?Q?510MAJALKyX65iRRUN6NfsNHJgC0vj1gBU5enZlvohEeZJkVC3GkWiH6lWtU?=
 =?us-ascii?Q?2AoggwugGS4ZsTUgGu6bHDHZnVJGRaKOVJoBWzhbx2jBg5K5jq+S68w96H2O?=
 =?us-ascii?Q?MhrFtOf6iNKr+4bQd4hjWXAPe/0hlqPX5PDispNZNWtyE7W72kA1gPK5Ly9l?=
 =?us-ascii?Q?lNufcrq0kUcR0U91/4ufxmyBKD1cmjIbo++C4pNJq89eoGoLMIjGKERXqZz2?=
 =?us-ascii?Q?DPfbk/sF0aYZMhp65tib2nlXLuadzNpPe5pdXu7poYfTn98FQ3y9KydzOPo2?=
 =?us-ascii?Q?PFPl/eBS6oQtWVF2OnQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9ab4c1-0ac6-4b31-7743-08db2961973e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:38:53.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9V+sOZbR/xz2HXgnM/AAu0jFlMrUb8UebwC8jvODEFvmWbBhCldAlrLXRFD0fGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Changes in v2:
- Use of_device_get_match_data() to get matched of_device_id data.
- Enhance sizeof() arguments.
- Fix blanks and remove unnecessary parentheses.
- Drop unnecessary marcos and s32_pin_config() implemented in v1 and set/clear
  mask/config values transparently.
- Put pull-function related cases together in s32_pin_set_pull().
- Simply use generic 'struct pinfunction' rather than having extra 'struct
  s32_pmx_func'.

Chester Lin (4):
  pinctrl: s32: use of_device_get_match_data() to get device data
  pinctrl: s32: refine error/return/config checks and simplify driver
    codes
  pinctrl: s32cc: refactor pin config parsing
  pinctrl: s32cc: embed generic struct pingroup and pinfunction

 drivers/pinctrl/nxp/pinctrl-s32.h   |  26 +--
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 261 +++++++++++++++-------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |  14 +-
 3 files changed, 152 insertions(+), 149 deletions(-)

-- 
2.37.3

