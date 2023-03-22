Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A086C5343
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCVSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:07:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40561880
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSS//oylg9gEZQ0XKUy/Z7LQhIItazC8Kqp/+LJMRjEadnUtvZLF8PcXjIB3VEVBJWDpDy0U12gAk5Hj4ivd4wGGqjHG22+C5lQLj1txo8ytt513P+QXwRT4hnsbK0qbb0SP2F3lpTWkpr+zvcP64WcN59z8j1NGWvnK2mu8PxU2Im7su+LIKXOdr9QNyB5TJu1wQN8YAty/00HHs46H+l+7xm6rkjdXNyU0W/E5uCzgnZVcx/ni/jFMRohDdYYje2pHtybuR7JALBz/Wp6iX0ZdqlK/5wPTMRL1O1nz3aoZrlThtcMV2T2lhFktg5yF3nycDsUGSAHe5LIpT5P4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOTb6mNaUws9k/YYz8sgYTKG7V4UtbhIeW2kOwJUOnM=;
 b=aG6dV4iGtsvV4NAnXwfeJO/XXzb9iwdoH8af1aHo7c10ntCskwqWX5DsF+cxX4exQw6t6B+I73qVkiXzLW0jRwatrkIAgeIDpxzTsyvTdhMLawQAZeLRizVfbZYRxfQpjvR9nUmiibM0Gpr/+MeQMnJOxZrJIOtMnqk83KY3bZhya7zF2spKv27k73x9It42anDyziHUyTq/VvqIzteDkmodyqglMMsUl1ejM3d9yeFRA8GFd7Ty/2EjlkM1Dvu1jPAAFDGl0pEYeWd0xR3CLa2NifH1VdwbWoLP83bqVqlV+iZrbkoa7yf2VNloEWHMqyH+00cbD0BIy4kjYY/3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOTb6mNaUws9k/YYz8sgYTKG7V4UtbhIeW2kOwJUOnM=;
 b=S21AcRiSJAUe5dKRrV4VpBj0IM3ZSu13ZcxYL3cFO0g/hk14xW0c7xcEk65VHHdD21f3yn4NQCT1hcbzxnxL/ZWfiJzR9B+HChx3r97sBfuwP85Wr0PeBHTPidlYLDYAa72pDtkchJHvb/yVB/e3S5Qbs2HfdkSZINt3c7zwhOPQgb5/Yg3c9/5pKye2U3gDJat5YCFyHSqW6N7TC/8yzVQTEhXHWk6+6Uv0s0/ZS6vEXN7WepxWSdxP9a1crkXhnY8DxBgtLMMOFvVoIa9IIrAejCSSOzxun2IZHvlB03Iy9GTDf6W4vlWkH4tXm4FOnJnXmG9Dvo5gqrrSKje68g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 18:07:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:07:03 +0000
