Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608463A9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiK1NoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiK1Nn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:43:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE21FCC8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:43:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByHeRnPbpV1V6UF7Hsp6+aA19B0NvHeiMtf8zsvmzHmUMPJyw4weZ4uX9YQGKhtWa8Mm2/fs6AZX7vPgsNXEexCTAf6cz5mXYnyRqc3vDLMY10YODTAxU7lYP6NZyFDm9bVpE64Y35NmF9QuwcjTzu68+62sIf0Cy3B8Z9sS1KZPVWnK436hnce6++yYrqWvt8POEBuIHrUtlYQGOyR/drB5Y7zOKr4aoS+6KXgD7AOnWThvOp3+Onpw+CSDKLsFe3332VRN4TIQM5IYESi0g1YzdCONB9gfshsnlkVZBqax6WXiLrWhLVynJ7ye/RNhkuw4ux4hc1H23ZFv5U5XCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/hki2UnNF1nYI8hltZDYfphD+6irnxP3H9DVuhm1T8=;
 b=UrieuBXO83DtfLdVpve8MJz+bj/UWm3EVC5UfHYgh84H84qgPkJlyB/mc7zIkSl9xL/X/OQYBUgBcNlBqALzoGkP8pyT9/6ZEvD1u/KVaFoZ5Cdgc0dt9ahKJ4P0+Tx7Qw27oEndwvh83Bx6S3Pcv1aZUfNRuTxablYdks5JcYE+cVWQTGg70GBg+XNairTfywXQ7pb183FNQiqQvHXc6JJIuEjCsWMCLXbij0KdduSRDmRTVx6fTbDD/25q8xC54q9z/b274IgqdnLs6SbH4tcQSUUWvRsCI5YhesthQ1Aj52VnGQ8VvwDnrkwzLg+DM7qGKH5UXDX9HVwQNOTKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/hki2UnNF1nYI8hltZDYfphD+6irnxP3H9DVuhm1T8=;
 b=t/zt8yvUYUq10w1VtVVL8TrCu13pcfFQmclcKUIj8qYR6Fo0aVgyLfYSeaQRdwrct5lsTTgtfGtaazdGf3jP4CmHSNJ+NmNPj04OccWU168T2DZMlTwPCqF2qm3eMOtvqWmQc3gksFEzYT1yvBUv9SO+r35uGV47M7vF5nIt6DdPNqu8GdHcpHy1vN0QFu/eRJSpdzSKyjYnlD5D5r2tilS0e8Pdnc+SIE4WVNEWEvwCwGp/zIYWSrwZV6fvW91pknvZo8tpIPCbh4bNTseu3sOAjolBUuvQJEvEHXdBUk/Jhw3FcmPvVOp97jKDUj5qN+Ev732l1Ps0Wxz4RLDM9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:43:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:43:56 +0000
