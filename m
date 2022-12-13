Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9964B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiLMJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiLMJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:21:30 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2107.outbound.protection.outlook.com [40.107.14.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49035B36;
        Tue, 13 Dec 2022 01:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBfLm3BAyBxEMgQ+CvZ0Lz4s4l36WpAm+SO7o/wUlOZo3D5CBJBQ4yjVkpLiJaVQETJ/oFjjgWOsHCAuoX4nI4FCg6f3c5+HejOHv4dcKChJX/uzfOfr2hFGH70JKBi37lU/CypHW3QYRmMkljjEM/SZh8n7XB4VX5AwOUb8L6UygPHtfn9OkKR91NirmT2f2stdfub5CTNBAVrydFmsYj3LxbIKW5GM7Gg9pE6YViLudhOKHZdodvJUnubr/dE1/H+qndJzS4UezBZLs0FpY7dNLWCJCDzwccautiN3dToU0yM0sGSQ/8YRKcFwgu3Qa1KfUu4ZQ4uvZBTHG0pzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCTaLM6MCfX2pEgyCOrFEtdlk0GYa1rnf1/ghNcZQGk=;
 b=fbKUmEfXS36CON+8XqvJPzTf2o4tE1sngnvLQY56+YwWGI7tC73wuWghLeZR3UCLiORHn2mDFhzbPv+4rOFYts15MYPHXugnEE0ZTrdQEhUQsEAsBqn38Vspz+kDWg6zHeZiobygChLpl4prNWYafzMA/TrqSddMViiJW9Z+2B/cP5eQ186fzaL18TzZmWXkiGVKnrY2K3j0LpA+otbEwgIZWIQL5vyqTnvk5LTPSmNpxr6hDXW1GIghML0xwAdWXZgjgQL+HCxv/cx9KMhWpe8hEzu2q2M2I9UVrd+ztTLdTSEat7syrnSGHVjBxBW2Ts3wfCzjjUbQRkrU8aXGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCTaLM6MCfX2pEgyCOrFEtdlk0GYa1rnf1/ghNcZQGk=;
 b=iu09pWXS/9Du+3xQWE8ovIvCQL86YaNvRMUrsnlloJyA3YAzyHIFgKlT0DYIaUPOgjw3zzv9KgcjIoHUIBAMTX4WS+ED0eLvvrw4O9koTn240vB8tHcKdOmLILtg/XWYYaRK7yp6d2nRqg6/Wk2LzhKqlQVdKLBZN3VoUN1u/YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PRAP190MB1764.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:21:25 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:21:25 +0000
Date:   Tue, 13 Dec 2022 11:21:24 +0200
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <CACRpkdZhjrze4q39SPjATESRCQ_RW4XJn1a1SMDy-hApXu9VEg@mail.gmail.com>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
        <20221205105931.410686-4-vadym.kochan@plvision.eu>
        <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
        <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
        <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
        <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
        <CACRpkdZhjrze4q39SPjATESRCQ_RW4XJn1a1SMDy-hApXu9VEg@mail.gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317ECE03D0193614AE849DD95E39@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PRAP190MB1764:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b526dfd-5ddc-4128-0758-08dadceb686f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0NbiTiWvzN6QuVPHibsAzy6Wa9Jda4/1HXAIUS3e4e8LGBGhd/pIotVHVSrGZpxefstqBPVQ2rZpCx4p5mtJnFNqvwM6+5/pjHCfRaPn4adtr5IhswtuxtGuk9eFsXvUSeqbHhIKh+dW3syklfE9uQhzclRfBCKoVWwfUvU63vHhjfp5ifxAMeyyeZDtcI8W4y3bW9MbWIt4OseWC7R1556IkbdGzk5l5MWTtfbSfRr5fehHlR2NLVZK/JYodJtC9LakYtfVhe7VFEhZgUIWn6PtnwUtO/ZDSPRzbvU9/yA4nEmEYhG2bF5MLTVK+obDW4heysMEpv3gTLHBbQ+NKNSeJ92FUj32rN6JDnBZ2O3+6jEJFoNybRC0SqVexFnPorN2mU6UWZqfUB04FvV9YQm1ZISf7i2Po2feYD86zW7B9tr0I/wrh+o5w98YxSVnb9aaNRShpyjI/9TRg2oRQajNtTEerQodoTotiPRmfezEm5MF5VLHiLSC0pvaEWyta56a4+0f3cx2KpX9fmzX5DHFM/YbCAZawn5UAqKriJGIghSatTu3VnlDprBC8o/3++moNHNlXzjEclMsTGMBd6tkhMOmhhWyuK/ZeLJqDG0WKMARGNDw5HtzgAW3Tr221rgoVwRu6S947cCybFIfTGMfYhhUEn6j7xpoBur0cBy/k96IcaJ4oBUvs6s/RtigXStmLQrT5qKybG+eUw2izkgRW0fKLMbCuXijsTAiTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(366004)(39830400003)(451199015)(86362001)(55016003)(966005)(6506007)(33656002)(316002)(9686003)(53546011)(52116002)(110136005)(7696005)(186003)(26005)(478600001)(41300700001)(2906002)(52536014)(8936002)(7416002)(5660300002)(44832011)(38350700002)(66556008)(8676002)(66946007)(4326008)(66476007)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Va5d7nqay0KIQ773vGx5SIMnwdUJmPWyD/t/Kuea+PKd2CG2uOs7kG+qEC2P?=
 =?us-ascii?Q?5KwDyNKYWgsqwT08LjGrzyjDBvsSYSzJ+iVOHLJNhUeCkq2CvTX2SNFIPZa6?=
 =?us-ascii?Q?ZxYpVP2Vx49NLD5meI/asKkRwGPbOAP8n5IPA+Gp2UfHqfPe1v8kSRZdOPj+?=
 =?us-ascii?Q?8m5DTIvpFQy3jMOHjbKwwVuRnultz91cXMSWdh0OxLi+8e7XVd2QBkYjxUlo?=
 =?us-ascii?Q?BxGrgh6sVlbEfxyXTtwOhi2Gx6hQpJRO637IVXToiuCmhDtqI9PTNQaCeX5B?=
 =?us-ascii?Q?ESAJ/TodoeSbBq4B0tLdq6wxYlNiciHcdgOXWd/gq4JuUNQvVXVXZ5ib84hn?=
 =?us-ascii?Q?fX473ryT+FATU0M6+R5HsqFF6Af9TCYL9a39npv2ldmHUCyrHUXsUnc8XmC1?=
 =?us-ascii?Q?3AZ6o2fLPp9Sp/8VaGETbQWCl3qvn3Sgi1ilA97Jjo0Qq58Vy2Aqi5vx4uCR?=
 =?us-ascii?Q?ZfdkgLJIuf2K5JjDcHyp7zT6vqNtWfTgYK16/uEjEOe9ORVG4xYP2nK+WK1Q?=
 =?us-ascii?Q?dHag3W4Rp2dOKV7YZPVMZPDdxo4EGmsync94aXGZShBuTgaBfsxgRFW5N7Mp?=
 =?us-ascii?Q?FOM1/Cwuz/l0sJxB9lW+8sYb0/QVVo+vKALdyn3+eEeJDDiTYqLPjj8yWBkC?=
 =?us-ascii?Q?ZFx55+lhvwtq4AKuO8DSOsqUFRp84VBbDl2tLibtRWYrZkOYXsKT3VjiWV2q?=
 =?us-ascii?Q?IFHXnXOJdIahQ2Nstp1HOt9bGFE8IgdDSBTgfM8/PtSVNCt53csHFKXHBx1d?=
 =?us-ascii?Q?+ryAMR15goso/D4dA9Nr/KeqYjGK3/L7lKwl2DmfJoXtXxiMZ0w5BRio1nBI?=
 =?us-ascii?Q?u8tuHFWqwT9zYtYFOkqHU1DOvsUfCbzwXD7ycuRlenDnjNr9cw5dfx3ZG0I9?=
 =?us-ascii?Q?bvvq98tImxVyidTqovibI1ZTltjN3ezRM/jI9xo3GuHQ8oJHecQfXsFFg8K9?=
 =?us-ascii?Q?MKxtoPRAHXO6O/PNuM3ZyIEkumpo0VmmTGXNvBH/KAZj/xRRVQkjQUX4u2NW?=
 =?us-ascii?Q?7ckPl/c+oK8kM/+S5VnV8cRVtuMOfXS7Dutp4ImGzxz0ntaHdPzJFIVN67Ek?=
 =?us-ascii?Q?dmAsETHfDri/zPzmaSdzptn/yqcIG+2OoSwqRs49QehC2Q3lwiexJ4GKVLph?=
 =?us-ascii?Q?oRgypTk4XBhI9//o6m5hlVOFt379kazZnLiNemDfqIx2vbZCC/Q+0Skn06bB?=
 =?us-ascii?Q?fBflQHO4mzJpxslpKfi9fEQzzZ3gCupx2cvn45qt92GOaPwdjSG232gjU9kn?=
 =?us-ascii?Q?eK6qcfD6b3U2Av8MR66DvQu/cvnMWxNCd/VLCeY6tr9IjjFR/+8phc8Pvndp?=
 =?us-ascii?Q?O3s+XdIt3uJ4XyZHNagbmoWUqtE0QO8Te1bnjWRI6qsJtNUVNENJ23KbsnYn?=
 =?us-ascii?Q?P/MIlqM7U5UZ2S+BpWrijwVw3cxv8tSgwRSL97L5L1c2y8d88ASxHfJYe1SR?=
 =?us-ascii?Q?Y7dXZLxPaJ17KgUf8xa9Jdv+vLZ6jQMrGFGhxAAu4LWWaK2QJ9JsVZNbxgd8?=
 =?us-ascii?Q?Ng+omDB2XzNral4+2U97W0opOlMPWeddaISgH4nvId55ygKg7A1IP0B3F8I7?=
 =?us-ascii?Q?o0pYxr5Z+U/d7c/MV+Eb/f/A0qorsB64gQtu/ByphvKAeAkVDjQKcLTRPZGo?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b526dfd-5ddc-4128-0758-08dadceb686f
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 09:21:25.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjxU3KQI7pz/40Gf4RlCj3BrVDJMSrl/sfGKtl8jsZkYznH83o0KeVWZnpLry/Z9kdaExoXlalQchWzeMLCjfRJgnfI6RaPJzHjnvklFo1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Adrian,

On Tue, 13 Dec 2022 10:16:57 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Dec 12, 2022 at 9:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> > >> Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
> > >> Isn't that also in DMA_BIT_MASK(34)
> > >
> > > Yes, you are right.
> >
> > So it would fail in that case?  Is it possible to use devicetree
> > reserved memory or some such, to set aside 64k for the bounce
> > buffer DMA mapping?
> 
> Yups spot on, reserved-memory can be used along with the kernel
> CONFIG_DMA_CMA to achieve exactly this:
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> kernel/dma/Kconfig
> 
> Yours,
> Linus Walleij

Just in case, here is an old series with reserved-memory solution:
https://lore.kernel.org/lkml/20220806085818.9873-4-vadym.kochan@plvision.eu/T/

But, what about to start with PIO solution (which is conceptually easier solution) with
checking on ram size and then develop better one ?

Thanks,
