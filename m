Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152463A9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiK1Nns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiK1Nnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:43:40 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FD12AE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW+ADaSZfF4mZawQ7QxPxheJQU5FVUZxqFpxkJtoB5Q/WQJK5SbOVa2eU/AFAU8aXIwjUSTHetvOUYoAfITyer6JHTra82JALALlj+U24ZWhOsHZv7rIUNJ+bYG8EcWz6cpE6uIhP3v3kuYr4fX7F8YiZ5sZxfqqy9H7wJOnyvVOCAOvn+P/BsaHh1a/8sV8G29zqHuBbvtrb8jRkggjRbUADOI36OsJOmbSTa2oLOC8IrBLBkMOCBptJjXLp7dg5OHCXyc9oSfZzSeW4mHxDwK8lLHcSrl9Ty3jWzuVykgSFO0CBb8m6iZuB1Ik2OgATXqQWe1yJD8BF09/L7cfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr0B1fm3jmljkTfSeaYQYiq7wNVEDbmsRUqh/B5bReQ=;
 b=j6KID1sp1cYEdqHAOcq8EbkJTOE/8FYIuGsuQZigCm5sgV3dtDNpjJU0r3QVKjf/gbVbzZHBPdQZTXcCWfCCCpqyRzM3mL2g6AIFaf0g+MDzm2aMHdloEeYy71NcZjdPx1fOSrYMaSBzgZzqHrlhFNigi7ikGWqj/83MYy5GFFzch4zWekA/DgS4tpv6Iln8lWC0CyUkmjkOQvwIE4a7w7W3VlwjPdnAXaKTCPB03NGEnNWkhMnIMsiJUHBnvVdpRgEhHScjdODN7MPqd1OGSLsjR74theK55fQ30rKPNu/uL7mU88WC1FEbe30YHrrHL2F/IJwpFmlJBWiz2fkNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr0B1fm3jmljkTfSeaYQYiq7wNVEDbmsRUqh/B5bReQ=;
 b=rdRfvW/QL7dF+O9QDNEOsyhkqCnAecGFlVKERgsdsIRXcuD45Z0gs+mJEi232srwYYyvMjJhrlo0Vpf6eaEYYmGzt6NUG73Ror4t22P5c5466L39uTX8M0h1eibnJBqUsJ15kjR+fVkxLOOlfgtlSIaX/fgVgAYieaEllbzw+tSBYBFpEg4h/1qC11gQfHfq0CWv6akL+ILBszH4x1BTvBuIFagIki/7AEVJOwjUHJhzDIvyKBsQOozLBvxGv0fIfUm6C8hobW+MY2ZkozMXbzeACFKMUC0NI5pwlnIlLfTnD3v6W5zthnhtwmCBK1hXC9ZFP6rFuDW3TRYC2IsvWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:43:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:43:36 +0000
