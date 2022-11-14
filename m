Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFE62816D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiKNNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbiKNNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:35:42 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976DB13DDE;
        Mon, 14 Nov 2022 05:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7h2IGS71ZrkBBx5EkLuJbH7ktEM5IaKwPFtY4govIoDvzpEwLQYRTSDS8iy0NbpMAa0oi6nj1AGVciPYhEgnRv2GdGSL4Y3uChSaTDCh4Qj1bQ/+8DRiUmVwRqYQ9jkKYWn79GHI3D+hAr0K0STbhtbDhQSsykdkjOQQTR+EGrBXLHZuYXjP7JdvnsFfZfzaDxg1SLqX7mqPSFI8o79XpaT7+B6XgOl2rcv1vlUY55jItCnjAn6PHBIR7uPpi4WU4t9kNoeoyTOYMatNm/0aLQwoXnGMpNGqoESGqGADT/39JYxYPfsZmZkYiSVg24x77beTdt3UcCFhpCiMMfQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS3hP77whuT+T1D0FdWP3Ksq1HfwvRetZe7WlaSZ5vo=;
 b=E43dMWdmBYGhWic0YiyV1pziITuc/oogefgys0fr6DwGQUyarW4gEA/RpzuDAgDFNCmslUniT/FpYRLwXyuHq+pz6hcsGwUEK3hEoSnXuBdxMtxH738woXrXyp1+d8ZYOLB7Is00AGVCnIBymFqLwvk/8kYIytHJRhncY5my9LKvfnRiCsC5sj9r61PbRoyErxx6GaON0rLJSg26AmMK9JhZmMcsBuSeSTWwROoMKpMP8mG0c20h8KolBWA5NepjW0doZ79POGD0QI+v9AEG5NK+yZRD9OVNHwrC1Fg+6xshM2UROr2CwayPv8fXhKV64GrOnn/T2MBilRXkJBrlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS3hP77whuT+T1D0FdWP3Ksq1HfwvRetZe7WlaSZ5vo=;
 b=HRHMsp9/xnJpRwqQ1j1UBh3N1dFqL1+CRuRZYL7bwQp210r3plyjqoRPMnmJkRQdeXxnGqVhbdw5JK+kYOwa5dfa33j0hcX6f2cCwLn2s8qNI1Tglp2VPlwbsbS+HtgTDTv+WGWXh8kmlAkkYwxLWwxbYlexMy3hIjBXIrnKtYLDL20T8YxzzS+TcuNwnIswg/6Gs/jaCh928CWsNA7CfQW2QBPQq/3ilB61cGPEuybVQfJGfxgzFO9pJ3CD0vQd6t/1EME0hlJEqHQcQMPRU4qkGK0IlrU8hFicdEXqoFUHkigDRL4niFeY7c1xR8gRi50L8poGEQ8sz8Cq/G5mXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 13:35:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 13:35:40 +0000
Date:   Mon, 14 Nov 2022 09:35:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Anthony DeRossi <ajderossi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the vfio-fixes
 tree
