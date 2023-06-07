Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E95725DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbjFGMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjFGMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:00:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19880184
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv/VRcVy5Xuv5WhvUP3YhpIvf57rSleH/zBtJu18dvds5Q1QTy+1ehYcAahA/JbXfqhogKLZ0ylu6eZ2kh1dWFxg+/SsvxyUVuvFHRtlBi2ewGgFPXqqWP3e/vc0Row826RNqqNKzv79oNIGKRBWNapRGWwQr39iAuYbaBTwzbvPXFvaxMqnKnZHtbW/j/OEOaf1HX8aOEsXq8+SVaERtFAjzxXXTC+8wEBk3C9sUeaAH1TbTUxdbalUmRQRpDjRmTpJ3Lq3gD7Yd+OWiMSmCiXGxDbr/qbCvqch0QIOYwTtAEz+22AQjGHxW2bxDisYjR90cfQ5CS8aEEPQhIF30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V17/DRSGkRxRC7p6MR2MdcKAUdZg1LtxpglUBLNNnOg=;
 b=BBNsVN0Pw2WmNs+Bq6Vktm9GwZnfE8V+YcSw9Q/Siu5Asg3BzLkXjydbay9FY3KyfQJ7Rvek3Gw/J+6C6CaxvrzC3xJrqqOABBoHpiv6oW1zmHNw3TFR/uEhQHqM3GSZqbpj5d6pWSTY1SY+yc3qO+3/BbFrbDQaabwncqINPn6jCowoFlMW/hQyB9Ocwn6/gFu5YujnocBvF3Rf8vhDys5h0+ickH6gPLx4ytMOCjBYcmDFScNbESjMsXvU8R7lJChalJ4jZdJX5r42x46bwCC2uWc/ACm3NfntXuzgSoVbSrbNG185bG2vcvAN+PN5nb4I5Liq7BrkQsN73h1WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V17/DRSGkRxRC7p6MR2MdcKAUdZg1LtxpglUBLNNnOg=;
 b=FDU9FX8X6O6wAZHSmplPCJNRo/TYev5bRBJWo27wwRzaBuo0uJ9FyatM8Xzbz83Tk863IRvyQFFQUCgz7GjofdihN3oTmZxlTO74EPRylavhhH6IbYz4Mz4oOhkITqjt9p6VP+kCgzGLPoPejJCZB0W6seUVUxgw3eyfsuP3lQ2HH4tmxeaOOovCaAZxC7vBMPLYsu80sR6yKB4v38QB2oQD1MtCATWZd7B5cKvF8YFo3rD6R/wF80gpvWayaQDPKJtjN4LqXxcyHsxaZOmKQEfi0vZvl0H++VV4JejDB0ehZu28viId5Q0ueYq/AQc91w9Dt+NQFB3Uxdk1UdjQxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 12:00:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:00:00 +0000
