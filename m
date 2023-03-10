Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0136E6B3593
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCJEXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCJEWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:22:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BFF7EF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCH/DJRfNE9K2+ddHDmrsWgg3j4qqox6U1e+i/wDV/2YgfnZW/6Sv5LZ+gB1AmBjXoOvgrHcz17XZ6JPrngzgfAVfxo7m3uuyzMqcd8XDKip79mH0NDuMvmTkwlAW1gqgWqIb/CocZuxVr03hkM3BG/eIKqrpa1RRY2fzJE69T9QEoSDpwosxHFiRm0Wvam4Fw5GS71sJ1yhgiuQhUqKu8zQEv9QUQ4AF1N8LSCwnOUD+iZJH3KqmD3jSxLXI0XvOKsHvv8Dc8MbAubA9jIvCOHSaQs6nze4jjtzH88jeWmVQYu9mdy14j57FXP6KHhZPqLYk3168y665C50ulEUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgXEAztKs9b0IfXjQgNfAxuc2TMk5WtHqr8NuhHcU6g=;
 b=Qv5z6JpJgaRW/GDff+PpkRmlmeO3kLqRRZ+SZiLDoT4kqEwWbQ1t2wf22yNc05vP+4pemztebFtdnN5+ZdVf87+HaPXRki/V59gk946X4SDgOeMPMMM5o4ZmgIc0SAhaXE5IdOmmt928wOwIkRrAu5diESGJKNR1vP9on2fvc/CspaBXXnRvn7NFL1nNC5f2KlVwNJusZS9tAmCjr5nRQHkwwHh0P71Dwq3E+RxZyU7pM+PmYc/6+JtnBo7aLI1U+gvM8vv4VVlSuOwB9pr3aoGk8dHXkuJTofi3C2o0aO1hZWJa1S9NIlOcyNcHvxbvwY6n/XtOEmKZuUfZwyyUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgXEAztKs9b0IfXjQgNfAxuc2TMk5WtHqr8NuhHcU6g=;
 b=EHh4mVOafE2jD3rKEDT+V2InhqcuOCn+IE3GjADuffJyHMwAo3T91WZIRKgH/VqnFDZDkd81to5NFs89c2U9N4mn5lybgn8D/LUrKZs1u9qTquGkvOPdhjiUoSy0mkxK5koh+czhddjzkX1OtHMz+v1bAlpHkgZJWuOPHiVaN5dPS15yGWkBRR6KEYYNkoLfhiTZcW6i9tAypCwSqf4K3uWEnn+reLmPTtPyA+ngXZBWDaoLrFA3EJ8PHO5/XnNaX5skPCV6Hy9nU9Ck64RJFrPmNovLnRj/TUWj0J4S3PAoa6LEk9D43Z4mayH1/EzCF3iilEyxPRa1mJjQ7YXbiw==
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 04:20:17 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::cc) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 04:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 04:20:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 20:20:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 20:20:06 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 20:20:05 -0800
Date:   Thu, 9 Mar 2023 20:20:03 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAqv87fjbdynVaHA@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAn7uC9UweiNdGkJ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc000e9-a87c-4a6f-3c99-08db211ec126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kmq6ETRdw03iWd6ldB5FtgDYA+WaqyfRvi0XaaitDRoC5730XKoeDImZaAUHNHWCb3ss7T0mAMhIlGqE2LEHUC+D84FgkbaQZnEP93dMGLobyRj/fXOhcUm/MW5Svc7gxQK6RpdWZaIxn+JdvaPqFZ61Jq79oLr59JhP+aQ9t8P20p5B0OPrIFgd6kmqUVI6O2jGFmOAkrhUiJU0WRfjK28FSoxpxHOFUsuUZmyG0qec8kKHaNxvFDVm0ss/ToXE+biHs1lgpNbXZk7WwbXedfMYdFXqU2frVIQH4MajiJ8yBhfKnEv3Fft75G891NELan5Whnks1/zA0+dopY+n8ZosVhq+NMgipVkJ7d87/C8By1rJDbe66LR85gBW/E0OTTEfbx0B1QSTTVQEuD5GOrsWsfvHLZBuLsgbew1fqQeeB11Iq0NzEmmD2CwlDYp6DEPCWWITN5oeWqpWMAeOfL34qlJGtEDr/BPGsKBvV9dluiHrLhcIs0V1sFWUXt59cQyKS1rkWJU4iSQi53DI84I/oxdvpi7DYJzaP8nQ35sLIAE0yZPugwLTHcQaDG399v6T2tfoBZ1zmv72hl+ZPMeQPh6sTIc3Bh8cjwR7Tl7Aqxme+wMdtTiS9HEDyuw/A2fWmpYCEH3TBdfC7Q2C9WerWxcjZCwz7XPSfQ+liGD+gN+CCcFXZ7FVzdyTopz83KDphbkX43YaqLzFJpLIdPwbBKtV7Wg/YUn4Mokhz0ijF40n6Zkx0aDRUKwvaGSA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(426003)(82740400003)(186003)(26005)(40480700001)(40460700003)(2906002)(70206006)(6862004)(8676002)(4326008)(8936002)(86362001)(70586007)(9686003)(7416002)(336012)(5660300002)(41300700001)(316002)(356005)(7636003)(478600001)(54906003)(55016003)(6636002)(33716001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 04:20:17.3957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc000e9-a87c-4a6f-3c99-08db211ec126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:31:04AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:
> 
> > If the design here is that user_data is so deeply driver-specific and
> > special to the point that it can't possibly be passed as a type-checked
> > union of the known and publicly-visible UAPI types that it is, wouldn't it
> > make sense to just encode the whole thing in the expected format and not
> > have to make these kinds of niggling little conversions at both ends?
> 
> Yes, I suspect the design for ARM should have the input be the entire
> actual command work queue entry. There is no reason to burn CPU cycles
> in userspace marshalling it to something else and then decode it again
> in the kernel. Organize things to point the ioctl directly at the
> queue entry, and the kernel can do a single memcpy from guest
> controlled pages to kernel memory then parse it?

There still can be complications to do something straightforward
like that. Firstly, the consumer and producer indexes might need
to be synced between the host and kernel? Secondly, things like
SID and VMID fields in the commands need to be replaced manually
when the host kernel reads commands out, which means that there
need to be a translation table(s) in the host kernel to replace
those fields. These actually are parts of the features of VCMDQ
hardware itself.

Though I am not sure about the amounts of burning CPU cycles, it
at least can simplify the uAPI a bit and meanwhile address the
multiplying issue at the ATC_INV command that Robin raised, so
long as we ensure the consumer and producer indexes wouldn't be
messed between host and guest?

Thanks
Nic