Date:   Wed, 22 Mar 2023 15:07:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBtDxXjtx/juyOXX@nvidia.com>
References: <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com>
 <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com>
 <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZAti8wy9wXwtIqLT@nvidia.com>
 <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
 <ZBs0ifAVwWvOt2b5@nvidia.com>
 <bcab0150-bd42-8acf-f0ec-85ce19699a57@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcab0150-bd42-8acf-f0ec-85ce19699a57@redhat.com>
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ae1f0a-06cf-4836-7077-08db2b003d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbpF5VMloUzDkGtRSQRevI5raS6gRZ1IUEvJ+c3hQ9M650udhKu+W0qKBJvBl6T3MLmwnLrDqJgaWWhb90E66AU04Ja2eJGO0eMS9Um81NRKOxBiCq9TUA9AAGcKHlSauBFqPxKpIB88xqlyfZZGRns16HtNarwn98lzK6YbXGvr9/A8jphmbHbnpQw1kC0O7SxN1p4VSFzaQfxoJhQvEPfwA7Ffx3k7fcQc1O7hqik6dvd4gk77SdcIvXCP+0kwZBIiqeLXgXMN15TFO3cXRJvczpQ+g214B7mwl2Wi6RqyOSTlDKsjo1EgJYx6MqKQKGvyHkivqg5cKmmx7Y8YQPcbm1EzRyDpHvZz5nVdGHZlLtzgvv4p0WCMPBC/5JUvBya1DmIySa1l9Ng4+nIsGo2CjTg430EOyBaTZNvQjp4nx7sjBZ6GOcWzYWq7JIg5FzlvRiPvGY6cWuGondQKZAXYCACAL3jyj+eFIgy/PavVduH4j7/wzCUrQ/9+4I+eq83BD8pxlr1bTke2OEcXmFH8r1aykhByAfOMp2JkLF0jurcjKoNqgONf1lmqOjpgizcdA7SEBHwKP3cCAjI05ys6V3qVI+GmRKKiD1KcAR47l0BbV7V4vu0NTILOfTc4/FwpGJPGVeqX4zcHzhcggQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(36756003)(8936002)(5660300002)(7416002)(2616005)(83380400001)(2906002)(316002)(6486002)(478600001)(54906003)(86362001)(26005)(6512007)(38100700002)(6506007)(41300700001)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGpJJxrg787qA6nXxWAoEED/O+DTNJzAkevvYhfUhfAOsvrlrBpaFvZ45ebM?=
 =?us-ascii?Q?uPhcfKKfrrpS54HlxO8VaHVq2yykjtFae4NgHa5uftVvJXRFd13LazhU7vo6?=
 =?us-ascii?Q?KZy+ox/NjE8LZFqLwqB00i2P9XAzI/ps1d6lzWFlmiEQuPw5urZyxNAPnNpL?=
 =?us-ascii?Q?dAAAkmNFRp9rzP0stIIFOk8qRUT36Hz5MM971Zktdclv1mrWSlzC9sWb3IpT?=
 =?us-ascii?Q?1hIOQ3bdK/L2rgWToaxXka4daLkEjpcEu4cZZZbNG63lmo3O1b9zOTYRBcOY?=
 =?us-ascii?Q?DieSQ3Y0n075YHN2zmn7EjbhpH3doaO535GJSp4QHH95WzZPtvbGCWlQqx48?=
 =?us-ascii?Q?NcjX9GvLnf0QO0HO4A+cmhJaTBUNwoZmyxjZPOdEHObVUsM+bD+WoZNM/7Gc?=
 =?us-ascii?Q?q4W1LsCZgN8298Ho60AlRq3kNqcjGAUuS6jR4i8th/+d2/W6APKkyyLo+uc9?=
 =?us-ascii?Q?p1biyaGfrAsWvROhpciKmoqPEKqIsxLfKmsVSzU68VsAnsxP8uOP2LcJlTt4?=
 =?us-ascii?Q?RbFQmE9ZVYR2/Pf18eMI6U8oHhWbZW0Fi4W2oVwNJ/Zx8srOTc5ZR5JoM/Sk?=
 =?us-ascii?Q?KX3G4WkzVND9RKYODfKjoDGEfsxDRxVAlfYxBCX1e5kOYbKHNWIBCRmFlLHH?=
 =?us-ascii?Q?H/AZ4+MpFU1ktZR2rgLLDHxb61zw/L6ge5LvtQBIW8SMTJtZl9TqZ9GVcN0C?=
 =?us-ascii?Q?ZlBfUTl7q9xB1gxyg2RoPrqa3dzazycFTdzZrk+A5lvsnVIV0o6kMTiDUOCZ?=
 =?us-ascii?Q?uDVoAtUlCbcstzviFCjb3nRlnx8YMmQZjkez1UnnQNcTBJPm10KLD/XET75N?=
 =?us-ascii?Q?m7HA9nv1hm3vxtg+n2+w19OVvDnTqSmi3eg5/Y86BsL+egvH4Zo2dhViBxuk?=
 =?us-ascii?Q?GUvSDeF5vuN4l/RPOUSulouk2Dsf442bB59YDgSA3x3BJtCVJzvT0PDJN6IW?=
 =?us-ascii?Q?oSsWOcms2ryfYxwDpE3PW8geUkg4kEfYksmeyBsanHeWOi7LGBS23EUl33ya?=
 =?us-ascii?Q?jYVtA7tlhOFMlA9hiBN9De3Irqh5s2IrBJTdWLEkcG3ATCwNY+wBAK7PeCVf?=
 =?us-ascii?Q?wGEBiUVGL7X2yhlUOmiDC2Nwh9ZL3Iju2ixU/UoGcvwGdismjsbTdE52Z/Yz?=
 =?us-ascii?Q?RZ46wdncyUWtppSf66qPIRtKq0R8sOPamh4GBg5IwQEdQrlJdwJe3szSh+uD?=
 =?us-ascii?Q?2YJA2g6Mu/p8GRNoMfomiymhTI7y4dhkuQWZnChxFp/aXrPTRxz7d7WDUAOg?=
 =?us-ascii?Q?2ULtqJtNqWw1UOy80I72+v6wCpm5v2DmvVAmMFjoQ1pUzcN2MZr1Fkyz5yV3?=
 =?us-ascii?Q?xh4FI1cEkXewvsPVETHTOk/DBclskLP3+forwkmMago3QVcf3XfXAexMmJxk?=
 =?us-ascii?Q?8V8Q31+dIwVEdua+BRsd/QZgg5lJNBQcUJ8+XnMU7PiyNkOT8zooEifD7mD/?=
 =?us-ascii?Q?GT1I+amWMWuHGT1rbk3y3v+m0etM6Vg5OJfz27oPoM9GhJ0pV2XNtf2kMUGS?=
 =?us-ascii?Q?NPhJEpiw01hSecQAtBXeNN6dBlN9RNLVMouwhs9dyAbatZZpnm5siuIsTR9u?=
 =?us-ascii?Q?lqGDW7BqY3pdvLhu6idTiPZoupMe57x9auUHXj6K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ae1f0a-06cf-4836-7077-08db2b003d0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 18:07:02.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwriWFwQoV0t2Rhw3hWbSDdBJS1ZsOEp0wbnQhvjPIjViBA5opWMbqk2u2Cf1zBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:41:42PM +0100, Eric Auger wrote:
> > I would say this spec language is overly broad. If the FW knows the
> > reserved memory regions it creates are not sensitive to PCI layout
> > then it should not be forced to set this flag.
> 
> But do we have any guarantee the bus numbers can't change. I thought the
> guest was allowed to re-number at will? While further thinking at it,
> all RID ID mappings should be affected by this concern, I mean not only
> RID 2 RMRs? What do I miss?

Bus number changing is allowed, but qemu should not be sensitive to
this.

qemu always knows the current guest assigned bus number for the vPCI,
since it traps the bus number changes like anything else.

Thus when a STE is configured qemu has access to accurate data to
convert the vSID to the vPCI and vfio_device. Even if the bus numbers
change since boot.

> > We are forced to use RMR because of the hacky GIC ITS stuff.
> well we are not obliged to use RMRs. My first revisions did not use it
> and created a non direct S1 mapping. This is just a commodity that
> simplifies the integration and was nicely suggested by jean.

I undertand it is ARM's architectural preference..

Personally I would prefer the vGIC model include the ITS page itself
and that the guest put the ITS page into the S1 mapping in the usual
way. But we are a long way away from that..

Jason
