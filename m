Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD216821ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAaCMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:12:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB835267
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:12:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaUBGnLwqTTp/Pydb2XPc7qzV1tDDHddsLG9NhfjLS/4p1vE8vVzj0Oj68TCNsEsxUaY/uxEEGPN07BD8ww8lmu+Y3JOoqSzA5kFk5M7PP/TRbzXoFRKgx4OxO0pNMbLT5s+a+fu+onPqsM+YhfOr68jrprFwFyQdRqtSJ5WskZm8Mhp9TRr6rmAMEmWLuyvPIs57dGb521qbn8JlQzAvCgR8XS+5tDGrbDjdgfll8+YJFGbAFcdEBr6efvdr1S/SOl3PyBA0OMqV3YGJXMKIaF4JWjmSLdqPQt06Zy4LOkW+g+34llvOfGgjLDCySwcX3LBnbndSG+Gdfy70HRPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH9DexqY+0NipZuZ8kdrR08rlQULxK5eTmwhb0wBXsk=;
 b=iPbATiQzY9BMMmiWiOn0hrB+hJ9zIiBD/tjwJvZAw9b0SOf1jOvwNibY/X0i5cdqQNrF8Vhk0MOAL+IyrxV4wGHl5Yijyvn7nTEvr0XpeQNHsy9Elf3eD05si8lLfWt6SpYUkLLQErKo4pbPCCiqSUpbDXizmF6V1ZyRB4mIjSj0CeD/sQSblTqdpi8p4nOPkRq9rU+m6qg2kBOt8ePg+yn4lRiZtbRAinPpqC1SDNodP61mOlOihfS6GPNobLmzrlpGg22v7fFjj2dtF1bAfrhU5KD6uG6vg+8MwcWBs1a5gSOusYOW8e7hUt+cgiwnpfKC3A82egws4Dw+cL0M/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH9DexqY+0NipZuZ8kdrR08rlQULxK5eTmwhb0wBXsk=;
 b=hYtAVsvdTmV8r66lTZ/C/GhURrcJ64JWdufgvtay+whpP/8ORDw/YBogwiht4qrhj4SNSKSSApXzp6KmrpZMw7xq/h4+YWpGu/DUr6/rXQNczw7IJhL9saQKag/pnHDsdp0RQYORbhYe9mEe7F4BncoeczDfgARjWBFCTvWnSnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SA2PR10MB4633.namprd10.prod.outlook.com
 (2603:10b6:806:11a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 02:12:07 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2015:3589:3e96:2acd]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2015:3589:3e96:2acd%5]) with mapi id 15.20.6064.019; Tue, 31 Jan 2023
 02:12:07 +0000
Date:   Mon, 30 Jan 2023 18:12:04 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2] regmap: apply reg_base and reg_downshift for
 single register ops
