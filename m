Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB06B4E17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCJRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCJRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:06:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B63B775
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:05:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKfsYmPND+Y0VXb76dTA3HrP1HULUMgLIPjm2sLChPF0jnfTaBwHGEFcGbj8LsIcexkIYpiXDFgn+qBVg+jvVlrfKQ9SFXLb58pxQEoSz6khzZdir9VcBrOaI9J7NklCqcHqBVeNnNLrZt7bsP0jCckBRVmMR2xOj1vaQJ3saVVjbtJaPVBsyBxQXecGPohxarrDr7G8K1Pb276E4ZBXw5Ky2jO54cmQBIFA04Eji1lQhSI7eEDIqanArpIO4uE8PrretKI0vxAkfraG5V1QnyNRazadcN+uiAzhQ9C29jCvPkElATU1X4fNW7FClhvKbGEO0B7gXbM9szWIHlQGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aspHK/r+mMSvYoswel5YF1p7o85F4o3xEjk76eemdGk=;
 b=bZsOUXeN8CrnMWZi+bhW9X5IAWybqnlO4ikC2Z1Jue/SHh0QLWsDBAXWFyOi2UOJSopgilXOHg1db2ebbGpuAQCWU7MjxYApCy+XcTZNarnXHDnxPfhgiyGn4YwIQqqQ6dJaqzb8+DK8XnzmRd+wIS283KySfNMHKzG4chpvARzXk4lta9soEkgVRJzfe9LcLQn2csfjV0TxqT5bcZhSM/QuGdAacrbmntXunoZ1RAcQ2NFZGYr+EAXpVWnrMvALqeSsDiGvSTbkOxopsBoZ8YBCQ60J2DouUbwZAuHXmYLaxl+RBz4EE8Q/0Q9Xb+S/5pp75pILD54LBiK6h8vm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aspHK/r+mMSvYoswel5YF1p7o85F4o3xEjk76eemdGk=;
 b=Bqk6DMyOZkt+0WJREjJ+GUkvIuIQhpxj2AJVCW9VyM2lRaA7w2zbFDp/bRY11pkitAWW0rKqil+d3bzCh92QIJ64+71CKgrpiBZTbQhxXbDd8g1n65j9jDb9fUMTIHketUH1Xv92LAOGMdNGu3wunbsAa7wo1P42cgM6fTmGnwPWJ57fG0PjtO5n49zV5Vrw9CBCDQl/dLNCofT0l1CqYgzVSi3Cc0AOM50569bpqUQQmeFoELlx008l39VHU6vE+ZklLHDLHCNAjEMFBOyuL8OUmCDoxZBBqjOoCspaFHn9OabTE2fkn7IsA2aByw9R0fr6ShimRawcIFdwzj8EQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 17:05:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:05:39 +0000
