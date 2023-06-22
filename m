Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2A73A55C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFVPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjFVPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:49:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292510F6;
        Thu, 22 Jun 2023 08:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMfCvgyvAohAvtt6cW/lg3nOnkdhJCLS/XlOFfbpllDqnp7VH8nu0iH/K3tVyP76fbFlqOBkHpkGj7xUs+bYF4Xw9yxj6HwUA38y4mr+3o5U3BQpgvg0kigIZ3Orv6H0x9oQlv6kdvpRqD/p3cQzDZ7PaYE3J03Kz4U2k6tW0jupy0zXJdkhIRQppjIBrKgaQ484I4wdLnLrVELNwSSSwzgopxH2CY3GuCp8YpLaFuWalyc6NcU2Zf9tpVZwV0wQXU+HDkEmSgaZ9RYpEDszQMBZgk2ZNtcr9jIqcm1rX7lLVroIZ2YRZuP0/4DQo7ga5U4xuYcjOgZSuho/+IwN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWdKDYVEKCZHWoP/+3J/dcTN5C3W/0G+68SuB2kBHOw=;
 b=fXC5inIlJTIi4Tg1tjZqLj3wWgUwfDPgc3byxwXuHYfK/FZj7Hl4ZdMUWwZb3WGAub+mUGpQ3mUsiVmlpmDjrFC07hpV2ewr/z2vd6pV92vHb7FIdq/ouSyIYLDoaKSh5CR6avWufVt5RVQJpRfKyP6R5M4zc2B1f6D6d93i0lr588BLFNvP7ND2WBGIHJRX/41l57QF9T79xF1WC40X0HW6EpvzUKHqAzxzuobNosGGAbJa3oR3Vx3ZbKFyZHv2KwvqzoCtVtodx6jNgPrN1vIq/2hX+W2J7/HF2fMwKSG5nmJInu4UP9IAP0zBmBcCbPfZVK5QguBm7Hp9YqQTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWdKDYVEKCZHWoP/+3J/dcTN5C3W/0G+68SuB2kBHOw=;
 b=NoCZGCswxKccznHrFL2+mCx5n9iuT0l8z1wwsCm+FUyPDXc+tC/s7PQwg6qxreA65FDn/+NV8EVqDbEKtVsgwQnIR2y5Qga2mpx3hndeadX9t4QL3XAXkIfK7g0ztyqC26bMjeMGOp2mWmNwkzRWkIGQC5bEtBL/XRSPJRCefoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4974.namprd13.prod.outlook.com (2603:10b6:806:1ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:49:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:49:36 +0000
Date:   Thu, 22 Jun 2023 17:49:30 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 1/3] net: macb: check constant to define and fix __be32
 warnings
