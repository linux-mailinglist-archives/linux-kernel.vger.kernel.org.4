Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69475F6583
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJFMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJFMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:02:26 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2CF3AB11;
        Thu,  6 Oct 2022 05:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTZZOBO2wckf2ASl668Z3eM2/+rFBvyJy8sy7+LZWdYyPcadjPhvyc8K+Opuzax72nz/W6HeMh8/z0AL0z+wMKzXrQ00v20Gs0ychazC2IH898bIXxD5N9pgJD+QHv8A5CtBz9ZhdHowR/ntfHLHu4OSshj2VKN8woxdWQI3K9TK7/j3mtKfzkdHPVYqagHYhZTcJqkL58yqLk01A1mQu2ERq/S0gpn0t2qOr62lnoO9DdSz+VCkIKDb7Qb/BTv+jbex/pG5YUTpw1i98IqKROHmgRBC3Cuzdyg/7zXsaQiklZ5F6bTOti5Kx8z5zijEozFugdO8urA+oVnDklMh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCvnFR6jB/1ZuxRqkIeTTdOhXDCE2+D0oeljrQwgdF4=;
 b=QVC+QNipnnHasAn9ZV60tHVWQiTuC/X+RiPuxeP6W6jgppDSh2iv12Deqn5qomwcPD1yTchwTnUWwbs8+NP+vbgjq0ujm2ziJnCuCb3K8YpdqrMJttDks6MLi3LHh8sAM5Uo9KD0kpG5INLIyeJPdWywCjDaTO/P+DzRqrXCH0bCCngXD3YCDll5eF7VpPoTK0GEGQbJidgbNsGoCcVwzJQMMHr5Ioyz1+KwoaW5BUSUE4gzB+dI6TIk8fu9anpgqCTLxCVDNewt0GD9xrJHyeTQfXPZrrZ87odxeUV9rRDJlNoD2VF+0Uyqy4J9DhvD9jhy3wqK8zBy9nYESnfkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCvnFR6jB/1ZuxRqkIeTTdOhXDCE2+D0oeljrQwgdF4=;
 b=PZ0SjS2x+rCc8en9DoRN13K8jS402WZd7SeopvI6NSf59ysvNbXCNi2fYGWPwAjXG99Quq7UCaKoyPINGE06wLkUiSKUUB/h9ouDNK+0850R+HHayjVrc0Qc6LlehcLv7enBpgnG9T6onUFG0jKXcwSl/nurmjKPp40ao0OqDoPA/jSmGjppbPiiJS+NEvv7OE/REuHC0BKrQQ9cTJm2r5rP8AmS+JPX0EzCARap9MK9AZpSY4jcWUdXg501IMWOuYAuK61oQPakgFTDZGSTKhF+5AbRG7NeaiZl49XtmP/Im9cxElXIlMzfPc7LpHPASRgSrgJhC0/kD5i4JWbxDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 12:02:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:02:22 +0000
