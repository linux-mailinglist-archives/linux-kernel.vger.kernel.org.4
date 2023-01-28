Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16667FAB9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjA1UHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjA1UHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:07:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D928D06
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF4KFAr0x1fzMJvIM6uXulruvmEbDzGDld78ufcUvyR0otl6WB4wvMSrK2y4/Abvc/8LkbCqHvo5PNyQZ72e76IsfyxxRrWdOCKs0TA+Azh+Eya8kmwocj/wl4a7qipWyyFEOOlFBEMScsldNmRj+FdWEnZIZ2LiLDxmSBf2O0E7X4qZu49e5R3n+Yt4Ormaao1AqxUa3YfFRPfPFi8optljGiK3lJIhOKpWEi3Orryj8jPZAfwe0VNE4bpawapK+1qURnWrLJLp2bdljsofNfUmXrVKn4ta2VUdBa7TNv3dv89a0sOKZGLiX5fTDhtk1CaMEuITzjE2zWl2SGktNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+3ruW8vpwdyeqJKNCZpi8TAdmmQlUzrL0vNmY8C1xI=;
 b=lCEGah068quz6r8PB9U0ArlRgVZ4YEKJbxDkT2bi9BjoUYvVMNJN+7buqok7HUBvwxsA68zbJjs8jcE/K6iJMjHYigecTu6FFKYC1DpFPNRp+jebViE/86lFGjHxTdhgMFD5ax7gPx5cTOH40HmTXO9WGXX3GIMDECvXZZPZcqM2m9Q91wZ3FtZDMJmkXifceOs/zYlJ9KFZ69Ifr3jQ2QltifEBf4w1gKOS1fn7CKmtinAP5oYGc7xyBNyyI12RXbqicyjfIlqmR42p+Yr8NF2ouNHmvT2prU2X5OWqSPMtN3/Zzatje2YgT1dka0/Ng2foQzbmXcyqGGgO0vkVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+3ruW8vpwdyeqJKNCZpi8TAdmmQlUzrL0vNmY8C1xI=;
 b=YjqLOnIRYFxNY/Z0HwgUuwFZYGVyl8V7fhjWwb9Bs3bs5aeguJNbAHqbDr638uT/X9cSKMtNVf4OQoCqW9j9fMzX3AWmvB/d+VFuoAvASbzh5qknvYFVNuGhqBTjWtxLU3vjwbJiBf06U71LVZWD1vXz020RkIh6IE/pd2zzXt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MN6PR10MB7492.namprd10.prod.outlook.com
 (2603:10b6:208:471::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.13; Sat, 28 Jan
 2023 20:06:24 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2015:3589:3e96:2acd]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2015:3589:3e96:2acd%5]) with mapi id 15.20.6064.013; Sat, 28 Jan 2023
 20:06:24 +0000
Date:   Sat, 28 Jan 2023 12:06:20 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: apply reg_base and reg_downshift for single
 register ops
