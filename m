Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9342963AA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiK1Nxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiK1Nxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:53:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E2DCF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:53:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4V2RPRoYJ1facZoEp9mq2/l94B0VC4OXoLF3LXdk8Q3QzvOFx1XBLS4IAA/WO0th4OG9jejo9YWwf/aE0kWIhc0J79Z6/A2iYOu1HO3vxmEgi0qzZfmD3TtonMosyM+3hsgGvLbenHaMf2ydXAUrXUEHDo2mvF/04nvz22IPBkahcD5Dr7LgCt5h+nkO+Nhc7KPM8qM+4S6WDp26A69SI3LdZDpLiXi9XENoNBwQ8TyJcsuzejEmSbmLbcNwMo39R8kz0bh6Mrnus63UlWWWLLm9DKVyZKbSuo2LvcwAOkkY8hl4GwGqKABWQmkgca1Di8U2Ifrlh2PYqhla2Pf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OeAmBcCH25WxUAyl98KujYhPSJ689ccy8Kkw3kxMjI=;
 b=cgRtOf0IzY3Ld5l7LI42PimhOTM2vUZnEHRWlBTvMLxXt+WmJplIVEwFuG/JlKHiK/RVI+XaWt/+vohBJAhMn05rj/uqVQBdwRUyL6+l4l3Zqoe1U0akhisurcPgKaeMWOsjlEcWKUrNcL7kFrm++DYjMNxMRsfgKgm5W6mNFK9KEfN5zORtral4l3XzCEQuPMFs3udCPb5SZpz6DZcyYW+YZGTlZw6tg6mbUccFXRW4VwQWR2GaMJ+i/WQKmCcb2H2etr3S/9VWuj4R47YmkQecl8Z5oMWdwZuPmZbdug/KXyzevepXZ/H5hfBykAYCia9XVzfkjHOy9hn9kjEJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OeAmBcCH25WxUAyl98KujYhPSJ689ccy8Kkw3kxMjI=;
 b=nxg2ZoW6FUQ6r3oO6C/uxA8R54VHXohWwpmsWSLlccWK6WFywhrdoPFvyF4S7n5y8S48IsJnC+FW+GdGIyHcnuy6TJwAlHYn1nYk9qBqSGtzoS7bKoncuS6CjM8VWW6TPbnIs75aBSYdsXd5h7069WnlLd/K3WjQ0y4EUTsN9hfVJg7m8tXWIGbGeZGa/c874OLpIv3jdNz8/9b+nK7N4aZ2/EPV/kWbMJNo2iHMhrUrUXaGoi6vpO/G3FzO8e8n2wRoWG0lQ/YIKyD/4+E1OmbRxPjW6u1Cfb+yVka/ycTU0/Y/QyVcJoQbjAXZqshYUgW3WbQem/GRiDXu7kG2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:53:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:53:27 +0000
