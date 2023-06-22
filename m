Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545073A53F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjFVPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjFVPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:45:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2118.outbound.protection.outlook.com [40.107.100.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191DEA;
        Thu, 22 Jun 2023 08:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoHeoMohE5dMEoGTP0XoquwHDymn1xhnMzPlugh7LcuiWhqoJBRooZBZWJc4hdhpcplU9ocnNUPoIKXV6Fv6kgsYJxrOS+YjP4X+qn6yQm+yrkg81AboWgMfQ9Cqqv2JKeVIGgLFP6d212RLItY1pvY6Aou4AlJjpMwQdNBdYDnQT7KCDRPJLfMu1UwZhM/am8zwTNBNe+BB6AzTMJFPKycQEM/WDJi5wjUNXGDAhevbsl/FRhI51f2JgBvNkvUGnYlL9+oe+LbPj2DvCEZkVCaPOz7sgeVabRl2ep7BoTribD7/lVZOac+5b46WklmMbROCbjG0FSCxXe/e0P8q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNp8gKtFKWJm8vH6qVjCF8dynYRcztSUp1+PVVm7Uwk=;
 b=GYatxPgv4PCa7LIBPebUic1eOoXt4GHg1vjPLB3KWpG0YtBhF29XCF1vy+U7qnOOuGOranjoNc+NOyIlXnhDzeTBICKX/PSQ41+nrDYz6R1BiHG3UlIArK535FtRa5XNiqC4ZnquVCTbsAXETdz7mAAVx2nTtwMO0p7ieULsqm/R/hh5/5JU6sedpiMJTcVv9vVeGJSLYOspmP6llhaA5yCzCxQUUMOxk3OW7cQtuY09pum821CKYM7lZxWIHH8ATVCEb1OpWipcIyN+mFQVckGQnhPUfdikIbFg29VaKlHDdtDevqjYX8kpF2Xf6qCSUSqzU9ummaCAfSiYAdRg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNp8gKtFKWJm8vH6qVjCF8dynYRcztSUp1+PVVm7Uwk=;
 b=bOXbtxLoIK8nACUEKD+wkKSPLYAbHhc60YtJ4rhQudhFO6FWoN9tBU2IQxpBL44ceI2MyZ1GR/KNpXA1Dk+XPJ1LveWhsHFL0oVfKH/XpXQEvfvPMSh8q4TuduRtfVsFwq4c8ywWmMSk98Wv7Wl61BTs0/eftq2ekAIEIhg4FII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB6009.namprd13.prod.outlook.com (2603:10b6:303:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:44:59 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:44:59 +0000
Date:   Thu, 22 Jun 2023 17:44:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 3/3] net: macb: fix __be32 warnings in debug code
Message-ID: <ZJRsYtU4qPZ0h1xp@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-4-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622130507.606713-4-ben.dooks@codethink.co.uk>
X-ClientProxiedBy: AS4P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f03b17b-5db6-4ae4-6f0b-08db7337a28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNmmkPdUA6LRrUWOgYYqyJo2K0UT0a7veGupbvibE/ImzwPiP5NdClE0qOespRohxmWuCmBPiTBCvwgG4sYUQVcTLpSL0iUjIAsr8QIcd1RDxtoe3XkVEdXgM0aw4h4yWRwQvVR+f8NaC+SXBM04izlgYrbiIcWKC5Fe53FGLEVANvnSTUrlaYsSyRY9t3twzImC02c6Vxwr7fgP9oJujwAg5mvfwlRP6Aj4LjGn1IoTH2tODNi1TckCMfLoOE04ctWZ8Q4PQAyGJk0Djkdz0gW/zlo+qUIFZb8GnZaTepBoPH7Z9eJ1SvStYz8vpeGeVUpDZSKagWIx9IMczwmf7AGIUSpaRZowJYTLXi5CKhDMhymwHZ2l4ri1uza0VAH97C78ZYVE3S8jA+epGPqazGTf/e8C/juYNW3dYRsk08yhJNz7tqmK2iiaAKO7JpNhHM6oqNEnv3sEcgXTBuPHQGbM1iw/Xodv7VTyI2Ekke+JN2qXSNOvHZQeiHaIjmRu+Q+t1aCcJUVpOfKVq7S1o++PAgcbi3UQ0hVxDALblgkEth2FKMHLMDk3L50nHWey36Y0R0idjG8QXWEEDvAHg/e0yN6KM7z2eQ3J6ACLl+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(376002)(136003)(396003)(451199021)(2616005)(86362001)(478600001)(6666004)(186003)(6486002)(4326008)(41300700001)(316002)(6916009)(66476007)(83380400001)(6512007)(6506007)(66556008)(66946007)(8676002)(5660300002)(36756003)(44832011)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVZdw1vu4eJZeyOdBb8jR4WOlBnijtRUjO4he7iHj+R2YVjkdrKEGKkHSfwn?=
 =?us-ascii?Q?G6WkOVxM60izgY5+yaxtJL6EVO3+v03Qvf6fmgbWWO6f4Cz/fRsTEUDIZPXv?=
 =?us-ascii?Q?WHkP5e7PDqhDGJWsCsA6bhEaya7SMgqk/eEE/Amv3q9kL/QnKxWXegYIGTuV?=
 =?us-ascii?Q?4UGfRqUeLwIba2gdHDeLVZ/EmULnSsd7duPaGRqzW6t1NV6Azt2o7j1NelGo?=
 =?us-ascii?Q?cAWo9bWMcfrSF17pXWR1sxB06iIug6LKYrSrydI3JjrfhRRjU+TSzWRVcn0K?=
 =?us-ascii?Q?hcAkKlOSP77dnaf7mzwRR0SCRT9zyl8V5O98yqvLZXzsMlZ2CdHP9PwkzMO0?=
 =?us-ascii?Q?uAKDeyzSjh5uPmKU89APCOg3ffh+bJCB44nzKj/e7hIr7TGwmPpC3wIbZkqT?=
 =?us-ascii?Q?akLpmHo2Wzfev9Am/9ot0prDFJWYASRsXXNHdvaNU32jRVp4fTlBoNWCQ3bY?=
 =?us-ascii?Q?clDvuVJ+h6dWbOYjp6TXKe5fAVxzwcuL88wJRK2BKQ7oxulWJvITjn0baX28?=
 =?us-ascii?Q?E56oHW8g+WYNpcQ9Zv6BS8EX+00O2Rj1V441Wvi2RBuH41Fu+VRffGXSFGG/?=
 =?us-ascii?Q?E253nP7bhxtw5m7FwhutoZh/Qc0ptzd/aP5IZgDdDlqHUHf52jYLjx/OfVsK?=
 =?us-ascii?Q?3S7LRO0rmQwi3gXaGp0nH1ELFyBlyio1cxL4r5v+CZ1Ot6P4bE1JLLhczv9l?=
 =?us-ascii?Q?1XIGW+RnlAX3Xnzr19ZpuGvpcbqGh5rqfDSyK1KoXSywELZbtggxNNp61NVA?=
 =?us-ascii?Q?cwGKVE0ZKOfNigmuuapt4D8M3sJoI0sFqYCC42CFMGyPLOFpGBYg6T3s3emW?=
 =?us-ascii?Q?qtPuCU4H8LIjWO0HWT98vWBTLNZjn7as3opk4au6d4Oe/n5LjOVF7ivpMyOn?=
 =?us-ascii?Q?z4HAGta0fAEUr/V0b3fevlUcODrVDqMNp+4feaXCw9jsXKnQN69pUfXrBqPA?=
 =?us-ascii?Q?toaw2UPFNhGHrL+UtwqmWDdlwYvSYm63L5lag6lfR/g67jgAd8h5VNju7kO/?=
 =?us-ascii?Q?ghbY1RoD+eYChEjzXllUfqLFLKVXPiWYEQ3bIwq88MwOl+c+xESztKsGhDEW?=
 =?us-ascii?Q?M+amnRJ5WdpFdUYouNNsoa3ZwchH+DWXl+270Mny6u0FmfmqCLYJ2E13zxGW?=
 =?us-ascii?Q?Mki7+MJDpYdLudlkARMY4M26pwYVUGyfnWOyl17/EVet7/le4nNCdq9scC08?=
 =?us-ascii?Q?49PRZdNK+7J0r1poiXlFWYFyOiJJPjmeIiFI5pyxED9Av88OTVN2zd8mCvzP?=
 =?us-ascii?Q?2DBJeLukXqAoeogskYMtCnChsMxv1I+F2ZRSoZ7NHXa9reK8wZ+myUk8Uds0?=
 =?us-ascii?Q?naHWLXkXfma8QJ4v0/8cxewKIW19Fp/mQbK/oXEvwkAo2UG9hG1wNLM3o7F+?=
 =?us-ascii?Q?TibT2zlg8c2iY+iUd3QKYVsMbnzykMVnO1/d+R+3G1Ptw9AAlSnCfEfzEHYb?=
 =?us-ascii?Q?Yumz6XA/6kC8jHGrrUvOLX2NePxnQUq0gb4QzjG6SXqIxkx25Ec1LtqRXy2j?=
 =?us-ascii?Q?8JSV2fRXx7ukvb/ALflmkw6oJFFlD4sWA3JQkynJDt569E4tFnqchwaJvxts?=
 =?us-ascii?Q?WfCebrofiSW/bUNKsgrwGNva4fMPtiLS49p1k6d1uVCh3qDbDwEnw9UR0KiS?=
 =?us-ascii?Q?6idh7gzPHT/3MQz0DarNmUtZ3oiRdyRdD4YGruxCBxm+yv3oj5C0xMWi63wA?=
 =?us-ascii?Q?XGiPqg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03b17b-5db6-4ae4-6f0b-08db7337a28f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:44:59.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snWl5ZS2Gy4WWGLLyMdQZjW4JwYnHLYwqcuLJbXc4YUgdiKXTSPrQaOU4TASuaCapbv59FPRTjZFlbfXRdOhmq+mToLC9WrrmOST1YCH+6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB6009
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:05:07PM +0100, Ben Dooks wrote:
> The netdev_dbg() calls in gem_add_flow_filter() and gem_del_flow_filter()
> call ntohl() on the ipv4 addresses, which will put them into the host order
> but not the right type (returns a __be32, not an u32 as would be expected).
> 
> Chaning the htonl() to nthol() should still do the right conversion, return
> the correct u32 type and  should not change any functional to remove the
> following sparse warnings:
> 
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
> drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
> drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4src
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
> drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
> drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4dst
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
> d
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
> drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
> drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4src
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
> drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
> drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4dst
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Hi Ben,

this code-change looks good to me, but I have a few minor nits for your
consideration.

1. Please specify the target tree, in this case net-next, for patch sets
   for Networking code.

	Subject: [PATCH net-next ...] ...

2. It might be nicer to write '.../macb_main.c' or similar,
   rather tha nthe full path, in the patch description.

3. checkpatch --codespell says: 'Chaning' -> 'Chaining'

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 56e202b74bd7..59a90c2b307f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3568,8 +3568,8 @@ static int gem_add_flow_filter(struct net_device *netdev,
>  	netdev_dbg(netdev,
>  			"Adding flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
>  			fs->flow_type, (int)fs->ring_cookie, fs->location,
> -			htonl(fs->h_u.tcp_ip4_spec.ip4src),
> -			htonl(fs->h_u.tcp_ip4_spec.ip4dst),
> +			ntohl(fs->h_u.tcp_ip4_spec.ip4src),
> +			ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
>  			be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
>  			be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
>  
> @@ -3622,8 +3622,8 @@ static int gem_del_flow_filter(struct net_device *netdev,
>  			netdev_dbg(netdev,
>  					"Deleting flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
>  					fs->flow_type, (int)fs->ring_cookie, fs->location,
> -					htonl(fs->h_u.tcp_ip4_spec.ip4src),
> -					htonl(fs->h_u.tcp_ip4_spec.ip4dst),
> +					ntohl(fs->h_u.tcp_ip4_spec.ip4src),
> +					ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
>  					be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
>  					be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
>  
> -- 
> 2.40.1
> 
> 
