Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11216F0AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjD0RZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243706AbjD0RZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:25:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458E3595
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDbI01bhlMbeebvobEI27pa29nXKMzgJ9RRHfbCGBmVZniw8b9F/TyjXhd8Y6kBb3lct2HB3pLsEOatrt7Fxie0VTsUd6MG96HP6d6XJJKjIOZ5mJw5ouQaNJCqYeVqZnnzxi3Dj48Chm3ONiXf859KMK8POnMkL1b48jn2VIa+yHNW9jENpPKZYfKhwWzSWQZG7VSrAEqxVKiKVVNDP0d8Up1jeZrjOduK77qcf23VF8l/NnU5SUZlQUUymJGGmu/WgiKfp4NOk+KJ3KjDkn44WdU9/g2swLUBBjtPHNKzqT+qLwWgPnU/QRbm7OFxe2R42qH616PhqcRnNuM29pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6HTymKgOASTuCDp+oKy2k6w0exLMl0CinXtf246PGI=;
 b=PdPgf5zvmizp+dBwpmgDPoGqnqwf8twabA48hy5XD2YjY9tPeqW//9RW5DnAv1kPN6aUZ98lIPWFXNRj5Abb4cqnyWuBhzoTaLGzwQ5mla2ha95PFlN8GVmIw0NEdyi7QowFZtaDRdAWvxLbnphITRLpj4Os4el2iweo6LxA9DkN/8srnr6DGpm2KazUO1nbO8HH/tfW/4IoAOqndryJ/1tkBhhkL7ePzAdSXvBfOBSWRqcH5F9Dmg4OsFpD7VFQxyVVZpwm23DF9HP/FU8ffjd77gNrU2cmnWJdx3kB4e5c3pCQwys+AAAVASt6BkI78q49j5mECnZ/hoa/1QnYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6HTymKgOASTuCDp+oKy2k6w0exLMl0CinXtf246PGI=;
 b=licHemh/ZOW4joNxEcPeFe7XocraEDTSB/JSKjCyuMhhhd6t8ScuBE/OUudEHd0Cunty2/lu39VkpB/Op7GuQOFtzCsKfN7DjchRmePTWBBn8PP1z5h77xaMEop6Bebx1ACHgOP5IlbTY4xtYs/OK+VKiO1n8AOtNIXenhADt+hIO1yOW6/iKNLesPkkmd8sydr1Z5HwAbUyxhOg6O18JAdwLlD7TC19DQ1X1Xa+exjePOZa6lRUKb4nzJjh0SEsA54LS4EE9fDWGT+jbHxhE9cRE5ntJWF7Mjd7h4Bluesrna8iBrUQrQRJS77PdMPfdTQEW2eqY6IsmXccyGM8wg==
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:25:10 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::fc) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 17:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 17:25:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 10:24:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 10:24:59 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Apr 2023 10:24:58 -0700
Date:   Thu, 27 Apr 2023 10:24:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Message-ID: <ZEqvs/QVyoD5G8/t@Asurada-Nvidia>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <ZCGJn3QWhQl4F1dI@nvidia.com>
 <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
 <ZEnFPYvNzF8WFgqO@Asurada-Nvidia>
 <09e4ce6e-0341-8590-b933-795ee28326a3@linux.intel.com>
 <ZEnt+qyN5EJIzCRf@Asurada-Nvidia>
 <d89938b0-191f-8037-70c1-4f054b527c42@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d89938b0-191f-8037-70c1-4f054b527c42@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f97d654-90f4-438c-29e1-08db47445a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkk8EYOEcDO855qUZs5deNM7Xa5JwlvxxukfdLi9XAPAEVxe3G58FZTo1SsCIujak0DTte9YgyluKebshv272TombnoGasiDIY20TQrGjw37Nuc5OC5WNTlRZ+kFKpJ3kcANOz4j/Nzq6+i4WscmihP5ltn8ax8vH9K2hI00btvQtwwVpSKvqxBzIhbKbsUvPDiPimOoBDFOKBw3KRlYI+ASMieYXd4PYkhCRmby4gz75SN3zAFLFTZ8M5lfNPnWwpexqEplAHneaNYAk+fG34mU434e6xT29nysZmnkctUWTfdKVOm/a41CoJfW43kC3jhRae+6Vgh6Act+obKa9YnIKo7NFhVmtKJHWyQGi/JWwkWkqzDI5M17trYHcK831deHCA58z/LvN40u5hPmhr8XchYc4l0tou0KMoEKrKmkEQ0PUYsDcNjyZVcNZU5fkfsUcSLFi2axVU5Q09Y4CP3fGWqF0+8j26Xv06H0a3sk/hQXqIBSExH6J1EFUgQkMQGsj2VM0t3RVDBVvwL2VF/7VPemcxwoqAT4AqoLybSIi+wjvhtzcN3tzfrw+mCfKeOOYcQwfqkxLWLHW57UH76IFOvLUmfw0mI4GCg1aOwJcDNX1xBb7uHs6KzvLtu6PEqxe9Wtyr36xZoCRcnXgZZ1pexPynMeJjZ2kDBJmeq8zDNX2ohXKKHLHdEkaNMpEnCuwDJj+6Xvp8SN0W94xfluX6qTiwwcgVWwufSJq7A=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(53546011)(41300700001)(26005)(9686003)(2906002)(47076005)(55016003)(5660300002)(8676002)(40480700001)(8936002)(336012)(426003)(40460700003)(34020700004)(478600001)(33716001)(83380400001)(7636003)(356005)(54906003)(186003)(82740400003)(36860700001)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:25:09.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f97d654-90f4-438c-29e1-08db47445a3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:35:11AM +0100, Robin Murphy wrote:
> On 2023-04-27 04:37, Nicolin Chen wrote:
> > On Thu, Apr 27, 2023 at 11:20:40AM +0800, Baolu Lu wrote:
> > 
> > > > Attaching WARNINGs:
> > > > [   19.680725] ------------[ cut here ]------------
> > > > [   19.681083] WARNING: CPU: 0 PID: 561 at include/linux/mmap_lock.h:161 track_pfn_remap+0xf5/0x100
> > 
> > > > [   19.684817] Call Trace:
> > > > [   19.684893]  <TASK>
> > > > [   19.684967]  remap_pfn_range+0x3e/0xa0
> > > > [   19.685084]  vfio_pci_mmap_fault+0x8a/0x160 [vfio_pci_core]
> > 
> > > I took a quick look. It seems that above warnings are irrelevant to this
> > > commit. Can you please simply revert this commit and check whether there
> > > are any changes?
> > 
> > I tried on top of the v6.3-rc5 tag. The warnings were triggered
> > constantly. And reverting the commit fixes it:
> > nicolinc@Asurada-Nvidia:~/work/mkt/images/nicolinc/src/kernel$ git log --oneline -2
> > cb3dc9b2417e (HEAD -> v6.3-rc5) Revert "iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()"
> > 7e364e56293b (tag: v6.3-rc5, jgg/linus) Linux 6.3-rc5
> > 
> > I don't think the commit is the causation yet there seems to be
> > a strong correlation here...
> 
> The correlation is probably that you're now getting to see a genuine
> warning from lockdep_assert_held(), since intel-iommu is no longer
> causing debug_locks to be turned off earlier.

Hmm, looks like so. The mmap_lock is held with a read permission,
in arch/x86/mm/fault.c file, v.s. the expectation of a write one
by remap_pfn_range().

Thanks
Nicolin
