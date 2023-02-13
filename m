Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F16950FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBMTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjBMTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:48:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8141BAFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsJymS/3ZI69TVJetSNpTn/6QgG8HPsckE3IsImp8wN8KJn/Foqu+qjg+isu221MlZpvmOSfdYLekemn0r8/5uTHR5LyHgWszL62EudiRxdGSI0kdhrI8RNOIlokL17cPuvujO3z3uc3gPLxs/v9Uxle7KBIH8R9g+L4T2Yea0WyaOhaTJCUaTGLlWNG0ATXFFKzKSgbym2BkUL3mTIoGfv6f6n4ALK+yWoSo57vI+QJN6wHaYaFV1VYHwjBWThyVX0zIvaC8w5XkYtXo79rS8cXDkec3rcc9DhvZffodb88YADHb2RdOqqdHRohV39kCUumeM9kBnrmwlLQ1/cMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WMMs1s2IWGXRwfnuoDwotnM5McR1zaTcsIrlBeqk9M=;
 b=Q66oUyxV5xxoEUaWi0XpcCOrbtSLq7/40lmjgKJXkT9RwK+cbXmYcKqs20ktpZDULNgleZlEcfGJox6oJcls28ZaIg3AaRVWbJlhReHZozgOPnszyQrixAfknsZblUPstwU+mXzXKRgUvFCwi9ZqkUSGnoV7ro9fyI/1lemkkjSZQ69FDiEZ+wRFH/DJBRRZN8FHyKJ2pUlfR2CukDLAR5aj091JMBigimvZ0virts4ZlR6Oz0cBE1YTPT2XRIlFUqRbrY7ubCC7/vPA1t86uHC8vHl5oqYxW4ddIY2n9hzcWFixi2oI/U7MzVV1HzbBmd0P5zhkE4vE/bH64uo+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WMMs1s2IWGXRwfnuoDwotnM5McR1zaTcsIrlBeqk9M=;
 b=CKKHfyN1+HwuoimmYkwPV7z7gYr/xo8JL9cswI9HJO2sOZ437E26H3OW2vi3yyMlf0upW1y19+oEcxsfLjQj/XZwRar9A7ZZkP3bIum7WKVYU9FKZKagJmXfsJZqNxVTX23unEe2KUo0hmlwvJ8RE0c04By19GDRkJtuMSzqWgmuKamEJBlFIOq00uMaLIvGKif1TLhV9zL4S/LI3p5iMKPyngKQL6KcM7cXJCpYXZyIGi1mjr4r9iFk69jEACKd9QS48Z4eSckgD757Wntaa40DMJPaQaBtR6Jf+ucA4b0IPJFdGpq3Cl8XMtfutjqY+ooTbG9K1Z7m6cLWIYgmHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:48:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 19:48:26 +0000