Date:   Thu, 6 Oct 2022 09:02:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
Message-ID: <Yz7Dzayee74Mu4NH@nvidia.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-2-schnelle@linux.ibm.com>
 <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
 <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
 <Yz1vF7B0FLvLVvE0@nvidia.com>
 <8c01ad419e91c0ce06bec8700d960c57f1a7c436.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c01ad419e91c0ce06bec8700d960c57f1a7c436.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: d6756676-5fef-4796-fa62-08daa792a020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsL/joHor+3t0AHfF5gKVjDy1ZSaVmVwtlMT9NufP5l2/3RLjLXbEhER/BbAmeSBj/9SUqluQcodKKwzLfv2BqgVNOppdt3EqICc85QyFNk9GZ+nGxBx5EHzBVppYMIb3hrIJltt+DFxMYdz6iZonpk5VidbpakcDu0knrA/OMtxUx+gaVeDMWoFE+7wW3vO9cCzI68jleYIU7X48IFboRZxDHnLPOso+TxWYt20aUGYpus8d8bikEtWu/adF0jmmM031B98mWNT1HPN3q+36P4FDmjQm/xa8P/j4vr9dvfllsQkSVBeKxz1oCfRsb0Z6hYthC5urQylgLV6QclcNazHfGXi/o6m+VRYh/Q+2AufHj51WpgcElLv0dWfESkUhxYKsyrBnlWOCQnEn1Hbegi6lBuOP9SCxxlMz9jX+ydJSw5TIGomtqqMFXpndcrQWfxv/uxqWSWFipaGq5aEXRziz8SjKrT7FLgJvoYIWjGGDFtOs9zmu3xzykNrLt7LKnLUJ8iCCWlyY1pjbmd8CzeDgI4MNgYZfaxPJoV0qtJ3whoSq7cEEhZ1jKGBJdKSkm/25J/aOo5bnc4aEuDE4olMdRauQD9KJs6N4qolkLLty38S6lePyAQcIQSYSh3bS1gdc2/UQyUz2UHaNHNkOv7TAiOy1F7/uU4UwEcs2t/1BTJuF3bIaOjlE+V5meE6rSuzjTFXAzFyyiK+QkMOag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(478600001)(6506007)(6512007)(26005)(83380400001)(186003)(2616005)(2906002)(7416002)(8936002)(54906003)(316002)(6916009)(6486002)(4326008)(8676002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C078+V4PU4DVk/KO5IOI4P1Gqiwt1vBMZw6NW0wV3RpVM5XYM28o5ffrPQBp?=
 =?us-ascii?Q?6QnRTXgD2Kjt78W4Dq4Sh/FEzVWw9hFbBPODLqxszyuBP/AeCHJULH+JBxHx?=
 =?us-ascii?Q?6ZoqufCUDJxFRQCBG4ZCi/lQezGNz/ybUAkeXyIFKvir1rmJsBHolnn++NNq?=
 =?us-ascii?Q?J1G9BuXFlVNvA5jbbmk7m2WubCk5s6RHMmDna6OxJcZzXtG/79h4FdvdWLj7?=
 =?us-ascii?Q?bIeryOEKfaI1RfoN/dQgE+y83T1dK/DnNgP7f0u0y7nM7ADOIP5NOsXRoSVh?=
 =?us-ascii?Q?eccKCmV18PR1Ja2PrjR4crpEjGqy8kRayNYWYviw4EezAQwVUwnYyB9ivPVr?=
 =?us-ascii?Q?2xHMTuL7TogyAmdAwqa/EQcGWVhgplcFjOccJrLmQaBgBT70XXt87D/HYCQT?=
 =?us-ascii?Q?UrbNjHNWGCqv0BcXVzLilbkzU/lUR7WOkN6iojntHX4WNZDzYoso/4MGDmn/?=
 =?us-ascii?Q?Wuo2CDXTvJ0DCTM9qHdrsaYiSq9sdEOdbvkI4EA5HguqFSOFHOG7dMM/+evr?=
 =?us-ascii?Q?SvoR43o3ch5GJN8CLb4Gc/eT/ZDT60D8L7S6P5/AVI4dJjEWLUnkHc5HtKc9?=
 =?us-ascii?Q?t8lm+n+vVJLOo/MuLKbcShE7qBvHyAvLPxp3OBQvVdb4K4uRYWtdo5MmU5kl?=
 =?us-ascii?Q?B2W/qIQUqaDwC9f5oEsb5zsyAKueRWV819WgWwm5o/qojlCz94VMWmXT3KWL?=
 =?us-ascii?Q?86PATsxTRiHNvlLILPZ25XyF2d6RzQ1JH+ILAHZOtIfL7PwxrpsK/cA3Tp4B?=
 =?us-ascii?Q?3kjXiHUjDFQELnewuvmTpKewHBRh7s9jvYVll0rAk5kN/OP2ikXBOKT8A7N6?=
 =?us-ascii?Q?BN8df+kuH/4j7OAgOYISpx+ra9qCgDLTwWt//AuVLh6bOk9s8Tv4b0KrVcHQ?=
 =?us-ascii?Q?pVYxox5kv8MrJhCwZzOEmty1AKkKByoH3BJoRMkUJvlzpNxA7kGuScLyL7uh?=
 =?us-ascii?Q?3UyRMYnqYVZHYN9yfjSpnDGorygn5aJ+KKzZJoDmxKBNf73dPrv+tlzgUR6E?=
 =?us-ascii?Q?0CEnMD72Z232WFJmk+zz0H0wibE+qSFwhT+TzfTgRcQlfIlL4hb7i1G7ZNCd?=
 =?us-ascii?Q?OzY/CsIn3ye7Y8HIvZUiF6e/dXcGP4X5xB92qjMd7euqDOIe1xqWLrwNMb8v?=
 =?us-ascii?Q?FkQBa2BnmS47YFR3fwfamMfxmnhMcZ+aP+CP2KBh/Uocb7qdd644Sjih5QCm?=
 =?us-ascii?Q?EHy3b47s95/HRZfd8IxLKBiNg7tEofeUAQAstA39oHt0vp2V8UFgngSXoJk2?=
 =?us-ascii?Q?xQ3mwBj4iMA+O1fNIBl0qjjwonWdxMTeo5Y9hbA50NguaY1Q0FtfKPYFORia?=
 =?us-ascii?Q?sKlh79uLh+VUP7zbp1OSvzotnF3SpoZsl/z0rF3ZaueCVnaAsiKI7dl9+ffO?=
 =?us-ascii?Q?lZiTcXlRsPn0AZAkn8rYIRoCOCF0BSSm8uevzzMhjSXiYwCPNaL0NYhEVAdC?=
 =?us-ascii?Q?WQ7iMBojjbVKhJvYEOEOKpK8bkcZD82iO4rxan1BvLJ0pioj3ZPuKEZ2VC4A?=
 =?us-ascii?Q?amNrnZf6PkS6X+eMcqVpomvYyThS0xUCBzWVmwsarJr8paloTJ6/lkv5ksgq?=
 =?us-ascii?Q?4tuS76n6h2/gy32IbeY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6756676-5fef-4796-fa62-08daa792a020
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:02:22.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VajNB70VUdmLCwPtBOgnz9Pit6YZ+jX8T8778CbFj0YLmnUHj0yDb58ymCyiXVzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:52:44PM +0200, Niklas Schnelle wrote:

> One option I see would be to ignore the error return from
> zpci_register_ioat() if it indicates case 2b. Then we would still add
> the device to the IOMMU's devices list and return success despite
> knowing that the device is inaccessible (DMA and MMIO blocked).
> 
> Then the recovery/reset code will register the new domain once the
> device comes out of the error state. At least from an IOMMU API point
> of view that would make the attachment always succeed for all
> zpci_register_ioat() error cases that aren't programming bugs and can
> conceivably be recovered from.

This is what I was thinking..

> If you agree I would propose adding this as a robustness improvement as
> part of my upcoming series of IOMMU improvements needed for the DMA API
> conversion. As stated above before the DMA API conversion any error
> that would cause zpci_register_ioat() to fail while the IOMMU API is
> being used will need a "power cycle" anyway so postponing this doesn't
> hurt.

Yes, I think this series is fine as is

Patch 4 mostly deletes all these error cases, and the one hunk that is left:

+	if (domain->geometry.aperture_start > zdev->end_dma ||
+	    domain->geometry.aperture_end < zdev->start_dma)
+		return -EINVAL;

Is misplaced. If a device cannot be supported by the IOMMU, which is
what that is really saying since it only s390 creates one aperture
size, then it should fail to probe, not fail at attach.

So I'd change the above to a WARN_ON() for future safety and add a
similar test to probe and then all that is left is the
zpci_register_ioat() which you have a plan for.

Jason
 
