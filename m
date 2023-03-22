Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDC6C4FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCVP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:58:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3B3B644
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsYBTqb0Q9PcWXe+Z4YlU5p6NyLko5rIb2okiU599/mLYyt72qJxrq89YEFYDSgI1cpS710SJYwumdEMRuBLIYQlDe/VdPJmG8ZlUz1/elFzbVM660PoZYhYv3LRkCOdGkKtMuL0PIcPpP0O10tU8/Lea/pw/yhzKuhyabWyOBx8Vnfp+hiZ6ZYQuB3gfw7KTQBKoxrrkSgFz0s4BOs2FAtRLk1LvkKxAZkhCwSGTehT8ztPi/oHdJw6IVxEf4gvdjdJtkU5gSAD9rXnhq0rmoBCPyJw0Iphu1MbohhDqLp2PG75nx8o3EtM7yzdZSiL5LhPCwNfz163d5OrGtFykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQvttYhXmCTiCMNh2HYlt4RKFZ33qrQ8NfZl74Ign9Q=;
 b=A4fCuaAuGORctrfBxelXiXcXZRFNlNP0xCXP7Ya6gPZnn7HtmU42yeET5qFigtbppdKxhnoHcjY5ntZdp7Y6OGMlzJOMB/YlgE6a9Ixyv2r8fSMLUrHm+AL6jk8MJy4SRrvuRuAT6vkfZVyc/K+1FzYpsyG6ct67rBDJsOb/k956oVGArv0HLFGCisOa3ovHtHuTnEyq9prersOKUjzqHtqYoYObixPYlMgy2fIs6XNGWpXtnZGzY+UR25+VOAosmHJ2u77i2KZ+xgcDVGR0M/Jf7HWmWI7g98p+SDglmL2tfKFXDdp9rybwhIqwmJqj/kp8dRUMz5FgqoQwnsCB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQvttYhXmCTiCMNh2HYlt4RKFZ33qrQ8NfZl74Ign9Q=;
 b=L5yy5fbtSLmK78CVBrZOARzPcWcgkCXH3IRkr5NUiLTkiNhHRczO7nf0xKjCRGAcpQtqgIINIXSk9YGo8rglC1sA2MQjP0sojYH1mchSpH0lNMgrqiK+Jwi4AGnbKZFW+36iJL4h0459le8cXUCrDavllafYnJHNS7vVNdBSCWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:58:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:58:32 +0000
