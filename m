Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685965D3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbjADNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjADNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:15:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44813CF5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKxnX0uleZus35gZG6wFp05zG2ZowZwUJ9bAqpm+txW9NwenIPubHnVL4mh61SiTwOetnDGHABsq/SaURT09frMcqpGs7MhZtolFE112j03wwqljKbBmZWhjfFN+cSOmCNtiNsbV6V3vRVg99k75LgqZF+mIuuDGb1kV5S9VEK8of2kTXSGfT7C1dTPn8c0IXVZs4xx4AcvnkVSs5ha/Pe7liXtBAJ+2cVHg5H0QeT1CSRMeIbH2ADI92SLMPXCTxAh8g3pC1O/zn6HtrgdFlUoHp8o0yo8eE/8Gm4w5j9wANzjfvOuDV/Vntr+4VOOBkG1i+KULU74PgMCUoxKZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDzmY1JvRhCpTPt69C1stDAUEAGm3rtvahsKbQHVhgc=;
 b=ScGmCX8FmgMzUI380RTrODVB23zyD6kecNotEmBnj1mKxQ3DgPmQbRilF9kjDAKhJidjkL3nvizl84aSv+rIbJFOcGEqQh0BREjGVogE459tNARnTTlDQtBOgxgD6QOd70VqWl5BA9L7hBoV7wVsBkydwpSFW79Q9caB3IrK4+/IdMKqCGUc+pRiBuL6xi87/jCR74XBbVLYvOESoslTyWSLaElPIu3BlWf0wd1mkgpYWTA8f7Ns1ZtiHvVOFhFizV1bvk77qRhoeMtzqUkbRxEjxgy3TQGMMWiEx4FShgzKDd9x6zyjsjmDvX2Y80Ty1tum6mqSBCDyiZNDsShMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDzmY1JvRhCpTPt69C1stDAUEAGm3rtvahsKbQHVhgc=;
 b=tESQFBA2dkl1ihc+1j3CAzkKv7u3KzXzLfxNDVTatZmNzL/fGDcOro+dQGrrPFSRxkq0wGCuYzugjKM0psqR1C5RvBsecczh5ovY3GaKjgVERio91EON+Zj+EW9Ijp1VBJ69Sss/bwsu//5Vg3SktPRti/2+kZ1gP52trOWFcKaubGJ+DEFCMwL6E8xvCm8FhfQkxcolTORI2Pc/5qJS96gx+4sLYhw5XPpfr9gvkW9ykIOjXFAlVscaVPM58vXAbs9XCBS1vIuMRjoh9p3loHv/yRqCy7Z/S5AfG3xMn7CTQqbnAKMpJEMRcAT/+/aKe7nT8q6ou2XEb1ZibvKCiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:14:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:14:48 +0000
