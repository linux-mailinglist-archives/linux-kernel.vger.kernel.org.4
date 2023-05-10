Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522CC6FE637
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjEJVZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEJVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:25:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFF26AF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxwcl4P+O4TaszSOCAUOkehIq7zKMraG588E3XlAcxymhFfPC4u9bUNCucxVcI3wGr09yylin5lBSgc0QvDChJ3ooqjUv1YgWxzXRnDccpaQNEHwHkrXVPlSBfyL4mO2NZNHIZqlfiGp/CB4dnw8Y8a9qQAz2gqy1/PMFakCbKD5QfU4e7Y3dsN0ZXNMV7mXAy2BZ4qw7ukNfNUZHpxDA/tVzjStr5wt2J28kDKTfhl7JiywVzoCeqxjh+UzEBkc2VJE5MsElUS1cvvLB4e7s8MXOj2e9GnxZ6wQqy3pYHOrZZxI3SbXB0fnY3Y0EaaaRNmO/k+QibpMEYMMLk9OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDvDgFPvb9kIte6bzkB+Z8xWSZkKUgHcj7v4BEX+G1Y=;
 b=df34X4vsqzEtRhmCZMFUUt6NtJEd1sVPaU4Xp4u6mNFWV/m0jgcgHm26NEPeu73oMzbxyTzjB0VXde87wuVp/dyDhvq0CCSrG415bc36eiBPY9kTg6VsaKE8hkYhzXzIB3Uv64tnNxp9i4lCt8eMUTJJtc95HF5X1vHgbFDrUEp9m52OuK03HR7jzwYq65LihrH5lopqKYtgIgXRmNWL0ozfUAr8b17gEvFhkEVCKFLhz3EL4ioG6rlcRkC+fBH+fhuw1h0F3TdgFKVAEOdBoRKKiKpzGIlks+VGLqQQRX+OrIDoYlbbc4UNdrWvUlQupchYbq/V5mzBknc28uuMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDvDgFPvb9kIte6bzkB+Z8xWSZkKUgHcj7v4BEX+G1Y=;
 b=LTQTG65KUJ5EHAm+RobC4okiwIo0YAy6EfkxGALPDCmuGjAjmxTTr1LzzLmdvv7rfwcZRCvhdj1JuLTqnUKKQHf4OgCem9JglGcof9zYcMuDlqxqdJSoY4MKp21eqEpVZFacLIhrBss9vOIad/PWEXJrzrAwgqk1v4+b9Q+JcbZPjZtCnKWzlbVfrZyVQQ7Orh8fZrVqVkPpCGtG2vVIX3YqfH2MBN+aeBz67Q0GTDRDyr3FR/K0OzO3NQPEbHEUHos/bbcPeFmwW7vP8FXDYnW4QiqKR8IpYMEHkBAre1Q3Dt/zX50Z8H1fVizzRquBHyYn9+FCAc2t6ZqU3pe38g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:24:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 21:24:56 +0000