Date:   Wed, 22 Mar 2023 17:58:29 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 mfd] mfd: ocelot-spi: fix bulk read
Message-ID: <20230322155829.uecwlv23r7plgok4@skbuf>
References: <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322152551.q5sjc62yu3ijp4wj@skbuf>
 <ZBsinMmfbglf2w8W@colin-ia-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsinMmfbglf2w8W@colin-ia-desktop>
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: c2040bc9-67fc-45b4-8d1e-08db2aee48f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0hEJZ0scT8oji4d0dII4sY6dAvf+E8oOFovukWtSyOEQFusgvfk+lnZaLpxEdgggylIf4vF1dM1nQyOfGAdoGShbeRI/juZZYlqipSRJpt+sgOsVvD4Jlk6mskdOxu3lgnjtoXdBZDBnLr5kCvld2YfqURNMGR51zDMAU4b/ob2eOwu9gOYR12Vcc21BSOQT3738PAEs/cVy6Rh7ivp7hvLUy1VlIvxe+nfVbK9Hr1M70fWRjKsnhgs5s82DrPj0oHFT64VtxOwyGbBYnY3fYBzauhI8amCoWEFwzIudhDIzdR8rtM1mfmzkEQM8xJGsmrdO396awqFsK3sqbjmHI5BgjuQ1bVlOCet3FunMnP5UekzuDUMQ5OmE3TucqdjqGCNyYe2przyLwLdoMcVoMPC72tzD4d0saT5cmr0FJv2REfUAoXfnTjAgk41cDZPNctrpIv3ojObo/YjF6lb/vZZdS2WbHJ8uPQc1BxgG2iGCwVu2ZUqeUj+eOjU2A4fXa6D0z5dIO660JXaRwhQ3aQ2whoSdYqG/90YTbOhoQTpDUrb1sI0k0RoftFIjICdXVwQCKgGlqDpnBm2mQ1ddF0Bp4Ltqwd3RHhmvNQYO0dpsEaAA4FkijHR7ykF3hXS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199018)(86362001)(33716001)(38100700002)(316002)(966005)(83380400001)(66556008)(478600001)(66946007)(6916009)(8676002)(4326008)(186003)(26005)(6666004)(6506007)(9686003)(6486002)(1076003)(6512007)(66476007)(8936002)(4744005)(44832011)(2906002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZ4/X4e6HacP81guXrdtvrYYJL9JEbAXty6bNbnvaRUP+2TiFvuVFM5JHq2l?=
 =?us-ascii?Q?h8dcCwrw/WUYS1Vo/EFni1kM4I3S64jqUhIyUBfBYmYb38w/tbhN1KQ/jJhd?=
 =?us-ascii?Q?Vlii9gHLvaoFPdv7U1NtwBYOqnMGRdB+plY+VsVGz+ba5V0PNy9DDM4EF/VM?=
 =?us-ascii?Q?Vxpl26t6+p1g7/Tj6QJ6SNa6PJJsFtOtuncXJhvLnGa+hRgyMP1QR9XpkeDP?=
 =?us-ascii?Q?I2/u0Z/KuyCUSygHpbXoaeNGgFDNRLM4hThBwurNs8LggEOFvgsKvy/2d4nR?=
 =?us-ascii?Q?k90+VoG87EtkbzwP+37sIBh2qYCQRV+Eqtyx4n7yLCxBByyRb6rdwiGUtvnE?=
 =?us-ascii?Q?da6/ORVj0loPKdQEZd+/R7PvR39pgdLfbCmGSaJkL8tgHnawppuVjabrQ8va?=
 =?us-ascii?Q?axuh/ec6KZognu1NRAn811DrUn0eOW/46TvStZ0uYuI+/eYT2xyi2GGS7vhy?=
 =?us-ascii?Q?UlnhnnlIA6PzFwepIjU5/LMa8jN4rtUD1YSCxS2FMGdjXTJ/8mIrRhdiM39o?=
 =?us-ascii?Q?meZ/i8+2tgwU3ldIi/s64zzppKXnsXS806w/RRaOkSVbqtWV041RsOzp71PZ?=
 =?us-ascii?Q?wJjKjV2xb7wooM/7ovU5f7A5GuDcDSboNSHHIJWq7yGSM1wPxv9/VUWxHl8i?=
 =?us-ascii?Q?wRvdl8qBkH299cjhJ4Rc5ytqJ2lhS0XkmXIaiYQaTDEkDYRHGx6GWQXcPAmh?=
 =?us-ascii?Q?QhjWJ0ko1kw4w2f/6rdLTUDHWw+Pz9URrw+b3ItR/2MwXXF1j6D1orsLYDl0?=
 =?us-ascii?Q?wzz0tUJLxmvHTZDpnREqKBlhkb0y62TVPgFzo0Uds5XaWgOo0DyKEhfI1617?=
 =?us-ascii?Q?3jXcXxlce+KzTVuTdT1MWIDM2ZseBh9pI5PULR/Uq0wB9BNWyLzdTwEsc9dm?=
 =?us-ascii?Q?L4TUKoe4qWCuLnVn5eJtQDE5F5FyryQXdKK5rnxm5NQKcxWnzzEtrf4jh7Zw?=
 =?us-ascii?Q?cXLBVCUmSjkn32EPEnzv8QW3U9CFW069OpY9XlJ5lsj+nB2QmIJUhvkMGFac?=
 =?us-ascii?Q?TskVK7NspQwNkVzwtTGVN0dfG2WTiCpzxXKFGOIQXCTD1+R3pqlr+/Iz5+sE?=
 =?us-ascii?Q?Hv6SgyiiTR0NKsN5Jr+CrvU4+xpHHYf5wTXVLwJk/O+IUtklHRaMlx6LVPPT?=
 =?us-ascii?Q?TM5rX4KKWSISTzMkYeJV3rQT5ehUYoCRfBnGKjrSnSod13Tz2ZOeHMitNcL1?=
 =?us-ascii?Q?GUP60n9xvEIk12U0FhDBMJW+XwYWjJrQpHxj/Q9vQ1027UnLyNb3tp08P6yp?=
 =?us-ascii?Q?8ioAIck1mkRpW29v+leOLDJztk8ZYjNjWez55M4AR1WR6uZDH0A+omIqU4jT?=
 =?us-ascii?Q?bqp9arThRWpH8QDfvVFcV9nDPNOaToRU3ugndHMUCdZoyLef4cmQwCmcmxBx?=
 =?us-ascii?Q?tv2go5NyB+W4P6ryBofznLBtIrfpVWidh6uXQ6iI24KR4pLqoo2hicC/ItMw?=
 =?us-ascii?Q?OdHwWQr32mr7A+D4UEE7phA9+oFaj5ZNFvp1DpGt72jSDyawidwSv2IQUHTm?=
 =?us-ascii?Q?MyGPh1o6rbMzBdWCBTwCvYwXFXFb0vTTXWebhKZIulHjWNSHrA4iEu1C/pZw?=
 =?us-ascii?Q?Wz1DuuFIv3/HaEvPK3q7flPYENkhbVBexLHiEqB0SibSR1GGWgzHsqHaN2aI?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2040bc9-67fc-45b4-8d1e-08db2aee48f5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:58:31.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmGrR0DxBBsz498kLvHZPfcx515sDatlh1lvUnPT4iSLDO6KZt4SZfyQK4TYGdkIB4YK8EOdHHCJzG7nOUItQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:45:32AM -0700, Colin Foster wrote:
> The chip itself doesn't support bulk reads. Every register read must be
> "Chip Select \" > "Read+Address Command" > "Padding" > "One Register Value" >
> "Chip Select /"
> 
> Figure 74 of [1] shows "SI Read Timing in Fast Mode", but that is when
> the VSC751X is the SPI controller, not a SPI endpoint. i.e. when the
> VSC751X is reading _from_ an external flash chip. It also has a blurb
> about "After reading address n, the SI boot controller automatically
> continues reading address n+1".
> 
> Figure 63 shows "Read Sequence for One-Byte Padding" which is actually
> done when an external CPU is reading _from_ the VSC751X devices. There
> is no suggestion that address n+1 will be returned in this scenario.
> 
> [1] https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10489.pdf
> 
> I can update the commit message as needed.

I have no further comment. From my perspective, resending the patch is
not needed.