Message-ID: <Y9WAPBYaLMsCbQN6@euler>
References: <5355a99496d764a7918f0eaf801fab7c9a3f5a98.1674875341.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5355a99496d764a7918f0eaf801fab7c9a3f5a98.1674875341.git.daniel@makrotopia.org>
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 48678ef6-776b-434e-870e-08db016b216e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUL+IMJ2U6CZpH8sVMVDWbfLmGxZOLYtH5EIbfNyMcm8RzNOqkLf46K2VY4WvxZrrhKNHl/xr0wio4wI4M26Y85+lgufdb8eh75i9uT2XQLg/n8qOz9aG9zlgyFa5tbuxRHBAVYBNAyvu30r/xW+XffaEpIsBXNzRXOhN6tQttvcbQyKZsNtUGDYvyNyekB+yTYiMjkR1BVMB36XtgJPU4Wu7sP7KKO554F/cSUZ6PnObgYp5r2vrPtzPEK4oLIG1tWKnMFQNye1rl02W2gI0ZWdOHOU0Ww+E6OsoAxEfsS1sYgwH20cVttVSqmJAhYH6INtH/0NjxZd20YPDe/I+eQwmMiSSV3poFla3Ye8CboGfwrPma5rN0YjN0PFMJgRhgIq3WR0iQLEJ2lL08JZD+yU/E5p2+38CGbVu2DPEWmCJzUfszKmYtyC9BwrRuKUjTiyVA1c1lTi1l8P8kF4DFmaxAODDotJj1oEZ3/8GYKNDxQl5wxsoTbOyHTBXOIde8uAx5S/fkdvukvePV/qc5w4P+srR4Z6eDAWjZsf+JBGGsIUUmLc3NED6O+pRh5unl8UlNR+W0dL5TNFBaWzI5Bj8xHf3AaRglTCvwqOdLeXvSlHXEZ0ygOYQ+oNtbq//Z4OR/2Edn0s2s1RrSa/oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(39830400003)(346002)(396003)(366004)(451199018)(33716001)(2906002)(86362001)(26005)(4326008)(6916009)(9686003)(6512007)(66476007)(8676002)(186003)(66556008)(66946007)(6666004)(316002)(54906003)(38100700002)(478600001)(6506007)(44832011)(5660300002)(6486002)(41300700001)(8936002)(83380400001)(66899018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5R91Xvu98xF8E+EHkpvyhob3M/z3TzfvKehuW1+U0U1v7SYMSbcIQ4TtIVZH?=
 =?us-ascii?Q?tKz1031OepeIheHEpEGe183nlJRP3WCNZGitpVCQpd1LGfFaeIpE/XN9YMoC?=
 =?us-ascii?Q?AsyndutwmAF0PLk7UZSwRi0MQYKygEOYUBm+P5fmqd4IGMWRVF335SDoYs/6?=
 =?us-ascii?Q?GQwNF1k/YHhHAgDR36geFMReF/cZQxvxV7Yq6i2G/ntUw8Ov3NRIhl/WKo7g?=
 =?us-ascii?Q?YWOm29P5kbpvrFZVo2ZM+c2AoLH5BnZAY2+VgTdQp7t3roB2ggb+Kss6xpCE?=
 =?us-ascii?Q?4hrl+rColAeEWMqQHGsb/4oomtHbsx/VwWhQ7S90P3jT0lu4hVampYbIKy4G?=
 =?us-ascii?Q?W+ivrR/1GvujYxsAsipAxuD2zLPt2N4b0EmT7l8d4w8vx2UkXZNRFY/yHCkz?=
 =?us-ascii?Q?xAls2MWCo9lcOorlCcyqeNi3M7+iRhd3MVwCtCwkSEITv3qoPL0p4I9Ia+Rs?=
 =?us-ascii?Q?2Cjd1ACXY+eKH9nYq4gzPY0fUnTtIZ4mKLYx8HCgbT4uhygna0d55v5pjIf8?=
 =?us-ascii?Q?6G3gDtFG2sbyeXaUVJY5pN1Q6X6XMCrcR8Zs67dj4eoDYi1NQkTf8QUf/LjI?=
 =?us-ascii?Q?hv2hcGZTAVPUIXZ3r5TXAy7ZKhjhNGPhpf9Uc+mPtUOCSrwzVKTB+kQwZEnk?=
 =?us-ascii?Q?Uq3yczqdfRiQfVMYhLmxE0/TEXe9OBj7x8M/D+T/5b36Pn+anu0ox2618VHV?=
 =?us-ascii?Q?U3+AysRjuakU7YuGBeem2QgAtlgJAnarekmyU7nU23ZcehKfZyv5t0Rilnx/?=
 =?us-ascii?Q?wrvVY+f4OenHDqtMXyoRo9pBYqigCc/Ljcm9uxiQSJFTrb04L66KTGL75wG0?=
 =?us-ascii?Q?+Q5QJiTn1cVmhcCi3jTxs++H3MQ4Z02G9jOdWs5uT6MEqbFSoBOU5mB510+w?=
 =?us-ascii?Q?Rg7c249+sWM5bwBJqPoZrKoUGP4Od2lpXpG+VgbZZgaDgLCwbQW0M2nBeop1?=
 =?us-ascii?Q?Fdr4NwhwhCo4XRT3lcP+fM6AjrCjFRXyRwimvq4OfYxnuQvIVUzQjtpDBlZA?=
 =?us-ascii?Q?xpM+Vu/XSOqBFbNKpkU9+jXM0RShl9PPDO3hvee6JdJPKDehYp+izVYbMj8f?=
 =?us-ascii?Q?+ehrr9F+wrGLwNoRs5l+8t4uI/tMNW5bJv5N3FeSq5BO/qPt8cRWQiwgD6UB?=
 =?us-ascii?Q?KupgyYA21shC6Xe1joZKh8UXxQKGN6PdAcg5dPv9Cvg+96C0QjO4U1MKcniz?=
 =?us-ascii?Q?L3uXGO0BeBqMSN/xjr6oAaCMfWB5mGFf14f2SmS3KonJz9Omo5xEmx7qgjid?=
 =?us-ascii?Q?GST6AFv9x4yOi3uJ8fLL1AGsgCC+JdTGCPr8npKJGKc0Gy7N/+dEzyGJsXb4?=
 =?us-ascii?Q?sjhombVcMW3WzqOMKrqfj63B4dw2fLVTKZBFulHMFVPZ9RuKUbFC5dfxhpGi?=
 =?us-ascii?Q?OCrrQyEweS1h0cK6f6/VlNjsCsCKUftXcQIV5o1z8MXVjN7Z/SzC4VqVpDNY?=
 =?us-ascii?Q?Q18tiiGmTKIuyyGvw9uR0tkvn2aeX33bi3PJNcSAIgMeo4T01RG2xEJrMQYl?=
 =?us-ascii?Q?pUdpSTToXUS8EdnAizE0izAUr4DMXVNMn8vYxezR2u7mkblNEZ8Ltb2wxS0F?=
 =?us-ascii?Q?2tVAXHfoT+PGlH03ahuAoWs11yzdmw0vdn6+rFPZ/Ad9MI869XFWyaKuWv5o?=
 =?us-ascii?Q?AB/zNKUf+L0t3vK4k5nsNz4=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48678ef6-776b-434e-870e-08db016b216e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 20:06:23.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4XAd4w33KkY6d3lPbjGl8ceTQJhX6tNhCv33t9mXZqbiQ1dJsFMcGETkQYuNBG2S9ZValaLJqrbKXKcmgwiWkWpfz1WkMZX1HJETrxDYWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sat, Jan 28, 2023 at 03:10:01AM +0000, Daniel Golle wrote:
> reg_base and reg_downshift currently don't have any effect if used with
> simple single register operations.
> 
> Fix that by taking them into account also for _reg_read, _reg_write and
> _reg_update_bits (they may still be missing also in other place, eg.
> page selection code).
> 
> Fixes: 0074f3f2b1e43d ("regmap: allow a defined reg_base to be added to every address")
> Fixes: 86fc59ef818beb ("regmap: add configurable downshift for addresses")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/base/regmap/regmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index d12d669157f24..7b8386ec21b8c 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1986,6 +1986,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
>  		}
>  	}
>  
> +	reg += map->reg_base;
> +	reg >>= map->format.reg_downshift;
>  	ret = map->reg_write(context, reg, val);
>  	if (ret == 0) {
>  		if (regmap_should_log(map))
> @@ -2879,6 +2881,8 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
>  	if (!regmap_readable(map, reg))
>  		return -EIO;
>  
> +	reg += map->reg_base;
> +	reg >>= map->format.reg_downshift;

Something more subtle is going on.

Here's a stack dump from a write and a read:

[    3.238249]  dump_backtrace from show_stack+0x20/0x24
[    3.243349]  r7:c3a27c00 r6:00000000 r5:c17aa2d8 r4:60000113
[    3.249034]  show_stack from dump_stack_lvl+0x60/0x78
[    3.254121]  dump_stack_lvl from dump_stack+0x18/0x1c
[    3.259208]  r7:c3a27c00 r6:c3a5a400 r5:00000007 r4:c1e64d5c
[    3.264892]  dump_stack from ocelot_spi_regmap_bus_write+0x9c/0xa8
[    3.271113]  ocelot_spi_regmap_bus_write from _regmap_raw_write_impl+0x60c/0x8b8
[    3.278555]  r7:00000000 r6:c3a5a403 r5:c1dfe160 r4:c3a1ba00
[    3.284239]  _regmap_raw_write_impl from _regmap_bus_raw_write+0x7c/0xa0
[    3.290982]  r10:df9bd164 r9:df9bd164 r8:c3a1ba00 r7:00000000 r6:00000000 r5:00000000
[    3.298847]  r4:c3a1ba00
[    3.301391]  _regmap_bus_raw_write from _regmap_write+0x64/0x174
[    3.307448]  r6:00000000 r5:00000000 r4:c3a1ba00
[    3.312085]  _regmap_write from regmap_write+0x4c/0x6c
[    3.317263]  r9:df9bd164 r8:c1d9e1e0 r7:00000000 r6:00000000 r5:00000000 r4:c3a1ba00
[    3.325040]  regmap_write from ocelot_spi_initialize+0x44/0xc0
[    3.330910]  r7:00000000 r6:c1da1904 r5:c3a58d40 r4:c3a58d40
[    3.336595]  ocelot_spi_initialize from ocelot_spi_probe+0x9c/0x178


[    3.753685]  dump_backtrace from show_stack+0x20/0x24
[    3.758777]  r7:00000004 r6:00000000 r5:c17aa2d8 r4:60000113
[    3.764462]  show_stack from dump_stack_lvl+0x60/0x78
[    3.769547]  dump_stack_lvl from dump_stack+0x18/0x1c
[    3.774633]  r7:00000004 r6:c3a5a403 r5:c1e64d5c r4:c3a27c00
[    3.780317]  dump_stack from ocelot_spi_regmap_bus_read+0x144/0x150
[    3.786623]  ocelot_spi_regmap_bus_read from _regmap_raw_read+0x114/0x2d4
[    3.793455]  r9:df9bd164 r8:c1dfe160 r7:c3a5a403 r6:00000004 r5:c3a1ba00 r4:c0a84140
[    3.801232]  _regmap_raw_read from _regmap_bus_read+0x54/0x80
[    3.807016]  r10:df9bd164 r9:df9bd164 r8:c1d9e1e0 r7:e0055ab8 r6:c3a5a403 r5:00000004
[    3.814881]  r4:c3a1ba00
[    3.817425]  _regmap_bus_read from _regmap_read+0x70/0x190
[    3.822952]  r7:e0055ab8 r6:c3a1ba00 r5:00000004 r4:c3a1ba00
[    3.828635]  _regmap_read from regmap_read+0x4c/0x6c
[    3.833642]  r10:df9bd164 r9:df9bd164 r8:c1d9e1e0 r7:00000000 r6:e0055ab8 r5:00000004
[    3.841508]  r4:c3a1ba00 r3:c21fc700
[    3.845098]  regmap_read from ocelot_spi_initialize+0xa0/0xc0
[    3.850886]  r7:00000000 r6:c1da1904 r5:c3a58d40 r4:00000001
[    3.856570]  ocelot_spi_initialize from ocelot_spi_probe+0x9c/0x178


So applying this in both _regmap_write and _regmap_raw_write_impl cause
the operations to happen twice. Similarly with _regmap_read and
_regmap_raw_read.

Rewinding my brain back a year - I also didn't want to tamper with the
reg value before any cache checks. Those operations are at the very end
of the processing chain. In my scenario, I'm getting a 4-byte register
at address 0x4. The fact that it needs to go out a SPI bus as 0x1
shouldn't change any other logic in the system.

And my other _main_ motivation was to use bus reads, so that bulk
transfers were possible. My initial implementations didn't use the bus
interface, so I did all address manipulation in my custom read / write
functions. Bulk transfers offered an order of magnitude improvement in
access time.


Perhaps there is some confusion due to my field description in
include/linux/regmap.h, and it should reference "any bus operation"? Or
something similar...


>  	ret = map->reg_read(context, reg, val);
>  	if (ret == 0) {
>  		if (regmap_should_log(map))
> @@ -3231,6 +3235,8 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
>  		*change = false;
>  
>  	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> +		reg += map->reg_base;
> +		reg >>= map->format.reg_downshift;
>  		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
>  		if (ret == 0 && change)
>  			*change = true;
> 
> base-commit: e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
> -- 
> 2.39.1
> 

Colin Foster
