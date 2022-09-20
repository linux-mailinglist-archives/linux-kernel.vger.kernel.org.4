Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655F5BE6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiITNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiITNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:14:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27136248DF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScZPEwpb1n7y0pRnVWBfWod7Qy19lSFDa9vWid0m/Tb1k1U36yB0DZzirIKCsdOg9O9+9dvXSqQg5iaSJAjzXk65QtIL77/CIzFuEI6e3gMzzk7AxNYkDndj7BWZYeer+mrhvEtCFef2zghksXuCmgUKTdSCvtTrFCHm9xg6bfRyTCqFDB+RWbWvxLLdi8v8xDS571Pk3o9xdRU5OvZYF4miZEwWjRdG2WVW14dILLsGkEDyZ62mQDhHnZg/kGJao2PsdLWaFn6dCzxF/SD1VIpbx/IyY1LdwAvHH6+eRAc+OEoY240j7Jpfc3FQfOTp5jfGTdCZZipBFpmQBMo/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XhpXCR6eI8znDvdkkBXgbP0Ey+dxSGJlXtEpOGbycU=;
 b=iEyKBUjVTcQ7T7tlcbjXDbUY5X6W5mZC6ikxtmiYeYVepDtoxCSw/Zm6MC5/GdhrLYOhAr2QGixm7tnyqpV0/kP+Aqoy4aOlFRQ4oJf6yNyxQZR7GelRJc4001qa6bxuZJ33Y0SgVBUD52j0hUhIVoNxKwPOVQftH4heL3GLXrBT3tj3foM4cKdBWid7hy2rXch8Gj62G2XfgkunIBjqwWp+bc90ujnos8NnzxMtc9o6BWLBdflffsOfXidkAum6FBxvhxbzaTqG4XghAc3WGFdMPpd1gpkXIGdRB94BpmdjDbn0Ymdz3FPCAFH0ZddaGp/RMkmLqMxN2ig3I1DTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XhpXCR6eI8znDvdkkBXgbP0Ey+dxSGJlXtEpOGbycU=;
 b=DaRfkL/lZ1FPAthF8NKfsYBvcRqg4p/JjLfZsOco7CMXf9p6immGDHzsEmtgyuPsq9H8Hxe5wqCAajC6ZQedkuZJU8O2XiwdJVcsWkkVOCuEOgPm2uxn+5OsqfDMFifDgEEEI2O1vkQ8qcuuLWiKW6jnH0mTngNh0Yv5mkErz4CvqpoNaZ5tERGeQ0uRi7F1rZllbBvxZkemWx5yarX7pWf6gRxllqmptHW2DfQN7zz2sir2b2O78AFGD5x2poneF2GRMzeVY+JI0RBETZkAkA+uxFohp56fYBdz3GE8xkHAShxiIYFJby61sjqA8+G2Vxdi3YLlUdWtWt3lO8ic9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Tue, 20 Sep
 2022 13:14:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:14:55 +0000
