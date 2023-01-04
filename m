Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856965D408
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjADNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbjADNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:20:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE8DF4F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSCmMbOy9yU7/TLjpCODcvUhyjTSAkn4KDdG7HeczEivCHTWiSOC3qrEuo2quwUG2+3oNrsVPfL4DPoE4CK9JBCMihh3JG8VV7lS3gxmj9Q8GLExVEFqVtykdS8U3BMNhG0nWjR/gNzArJQXv47YDam2v3p+TfnnUiWKHEhj7sMUDKSr5/xrfVW2PmVzgdH7dUnoTVn2Ia/EA4lGyuChafL/UAdFcGCwsDnBf1kdpQi3V/D1VOKl1tHzcBc3dbiosqM6wb0Fj/AiExbzXxVezOqYZF7gSWD1/B4rkstACpGCbpX+sJpgtDj33oRipj6zMFeSwS1kHDJIwAKYqAggLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iJl3fUuPVS+P2Wlfl236Xjqm8WGFuFqh06sBCWYayQ=;
 b=emZpSq1afwnfavneiIyExCUx3qtj2eSGxbvmqHMSr6OhmIwvZlIia2mvWICnYdrpD4vq9Qg9OM/kAk8tPuEM/oEmDWWVyzi0/5fjupgKJvz4CmABiN3QkX44JI6KiyNOyK3/XOVdjcQ0inv2ffLVQwhNvJj8l67P1VUJXUTE1l+pQ+fem4i3IcTxDPb6sRie25cq3I/1Y1KZOJSu6sCPwdCjtFsXUH9paQC8x6nSrxFyq+/+2r078ruBLg/seTt4lYRgpn4DUBf0YdRa4Rfw3ukFKofR+3PCqY6rmCBhg8SM1xSje14AGpBit7aPxdl386Tx4zq/0dJw1JO/uUso4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iJl3fUuPVS+P2Wlfl236Xjqm8WGFuFqh06sBCWYayQ=;
 b=SRniSXLUAIv6CokO7I1C525+Hxf3onW6Mf0ktkSnERjX+TXJm6SHjGFWiyoZUrGIzuQ6mycxmksFHCsSuoIh0WXyctZwKFFwfvE4KgTdmL54tuJ1B26wtAP+jCKcMTRy+L6yv11HHAJudWbecyF6ggnbMzOWP2/E0P+S2W0qrp5jNS0B89b6rSYjQDye+nRRXHjQssp47UDfz+2RKsnWCXGCiw1mwclh8Avoo0Z1Te8enROILr90iEg7iqH0WEUSioogCw+AzrFx+UCdQBfoKw9OxNpHDBInY3+ZSQ0pmhJZ4flEGgCSjn6wufyVcJBHOfw4Jbvk7SKxcpmCT+c6gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:19:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:19:59 +0000
