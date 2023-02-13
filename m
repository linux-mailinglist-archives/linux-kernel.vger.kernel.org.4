Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A586950EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBMTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBMTnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:43:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BE206A0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8AH/ZHivjk05uDfMdSg7ZZk3KmEFbhGZpKFjqnDuCF3Uwq5Ue4WYpomob1a+Ah5hYv3nf+7/gdO4t1Nli2S/RR+UPZN+RAWkhf4jBXOSebNVXuWTN0yzUPpe5h9QedjGgxBcdoXm/MgSHXldvhQu2sLt42wPjCfq8md1TDYIQi4AZhFZ4ehNcPQ7Q3l809yX7ZQJiIsJ9hRpHuZiq5u5Ev9Yn9b/R0LA0yyJazQyB/WmPuQBZwcwC1poy185UmC6J2ThJ3txJWDAcN+ZgCLs9fcwFJVyK8j4hnzxSREpTwJCnnxJI3OBR/WO3lRmiAQwzll0WFVKl7Ziz0YWRwRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcUze2kxsMUY2ahzc5R+Si858ouNI1BPGf5iyIa9ems=;
 b=Dnmurn85+yEs7/FMwFumhPZrGezPsg3Bip3H98nQtxgeGTWlPDzr0sUOpnUUpSvzcTTcjAGhs6O5OXhvzZ30Waf2b+83f1tIGgKkSsT4J7zrzF6qc3YBgboWPJQHUp0/jlQ/9g2d6HA8djSFXZ8DlUThiBwLJdKCpUr6Rum3DGZSb7SFPE0lxr/rsvA3cIBBhgcTJgyadoitMsgGEMCt9KOvWsxGii8Gd39flQSW4bOIGXGbfhzk6JMWiF6Z5iooQpCOSsflo2KrmtwbSUL90V5+enhi+j2FZQIkKheLbBGHeWdW5/o0ob5RlZCLv0dsbHcLkFJGj+Dm5ghpIwD6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcUze2kxsMUY2ahzc5R+Si858ouNI1BPGf5iyIa9ems=;
 b=cwptbb5UCWHW/OVeaS/HzvLS65l9wJa6NdCQFCW3MOF0t4Oes3SD1ONWzY0S6/TK+CbxRrp1lP1JsTfMoVzzH+t8X9Xc0Aet13C3QZMMbL4zIin6EX8I/9lvZESa8CyOukviqSqCkM+5KS0f+ZnWOaoYr6ieAL6ueECND4xIyymEjDSZzVPqbd2pNkhGEeUfY6vn+dJ6Iqfcj2swOG2HZcJDxBp2t52TlN0julwLAoBNjl6Tht349UudzaDyyZ+o6/FOMA1gch/98Zqzouf6pvPzk/tA3r8Hrrlat3Fj8gyt6uEhFm7IJSbjaPTboOT5H6uqSQMPAc78vvVBVFd9TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:42:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 19:42:08 +0000
Date:   Mon, 13 Feb 2023 15:42:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+qSj+xLkqhF7ZE3@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <Y+pkL5b6mGv40nZy@nvidia.com>
 <20230213111152.5ecf734b@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213111152.5ecf734b@jacob-builder>