Date:   Mon, 28 Nov 2022 09:43:55 -0400
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
Subject: Re: [PATCH v3 03/20] iommu/qcom: Remove detach_dev callback
Message-ID: <Y4S7G3h/yMPeZ8KB@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f81d693-a685-4bc1-7514-08dad14698b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fL9tuov8sjZiTrGve3q+g6oMpOzGhRRgL0Y0RxgwOSMUvmhZXzLR6dNJP3kVC17s+m+VJSKH2XrLWetKR0sQr8YnVOLTql7A88K+YKrmOzkxZFDxQt4QaqIarWigQSj8WWaswlzwJud4c6kS+/miHP/EWgk8SAG9ugvis/WBGFduX+OsD2FhBy94ZO4wdsPYgEgvPJ87gaFHiX6QTkVbSahlwXLGiZfrTUIuCPDGGTMWWsvuUdiP6oEm6vkOKGNUyQZ/8jVWQGnmquz/DibK6isWK8bCjxfYUkEacabFqsyC0931MfuaE3EVfJhGgZkURcHm5TWujf9zekII4/9/m7+BU1MbQxpFcit0YoSu+EO/8plXFaEkvzNWi6k/57PGbjTPIlL//H+QZs+00j/hFwk9Ge5yh8z++uu0HBJYIhU97ly22MX7mMczDXCutXOvyrylruvFBBLCBBoDFReXXoUbkQpIKO6cq1a8UJ7WGiEfNGffsSi56/LdAxr6SLIP8MA58BiqmaZdpCXuvp5fWosb7oRUDuNIWeTQaa8va1Mq2JDBlUY7/wg65HO+J78VFgxxq7vfdGJc7KXZ0nIF9/l50f17TPi0idYa1UE+hDKjb8Vs7Gvxt24ZYAKH7qNs9SxvIIUPcxTh/XldEgpkQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(66946007)(66556008)(66476007)(4744005)(7416002)(8936002)(5660300002)(41300700001)(36756003)(4326008)(86362001)(6506007)(26005)(6512007)(83380400001)(2616005)(186003)(54906003)(6916009)(316002)(6486002)(38100700002)(8676002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZpP/UanB1J/a5ZaQxyiCFaSBp+N7n/RgHjyLwV9/OaYvCLKO54E7v9mpgwB?=
 =?us-ascii?Q?QcbbWjMJlWMfBgrW80m4Gk/0Iypb/Q9rKAGdfngp6VTPCZ6dhAkPYE6pSkSI?=
 =?us-ascii?Q?yszwQJvywg5l7i0uycg23nE85FTJlgrDP5cxWmdcfYNkGA1DbBY4BmmDJ6Ra?=
 =?us-ascii?Q?DFeHxsmZ+b6Wsyb1XkKc4gjdgkd8JzAVKt9WLwPgByGkiLacTUcQzoB/GYFh?=
 =?us-ascii?Q?fGKJDKxEKnrSa/08n3D7ed9tUN9VWlaKbs90mxaamgjG6fQi262lDCQm3Q1j?=
 =?us-ascii?Q?9TMOvEnMK5FtAUEipUXp8bl95q+4sBvxaecVlqbixo8qQIAx7Tmht/XL1Mbl?=
 =?us-ascii?Q?nZxUSxeX4otPFk6/lVZDO9aEtUJFVMSc9I340F7rT4j/OyZXaVNz+Eyb+CvI?=
 =?us-ascii?Q?hAPBn+JW8cr9FDrlNNeFbFCdZGxOmrOEz+uWeWvJ8xfBVuYqAbHc4JcdChWo?=
 =?us-ascii?Q?rNaDnZ+TW00hggLLVJzXm7fRW2ULhh30KEqrbzwliUoF8DGQDgUF42/JyRyM?=
 =?us-ascii?Q?D+U5svbpSKvAZiNrzc8AQGbnaII2IGvnmeytfcxr/BSQMgnB1M1hQs/pcvTI?=
 =?us-ascii?Q?4kpiSTSD8CK9vAT+fwZ6V8/19mr3BPfK/qdMsu/dgoifJI0CL3QfVqSXdZGu?=
 =?us-ascii?Q?zRv8LcdIBZl4XDvhYZam1X/GUM1c6KqVMb2dtGfxCfaKtTvJ4ahyqY6qjy8W?=
 =?us-ascii?Q?wWky5bQTvKmV21o4PZVtkumcGxzp7KCXbuxJ/wAYrhiDpcvKmd4UOGen44Jn?=
 =?us-ascii?Q?gW2i4Xag9XqUbkKzxkZt0084SitTn2EToDyxVNagYiuSx0hOjfzUcmz+vICb?=
 =?us-ascii?Q?eRC48SzofPRN2vPw2Z+sL0Ol8N+pVinvw/lBxcwHaG+aMU94egzPu2q92x0+?=
 =?us-ascii?Q?AaRgDY/1DRUYkiWq8oyLmMh5/2zV/Eui9pNREBM7Ffyd9unzfH3Bgqr552sw?=
 =?us-ascii?Q?vf3gRr0q86Hw5rVdmce12JLZgF7anostqo8DY5it7wu4rLft3EG4Sz9saY6w?=
 =?us-ascii?Q?oy6G7lBb6qm9si9O9XqDhMH1w7fo/lxi8JxKpPSzGMcWuWFDTc8I/pSYXoFg?=
 =?us-ascii?Q?gzdEP/yECalM5g2IMFL8gSOAsR3aaEuGhw7l5NQZq9/a6p91CW1LWnIFJLT3?=
 =?us-ascii?Q?D96qNe4BIvCq/8O9KljE12omMUicv5rD5KloLMV7eQpMczeabAiUTQN2bscF?=
 =?us-ascii?Q?DU55U3Uu3F75zGxujDLfwcz2CGg/VslFa8oLCTQyDq6knV66jvYDYSJ4WJj4?=
 =?us-ascii?Q?2j/tZn9K0Tg28EXvnZaPYeRs2O1UdcY3xK0KUIT7u6SSkDyrrQmXOdGMyAb0?=
 =?us-ascii?Q?TBcOaGsaCRqdrHd/A5fGCsH4qbKlveA/f60kT5zaC1Bs0yzRaA/1DTWzbu1B?=
 =?us-ascii?Q?Qq1adjEabulZ/VLkiyFOMoIiTMshExUFIU0ruzJJ2ofBEvwpC5byvghe3upN?=
 =?us-ascii?Q?uCjorOTlbaasf71jYKbCsofqVInDnUcvoh1P3wOxZWM8PJs9olkB4+MebxtI?=
 =?us-ascii?Q?IfzYZmFARwajDFFfU/hFb/Vbm0Zpn4uF9DODDtMKVUq0xpJSITeLTCKZjxI0?=
 =?us-ascii?Q?Ni/6qhLjSM1AqTtIUXc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f81d693-a685-4bc1-7514-08dad14698b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:43:56.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXQrJrijPlEwDRQKzjTZKjIgfyBH0s3YFxH5yjoVCqAPdkpkdWhR7A41oxal4xZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:46:31PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 -----------------------
>  1 file changed, 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
