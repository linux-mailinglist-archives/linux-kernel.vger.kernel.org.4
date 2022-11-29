Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782063C8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiK2UJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbiK2UJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:09:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A675B841;
        Tue, 29 Nov 2022 12:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwRZ3AyccZqtqL/7W5t7iPYOcilX46LIa6qllLmdwRLqFxdqP8irEnAny2EZJHqxmP9AkVVGKnxlWudHV85PH+rPR+80Vviy3pN9KcG+Ci3sDd49+7FST5GR//iZjVa/8yRpaO9nt3XAF0aM6Bzr4RSbMVUoDTkrU+WOeeouqjFePx8QheoQCBdy2tCSLNo1fKUSr3qH6GKdD/gbngJNt8lxcVKHp6UTXmp2RKoBp7OFYQFQwrO9z6HTp2l5EA43JkffMzPkL+YYcCeGUMGJi1mEFxyY8QXQ7JqR8pdDrV+1YzljAJRJ1Wuyb+uOhNOPSpTOPdOWqcpMvQ1lkLaxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1NPcNU6pJ2j98YvgPWXbMA5Ku4st6k91kxZOME50Hk=;
 b=GUq/csSCoJawb2wCdS7oA5suFdy+9d1Ed0VC2Lr35lUb7tN4gsI8+WmMUlu/90lT6GS9Dax45HhzmhjPmD1HLE/kYu7SYndOB2wV52mrZt4WhRc/ce+2koTzqRMwwcm7l/jvbb9kE4X4lzuA7xshSUvsUS/xigmi/DUZw2IcZG41ohrRcqreK5WSON5PXgAEvd7Hb9crREUmJM8UL6ydJqp0rHcVh2BMqAhMLmjhQYaOdAyLn5XU7DDDMvCgs+6XmRhOrAIp9vmK4sJB2esE/fJg25+blQxdw9rJwi3EKAwbcfFKHiWSmO2hGrTwhOVnuRfH+DRWiRomPL7U0N0wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1NPcNU6pJ2j98YvgPWXbMA5Ku4st6k91kxZOME50Hk=;
 b=Fw2sTe4VjclDU4zd3bJcDgP8EuhvJOXUrwQy29CLxAxNILL1FC3D2ru5tD7nEc2xDaQJbtHLO9sFywk0UsIPuO54U//6Mz7lRYqwsDULRef75TYKZIXFviVaMMu2ximS9LhnWLBlZkm+74eLzyX1qlKCmr+/f3N8/3R4xfxMyeZWUKgt0SNdmX/Ph+RPFjTudxjKoVq1Umq6TK4ZvfJiLOAtJCzTKiu1WK5TtTFJ8ErpMM9kt/wHl08TDJzouj2H5iC21qUX+IB+yj3wL2Q4p1zqUc2xul7ECg4QXsL0cMQcsd8GNjLCPg4+Yi3MuN714bi7TPCNPRj9QMBpy3ma7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 20:09:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 20:09:13 +0000