Date:   Wed, 4 Jan 2023 09:14:47 -0400
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
Subject: Re: [PATCH v4 06/19] iommu/mtk: Remove detach_dev callback
Message-ID: <Y7V7x99oQX5kXoi3@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:208:329::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc060b0-9124-4b9a-05f4-08daee55a7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 496R8y1uHMJR5qGI9YX7IzrNPKQxJPqat6kCsfrWhiXNkpDleQdcTIzWLuxNTJZ9LS5vC1w0OokzCY4VFFTO+6OI4EzcPRZhMI3pL1CK1cMqeUiw5ZMGqlwdlnv4N9Y2a9Hgg2K673X6IgvAI6rj5KcHtNhAuHoV7J5K2Emkd3Bnp1v51QG2F90I3c2WvXeQPRCYZiYKD9YV0QqkpxiX/vj3si5qjO2hZIlBukPLDVOMDfnj7S1kzP4KcpRpy21ZuKb5yd9YgRsVFevXEkRmLY0u7WdvmkmkL8HMDO1QXT97fHZ/0G+/g3aKlp5Obwktae3B0mgSsw0OJ2YGwiT12CYhRDKHwe6+HJMfTfbULb+DdDHhZcJ4QV5NJTnOpwcYk9/KafPui/f6CPn9DbnO+IDXPamkMHLGx8gdyfs+D2El8QD+qRP4kBW+83w8HWdineBgAGnCIUE2Ju30cUAhSwhemUOkT24uzBFvgB350g1EJCP3jJNzx5LHYsnqxq7JLXpJNHv9Hdo/p0Q27/WHwD0/i/vapxm0Ldjp+PLCH2JeM//YT2sF3YY/wJEKm+7TP4V4uezo+mN/ZBX2DeZy7ezbf7OH0WG29UAoEeubKGc3g6diWCHsAc4zZvl2dIUx/tcOgRIsJJKRJ9SpJ08rzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(8676002)(4326008)(5660300002)(66556008)(66946007)(66476007)(316002)(41300700001)(8936002)(7416002)(6506007)(54906003)(6916009)(2906002)(478600001)(6486002)(38100700002)(2616005)(26005)(186003)(6512007)(4744005)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBpzE/JqctgYa1rLXKVK7r/Ek1x6EqNxJL4miT8jiChZKx5rg5NkJ8cxWq6q?=
 =?us-ascii?Q?Lx/TbDc3Tjp65EzUhcN7rx9aT3v9x+EkTbwKP5QSeRsOVOmTF20CGo2Iur6q?=
 =?us-ascii?Q?eW/eEvqsAsVqxjiYOXTWcsTcOWsrRJlWvNg6UQ0aS/bcYrNHWRvMF/iSDCAe?=
 =?us-ascii?Q?XlmMD/9EV3UVFXcVREXCZeiAM+DQ6BzSma5alywugD4rd0pCZyiYMvPGOwEn?=
 =?us-ascii?Q?TgI5B9vgfp7SU+TEKhs42td3Ss0XWeo8drHQxSA5pk45xDpjQq1z31XRQLOO?=
 =?us-ascii?Q?tVh/GDOwPQ6gtD0KH35lhjqDUkb+lHqPV2dFOVf2uVmZHiyGmZHyL6GGAJq7?=
 =?us-ascii?Q?V+QA3uMcHqnOtBO2RYCQ9x5BBqZf2am4Uz3cUXrQiahx+A+aS7fPaPZrwTTl?=
 =?us-ascii?Q?BGPOLvAvnCVnVRkKUYnkumGF182IAZMJXf54xT/XQ5vfRp/ROH2W+5DsQkkg?=
 =?us-ascii?Q?GUUFqRKF1eb+T6wIktlor1UUZvL03eTEQVnpK4o5idjYYPXHGZ6376k8OppN?=
 =?us-ascii?Q?CA81qEMzWL4pM92vrbtbhFESLI72/O00MbBhas4+92yzPWfbXTWFcMmu9wHo?=
 =?us-ascii?Q?R+h8+Tb6xpP6sVq0sTe5FyGLE2tMMbHJENThRNYLEVAOTfFxSwz/YrITvdTo?=
 =?us-ascii?Q?k+GJoUWHD/h+N/gqQsKXVkcT4x+c8W0dJwbWxRqx94rkkAPUFOBDfOetP1vo?=
 =?us-ascii?Q?KQ78vAGKGrdjp/Tpk72cv/g4UvBLU9PNzbsaoKnISD3b5/6TJbciUCuIcTr7?=
 =?us-ascii?Q?BDWY9+RGrZbN3bFtOPFoDOx6ty7n6pZkMyGmZfs8WpYhYhidF//5LyvdN+c8?=
 =?us-ascii?Q?uK28qRTZZdQ6N9AxbEncRnS21d/ee2+NJFC+qd1CQVfl+IrjQoHb2vHQYbG0?=
 =?us-ascii?Q?xqjAlSrvNHfS/ozCzIUAsPv9Ay4M7OJCPqwygb0QsWCNyP0ZDa7h2rN4rnG3?=
 =?us-ascii?Q?HU5HBvc5iMaRYyz/h/Yw0jzIMt8e2BQmhAqxgJ1+r3nWq9gLWZ9RSA6qhNff?=
 =?us-ascii?Q?lwGym9iZWGE50eb+5PExbrj/LkJvL3ebd5TCFbfPo8QWrCHPTxwXuQrIUnJU?=
 =?us-ascii?Q?IqDLdXoYVOD+riO/oZdzgRHAUD4QLKXneFegNSOPNdfuNesORPS4yjDc3rtV?=
 =?us-ascii?Q?rsJpSf3LIFRrijlscraxNjXIQ6T+qFyp1Y9fixCr1FdRx1QHJqKgGtivEjYp?=
 =?us-ascii?Q?0PQx8P9xw4duB52P5GCDAhrmtmoAQ4xbqACXzvGt2Eop1VZaTEUG2nixvxbz?=
 =?us-ascii?Q?OhQh4SYbYUcFbIdy64UiPzPBbo3YZu5EANpzH5+PR39KA+i3I2laehE8kTt/?=
 =?us-ascii?Q?JmRTksU3iDFcJfvs2jwv4fV5+0wePTO3ViXPJ1nhwce9gvX4BGwwuWYhSCTJ?=
 =?us-ascii?Q?BdZQEMr8ptBS7BcbgCVOaPrKxaTz8qvd8ZRmFXoyaiLSAVqtZ/MNo0At9ACY?=
 =?us-ascii?Q?S16PULakiWsjhakv93vHY00FdSnVP3weRx9nsmda3r/rY/gpILOYnhmJLY4A?=
 =?us-ascii?Q?1xTAYmw3/FnB6FmGHVGM0Fk9p8tDq3OlCwQ8OOUEwgK17zhmeAIJyniSVo4v?=
 =?us-ascii?Q?PIPrNheF0gGpcwUqPogrxgMup8ysUD4rUgCbhs/P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc060b0-9124-4b9a-05f4-08daee55a7de
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:14:48.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II07rXmbWwOtpizY8+5Q7rFo6u4nuRw4wSUWHk8LjXW3tJ5CNVrrkGtAJf7FltDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:12PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/mtk_iommu.c | 9 ---------
>  1 file changed, 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