Date:   Mon, 13 Feb 2023 15:48:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+qUCTGEOOeV4rua@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
 <Y+qP0q9U0J2UfIxX@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+qP0q9U0J2UfIxX@myrica>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: cacd84d9-3695-4135-050e-08db0dfb4619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7yrI2K/WIMxW1cHMvKyuCZeRQpRIB3A7LrKGfx+V39m+nrh73wo92V4lQjS7cAjC1vg2wPifkHmuYp1M85fqESlKLUpftkgGrHkHgAVxsbip/x4mAz9D7HRvPPJkDXQxqtLWhqGNSGmWBVohBvNZUL8hFYSnwR1NuMtBPT9oozeqXA7tdva8ZXRlGBfLHxLHrTNczB9zdZjcjs28gvG1jItwbBhIEKB0YYPGBBA6JIFa687najTDv1dRxNtuOgpoQaY+xa1gmLFAziSLAr8EBxN5DyT5xNUdJb3LQtcCrr13ABDqaEiCguSfUHgxfETwO5cz0IS7YCn6YYhNC4J/R7RfHch0ouAbM90szU6deflfPYZi/v5YIP6KqbDH0VByyDG+GnyBW7PSTtI8wV4o5VHMum+XVRTIHjT7Dowsvx1IEwrSNPTKQlcGyTn+huiGY9TKzX1Mm12DzNpBnw1eAfwC9vmWSoyg0ZI3ZfPJj7wvPKvhLkiFXFQKvjL6N+Ywnbg818geXxdCHnuu7bsuCQ8YJ2w8oqj/0PLw7jWnjlMU/NR6dGywwehZGfFLJQw8P9B6QuYrNkSF9drzxWi3h0eIMPT0n/3aU7WpVQXGZyBth4oT0v2zBV9h7xYro0tDwKF7Dqv63FUGvYRImBrMJ8vW0gJWAYxMQIr7C7BbZFOL2qM7DwHuEqpWzs1RgQO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(83380400001)(186003)(26005)(2906002)(36756003)(7416002)(5660300002)(6506007)(86362001)(41300700001)(478600001)(6486002)(8936002)(54906003)(2616005)(316002)(66556008)(38100700002)(66476007)(6916009)(66946007)(8676002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WM8edvTJZYw9Mqkcck2HneJ1XIuy/s/m1ppg5TbEo3L4YTW13i1qIzS21Dqg?=
 =?us-ascii?Q?3RaZmpgyko0nDf7xX2FctJ1efpSQHo12R5IstWDqs6U5zU8qPpA1idLeNnSf?=
 =?us-ascii?Q?JHj3cYui3yTBuG3+eztbM8SKc7/pSC5iVhLfjF8409eljKLceTfP3Q7+/kh0?=
 =?us-ascii?Q?L0lW7FCmX+4XN2wvdvVqkEzHvJgRUtOaDYRFa2fcnAdMLFeE4lmnvz0SXM++?=
 =?us-ascii?Q?CcuNShWhPbQZqxzMC9C7tCJ6KGJtcNw5burqd7rhdc7wqw4GMT198yH0lG9b?=
 =?us-ascii?Q?Lw4qj+bVUjbrA11GENRB4pohhuhXhVTBAHlaVMlmNHg58YFV39Qbws5HcdTx?=
 =?us-ascii?Q?MY9dI+YIhPj/XLtbP893LeF1VBUmIUX0anj3WV2kWuvg88NlKYNwq9tecdEh?=
 =?us-ascii?Q?3TevgHUZjizb/0pMMYzNY5vMtN/UzeVVzS6ME/W6AROOveO0A2O3pyJu1kZx?=
 =?us-ascii?Q?FH9zYxNxTK1YqBXCKR5/mmZhyV1NFVrJJeh0pN4jBoy1YEHdal2m5Z8QxZ2L?=
 =?us-ascii?Q?QmsVh+n+m+aGp8x7kfDQk6/+Q0/LH8J+FAb6GeHbhnbqyY+Bg/8WnmvfTw8W?=
 =?us-ascii?Q?zxY8lY8N9IZNiTCNKA47uPTHgfat8vo5bh67RRClHXQALJnRTHb21x0GTYcL?=
 =?us-ascii?Q?60ARXuXxzTKm+JUqpD6wIBWJjPhgYFrWXRvZkVu9YU/SG2XRI0lw92h32KnT?=
 =?us-ascii?Q?ksDvwD5/bU5kfhryQ00cKYctPcz13bPEyLBENo+iWwIOtKZNUw54xUwo15CT?=
 =?us-ascii?Q?GEfYl1OOAzpx5zErZnlFRxOaU8ZtqxQ9syEf/Ct4Zd/IYuw9bD0/EHEgNXq3?=
 =?us-ascii?Q?iuhxgcpcqNGicFUqRveAG/7z9eX2BqCqbzCrukh4a3A5XrSXLYo9++c2LXNx?=
 =?us-ascii?Q?06/XIV5Y7s+cKhr9pzqDuGMHyw3CUlyK8WUmNRYtVRLqYmMz9ZNwjoBdX/qR?=
 =?us-ascii?Q?v0acSiiVaNOgoc92yGuOpjy6mVmwcl5MhB9giD0xRygJMu2xZfGKoSxIbGHE?=
 =?us-ascii?Q?t6psggpytIqUuGv5WzJpESvhEoSikwkMCyvyJmjM9TqnJsF6K7YTohl8ijH1?=
 =?us-ascii?Q?C6vEU7Cz1aIGFxBOo4m78YRPKnTO8rERuZoHZR6eOpdZtpPossR9rUdxP3he?=
 =?us-ascii?Q?yMbZwXiBwZ5Fpc2jG2afNYD604J5bgYnbwJLztBZnlSgmdVlmUqj8b4RD8TE?=
 =?us-ascii?Q?FikoC3j+pQDrTjg9JdKPb5OWhn4iDVeNgwKkAlCt1VJWDg8tgoE8K9vIHBBw?=
 =?us-ascii?Q?c57WqVJDJOLwssbFEr66vhcStJuNDQvnH7xH2Dr4T1uNsHdEqzq2kbKv3Vrd?=
 =?us-ascii?Q?jAH5+DR+3Xs5Ujr+fCp3UYWynxY8vCHcPFFFBHaFL8NM1AlhbkcEDKct6xVY?=
 =?us-ascii?Q?GIz+t3E+3LbFtnnD7RJqJw/wnJxEcX88MAfKkYnT2YCInpi00N/KfI4yfvC9?=
 =?us-ascii?Q?oTSDVYDPsDw3ereNbYu0Mxzsm6yk01f2DBj6XBS/iLN0msVy2pOFwF/G23rP?=
 =?us-ascii?Q?sYQcV29SCGtE3CrZEXW5cY2uLd9nzNGZIwpB7XaldX0N+h6KgnrQenr0xLux?=
 =?us-ascii?Q?+Nc6i/QWBCmaYdwGeiIXu6asK1XKuNQe0KG/RPZS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacd84d9-3695-4135-050e-08db0dfb4619
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:48:26.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nsj2pZRBJulfeCf2TCkZVKct6AfTsPfAnwdZJaMVNW3yL+Ig4fJCgeAn4dU4VJvQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 07:30:26PM +0000, Jean-Philippe Brucker wrote:
> On Mon, Feb 13, 2023 at 10:34:55AM -0800, Jacob Pan wrote:
> > > On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> > > private data helpers") removed the last user of ioasid_set_data(). I guess
> > > that could be dropped too, unless you plan to still use it?
> > > 
> > You are right, will remove.
> > I was planning on the other way around which will convert VT-d's private
> > pasid data helpers to common ioasid code, but when I look closer the
> > private pasid xa is just holding a list of pasid/mm which could be per iommu
> > not global. Another cleanup I suppose.
> 
> Yes that should probably be common to SVA. I'm planning to take another
> look at SVA on the SMMU side following the recent API changes, and from a
> quick glance the problem that VT-d's private helpers solves is
> common.

I think there is something really wrong that the drivers are somehow
tied to the mm_struct in some deep way.

The flow should have the SVA iommu_domain be created and associated
with a mm_struct in the driver.

At this instant the iommu_domain should extract the top of page table
from the mm_struct and from then on the driver never touches the
mm_struct again. The top of page table is just like any other
iommu_domain except it isn't mappable and it isn't allocated/freed.

The driver will establish a mmu_notifier in the driver's private
iommu_domain space to capture invalidations.

Page fault is handled via common code

Any invalidations act exactly like any other invalidation - the driver
goes through all the cache tags associated with the iommu_domain and
cleans them.

What have I missed that requires more common code or tracking a list
of pasid/mm?

PASID attachment and invalidation is general, and has nothing to do
with SVA.

If the core code provies help for anything it should be to help the
driver keep track of what cache tags are linked to which iommu_domain.

The comingling of SVA and PASID has made a big mess in the drivers we
need to unwind.

Jason
