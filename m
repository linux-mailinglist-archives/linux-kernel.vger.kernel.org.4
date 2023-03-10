Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978816B35DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCJFEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCJFEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:04:39 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E35CD642
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJyiue+O8tHU5iB/C6CiDJfvfi+YbwtCwus9KzDmJm725h1ZpxM+NPW51lQleEfDuPCzSy2IkugxtvbNdKrogSKWRM4BJBnXeN/gP9/cqUhGMM0v93Hc0iR3wdc16LBnxG2mLEizyMnENPPkxX5tgXhLgkd7HjKo4O6suTBll1Rm2jSUc/49eaXIMTdEvujCePIRaXPAJJg8kfPuWWArzMKdGmBXgosT5HNoa5b8SKTIAtoKLIRccpUtCMebh/pfG3TqL3DS63maLYojYrIH5qLHUU/HnfZJKAauhIumyDR9Pd8SsMKzolfTMyDrXxsTLJqWLl/uet0hROhTAKX/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nrkkIJYOyJ8xMVAHQcJ7JVQU5V+MSPytuMt6KScULE=;
 b=ZTiB+bmJPrx9zMYJKrWqv7qjcm7ISZAq8lF/+wihrXQDxOvRJUP8/i1fbDgQmcK7JCy74yjqGG2XnMnq5USW+eZK7CHgeVoBq0RD2/HI5mWccko0DL6eBzfWJKOgPWvtc/mdEhlQkLlHq+T6/2ZSsw8RyhGkdNebdol4Y2lg8zdRJwS5qtaMxbGBgIOP3vBcW6jjYM46XVWHc4vnBisqyYQvlpZI+C9EAFzx0tJTDZb8v2hoTKOIGge6tRKQltYXohsYbTpDUCJjgofzcQuSfD/pF9SvS1GjwhC6oJD/CsKWNuJovBoLCjcLdJmiywLlhiAhsevH7PTHoef2jDDYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nrkkIJYOyJ8xMVAHQcJ7JVQU5V+MSPytuMt6KScULE=;
 b=Jf+WG9iRixyUMPkkbuGTltvY3aeLeVGLsHhRwhiwgPRUG3VawgAPb4/0N8APUYsLvREpKoziMHzOhdGhoxstCRAPEc0+udocvob9K7wFkIDDOS0qF0DriImtpQXfD1Y0KQwPBj3bwzlsI7LmjE92+NDPRVshTzLkyJCZAcz2HaAQdm+JrybRIRLhr/kadhbmdXmjWo72Tas/viqDS71S2GkoFLCy+u6wUR0JXW5A33tsY7OXv4nLWNWT3CGIDZ0q3qNoRDAGQY4AqzDFYgfnIVoaTB66KLUIdJT0WSOWc3z7LMhcWOOFxMrkVM/K1YA0k3iou+dF40HBq4C7IELgyw==
Received: from CY5PR15CA0122.namprd15.prod.outlook.com (2603:10b6:930:68::6)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:04:35 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:68:cafe::53) by CY5PR15CA0122.outlook.office365.com
 (2603:10b6:930:68::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 05:04:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:04:22 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:04:22 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:04:21 -0800
Date:   Thu, 9 Mar 2023 21:04:20 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAq6VKmDbVT63cot@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230309134217.GA1673607@myrica>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 598f0bd8-52b8-4618-18d6-08db2124f107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HulZdZPHGb/3w7/HEEl3M19ptbInsPDi+n9P4Lgx+MoAtk0TxajpSGW6DUnGHmg2GpErG5w0wPUCmVSgyo0+5tUHAktE6B2TGCo/u8YK6/NHH2jidJSoUGQJFa9fPiWi/yF8xZsIr52BMvNxnVPpPYNXWIc0cm9VI+/NxkUQ/4HKb1JUOkAllztcBecMcxTYcv7OCa/3PEc2p9cIAebOL9jd3T3Jszuh0RUXvQSpg6NsA4iDLT/M4cTM8fa6seIhuXZML6B708X3WJlQFJdelUwCxiZ460Cb505m9GtwEtQIyK8zh4aa6V1fAYeHt6N3pLdyAhMYoi/p5q1f70HYfhnAwvpBPq5PNRWjjTEW6rl3RKQV7aBO4KPXWgabeFc/XRMB/H/5//sew9+YH1Dn4zPSFmxqyqxCBMQAhV8SVD3CcuGfOMYpwEV/sgk/0tNwmkjP2gXL+j4d9x8s5hB+mQA5OiTnx6hQrI8Z2Tcy2v7jWLTJp0kKf8FGNyi4uPk9tNjRhuONiZNVDZbSmQp3DnvepcAM0kd+3o/6kefwL0EJ0IUtQoO6ant8oiARuCUdRagT7VMuybx2ECQH99g0Kk6iIK2FiGZY3X3fMFKGvwBKQ1SdoJhfdltgdDCm9q6iZYQYFRTsB3220Y139vLyzuoy+4F8zmlrEcW9CxX1tpoK+3Hiva2kGYw5f6IFPdCYf1nrJoPLYvdNdqTUbD2i3VcmVZoH1emw98rhDCzdyXVNNTTY1H0fWvVJPNoje77d
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(33716001)(82740400003)(36860700001)(83380400001)(426003)(47076005)(7636003)(54906003)(478600001)(40480700001)(55016003)(356005)(316002)(336012)(40460700003)(26005)(9686003)(186003)(5660300002)(7416002)(8676002)(8936002)(41300700001)(70206006)(4326008)(2906002)(70586007)(86362001)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:04:34.8277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598f0bd8-52b8-4618-18d6-08db2124f107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeans,

Allow me to partially reply your email:

On Thu, Mar 09, 2023 at 01:42:17PM +0000, Jean-Philippe Brucker wrote:

> > +struct iommu_hwpt_arm_smmuv3 {
> > +#define IOMMU_SMMUV3_FLAG_S2 (1 << 0) /* if unset, stage-1 */
> 
> I don't understand the purpose of this flag, since the structure only
> provides stage-1 configuration fields

I should have probably put more description for this flag. It
is used to allocate a stage-2 domain for a nested translation
setup. The default allocation for a kernel-managed domain will
allocate an S1 format of IO page table, at ARM_SMMU_DOMAIN_S1
stage. But a nested kernel-managed domain needs an S2 format,
at ARM_SMMU_DOMAIN_S2.
	
So the whole structure seems to only provide stage-1 info but
it's used for both stages. And a stage-2 allocation will only
need s2vmid if VMID flag is set (explaining below).

> > +#define IOMMU_SMMUV3_FLAG_VMID       (1 << 1) /* vmid override */
> 
> Doesn't this break isolation?  The VMID space is global for the SMMU, so
> the guest could access cached mappings of another device

This flag isn't mature yet. I kept it from my internal RFC to
see if we can have a better solution. There are use cases on
certain platforms where the VMIDs across all devices in the
same VM need to be aligned.

Thanks
Nic
