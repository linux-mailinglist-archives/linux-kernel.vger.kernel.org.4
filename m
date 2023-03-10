Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396E06B505F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCJSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCJSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:50:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BDF115B7D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZmE4w6Ewf2RDPtAoOteRAQ6EFRaOB6dlOqQR/mEmDv/Jq2u9hlAg03yWqUiY54YPXfrvKgVR7f+tIc6qnvMtrUVps+v0ra1Rb4/z4bj64kgHJyCVyEhBrDqVRTdWyssMl6/3v06eP44hAAFfH/zWtOv6tU5NfPCYg9zTrkxcBvXta3xVV/fQn0ksa52ylmT/DHAyJWdlc8rJs5mcJHbfjR/g4JgdiA4xBKXRDiUG44eK8cHls9GYbhNfelubwCKJBbqz/lbMEcd4Fj/XdXx3YxSQisNe+FUXnSoaJCdCAfiAYksz1PNJJSfZv6KOK+taidH3fROnX5OAGvRdnpdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbYNDLhagFmV9ZnNKy/D1+HxhZs3P6GiNIpU26Dhf5o=;
 b=nm7lyji4go00ujqCaaEaIZwvkJQlDFLNfNKHF2EF6Lf0+ROYeealM8ihWGHDLZhE6bqTExRYkKfn0itJzRqQx2Xc81Ve3ru2zteM+uEI9u08zzAZLujJ4lMFZbXqlL8JTPeMUxUpBP33IWkkEwOY8ZkajkhhjB2kYMRlPCVvGWeVciDZnaUC+VYdZkjpFQkZ5wB9hFUdBrrG+7YkZPLePNX830Gtr93yNVMg4Q6CXtA9+aGZzzdyR184X73pNcoAHh7p/fD/p9BChc99Qr/OSueWDkJlaO4Pa2oZL80Mg1QxptlOB6q2Aerr92NVTjwTZTAFZ9IbljZO8swHsbEOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbYNDLhagFmV9ZnNKy/D1+HxhZs3P6GiNIpU26Dhf5o=;
 b=IerSr3DrEFydttbnwq819wUX7l+x0mo1jaj5nHS1GPn5BXOdo7lP2kzY3KW+kiMxaGvdGt4HAHnWrP4FLwMgojbntuaN1BvosI/diS59DJmn7GrL8j0Qw+Dz8nnJH5E+jkg8uajMimvu8dAtVnvbNehZpyVBmv1PIaJ/DiBZedto21Cx8P3fBfR07q1/ZZFKI3rq2rDRdwailT+rpy9KiuvU3USRGHdwBjZ+Y5TkkuWIcQDxdULaYXM4abX2osMbjT/ThWArQpGJ8nXwhokfTYXt2cJxpEi1YciB5Dg+CZwBJDCReFb2EI/8qo3+ofEBNWXKE0x3Cgtay43uDO4rGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 18:50:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 18:50:00 +0000