Date:   Tue, 20 Sep 2022 10:14:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yym8zsuXbYaW3alU@nvidia.com>
References: <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
X-ClientProxiedBy: MN2PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:c0::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e5c8f8-828d-4e7c-67a9-08da9b0a1c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4e6JOgVTLRs6qH+7vtqbEmkBEm92ypHKDK+44F2Ji75fS9t8rrB+tXmu5sue9arYfZcMbLxYghbM3/QzJYbrEbOs+IDIH8bcKs0kpJJb9HlsjbK3mhSRru5GhN6GComckDwUXBxUnC3jrgA9Qi2caBxn8NUCO1VEKdhbutH+rDNCV/7tNDMXQpjERfij9OlLf+wggdBsqPT8666wbwU0xteus8Kg7e0GMMdHmaqZeOmwdJhbCCqbup6YsgqXSyj/TXZombpoZfpRPUyfSz1NKBbj4iPCx4qNlfUoHjfjh+OVKXy6yIH3XER9cqmACV3tv1FdF5xlqfkKPikcLsMnrm0DPDXW7qR6ao8Xv+usO/X4IzZkNEk3s4hSDG+7j0EcTJEjz9Sr/zquEAlJb26cbOmRvREMvIBGbGaEX7WlvJG93cZCg35sj/gbZn5NSImsESTvBUslNAYEkPAz22ZEXKcW+Q1Gu/8g/EyYoGtNEtBLWbzqUlyh2CJPn+Fvqq7VLHWph9aNSeKcTrtzl5+kWEaH5QoLIDo8oEY4uo8+1uKjPb3HKrjl1I2dymUgbXRExM1N+I7I7sXJaJdjfWUL9+lHCRrPTeN0QWFHFn3pxqWT+KLPUMuDBNcoFwDXhpMMuKk7qIqgOU1UL2Vc6Jt0tyjvPzVIMoYnhBN96/yQ/kbAcq4Oi4TIj4ahLmw0tvb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(4744005)(36756003)(66556008)(54906003)(6506007)(66946007)(6916009)(4326008)(66476007)(8676002)(26005)(41300700001)(478600001)(6486002)(8936002)(7416002)(83380400001)(5660300002)(6512007)(86362001)(38100700002)(2616005)(186003)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsCNxnfeoUFB/+3KxaWy3LFnuxK/qp8lXob7ZJ0MWRgKWeHXZ79JLcB15RcW?=
 =?us-ascii?Q?Gs6x+BJVgoLkb3/haxHbPgnEiWwhJVAHb7n51Yw5BgeTVaHiIOxTMmfBV6KO?=
 =?us-ascii?Q?Ty6ZtvrEomivWYMsAkGPKMEZ3614SWJyFOD7WRDPZ7/WuFQLvSGx9Do1B5ye?=
 =?us-ascii?Q?CvLXlrwMkMCyuP9XfFq1guowodiGGFRgzO4VbASYoF6hJUim0mOhSBigOe8y?=
 =?us-ascii?Q?Uz7cBrDqn2St/f9eERGzHd/Fh2WtGD+53F27HsErDpMLNNgqUzUmbvB2I4tf?=
 =?us-ascii?Q?X/nFvy2aqOGkAQsjW4ocH2yMVqUnExhQxq2bce/LeEGNtjGIAAeC2ekRRyCP?=
 =?us-ascii?Q?vaMiLtBt/MXQz2k8+uOLZR/2E66l0o+RM7twJFdFqLRyPu6df9eESIcA2+28?=
 =?us-ascii?Q?KkyRR04P7DhdP34biGWmQ2e6ASTsHLurrLWeXyxrbTFUnstwAqSZ80Sn8mIU?=
 =?us-ascii?Q?sQzTL9/SCqY08d36E+4PryUHVLaNADDMYZbk5l3YQblnhiQmgkO0HJ6vrqDu?=
 =?us-ascii?Q?UiHOcGUzM3L18MmuRPthaJ46xgTRhHbw9YkrRNjRCtnjFVaLGw6r5kiAK13M?=
 =?us-ascii?Q?kCfdCZruu2SZecCeYTPrbeh+mEwyzevW7LuAwZ8b0c6V/ICJbDFaB72BHNrm?=
 =?us-ascii?Q?sgzXktn7t+S00OQQqNB3afQgxV6Ver9uNRYKxx64HxgMlzdHj5EHJNHQudcH?=
 =?us-ascii?Q?17mrd23VoVVZX0/8N3e7uor2pxSlFvjs7WUVePNtq0JpknHntenzwo+xPWWe?=
 =?us-ascii?Q?0dOqYc1CfCrPWVjju95HM7nMP/G62qI/yTnZJicBjrx0U4ZcBGlfG71W9Cnp?=
 =?us-ascii?Q?wId67VA/gcQrsRlRzmA7DrXyAMOi4Bzznz9eFU+n6yAIexPjOQJOjJxLhRwD?=
 =?us-ascii?Q?o2x3VeIfQhpbxxU6gV/lnPALq5lQQkMheaMyARLuuqu/dShGJdSrIn9tNfz+?=
 =?us-ascii?Q?lLhQV/G1wTRmuqxoNGjbtATjOQ8o/q5EYEvy4VH2r1wgtRvhoAJfE03gshA4?=
 =?us-ascii?Q?1EBWlazB/01BB9owtu/2b86fGdvVNbCDAuO9whz1ZdFyHA9EfVK+MN9z6eQL?=
 =?us-ascii?Q?2DQLsiA3fDoP45nWpwI/idzsa9meJt6r25E0lly2wr6soiGyfs6F87DNvjK3?=
 =?us-ascii?Q?65KJ7Gq2kw+vlSCt3XagMuqj1MRxj5mrL9cWlkmLJj715wGpnCNkfAAjLqDL?=
 =?us-ascii?Q?TZJdk132Mv/BDO9M5620XPny3xw+UuNd1pCni/QYaY0GxUGNSRiH1uUoPMyE?=
 =?us-ascii?Q?UZn7vWmFJaY7nxGZNw00ghqipNdKDh+YnTKsB/6Ooyee4awFfZZ0gj54+75X?=
 =?us-ascii?Q?47DknG690cEYRu4521FtKGQAOKoeMR3gNC5sLtwYmVSQKeuyiNimy+WXcuuG?=
 =?us-ascii?Q?DQHfqbGNuRLUPgYkRPyEZIBI8zshboBkwKIZGu8FEN/f3bjTySjBni0HrqRA?=
 =?us-ascii?Q?YcbJEMsKbznTggoP86R+g5qvgA26H3VxX51EU0RMFsGQOE0zoCBfh5fFxkIP?=
 =?us-ascii?Q?yyBJeAVX3xukUuQ9V1la5I9Cs6kY5+UHgJvfCglC1ZopFnLWmw/9eCML2RnU?=
 =?us-ascii?Q?28k86QagPCB7ldQS1vjO/d59THbI46cSbhBPqYLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e5c8f8-828d-4e7c-67a9-08da9b0a1c3c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:14:55.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu8vVRUS+8ou/XoDcTAE1dWO76oYM5FH1PM8pfwWq0ubPzYUCDlCyi6doft1SZ51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:28:58PM +0300, Kirill A. Shutemov wrote:

> @@ -31,7 +33,17 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	    min == 0 || max < min)
>  		return -EINVAL;
>  
> +	/* Serialize against address tagging enabling */
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
> +	if (!arch_can_alloc_pasid(mm)) {
> +		mmap_write_unlock(mm);
> +		return -EBUSY;
> +	}

This has nothing to do with "allocating pasid"

Rather should be: "is the CPU page table compatible with the IOMMU HW
page table walker"

For this I would rather have a function that queries the format of the
page table under the mm_struct and we have enum values like
INTEL_NORMAL and INTEL_LAM as possible values.

The iommu driver will block incompatible page table formats, and when
it starts up it should assert something that blocks changing the
format.

Jason
