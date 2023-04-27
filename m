Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB796EFFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbjD0Dhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjD0Dho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:37:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350592718
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DchOZKvTfGHvQD8FRCn/2WtbfssoIMAnBh8hpmZiCjGcHEYn7i8PIJhcL/cZZRkBk5qfdXSje0x4D4oFUrm2Ewb5iDwfVLUAiNZB+E60DavExz59IDC7hxnR5r9LD/PvhTZIJiCXCit5TI4Yi1o+9WcH001bZklxgZPHUCl+1WOkKSxvWAnIUQWVZgmF0SUNrs92oldMNMHw6XtKw3qXwCL+NISpB1i//4GnJ4Xdrxnd7WgiP7KXFCuP/14Mhcfy940qe3Zx0nNnTtv3v9dh1ICjfOE5PW/Yv/9sAdLtGDDvSGCuoGwgg22YBrqIjrj48FUmeBEm44XUDcnE/F7l1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmuxGlMhNnuYlFBlLbqzgsC1JUHPlc9k6jUOb95deMk=;
 b=ItHIASfAmOix7cFxOR8jM3lFhk8foRsauoHYHmo7vllE7zDJKiYBlHKp4cO3seyyDRsfgP2N66IRPxy1UA9nr4X/Tl2tgBO/KqUyFb2pXS7Von1yNM4+ILNNTv4eUT53BZkBlLoKVeNUkBBN6KoVllFgIQ7QF3BxZQQAWA07NfrzBg8tFyqL9bCdTEWO4cut4xbR/UwlhhwGntXR7j1HqIOYEKXI7+pkBi1/AGMCnYUcJirOKifwDDvUC1Z/Dcy0mEpxCoWKQpkhA9TqlAxgGfrn8pucj0kZ21Sd/TusgxSOB84oILrRRP8G1uPt9GJ7pd7Xwro2a/LlzKhZSkoPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmuxGlMhNnuYlFBlLbqzgsC1JUHPlc9k6jUOb95deMk=;
 b=Uv4oo4uqi2Va61iH3h0/cp9AMX7pqNKc3diaJDlZ02Md7Bd7ClEUdNGG12AykfonZm4wkky55sl24MWklaDhpkQ5SDPPH90uLQPJNMMFzE2D2/0Gjok23Z5GJjefHW6J1pmWHLHJF1oomOjSKtjkbMf7W5mvAaJKsX816C/w1ZKR+h6TetF0Vmm4RENLL5qmz42kZ1rq8Oy4yDVMhERdxMcbfRzKSPHvqeXxSGxtdXXlAYmyJhkNPGnbtBnr2LM90OTfnFWW0L7iDDUU0TcQ2JalhnLCLIeNB7fr2aVKJtnJsXN8aovK5vD2fnVPoAqqKrMAcM3if8IBj2lQd2Q61Q==
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 03:37:41 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::e0) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 03:37:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 20:37:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Apr 2023 20:37:32 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 26 Apr 2023 20:37:32 -0700
Date:   Wed, 26 Apr 2023 20:37:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Message-ID: <ZEnt+qyN5EJIzCRf@Asurada-Nvidia>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <ZCGJn3QWhQl4F1dI@nvidia.com>
 <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
 <ZEnFPYvNzF8WFgqO@Asurada-Nvidia>
 <09e4ce6e-0341-8590-b933-795ee28326a3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09e4ce6e-0341-8590-b933-795ee28326a3@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 6777386f-cbc5-4663-39a9-08db46d0c0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jClQYaomXLv6BuYk+fTgirTJF60h7iMXFZobSKxZ4r2QpV9Csxtd/BA6QFdIJI+6nuJntiFhn28rY7L30Demv70h7dMhtXEe5Gsrb9lIZiq/4Vcy14iAkakgz56xUf5JGou13dUzthu61IRhtkrGiZqvjm1wtYLJyPB8QbbtyzQ+uB9cvBIokl+JoV6sQIeO3Uh26b905weZAENBRvWtQvUiRsjQ81cqNnLlu7pbASPNdLliSkoCw+11vxIfndyghDbJMXFh5XKkkYGejsrnMKTClJsSfhPpZZwSvKblpGjAH5xZM5oVQl3/GX4XMpqxXZjCW7/4RzRgWLzIgO20A0KvrrwmOmQG/qYc7jTEsu9hM+uKnSqMEo+eumDXmIhZKuJIyFslKhvkSv5V/sn2rOAwURcgrZkTAPLSxaSa7TsPxndQkqAuni6pHs24DEJtYFTJZhazUBT0zYKfe1ikO21naHnucQDCz85/gQSoSX3oYk9LOqFJG/jLttjci8U37jarZgZG5Sw8bOcayBcl7uNWbXrIhm7OMZxuSs3oK+P8L4iy4q3I1RFEvhWBPq7oJ+9uEDuPt8GPnyMq143Wx0VCte4uxg7+bNxRfiGtbeNwo9FWmHqDypbqRkFlCsJMt5KnKK9miIHEVMVdZqU9hNdG6IB7AZYg9LbiHQzW25tyWz3bbFriVDen0Ac502ZcK5pIC4Rl2B1H9kgkLbkDBSHQ5SH36Hx32/J1n6QSaUglzjXI7/x9yUZrdR2RVZG
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(34020700004)(36860700001)(83380400001)(55016003)(26005)(9686003)(40480700001)(70586007)(54906003)(70206006)(186003)(47076005)(336012)(426003)(41300700001)(7636003)(40460700003)(356005)(5660300002)(316002)(82740400003)(6916009)(4326008)(86362001)(2906002)(8676002)(33716001)(8936002)(82310400005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 03:37:40.2419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6777386f-cbc5-4663-39a9-08db46d0c0bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:20:40AM +0800, Baolu Lu wrote:

> > Attaching WARNINGs:
> > [   19.680725] ------------[ cut here ]------------
> > [   19.681083] WARNING: CPU: 0 PID: 561 at include/linux/mmap_lock.h:161 track_pfn_remap+0xf5/0x100

> > [   19.684817] Call Trace:
> > [   19.684893]  <TASK>
> > [   19.684967]  remap_pfn_range+0x3e/0xa0
> > [   19.685084]  vfio_pci_mmap_fault+0x8a/0x160 [vfio_pci_core]
 
> I took a quick look. It seems that above warnings are irrelevant to this
> commit. Can you please simply revert this commit and check whether there
> are any changes?

I tried on top of the v6.3-rc5 tag. The warnings were triggered
constantly. And reverting the commit fixes it:
nicolinc@Asurada-Nvidia:~/work/mkt/images/nicolinc/src/kernel$ git log --oneline -2
cb3dc9b2417e (HEAD -> v6.3-rc5) Revert "iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()"
7e364e56293b (tag: v6.3-rc5, jgg/linus) Linux 6.3-rc5

I don't think the commit is the causation yet there seems to be
a strong correlation here...

Thanks
Nic
