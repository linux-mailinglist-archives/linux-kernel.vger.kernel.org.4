Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774826B339C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCJBTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCJBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:19:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C48FC642A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElbPY0L0PrWJ3gtnGYrSxe+tpZbrmO6iP6zOZGYQ/1+KsGe6v8Zb4kwzINtpZrRHzXN0ZAtajDq5uwB1jDS8GHG22UJ0B18SQA8iUMcLsD8LAU2BZa+bVj7RfUeGemsbqcWTvtivIBLgi7RRsUZ94Ia8ULlVkS1S3MH0HRJWQC70uXsW3qAybe0zbdjBmWh3Z5jvpEFUKBZnPUituWSsJHwmx4TBn+XDDojPLytRgE+Z6IlEq5qbgdxiQQp2XNuz9JrwI8B22V4zzIon2ezM00yISmQfMEYlxShwMHmi18YkgbRVKfkiX9lXFNhzfN6GS/uT+9kFVjHF1NHjpCnOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJu5Mx7koNAKJjU04pjO00/8z60MhFXFPEvWnMHXFVw=;
 b=Th47EHfOfNdP8aH8cdRZCQsx0CK4OKoRafTYyfgnrj3wmc5f2oUB+PY11ESwWDty3T+YKhOWOzCy6Zbe4hMj1HON+KfpeZa2nwmajRiuu1qG4n5UEsgJTnFuaCmZc8GB2TW4JL765o552eptRUqH2+OvjA5J5+0kq33VNjvWq3T+2Iq+8+ppO5QZU8ygqkORSa5Gk6ez35ctCkvBdI/fBbCMsp81AkzuUN4J3CVPDIdh5EwrUzMfqhF/Xm0AJ1NGPAutV6MuM7ED57Q8DQxnhzX/iXSu0HhY/WzYiqz1LvW3y+6pfepDERZqBjvJD93wbV/Oh+rM1YwNOcYbx9tR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJu5Mx7koNAKJjU04pjO00/8z60MhFXFPEvWnMHXFVw=;
 b=p7D0KXJSfsic9FyO0/b3guWpnGNbpKm8cUmWAis6oy3Et6QhPXCvVkITPvZl6ee1dcK1cGzBsIf5M0LIDLWHN+s+tBIUVlBi7WNyv/jbZNelbofmGIg9YkN3I6fsw7pf8NPr0t9/fKNlEa03Qnj0oWqDv6eVc5EVclr0C6STCiWr2zP9BQOj3ROUIynwbLeBeNoQhGS4TMrcSaoiZBNJNWGRbxsGpC9o+ZkOd4Kka6J+rXmxAZPXrqYJLTJzo6/KBULmxI7dNKX79U2Q8K41tOEMPF1zhAp0baFncPheoXQLWrxealb2AeMPXTrNLA7eAmKiHZxq+5asDKR+p8K+6g==
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:19:19 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::14) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 01:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 01:19:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 17:19:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 17:19:09 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 17:19:09 -0800
Date:   Thu, 9 Mar 2023 17:19:07 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 13/14] iommu/arm-smmu-v3: Add CMDQ_OP_TLBI_NH_VAA and
 CMDQ_OP_TLBI_NH_ALL
Message-ID: <ZAqFi52vU3h+DsWF@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <3b059f4b0bda1e83d402248114a774186f678387.1678348754.git.nicolinc@nvidia.com>
 <510e6e1a-884f-ae5a-35f3-4f4db997abfd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <510e6e1a-884f-ae5a-35f3-4f4db997abfd@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a45eb3a-bdbd-44a8-2082-08db210578ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgDR0ILWxsLIFrO8xzsT/ncqZ/68vryatamC3zSr2XdYN906aNitlTejji/4taKQWSYy8CnN8r8vwblvv1dRDXf6L0FOMTogucdEJK5Q8ndBu1bi4zClq9DrprZKk4xmeVGwt9/RwApUDSmd1vMWkr+lBqzG0fdoCG+odY1V3sCdO6VjpL9XOdVShpLQelxkkVwuWMBES0e9TKPDlCTSgCrf8NveC2UJmi2VQz7iZCJzpRexqSM8bc5yd7wg+IdvrOZszScT3/cxWPl9c/5ODy8CzwT2/JAEHGh5Qaz0syqjO4ON2bX94bdsOOn/FgYWxQF87Mxas2D3IaKghENif80n2KJi4geI8eWjncfU58YqukA9uNAURXK6JGdoOdgDJfXFEZEsbt+PZWHS8IfHqvKoJLmsR44sxjeXW5AoOPh6q3qWB3/QUsJ2dySLVdUIoOdGoORLyJHauhfhOUh8DqR5AyXp4fcEmvDwwAL7b2mBY8bwqNOLoTBySlCuv8HvyH9a3AFcW5d1FWRU/Q0IFPQ7AQf68BNhiqiMmdeZSm+EYCv8WHNtlAJRy194tkGZkAl0BmGuh2doTtCdXlo5b6VZiRCSYfcK5n2RkqZZ62R6rz53Yiq8CUVYxEAN1gKiERTgWXy2yapDEjrmwUVUEZcAtKPYf8VZE9kYY/f2aN//NHYeNyLw/As0k6gJW5F9jl4eIAqJ2kKW8HrSQkIGkbCrKO2AmEksqJoHrerwfq6LG35MDd2DLRPM/XPTZe0vPN4/igSpuR+mXJFkH+0IFw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(54906003)(478600001)(316002)(5660300002)(7416002)(8936002)(2906002)(70206006)(8676002)(70586007)(82310400005)(4326008)(41300700001)(6916009)(82740400003)(7636003)(36860700001)(40480700001)(55016003)(86362001)(356005)(186003)(9686003)(33716001)(53546011)(26005)(83380400001)(426003)(336012)(47076005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:19:18.8813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45eb3a-bdbd-44a8-2082-08db210578ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:44:34PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-09 10:53, Nicolin Chen wrote:
> > With a nested translation setup, a stage-1 Context Descriptor table can be
> > managed by a guest OS in the user space. So, the kernel driver should not
> > assume that the guest OS will use a user space device driver that doesn't
> > support TLBI_NH_VAA and TLBI_NH_ALL commands.
> > 
> > Add them in the arm_smmu_cmdq_build_cmd(), to prepare for support of these
> > two TLBI invalidation requests from the guest level.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 1f318b5e0921..ac63185ae268 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -277,6 +277,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >               /* Cover the entire SID range */
> >               cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
> >               break;
> > +     case CMDQ_OP_TLBI_NH_VAA:
> > +             ent->tlbi.asid = 0;
> 
> This is backwards - NH_VA is a superset of NH_VAA (not to mention that
> quietly modifying the input argument is ugly; in fact it might be nice
> if ent was const here).

I see.

> Please follow the existing pattern, and decouple NH_VA from EL2_VA if
> necessary.

OK. I was trying to keep it neat, but it looks like decoupling
is the right way.

Thanks
Nic