Date:   Tue, 29 Nov 2022 16:09:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y4Zm53o1ovdIAqr/@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com>
 <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com>
 <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe869f6-777a-4614-93b2-08dad24595f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lh10gPVexaw1JqLfYAwfl/rvsbbB8tJKS/ca7/2EZde6OR0aqhNSpEanx8GgeOz/8rYj4Wec+r7q1AEejOgOoIYFwRzjpr84nMOu/VcRQzhrM388qhSiKi1f1zOzNaenPtILsj++va+R5VWsDfl812C9AElo5yZXqFxyQtRLbUMsB4KqyJGf4MeWTK87VZcA5Un7pQ7StkNB6JLCIjlE4oATbWRqFT7ypHQT0dVbozZwVqCSZFsv6t9YMQlKB4a7lrBAgEg5PxAh7UDRmlSRrPAFt/P1/ddbEc4YXdkttTYmchpcKgj3rtdawCYhxw12c6Mt1OdP12IC3YA/ROOm3tqa6vMob5hJiZLTC0mOaQ4n9Gb1nlNXtHaDScs3j3lFEN+h3z7iQVSVyD11RxTzFd5kTP26wwFaWZ3+ma125Cef6uLxu65cb2J4/Eb4KRbvS3fDICb8sXWys9vjZaT7ZRb5MMSH0lZIYoTEyIp2Jm8Vv3jwhT44pkux+RaJCHAiy0dmitXQYTVtovPZYBhOj9Iee6MvW/8wi+R57NeZYaxCejbb5QhQgSkUTw8ok/xHduSnBfT6kbFNTHmb8jU4shSG8rkeGkrlqw1a7lfdXi53czHBOE5k18J+eibXePflpZ7w4qANSFK3REwcrvdZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(5660300002)(7416002)(66476007)(4326008)(8676002)(8936002)(41300700001)(6486002)(66556008)(36756003)(54906003)(6916009)(86362001)(4001150100001)(66946007)(2906002)(316002)(478600001)(6512007)(26005)(53546011)(6506007)(2616005)(186003)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mY5erK4tjLF5/gcs5qkM1TpZwsPO2fRmd0iAa3Wq9sd9xB3Zbqbnf0TY3n0q?=
 =?us-ascii?Q?3ttZZU0qT80zGuPP3Y8iwDte2V1ITRo6+U2oQmTM63piENXt/FmcE0eN2kRD?=
 =?us-ascii?Q?Dgrluf8g9ln9ql48cMu14nuKR/kPR0nGQckO6b6d0XLNoyrrKEIg6TGJxsls?=
 =?us-ascii?Q?i+wFMaLlmXgJMCHPKyQorkLwkAtVjhk9eUP1qvqiuoTUGYRAqnqoowVtjkDX?=
 =?us-ascii?Q?USQJwwBTWr/4mzOjDedBLAmyAgSCIFkn3Jd5l/NSIMJhsnXZFQNbC61okG1k?=
 =?us-ascii?Q?a1u3WGlumngqk7FvSZpZNtJhiU7IXp9AOjfbIt1tTUXf3y919uKGZsZrPk7V?=
 =?us-ascii?Q?tCcQdwSwp2XouaiE/kvUZsBOSv79ihSOXX7NSPqq5Jb6H8ig5waQ/M7IOgo2?=
 =?us-ascii?Q?4rs2rg19s3Bxb3+7CgwdAnwGEpWryPiUYwlHFmY/AX4K2I4+iNyFJPYs+2mj?=
 =?us-ascii?Q?4EB7vVbR6sCn06HcafVuWTOaQd09iWFHTB9Kay/nwdrNFDGfaTCMaRJd5iyq?=
 =?us-ascii?Q?mXqOg6gGlp5jqfXhFDrQn4RddiPh5SzvwAEmv90dez6fFxFzB56uQOlu+Ioq?=
 =?us-ascii?Q?FolNZcv0gzVNAoqEe5CuJw/8OiMYDuVFthSuuxJ6lzjTQoLp4+byGdGLtwSP?=
 =?us-ascii?Q?wh73VNdMXHxDZ/KhgOBEfQPRZU4EWrIfTFz7YOgZNtmkE9RsvCC9sIvHPHWY?=
 =?us-ascii?Q?igRP6H2M0Mbn34PehKWwxVkv5zMNSO4BJex/dqz0FyhxDs9xV0XTLghujZu4?=
 =?us-ascii?Q?IogFJ3xtUUW5HovNLOVdMlmF71yiR1HD3sxKnw8pQFx+tilYDnlTRm5JrHm8?=
 =?us-ascii?Q?ym7ecVxiCAcNme7MfLiLXt10gPtu6Jt3OqHe7hzPrPt1IgWt2Hm5iohylfcy?=
 =?us-ascii?Q?Nmc+Z1NL1Z2hYvruivKRRZlciEUnMWD68mIoXgb2C3sEUFfjRB8sWdK8l/R+?=
 =?us-ascii?Q?+nabKLhFnDOjg+vE1a8qB85GVWwG/RJre/k1iOveouBg15ucA8KcaHcL5gXX?=
 =?us-ascii?Q?cRVayRnKTBRrmS3ikMLNKVjT7ZrmNrOXOtFRmegCfZ7o6f2BVRP9xZp0vS2t?=
 =?us-ascii?Q?PL/PtewZL1V7/zFT3+Kesdc6CUVps5AWmOg2KxYeA7rdHWc68WtHlc9s54/G?=
 =?us-ascii?Q?7zSy9KSJuyRBQVAZmd0p6vPB4HyfkXpJmfMUkvBB5O7JVY4oveKnGPDGEph6?=
 =?us-ascii?Q?7U5lKkoh7vpvbl5NZcf/GdzMhb86fwIt3B/AEwYsHkGMJacXJSoRMoxywRfp?=
 =?us-ascii?Q?YVLBHnXfjo+Pr3bO4bdE4F635Byt8pcoTkvkm1YZ7Pp59zXl74TwPQWVs7Mn?=
 =?us-ascii?Q?ZH5kkaSnM3GFzuaVC1n0Hk8aZqDskTjJkV+8NzfI9gebTFcGKie2r39bwUIq?=
 =?us-ascii?Q?Uj2a3t1G/omC+o49c592ngMXIDspjRIlqtnmFbtb8JRWXOT9u3IDBHrZOPDD?=
 =?us-ascii?Q?q+b9CyvZ13iYfqm8KUzrrnNwRnqbGxI9izImcnqaLl5SMdwsvlyhNIVPJC5L?=
 =?us-ascii?Q?c3XgIrKs88urgC+O32to+7GK+QfZTxEpS3jLOHgktbFrOuQTlWP4CYPjGsEM?=
 =?us-ascii?Q?98PpaPB95MDrsB40yybA7OI07CpZkUABt5yDcvOj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe869f6-777a-4614-93b2-08dad24595f8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 20:09:13.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyou9GYVgusmxzypQ47RNXQxVvTeVkT39aN6RZbeS8wv+/jDnWEB5+kQiuVvFF2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:41:22PM +0000, Robin Murphy wrote:
> On 2022-11-29 17:33, Jason Gunthorpe wrote:
> > On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:
> > 
> > > I'm hardly an advocate for trying to save users from themselves, but I
> > > honestly can't see any justifiable reason for not having sysfs respect
> > > iommu_get_def_domain_type().
> > 
> > We really need to rename this value if it is not actually just an
> > advisory "default" but a functional requirement ..
> 
> It represents a required default domain type. As in, the type for the
> device's default domain. Not the default type for a domain. It's the
> iommu_def_domain_type variable that holds the *default* default domain type
> ;)

I find the name "default domain" incredibly confusing at this point in
time.

I would like to call that the "dma-api domain" - its primary purpose
is to be the domain that the DMA API uses to operate the IOMMU, there
is little "default" about it. This meshes better with our apis talking
about ownership and so forth.

So, if the op was called
  get_dma_api_domain_type()

It is pretty clear that it is the exact type of domain that should be
created to support the DMA API, which is what I think you have been
describing it is supposed to do?

And with Lu's series we have the set_platform_dma() (Lu perhaps you
should call this set_platform_dma_api() to re-enforce it is about the
DMA API, not some nebulous DMA thing)

Which is basically the other way to configure the DMA API for
operation.

And encapsulating more of the logic to setup and manage the DMA API's
domain into dma-iommu.c would also be helpful to understanding.

> Which reminds me I should finish that patch undoing my terrible
> ops->default_domain_ops idea, not least because they are misleadingly
> unrelated to default domains...

:)

> > It is close to being clear, once we get the last touches of dma-iommu
> > stuff out of the drivers it should be quite clear
> 
> Cool, some upheaval of .domain_alloc is next on my hitlist anyway, so that
> might be a good excuse to upheave it a bit more and streamline the type
> stuff along the way.

Yes, I think so. I want to tidy things a bit so adding this "user
space" domain concept is a little nicer

Jason
