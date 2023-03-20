Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26346C19B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjCTPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjCTPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:36:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24C3B20E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l64i/T0W6l+anRPKZjBuTL/tXZqa0FkQvw4UfgxbElYmDxq/2/H0fZI1fOAB05L1Wl9UrCfEkWSkMkiJ8IsKPXnADNPc+IbjVTn0AzlQNrHxj1lKrR8+tdXbKWPKH6k6fDngPjKo03D4j3ovCiCFd0CEbE0vinvs8SeSJ6RfANyi/X7l2uI6HF4Fh71N5NFWgrpbOdsbIi3T7+zvkK9/ahkOqYWDdxLffHFUw+w5EXCWOy5qdZLpJOwkRaxJlVL9lMVVpL2Gju8GYsLbMt4PM5CdsLghfU7+BNB1/DAm0giszByLs63nmwmM744UbFDRWDwVoxxCCzutqPA5cL37Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY6pcDLXFcLwOyXj6QmLGjLpta81kLlehxMD6uxguBU=;
 b=ILopg9gFVp2YPrkMN7jLYQKWJ1JRKSACq3WHOQpJbbGHjXNpoESxvsNkIbHsA/i6Y9hqMOX0+F1UdDoRy4Gdtd8gTyk/mjep1LQLyfLqz1kzkrTyOfbTXpiQnRcNA/sSkjDGVZJFMreuGFXUvdjag1DP7yJFOQFq2Syc/e1s6iNnpgjXRYQhTIROiOXeoX52Bx8kc6F0BhTZwv0KQd3ESfw4wjGWBsJ78bIVfUqPzsbVbCO2WPm/nKotO/6LU9mwWPITSNn5a2UuwwQzG9pGSGhsWazsTM2+ZjOISUhEUX0zJ91XZ/hglm2yqZx9s2T+31SWagVzght+vvQaDVfmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY6pcDLXFcLwOyXj6QmLGjLpta81kLlehxMD6uxguBU=;
 b=l60jinrD3SOx0MMv94FH3kBR3P1DE0GntJpjUntRSJocLHbljXCc/9ahauAtVAdD6PL5PR7troo0ElzmuVVGnHI3thn8zwGCR7VPbeOMMM1qYhEmdqLi5eLLVu5Tg4hzJYaJy8RPlObYKTQ69wD8uZLAQ4s89K2FoK7jX/BhZjBWzfncITXTJhxEaRxzaZyr2PctvVUNtBtH6D/tYRF5PlBVznt1CSXfOB9KS6kx9G1h7pkQlUMu5/Q+gEJgFlN2VRI2Hat6rZHgDjPF2iAbt6HrMCCVEmXLpLUAk0COwesZfd+Tev8/c4rkNbmXYw3lj8mUfZAUEwNbQy4bADo2QA==
Received: from DM6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:5:60::18) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:28:20 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::87) by DM6PR10CA0005.outlook.office365.com
 (2603:10b6:5:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 15:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 15:28:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 08:28:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 08:28:08 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 08:28:07 -0700
Date:   Mon, 20 Mar 2023 08:28:05 -0700
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
Message-ID: <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
References: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBhbmqprnux4q00i@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: fd61a141-e980-474b-2b7a-08db2957bc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdHorfnLGxZSHFcPnQzqtAvWCQsu+8zC2/q3x9ZKfJlLJtT35FgnDjO7X+TdOqIXJJ/gn3Pacpwyv/LmXpq9uBQle7mcxharPxul+5637f9hi0qtaKP4lUkpLgXSJDg+Bu3Vdro4SHin1fLjazrK4Z+NR4kGGR0oenQgkCS2ADrkamTXkmkN3YQ6UGXOs2/qSdEhDCRe4vwOg32QYhsgK+zEN1EQFr7PUYN3PajH21XSCM4OM62NQ05ybWjtjH6Hmt2PRIFBIiQkoZxUYYexecMuU68DIDDN5PiN0W8yBtT2LmVBltVkUaiGtRUTiaml2OAOB+2VgUT5BGWOMtDmkea7oSgvDIgKzfEmlQ7hbGR2U82ZY0nbLoILKjGrQm/13zo7nMXC3+6P21jlW4hHdk/1xnPDFoiEggD3fZuJ4HpV8Vaz4EkkWSnZhDQhgf4Vhf3+CrvjPGOQ5glbgR6boWYrM68BGbdG05xDX146Sfg/Wii1oT3UN9pssEAit+FkwkbrWF3DFouWm/Rr8Awrsxe6QtxKezbO5nOI8qDeEbEFvrQ69vbvZctOQaZFpQioH2UUkmFrPJq2R66XxcqZprO6PE/F5rbbwmY37E+oBfpEEo6eVZfj8yW+roS1f/766qXwUaUHnsdT0KDjUIabEXOcalpyjGqQaYwlWCstoNbBIfQbwloPHGCaTa+uvJdbn+uaw4SXNpdbsKTucok17VsnDblQ+FoMZsCCZMfCfFHcGz3LMrtdTGj1T72+HI8sFpCq6N11XQ5zIBcE5Oc06w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(316002)(82310400005)(83380400001)(6636002)(426003)(47076005)(336012)(86362001)(356005)(7636003)(55016003)(36860700001)(70206006)(40460700003)(82740400003)(40480700001)(8676002)(41300700001)(70586007)(2906002)(4744005)(8936002)(6862004)(4326008)(5660300002)(186003)(26005)(7416002)(54906003)(9686003)(478600001)(33716001)(341764005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:28:19.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61a141-e980-474b-2b7a-08db2957bc30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:11:54AM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 19, 2023 at 06:32:03PM -0700, Nicolin Chen wrote:
> 
> > +struct iommu_hwpt_invalidate_arm_smmuv3 {
> > +       struct iommu_iova_range range;
> 
> what is this?

Not used. A copy-n-paste mistake :(

> 
> > +       __u64 cmd[2];
> > +};
> 
> You still have to do something with the SID. We can't just allow any
> un-validated SID value - the driver has to check the incoming SID
> against allowed SIDs for this iommufd_ctx

Hmm, that's something "missing" even in the current design.

Yet, most of the TLBI commands don't hold an SID field. So,
the hypervisor only trapping a queue write-pointer movement
cannot get the exact vSID for a TLBI command. What our QEMU
code currently does is simply broadcasting all the devices
on the list of attaching devices to the vSMMU, which means
that such an enforcement in the kernel would basically just
allow any vSID (device) that's attached to the domain?

Thanks
Nic
