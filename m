Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB35BEB18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiITQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiITQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:27:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0E5A8AC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SldR3Bg4B6drrG8KnXkAyVxPCSwkqZxy6J0cXisrMkD5716fHX1fqbldgddu63quu1vzofYMU2qbAZnGpuz6lW1ASb6C9LAui6UQDcyG/P0nhS2o1drEZByHuR1SiLDedTj5eV3sqkrqobbEOgAEJ2xjTvs6yDUdk5sltcgrzlUyFa0A33jhaGTFEbJFUNh0+BkKkZbCFeCxgxnXIhqIKQbhYdfrTCrTalMpG77tojr5ub0UN02RYPt0hvuiRLNUgZzMPbpt68AJQVKcqXBZgiqKZnAcrF+eNqOrvCzuFupwwBSF36EMzZMjHX5f9fW9nSg39yuB/GsCCDfA56SnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v//adKRbnVAcYf1YbMKo66pIjzZOJcpZCSoLk90bcDw=;
 b=JI9gQX6/RVWJOkA+BwM1GWdN7heG3yxleBdk89lDBv9Y8rUg2N4OZLkjXAuD+3L/xi6UGP3HaREcgrk4P23TSjFVayxby7hP93Alqp/FWjMgwATTrr+JLSwn+n4lMKBGtyMTVpmcHh/cIY6HpKZWaS6veyP10kSt7oPrgu87ld+2InhJwqbTXlkl3GVfy4advKMjyvy6yWwcNPRgBcn9lwKJrCeFhcj2nlsHJrADTO2XKUu42ug322lFltU3cTsYRoxTWcJyLk3e5euOljeEzkScdEtUjSn8k4UhkX6nIdr3WVXKhjwKwbYMJ6ozqIYd3R9seH3KmuMqo/RNULqwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v//adKRbnVAcYf1YbMKo66pIjzZOJcpZCSoLk90bcDw=;
 b=qYczY8yIYPj3PkIj7vs38ERmrwrFRpeENDGKyhUxbSKpczFm3x1mW/A6fPhdQbzN9XDTu/EgdrVe/7OFi0G+u4UemWS14XampAFQlNRz41zB/1gE+7LXr37ftAJhMC2EXO7A5D6XY2QhOmfEDutQUP2etZl8r86rbUF3p6ZTaN/tzzMkVkGuht4OIxpJkvKV5gctl+yXXiWwZ5qwg5h2T+qgimIsoCqWn6eK/aNW5VWRqr0WpnGlJEwnvxJ96c29+IAq0PRRX6IkyYULo41okGbVeGEkCu3wJeg+8fzYyVYgUAYayRqDhT8llonr5xTqscLx831oAEa1ni8XGONuUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Tue, 20 Sep
 2022 16:27:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 16:27:31 +0000
