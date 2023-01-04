Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F465D410
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjADNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjADNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:21:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E4B01
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h02k9D9yjtYjZC0xvxlm1aRujD585q9zwWsL5OBmNv5h1Uis/csvV1LY0OMlrF7uYe92lRmACryK51Iu+cPOw9FEyHEJ57mHl+s+VWEvFevRmvhmcf2cH6PCQpMqfgNX1uslIoBeBNfwcKE+Z7LEaihorMCXMW0chpd1bIeFOBtShEx98yZ6tbXqy5YAQggIZQdNgpMAEx7jO6VEigGtvQQ5s5Q11D9hZFk8Wblx2qryLHfXmF7rMVS+JuBph40i1rR0q9V+sd2YcXHdSVuHMR7BPMXc8H4lu1q/XBurRaAU6jWZiqs3e4kOdP6d9SjZTqDoZQYZkCz+/MlLvMIZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zjESAwJoO8p7hxJ6bq+oP7EbDsY49lP2DQpjSOzYzU=;
 b=TQiWjJDZojPSc7NAYM+wZrvCA3tYLhOnzp9YJ9s8mPaUPiTFEKoAuFicutvf7SSe4GZlkkToEUs8fQhwycd1QAp5B0wlWFAziMAhhsOc0SMtV77AaYGSL80UDjL2UYTFWg/HmE2Cicl3fMSUU93GYi6c3jPG632+/ays7ONg4hlHUsp916xR1PNBNs8cdmL2XIPlf1Fym/VTXVb9zLV5aBa5hVIGET/sSqZn01kHsSxHTJbc7OWcsZVOeQsODn85OYj6P+58KiGXvShVd69NGNprJ3TuozxADsT5KdKyRbmRUcE3LTtIwn4Ol8lkKmd6XEUMr14gGQEceJdzAQHJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zjESAwJoO8p7hxJ6bq+oP7EbDsY49lP2DQpjSOzYzU=;
 b=e/IZVb9OClG9h7kWn4/MEa6eZNCtchGFjtNSaRZ5jkpc1TuGL7M9FMYF8ZDdmkq8gRD95EpKXka5leUMEed2xxLLWMpC74ANfJdIkESUtDmqFRH7QieZS1ajPfTYRO31DTByKTbXu40uJ0kB5l86I2jDHwoN5bccGvzpl1i2mT0uImdaBOS9u4dNTz/K/qwlZJiqNc/phYmFckbUEEMNy4QAusCSfL4HXSR13gsRKcH8NN7Enlp13kmoDMoyZSIGeghs9vOW0iNSpELonhvQNuPupV4R4jXEngiE0qBIwv/YbE8fn32sX/46WI4w9aKCFYhYrhhjCMSyTWkYGOA1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:20:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:20:45 +0000
