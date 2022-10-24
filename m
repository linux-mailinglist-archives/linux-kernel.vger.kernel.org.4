Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39160B5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiJXSn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiJXSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926926AFF;
        Mon, 24 Oct 2022 10:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE2eKC9/0ZMOQkhY2dTQ3Nv6uphZiecuIrWiFiJXMzlXuzaiIYYppmV4TnJQqaAuZ+wgfqETkwLtbvQaXFW/CoFHUFa3cLYf/3mk8g7s9YFvh1A/7N5pCapOaEt58WJY7oiu6w96yPqUProLIaKkoSR3Q3b7mGawzUYH1gJ3UfCzc1FyoCDjU6Uu9krG4EjYmMV4d50YFsvSk5Rvh6C8+XeLA7Fc0FqLsg3zNvv537X97EvwYAZL4s1UvFhlxu5UiZkQbj+B0z8vxLGmpZUqndf5kz406Wd7FSf1GTGCyPq/2OH55uHEXKePKf0zfawJIiiqhtqof1JDji/rHanswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1LA5Ww0XoL4QFb5VmE+dXPqbtG1fVpXKTpVLS9AHFo=;
 b=IcJfhs5Vlj90NYXtkkQK+xKIBesOXM8Z+eI733T+rz6F59UznPyW/YFuDnbni75JCKEJlqut9Gghm0tr0cyF0SvWqI+EnF9Er6YaBYADHMI6WdsVynsuv3Mqk/hf4cyxRlAPsNkhrpgJf3iidj9un4HeSDJTQ52OY+NaWIcOjSAS+x9CJ+7A5gXKSgP/rSEJMk4Of/Y2Sa8lqg3Ef7ggQy6L2MwywiMjNBePDJbYi/S0zm7fikxr3ahYuLn2ZDd+QtyeBkthmIbmIOIlbJsS+Wb/OnD9LoeVdEo5AuU3wQIhP+UhMl6idp7c4nhOWwsmNmuE7WB+zwH+dqcWs21csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1LA5Ww0XoL4QFb5VmE+dXPqbtG1fVpXKTpVLS9AHFo=;
 b=WPFZ8YdGlQdlhRNCzNK9eWcVT9uCgeKUljhhfdQu3MfFpDwbF8L9mb9xWydWpeZBy7NF0YW+X0TFIxlZfsg5N9+EWrBK3PhS3gb95bv5oqiKkAwjKAk4t9rz56StzYEqdaLa2JV/vrb/Yz9NjbFxewdRndDXxHmEGLN1KZ1uv8AGzC0cGx4zff053AI7x3Ac9S7DbvZIrYLKlqA22FLw69U4A36fJs3SKTXdLpnhE4z4vEL1jjO0erBJtiTFT/JsxYBO/PO71VVRmO6MNeriRhMar5pPDVOysUS00wN9ayf7M4FRGyiUTQVVyPLgcYenlYDn4IM5NbaUoZaZlnt2Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 16:52:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:52:52 +0000