Date:   Tue, 20 Sep 2022 13:27:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
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
Message-ID: <Yynp77km4SaHpe/3@nvidia.com>
References: <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <Yym8zsuXbYaW3alU@nvidia.com>
 <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b97e57-ea0e-4115-2d1e-08da9b2502bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlrEM5lZV6AP6gFdlOKyM3xbMY/7vDnsIpLyM+AACnOq5u9wQN5FJvTIycE4x7NUiI5/Wl/WdhrFmW29L/RuNe5SxhaZOpLSd1EVTXGAWTg1c60hqAQi8Fb3NtirCjSfZk9dw02o6Hs36LCVGmRJ+ArlTJd/ypLMaPum1/HjWJ/qUpU3cOAJwEG8NpIhu6azcHbYvKZWGDmuehDUH2KXPPm/F8XVW8VWzdjgf/z5YxT4HRWVgG3fxJuwY8dejooMmQCMNSw6I95iLZs4o8jFM6YYmZkEqDbw6isa55NUnXctLYHupRNZJ7XmRzb0V3m8YVlHb6vH0g4QKeAU4cWK18Hbm3xpM3LR18NELZ86LF++a0tDVtCpVS4EGwXFeKmq9rKEPqVYEciLk4ng8YNDPWI3J28CPwVtseGw8Ec6GBS/yZTkk0NCnq2MFjgW+rnkIIUcnKjU5JUfqiZaYQYDRUBLZpyxqE+VlXWIJJ0xbmust7DixejGerWmniYcKrU2QAqMHJVZD20cf+ft4SOsH7WlRXj4tF9SdHs99TTFDxSvjcg6aOwCsyRlo1jJ7OXV/X2JNa+qihdCMRvgr+5TR3wzcCkKrQlSyNSEhV6i010ILpbRIL65FIuhO2OFi2eHlDb5lgC3OghV3uAyAhCrBB8KY7ZjhNbARxqLf0/My75tnNh4VbnhvZFHR/vnBAUcNwzoZoELKL6VRRtlvFoHdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(26005)(6512007)(5660300002)(83380400001)(7416002)(41300700001)(8936002)(6666004)(2906002)(38100700002)(2616005)(6506007)(36756003)(54906003)(6916009)(186003)(53546011)(86362001)(316002)(66476007)(8676002)(66556008)(66946007)(478600001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kJ2Bw8IQnzbM+cLfvg3NlutQlhPHoTIe1dPEUfdNQ/EK0gx8e/HHnyheUn5?=
 =?us-ascii?Q?lHolw8Ednos6ZMLp/cdyEnKZYKY732X2KOLjh1qgvyY88iKD0TVgc9OTB/W0?=
 =?us-ascii?Q?UV3+W0MfG1PYfGso3nAJVdF9ZCestFNKWqE2AY1su3oxUGR26Kfw9P1P9FpM?=
 =?us-ascii?Q?X2/p7WeIBv1RW3MTjcIHjYZQ51BRpSb/I4D3QJFdjAFTNWHrjr2Ayp/fLaBZ?=
 =?us-ascii?Q?xQuJ2QLh4TF0Bgl/ON2l7s7JNTAH01rte44t31xDMBmpzXLit7dIkzCooYNP?=
 =?us-ascii?Q?+vmLKoF3LqnSNsdLSEgp/jL2GGnh0DP2NfPW7CcPOyWCQzZn9CadFwZRiV52?=
 =?us-ascii?Q?SKJNNEdQkfqdrHNR5QazwC2FDUDFsTV297+Y9AKL+buuvhw2fZpKCzSMW7H/?=
 =?us-ascii?Q?T12wtAdve8uFXUHdKtvpNWZEqe6Q5Ab6LwXhUXuCShTaJb6YN1Ap1p5cfcfn?=
 =?us-ascii?Q?LymXghdAlAuvdJq6V4+tFzfARLHbQVqYKoOyfiKwiyiKG7RNsHhdU1axdoWc?=
 =?us-ascii?Q?fKOoaibSut+CA7K3YdGlZmdXIWS0OwOb5p3r2PN3+9u2P3qtGUa/zLe+6KF3?=
 =?us-ascii?Q?3YYNXfK2ysxdQMNF7Rw00/jvO2hSqdeJcmtEo0dXldUmappfbh2tPggc2iPz?=
 =?us-ascii?Q?0wfx1J3b5794SjvFC2rzNZU13sITJlZqTjQBN+O7P1wM+Xp9FjVLslYGCkT8?=
 =?us-ascii?Q?kCvRz3ssmzpdw2wzKKgtBoAds3BuoWSKVL3i9ksdOdmyRSDkjUM5sonXYqjn?=
 =?us-ascii?Q?8KE30R1NjHND6qGr/smu9eyGfsX/+Ba6VaY+I4FkkCEwoFfSlDbt5mOMsYHX?=
 =?us-ascii?Q?NobP191y0EShbznM8if7zEULZOO1yDmi6K6SlqUZYsicHkpj3akgdE3hQPLI?=
 =?us-ascii?Q?mCiuw1wJzcN9UoKLoTshd6UO2nRdU+a/HiojEt7tDypjDbFUBbnZYsXRdj/G?=
 =?us-ascii?Q?SMokNCoI94oWeXa5ij0saSH28irboR6I8okPOm8QAiKuKNlXEeyKQFMGLBse?=
 =?us-ascii?Q?fxk++KfGaST5TCz2TVx2CHxrlxHGTY3K6L9uZqTn9dK7aGIE54Otf+6v9dHd?=
 =?us-ascii?Q?WPjpsImprYbXfTUrgaI/i8I3zXi8yMydAc43ji4QwoHrKLUszZZaAKdBrvvW?=
 =?us-ascii?Q?OymGNuW8iJU9CninI5p3Khmk3rRjZWhpx5mBSZFko6/CcP2A0MGD3NzlbgBn?=
 =?us-ascii?Q?40HA/m7OVbHIugX2tfAjx2b30Q3+HjynDGDw4JBdAtTuGCwKVPbPejko2hx0?=
 =?us-ascii?Q?xDKxUN6+tzkCgEROTFQORLr5T2ylhh4rWQQnaGprh/5TylWFTDWX2Ut/XO6D?=
 =?us-ascii?Q?TMI+rjjabbErgOO1gcN7s44HJlEivn8c1WATF3dhPezJQqF99M8ecZlqVp2y?=
 =?us-ascii?Q?uT+qWnRC7SazRxqz6U5b2/pzeIHGBP3I83+3gZ9dGN8zqb6n773I45vFffpM?=
 =?us-ascii?Q?RKpNgPBWBgMhK+a+FqNqO2gvjWz93Mj1ubS4JG6jLUcEEKaL0pqA1ME/Rpvx?=
 =?us-ascii?Q?gvmoe778bFQVtFrTk9HSqty2EDWaTLcNi/XPTtWm2I+AM3FWJm/MOSvuF796?=
 =?us-ascii?Q?Elby/jB8xdQFT82yqlzHHzZGMAfqkYM3Y2wf8Lal?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b97e57-ea0e-4115-2d1e-08da9b2502bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:27:31.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+788yMObFufwhi7NLhELIMPQorpfItdOYRXP4Tb9C5OVD35zb7N/BwT9YM5RX3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:06:32AM -0700, Dave Hansen wrote:
> On 9/20/22 06:14, Jason Gunthorpe wrote:
> > For this I would rather have a function that queries the format of the
> > page table under the mm_struct and we have enum values like
> > INTEL_NORMAL and INTEL_LAM as possible values.
> > 
> > The iommu driver will block incompatible page table formats, and when
> > it starts up it should assert something that blocks changing the
> > format.
> 
> That doesn't sound too bad.  Except, please don't call it a "page table
> format".  The format of the page tables does not change with LAM.  It's
> entirely how the CPU interprets addresses that changes.

Sure it does. The rules for how the page table is walked change. The
actual bits stored in memory might not be different, but that doesn't
mean the format didn't change. If it didn't change we wouldn't have an
incompatibility with the IOMMU HW walker.

> Oh, and please don't call things "INTEL_WHATEVER".  It looks silly and
> confuses the heck out of people when a second CPU vendor needs to use
> the same code.

I don't mean something where a second CPU vendor would re-use the
code, I mean literally to specify the exact format of the page tables,
where each CPU and configuration can get its own code. eg "Intel
x86-64 format 5 level, no lam"

At the end of the day the iommu drivers need to know this information
so they can program the HW to walk the same tables.

Today it is all implicit that if you have an iommu driver then it can
make assumptions about the layout, but if we add an API we may as well
be a bit more explicit at the same time.

Jason
