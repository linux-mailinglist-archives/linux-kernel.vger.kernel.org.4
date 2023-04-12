Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9D6DECDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDLHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDLHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:47:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2840D7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWbw6JHRtFPlyH6EYL9iEGAZCQ/HHx++l9yEtDATuN/kSmnLzLv9u/0+DB1gqWmlDHuASxFAcp9KZruAWpdqfVPiNnkyPQ44Aw/lia/UYap250J60mebceAPenNm34y9p55cE2bTv7WYib8VaNh0QMk2uali9nCuiMTo5ai69CwbsoyfqFS4UxfdaWnem0V7QYMv4+3ZT6y2PXApN/1H58VVsxf0Dz/N+eYnoJAXsRghRWnBlcorbcBAXRQiF6jsEf0yvKJ+P4CsmEjZ6OozPKThIpv09BACs56iZAEiD2ntNvZ+xqPWXtyl2crKlax2XR0Kucc2gKZKlpqeerWfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo8dnMgc/vvHBmY/p2Otsf2NA5zIQpRRRKa+8SZcZDY=;
 b=PVvTyjKfi/RsjEMP2EoqJlG/XS1MI+uGWG9rQvCp0zycIMaf2B543Njo7u3B9q4cr+1E/GqDoRt21YqEdlg95G+qVLpK9UH0pE+TypqFEaR7Y3R701gmC5F+y7Y9p3W27VqoYPdj1O5+INSR5OqmULU/P04ac+TW5J+a+KJ0JqKwDsY451aQ2oUNnrvDhC0nhElqcmtcCItwhApnv3EjpyXLNYR4RffpP0N5iKjmGgVQ5CkbtLW3wgRF7XuQEkG+K1BfevFoRaekM8FI5DoNJ1d7rQGb1QM6VkGSUlMiq41YM0TdK1hPux+tXd/IVeYzuc8cQAKgbYLeZHYcu+WlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo8dnMgc/vvHBmY/p2Otsf2NA5zIQpRRRKa+8SZcZDY=;
 b=DwVsfQd/Wofu62QJ+OxqUo4QSKwRJMhb+4OfA0/pcDpvw0K9eBZMBy2kBts0nP5khFptolWEUyTqJ9ND0sOiveddsCG2NpDv0b/K0KkqkN+7tAZlikRf6xEYNg8k4AXux+i9c9+assrb994udzLNH0ZI9eBUKCC25f0z+MhSxJ//P2PCnt3ujJrJXY/sDc50wV6wiSqNlCjhYcSpqrRHciZ9ozC3Wny8BP9EOK6IzHnifiBfIwslrVnCQEsONELEe+aB2ADcwPnrGf7/EuO4Cg86mbEWQdbXVrKPvKsEpVhIkxQgx1neo8aq/h68yY7wTRjB0nuBefQtq9sWoT4M7w==
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 07:47:34 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::8d) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Wed, 12 Apr 2023 07:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 07:47:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Apr 2023
 00:47:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Apr
 2023 00:47:23 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Apr 2023 00:47:23 -0700
Date:   Wed, 12 Apr 2023 00:47:21 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Message-ID: <ZDZiCUY25pix/NIX@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
 <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
 <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
 <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
 <ZBJfJUjbAUId68s1@Asurada-Nvidia>
 <1d4ff93d-a97e-85bb-4259-9da259bc2ab7@arm.com>
 <ZBN2tmWoRURvjarc@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBN2tmWoRURvjarc@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f83c3d8-7b41-4e59-05e0-08db3b2a2d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGn1hefI9W3tjVit8dtjZcm0f7q5urV1UKQK8PnoWq3ypt6Ja8EsGJ/qdMYcrj5eM2LNVg4uyuir1ezu4dOOKnKA7HSC/jZI/CeX4LiOmFcAijUXmVMMQzTqcyx3X5X5e3+gjy5yZxe3wUF930oFYkYTSxhGfXXkKOLUMYALNpxNvZKqz3R+xi1pke+SBJHy3kNPYEjcEF3Lh3kjZxuMn5y3V1uPtchDZ1I94cLZrBlGMJdRmSw/Q4eV9u2TrerW8elKUCn5B8ya70KoynSARYb1ri14wsSRr/Wmd04XkAulKkasaziIfAXztrEbvCIcSqItAc8sGltfDNJzPXZKby66t0rttJo+v9HZoitsYXbKboOD9gga02aZqw5dIlGq1pr9J77sjsj4uDXqisP48r7vs8yBdYOOikKgXJEjDCWFsMHu1kSdb4YGdeYKQVAh4cXNpV+exTxumZpRM++gY4J2r9nNNvzZsKC3kY0uOJqN4+N4N1Linwr7GUXy9xmPW7Eo45P4USzb4U49HCSx0qJQvZr0ZL+yX15xY/rNLSL4N1lIgBJ6OzZgOiTJKtG7EVATVm9mxJwjbeqPtE3GG/twAkSE7W2wFLYLYwpEmxP/cZbmV9jLDsobnAyqFrwgjg+Ar0O126+kqjouVqT9p0MUquakgAsnyhzDvVIu1ku0fDvpFbQ6LkP8hYbKetzo7+TdNViYqhTOzQNkhd/TGDDfrIJ+oWrUYGomfEW87IAReLv2kUhkc9qLzyWelvz8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(55016003)(40460700003)(40480700001)(7416002)(5660300002)(6916009)(86362001)(4326008)(8676002)(70586007)(70206006)(33716001)(478600001)(316002)(82310400005)(36860700001)(82740400003)(356005)(7636003)(54906003)(2906002)(83380400001)(9686003)(186003)(426003)(336012)(47076005)(41300700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 07:47:33.8487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f83c3d8-7b41-4e59-05e0-08db3b2a2d69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, Mar 16, 2023 at 01:06:17PM -0700, Nicolin Chen wrote:
> On Thu, Mar 16, 2023 at 03:19:27PM +0000, Robin Murphy wrote:
> 
> > > > Note that until now it has been extremely fortunate that in pretty much
> > > > every case Linux either hasn't supported the affected feature at all, or
> > > > has happened to avoid meeting the conditions. Once we do introduce
> > > > nesting support that all goes out the window (and I'll have to think
> > > > more when reviewing new errata in future...)
> > > > 
> > > > I've been putting off revisiting all the existing errata to figure out
> > > > what we'd need to do until new nesting patches appeared, so I'll try to
> > > > get to that soon now. I think in many cases it's likely to be best to
> > > > just disallowing nesting entirely on affected implementations.
> > > 
> > > Do we have already a list of "affected implementations"? Or,
> > > we would need to make such a list now? In a latter case, can
> > > these affected implementations be detected from their IRD0-5
> > > registers, so that we can simply do something in hw_info()?
> > 
> > Somewhere I have a patch that adds all the IIDR stuff needed for this,
> > but I never sent it upstream since the erratum itself was an early
> > MMU-600 one which in practice doesn't matter. I'll dig that out and
> > update it with what I have in mind.
> 
> Nice!
> 
> Perhaps we should merge that first, or include in this series
> if you don't mind, so that we would be less worried about any
> affected platform when releasing the new Linux version having
> this nesting feature.

I just want to see if there's a possibility of adding the
patch that you mentioned above in the near term?

I'd like to send a v2 of this series for another round of
review before the next -rc1, so it'd be nicer to include
that.

Thanks
Nic