Date:   Mon, 28 Nov 2022 09:43:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/20] iommu/apple-dart: Remove detach_dev callback
Message-ID: <Y4S7B5caPxWYB1XI@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: cce75374-f593-4990-49f1-08dad1468c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8I4tLZsrMlm0iS1tG5Eh6hkbZhuB1k/7QSlK1LH6c4RBcdCkpOYdGkoIEoQNj1E3gpn9nV9SYjdPy297zQ0A5qiiyjbyi4TUA3+T6TOs2vCqHVIiShRzJRfrxnx9wRUQJZ3xXQmBXAOf8PF6sbSMYkrvRIxc0OY1dA2lkRrUqGnesi8FaaTRhQRE5ZAuwK7UHh4jiUxUoURmeTWPAxOhhsHlsS84TFIsuxd7OLcitGrFtqZlRrf1pqaw/uepa4M5r5jZoLI6vZbejNz2JQuX5BTMOhK2Bl7uGaub9M7xrliQAxzp4aX8301bF1s2a83pA3faj2dPC6vvzwPc2jPyvsXM2fDVA5VthORAlpSRsfbfwNKORt0ZTb32gZL2j6E2dUIiSTt8CVZ5GO4LZWMfi7BoRURnHdzikes+1pGWxYjrq9g/p072KBnppztbeutemPVRDhasEJ4pv8HzdrRYZsW5YsQOFxPfH4UAKWrKN6RtL9FfeI6mdbfFRms8SkYz3PfKO2bymbWbT3/RAm7IsoDHcUT3cwQpJrMz5taAYiM7+H/8BPc34vGr1o1u7LDm4f8n4QY2wmt+E29NtAco+q8Dj8MAsx4eZGxwyF6HTqyclsoW2xyDc2pZBFtT02C3k09fHbKUJKQlJBE4jho+sSUrsWj+Wv+IxneX3VvBHpWcdC4WFM2Z8Rn4nPlPjP65
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(47660400002)(451199015)(66946007)(66556008)(66476007)(4744005)(7416002)(8936002)(5660300002)(41300700001)(36756003)(4326008)(86362001)(6506007)(26005)(6512007)(83380400001)(2616005)(186003)(54906003)(6916009)(316002)(6486002)(38100700002)(8676002)(478600001)(2906002)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhsKVPxkcYfzvuYNVHHTazG/T+P90NIyAjzGLs2TaaT8siMgUKrGsITkRf2P?=
 =?us-ascii?Q?QdBuXKTfthHjD8oINv+KfOvpGiWtaLG03nXwKE28RCuxtfMpnnlbXyPoUsPN?=
 =?us-ascii?Q?0VV8GNSJ3ngPkajZ2dcF6YdRHikxcUHKtsSnL+0SIxk8jUmxfY7l+pP7+yu2?=
 =?us-ascii?Q?quIs5+923mmn5pxB1+ISvc0a6QJ69rlj0KcZ4yMfLeEe0Bh+66QzRl//Pq4h?=
 =?us-ascii?Q?PqxkEWBpok6f3GJXOvgmpR+Kly2EyjKBXhpCsaR2ot+h/iDZ4OGaT3tsP7Jl?=
 =?us-ascii?Q?FH2R/Lwx+2aTfeFI/S6peemKS+MESc+7KFpdEDYJZSaumWyyxOGjkrKbVAOW?=
 =?us-ascii?Q?ZxPnKThr+GEWNoQYk0C0SSBbXxcadbbWgdADxi6uR8MBsbd06icc+nNPrx8A?=
 =?us-ascii?Q?AsDzmaKH/Rm6pSMRQsCK4YynPhGC30GjLQ0/YfGgiKOjv1gbbVsttFxZkljG?=
 =?us-ascii?Q?oXnAXIcPiS2+WQHlsQtsNFZ4fxHpIQ0GqfcqTDfNIH3w96+2AJbhDlIP1UL6?=
 =?us-ascii?Q?ROYgVHe7zH3xzTsOQ28jCW4tBoAPDZGfRWK6yIRWe2iD4JDHha74e7DGOmn4?=
 =?us-ascii?Q?v2qYcKUGoAZyZCD89ui7bS80GF/id7iQcvOPeHxGBGCETOQUSEWcWid48e7Y?=
 =?us-ascii?Q?LVWPcx3TWmkPlbWl4xiaorJbXu4rJA+iL/O7vHAFdjqQRGSe1GXfybVXQbba?=
 =?us-ascii?Q?B9QtftQeAVeMBkQ2JEm42QXHfhVtkIGwHAfDQBlzWOa0gmHU2KUw3T61xhb/?=
 =?us-ascii?Q?rPQC+MrqwcG2/UgE9VYS4a5Ep231l2P5VySmMEqiXf5O3VTDaIWVQAhzACfB?=
 =?us-ascii?Q?JfpYp3hxk65zlNftku/csqKEIOX750W1LfMpfFZF5TVfZgg58G7x+huVM5tS?=
 =?us-ascii?Q?hntZ5tRc8iCnqXBnHUDFhf4ml31zf1ZoZRq0PCzdi4mGdSqmnp8y5nymh0+V?=
 =?us-ascii?Q?S5wbSGDkKgrVOBaUCsQBi+jjzD8Sqe3KcFK+moKTiTm0y76gK1eCIJ/ULydY?=
 =?us-ascii?Q?oMHohCnoRGgisEPsDNA9ZHYP+tpgpAwC2PP1RTIk9g+5uFo+y8ckQamBfGNf?=
 =?us-ascii?Q?nR0PHEHSehVmMV4naHWW+9YlAicfvLHETEsFx4xPZFQyFjrXxKlt2zXsTOmB?=
 =?us-ascii?Q?e+OYdePemHnZjUw895tSkmyskpz2uSyUZh6KorB3zdHyQZs82mNhLrqfHszW?=
 =?us-ascii?Q?oEpiWt6qXWCS5QxCl9wfO7K9frADn/35mWXplbsUlUUexrHWQ21v56nOch+4?=
 =?us-ascii?Q?CxdUs1y57P5zPPp3Ankp96dQjHOGvsQQ4zUEGkV8PaXU3qr0/ySajQjU/8gT?=
 =?us-ascii?Q?2OyVG7mzL9jjrcOccBuGzG1pXgpr46bTGsLg5nTAjna3/xlCGn6RvOyPv5L+?=
 =?us-ascii?Q?dnXHeQ5IGlx2tsSgC2BtoBn5SVxx8zMw0Of9Lo/MweKpNNuLkJjcMDWKhgBJ?=
 =?us-ascii?Q?sAZ5ubz2f6rhFLAt2Oo//s8sCfhYCtrWb+0zHNXw/WldzWvbTUT6+0nft3vs?=
 =?us-ascii?Q?j+FMulxNlvFkjC9nvk7RwFNMjWg+aJe9eJs5cTUHPjfJKwGc8cPjIwXCTZVq?=
 =?us-ascii?Q?LeG/iTPn7BzKR3WFahE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce75374-f593-4990-49f1-08dad1468c86
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:43:36.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH5vl+jrxjg8/zjgTO8zNhwu+cNNT5RWamYa6yadw4Ocj1kiiR5WiMm185nLYZUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:30PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/apple-dart.c | 17 -----------------
>  1 file changed, 17 deletions(-)

I suspect this is doing the blocking domain behavior..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
