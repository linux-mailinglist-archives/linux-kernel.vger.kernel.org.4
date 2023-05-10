Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB36FE607
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjEJVPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjEJVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:15:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835C426B3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBobELqfbWsXh3eitxbfT1oUbNhKPTmAtYgCzOGrGjfxRVtnVODoi3y81LQVFn8rZPLP4VgKZPr1wVlmMCxOA6mIKviNedqB9ppo+71n6oMWWV9oIMwAGotBue4mVkbc8bZn03WWI8+FFNm9Rtfl9O/ipDKBF4rLev7pbxTEhN/RiqTFJ3a/6WG8pXhnL0hP9VgHXdZDG/2snaPvwBYGdNVVdLJkEuNaIbPGbVFt6Q9CUgBNywRy8BeWhhXzfPmPrkGjV+9GLnfwBLvQXzKqhRSsh1xCwq+n1hfxKwTpTdb4ghPzn4Zjitev+1h8/Wy8IH9SgyPyPnmvxJgXuK6cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6pL+Ni+OvaZDBaERA29CIiO/sdbuEnE7Xyh81JHiP8=;
 b=UsCH7JU0RFS80flpIGb1a/RnNoTv6FvXYb9/pfc9drgLWumFop4uCxzrN/JwEJirCnjqA8saVEZTE9Nezc9OEUqKNbJ6+cvprCZIzf5fPwOjbzOFT2mRdvco1TKDuQtRGhCJcnL1YcA0lYZr5PvSTH4u7IOVZMXeQtqibAoeATTGhfiU+WNCIutRy2fHN4qNICTLsgwn8XaVawaSMhtSFk9vZ4TMpKp2YrKpAs1BwB/1zYM4nyru3uU4IChllykQ7sJ0W2fbAudRVgQ2c6M7S7QVsVsuwPH++6K9s7KSonl/kmkiRKzVF/Z0ZBEx6OVNTFwnSpi9Dcn4/tqBAHaxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6pL+Ni+OvaZDBaERA29CIiO/sdbuEnE7Xyh81JHiP8=;
 b=Sh6oderkzpvbETj+TXTCjQ56gTEJoeX6Y/ee1JcC2qv0PQDrHa67UtgXmVAzi3+4IniCXNUqC2TIrCFR/pnVPd673OAlep1BIp3elZlWnPSKdUxG4WdDZC9R3G7K5hib+/tIkjt1zRWohag9CAHKCev02+hzTWVdaBr5CP1YnPwcFr6+Gj3r5/cgXoJb5O56UTR+sriKGJp5mYEMoUoHVCFOvMoYWjOXwh+WmnqpUbyKLo5aG5hNCazm3tf664XPXqkE3GOdKwhRPT8qlEzTqPtW1QYgtHoEyX0D122t1lneRzZVfNa23Wghoe/V73JQuXyNLIgILHWXNK/kp2VKUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:15:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 21:15:44 +0000