Message-ID: <Y9h49F7QxdTa/deD@euler>
References: <Y9WAPBYaLMsCbQN6@euler>
 <Y9clyVS3tQEHlUhA@makrotopia.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9clyVS3tQEHlUhA@makrotopia.org>
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f32703-d673-43cd-ff4b-08db03308da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNq+3DVKeGScSYoCC+k8L4mNdHp9kmdN8xwvujSf13taqmt5MtJBHlGqsHj80aqn156OxGW3nwmE8nkoj4eN0teV20mLKw9CEYhnzhV1sEGdNYeUSIl9TptCtCnrM2YOKUzDs1aHdW+voTi/ScN089E/lwmtgbkmqtCK/YVwltMfoC2viZ6ltZFt8t3lIsS0ulLDoOA5UGIKb1097DYBOT+0PwLekFZN6rXQym42bbROyG3Ua+/V+oZdOwCXvmoFte0mX7MNI2PLgJP7DvDQeFXp/VePlyM9AJuO85NeDThGOblevNYgFkXq8K+DN3b3HN50iHp4q5TKmqIwTxatWCuvcXvM19iCeVKDJT22TSqpA4eauGMAQ8oHX+/5jLUpxQF5yZfrJWCjCOZ5c5HInjb6aiNJPH2YCQW/lfqRkeuKIKyW5Vg60iHkrSK24qEc/nkA2PzBCp5Dp9ZxMY+pySm7tvjcBG2h4NWcMy3Q4vKP+kep+iOah5DbTPIZUBtyvM49Zeaby4pZj/CL4EcwzFMmkoAVRqHUJdiV3WthlmSafN7nGHL6evmct0P9gCSjAJQbcv44byBFBmwgRPgof0KaYL8IyeBQzmwpvTmXwcs376zK47gd+ixaWK0FVE44Tu/orfRMwyOoFj6aRFVaYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(346002)(396003)(366004)(39830400003)(451199018)(6512007)(9686003)(66899018)(186003)(6486002)(26005)(6506007)(2906002)(38100700002)(44832011)(6666004)(5660300002)(4326008)(33716001)(6916009)(66476007)(66556008)(66946007)(8676002)(54906003)(478600001)(41300700001)(316002)(86362001)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZP9VnfY/UKo+Q0tiWhtSbZjcFpx3eRbFXKh+C3NqngLAfcHGJcwwaCO0NE1?=
 =?us-ascii?Q?VkDvjjuXJvaeljin3fE9tTAQ9dR3d434idN99z1GoAb592jEdEURXndGJZbc?=
 =?us-ascii?Q?uMum80/J6G+PFdvtHQ8uInzSgjKMKFDpEulyjb3wugWXmC983n6973CzFTZ/?=
 =?us-ascii?Q?Nt2RNYrgkuwwqi+GksRVoha5xfK0yOflpwhSraqZuxNrGe6AD2DeuF5TWwpk?=
 =?us-ascii?Q?qheH5fy9+CnDYfLlJzdQt1qsBuj8QlNTbuPp2hcsu+QPT2AS/IabKk3c+2JH?=
 =?us-ascii?Q?KPajRV+Al6rANItBfxT4D7NQDUstE22SbkiGzAly2/8+dQ+ExdtLYPm/K6YB?=
 =?us-ascii?Q?fIcdoJHfC+/0L2BdeMmMdmfg9CIAIEuk2q0p41H/bUcPv+jpS9vTy0Z+9t//?=
 =?us-ascii?Q?dKyx7xGWs5nMIu4e8BDuLkw9khktcjBEiMkwI72O7lwBOqR291H+8CBIDrC7?=
 =?us-ascii?Q?7qPl6YKIKPN27xXXLkBkhDLSjHPVScOO2qFj2JohLEV7B/zbSz1/JnYxeOQ2?=
 =?us-ascii?Q?FyiRHnvEsLZD+pVOryD9dMPvNsUDSwxwLbxy3VAnnRzrzrITog4EwH/9C95m?=
 =?us-ascii?Q?R183zLLalGGAtq0dRoDofVmUx4sgy+E6iTnZaoVkD0Dbun3nVYqWO4A1tuOs?=
 =?us-ascii?Q?GZN1iHIFblct+pAP9erC1SPDfHdNiwtdNBTrj8SPfkgSrty10xEKU9oiGhVE?=
 =?us-ascii?Q?9Xo1c61Yvl5lBmTvz//uy/Xc3Nu5TLvDLSFazYR1BMKyvcF52oAvGsJCI4Ln?=
 =?us-ascii?Q?BrDtNTkK6lK9TKlEBdeIYThpf4lr0dDXKRnxZ65Mdj6pOua0VNnbJPd1sIe7?=
 =?us-ascii?Q?1di3cwo7yTTz8n6++galUTufyiq2cpKgWSmMSz+XYH5nNjKze9A2FIPliPt+?=
 =?us-ascii?Q?7pjUUN1DdSAONNuOlcge8W5r4RqzwdVYRYp/JnORukJpYYPgTZ6XbbQIvaVo?=
 =?us-ascii?Q?nc0aMHcS+Ym3D4Oxm8vHKijT46VX9mRMMJee/P2LcAvh9JyY60Z124cBfid9?=
 =?us-ascii?Q?RK6fb6vmdZ1SNFm7fWl/dPAxk7yZW5W5hSWwbyUd9H6lbXKvO/uzr4gAKvoH?=
 =?us-ascii?Q?QMaH9Bkayee7ROcRqvw4lQ2E9lNDcx176Jhha2Clvl3pxiDIR0HAMnn2rq1T?=
 =?us-ascii?Q?wLs4JXh4R9lMH9nheUYz4WBaHQA/HedXfDVYqAqmlJl7lUsLIoK/X2rfWM48?=
 =?us-ascii?Q?IPD8vaSgZ4m2Qf6kBuRtLrJHPxZlwPDRfMJ4v0Cj4XhpjLIRBHClrkrCJ2wB?=
 =?us-ascii?Q?8K3nZ+sYvuq5z6cAUP74nB0CrNwm46oJbzAktn86UZ2Xon9rERFbgepo+lV8?=
 =?us-ascii?Q?ALDbGqCJ2dx+WxW9MYZar/+09EeWwvy6AB4JnX076VWGDiGvIAMnRx72X7EA?=
 =?us-ascii?Q?lx2qiDgle85cDE3SPSEGDmGdqsKfFq88UwJ7kaplRU0KzCaCXxgb7SzC1HO5?=
 =?us-ascii?Q?OburYyVzHDQTTVrJHqjsVtdjFi0njzldbtoBzc8UmJFRa71HVoYJjrppvDmd?=
 =?us-ascii?Q?uxKhfoUbsfFiPQjxcGw9Av9YOe5Wwf2lGo8BX09ikqnyXprxoTlMXD6AtJtj?=
 =?us-ascii?Q?n9fJ93jTpub5C3I+AEJXC20NTXAlwzt76qJ1B3iBQlnSwtdYM/vUlr5PKwbp?=
 =?us-ascii?Q?0Zfg/20bFFoRWTs+3kQARU0=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f32703-d673-43cd-ff4b-08db03308da4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 02:12:07.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9BvC3mOeC3Mm/9Z4fi8P0TNDfrZLCS04OCp/6nO4fKHjswRQUwOBvDqTau2Ajy6jrrnfqT/LoWwSBF92QqPoCCcGhWRU7BZ85acQkRklos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jan 30, 2023 at 02:04:57AM +0000, Daniel Golle wrote:
> reg_base and reg_downshift currently don't have any effect if used with
> a regmap_bus or regmap_config which only offers single register
> operations (ie. reg_read, reg_write and optionally reg_update_bits).
> 
> Fix that and take them into account also for regmap_bus with only
> reg_read and read_write operations by applying reg_base and
> reg_downshift in _regmap_bus_reg_write, _regmap_bus_reg_read.
> 
> Also apply reg_base and reg_downshift in _regmap_update_bits, but only
> in case the operation is carried out with a reg_update_bits call
> defined in either regmap_bus or regmap_config.
> 
> Fixes: 0074f3f2b1e43d ("regmap: allow a defined reg_base to be added to every address")
> Fixes: 86fc59ef818beb ("regmap: add configurable downshift for addresses")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> I hope that I didn't miss anything there...
> 
> @Colin Please let me know if this breaks anything with your ocelot_spi
> use-case.

I see we're working on similar things! (DSA hardware, that is)

This patch works for me. I don't konw if there's any value in
back-porting it to affected kernels, as ocelot_spi is the only user as
far as I can tell. (wishing I called it something more greppable than
'reg_base')

Tested-by: Colin Foster <colin.foster@in-advantage.com>

> 
>  drivers/base/regmap/regmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index d12d669157f24..d2a54eb0efd9b 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1942,6 +1942,8 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
>  {
>  	struct regmap *map = context;
>  
> +	reg += map->reg_base;
> +	reg >>= map->format.reg_downshift;
>  	return map->bus->reg_write(map->bus_context, reg, val);
>  }
>  
> @@ -2840,6 +2842,8 @@ static int _regmap_bus_reg_read(void *context, unsigned int reg,
>  {
>  	struct regmap *map = context;
>  
> +	reg += map->reg_base;
> +	reg >>= map->format.reg_downshift;
>  	return map->bus->reg_read(map->bus_context, reg, val);
>  }
>  
> @@ -3231,6 +3235,8 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
>  		*change = false;
>  
>  	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> +		reg += map->reg_base;
> +		reg >>= map->format.reg_downshift;
>  		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
>  		if (ret == 0 && change)
>  			*change = true;
> -- 
> 2.39.1
> 
