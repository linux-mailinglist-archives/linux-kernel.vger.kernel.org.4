Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D89696770
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjBNO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjBNO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:56:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FD35A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTt20QNfhX9IfbY0fZ/w845lc0HDxkI4g6ku+lzLQP0PsjZAa2YVhwLUcAfOPDzbSA069sgLrqGKG9/nZ2PvMUfpcoEuevMpnGai9+uAky3yFMDbIXeqbDbB858MfeUxKyb0bhVsDP5bU8O7pcWWJjaAmTFoVDtFFIMB66hlP9m2r4wte5T/m+pbg7A5ccBtALq34VKB0ipmZVCehg/fJ7LZ9TLDyYWYU2AszIjbJ5RPOYvttkrq5amN6b3nuk0sPZFexfnKG6vbSIkA8J3ZSo1vfhZ+uvApFoUVjnu0UsqxI6Tw4FtU19rnW3ISTiswrOON1BWHcMFwVn8gWDJBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmBVDUtfePRWd6MVPV+2wY8fXtcucMXuP2aIkg+5a1I=;
 b=TpSPiS1+yG7aXP7H5li2Oob/u/djVtk0Pe8P7DICWz9x1eGHwhQ+D447t5ksIxAKTc3ZyMR7Cb2cd+70WCRj0TlEK0Lpm+vh1b6bz+prd/N0Pxw2+4TnYvFZNC/1c6BYoS4r1vSE7fLTgO1OixlQPo+4hjS+1ZayabhMaBlIFd0VdeTqxUDoCqDg4IHHPu2/Mczquu2lu2JrzCGdGuGYTdAQEHPW9EQ7Txu9Zxep8KeYqiZPTc6Ow0G/0NLaiHLHxDPM9mMWK8NO6QorPLI9HrOP0HGXW/iTiUECblBpZ0Yl8w573Y2+nxbTXsxpNOiiYyh4zP8VPI7C6Wzrli1GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmBVDUtfePRWd6MVPV+2wY8fXtcucMXuP2aIkg+5a1I=;
 b=bpwDmmm6rwZW2PjzBFrl9JaYafNoFw4wGKbjZmQ0ilXZ5eKzqJB4q8noGyeiOfLlg6eSVIPaQUV/PM5NOY3TVH0u+edMsVwWJKtoXKnCyGq0coj8TfksFpNQic0qhZnQfqK6GYfXOlAPuHDwRx7EFQORooyJbsmTln51o9HfqLHe0882bh+IqSMBvSp297oBHaBUN/KdM+HRIiZ6tFz3Jn0yYg2fvcor37APeFuMgRj+sua6I1NQM85oDODzeySuHeq/ObBLhn3gfhWCN9VCiUtLxKO6uQtRDiJWJ/XXXviYD9e40tQP8/Rv4xKcDecg6Dla2+9YxVlhjQpm1632Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 14:56:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 14:56:04 +0000
