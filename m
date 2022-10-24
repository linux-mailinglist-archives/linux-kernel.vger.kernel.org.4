Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA22D60B587
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJXSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiJXSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:30:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95436BD9;
        Mon, 24 Oct 2022 10:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFAp8MCcWhAZc6+Ru4snKaKK/aLC9Z7NK8hEFMgIO2k/PPlFLX5bak/Dos8OZV8zKB8pRR+g9GAvB6CpjjKoVmtm+M5fI59Wruqi3mU9xnVzH9KhZt3psUBMWgQ5ieAHcrbAjZ8HieaWOVFa+FWjLzf2cTK0MGTVnaUSPXvjhllODYr7Mm/WmFTaE42WLbOqyC20lmlJ5oCOW31ycGIL1wfht2Ej5vdoF45udB+zL7bZOC3AzReR/4THQ51w2U6xSNEs2mNhrjkZHW5BjpfwhlL1O1AOLG4VSE5uOz8vz9uaqB4yMWSPPTdOrKuQ9udgmzBwEmClAVbKjwM395C6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru0SoQK2DJknclQYX/Xn5ieioQq4M1Uo0fasyGzNwG8=;
 b=cNgPx19sKEBN9rLs0JOL7IOe97WqgR9hmN4vrq4iatyMBZiUAeHHv0WH7I2yjoR9h6wR61davrYJ7zzDsOrSpDr+zdvOSH6p8M8hY84wuQyWeiP56ecsKBJUrh7ceyc/sl3yj1acTnBPhvI5JO3tyXWeudIzBQ0wbkKvW+BVowDMp1mmLQiDkvxtfv0IpYuVEU+OYLrqu7MThENNkl70oWy8ijcXHMIzpJWwcluPUUNpb2jCoeWi6hIEVURY7qBPCPHMGDqz5VtcgBK4WMg3ZyWPsHhafr364Owg2wQBbxnEikRj/gvBpWKhuGvlbQ4oP2i64W+dedDLCRIgDYlI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru0SoQK2DJknclQYX/Xn5ieioQq4M1Uo0fasyGzNwG8=;
 b=gsdeaGm0lZ7LTtYaxhwBE8R/EaV9fMtBKyTiKXcTq73OKUE/QSAZxKAHZVgLKpfdRHyFh7XHQ7tLhhmNYiXYZ9gZe3Rx+wRT4lM8Ju8WRp61bcZOMfj4hZ+n3t/Hlur7CjgiQPKD5c1ExkJnk3rPIpFXBNQD8zGe9VnWkZP+du5pAAOPj5j5NXPxphwWBOW6XN2OrOizimBeq+O4jCqQ92hsP9iq5trSgtzjLhDDx6CTnHHdegJ0eM8Dk2u8tJnfLIhF7Es6K8gteOEnqw5VMM/QaceOFUUGsmWtRhmUHfcZeVd3ADfxuvRk4Rw3LljcGhFq3euEVr9H4LwDWn8fnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 16:54:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:54:07 +0000