Date:   Wed, 10 May 2023 18:24:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZFwLph9WXByeHxAW@nvidia.com>
References: <20230510205054.2667898-1-mshavit@google.com>
 <20230510205054.2667898-5-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510205054.2667898-5-mshavit@google.com>
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e84db2-41fe-4efb-6a13-08db519d0076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHXA59Fa9Y+OwcwQYwBfsqhz00rRUewE06QrdcwUEkh1F8agtTRKEk0ydje6ryLdTMrb6278PYskD29V20CEsV3vgubgtBAGLh6h61D/6cFNSH6wNZ/qZ1sST1UfjvWd9sZsX9fcj/kWVO5moEdqNyvAlv8jPlHGyWVYnrz2a7BoWXuu5HA2LbH73YKW1KpvJpXDjkZLOR8pQ7q8yfHBOQjcGTqC6ARoU9G1Bl99yKRtdWCCulfgadGr7BQhQocsE1TbGtB8OaagTpp3VqfOZl03FYMb6nLmglBdQM7lpLy4T2nhwnJY/4+leez1RT4zkSeW3lb3R//pCrtwn1Ex/zmqFjtadpHB0tVr885mDTIUOj+RHkB5/PaiQk0gIhhbyKVku3nK/dloLgbpC+LJD6JCpCAm9dPI06pg5+WTmQ32gR82GIiMqcpM5kZnB6fTR3kOMr0cEc7HNoMiRziEu/GyMnaEXgj5dtrfRqIcJyPT5xLjwEOHy4RQGIW2jym2vDUIxZnO2H1xNtVhfx5HrmcEkvu84fv7xRdZozJYlt8JliQBaF1ka7F4MSMpvf0z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(86362001)(4326008)(54906003)(36756003)(66556008)(6486002)(316002)(6916009)(66946007)(478600001)(66476007)(38100700002)(8936002)(2906002)(41300700001)(5660300002)(8676002)(186003)(6506007)(6512007)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6mdiL2760nXKCkODMe/GuesHtc0loc+BZfCGPNZuZzyU7t7r8pRuEfy0ntn?=
 =?us-ascii?Q?aClVC95jsNVfg6znWsfG8MGW68InaRTXKgsgOs4afzp9NaBvYrNNirnkT/cJ?=
 =?us-ascii?Q?0VN3t/P16vHhsZnmVOwpYlxyjOVAcDsByCkDsLVpv+hCYbdYQF/mpMLKY/tG?=
 =?us-ascii?Q?cmAi7xmL7fLMda3Dr3QAdEPSW3LZ3vESAdaCK6FlS6j85KUP6SLAWOMkt0Rz?=
 =?us-ascii?Q?/Tz+bixfNTmyTeTUjIPJYwprLFkVcmrLPfNK7vpYZ21mF9DJ7wUw8WbmoVgL?=
 =?us-ascii?Q?5VDxK7CoiAqbFhrAsACqZHANLadzjr9yWCpmWKoSdqCwOfLvPO3KbgwFiyiE?=
 =?us-ascii?Q?zvkmp3Q0rUwE3GaUA7pbpNY7KEpifSd4ArC93gx5HTmysusp0qCk3FVlwhmR?=
 =?us-ascii?Q?lKdaUfzQnAz1St4DgWjR5UbOs6s1QDIUAIC8PfI5UrVzFQj8y/athokBTpNU?=
 =?us-ascii?Q?YMdAdWGBgTX6Bs1LFYuocKxIhc14a6RiqXVWRUVCCB973h9zNAvHGmAIv9D2?=
 =?us-ascii?Q?BqJfF/IoDjvv0WekPe9ecmTU+ADGuL7Y5MpbKLRsOpwscypz0/sFTN32oIzo?=
 =?us-ascii?Q?nGcTEsWCdcLNU1Q1akttZFtgfoqRuZncq4D6RFM4dnjLqjxDy8HcC0jwruCi?=
 =?us-ascii?Q?VUQiIs56VDZVO3Y0R21lNpSYjmtxAIIQECnzENC5GJrETyyTdRL7kN/ZHqA/?=
 =?us-ascii?Q?/GXfOOCPK+0xGvMdeYUFMFKJ7OQZoS7gC6LedsL28mjIBCCSPsOAHSLGPX/v?=
 =?us-ascii?Q?9in9QGe7Ua78vimVvOcZM0GInYJl6bNmnaLLsvi02hAJhr8SHJUallU4sxuF?=
 =?us-ascii?Q?Y6w/TaSKIc1WjRinzsm7aT0FmG5c72GKTs/bZD+/wyJ8w2yUVzPakIDuD5FL?=
 =?us-ascii?Q?X6FkUriG0z/qcH2KJ9MnwysOLRbo0KdSZ2wY6zKRU8BtnhalUyfoEE17iP3B?=
 =?us-ascii?Q?DZgnpn+iXQIoWPKl2yM04xFSo82sqbYi1uGNQOq4cXpeMh/ofOxMzqTL4K6t?=
 =?us-ascii?Q?aj6jlkQDwV7QiNY6ldefLhbSY6TX8PvD9M5AzQtXhvTMeinA87FBCsuZXxx6?=
 =?us-ascii?Q?9mYV3UwTyaVSV8t668VERAfMIssoJ9P0aB/bxnvViNEue2K1xRvWL2MS4TD0?=
 =?us-ascii?Q?dq7nMK6i4k8Bn4Hj77HTNU4s/J3MFaWgU94+20GGoiAjrc1SokhS8Z/jbs78?=
 =?us-ascii?Q?+R3Si4vXJbeSbXyHwRSRCqObTf7JAb26uREh+4LlA7YwBH4ccCthjCGu0Hx0?=
 =?us-ascii?Q?ccmqc4NScNlG/tuP+Rg9xt2jl78nXbdQhFgMM1FQvsdKzt4XLoyIDVk4dCQB?=
 =?us-ascii?Q?CN0P45ROfHbzJPjDkg9sEwwRCuYp6vNWsEkuybo+8x/x7DzK0YpxkgUf2bEO?=
 =?us-ascii?Q?vealiUn88sFmEWvAR0hDbtdO7Wp3Njy8c04jitK93WzyhqjTzGEAFauRdlxz?=
 =?us-ascii?Q?zem4d017WOthjUP6HtN2xiqscagxcS6oIkmpCexSlw9p7wWmuYoQcg3CMD2S?=
 =?us-ascii?Q?hpGfHFJOfC+fgFMldN5+kMX6Po+/xN+W2H+UvPmPiIIyII76NOwfDHhnkG3i?=
 =?us-ascii?Q?lqCIRt7QaPI62k1xscg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e84db2-41fe-4efb-6a13-08db519d0076
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:56.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ee/Srr2exKMfVahvJ8qi8shz9A/WNeAUp5OGXnglry8ltR2I25+vQ4wEAswOR2JM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

On Thu, May 11, 2023 at 04:50:51AM +0800, Michael Shavit wrote:

> @@ -213,14 +213,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>  		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
>  					    PAGE_SIZE, false, smmu_domain);
> -	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
> +	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start,
>  	size);

You should be getting rid of mm->pasid in this series as well.

When each domain keeps track of what STE/CD entries that point to it then
*ALL* invalidation should iterate over the list of pointing entires
and generate the correct invalidation for that pointer.

Eg we learn the PASID from the fact that a CD at PASID xyz is pointing
at this domain and generate an invalidation for that PASID.

mm->pasid is logically incorrect in all of this code with our
multi-attach model, it was here because this code wasn't tracking at
what as pointing at the iommu_domain.

Jason