Date:   Wed, 7 Jun 2023 08:59:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZIBxPd1/JCAle6yP@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 297f08ae-620a-4c3e-4dad-08db674eb876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRs0gHWmGvyXbzQUC6HeQRGL6uK/hwspo3SvZYvT5Mwy+kMDzhbol5NhA8KOuCjimTfG3Uhh1xnIfYl0xX3L5aRtDqd1juSuBh9Q7HltlHimrrg9jmDGL9cXQJGOlp7MaEiaRYfM0IhUqyYxXJSWE3f6iYyiI/WhxKWZ/n2EKgNon37cwXg/ZRKNynsgMVcZf6NkiRcOiBQ7YDvw3AszcxijmYdVjDhTc38Sq0LI9YgtdFM6Bx3fNLQXT+WMN8bEddq2mNyN1a8zy8Zw4XfrYoTbxhU8XbHYbFTK1Nfr41CeV8evj5AnTxLximrKghdCeeenFma/JvZS3Ckydk4brSi7xw2p7VkKc+kWz/ZrUOB2Vgrg4SSc9RnIAsttPSpL6ahjnRqts5t0/2exGT1NFzXhIxJne+dZ3iIoVfd3IPpeAJ7nrYiJ0Kf2InxO6Oi0Pq9jmPYDpGJwtBnsmGeQWESMHjQ0rNk/O5DHi7clkxU+vPQYfa9oBcM1rCfd80WjzuSzB5iIl9XuO6fMG0RdiFsFTNK813ernzdNeZIoIHIag34o24nat1spxnL2auNo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(478600001)(2906002)(83380400001)(2616005)(186003)(6512007)(6506007)(26005)(86362001)(38100700002)(6486002)(36756003)(6666004)(5660300002)(8936002)(8676002)(41300700001)(6916009)(4326008)(66476007)(66946007)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GW4Zo9cRhe1qeDidqTTa8A9kkCOJxD4D3k7X29NsP8vCKlCaD5QAYVnKvqy9?=
 =?us-ascii?Q?EAq0IjyJywhDwf5N8bN42bEclY2FIrlCU6azkjrIPwXeJ69tGF4oXk5e2LCA?=
 =?us-ascii?Q?tvG3N2qBasWtneBacLv96LXxWmsRtfSLjsMcOVhyYl9UtXEem/88vIkhAKVk?=
 =?us-ascii?Q?ixFP6l6RgkcW3M8ixaA3jEhr2oUYfeqWh8zt+QOeP3pH9tLDLcNir5KeTBAj?=
 =?us-ascii?Q?2GOSMvD79YpFBWOZr5rosJucEyFmXNslXLNvEF8IR+Vpq1cRgi3L9rSk7hYS?=
 =?us-ascii?Q?e/5qwpmohfIIpSURufSokICWHzDTmcDt578UQJrpgR8urbqnIfn/Pj2+p5ug?=
 =?us-ascii?Q?BmyhmCNU0VOTgHW7QwJX0923lsAb8JYe5KKWm5GjXhOuiOpPcMrC1e24vpLz?=
 =?us-ascii?Q?v8l1lgz6wo2CqaWPgQbU3VGsQqCJloUPcIvW5mPcOafDa3CK06xF08f4Op4q?=
 =?us-ascii?Q?xZkUIcAttebkTn2elqwE87Bzee+DziB9efrqr4Z//zpU5feQDsBaU/WzClqa?=
 =?us-ascii?Q?Vw+nHpDCFustkrMVfVv8SiMuLdlu+6TnLLTSqm2HTVgAUnjzLJjWu5hx923A?=
 =?us-ascii?Q?hgLSV0MrqcnFRzJLZ2DWBT1mifdx1mq+kdWtGgu+KvAOrdySsCDZiOIISSdE?=
 =?us-ascii?Q?OjW9yPHrlWC+O+4bHAwNE3azUDgJ52jO/8HrVCsi4op7GiezrstzFAS3yraB?=
 =?us-ascii?Q?JdYo96wh9FnqIEMPOQu1fgNN4snzzuP9KrYrArD8XEoYsarB/h5YJQma2BLb?=
 =?us-ascii?Q?D/75vtVHVHQjQEDfOHqoRukacB4KLTu1Fyy+IdR9xrj4lsv1M0PHVrB6wfvE?=
 =?us-ascii?Q?72jArBOc9VA9+csv03wfyqw15daSQP8gVeXPgaUDG+zIYVaRX2WmGcaPS98j?=
 =?us-ascii?Q?eu1uEVDLCbXlfV+B1KEC4rNq8PYSuu9OF2RuWnJrzSehL1a7qR6P7Lg1pGgW?=
 =?us-ascii?Q?01r266KkzW4mLEu3/WRg+k118lcgKjIaM6TdOwLBe2YMc63mVz6lwRk48mcQ?=
 =?us-ascii?Q?PCyQAXLod8y47gOv6jENUAAX7S5YpgGjucZ2qm73QF4rQcvfrsbclKWYViDE?=
 =?us-ascii?Q?F5mms7T94GzjllB/W6y8qP3p5hZSdsMhBpqSJblHz7h57VR8k1783V83r+IA?=
 =?us-ascii?Q?AKOcjHZY/mRJQQa3B7G+atYzW8eZk2HYbhUSpTvLnH5vcD1VFaCQEeUsTWmA?=
 =?us-ascii?Q?AztpnC01BuAXF4q5U/0A5Bqx5kDqTiHCdOK6gv0Q6+QUlAng5RmQKOXkbNhq?=
 =?us-ascii?Q?JDyZfUjbT839zelCq/DdFPnXAShTgI5uUDXlT1Y1p3AFk6lll5eo4TU66Gcu?=
 =?us-ascii?Q?yK9oODMLjYpVYooNUb2e/AimRPlEX+gio/SG/l5DzvQjmWvd19DEeXuVtHf0?=
 =?us-ascii?Q?IuhsDH5/emPzQ1Uf0quD0LLckrEMWJf+mGG1GxQisuNrcqfT1RCctJwZX6mq?=
 =?us-ascii?Q?HwCHXognqHAbAQvPFOC2YwRe2Zr4LzgGo3MB0wuOcOl8BBQPgu1gHZFZsDHW?=
 =?us-ascii?Q?CTpY7ar2CCE93RzwvcohOeISuNOHuNc55qLqFtTesCixaVRNMz7o+ISW4F6d?=
 =?us-ascii?Q?IZkYog6WLWRkf3DwuHEUhqEDd2op0OMJP1rLs7Tz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f08ae-620a-4c3e-4dad-08db674eb876
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:00:00.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKN+IudnreXY3CdJwBVRfiDIp3venDwxX5d+GAQLvMUDL+pmrxTO1LAckDWuwh+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
> > What we definately shouldn't do is try to have different SVA
> > iommu_domain's pointing at the same ASID. That is again making SVA
> > special, which we are trying to get away from :)
> 
> Fwiw, this change is preserving the status-quo in that regard;
> arm-smmu-v3-sva.c is already doing this. But yes, I agree that
> resolving the limitation is a better long term solution... and
> something I can try to look at further.

I suppose we also don't really have a entirely clear picture what
allocating multiple SVA domains should even do in the iommu driver.

The driver would like to share the ASID, but things are much cleaner
for everything if the driver model has ASID 1:1 with the iommu_domain.

It suggests we are missing some core code in iommu_sva_bind_device()
to try to re-use existing SVA iommu_domains. This would certainly be
better than trying to teach every driver how to share and refcount
its ASID concept...

Today we have this super hacky iommu_get_domain_for_dev_pasid()
thing that allows SVA domain reuse for a single device.

Possibly what we should do is conver the u32 pasid in the mm_struct to
a struct iommu_mm_data * and put alot more stuff in there. eg a linked
list of all SVA domains.

> Splitting this part into a follow-up patch series would definitely be
> easier and helpful if you're all ok with it :) .

I think splitting it into a series to re-organize the way ste/cd stuff
works is a nice contained topic.

Adjusting the way the ASID works with SVA is another good topic

And so on

Jason
