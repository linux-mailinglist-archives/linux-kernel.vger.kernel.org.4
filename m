Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F673B5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjFWLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjFWLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:02:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2109.outbound.protection.outlook.com [40.107.92.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168B1BD8;
        Fri, 23 Jun 2023 04:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m89u4CPQCp7cRUq0/2ZXD4sU3QB2PrBIQt3fEQnQ8osTDkz+h8feGd300d5vZ/RN21f8Q1XWODbJM+KkYkZsaUKBMfh3EY6C5NgrvaS0Q+p7FfkPsSO5pVNKgWnu/wiXFcglV+RH8xJdKmAQmd7OYZMYEb8I5/9BkkBM/aghQJUw/LfM1WTnGFR8pkBPxgqdJ/5D5lDT2tdixf5o4OwZeXiDb2PE2LUtPriYhFH7E5z5KxAVMUeyg2BAHNSbBpb7TT+nBfl32/sDd9hgqcBU3wC991urcKh2tcLviKz33cx3OmhT+FH0O/SqtabpNecnfeSNGQuGpWcf2zp2XvVyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx0Gw/LJS8pKd7j4tKfcQ1QBd4Yl1JGL/wmDUrDr2FE=;
 b=PW9/W0nOlPYkltdIL36fxAj7JELLPeG487n+oIynGz0R6968Yargx1LXvQtMRLb1JM7FOoLOw8f7u3nVzrbRFz1ruNv/NLer1J07egFUr4qfp9IY+GbDVJvV0TAg8S7wvxXqr2bFLGU/nBGjtXaqHRilTSsoxoJ7YMazIQvKjznoBKyX+eiPkV6LWyXqbClBXhK0Y7+IprA0kbhuGIa5hBCw44cBx1onFIv0h0KE9IZUnja5EFtvXkEIQobnH/kXZU2/xTg7wLWyh3MwCgAZ4kHLNTMHfNzf7AEuHQQ49hwSWo20SOYarzuDm59gueziCrcAYjYTYGKSBAbt5j3J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx0Gw/LJS8pKd7j4tKfcQ1QBd4Yl1JGL/wmDUrDr2FE=;
 b=jYHVXuLEps7XEdTC6JAgjt3V5nYTK469m79ApWjwmrN5P1AAS4K2FjDsOJQ0o9JHCo5PAQsI7HfmrUfegK55FdFnYfwiDhX4DYZuKnOn33Rjsc7EtNdZ/e2LIIsSSpOQNFcMI2YuiXvbnNZfphby35fDAZIKeFVyzIjzUr45cHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5731.namprd13.prod.outlook.com (2603:10b6:510:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 23 Jun
 2023 11:02:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 11:02:37 +0000
Date:   Fri, 23 Jun 2023 13:02:30 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 1/3] net: macb: check constant to define and fix __be32
 warnings
Message-ID: <ZJV7xkASubAENdOI@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-2-ben.dooks@codethink.co.uk>
 <ZJRtinvcu2PAf+Cc@corigine.com>
 <f13928be3aa5b14908104993979df6f7@codethink.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13928be3aa5b14908104993979df6f7@codethink.co.uk>
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba70f16-daf0-41bd-b473-08db73d95acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQnaDdMIEVb9MS+RBfSosrM3PwZuPPa+Jy/F0k+FojyX90wmxu8zbXYciBNgPilhAqUW+aWdyKNZin94MzfylTnPLEz9OBCPFcbPKRyZdRcacLOn4+O07E5oIe6O6WFmAKBT6tKaqDM8/WBM2ZVxb9F+0kc70nLqYYGFLpAWz6aqV9jwAQOV6C/l6u1LAPtk8OryWy5M8G2uDTUTEl3O72UBtj0Q4B4eZc4nW3DVxgWAEoE+YKwQnUo6A/FN6bRmgQRv/EBMD0B6cAhXVD8ZUMR42ef0l0bPAhhZnTiCbZqf6EG1yYhvlVsQE0CwHXlM++44Z1ZMXXy0kru8SHia8qUQIkS0G9NyVWeTiCPf/A/+kj2B3HTx6eRXEQNFxDAJqBs7mLAo7DfJMRhUAkwIbxqU78TSr8rzhOMi99/kO+Dui4y/dEJaxnq1TLrCu0CRr9o8E30Q2dlKAKFi+dAhZ9wVJsLPZS6cckRvo62loxhoCLykAlwRWaOhzh3hPtOYC4QY4gLRWnl2Xlq/ByAPwAAylZx2Y4IE54fwIyiOAE7wEpWPnshCDXunai5onjBwOZhPx6GwMhu/ujRYDOpadQ1rzeBlSnZfLMKAVmWssGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(451199021)(6506007)(6512007)(478600001)(186003)(53546011)(6666004)(2616005)(41300700001)(66476007)(66946007)(2906002)(6916009)(8676002)(4326008)(38100700002)(83380400001)(966005)(316002)(44832011)(66556008)(86362001)(5660300002)(36756003)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zsby/Zc9XhxQ+3Fj45XmzP9+dBJC0GXmOuenkxctkf4p8QwUwaeEGwS4Np8F?=
 =?us-ascii?Q?WKbDnytZScBGIUmvy7qnfWV1WVgTVNdSvEuCmW3PVhMHrki4suqrJhcG314M?=
 =?us-ascii?Q?38XUki588oir7W4WxP3fhtbN727euvPxvrRd9U/ioqLwsvA6dEjMBOeYSwYO?=
 =?us-ascii?Q?2WquJHVpUxw88oQgRLdXYbN836GG+1lH90hIFplDME+Sw2eejx5SoTKOdRRl?=
 =?us-ascii?Q?a1slOLiknjuJGsbVewtVFV+5PnZHeoAlV2I2DfH6LSfVIU1HqT6sY9KKFwWK?=
 =?us-ascii?Q?0JBjv58dxquS0NQxU6hR8hWbuBuFFEisLdoWEuNTk7ODszqM3mp/546DfJtc?=
 =?us-ascii?Q?pUeySQtJ+8MhHBdGa4C0Y9rYHvrLvoyEbU5ZzOFC8aeEhj9llql7UMvpmiRZ?=
 =?us-ascii?Q?GEhnRQYhRHxzGquwwbzELokHJg749SWWAo9cBFMVluQbX68QYAXsENnrzbsF?=
 =?us-ascii?Q?wNxHIuTXLQgjGsG8od+FvMpxeVOWdmt6smVruFzWvtp9DkC7qP1OfcJlP8Yq?=
 =?us-ascii?Q?qvs+32rP5qbLwYrZPq/K2XOlOvpc5nrpQSs4tntwLK6krr5A4psDm2AsVfEF?=
 =?us-ascii?Q?QOpiMg99bSxU9c9zMpSGohHYZwI1ZkQCkwtLEOGTpjUvCPzoQ9In0TNfja7d?=
 =?us-ascii?Q?Wmk/8TW8jUEs/XU+1YxwI2ZgZ6XkJ/cDCBoA7TOM5YfV4yhfO/eWDoU47waT?=
 =?us-ascii?Q?z3Cno/0/uuqXkd5LwmjUGewzGinftD2p4nF77Jn9fpjPoijXbP6AuGBW7uSi?=
 =?us-ascii?Q?kZLXLswL90gaBVDcWB67a2r+lxM2XsrztlwsC/Xor+xma2Un3IzABGfPVX11?=
 =?us-ascii?Q?KcGCvmXvPK4FoGDxspsYxEJ1GUyNrgUWdADUWRUpccHw+ED/o82qCF6PAaBm?=
 =?us-ascii?Q?6TGrdnYhmjQ7E3Vtd5nV5meIsAzI6eiGyrLSjYFwgMaEvwWrghfqzLTbvjTQ?=
 =?us-ascii?Q?KJLCjOxhxxFLGAyXwZAllnWv29Vc2frtNm/lNAx9MTbo4iwciZDqLiDyjTns?=
 =?us-ascii?Q?SRmtXw1qNL5xbu0Sp+X0USalAeEmSRDHSkiQ/7UTzK1agvoZMRk4BHH4pidW?=
 =?us-ascii?Q?absqZP7t2l9APSxwemb1n39Xyrw0hj6bq/MCeghUYEe8w4jZMhccT4cokcXs?=
 =?us-ascii?Q?kVGHFSe85CljoOLFBMkqpd2BDfoGEoZZa6Gb1/EX8cHsguQRTI3ROdsXfHVm?=
 =?us-ascii?Q?NmGbkxYyAJus6IqkoOaMbq/vUZ1rlLR8XJfkMI1bMegxwsmZYGoH9WPlOzh1?=
 =?us-ascii?Q?5/mtvlUlflwEXE20axCFYOAJKe2Sb42JlDapBM7VqaG0Ug4D9UlsKcis+7oU?=
 =?us-ascii?Q?sWZbQwSl6uxsno61sR8BjHPj1qyp6m/b2lBHdtNLjtcm7xnfc8vGBiAF2rJb?=
 =?us-ascii?Q?INodKgRwAzD1+VF9Xn9SwhxLP6uMYFDfO0v7iwbsZoTOfkwvx+EBmVxY437D?=
 =?us-ascii?Q?jXrHDvNcG7KKT9Dy4QpAV7j3XCQMtUmCcwbNBNQoXYXWmQ9a9XycX1bqFARB?=
 =?us-ascii?Q?w/sqy7sQ4rMwwkuA+I+Zd++Bb26cQwBLP8TLecsXauDrM++0Ge71oC5zjJqi?=
 =?us-ascii?Q?r/8l07KfjuOoL4SqRIWVTD9TUfnY+LLz0BgI16HMGt4wzjNp1RuW2Q1KH3LQ?=
 =?us-ascii?Q?nnmfpwOC1xfKtv5TPwPtHWIYg1+qNG+J19BQq0TTIIMPHd914RR7X1tbRmIp?=
 =?us-ascii?Q?Ce3vOQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba70f16-daf0-41bd-b473-08db73d95acc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 11:02:37.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwrSoNn9JxE7PJEb6fJDLv07Gh3GAmMlTMnCqrSgBaq/NH3iaD73PSjmAiufGckA38XOYV1nn6ao7A9+I8DtQoeEDfWWPSYSBSyGoVdsUxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5731
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:40:52AM +0100, Ben Dooks wrote:
> 
> 
> On 2023-06-22 16:49, Simon Horman wrote:
> > On Thu, Jun 22, 2023 at 02:05:05PM +0100, Ben Dooks wrote:
> > > The checks on ipv4 addresses in the filtering code check against
> > > a constant of 0xFFFFFFFF, so replace it with MACB_IPV4_MASK and
> > > then make sure it is of __be32 type to avoid the following
> > > sparse warnigns:
> > > 
> > > drivers/net/ethernet/cadence/macb_main.c:3448:39: warning:
> > > restricted __be32 degrades to integer
> > > drivers/net/ethernet/cadence/macb_main.c:3453:39: warning:
> > > restricted __be32 degrades to integer
> > > drivers/net/ethernet/cadence/macb_main.c:3483:20: warning:
> > > restricted __be32 degrades to integer
> > > drivers/net/ethernet/cadence/macb_main.c:3497:20: warning:
> > > restricted __be32 degrades to integer
> > > 
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > ---
> > >  drivers/net/ethernet/cadence/macb_main.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/cadence/macb_main.c
> > > b/drivers/net/ethernet/cadence/macb_main.c
> > > index f20ec0d5260b..538d4c7e023b 100644
> > > --- a/drivers/net/ethernet/cadence/macb_main.c
> > > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > > @@ -3418,6 +3418,8 @@ static int macb_get_ts_info(struct net_device
> > > *netdev,
> > >  	return ethtool_op_get_ts_info(netdev, info);
> > >  }
> > > 
> > > +#define MACB_IPV4_MASK htonl(0xFFFFFFFF)
> > > +
> > 
> > Hi Ben,
> > 
> > according to a recent thread, it seems that the preferred approach might
> > be
> > ~(__le32)0.
> > 
> > https://lore.kernel.org/netdev/20230522153615.247577-1-minhuadotchen@gmail.com/
> 
> Out of interest, should we keep the define then or simply go through
> changing
> all the places where change is needed?

My personal opinion is that a #define is a nice way to go here.
