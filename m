Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5E6232DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiKISr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKISrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:47:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483BDB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1HUTLVu08e4n2xK6QFO1+Ie8klHSPv0wCif2v1qisoqADSrskhK2LkUqjvfTNy8vlb0mEyni8EEF3vCZ2X+yEtf/Ofspnm0ptO8thUXLtNI7059h7xcixBor2ShD+fx1JBn1xZD0EdB6NL7lJ7mIR5+ArQn7oYePOg8NMz8HLUje5xXWkfYovwESoUE9g+Vw54DwcFK/P6VWZ5B//18b/g7/7c7PsBpiPsjfwRqUdE7Zh45d2vZoeQtn83F4suU7pvGHs8AflCCjY35u8RI8X++BHlR14zVdY980bSzHABJ0YyalE4GvIqS/LbV2RqgdzkUBbaGbTDbh3owKH/4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBty1l4hMLabYNWgf1dMFOtqobPwttwq/8XIjn2lRNA=;
 b=EO4W9K89rFQyazGNprXrrrojl6Pisthj8+MPgMpvFkdypFLd84aItY5a7fndsI0S3+ewSv/Jb4uegZkk2NOjxxsmcr60srG9g6y9fL3IXhp8jgP5VpCo9OL+Gcx7JIyDF1J8WPbH6MqBco6GcxYoq5bvN9m7kRgrVW/YRZ3WEUv9v9Z4Dy+mmBUURCDNt88GI1bH1XPwTkqj/IHSQrU2nyRteYAbf6LLd1RGuD8dENxQFeoqpfTGdjHvGR5q0ApBGnz/7sEHcgsvZfg6Szgr4yVUJ+RnsaGcxvOOoNS3i7vzdktTtimH1Kg167ZGL5bxjO6+fYzRDu8HN9wdGgBPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBty1l4hMLabYNWgf1dMFOtqobPwttwq/8XIjn2lRNA=;
 b=SN0LlTbqn9RQxGRdLeTszQ7TrxIXSerxXGmWmbAhj2wEuy8HeiwcnAgkvbqyUNTf2TxKzVMo8PBYRxmiy56nA5R0TkoZhOwUkK9FsxwnB9lmNg59IrEZkSJCciJogyHqOke6DSYLWWI9rLWwJ72sQnIO38/FbHZtGiY2eJ7fRcDRa7jtbzoUWrAX7x3/RFFRY3zsdf4lWJOgKfvERdgS6Fa97LC63qd7hFHsxrc13bm0mp4DuK8TI8pAhernZthpIWUgirzHxB7VVp0OyXSZQLm5iv0uCbRVgdHkaiGW4ZEnQLOuhWYy40hJiUrIEFeBb16ZCegM2nDfMRonw/smeQ==
Received: from MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49) by
 PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 18:47:50 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::46) by MW2PR16CA0036.outlook.office365.com
 (2603:10b6:907::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Wed, 9 Nov 2022 18:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 18:47:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 10:47:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 10:47:36 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 10:47:36 -0800
Date:   Wed, 9 Nov 2022 10:47:35 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <joro@8bytes.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Restore prints in
 arm_smmu_attach_dev()
Message-ID: <Y2v1x6F31X6F/VHS@Asurada-Nvidia>
References: <20221109070713.9617-1-nicolinc@nvidia.com>
 <Y2unGf7trHbfPh1v@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2unGf7trHbfPh1v@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5a4d7f-cdaa-4291-7af7-08dac282e706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ky8KrxwhsbXUeU+dXVhn7zHCYCvNM2bEj0KtkBgNUL7Md2Um7BqxrCGX7ojVIHCxaFV1TVPBOpPUHEEZwooCkWnglG5UQ1I85j03nEDPIAISUK3QoFUjZeGu1y61h9KaEHDH+pCQhdkfpO7DN40M9N+L/j0u96sioq4gigiDBfbtdhOb09GUNgv0cQom2IfeSB116QppybslG98V0U2TII6gqGiDiX/R1miOJfBUIhWte32Z1Qh5hWQ+BKTJ0JGAuAk03lnvBW4ud7/x4MZTxMpNosywotUAvj+mcmm5nYOntWoABunY4rJ+wUyQ9mf+h/bpshhnE8vSw/gZxsbzIqZD8InmXohScUhB6/XoBkKv/2bFRrMuqo+Xe5KgnmDezbRcO+kKT14NOS0/LQTdyIlBbu5AUr0vfKA2JmX+CsnTd56E8LTIs5pgPAwiiaKGI5qR9JzmSxfQ5fK6bosOSKROy8I7Exz25ugGD6ZPHxf6QD/oQEYGQzSSabyH+oH/eiuHtw2POlaEMiFk/EtBqV0Qwcsfe/eGq477MIJNjL6W4M7SWSquVRLUlSn8eyqD39RRy2Fcvz5oMj1fLANSJ2bTuKmPJI9GLPqPaffkA70rnNcsEaMdTObM2XYl5TLklPwWWCZME90u9NoR8RG/FfM4jxNQoNSeu9aNkIaD80N9H2zxy2TSJplezuP87awT/kfPhanlO9Cy0SRDbjE+KKQc+K3fXx/4zc3YF7ONh6iIyPD7Ri5At6dATp/67JNcnlnuTsHJpucXdKT/ALEdEg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(4744005)(6862004)(8936002)(70586007)(478600001)(41300700001)(5660300002)(316002)(6636002)(54906003)(55016003)(40480700001)(82740400003)(7636003)(356005)(26005)(186003)(9686003)(336012)(4326008)(66899015)(8676002)(82310400005)(70206006)(2906002)(86362001)(40460700003)(47076005)(36860700001)(33716001)(426003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 18:47:50.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a4d7f-cdaa-4291-7af7-08dac282e706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:11:53AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 08, 2022 at 11:07:13PM -0800, Nicolin Chen wrote:
> > The prints for incompatible failures in arm_smmu_attach_dev() might be
> > still useful for error diagnosis. As VFIO and IOMMUFD would do testing
> > attach() call, having previous dev_err() isn't ideal either.
> > 
> > Add the prints back using dev_dbg().
> > 
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> You should probably include a fixes line
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Just sent a v2 adding "Fixes" and "Reviewed-by". Thanks!
