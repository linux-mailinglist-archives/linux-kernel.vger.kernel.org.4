Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B006E11FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDMQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDMQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:15:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0519AB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahGzNFSLotPVEGzRi+C8WvrYcWe8EPAAvfbKeTQKXNsEggGTBg3GB7KDNWWMhAokC9XNRCIUbVwNWcjdTxq/+WFOqw6qAjE1dJenOoHtldUnuCcPL2fzHkC6dpLH7m2tYBx6yDPpK8dGbHuid9v6Janc9k/DGR23HiPcKPcubkcoFcutAI7vjCTYhl71S20vM23E2Q1TP0VHU07xG7wmJbfGoOQDBrWAV+hY2sj/mysczlUIQAoAJfY0TedxLuX7EKAJWusxXah273/DJRpdVnyzqPau46qebsi6c5PwiKEXnDHz/AXMMi6S5mI9YIiuXX8fVq8Prb8OK/u+nPW2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jamtrcTZUWgeKzoc1VFbcJzG8oRgxzYT3CjFO5UYxs=;
 b=TljYVIMNX8S+6xPvsQC5O5ht88WrJY7gInrPmFXFZHX49bY1FZpgDB2KA/ezRjB2PUZ6LXI/yTN3YKFNOnlvx98AFcZ43K3y19TJYkZlfg9NVi89daeu5KtZEfb0Rs6Ky7l/evVPjVz0Tnx1O1Oef3y3G/7BjVh62WhYrYlkdNX/6d8M4Bh7sq+irOLJW+//jvuH2ht3I2pacdUtUELowJImsuU4Z+UFnTi1QvtJ0JkCGpKqYMtV2YEyNFhcamUtWHx4gcQhqHAGR1UGgd+77UlOXhnoeIkJnRHIxwUvrME9c0qtYS6/r6WDe3bQRf7wuLfUaH/zwE7KoXDgT5re/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jamtrcTZUWgeKzoc1VFbcJzG8oRgxzYT3CjFO5UYxs=;
 b=BPGe+lmVcC0U2syzIdUYI4uu/9S2gWSQowRDsIuVHKDp/kCRtegWGWwMhH/pH/qe9E7hG7viWKFu1yU+vNrN+25y3RxDulYWjE/DAGZfmg55xkFBUlQ+BOzY9njXKbqrlPi4mY4ds24F0gEXWHCRdh7WTpRmwcigUoAgAY1aMFSU7HfLyMbIkFmEvtoJLcO8cEgprbTKXTRu3W6mkqhzKkCs30BWmnnYHMSDp92KlDponSev90owdjSz1w+9Cn8EVs0QzSCwGsYgFIBu/9/y2g+y4tgKbiDhbxWtrwa5e/qn5dPT3mlPy6k7vungbQQ9/XlYD75/YCsnppQ7AJJ5Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5168.apcprd06.prod.outlook.com (2603:1096:101:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 16:15:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 16:14:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     chao@kernel.org
Cc:     frank.li@vivo.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: export gc_mode in debugfs
Date:   Fri, 14 Apr 2023 00:14:50 +0800
Message-Id: <20230413161450.81272-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <e5dbb307-7337-1f5e-4bfd-b4736616bf57@kernel.org>
References: <e5dbb307-7337-1f5e-4bfd-b4736616bf57@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 58472c20-3ca0-4fbd-b390-08db3c3a3a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwZKZ8sQrXXc2EEH2TxD+bzUv7iOOBBfQXQBYQ3bks6BalW1kKk3xY8QuYpI3IZpHk6O30zuVTH35D7D41SsIJW4GpcPnqqNdIQDOXut9eEpWXvGLeFlPbMeITOjaQ3vO/nj8yirZcOd/oMvB/YR6iv1TCw7o4Utv7IbWfhqIxaatoq8kMli0ada39yLXZu2HBzPTOxTqlN4WULgnQLrh5aCWzaF/GHdyNnDDMuP8hK4xmwlwyVQgFk70HIzyJsbb3u8NCsOFSXV6VhbsrzkaGFfYKegiEkENXFR981BiBbKidOKWYHl7AcWB6f8cxVWb2UbYC0kX5Dpg5i7Wi9PlFcgUJ6nhDaCDMr8WDaZx14IdoZf3hkcPfNjzZ8pJS0azZ+Nej7tK5neRJfH/BfPRi+g3AzsVpJR1J2NLZ12doixzVOVfpSIIiNZr0CHnHJ7dmIfQRWjYzOFpGSsQ1CvgmIh0J+HPsIse+ncRR1hcI7eBdMjJjyVXCUbK+TejCyOMGPUSZVI8IjpZy7nu9L75U9j1gYNE8iLMVgAy34lR6boR0oXCSWklEsvCgVdV2En5MOX6wJdwEMOzPFjLEhvBy8/Zj5Wdtv4I8asasJKwfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(6666004)(52116002)(41300700001)(966005)(6486002)(478600001)(6506007)(316002)(36756003)(26005)(1076003)(6512007)(38100700002)(38350700002)(186003)(2616005)(8936002)(86362001)(4326008)(4744005)(2906002)(5660300002)(8676002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PaVhPdCUbO1VCITtBX4PeyJ34BsQTkmBzd0n262eI2P2kozCMgvc9Uzz/VYF?=
 =?us-ascii?Q?ejtZJ2+BIxgZWUXZx3jnehTbcvcWI5V0Q8kme0oOeQTitpxU9zfZBMQfhVYm?=
 =?us-ascii?Q?mZZ2U0S+YZl11SfQfoK1bU/sGO6Mr3iC9LnIw2a0uvfL7zZh+4AhwOO9W/cQ?=
 =?us-ascii?Q?wQzRjl2CrDvHtCnYtQDONlD5OgdGrE9es6oRTvrAkekQL8dE2Yld3WpIFIXq?=
 =?us-ascii?Q?5ar6F6wTNA1bBSPQDB860rh/ufVSXuCv/5bW2pNCTxG3y+LlgtYEZArxMbIz?=
 =?us-ascii?Q?lNwRah81Y9HgE4nfis7rHKQosFTjnlCrZuy9gFBdtMPyhFhmjOWEwl7cgokp?=
 =?us-ascii?Q?d2DsHPQmnf//t30fPx/gg8DmI1Bw+SwZ4BAJjjw9+PivLnNcGwvhRkZFbM55?=
 =?us-ascii?Q?dV2oySDFAmxTbzAkaEvBR0Yh58HQpgi6hpjzgVf8690bulNvZBXM/uRVpkBQ?=
 =?us-ascii?Q?WrLlToyamIHMzB2bi91jC123qocG2dG4UjJdNBsnaa03MD7VFE3oMTCKhKPX?=
 =?us-ascii?Q?PzxHkhHlZZqJMUYQWO+x/2jWObmoGrYgBKEgXsIjc6ikcFlPELiAV0R0nj1x?=
 =?us-ascii?Q?iCbklk0vrRRGKJ0/OFbNZSqqWpmxRm82WrMWN0/exDNAmi/TSWUnmkuAf/iV?=
 =?us-ascii?Q?LyQT7SVSiu9SBv3Quwaxkma4PgaYeJrgCYiyI+9O6lLiR0npdAVVRjaP5rf9?=
 =?us-ascii?Q?lEDncDobHUxS7rtZ2QKR4wgfpIJmAl/7OV8CGLIlw3dd2hf6KcUbaW0mGo8x?=
 =?us-ascii?Q?9NQJcb7MWI6wusAHJuzz9FAyEEbZup+tU2iDWaUIF6XYjFyxp4ynjDtCp8WI?=
 =?us-ascii?Q?AHAZayy5EMTmg0n9q90QDJIajU8uarjcH4FkvuYrlTUsQjx9IN9oLPHhDHBR?=
 =?us-ascii?Q?+odnl3N7NL1IECFERcfnkNcbxWypnT1hN2vbQnRqUWOhCsCZ5TLCGhKjExaE?=
 =?us-ascii?Q?5XMtB3nJeRgY4cJcFaPYudqYF83pQaWEPsS9GlWUESQTND9LIAKIA8iooAqt?=
 =?us-ascii?Q?42uigUCGoh8dXPoJk9uxYY7bzn8dvZCPikcGJuLFqD+CY9GPhaz9Xo4Hy81c?=
 =?us-ascii?Q?Och/gmm1WqwnAjljRcTPiLAa8Renr1WJiQlEbaoedApi7HHiT3DuyThWnGXC?=
 =?us-ascii?Q?IZURhtJFIXBSTnEXqjvl3bhB5l4Jw0zRVxazt3Stvf9mtL2LIRc9yx0BRdQO?=
 =?us-ascii?Q?ExPJp1dp7pgUW8bBy9iuQGoH1Dw+WEb0Xt+hMMdplipL2tNLm0xabB/JYKrH?=
 =?us-ascii?Q?skb0OIlnt2lRSIR0sVDjDkTWFfuQniDridaK55GXB+5fsxrddd291CEIXycz?=
 =?us-ascii?Q?y19VqjLFDl0zF9UHVj5562CvfqIgC31k9FeS4OMcN7bQyaNLC4DCOEkGSQrP?=
 =?us-ascii?Q?bjdHKrhHd9alKDAFtPxWxUCl2Zm0Pbei4glrSpUJWDID9LvBqWOjHWGfSGIj?=
 =?us-ascii?Q?26Ub758uHRBUnsFrB3d3xlb+1qfL+17jzud5WFb89fhlCf72CbuEXrt4o9Lr?=
 =?us-ascii?Q?ih+mCgvF1sKkQp+ksRfARok1hkSqAMmpiBiT2aci+5K98clz7ffsMztGl/3+?=
 =?us-ascii?Q?gxPhjwY3GjqeVi+HzW9r1u7RnED0fk8i62niIzSU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58472c20-3ca0-4fbd-b390-08db3c3a3a5d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 16:14:59.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAQNala23h8u2cp270Bndx61oA0Bp0FhsFvQTRqalpsX12RkOhHy2BbaCqcSHe31MX7v7rL/gpVI+GZMhNL0YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What if some app/script is using gc_mode....it breaks its use.

Similar words, you said before.

https://lore.kernel.org/lkml/cd6d15e3-b692-d3c1-0f01-33e632f5f94c@kernel.org/

The instructions for these nodes are in the Documentation/ABI/testing/ directory,
not the Documentation/ABI/stable directory.

So, we can still remove unnecessary nodes, right?

Thx,
Yangtao
