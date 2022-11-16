Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA562C6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiKPRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiKPRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:54:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF65F869;
        Wed, 16 Nov 2022 09:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVQmz1Nu5gb+LEIEAjoQbLSH8fWTwlVubLppcKs0vJ64LakdxlmE39nPsgSPg8ZhH/eJ3NysIkAaGI5jfil0YPLzF+rtlSWTroR73boraBiPmfeILhKCP6MEWeZWnBR8WsRn0JeAvX0zItZIfEkC0sQeLmyHDXyRPVesqb0rm7HSfPn94Vyp8lpGOnCsi6iX6YOfoRUHaIRS0kjjtHaYTi615oHZvNvPVr6qqjbBgd1BwlCyYxPpzMqnqAkMCLqR8t1DWJwqRSHtxmvuFJRnHgmACQ4D2xvKtAJ4G8BTi4Nu29tGYNTK+KLig4oayHIr3IW1ihh/In8hZynBRC5IkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plQfQgVgNaNfJpf4Z7JWjf8ZtWcyYGX28UVnSpdLGZE=;
 b=mzVqx3VgUoEqN7wIRzcaTCzngjmcU/9ppplma5dREOl9HaoMikZfozs7dU5j7VYiv9oWEfJFVPVGVLMnzM1dNnvgrDB31ANOYYcDx0kbnW+ThYOCZLrEblcu0QNcQpTv6UCBzm72s3iXVk8uj+GuzHvj5JqNcswd9CAhliKr5TPfAkixBopWUlEvErDNazHu79mPgx5oH1M16RjC/WczWJX+0ALcieDo6tlMacsLpM4CqOi4NAtHlgZ4JglnDTYQN4Zl/OpkLRSY/xuUS8K1y/dBMlWjPkWfcABLiyMuqqC7B2MG8SoZcJ9+XrgVmurTbcKuMgjO4dTeTr68af5ctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plQfQgVgNaNfJpf4Z7JWjf8ZtWcyYGX28UVnSpdLGZE=;
 b=gwWBygC91Xt7NGZsIJowJZnfrumBud3uaj1Bx+XRxZGpc7yBfToyaXRf0/NdSLw0o9BGeNFpSU7SnKIqsINlHBYjjEUaX0glIPbhXQsHxH7PPQy3bAiAEnVniform4Gncxm48px9gqcc/v2Xj8k6FoTY8uof0DTlWnBuxdZWzgZznfCDY6e2S7cEnyhnNa4IWDtwrYJAfBmWq0pUaUs8DrmwdT4CyM8SXAKjdKhwf8IptVm1UlhHB0g5Jx6R4rOowLL0FPqYmBLhqyEDsVpe6Z8bJ+k65CsAQoYdOdyBCABJkeF3TRipwX6ItCx4LK3m6fVgHUHZuT1c58bRfm+Wog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 17:54:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:54:41 +0000