Date:   Tue, 14 Feb 2023 10:56:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+uhAvXFq3YKcsuw@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
 <Y+qR5zC8ZOkVphgv@nvidia.com>
 <20230213134402.194ed7fd@jacob-builder>
 <Y+rFW80DUHvf3hQP@nvidia.com>
 <20230213154345.0f76eea1@jacob-builder>
 <Y+rLqg66BBPsfsRK@nvidia.com>
 <BN9PR11MB5276D28B4A4BF8DD3AF1A2828CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D28B4A4BF8DD3AF1A2828CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a47c555-c8b3-4d84-4a78-08db0e9b988c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2lBmBlBoHqIW+8rN7lRw+JZBtxTTe2GAyZdSsp4jDzCnx17RPz9zuhth6dUNu9gYcsQWm4h3rC8JMx0Zgwd1byMqGPmFCsg2il9FhvP0wJGh8pG2S8avPdKwF6aRPJqB4ik+n0EQ5gDFazVwVUo6Ce146BQvklefddGON0GmQiAOVqhEVKNZfHy1EalxGseizVq5Pw2H0AhgQh1V/8Jo2ZqnX86s39bM2n2O6ej7Wr5E0Vgl332lqiO422WFDBMK0PaTn4HezW+O88ywtYx1DauSPdNu0/QYj4MTtZGcS9VZofqL1wjVwVw9ZvkthBAQ/yKk/Zm2DWFPBGME+p1tI2NOeuX5Q7ALyDb3/mTfO59b40w+Qprniu97Ma8FsJHdZk6MEPN99mgMd9oeCnQRYcKduotIpG/vnDOZBTILiQQ63GDAzMwik70eRrI4BfltvNT6HSf3A1BmVTQ5l0hBr9kPhKaH/oUF00kYBKImrOld570HG4DyAokL0FW4KOAunw3xpetxvF74iEU3zNLS0exDtN06PCknUQ1GojnF+8n47BPAXQ62pOWZ0g/5WbvPjLjZlp35rGst1FqBvEQJ0FS679l5okqhngXAoBZHuXXqdB09xkb6aL0tFPzjdLi28wJuAUETRKxpxYIU2h7Xge5nD8SUHSZ4XXkY+kVBukIMOdqRQ3Xxsh6+Tacu4b5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(86362001)(4744005)(2906002)(38100700002)(6506007)(6486002)(6512007)(186003)(26005)(36756003)(316002)(66946007)(54906003)(8676002)(41300700001)(4326008)(478600001)(6916009)(66476007)(2616005)(66556008)(5660300002)(7416002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RCLCCE1GeQ2JoJ8WADmioqNYFJxSWuor+ivu1pRABEJQyDCzxF8AqGnLmlw?=
 =?us-ascii?Q?l1SQFMilH+X49xr2Ki3eVTE5EY0YOExqNxsK0GC7P4DyHnhokj1mAvoIBzdT?=
 =?us-ascii?Q?87y/MNd9H14Gp5lvqaxeTdtV3YY3LR2o+cbbTe5/GaPMu/qkMPtdTnGMPdvn?=
 =?us-ascii?Q?bPvtNSb1jQj5vzeadsfvhf/TxdkJNfHwbb8eVUwKG0E5/h6zi2v218GrsOJI?=
 =?us-ascii?Q?rkrKUOTFvgxI7sqzxrb/wU/MPUALEVxkynh/vvfDhwf1Gaq8JGSv2H2GfPky?=
 =?us-ascii?Q?TZxQA5cfold0oQIADtoX7QPl1v8h8GIiVcInsv6FxC8+nYwuTMp7LZlYqvEr?=
 =?us-ascii?Q?7ITmTUsTkbyLYhETsnUm4HUEKLbp+mTLQAYfsUXUbJ7BZZqsMpiCDZgUaiIb?=
 =?us-ascii?Q?73oqyS+LDd+6J+edBfZhl5DhWkiUZ6JOJ1LdSsWIcichgUrSMHE55CDz49In?=
 =?us-ascii?Q?UrmV6cJyY3iksnjfGfICNQrrczIVS4JaUBQvAyOae669CEXOW3OistcoRVTo?=
 =?us-ascii?Q?NiyeRGdXoA/JBZk9eN7rfuIm2wMwDTa7gV52ODdskQQCYFcadi1P4GnKgUcc?=
 =?us-ascii?Q?QDFvoPxqUmE1CMKvRV0lKJj04JotCc+0xzhLFNlpr+6YaQvCsNpNL7TgN1W5?=
 =?us-ascii?Q?LfO9LI4ZwXjkaYOGIeXw5j1K5VHMcbX/DVTedaKmtK2VGiaepR24bPfvI+9K?=
 =?us-ascii?Q?bqBniUDKsk/oGkFxRh6icIh0qOH8uVwLCvizleT5M/ceT41rnJY4ZsH/3EX7?=
 =?us-ascii?Q?zKAUulUUH2ufl4dXxSryQR8EqRCHyIEIku3Z5MerJOLU0a4DhnarjQIm24ww?=
 =?us-ascii?Q?zYr7zHUvXnllU7R1pxutDBHUgJ8EboxEOLp5gzmFWPcyK/QS6emqZiflqFeL?=
 =?us-ascii?Q?HJwo5cZH/nTudpGg8eO6BFTNJWhkvRlxK9c0S3ZcbIZflCvmPrIfD72J+dMr?=
 =?us-ascii?Q?bTRXVx+8eLHlPHl5I4wZWSk6oHlbzR3lVs7R78MX0dUPENWm4mvp81G3Ils9?=
 =?us-ascii?Q?RpcTu8tESDDFoFqbIR2R5OH5pTUBgyGIlO5fFQEXRtgPXEBtUGbfr2urgPyl?=
 =?us-ascii?Q?tnPtCFKOvh2m06TcBfOKbOWULWlOB7x2kRgGXEX8ZtYulh1oElJc4IK+H5In?=
 =?us-ascii?Q?yyQMM8nGHHjPtW8y+Yx177EQ5RTHfZDuSiSt7e42Q6f3c4whVJgjgudVa591?=
 =?us-ascii?Q?A49qalb7lV0+guI8rbsB3xHQ5MVSDdZ5COpYm33OZGFbie1N/rInHRvpoIH0?=
 =?us-ascii?Q?20F7Y4ysbHFnJ9ObOK6oxcgOSECEkZzF19j3rAAz101+BJRYkE9UQQ+TXRdT?=
 =?us-ascii?Q?QVJdETStYX6FE4mQAvJHxuDaMUxAgyNSWEf6lqh9+soey1n0KURbqa6vDZnT?=
 =?us-ascii?Q?wxmHdaNc6L5inaBuaTU8UFq4+1phVhKjdvIhvStzqH03oKDjmmi83IxiJB6F?=
 =?us-ascii?Q?aLeXu63dN1Z97NR3bgI4XxS266Cw8U9J0VneG08mM4feC3p5iLzJK42dAKA4?=
 =?us-ascii?Q?VEj5hYHp8ga+J4/EzLR+CoA59MhJ7ieurEJFAfzOWhlUBrVPkYahayJsn+WW?=
 =?us-ascii?Q?h6UXIqER7bQ2Idzt0EU924xmSHZbPbsMezTuGhcl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a47c555-c8b3-4d84-4a78-08db0e9b988c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 14:56:04.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b030RpdJ/NZYohCjdB1I4PX1CFPVUk4Lla2ykMo1jUkC81pULpjO8At5PKt2qiLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:26:25AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 14, 2023 7:46 AM
> > 
> > > > So if a cgroup comes it is just a matter of putting charges in the
> > > > right place which is auditable by looking at calls to attach pasid
> > > > functions.
> > > shouldn't we charge cg during allocation? Or it might be too early for
> > > iommufd so we have to wait  until attach?
> > 
> > We need to sort this all out. I would expect that iommufd will have an
> > allocation API.
> > 
> 
> yes. 
> 
> btw presumably iommu_global_pasid_ida should be move to iommu.c
> since it will be used beyond sva.

Yeah, maybe, I'd think about moving it when we get patches to use it
more than SVA.

Jason