Date:   Mon, 24 Oct 2022 13:52:50 -0300
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
Subject: Re: [PATCH v7 2/6] iommu/s390: Get rid of s390_domain_device
Message-ID: <Y1bC4tzKOIHhrYE8@nvidia.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
 <20221017124558.1386337-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017124558.1386337-3-schnelle@linux.ibm.com>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d67c85-a002-4274-b949-08dab5e03063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyCNU2Frtr1IoHQykSEeZ8K60iU6gFOC4PyEivwsxAq+4jRvnmnitrDFKKrPhvQaL22OCHdPTWW88SHHQ9GToMUBBs7/q5Vm/7CWEofqqdGc+NISr9MMoGB+WQlhjcTUi4rTTbggMCe8MXz5JqY9ZfBNsmh8GsvCCz9SydXyxJl6arOebKCHg6lBRYABtXyIAJsWrbpa5wmxn0bFfyKXsUulzBA7tYi+8D9iD0rZtRYwudgtyu7OktvL9QRX0NGYzVSHlAE05LxSoRvWrHOepocNr9x12XUtidZZ1Q9oyARXk0mPb0a8/29MQMGoW9YuW34Bh86uV6jxRqPS6DNMjJEbiM+AF/fiB6oeSUqXfMQLepJ9S3ilIXgiGyHHruj+E/FXFFcF++rMLt6y65Naen+E8UrO7k+fBIB18rNuOXIxtMJ5Kcwb/eQy/QtbAaPvsVg3Dw019bnAls5mWsFaqpdA+4y8USBLsS/lxiVLgb2uEezQMXvYT6XxRIkFNRay5vUnCIoI4O6rCG6qUa8PYr4JM3CnlyCmfUyWwTywdQWCdzF8ps7xKPhFqU0hUCnzY5NL0vpvnTdbKS1sYYlyXEiM9SURk6x7VjQMaevi3BSOzjeuibogqJA6OU//lO4CecHXTAVJYWwv9+K1lFbjmEfEV1EyVEQv6K9/GKKBLTYaZSOHhVZof5Zj5BCGHMIg3sNWJ28EMw3kHQ5uN0YChP0wDz4tqofYasFfWlGGMq3n+8pGbn3tnAseazddgmYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(36756003)(4744005)(5660300002)(66476007)(66556008)(66946007)(7416002)(38100700002)(8936002)(83380400001)(86362001)(6916009)(54906003)(2616005)(26005)(186003)(6512007)(6486002)(316002)(478600001)(2906002)(8676002)(41300700001)(4326008)(6506007)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xIXMKbYRDHyjBLiLcOm+BsU/BnN6rO44/r8c30xAp1rKbHiYLZQG9Pr07OZ?=
 =?us-ascii?Q?J5EfTOV9DtRRUkIEzj8t75Bn37IYWdebfIeZjdyeMADwUr37/AWEQBTGvDED?=
 =?us-ascii?Q?/0VrVOhD/6OKvhBq74J3K/BrnZihWJzwPNuAj2zW9WQpXSOazn92F5odoq2e?=
 =?us-ascii?Q?cOvfue3Pc/q88+M3SinoimF3aOLBUTpGNy/ndikUXzz6NvYO4+Z0qmuo+tBq?=
 =?us-ascii?Q?0dONKqYXLuROVQslxaDbvyPuRW7H3V6mSi4R8CFrfILzj6R/62wpQwTquWwz?=
 =?us-ascii?Q?xMfJBNEf+q2rmpUIqbtMeKhADligDBR8Eu5a38s/CnLcXXLtTsKV2cGjqWHF?=
 =?us-ascii?Q?YdKes02PWceVZ5Yj7FjQCxjdq2TGnbXhqTJd77HJzlpd/KTBGRVA/Io3q7Bi?=
 =?us-ascii?Q?dXKlU29FZrEyMYGaGU+6kLOGbQtJjQUVJK61D0a9mi8irg91rXBPVKB7N5Vs?=
 =?us-ascii?Q?/h/FFgDjySPPdGkIAWiuXIVKqzljoujo3yH/fKtgXk5q3oTRyH2Gyrc0+Tx3?=
 =?us-ascii?Q?jERxGwRTqpyCxGFR2tzSi7d/dV3q4ktfGd4fxrbDH2ZBU3ULOzLgE3RHo2F1?=
 =?us-ascii?Q?NyVrWXuWQa4xCengw6B5IxY52r6mF4cdHtd7AgJl4yjx5v5w1F8LTDtVuPsb?=
 =?us-ascii?Q?cauhhaIpCFT++pCAhst+AaNzTWCM0Ra603sPpG0ntiqFXuEuC4Zg3umwNLZG?=
 =?us-ascii?Q?j1Pv1dhv1Oasg5PRfmxGuqncJ8DXJdu1jby6/+MKLrIHRR/o/k5YORCjBd2+?=
 =?us-ascii?Q?amAmWx/RkJZa9y/+y8pBvfazZXvXzvIRMScxHWzlNGnKVTCIUw3oJAzKvrLm?=
 =?us-ascii?Q?s7KxS6ccFcB2Nx0ioGvBdCKA9qmvC9L8vRSEeLyeHNJh6BME/u3SgAhS4XOR?=
 =?us-ascii?Q?3DZsHgF8z59RJRhi6+FugOXtqMQYjjWbg7RwYoDk/Qyezocp53cheWbpuyY/?=
 =?us-ascii?Q?Ozcd7VXk1KbjgwqfaJite0FaEW+Exg1bJVh3C0H1xbMTLGk8DtAhL+RZ5Aqj?=
 =?us-ascii?Q?uMxecSdkdLq55od0y+UDVYaD0SjnuY52/3dnHJ8GWMmOgeYskD6iqZRlyO4g?=
 =?us-ascii?Q?9MfyVHhySDKNtywxdwdcUMDU0NRJCgImtQGov9d78waTy/zVeFo/BhB1P3Nw?=
 =?us-ascii?Q?7QGRSAqlBBHiKIF03j7dkDqdvtNE4B4bCcmrkYnpifO2zSpfB3aZGGK2ABfh?=
 =?us-ascii?Q?x3rhsNRkQODs7Bowapb/C6n7DbAuj8yDW2eeMBCrjjjld7Fi/0MT7P1XRoOK?=
 =?us-ascii?Q?nozMqsNpD2YnxLtpGRiXwB6W9z0U4Hnf5i51e1NzAbEMK2rGHeLL3OiMAx+g?=
 =?us-ascii?Q?lT00nCE8Kx1FfnjQao/XT4UyEqp5TKqAPY+yUz/Dr8Z6isXi+h/rsPY1/DOW?=
 =?us-ascii?Q?5N2S5cb3AzUZJOw9J1qmdtx7DuR1e2yMeRfIL0yjKQlOXp5zJJ539yw+2hFo?=
 =?us-ascii?Q?hpavXqKC1qk4mTcWO8+lMZL+iDTRP+QdhoNN9mwzrM8/SWQnWO/4+Ltp+heh?=
 =?us-ascii?Q?XkayRv/WARZ8BZ3phRnlvlvAK22pRrnsiHYumRwicHjWXC0qU8NgKoD8Bc1j?=
 =?us-ascii?Q?EGxywOceVlUnhXtRyTw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d67c85-a002-4274-b949-08dab5e03063
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:52:52.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvzna8tKH96P5wJkx4ZSPTx4ZyGNXwrNRQBX9CwF9dasAbQOKeoHGfJgqOBs/l25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:45:54PM +0200, Niklas Schnelle wrote:
> The struct s390_domain_device serves the sole purpose as list entry for
> the devices list of a struct s390_domain. As it contains no additional
> information besides a list_head and a pointer to the struct zpci_dev we
> can simplify things and just thread the device list through struct
> zpci_dev directly. This removes the need to allocate during domain
> attach and gets rid of one level of indirection during mapping
> operations.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v5->v6:
> - On attach failure make sure the IOAT is not registered
>   and zdev->dma_table == NULL
> - Dropped Jason's R-b

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