Date:   Fri, 10 Mar 2023 14:49:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAt71pZp/JW5MSkR@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
X-ClientProxiedBy: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 494d827c-6960-4580-7b40-08db21984021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsj6WoN/yaQ+4VdzBK9GjQNXKL0duyyiTi+7lDKHF5/oYLk4H/epJMzONkIiRwc+Kr4d4YBeyz8WSylCknoRfEk2k1osdYS3R1Ys88BCUBCOMhS9PtEgDXES/YechxFqqsp0mRNL4Hc95RIfW6JSTzDSxoP8tBuA2hkONi8FUQsj7MH3codS16wxxSSkbEGFo20sjcEY45WtlzMwezaPBkhshNv0zzKkpuwxVMqaAsfSkpXhvFT1RSynhJEjgpOnJwyLyjJv3p0exvHfI4SX87d2yyW9eUloggN1ePU7fGXWK/s9TJWUUEjCUT8WUkfAmskangUnMvW29dctyA2u+m4x+KSxtGznxmo8exvByj0/a8oHDGS/c0Qv2IwaEE3zHBCi1QXBVy8Iqc4KWj3TzkgUPm6qYtwJqCyizTFHNpRsHlcZe14m5lWMj961qGttiyYjektddN7Ppw6TvhTPzGR9L+OBhCOqKCeZS9JvTBcCrZYokaHaRS3z9JP0rmKZSIhds5XyrEBHF/TgL7ARiMF8C4CiOfVs5gqt1STgFFUfl6yCG/+tpEHlALq9SsvwN2WElHt1EpVh2eQKzH0xeQo4WgxwiUpZHhxW7R1c2aDguTgSKbdw6hqcR35ptFRSzf3YwLdokPyNuuYTDzCbcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(478600001)(5660300002)(7416002)(186003)(26005)(6512007)(83380400001)(6506007)(2616005)(86362001)(6486002)(36756003)(2906002)(316002)(41300700001)(8676002)(66946007)(66476007)(66556008)(6916009)(4326008)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2iYqAo3dRCihxNuTIWvwbKPcbJtgoaImeCYfESKmFKyxioZbZS1PWziGyi4?=
 =?us-ascii?Q?ZxIFh3pevvSzD5NH0/w5n4G1Qx3X/z32gtGk/rw6ImDNqj+9caqA9TS704zL?=
 =?us-ascii?Q?sLiIp1v7pOZX1OvKOtHxdP6neGdYWBjaIgC9DioaBA4jUSE8A4647EB7mriI?=
 =?us-ascii?Q?V2G8K5w6PwALMuPU9gcM23Hfn5GSMcawP6NTiQC+TfvGTohK+mK2vENknl4X?=
 =?us-ascii?Q?ParGm3qPWkhwS4wpEb1tlPYXzGsQDAipno66iixstg8SjR0S8dRNOsrgcN2S?=
 =?us-ascii?Q?Ml7KXzN29tTXtipJzj68ErtdN7wClnSoyDvy+ZoxPjN3WXGxA05kPRN5Ll2e?=
 =?us-ascii?Q?P2DUJkxrvFIMZzlm7mDw1MREK0thz1sNXQs077bzeI8O05RU/TC8da7MkZq9?=
 =?us-ascii?Q?H9A2xVb2G8riVDiljUOGv5tOjDSfE2QbdrpqIDmd5df9UkB2gputclA7F9oM?=
 =?us-ascii?Q?lntLByg1NAk15MV1t3Dvd5+zW0er6IJ1/u6KDiVhmAn6aswPsSMnpgwgEsNk?=
 =?us-ascii?Q?N83x6grQU2liS8YW+4gJbTeXbL39jT0pWDQLyGLbQYOmFYRzp0ND63jGGU3u?=
 =?us-ascii?Q?+LGSbevIb+fLPH5DvHymac0pWDjFdMhStSJBdehqcW9oRv4Nlm9yH1XtEZg8?=
 =?us-ascii?Q?MogFeXl3xvXX5hIxJ7buHQdxda99xul2jXW0hAzNhQXZYYbyB3fb12kb0jrM?=
 =?us-ascii?Q?FbXH/6R2wNOiF8IyRcqtV/o8U6VQBdsflNTLoq7JXKl9ewEJ6P2Myw/VvDNN?=
 =?us-ascii?Q?PwVfqP/1jtJk+EC4BWWC1+VIl3uocoJ/Gu4suZsLUH02W9wdtOFEMPDjEFPT?=
 =?us-ascii?Q?bjJbRzSz1YvfIFmDq6WRmDFrtQd+qaGhu63gJ7fs3VlOepWIRqF5SzP6AuZK?=
 =?us-ascii?Q?BiB86/TgOXafiEHCmnUwUAtT01rbjt7ibmpqPT2dQzHw+DRdBW27K7McV/zE?=
 =?us-ascii?Q?2xXQOV54NHFw63jG5+fH5x30iWcMjIog+Y/LqzUJMb0FsS9GYmzO8pa1fD4j?=
 =?us-ascii?Q?pzhM9vTjqXgxUhlFskbpTkdCD/YDfJxhjkSCwLGdtKYXBunKB12+3/UDMXrI?=
 =?us-ascii?Q?aQbmlvkplxq2ILylQ4Ojz5ersn4C4ZGGoidxUTAbryPJ+DEulYzGAPnEiFlO?=
 =?us-ascii?Q?5fRo2X7ZKryUxVfUn5R5lajkf+XY6Ah1Fg1ftNUB9P1Ru3YIdMMERpYDZPcC?=
 =?us-ascii?Q?9ximO/8gLLMlKU4w2SroJCAyUt1k67+jaP8/tLIFWa71uANIBcqLKVUsJE2a?=
 =?us-ascii?Q?YccR7jdXAv0e3F/FoP60MmGKDXbFWAN+3i3HErrhdtxBh42dIEmiYhLIkIHp?=
 =?us-ascii?Q?yhOy2KGp0je5h0n0D+IDurjsEcjrw7LN+Fiy2j/fnmYeuFgRuCFzTAJZpfTt?=
 =?us-ascii?Q?hEsO9JfwRFAK/Hput1JyA5gV2WY6VCE1U7gPqb8J984nELR9eE5Z6qBb79bC?=
 =?us-ascii?Q?80u/x/DqCaWVJTvG+r00lqAbihp8FcXg5TqNSHbL6SBuPKcUnTVCArHWTzsB?=
 =?us-ascii?Q?+UuMvRagMm0mGDkR6l7edQdYaXojgzyYXo7IAgvzEOViSvZ9KkbIDJ0Spt4i?=
 =?us-ascii?Q?iGpPg3mNdyczfuGPaKmyfEghXORbb+0iNqwAt97Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494d827c-6960-4580-7b40-08db21984021
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:49:59.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTPAYv+clJsBBvuz6sCgFBQjdCeOEEVSgJQWZcFzif960bufzC2dWuDu9xoCd0t3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:53:46PM +0000, Robin Murphy wrote:

> I guess it depends on whether IOMMUFD is aware of the vSID->device
> relationships that the VMM is using. If so, then it should be OK for the VMM
> to pass through the vSID directly, and we can translate and sanity-check it
> internally. Otherwise, the interface might have to require the VMM to
> translate vSID->RID and pass the corresponding host RID, which we can then
> map back to a SID (userspace cannot do the full vSID->SID by itself, and
> even if it could that would probably be more awkward to validate).

The thing we have in iommufd is the "idevid" ie the handle for
the 'struct device' which is also the handle for the phyiscal SID in
the iommu..

The trouble is that there is not such an easy way for the iommu driver
to translate an idevid at this point since it would have to call out
from a built-in kernel driver to the iommufd module :( :( We have to
eventually solve that but I was hoping it wouldn't have to be on the
fast path...

So, having a vSID xarray in the driver that holds the struct device *
is possibly a good thing. Especially if the vCMDQ scheme needs the
same information.

Jason