Date:   Wed, 10 May 2023 18:15:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
Message-ID: <ZFwJfVOKWsFk8oup@nvidia.com>
References: <20230510205054.2667898-1-mshavit@google.com>
 <20230510205054.2667898-2-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510205054.2667898-2-mshavit@google.com>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: d8974887-13c3-41c9-1738-08db519bb7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gO5/bejvOxzT3mTuXJubarO6Oqeu/5i53ypCwo6qIrCEfegTOxxsPQjqbbSIuK3X4j++Lyk9y5rUh2CbfOv7oj6pjVwVLoSWO21ogBYS/nQuB51R2DoFHyGe4ibEcuStIbukJ/XGxI8dNoBdzEpw787b2tC+osHdBWUX/aD5f0SVXhVCoF0mZHDPqlzvCfOO2hvYDOeTuwDZf5Th1YrPxLVXIu1QdVvom9IILYzmgDgajlqq+qnbdB3QBx+m9TjLE+PR0Gu3LZvui7IsZ7DKNVNYKMUFjafxev9HCKzWVZU86BusVphZ4MvlPN7d4VeiJ8nxsBf698H6mXtNqOltBo1J1kOWx38EPq/Arl2eFiJNeEtGRI1JX2hGPoztrTG1XG3UAUL3MTvNu4c6YSkeiSWwKY3yPU3+pzv5TXvYpcKsAkIAz1s193EjlTkSxLGuPxRA7Iw7VH0WdGji0q2H431EJSmKfLulay+L6vyfTMqKiZYNLL9/wGhzOyhGWb3nyYXvIxvCdjUV+rcCub+FAuugWh4Z4Mn2RoK2xLsZ0UxKSMQSScsyr9kFV5fZzvoz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(36756003)(6666004)(6916009)(316002)(54906003)(66476007)(478600001)(66556008)(4326008)(66946007)(6486002)(2906002)(5660300002)(8676002)(4744005)(41300700001)(8936002)(186003)(38100700002)(6506007)(86362001)(26005)(6512007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6kPzLFSOEBgIxOmzX9bG9xIhpsWot4txRIw/ZfXCo30NZC4pH3+IwdhFfCg?=
 =?us-ascii?Q?hk/QXHKLdokV2cHCAjuRyska2L7wzLGZN4vIr8CNsETcYqA89+GVw+TPamB8?=
 =?us-ascii?Q?qwIORU1+Z/VXM2DWTtx3lQvHEEVPJIWe6VO/KWEvPH1WnKyO/fW8oI5IQliJ?=
 =?us-ascii?Q?ohXATmqwt+i9Rm2ogy1z3BNFnGlQUy+ha9wrqg34o+C0N0mPgBWd4fdnlK1o?=
 =?us-ascii?Q?aOS/oq+/sUV3tXpnj/DjpOuo05gQ8ZQ7pqfL12qp1wZ20GgF505jJv3rySwi?=
 =?us-ascii?Q?BBu0QLPxeZF38zh2hd2/3+Atymf0s5oyysa2t0mx+Avgu6AY9tcwFr8zlf6h?=
 =?us-ascii?Q?EPN1cArMIn4+OKX+4OqoVWxkjCkM+7NQSuV/SOuQPiU9d5sLL4Gayqx3kiL5?=
 =?us-ascii?Q?h6ySj8tVcxh5CBduE3HZpfvTmRbVolY9edVd7qnGYY+pxXOZlKDvzNIgh6xw?=
 =?us-ascii?Q?uDBc3rWI/fH12xSijzRpoYV/mBAWFmbH/gVwsS1C2eueBhvLAMkxgOc8x5CS?=
 =?us-ascii?Q?k7qUDpkjgI5aKQt9v4FOv2PT2SB3CXgLSPmegaAZxBJrLiTvUTvIYP8wReny?=
 =?us-ascii?Q?+sD7Bozh3XyBFx6ui/IRc/V3N6X1DhEK8xnedzkh/lZ7Z4nxa2DSCsegldCj?=
 =?us-ascii?Q?zoaHnd+b7sj3bdlEcVQ+pltJezb7d6BWUbhI252OSyDHph6ngbLXGAGsZbbF?=
 =?us-ascii?Q?iEAUd4yS13YeMrBu65IiU/QpZWB2TCOfY0GHcCEkykQxLOMoH+5I2fK/NhGW?=
 =?us-ascii?Q?xr2SkXPcvL/aKpqr+vjYRn5D8i8yT/imxBEPfMIGyvDylHa4MS73dHsH789p?=
 =?us-ascii?Q?1l1B6aU9qawJz/HXo7K1Z24jPrk97SnxyduHAAVX3J0uU0aFeUlJ8Tjb8r0B?=
 =?us-ascii?Q?2Qg4/ixK/IaNQrKrqZvrPKZeTHCI9VzN38EcNjsNqhwPIKOp8xjA6mI+6LyW?=
 =?us-ascii?Q?zf0WCOfaXhUTHmXZx1culiK6y78l0nAH2kgbaK4tVG4aS54V3ioepzNX7zsn?=
 =?us-ascii?Q?ZuMiZgT7Ii7UtpZY+jxfLcEqE1Bk4mWzAwt1TvmWWwbOQCavwO/q3SNbwyb+?=
 =?us-ascii?Q?5ZljIzTU22JtjLA7Yx4UdiAWCdV64XGh6ckwcSyosB3pOd690m0qX3KCJyNu?=
 =?us-ascii?Q?g78gMrtim0NBJx0bIf1gjAs2Sjzx7dMgbeapEzaOEBiawoDyEjE6+l/J0SFP?=
 =?us-ascii?Q?GXsBlYA4TRSXKUgeyb3cBBWUoeTGul/7F032hXDfJdRidmcIsKnP6NuniSjm?=
 =?us-ascii?Q?kNCmsOcjEToQwwvbUxQck9qf4NHyZVy8Kyy0aA/Ew+f04+8qXRsB/AhPtLBr?=
 =?us-ascii?Q?pbGzxCN9nJsX91wsDhXbCveMp2zYtJfUEwF+zG1x4P+euzmNs3Kmee6n/Llf?=
 =?us-ascii?Q?Inr76wHoCbYYwI2taQcMfvFJzI+AceVW236+r5J+lLIp2zxbGcjfRpFc9Axf?=
 =?us-ascii?Q?5TXReFKyFiPPROkYTPocA0GpPk0HcUan1GaHGOjsNuhSkOsQFcO/XA5XgqxU?=
 =?us-ascii?Q?+EKum0id6B52lE8hZMFaTSGndyQx9eLET4GAV5Joiam3NjlVHl/3aZ29KtTc?=
 =?us-ascii?Q?LvGqMb3j6CqET3dTeYA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8974887-13c3-41c9-1738-08db519bb7bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:15:44.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AqsCioNgZzs6oj/rxZ6i/y1sHO0NzodnB5xgqV0wi0reeBohEBqQE9tKvT8XV4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:50:48AM +0800, Michael Shavit wrote:
> In the arm-smmu-v3 driver, stage 1 domains represent the entire STE.
> Iommu domains are conceptually closer to a single address space (with
> some exceptions), which are better represented by a single
> ContextDescriptor for stage 1 domains. With this change, the CD table is
> now owned by the arm_smmu_master instead of the attached domain. Each
> stage 1 domain now represents a single context.

As per my remark on the cover letter this seems a bit confusing
description, but the idea that the CD Table for kernel owned PASID
list is placed in the 'struct arm_smmu_master' does make sense to me

This patch seems very big, is there any way to break it into smaller
steps?
 
Jason