Date:   Wed, 16 Nov 2022 13:54:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 16/39] genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN
Message-ID: <Y3Uj4F/9mujaaT9a@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.524842979@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.524842979@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e398ab2-2e3c-43f1-2144-08dac7fba30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUqnmOyj3oLP4pBzZLgfDlkNBg217hSLp27bS0IXkUUS15ACrDCLeZquvBPtYzB/a/qtqUIOKqt2aXktfPviyZ1TnTfB6VC+187eAtd2OsFvIl+RVMIwZ4K6XokDLXVViyANtnVUacR3mTjpz0ticnbDeVyjp0jd/r7gK8bKt4574kePmCGNZIZ3I4eGaXQdsLtq6gj8UFPfoJAkMc1psSWFd4vu/eWWKRa8hKSQGZ4oW92tMpT/4WH/YEAzBRr8rOVy1jw1551gVzW8PRXrE+O+apsZIoATRMET9mQ4Kk6gtDrlE/cdc4w7Z6RdyrUjr5BGIt2CDmkF47l2XWPINE10PUCzvXjbyJGGgV140m82mbPge6T0tJWCTuyKOmKJGIH8r7Ay2VmT0nqhaJZ/4jz7HFf9+6ZE2W5GN5mChzqrmVZzHl62PRRZcDLqJpObKHXUw5wz0SK98qq6SNWIa2gWV6/rqm/IbfQZD74LmUCjW5Hi60ORbM9wY/hUYfLGaiyXyh/QwrOdkbLNHcjlBgIFm4rWsNO+im7tlNRGWmDXfY0ci0En2LjkYq/D+HgWHCGPustOv6akL1HjuvE3az0AAyqCMeKPuSGW1Pt3QPAHN1prYbRU4jo1GdYV7laXaIM7EiIbwEeVJKOe75ZpV0nHrpPolQhhufoPORJv5T/zq/oPYdsk7GjN2eyghwxUMl9db5ByNI8Uei/YjyI2UPmAyXryi8cpm3cPZiIYO9pkjprpxUJseQ9n6Ppuxu8P5BS6oMZNAt0b7YFZQIFDxIt/sZS7PdOL1UqXQjsZ20U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(38100700002)(86362001)(6486002)(5660300002)(478600001)(41300700001)(6506007)(8936002)(7416002)(4326008)(66476007)(316002)(66556008)(8676002)(66946007)(4744005)(6916009)(54906003)(186003)(2616005)(83380400001)(2906002)(6512007)(36756003)(26005)(26583001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xK7QDF++Bwj9TFmdY0sE7C+xGASAaWG4hwRzc7sg/bE0k0i3BbsxzVf2E2Ii?=
 =?us-ascii?Q?1CU1PvntGW+ViL+g+dLmFvrGQ8ntu8m21d1XLrEieGM+OlZ/11DUYqE1kvMP?=
 =?us-ascii?Q?gsX1rlSX2m6z9NzUC2GNO0tt7CMyGGzoGjo6bmfaLiTh7/gm/u2MwtL6fgHT?=
 =?us-ascii?Q?oDAllZkpgeagaEpb56ovSmrgz0nYYAuz/MXSlIky9/n0R3lTsw/bQwKlrkMe?=
 =?us-ascii?Q?XNNLEXlQ7Dx+Yfz90lZQZA5WYzI2WryRI0UZPXIVeeUGun7puwWnPbty2d5f?=
 =?us-ascii?Q?WcZKDPlNIsrDPaw29qaGZLuPNubuqqQBec6/0jW8s5muZQ4ZsJQc1dmXVrgs?=
 =?us-ascii?Q?QqfiiMRmWxpgWdzJa+fmyY0I4OZ801vZ/wDrLVO8CGWESP3d/krqZkeqiLpB?=
 =?us-ascii?Q?f3H2ugu7g18SlzA/iFuI+GncKWw2QpPpQA3DONReZVLlHiVcdjjBWEeSk5Xb?=
 =?us-ascii?Q?pfflRZXkJn2S1AgExg3SpX3ROO1IinpRr9Td9QHLeL6IBXokDb8spZXEjLvT?=
 =?us-ascii?Q?tjErF6GQX8EGmBElgav8m1/tUj8fVpN0xfM3GjsFrBf+R2nRYIApUkfUFbsF?=
 =?us-ascii?Q?Y986vxf1Yav/Vy9tX6xJPO/5Gimj8jZ2BZqv3eZcYzQO4fV1vWMUUtJtvm9d?=
 =?us-ascii?Q?MC30fmf4bFiapzcsgec2Pe0w4Qp/9FGoaMYfNnP6fTngpGTVc192AGiVzdX1?=
 =?us-ascii?Q?JDPapASxLrtcp09hCZeS8yi+pc2PSQuIz2U1j+kWgBw1i7qxFFIspm/sT85h?=
 =?us-ascii?Q?IjOboGIQO4uY0NkClJPsspsDB7xpEHPRxZPrv30lhaaL8j3Up33QbkkXvtot?=
 =?us-ascii?Q?Czxl98SdDBZfA4ZA4oOyTcaSeIOWIYDuM/5XQe5kC33WQDX+OQRCfTmiFM+t?=
 =?us-ascii?Q?eSRcxf2TOwE3pnP64zAUhF/QNnjAtnZ4X9VS9Ex/x2Ma/e3M3ui9VqrawSMw?=
 =?us-ascii?Q?wMghkFYu+HBmbchGAokZB/7NcM2TYuMwJ+llUgcuUpb99RMdaQAsPCUx6AhM?=
 =?us-ascii?Q?xsojo38JeeA7KzSZ8UcPCAGbiC+c1F/GwG3HM6cfiSqHxVLryAIfHv86OWgd?=
 =?us-ascii?Q?M0iLRAwZFq25KituMCQ2h6yTnQ8Tz/QHV8F0ZKV8X61CclzHZT4j+GimOX9t?=
 =?us-ascii?Q?4mtqZ8QcxqpUoSwnElNI3WDM0vKCrKKEZkX+UVj5gZ3dLQqUkNutdYjawAiu?=
 =?us-ascii?Q?GRc4Sx97fbdzldnxAswts1c7U0CThpofs8qtYB9thXKYV6vcqcNyoHfcPQIS?=
 =?us-ascii?Q?Dmau/5sHeK/iWlESdQQJSoqv2sAjQeW3TaZ3wPU5j/36mLccDX0Ia1yE5A/O?=
 =?us-ascii?Q?lvS5kyXxFDyROq0D7Dz+lOi8SDG0JW+1ZmWxI09k9w/jxvGOObGPbmpXPK1/?=
 =?us-ascii?Q?ipbpnfcmiZFtUC7pHLe1cM73yajB07YwoaaeuY8dQtz2P4rFID2CCdpRxNpy?=
 =?us-ascii?Q?DJ6j2Kq+zxHC/3GPnRhkYYY0hM/kxrZyHNynU7qjSN/W8zRvNm4BXVKm5/yt?=
 =?us-ascii?Q?YiuxTyEkQVJhAysbU/gNtLMiKZHPRcIvOlfBIYb5QUAmtpQYhw0qL4kLV6vY?=
 =?us-ascii?Q?S5+8/34cuDtBE7ajYQibzsldXHgAv7bUhO+oLs/z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e398ab2-2e3c-43f1-2144-08dac7fba30c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:54:41.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Amgi2p+zMeHjvuAqZ390HzJR/A70z9ZGILbxs1lD3To95E+BxR6nN+JfcLQKKsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:40PM +0100, Thomas Gleixner wrote:
> Adjust to reality and remove another layer of pointless Kconfig
> indirection. CONFIG_GENERIC_MSI_IRQ is good enough to serve
> all purposes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/base/Makefile       |    2 +-
>  drivers/bus/fsl-mc/Kconfig  |    2 +-
>  drivers/dma/Kconfig         |    2 +-
>  drivers/dma/qcom/hidma.c    |    8 ++++----
>  drivers/iommu/Kconfig       |    2 +-
>  drivers/irqchip/Kconfig     |    6 +++---
>  drivers/mailbox/Kconfig     |    2 +-
>  drivers/pci/Kconfig         |    1 -
>  drivers/perf/Kconfig        |    2 +-
>  drivers/soc/ti/Kconfig      |    2 +-
>  include/asm-generic/msi.h   |    4 ++--
>  include/linux/device.h      |    8 +++-----
>  include/linux/gpio/driver.h |    2 +-
>  include/linux/msi.h         |   10 ++--------
>  kernel/irq/Kconfig          |    7 +------
>  kernel/irq/msi.c            |    3 ---
>  16 files changed, 23 insertions(+), 40 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