Date:   Wed, 4 Jan 2023 09:20:43 -0400
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
Subject: Re: [PATCH v4 17/19] iommu/tegra: Add set_platform_dma_ops callback
Message-ID: <Y7V9K1irn1b/MJMD@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-18-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-18-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:208:15e::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c03eaa0-531f-47ec-5ce5-08daee567c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozJTTwPU3R8K32dHcDn/x+9i61zhbcF1ejPnRPK8/QFhgmw8b1S/7xf0NhGgcoF5fw10kY6cOdd948Nv93oaZFzGBBCR+ivsPhTUW6mLuBdT6fkU1XnMKx1H56B/ymrKgHCS26Ygbh8joF4DzLjznlYvBVhRGkgAHh3SMT3E19LlKJ6G1FrpzUtsuvQD3k4MhtmyN5+5H+ZXVU0u5g/IO2Cu+WF9OrcHZaYCSTwb4SHzEd+Xw0mm3dKkbZmZfd8Kny8YbM1JvStrLqiFFfoUfNVwxbhaUO2MjyEMCpfKN4XFHLJiHumWFXZ/vDFaiH5w+X62cMkw7WxcTJRUiga1s5vRaoK0e5Dd020IL9KFoUR6maxWtfd1hXgEIFD80E2FKleI/AkU4GVJd6cQvAZtwwC3CHnD/f5mi1tvFvbJo+eNyCwNqqged7cd7mZDHKmtF3fKQGMhkEeqBdYTIbfpngcqF6q/VJrWFVvm1wywLXYEmP2lP+vuTFrfgy1RXmdxp68ieMPggJ58vkWTAMroIb3Li2KqAQ8jPs4I6WmTbwwZHW8s64cNUmdiv77lgfySluzRi/b9FD0dV+CXNil+4XAJEZD4IV72UFUOizMZIKxp9gHaVOQnWiPZB3GtXCu5Dtt700vBivQday4I8/OM5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(8676002)(4326008)(66946007)(66556008)(6506007)(66476007)(478600001)(86362001)(6486002)(36756003)(38100700002)(6916009)(54906003)(316002)(2616005)(4744005)(83380400001)(7416002)(5660300002)(41300700001)(186003)(8936002)(2906002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2l9b3I1XfjIREkV4tYsjFPSSvVir/7WdGwngfhJ0EgGbS0vjAwKoXrr3f3T3?=
 =?us-ascii?Q?WfVnyOzvXcr3zk408ej8AmTY4oYOvRIOhXVvojKOrQJr9I6bLfbyUjX5Feqa?=
 =?us-ascii?Q?uJZljvLvEg/s+zSh/38i5MBvhgYS2aUL7B7SFfYTR2/X9/bdmRX4buoQbmie?=
 =?us-ascii?Q?lGT5Jo8AluiP8W9WlYi7HHj4VxmdsIJEp+zIYDvWyQkAXPgsihxSLgxkdVEj?=
 =?us-ascii?Q?0u7kwH8YrEOrLG4ZfN33sfIvrc4pMjkSHWMKiFSnSuJeidkPp4abSaqp3Ba7?=
 =?us-ascii?Q?14YVL8AjF0LkBONk83NkPlKvm4z7fLk22nKXnMk4vh8eqlbOfwMLzTezWu8k?=
 =?us-ascii?Q?ysuBs9rq5g+e2OnC9GcogWtOkYVD6jXdZfppKJvMfSKxUYO5/NloofF2kUFS?=
 =?us-ascii?Q?TpJAgMvqvp/200RKuGTw/OUdLDAFL7tnWJj7K4WQ+0DYikyoyirXm61OC9tf?=
 =?us-ascii?Q?YvIKIeKz1/RWFdI3Dr4AzUnHmvpbzyRzwmujEVTAij5eSJr9eaUTOH3oXGWB?=
 =?us-ascii?Q?1CAJ7oxjCh77ZS+krX5wlwZmP+PUUi9Vsu8GE1abnGAeYRU4T7CZDKeOYT82?=
 =?us-ascii?Q?XpE86QJgZEJ41OXRzE1okisM39ZSVDiV/k4FKe5tyrE7eSZwI0LaTvC1Ggm/?=
 =?us-ascii?Q?+wSSn26/1Nst/i5yqQNczTQJZCiHisPtGfBvPg46nnJf76LqRnFBlVJrN62H?=
 =?us-ascii?Q?pjZuZdavfwD70g5nc8LUYPPNv7HfL2uAYKCn/1jgqGBvcxX48QF/71kqJCv5?=
 =?us-ascii?Q?MIKjjf6M6D+KnuCo+YAeFGLkUmLwycjCiBPYXCxtKO/G5ark/PDSM4eT0VEm?=
 =?us-ascii?Q?huo8Az9yaHaONMTQ79kPwomFv/DpG9lij/70hPECEshSIY4npig7tsA227ZQ?=
 =?us-ascii?Q?YRx+Yfyz+U2ju5nmj+J2VmaHtKvLf2WhyXpWxF3C8VdMS6VZD9CYGHwFwMNI?=
 =?us-ascii?Q?aNtTRTbKCaXFAAJBdNsr/zCNhKmpxT4uY7ErlyjFQngREE8LY0hnzrogR06D?=
 =?us-ascii?Q?JPbh5Dlby3Vkve/nK+Nnig1juBeRueRI807xgTPU9DvgdGFN0f+/dJQgzubX?=
 =?us-ascii?Q?tKuk3yAwh4qvc/3qh/8KPF0PIZjtDWpmSnCFxGD2nnV2zdpzPOUF0cGZhe+l?=
 =?us-ascii?Q?7npE9tCkpWCeqjUq5vyobZ+X34R+EJpYwB7etXQh8l+F8h4Vrc/tvqvAQiRL?=
 =?us-ascii?Q?fBTg4a6NfEViTo0YnfxhPGCcIO5JXOwd4I59308vwqbyNN24qdrl1sqqq+7c?=
 =?us-ascii?Q?LXsNsZX9cS4Lo1TvkBCny99/RGj5eIUNsDr9GPwJ35/+WyyXwqIrPma4Z/Vw?=
 =?us-ascii?Q?s+XbN/o59duROWRBncFWt1uSS6g4J43ezlfhUxJJRcstoEzhmhSeCDiyzlRh?=
 =?us-ascii?Q?R4Vrre5YBaYW0du9FcyNN321z9qUz7aYo14SljYQciwyPPoOzHSVpIIHiXyK?=
 =?us-ascii?Q?oGXCEQyjW2V5btpzSWUy1vgLDAhR1gTGzuj/+8G/uUCNs/Vkg74Y9DZQVyzv?=
 =?us-ascii?Q?Tfto4FM6Yuk5CqvSF68ONdLG9gBC5YWa7Ek9MLr0ciQH1m2+bQwE2GQWQG5I?=
 =?us-ascii?Q?8YIGxrg6/nR91bY/383vL2TyTZs8yDeKe9SNWjP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c03eaa0-531f-47ec-5ce5-08daee567c65
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:20:45.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqEPmzKH8J3beQSDxnTk6q4BTHMuQrnNSCEbTkptXqItZzvuHLlZb6E9plcPoqlc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:23PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma_ops implemented, there's no need
> for detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/tegra-smmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