Date:   Wed, 4 Jan 2023 09:19:58 -0400
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
Subject: Re: [PATCH v4 14/19] iommu/omap: Add set_platform_dma_ops callback
Message-ID: <Y7V8/nhnQC/8v6M/@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-15-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-15-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: de7eb9c8-6d31-4871-3386-08daee566146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gj/HVVT3pmQKjYSNRr1cb+AeKR0jRULhwXrNbP7mLO50oQUtY56gIkMwrvbvL2AXU4OUN82tBKOinBvForyt85HdBgPwlz1O9yJzFK2MV1plQPMMgF0143s+OiIcEg8Zh3SesH3Yb6Z2rOkV7VsRssQyLXxIRIA6PUq9kI/vn16JEJT8LQYtdC448WCSM587CxASl7WhY/um5yb7jscpiQgb7DtLtZ6UzGA+QLixkemzOEONoXblcSzLT+AeJRnI2ln8lLdrBsBxs7aauG1Qn470fDutG6lQKGEmFR5YiU797JLw3zMQS6cYQFem/V448y8D0K60dtIXeyvsvlpj580FspCg68rFSm7xDnCSSOz7vnL0h1eQeAJ5yUspueUtQzyEJbX4mJsggAw0r3cvv7Axy1fIUWoom6AJRs4VzDpMYU09419raX2raBrf6uuQij7e9XsgCRKebIJ+OjY3pryHZViBC/H4aI0yuU76WCEhLQost37wQQPuZchvacwJusuRpbd4GLxXQBdvrNwC+f2NFGOMfuK0O5BbnnIfWuP/Fv39nx8f7m+XR2DtQBuzJcdCOLqFQc41RmsO40aX3cHtVmUVbcQAnpnhc18UdLHSLSANPFgxfUKWjW/KVvOys3Z+YCr8OxX73do7mg4LyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOLI3JzqU0LOUCMqDg+FroSo85DluaPOmpgaSWXJXxcPPXeK0OkyCZoyS3b8?=
 =?us-ascii?Q?dYHvwSIq4ZE2cBEmDWtT76uMg3S570d/oAAUBbznzBHr1cmt7HXLySsk4rAA?=
 =?us-ascii?Q?4Cshxf0I1PnUlLL/WatuIyHf26pVWSBrD8nVjIVzOfLg3Kw2uOZ5t5eGy7ep?=
 =?us-ascii?Q?lGFfrvVgWYk55oYZv4Te51G+iPGpcNxAOmKwxm1cKnEuQWbNdbQAZc31wkNQ?=
 =?us-ascii?Q?MQsuMBlkCB38VN26irIQe/aEC/E3L5mdLpABRWWqdLJeyWfI1UREXq5CK7Zi?=
 =?us-ascii?Q?RKE7X4Yx6PzscfQSMIxdsTKq8q/542lrGd/5vc7nzadkVGXsOwfp6VMot6tu?=
 =?us-ascii?Q?3vHgSYtT0LQig6oejoMOMxUpV/JptTt34eP6g2ydJefAnmEgW9T/I3kDqPrP?=
 =?us-ascii?Q?5URrO4hmudZhm/RuKfYh4NfIQxgknxnVqlRbB636O6v1EmYzKb1s1glncwsz?=
 =?us-ascii?Q?vCGU0hYAXj657ql3yOPcQha6zRB+z5zAqEIq0658VzkXrO07pU9e/2vOXOxD?=
 =?us-ascii?Q?L01V+pemqeSd4ziz98IKmZlRdteSeFuTA6l4LzBfMOKSvFPrm3X0MtRZmUVL?=
 =?us-ascii?Q?10Q+IvO5qLjWd4mCC6oaytQoegcafWo5A+7VBnTnTMR8szWUSE0VqUAjo12f?=
 =?us-ascii?Q?JKW4/uDtNEUjGyTef75cqp9FXFjrCF3CY473wF0als8IEjSycHtmpzcGBt5F?=
 =?us-ascii?Q?WJdNiSiypBwirtVaQOWHNJXHhM2x/twRy3i7U4905s29krhxR8xDfCI7K2+G?=
 =?us-ascii?Q?JYt3jpwScLCtdsoPU15FJHGKLj+zNbNGlVLGPRyYfi9fS0U7/k4BiX3MOR/Q?=
 =?us-ascii?Q?Q1UsjLVJezN9DBKnV2dgQUWcrIUIIK4JkYj1CCcVQywzfQi/aT/M1YxVDds8?=
 =?us-ascii?Q?DEJAxaTDo0hXptqdVI8LdqGRLUNB6maCv/02WnP1WVmq2mwGP65dbwOotA0a?=
 =?us-ascii?Q?RvqHLpRe1J/w0ubylDqXjTAx/n/dg6gSNOOkEEZs1miNKs6CciIioF2p0nkn?=
 =?us-ascii?Q?G30rAHiZxMf8PvKJeGsqzjr4pNpb7IHeW1YG3GSsde8iyn6aVdENl6jEHj1V?=
 =?us-ascii?Q?S+EMBIPzr8NCqCyZUbUtaatXIgs6CAkubB8SWPiw2cD/sEsCscZCGknRJxDv?=
 =?us-ascii?Q?p/6c3GgoIpeKQGZbgu/WDFw6AcnUf4c1LEGICfaFUp+mg4y7kb4jE0ghp1wA?=
 =?us-ascii?Q?uVz+ZgFFDFumEI9W6Nr2TIjhvvavZNu/FQPlIhNYnHH2YOsD2pznYBANrVO1?=
 =?us-ascii?Q?06vVxXR7R31XP7OzRUXflhE+P6rNnCplmXdELC8H5XJ2FZs7yujmGmSlYiV0?=
 =?us-ascii?Q?buCCiGIUcfhD3QKMQP4DTS9HUdzmFFPEKsRnrE8vyYGtj7MP8K1s36X2MEZU?=
 =?us-ascii?Q?33Oye5W4nE4nBBjAOow1UiD9HVtPE7frcjeDBNPhRQ3VMqOGANdn8jymRbch?=
 =?us-ascii?Q?SnCW1htCB07oF3N+9q8Zg3A8mmmCINKc6ktSJyfn1CHqDxgU5ncyStJPjnO4?=
 =?us-ascii?Q?gK0WQOBGa7ixTG/uGILd6vOwbpD533wmOxITEMGX4C6s5UvsqL2qwO/STETx?=
 =?us-ascii?Q?GZTRaHL3+rPwFHLyMEXqg7EMCD+dmSJnDfWF/9um?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7eb9c8-6d31-4871-3386-08daee566146
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:19:59.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBgzqlPCOjHTVyGObVbTgfK0hL312+Tv3nh4EkeuTNv5U6Mwz4m3KN7uRNf00ral
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:20PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma implemented, there's no need for
> detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/omap-iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
