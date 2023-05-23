Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C770D14A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjEWCdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEWCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:33:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6FCA;
        Mon, 22 May 2023 19:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9htZlAoh7MLm+85R8YdIo6470JLJkHfhSdjt8Q1GjmmHMKj3aX3oQ9ZvaH88QR3axc4UL97VU0Imj008VNKYHf7uBcC3vaXc3m2Tyc7EeKsutYqHDkwEQJg2We4i8Wp+/SlhO/HQdEWiUrHLaIJ8xiiWp8Nes0WS5rgo+qY7ApizHj35K1gxNJJf4pNE8kEtFYSQ1D5PFRnmSmJX9eUg3/jrBVwSTGT4VHYNJ+ofQscvwm6/Gp4ONP9GrZ3N8t1jnCB+QCposYD1nVtwZoHlAs/uUhlVZUTTUbzHo+e6ck/ekJySi7tiuWXTIaHvSuK6VvZKC3fHyZlqvglWybkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z9sI8pfuGx64iFmddmpaBSGeeTHDoRVuoHuNf74YC8=;
 b=QjU6vtd0mreqlVp6v/cnCUmq8V1ttfjhfn0iBmYCyKwlpudZnT9rN6XwpkcoRwPXZy7yeW2H3ttyGE6ucqfrOrk1StEUrILjFVUiRoGgQ+8c4hpkXIfA+rhm1T0qssE6KsOKoAF9LlCzqwe92NNpvw4/e/NL5ryjdOUB6oaD6c/4PbM5AnF5Co5LunnFzjdqOWpD2F2Wn1H9IcrhUjXUbwzC2bU5z/7pJZo+EJEuQ2Grs2NQzOITOVu0YkfTp9l+37R7bLP00dmYPdnEeVcKNv+/Sogyg8JPvMc77XoM0gQYAN3yKwe9Sl4fnukIGGZarBrDlh8LEyvpMebhUW/Gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z9sI8pfuGx64iFmddmpaBSGeeTHDoRVuoHuNf74YC8=;
 b=Zw3w+e+db7wqAGbKSIJPCHdVVPiY/wTaBzg+ACXvIXKhmRzfnADCenKZ2iuUCMpeXzYWZkvN9NjPinuNzjz3/E26MpecISoU4AMobL7YeLRuCnrfzy284ZwqoKhFYYelwES9nNyAOuIUPFDFqv4NOOXVwUuU7s/l+3RitaTwsas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9705.eurprd04.prod.outlook.com (2603:10a6:102:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 02:33:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 02:33:17 +0000
Message-ID: <02e4e072-a2bb-8455-304d-49552ce9c866@oss.nxp.com>
Date:   Tue, 23 May 2023 10:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230506195325.876871-1-aford173@gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230506195325.876871-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7de897-951d-4c1c-374c-08db5b36108b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wULBfJHPcA+eMVSs+Xq26UMm0ml1hJji8JucuIgPcn3VTzfGrgwvH4OY//7cHcrXZPzbohBoXPYb7E6qC2//FWdiua3Hpv8iQNZH6AYZusTYyMkFne14lLH1IkyPntAS0O5eFsmpP3NYwqGjCmpdwk1kopxDZxRHbYXRitbSBEtVbRtkCm3MPf+hWZVdO+vj7w0n7Z3X/WUKBN0FvYltJz1/H+HV7e0L08/j1zOcKxbXPK88oIMSNEkaxn9m5kiKuLOUR9O1bkiZ4FKmsj4x3IfICm5FppZS2E2Jrqchht0XKUDttKcJ5rTWnQ1jkSJkJUpBDH1OWnAZap7un31mm3/6yvRlrIJ4Xne9LYKOia5KEy0a10e7hJKb+LY7RUY8vBG/Cj+T62secK/bKCR3Q3EfHZm/WrMn+dgmMod0+pLaUj48X3oM3WXu2pU8yeVShQqHhaqNn0sSqrGOfzLD1mjJ+wtJRipNvwEiLvXQetaa4SNrsmKYelXBD32C34qD4M+QXk0JWMWJ6yJ5pzfW2945oIbW7lT91TnGSjl+boWmKh5lzorI5OEQosa0ChqBxpbqdJz48tXLhMimj18ENARa5l6o75Uq+yiRH1qjVzpjpIwLBZFcy+W/imsl/ZnwM91oM5vUvSEGWlY1OILoEQQPqBrETquGgNyiOrNhmZr/X3YNfsWa6Dcx+RZNzxPYtRZrqpYE9vMZsPQIwkeBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(186003)(53546011)(26005)(6512007)(6506007)(7416002)(38100700002)(2906002)(44832011)(2616005)(83380400001)(316002)(6666004)(86362001)(66946007)(66556008)(66476007)(4326008)(41300700001)(6486002)(54906003)(31686004)(478600001)(31696002)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZhbmhSN0d3bVJHSGx2U0hCSmd2TW1tYll6blgyb3Bhc2pVQnEwNWc1dXpU?=
 =?utf-8?B?L2VjdHZvQXlmWW1pQnZaMXphZFZ2SzFEaFY5TW85cXhNSElIc1JmVG9hUjlz?=
 =?utf-8?B?WXBISUtEU0RSMzBEenNiR3lCcTZPcW0rWUY0MGFUeXQ5d1E2MkIrbk1RN1ll?=
 =?utf-8?B?aEVwZi83cmdYVWVYb2M3M0RLZEpkSUZIMWJZRkhUOEFqQzcvdTNBTm9rTXNl?=
 =?utf-8?B?dkZNdWI3WkwxT1NxYXhLaDRDbkJqeGlEVTY3Y1hjZUFlN1AvOWlONHFGaWR0?=
 =?utf-8?B?dVR1dy83WVNEaHVvVjVMTWdGUXJpcmQzUFZ6OEhQcWkzZWtGU1BZS2RaRDdT?=
 =?utf-8?B?R1FTNXhRRWVwQWM0R1Y2K2F3Y3hrTER1YVJRTVBtQ2NxbThkOTRNcGlQUjBO?=
 =?utf-8?B?OHZEVTVJWFZtbHhtWnB2K1I4QlY2N2RhNVY0cjFqaHdFNE5GQXIxa2ZxNkh6?=
 =?utf-8?B?NnFkNVl2YndPakVJV1d6YmJxRlRQWndZTytlS2dSL08vc2ZzK2Yzc1QwN1M2?=
 =?utf-8?B?SlFsOHlDWG1hc2c5aEdlajMrOVR4TFdTejNqaDlJRE1BZldScEljbFV4d2Uy?=
 =?utf-8?B?MWZ4SjdYSUhoQ2VMdTJ3V0prVWgySVVHa0t4NUF1d0lUUXNnYXZ2VFArdFFW?=
 =?utf-8?B?R1p0SnFvOER4L2taSk50N3dzeFk5RUcrdjVGWjc1SFlhclVJcnBubWhlUzNB?=
 =?utf-8?B?cVV3a0thRCtsdFpVMUxpT1dqcnhVSWUvV1ltNzNweXhmL0MzdWVzZW5OeVBV?=
 =?utf-8?B?YUdxUXdyRXFIaUZpbTVraUp1Slk1LzA0ZWJiaGVDTUcwZWxLSllYaUtRVnhF?=
 =?utf-8?B?MnA0QTZvTVlCeUtRRnp2M01iUzhrcFFhcEw0NHRuL0xrUjFDdkJSVkpjeTJI?=
 =?utf-8?B?V1Q5NmFTM3hSZjhiclRvdjlEbXFmL29pQk05UjhZNkZiNElkVXh3M1lWRWVp?=
 =?utf-8?B?N2ZrQW9sSDc0WWF0ZDU5TUp2WnB1SVdXT0JQTWxGRHZRQVFaZTJqQWlaeW83?=
 =?utf-8?B?MXVPQytCZ2d5S1JiN1RJbnRrOVM1akx1cWk4L2VqZXhJM0FPQmZvQ2RJRTlX?=
 =?utf-8?B?NG9Pc2FGMFlqVmZPN1NSNlRPT0J2ZlNPR3FwRnBLeityYjhuZUI0N3NTNks4?=
 =?utf-8?B?TFN2MjJiOGdWbGEzVEcxeVRtNXNzMGVhZHNzdnNtU3dXMmFIMkxjL1RWb01w?=
 =?utf-8?B?bjB2WnROQWlJZUd4V25XeFN4aTZUN0V6SWI1ZDNNRTZvRi9LZ0twbmZLakxi?=
 =?utf-8?B?MHhRS3AyVU95UjcwVlhIUUhyVVl2QUx1WlJ2SjgyRlRSUnM1bEhVbmY2YlBr?=
 =?utf-8?B?amdycmwyWXZGcnR4T1c2eDRPOFpnWkFhNkdubzllQTRoQWtpWXJRVlNoZDR1?=
 =?utf-8?B?ZDV0WXY5aG5WWjJUZ0MvcTM2WGNxa2E4OXVRY01wcmRUdXhidUxhOVdLeFlq?=
 =?utf-8?B?ZGMwMWZrVnFqOHM1c044S3RnaG13eGppa3BHK1NyeXJUR3VDTGtaUGJpR25Z?=
 =?utf-8?B?ZDFKbGRqeVNLMU40bmROU0tXNmtLNm9ubDZ4SVRVZHpKVENBOTVVa0xNaTlt?=
 =?utf-8?B?Z3NiMkFhRGYvZ2VGcTN4UnJLZnh6VkxsUmYyb21kS1lYRnVKMkJQbGpPVTB2?=
 =?utf-8?B?ZStXVmtTOE5jUkxtbUQ4Z3RJYU40NHJESWVaSk5UczdvbGpYWHkwc0t4MDN5?=
 =?utf-8?B?NkE4eFVkMmZYL0dCUldtRlVPUzdTeEFxQWdsREpYUjRrNEg3dkRQTmRiUDlO?=
 =?utf-8?B?amJjc244YVFJbnVRS0I4QWhkK0p5ejJzemREL3I3VGQ5bXBWUWFZOEZlbnJL?=
 =?utf-8?B?YVJGOTlEdHhqeFo4eklqM0RrMlNucmk3TkgvRXE5N3hvNWdwZFpWZTV2Y0Va?=
 =?utf-8?B?ZXIxbWhpVGxLVVFBOGN3VGE1YXJ2V3d6VGNqYVR5dE5MMDZWZ281TFZsSUxz?=
 =?utf-8?B?cHd0Nlg0SFNiTGlvSTBpSi91aW9TWGQ1NTlCb1I4a0tOKytZcXBJMGlOdzlz?=
 =?utf-8?B?ZEdjM2lYSVByRmJwbVN5c0t1RjBCNEV4d05ONldIOG0vOHlDR1VXYmJjdWZN?=
 =?utf-8?B?d2ZLSEdnZlA5Szhjcnhqb2FEUnlOVTcveUNGRTZDSS9lR3pTQk9XN0VGRHZO?=
 =?utf-8?Q?hhfHantg0UmO/xjtIUENTDG30?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7de897-951d-4c1c-374c-08db5b36108b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:33:17.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbtw+7GjyDc0nYLN6ZWR0B6UOSw+U7XPzEzRm6z4tfMFLLiS/FySP37OBXM/0VTj8wlAS50HdwtOoTMLXpNPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9705
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2023 3:53 AM, Adam Ford wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Currently, certain clocks are derrived as a divider from their
> parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> is set, the parent clock is not properly set which can lead
> to some relatively inaccurate clock values.
> 
> Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> cannot rely on calling a standard determine_rate function,
> because the 8m composite clocks have a pre-divider and
> post-divider. Because of this, a custom determine_rate
> function is necessary to determine the maximum clock
> division which is equivalent to pre-divider * the
> post-divider.
> 
> With this added, the system can attempt to adjust the parent rate
> when the proper flags are set which can lead to a more precise clock
> value.
> 
> On the imx8mplus, no clock changes are present.
> On the Mini and Nano, this can help achieve more accurate
> lcdif clocks. When trying to get a pixel clock of 31.500MHz
> on an imx8m Nano, the clocks divided the 594MHz down, but
> left the parent rate untouched which caused a calulation error.

Not all clocks has pre/post div both.

If CLK_SET_RATE_PARENT not set, would there be any issues for
other clocks?

Regards,
Peng.

> 
> Before:
> video_pll              594000000
>    video_pll_bypass     594000000
>      video_pll_out      594000000
>        disp_pixel       31263158
>          disp_pixel_clk 31263158
> 
> Variance = -236842 Hz
> 
> After this patch:
> video_pll               31500000
>    video_pll_bypass      31500000
>      video_pll_out       31500000
>        disp_pixel        31500000
>          disp_pixel_clk  31500000
> 
> Variance = 0 Hz
> 
> All other clocks rates and parent were the same.
> Similar results on imx8mm were found.
> 
> Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to determine_rate"")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Fix build warning found by build bot and fix prediv_value
>       and div_value because the values stored are the divisor - 1,
>       so we need to add 1 to the values to be correct.
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index cbf0d7955a00..7a6e3ce97133 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
>          return ret;
>   }
> 
> +static int imx8m_divider_determine_rate(struct clk_hw *hw,
> +                                     struct clk_rate_request *req)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       int prediv_value;
> +       int div_value;
> +
> +       /* if read only, just return current value */
> +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> +               u32 val;
> +
> +               val = readl(divider->reg);
> +               prediv_value = val >> divider->shift;
> +               prediv_value &= clk_div_mask(divider->width);
> +               prediv_value++;
> +
> +               div_value = val >> PCG_DIV_SHIFT;
> +               div_value &= clk_div_mask(PCG_DIV_WIDTH);
> +               div_value++;
> +
> +               return divider_ro_determine_rate(hw, req, divider->table,
> +                                                PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
> +                                                divider->flags, prediv_value * div_value);
> +       }
> +
> +       return divider_determine_rate(hw, req, divider->table,
> +                                     PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
> +                                     divider->flags);
> +}
> +
>   static const struct clk_ops imx8m_clk_composite_divider_ops = {
>          .recalc_rate = imx8m_clk_composite_divider_recalc_rate,
>          .round_rate = imx8m_clk_composite_divider_round_rate,
>          .set_rate = imx8m_clk_composite_divider_set_rate,
> +       .determine_rate = imx8m_divider_determine_rate,
>   };
> 
>   static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> --
> 2.39.2
> 