Date:   Mon, 28 Nov 2022 09:53:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/20] iommu/rockchip: Remove detach_dev callback
Message-ID: <Y4S9VpxsRa95b3xf@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: d7764e7a-715d-4f8f-93ba-08dad147ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjNCnoIgsB8510uKCrIsLkCd8aINMne8OkayrrFobnDXAKaIISdPnOh4TEkVCKMptv9ayqFn4Gr964oDnOMEeB+d7NR/mabaLIiUNryR3RP0cb8sZ9tXwD6D72j4+Huej5324weiXPI8bn6kosFMWznWya8lDV0pMdk43pOstURFxxNQS9+g30/BHQI9hZF1EtIPXk+ATTEzdiRZPTr7Q124dEaQH+Ia+y1fIC2Upl5ttm6pUgLzYKzGFd++2BTYqHe67q51vm/5kjDwIfsTDF4PqdUBQ1BC2ZGVnu1qKqLfEMsAq0cK29jbPjaTtEEMIY4LhRxMuons4NURbt1Te5A+gWud+mes3D3L7q6y8QlMvdw+8xxBRMDEC5m3jDourdEBOVWedJCoxq72SPhUOdlEjnolHSc37WWOQAH9l03HYX6SoSmy/WPl3zwKNkHjIddkysT8VcQrX1YIBu4mrx1meucfJwfWw8E8sHmG7PLd27fCdTkQSspudCS2dwR90iLoR780qKwYrdLNC1640cfajcIXZuhakiyfz0R5/KEAz4+BYIMdyvCvSLFoB2AHp8FZ9E9A1Zhib4XP4Pk3255yCDpIg7B6n2H6CvObdk7HhQHOqYnoM6IqDPRwhr4M41GbuTngDhWTOe7ovAO/XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(83380400001)(86362001)(6916009)(54906003)(6506007)(6486002)(6512007)(36756003)(38100700002)(26005)(186003)(2616005)(7416002)(4744005)(8936002)(5660300002)(478600001)(8676002)(66946007)(66476007)(4326008)(41300700001)(316002)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDDJT1F3q5SFooKRbjXzvTN5JpE7WeMTcNRZ6QnuhAMR8C9GG6uQ2j7k27c/?=
 =?us-ascii?Q?o3jLjLLQdAYX8+uPxW6JuhzFhGyukbpIijwnX9+kkp+SPmbOrK9i8pqGGnD5?=
 =?us-ascii?Q?gwdxlYCNiJ6WJogPuhNGK+PLblyXJVSJepPzAk7TUbY3TlNCFzgb9y+PBzJ9?=
 =?us-ascii?Q?UzlA9aqGe929gGSMMqYzMNPuLBCQkwvAxWcSogclhXlaz33MWxx0w2e+3nR5?=
 =?us-ascii?Q?GBdhHwhHp8pSmOPEHWXpI56IxxOwQ04Wf94gqKZuePJ9kMj8K33Uf1zsyknG?=
 =?us-ascii?Q?m9IKHBDZt9LbEMLEbwtbKoYOFzLh30v6a0zZTox90lf6NdMCLWZRSNM+1Wpv?=
 =?us-ascii?Q?8vFgblIoUMbVQfg0BMIko+adGdEdTd0r3/W4YKN1djBfV9FNdS0ov5TE/4VM?=
 =?us-ascii?Q?ns6ZJ2K6wWawGAn2T5DbD5rMNlMJrYiEuBFAgHDZKyEVYw40KLdL4Fe8Qq/N?=
 =?us-ascii?Q?+E8/sQVkr1xwnX7/BKBelFSn+qB0kBPI6BhFacq9FNWNsoAc8ljAQZpLLjKw?=
 =?us-ascii?Q?dgjkX03m/rnm5EJNwKHNOHwCUFu+9j9M9BXBlUhyfPQWcYP1VwyN9HyK2eTV?=
 =?us-ascii?Q?c9Rjqje3/yxaBvkEP4gYGy3heybanWP/sQt1NG78TZ2OiiGjI+Vlr1QRsEQT?=
 =?us-ascii?Q?80/htXQlFUzEvKOTy/HEhDuIesrbwyfXRQ+VQxEXZpUf+G+Z4vHWdwUzitOL?=
 =?us-ascii?Q?EPHgE3l4khAgR+kHremfYeofhTmZ7xQ6SuoVdllU7PNKkAbWPC1odnIlA5HC?=
 =?us-ascii?Q?bZQoLncGtQNlygKOI7+3kGKATdISQu/TM1JuOOcRw/KjBgFyB3MAvL5bAbDA?=
 =?us-ascii?Q?bai0Izu6KI6n7xEx/IOa3EHWx+8ozj85ax3T7rQLL9XJaNNp1h/o15d/Fwol?=
 =?us-ascii?Q?CWxU7evbevbkuKm4GI054358LL8c6esv2Xc9b5rCyl87DbDuba/uGMM/nRSa?=
 =?us-ascii?Q?buvedb6CI6A0Qsi5gc7cDGLY0rWDzxLDfZYG1hnKOgIR6vkTugmyh9jP++4/?=
 =?us-ascii?Q?7VE6Fsys4ElI+JBfjpcnIqBVeFRbDJ9iGsT+uz43WEcDSpcWr9EoLChv43Ex?=
 =?us-ascii?Q?6KWetqcDB34YGtVclJqe937cNGK8Erd8XkrIo5bX/qIW7dW00lCiD0nwRfU5?=
 =?us-ascii?Q?Wd00mJR3jEFVGQ8VgsvVlNKdDJelpfwnQ4JO2yy4xJYCRD5KyYIf/Ray6DzH?=
 =?us-ascii?Q?UuSWkrRmgcz1IDUViOBRkC0YDAPx7hdWi+EYBzJB+1+z6DxvzyG/ZcfixqYy?=
 =?us-ascii?Q?AAYqZjZzIER2ThbC+4N5wJNgNikQToNK/voqTI+6TbSjyRAP8EF96dQB5fZ8?=
 =?us-ascii?Q?7Dfu+dqkD8H/FTbUdrr0+GxY3cssSB9469E4FsdE/ni2WvkUZUA9e6DOX3dx?=
 =?us-ascii?Q?d6bb269wYbsgx+pWErNo62ulPc5ReCUy0HHF01ISAiuDN8ruXAtK7PXH9dR7?=
 =?us-ascii?Q?RIq8iK7/5qxZx6UDj6R7k3122UBuX9zBJz8DZ+rbWj932uCVf2yU5Kh6XGGo?=
 =?us-ascii?Q?3BO84wGfi5QEAD4+Zann9emZ3RAKKNnt4puTGGtKLSeVUc7uHeeQRX1gfb6G?=
 =?us-ascii?Q?EgTOKMZKDqszPzFbP2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7764e7a-715d-4f8f-93ba-08dad147ed1a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:53:27.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th+ztNX6NQ/2sdzQzIdqvmqRNY2o3+x+5iMt1vXCToRMyS9hHGiSkFAFXMnAxiin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:35PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