Date:   Fri, 10 Mar 2023 13:05:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/14] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Message-ID: <ZAtjYFMio7t66KWy@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
 <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:a03:338::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dd4303-9df3-4a2b-2787-08db2189ac82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bub9/YYP0AI7o2dXRCf+KXXV+b/NqAVOE1+akfN7hSGjvVKy8k7ktQ9pyxiNP0vMhE9qygIpISWOsBKxJSNdAzPm5XYc0InDPdvIFWvFeCp8t7QYCw+PxoR3M+PyRV2+3y9lIvp5i2hh1TTqAgJCbWfI6iNWeiwuj4G2QlyRsQpWr94JwVgPa5rOZ7f+VoNhi4meFPWFrseVLbyVlnDuCAwou+XHPt3TNhOh7+LnqkKTIUkWJXGulJz+nfQGGNxF7HpA3yg/QsT4Yvcx9qhmeSAU0y6EP8DlxtHnJka/FWQeEw0Nx9WJpn79X8iRAef+h99d59hegTUN0/bpSPCpv9IFAe8lzPzVdgqK25v2lQ/plHMCU3NLhqK6w/Azc4sYdBDZ6x7cFeKP0GKGJM7dKEJjtGn83PG8MqjNNe29fUcH4XS/ae8bNnLqt0h2NVUv7pZP4Q6JKNOhLCZqpLfw2V9JgKdNVpEebeNGn0cP5BuqLnnlkwHTZ0d2Mw0mCxnOsAgJdThzB/ZJ8GFDctPff/uU7SLYdnoPMC3qBfddWcMrijaLAcHNG/Fio7ATITQbxTjtIDu8jdz3a1U3GuF+2O0NDYk4cnWEEt9rxC7xqsrRrJkJYyOaMB0R2OxP3hrCBl5ZfBrU0n7ZtIRX7rqSuevyxefREt8b++aaPMKPU5fXYsNpCH134UhEHSSx+Fl5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199018)(38100700002)(2906002)(186003)(2616005)(26005)(4744005)(6506007)(6512007)(5660300002)(6666004)(7416002)(8936002)(41300700001)(66476007)(8676002)(6486002)(966005)(66946007)(86362001)(66556008)(4326008)(6916009)(316002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OmxGkFlkzrzQNTGoDl412Pa3JTkLKbjJ31hmAKy5T5lUogIDl7iyoKK557B?=
 =?us-ascii?Q?us0wI06KJt384W2elo3OK5ar5FdCwXQUUk6fQCnFCioUFm0KHVy2bHArG0cI?=
 =?us-ascii?Q?ujDcXeg+a18cseJ+uW2B2i/1SYMjPLmRFVCYeL31rHOjc1zcJaaTfDnaz42+?=
 =?us-ascii?Q?Nd8lA+SzMlmdc9Fh1JwO0Q1RZHTdChD7SlVyDXQxGxs63t7f97VN56PzFxaE?=
 =?us-ascii?Q?WPsT2I1w0rnrbdVURb5zmQgwTFSfszWysMuUXvx+jCpgBOAb9p96H7uJwGpa?=
 =?us-ascii?Q?h+FOo43o0GEE/Cw7wgLLIlfkEW2sY4iJ7suy5HSHQY494DMvlCghtXxgF7Be?=
 =?us-ascii?Q?mmOeDPf2UzXf1J6ROjMN8f5ulWFLBlo+ccKMhQ2xZKJDkGbPTQUXGEJff9x9?=
 =?us-ascii?Q?k9W9YQddTKFAjk9wfIGpNeu6lEYDEbuF7iIrdaulXnqMoTulHnqSW5oQHCBQ?=
 =?us-ascii?Q?9qyNW4mguxj+nzD+volAyezd9jty2cW+/GpIXnfVxOKO51fWtJCgAQd80dBN?=
 =?us-ascii?Q?Y5PHbMq+Z7OyJmENIDXZB766HoKLq8/23IS28AwQW1+dC2lRZPeKJZpjiIiX?=
 =?us-ascii?Q?uMfswOe6jBZ+uiYhoUHsE8vDVD8oOJmE/G+RgGYYNvP7UDu2exlSa8mqu1xu?=
 =?us-ascii?Q?dp3T4LStgxFObCKaZNAE8Ix31draomN7ChebbWCXv2e70EVYsA3jAZkCrbPb?=
 =?us-ascii?Q?8r4UAxEXBfDmEqN86NEKHeZQdhFv/Cd/RvEZgK0iKJ1tH2MH4R5yRd1FmMnX?=
 =?us-ascii?Q?EOTI+n7mhsZpwycBU+m/rA5ujbKYaPM9S8EQbtWzbnFXXdGM6eFQHM4xpb9r?=
 =?us-ascii?Q?X8qBvYiHM5CCAg/R8t2xt5h6TsCvz3ZLico7dPNiqp2zGNIU1a8ICje4d7s2?=
 =?us-ascii?Q?r8xAH4Gp1lJ3RwGxgs+xv/DQfoGS4moAO3pKhpS2jfP2W9EHf7hi7KQUDJ3A?=
 =?us-ascii?Q?cHttfcepLDPR3HKr+734vW1adoyLyMC7PhcYWpPHIPtvKaIZd/EvVoufnQOF?=
 =?us-ascii?Q?FcY9S+GRK7fGKliPKwscIwM6K8DPKA2L2wupLPUDTc7Piv95qeR9YH9FSpHw?=
 =?us-ascii?Q?O6qnkP3feKkWXu23MEBvBtia3Ljm+Nh1Ee5TBV0twsKEci/mi8WJNCt/jhED?=
 =?us-ascii?Q?0gfNETufo5S3rwS+U00JOzt5ZusimGdMH5hxT84cSnMCvMiCgsOXvquYDNQU?=
 =?us-ascii?Q?z8zem/ACepgRsGM6zYAcqgg0UtbN5s4Yvs6QdcrcdQlxwytLWYHMYmMGTlI+?=
 =?us-ascii?Q?cbUcM5kG9qnG6OSPtL4h3VWplqXB25wKuNAFgErBCFhplePZQnl0v+yxlkq/?=
 =?us-ascii?Q?ZamebVb/o6kme72G6yK9Vwwp3pSP7dGhutJTIhGory90WdFPy4PQqqBS5YIL?=
 =?us-ascii?Q?Oh5JNSOdE7Ljezq3HEe7cp+MXv4Z0eqcmh9LvATNfvv7iADB/IvcSB6T67h5?=
 =?us-ascii?Q?zrto+GidJKg7kg249nwA0aOS+mupZYX15KzICKG5h4Ep/QtfnVc7n9AdKNs6?=
 =?us-ascii?Q?/Yz2hZVcE18QHRVmvkkOYH4EwKfkDMctDz+TJnzHNORVJ5lGUW51UQEksGAO?=
 =?us-ascii?Q?d4RZJx5X++pzBu322qk/UcucXOg0RbInDmOIr06u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dd4303-9df3-4a2b-2787-08db2189ac82
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:05:39.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yzYd83YoCxky11EWxJ3s8/PaWauczQ3IXiNaJwV17qhYqOZZc4jDFMZkVayeVSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:39:22PM +0100, Eric Auger wrote:

> > Also drop the unused arm_smmu_enable_nesting(). One following patche will
> > configure the correct smmu_domain->stage.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ------------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
> If you go this way you may also remove it from arm/arm-smmu/arm-smmu.c.
> Then if I am not wrong no other driver does implement enable_nesting cb.
> Shouldn't we also remove it and fellow iommu_enable_nesting()?

Yes, lets just put this patch in the series please:

https://lore.kernel.org/kvm/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/

Jason