Message-ID: <ZJRtinvcu2PAf+Cc@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-2-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622130507.606713-2-ben.dooks@codethink.co.uk>
X-ClientProxiedBy: AM9P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d3fcac-e31b-4f12-f43e-08db733847cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYUEYRN8EBeQTi3QrlXyHIHYmrnteiYEt7xjDRi3t9d8Pod4FVgsqa3y9A7+YR/fxNsY41QjbtvmomohEIIweOJwxSyCaDY0j6lAPfx7577bBfgsFTl+QZxBneaE2mcqoSZOtBqXjfIfPXMy9XMzEQfQtIhvX4sK7Sftmft9ieByqx3RLi1cLsISEyhC+YWKnah7/hLlUYLBdhoCGCoMK0/rD3tX/vE3CVxiOJv3tLj1DG7bXMQudiEReQnFNmJ5xbCPb3+VaAs0pdlMRQ/10zt3ZoxXAfBOfNxM+TBaVwDlYth5xKwyzbuqVvVAPrJBbdJ7C7nw42VYsW/9AJwJyfxH1j47mIDKRprDEpmNV+aTRssQQsW8EU86/j+1UQkhk04dFP8OWuxlm0rHebtL34QEEL1cmoV02xpWumK55yyUhCWxPeJoOT6I7y/0CjR4NMXhLhS71S9juAnnoQVOEfKgwWyC3BPkrVqgukybrzQb3XOvilbEdVcAPL4x+AB4fg6FzIQ6WCPOZD86NfHfJJTVp41qSdvKf8PB2BG75fRs0JjDF6zL+146hcIuRj+mtSxCCq2iG6RzDl5qeVyuD/qvmAtbckTSHXZyLXSzCqs4NKdIUfFJGwSRhJpfPq7FhfW/94Ta+7ORSol4T+gmeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(451199021)(38100700002)(2906002)(44832011)(83380400001)(36756003)(86362001)(6506007)(2616005)(6512007)(186003)(966005)(6666004)(6486002)(478600001)(66946007)(66556008)(66476007)(41300700001)(8676002)(316002)(6916009)(5660300002)(4326008)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbNf+J6QpjttEniiL6uiJJgTiXHC2ni+ysfW6bAnejjPZWDvwZ1nPRGp95Dk?=
 =?us-ascii?Q?5OnIQainE4NU3jMb1rQRGC1AWmjSKmNeF0O3f8QRJUfj5r9uO/pw+ECWSm15?=
 =?us-ascii?Q?frSavUUEDxAxw05ybfdUqOvEgi+ag+wh+vx1GOcrh9BEFVqAosWk23eiHkcp?=
 =?us-ascii?Q?RuEA03CFsqhn8u0fgYFrYNZMkOmGQmJTGMvG7X4bl51DHuuS5nJjyq1CfkCy?=
 =?us-ascii?Q?/ZSr2egvW0hHhxH/6GpQgWezrBkVd+JjiSYk30QeDVc0ZqREAawnPUabdNmc?=
 =?us-ascii?Q?vrABdYdtJGnjoRd4FWq83/f+cmap8Ls2BLS6peVU2GHjS5VGdrOesXfH8fMR?=
 =?us-ascii?Q?Gmm1zWXSGhuqH11CY8WmX5PaIKb1Ox6NgIu9xMjaUxNcdRrqC4qR7ni+cl2c?=
 =?us-ascii?Q?mQtHYO3ebem2JOjzFWx36URMYLk6EYhHEcu5Pi4VZvliULPv9ijuN2vQQ0xN?=
 =?us-ascii?Q?6FVaG4j/8EjPMrlQeKyZ9yx2e5ELgiEJJDFpcYu6LUv9UgKpipciVUyS7l+Q?=
 =?us-ascii?Q?4vS8jxr6SaxD7mqJ+HUbjlKOAmVlzMh0dn52Bp4WHUCiplobd+LzfVKBy4yl?=
 =?us-ascii?Q?OsoeJfNY6ChtyJqNQyHlGeCFFm95kb/MCPEVaE4xpBKbPZKll4ymZ4+WJTGE?=
 =?us-ascii?Q?KWceccbGAfqT6hwBJRqbyEiTXQXXSS4Zs6kRIzSdlFrTkqffoizcrgYjVfi9?=
 =?us-ascii?Q?q62g6eo0Jv2cw+Z8y7qyZGM53qRSgWTmqTR/7uv+3XVrVEedFiSjrVYv2vLI?=
 =?us-ascii?Q?scKuhSoXd0KJcyitoLth9HU8+6MeE/VMQDtU8Avtgu5xh36Ta4eQOoVuB1/J?=
 =?us-ascii?Q?eb6qMJndIbS+The1lifp7vYIMhFM/dyjubKscFNGpUDo6qSdeZeq9F/4/LpY?=
 =?us-ascii?Q?vJCyQNfJYauAzPoUdVqJAGAhmXC/NgCMdEkacMs0jQqKpheyHTS6fNQzCGko?=
 =?us-ascii?Q?xMJQmNFpVLpWHFY/do3fG8pJ9ISrY//oA4/sBHtImwOmh/VGRsyuwG2QpSor?=
 =?us-ascii?Q?FuIt7p1bbeUm6jbxAGnTvQCCOMEQovBnwESuZkTt7QkRiwIyY+h8u9HfFAsL?=
 =?us-ascii?Q?N4YuJtq9vawpn2m48JMaZW/UI9T0rqIdPIIjoxY998YqGtR9mL3DbodUzFuf?=
 =?us-ascii?Q?q7fBDumQ1mapYYUz7PjPrjQyxM/6QJ6S6xcH41MI+4mZI6Yuz7/GsuvSGTMR?=
 =?us-ascii?Q?8rj0ubA1GMtNOloMldg9kHlXBkxHIZEtDf32GRbBIk0BtwrU4xkCF+50nd9k?=
 =?us-ascii?Q?ionI/DQ4bcHZdobuErFPNyiDeJjgwMk8lh2Vb1A6njlCT2b8eCxzMkIrJWpW?=
 =?us-ascii?Q?G0cnqyiMXOscf6yWxhPUU55cSuXPrPQ2Snx/dsbT/Uxy8EfcFdNFRi4s1BYz?=
 =?us-ascii?Q?r4YN1dQOYyScQwKaIiUiOtTXidsZxlE8Di1r6yUbcWle30Q8FAQQ//4mS7ub?=
 =?us-ascii?Q?7QpIMcwA0qfub+V+8vOGASJrEAmqnaTgN8FTEfCMxJGqy07lb2yRrwvVch7B?=
 =?us-ascii?Q?LIII62rjLvRu3sXWHl2HT13VxzwyAr2nLC1JrKasy6g6A6ySZx5f4Y5G+g3t?=
 =?us-ascii?Q?x8uumOAfkkI9EVFPx9Ntp2ujqs/fvODxc+WQpnsItBZjPmYj88osOLs+rFKp?=
 =?us-ascii?Q?rpfoB/mjIytuRs7NNb77ws1c202xDvuccRNxG8Oj+IP0OXzTUc0ssP0ThBXd?=
 =?us-ascii?Q?HnIPQA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d3fcac-e31b-4f12-f43e-08db733847cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:49:36.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReEOPJyprt2ruUs9kilW8zswYow2B6+5dgqlBIuAel4Ck1+gcwpVsNmYrnos8slEiQbdkAo9xKqAkTeShw7SF+iNGdPSFEZtn7C7B8ac2hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:05:05PM +0100, Ben Dooks wrote:
> The checks on ipv4 addresses in the filtering code check against
> a constant of 0xFFFFFFFF, so replace it with MACB_IPV4_MASK and
> then make sure it is of __be32 type to avoid the following
> sparse warnigns:
> 
> drivers/net/ethernet/cadence/macb_main.c:3448:39: warning: restricted __be32 degrades to integer
> drivers/net/ethernet/cadence/macb_main.c:3453:39: warning: restricted __be32 degrades to integer
> drivers/net/ethernet/cadence/macb_main.c:3483:20: warning: restricted __be32 degrades to integer
> drivers/net/ethernet/cadence/macb_main.c:3497:20: warning: restricted __be32 degrades to integer
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f20ec0d5260b..538d4c7e023b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3418,6 +3418,8 @@ static int macb_get_ts_info(struct net_device *netdev,
>  	return ethtool_op_get_ts_info(netdev, info);
>  }
>  
> +#define MACB_IPV4_MASK htonl(0xFFFFFFFF)
> +

Hi Ben,

according to a recent thread, it seems that the preferred approach might be
~(__le32)0.

https://lore.kernel.org/netdev/20230522153615.247577-1-minhuadotchen@gmail.com/