Date:   Mon, 24 Oct 2022 13:54:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] iommu/s390: Fix incorrect aperture check
Message-ID: <Y1bDLfK7df6XL8WP@nvidia.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
 <20221017124558.1386337-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017124558.1386337-5-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:2d::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: a965a4f0-3aad-45a3-a1d5-08dab5e05d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XCUW9CCr2tkTQsziVfUduUMOaB4iQBv0lWglpHBLdCNaF6hS4aZ3wKNY8gMT5//2e7gxIRYHl7uW7Ex5HSXAPEIJksEjKazsjJX2nfjd8SLJ9XCZYDDjGSreYppkeIm1jYZHhFCSxdii5HZIUYQ4lIP4+0Iwdc9LRFFU1YDxU7AEbE06UVSP/uVezPVdgMlA7bcMlEWADhC8rveNduDua5DgNufQ+3mLdSLivl8GMd6y6MztJ2TYqhWWlNBBJFGI/10GmF2F7cnmzEh3RwhanrKYzyrwCbWWICrbRQfsDLI9LhY9wpZAqd1NF4dz6voE4OorXxmQ9KvOF/6kmhklqMrUoAf24tIcSFH7kPAWxGXHkKUoSMGr+HhOIyvNACco04WlOyNQJrscJeABHfChXAO7wTg5bZT3YVBP+OePsgyJchhgJqbcvLnuec6QxWXdF8LErDZsXuw4Ce01BePkALTbOwa90i6Y0ULvcmkOdlWgcsqWMjdoRZ61wTFwFORttNspF+1Y7ZRcJVWYcmelCWSZNfoXY6do0e3SER0oGkBwfZGVENYE1oxs1TbY8XuqcUZRjcQGKpws960nWNcqZYMYnFyPbiY+8+JtzwZ/sHeA+o23KYFhX/GusPPvD/kYZQCHgudYQXJwYNxo8u26+ydNsK38es1KA87+bmIAM5pYl2qGdgvDUVQP7lgCF/XgPUQMn1DPgynDwTxobFS2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(8676002)(41300700001)(478600001)(66946007)(5660300002)(66476007)(316002)(4744005)(2906002)(4326008)(6512007)(26005)(6486002)(66556008)(6506007)(186003)(86362001)(38100700002)(36756003)(2616005)(8936002)(6916009)(54906003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QuYImb5ThIqy7AbME2lmTFdCNbFLVsMH8CqqGjDBp+bdTdysGEnQ0yJDpcGK?=
 =?us-ascii?Q?Kp8kwvAAz+CWUMcGmqP8btkvQGLbqiidNTlcw97XzRtxx/M8UIolfY/GVSnA?=
 =?us-ascii?Q?f292GQRGXX5xs2FKaUjVcCUJqRqq21gpUofZDDRMTnFGo+ptQF4dFJWnuMt/?=
 =?us-ascii?Q?vIBLLKVwy1lOXyz3N9s5FAaLPpjiiSaKRtC0LqdMFqz/nMrIqkMztLKoTk17?=
 =?us-ascii?Q?Ezj3RKyijDBKBrTY34h12GsAOp+ZmKqE1od3ROqGZ09t777Qv94IuUikTSON?=
 =?us-ascii?Q?qDE/LSwAzveszINf+9azl5YHqPAQ3C+SUhdcexVjHiAwhZcg/t08DO5jZIRT?=
 =?us-ascii?Q?xeiyNNSMIr6By3St0vrN+2yKgKj4Lz8sKO7rGJaePZCdWbEwY4EfqG1GfQym?=
 =?us-ascii?Q?vSRMtw1IRODT6DZFpJCOAHXGkOutOkLTI9Jo6uF4oOsjEt8Gpo4UH/KAVZTW?=
 =?us-ascii?Q?ie+lGlo//gKtC6regh7FKYBgLErAwF5X40WUOFPilcfQ5+CxYYbmniDIWe07?=
 =?us-ascii?Q?L5LHvOnCEtk1hezoWTiZY8x486N6FBd8j88p38fUdyOX1cULACBwOtHWsY+r?=
 =?us-ascii?Q?/EU9qOuH5V9vqRufX5vWeGFo4vMtSGcjwPN6Zi54STGPygBsVt74fhfChy5c?=
 =?us-ascii?Q?n40mjQIf3nThoTgHostBEO6WcGvCvA4crfSxgLLpHmTgcr/F97njxmUCTjML?=
 =?us-ascii?Q?yy5zh4RYboUyEC4oqI62meEFFiHVOIp8zZSbu1Ehi/Eadqc7nmrCSH4Y2NuY?=
 =?us-ascii?Q?sK591wmyc/joRGIKYR21PKa2F1iDC6igrOK/GE5iInjGwysvpPpuMtXsvd5P?=
 =?us-ascii?Q?QBeBCVr4r+Uph4PJWPnPJi514j5u5HuyISQRmbk6oC3pS9Wikd3E7lKXDBd/?=
 =?us-ascii?Q?xFMh32/puaIMra8Yba/H4QWsnxAubA0AF2xZ7TiOrh8k9Fad46LVWPgnyoaN?=
 =?us-ascii?Q?Ws85zUvk2uX1kby5r9yzw5hwBnbbSBTbvFNfM6zF87vIVD2k2nMNvLstWmLH?=
 =?us-ascii?Q?PZeCdJoA9eihXivqsxgf8pAE3Ziz87W4SURpTYiJ9xpzWTBxfw4zoji6NYGa?=
 =?us-ascii?Q?/nykFEwJympF/TmZCmQQEZmlVHeusk6Lrmo5vZS7MAEVrjojp46SMWQatT/w?=
 =?us-ascii?Q?PKoDD+iUbQERXyP8fQnitPDAp9uZ0NRk7d6Rnv4qMJUwuDZ3PIiSBsF7kbAG?=
 =?us-ascii?Q?6vhBxztHNhoY7eF1zXVIZAjlxiovxRi9VwGUjr32vgWIgTq93vmR2kXFAixl?=
 =?us-ascii?Q?GdLI5kWr7hkMoHYZZ3DFKmon2S5O6/1IFI+0QK2DA9qgWxUZeddTFLGLLqhj?=
 =?us-ascii?Q?TVcc0qWyrIWU73lp8vYH5RfnXXBmWGUvUm7+DI6+ZGbD5hiyoPjnjmgWV6H2?=
 =?us-ascii?Q?Tdraa6Rilf55myeRsCZcjpS1f6Xr/Le8Ai4nE6muG6Q03eMToZvx6BmLlC+e?=
 =?us-ascii?Q?BbeUVlX6BD9KV86fCVxsDxSfdiceV6UN5dqf9vOtJow5NgzQFPgDcmABXdWM?=
 =?us-ascii?Q?IMZ+icxQLemZl2fVAd1d5Meeou+Xpf/lsIeO8oXnUdNygpl6Fhl3YzTghWK6?=
 =?us-ascii?Q?FhsFwyd31WagsJcLC7Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a965a4f0-3aad-45a3-a1d5-08dab5e05d44
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:54:07.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+bo0NpXBLDpFVhUWBV50QcmbM1sGOSHlOMVeeHyMCuFZAnmkjcPyAaz7/cnl+EF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:45:56PM +0200, Niklas Schnelle wrote:
> The domain->geometry.aperture_end specifies the last valid address treat
> it as such when checking if a DMA address is valid.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v3->v4:
> - Make check robust against overflow (Jason)

I wish this value was called "last" but..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