Message-ID: <Y3JEK376qqpBcYAq@nvidia.com>
References: <20221111153735.07a2bee1@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111153735.07a2bee1@canb.auug.org.au>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: e85a1103-15c4-48a0-d295-08dac6451ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bibd34V/t1soUBcpjTZUoM9wlQVOTT/YeU+W/aWhsw6aRL1UzOf0TZaGJVNDGjVG3gwsk0S7ykj+UR0QOUCIzIjcty4Ar+DkiI93ntWaV/QlGAJibhjsE0fm9iZ68eOcShX+qwwXt2CnbBlQYxI6EWvABv4p6rsLZJR4xEDWVS7X7FddrHAT9Ab6OKck0onxpGpCxYYcovbVbfIuJxUKBPqEX4WZIBBdXmS0KZkqxPC4xWCDNWZdmz/sY6SedUdru/6WsVl7sFpuE22fxxTRqXfVHUy2FksudIb3F/lqh2e/+5lFHvKQR5h5l4eLwSB/T+QmcLBCB6MGKQQhiSh07aJqYssMw6vYNhrjwLnZlvQVtPaVINuQcf1EfXfwucc+7fuJYf7RG2RegQ/eEhgTFT52T+XhoMcQj7Q2qGW5GLpRDK2p/v4xZhNvBplFGKFEop8Pael0IC0hrw4F7oMlGeNfTyCVUEMd01nnlKpmfJnFWZ6MljRdbh75ZvKV7BARPupBP2oTDubK0bl7cK33AshkdCAvdXOVm9py18AgyR1y+ZDXgCkGALq3eXvBl4CE6+Qh7CfZ8tZBha+IFxg0zUqws+lR38lojadax4MsG8oSE2YNZNO1qdt+hE5+KQ+MXtgeVNKISjCqyffvjuji2TlL4TPbWjpxPO92SUlzGGcO3KoJB/DVV/IyhaVXlaQb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(6512007)(66946007)(66556008)(66476007)(4326008)(41300700001)(8936002)(8676002)(54906003)(38100700002)(316002)(6916009)(5660300002)(4744005)(2906002)(26005)(6506007)(186003)(86362001)(2616005)(6486002)(83380400001)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v04h4Dr0uBjSS/9ooFSRevuQ+0DaIE9skvXIqcQTJ6ANHMhHDcpJCwdT3Ltz?=
 =?us-ascii?Q?wWOWnXP/UPTRkXRoDD12N2Rt6KdN0XwPmyMOqmQRqGXZJr+B9dItjpzH5N43?=
 =?us-ascii?Q?lc88s032S7KXsEe/iZKBTz3KTHLsM2vVjZsvgC4M6MMGcTXUcIHoYwR6clBg?=
 =?us-ascii?Q?Tx7vyQDhcNdHVqt1ugq7e+EJRf/9Q4+fN08UVgW+/kxzQk6qhI//UukSjdOY?=
 =?us-ascii?Q?8SQiLOWyiFtoLqrKR6gXqlm9fbkT/hGZNL2DF84srEu7FbxW0+om6PSDpM8h?=
 =?us-ascii?Q?E9JhsUV03lK0tJpaJSovwTZsdDip9rE3afZVwLe1Lm4C6BlThuL/bHyszgwy?=
 =?us-ascii?Q?XDxhhog/uPkUsseX6zPCqbmiA7WLsaNDbSfc5eOLaonPL6PJ4Joifu6auxgJ?=
 =?us-ascii?Q?J0BehthZ7C+UQ0d6fnV9JuKvs3bb640+Al7ivactMfTh45c0f1wuaSj+rttx?=
 =?us-ascii?Q?dBdNoBn1jSMkS3ti+L4M3LwGGDZRZO1nDKtbpiJEEatjEvuVJVBWYrLRopqF?=
 =?us-ascii?Q?b3/u4xT4VLAR7jxazDwfvKIWxLwbbNDXoSOD5VY1ELFQcVCO5gq6j06xlJed?=
 =?us-ascii?Q?tu2Uuzc0UzBlP+JFhvWzjGs/BA9NwoezS5CRQm7aBrplssDV9vENfadXIA4P?=
 =?us-ascii?Q?Nq9zDT4hLtjcQrBy8Z2WwxNy8BUSweI+CQF4K8wiIsfxi+3NjhtUUqqPqEOt?=
 =?us-ascii?Q?n8rUVxxbBDUOJtIlNoEywFm9PemG01NQNzD5SXjheJeXFGWSFNE31Z+vIrDq?=
 =?us-ascii?Q?ZcxrU6dFORP/JlfBlbc2YgYEPlair2kMbVEjH9JVZP0u53+illFY6xIlN5Z1?=
 =?us-ascii?Q?1AbjBYMGeyKWasQOxNMkIyzj3/DPWVGyCeslq21Bmcmn5klqtROj/7m/bI0q?=
 =?us-ascii?Q?Id0le795JG0Em/4Tdv2A1SnQTSAUsPff/DNfRU7uEIPU77Ck0nUbDwfjWRDK?=
 =?us-ascii?Q?lG8jMpaTGQL+/6Oe7vIo7f/muz92+ZsQj2PSy2lRCXridz+w3XsxWy9sG3eh?=
 =?us-ascii?Q?inrv8c40C3+F08pC7Y7mA8o9HGgEPFFqGywohD5zGQOi0qpKY5OMKhK01bqj?=
 =?us-ascii?Q?J9PWTU6bVzedCES4/Xq+tAOcayN2VfX3obwMAb/IcnQHj4bTRAHTESa2totJ?=
 =?us-ascii?Q?2aDieNx8b1Lg6uFNDrUK4Ot3eC8gEdcH8qmKkIKQ5Cfr0pPJEf5Nue7+SKHi?=
 =?us-ascii?Q?skdR7Gxf5z67qdovlOebFIpxRcZi+++PGdkvLrSGQ0egzEKNoyfmOqINV+4x?=
 =?us-ascii?Q?iyFRfiudkK6sFedhUTYfHQedTCV8fe1+Jw8X9SOdkm9tZnft/8cGf5MEwHVh?=
 =?us-ascii?Q?4sdhV6dA3+Fm/Zr8H/WbayLcocdEj6el3cNYfe2pBYXOjTCeFXU56r0N84zZ?=
 =?us-ascii?Q?DGZg9D9mD1DBPQHJX3nJTGz1JtCd0ssfffDsVxNr+SCqMOJY7m2Rk47Nh4Ax?=
 =?us-ascii?Q?Wo6a9U9AM7cTVAriIxD89/7vDz/wPh9+Lcb2Dtfhv6P1ez0oPxmJ7D0OnKiG?=
 =?us-ascii?Q?FKyRaVtEdvX36pxjOJRY+y8FCRTpB4loT8Wr+XBeIY3X99AhK2j77WcPXZ46?=
 =?us-ascii?Q?Sf85sRRQ6QbWDNqmmwY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85a1103-15c4-48a0-d295-08dac6451ed0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:35:39.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjBk1tkW0PBHGvA724gBxCMeQ1ZytWVg8OtQbdGoGenrHhdYVz/H9JUG5wwxhVKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:37:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got a conflict in:
> 
>   drivers/vfio/vfio_main.c
> 
> between commit:
> 
>   7fdba0011157 ("vfio: Fix container device registration life cycle")
> 
> from the vfio-fixes tree and commit:
> 
>   55e16a188913 ("vfio: Move vfio_device driver open/close code to a function")
> 
> from the iommufd tree.
> 
> I fixed it up (I just used the latter version since it seems to
> incorporate the former change) and can carry the fix as necessary. 

Yes, that is right, it is as Alex and I discussed

Thanks
Jason