X-ClientProxiedBy: MN2PR20CA0063.namprd20.prod.outlook.com
 (2603:10b6:208:235::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebf1eec-8cf5-4840-985c-08db0dfa64a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZL4GgirmEYH8ucfNMUn9l9rKW5rDmlt4DYjnA9ahvuCjJZ5flrD7s7NdUBt/7InLcd2h7ng2A2UNzUp5tY01dvobAaBkx0L5D/27AK+M7+PG9HD+ozLOTHy3vhuKB3xV8Vjo5FL2BU+o5GrdMM1cuBtKhHZ0H0iqwcBJ1Wqc2VPFu27wGs+72PQzVdwgD5afjBwnqLgW6Fi9Kd28NJxDNzlKU3knWL8KmMBftP45rYJRJr2SVjZfI4H7U2N6jHe5HPO+DviP6607dfvBQGPTLBbW70owE0ZlfLN2lqi9bh7fuFrQnUWHHjnDLBKJOFCENVQ8h/I+QHzMehZU8K53Q1ndiLu8o/Du3DBVyrVLsT/4MHJ+n1Jk7X1CPNJ7e8qhTGMXU2XAMGi+RudLPSlwoS5OIhtfZNkRL2hmQ/Ui9J88fVNaQa1Zirv5J06f0itNBG8lBkWXgIWy4n8/vsBUnvLO1/DvihBzG11oLUBg1kwBl+IcePayaScmjrrqF6f6hQ4PvnVQkj2EyvdhT1KQXkGsdJyjbhy8rBhM3GYh2uHplEVFYXh/XSoZHFlXVQrbyYN/4voH99j3vfXJQWrXek6MA27mtvx/W0fs2wEwq4OxeFGAsoPbQwyjHjqd5cSns2qdpO9Yhzoc+CjCrMvsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(54906003)(66946007)(4326008)(8676002)(316002)(6916009)(66556008)(66476007)(41300700001)(6506007)(8936002)(7416002)(5660300002)(2906002)(6486002)(478600001)(2616005)(186003)(6512007)(26005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxiKCjh/ePpkrCFrVrZeiZJRL0V1lbWlddih/qYiErEBO3JE99XaIP24yhwu?=
 =?us-ascii?Q?5QV4ak03KyTTSaZw+2aRETCfNdN5hOiJckU3O7fWPwic6ZXHDn+c4jBlcO0b?=
 =?us-ascii?Q?f1Qyp4V+9fcwOHu6S8oEkxSt2yQjPp7aDXaf1qnroPzCVhto/PqJRXsaEzwL?=
 =?us-ascii?Q?/tHUZuNJ6m2tDLyzwnpnvyqTLwEzjH0LPeNep73k3gJtiFOq3O2xka5DAbBr?=
 =?us-ascii?Q?W6Ej5t1UFbqBHsXMqumWsd8pqTMqPo4RsbMvJj/Hd1L+fDadJSfpp6auLalX?=
 =?us-ascii?Q?xQMSoc5SfIuA5Ltbh16pBKuOGOrzltE0vlF038Kt0FitzkF1vpyK0MX9LHVC?=
 =?us-ascii?Q?POf4jadVoM5RVOc7ynAou0AOIYPeLw6i4JpBUs2WQgCTg4VQ7s8ghAIQAMUn?=
 =?us-ascii?Q?d9/eLPgMRFdf66w4apuC6AomyG5oTGrD+vEIvaxtmNUadeZwd9y6rJ5X8eAM?=
 =?us-ascii?Q?RNL+pQ56O3X+uv/qSt+ZgQHIJERH3tkhkeQutJPu2sRUQLFeSwgXEVb8jWQ6?=
 =?us-ascii?Q?12cDpO3c7zPkfiCbWgWtPMzEVT68XnQUt97S8a3zK9XV2QuMK56PScFVxVKI?=
 =?us-ascii?Q?7Y3TkxGZb8h77N5y8gy34fa3l4RECrGy+Hvq5LM5zCFBlh//m9nWDhejGsKo?=
 =?us-ascii?Q?XFCSdgA6JOr4kWJqjp63q8/8ByVLCf6fXWJl14StgBVDcCExYERkKmQlVRg9?=
 =?us-ascii?Q?T2qPC7x78FkWfsElOvsvGcwuabZ5552s6vMYcuXZuR4aTpKFJgIXOmZEmfGV?=
 =?us-ascii?Q?qh++6HgrVjcw/tYjVNpN/bXgTcqQzVOYuPoNjwJfm9akP+Wn8Y+tX4NbolJZ?=
 =?us-ascii?Q?jKGqJych7gyzLTBROCvJpgpzvISY2fc/ikp+kzv87Gij4wlOk0MfT0gLX9KX?=
 =?us-ascii?Q?FLNsennLsF1MbvGC4Qo9d7hujHV9eccnonDWjgLLy6F2lDM5LvCkwO5jpjpU?=
 =?us-ascii?Q?SjOyrGbVp62fa4lrPbMipZUS0dQIWDbaqIVy76DAZ6xLD4rtRW3Hu3/S8GUb?=
 =?us-ascii?Q?1X16F3DmGW99YGsrN9hNECIVvwBv//FZn0ib+tQ9DjPi5Z6ZVHQotZRWk37N?=
 =?us-ascii?Q?a2TjxEPHVQjcAG8IuKfB1nAETOemCJzoQeHgYWYOkeTyIrvDRCgxsWlBOEk2?=
 =?us-ascii?Q?q5XNwZlB1/7LzfBCyJBRS3ctU/K3SinjxNv35n8WC6wdwE8KKzGrtIaiK/+E?=
 =?us-ascii?Q?K0UBdLFn/8O9vVrV7ab9BG6oIyo4TBbg60DS1+IBKWt7RGlkmjXi58dnNdut?=
 =?us-ascii?Q?y5bnYvZR00pR/UEwhpqMKs/lO5YU2J8IZ8JUfIEp6lGdPwQOjIYpm7Q6nyvq?=
 =?us-ascii?Q?SDoVhik/0f3MvC38I/FHjmyhPq8MFr7rj5bX3YECPXGR/p+slccWPsphzr31?=
 =?us-ascii?Q?9PfCQk3E/bSI+KAXYPUqnmLRvqtOQCTpslHzapqXn5kEo+iTJrh8ejbJ8/88?=
 =?us-ascii?Q?0h5oKcfXdTrGNUFkgSRMidqrSztOC9CLRZg6ZoOWNr4rG9/rKC47RNQYsgjT?=
 =?us-ascii?Q?iB51RNI4EUm/wg2G+0Ig9RnHOZFmkkAV6UjLbufQ3BqRgi36XnB7EJrnnOZf?=
 =?us-ascii?Q?/lvcEdTQrDOjtVyvagaM0R0a4SovLnYe29LiVaZw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf1eec-8cf5-4840-985c-08db0dfa64a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:42:08.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FVa/2TqpYECJ8BwuDjvab4GwoH7Hu/7HbuCeB4ZG10fRGmyCtFQowtu9s9oGhhK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:11:52AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 13 Feb 2023 12:24:15 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > We could also merge ioasid.c into iommu-sva.c at this point, since I
> > > haven't seen any interest for having multiple IOASID sets on Arm, but
> > > I'm not sure what the current plan is for vSVA on x86.  
> > 
> > Once the customer allocator is removed this is bascially a thin
> > wrapper around xarray
> > 
> > So anything that needs multiple pasid spaces should just create it on
> > its own directly with xarray
> > 
> Just wanted to double check that for devices on VT-d platforms that support
> both SVA and DMA API with PASID, we will still need a single global pasid
> space (due to IOTLB tagging). 

Each driver chooses the PASID allocator it wants to use.

If the driver uses SVA then the driver must select the global SVA
allocator. If the driver needs PASID's for other purposes then it must
get them from the SVA allocator too.

> As I replied to Jean as well, we could use the ioasid_set to separate SVA
> and DMA API PASIDs.

That doesn't make sense to me..

Jason
