Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB86563A9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiK1Nou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiK1Nof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:44:35 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7214D0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/N7sta1UkMf9FCy1JKsKdu7/V6ApYTJEFIyKssYhS2onFvZIxblWm1jZ14yWvK1lH/G2PIKQspTeP0GHvzXhjzUnsJMXL2bPlU2Cl/3Lq9jGKCT1/6UNS21eP73/tDebV+uoi1PQPViaCpQii0JNEDHlARlocdLjNldA66QPNnrZLL6fn6EnIU8yllwKgKksteNoRpjeCRH0q+tnHoKYOwF3UkV8wcnnqNNYehB1pbuMIMqyDYcw/9pXmIGZsyQKoSQhX2FmZXoilbINNPMjVugp2F6b/LNrQi15H/tIbku0IEcnHA4+pAxkAzbxxZrJ8YjdJ4iQ87MyGSUfOgIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNdPFQVHcijThfX3+m15vew8MC9WPVe2U9Z7EBUEwYY=;
 b=bsOyRg8EJ72t6RVweQFxq1Aw/8c1nJZADAjjG5cShMH6SvWgE0nKF+UvlHNKNLlhlTdaouEiqSxchg25Xt0BmDRqMpS1qFc8lCIOEA8UtBtjKErnHGFHmL+f/YDuyspq7RtbRuDJ6iXyYrJtBklGfMHPNaYJkCdt6eeDXPTUz+xKLyh+nlaGb/2mu8e1IEheSSBIVL8AY4hUW5gjFVE8rzsI6r4rSqkieD8nvEZHWlUeC30eG+lpOG+3LeL3iHMJ1QcGD1ghv+BugrbeWHRZZgrJKpR9bTIim0Gdpmxd4pL9A5pZFAUW2nfSKLApPSlF79zxANUEnlt3zpf5TTMk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNdPFQVHcijThfX3+m15vew8MC9WPVe2U9Z7EBUEwYY=;
 b=lmEygFOS4nZG1vK9qDBgaFePWwvvyyPNXjT936Y30Vf6Q6l1pgcMpQVGM0LjJ37qhC7KJe6ndL6EQ9pXxxqnvsJUZNY+1VACdh/MsvJ0Cmwpeepo7eltrz8TOc+XiZDoNcDIrOT0GofrjQnX3l/nkg5NJ6W+rVBjkcnQFGxqH4aq1y5i/naF+EebUIHNIwFzA5OWG3pqENAwQYGdjUHi+5JKeNE8/OIL0nCm/W492y+v49dY4Vk5dqhX/leI6v4IXCj6rPYpBnE8CyW5mm612FAc94qSguFSrkr2yFJ5qUxAoPy6fXrw/d7Qv/W08GUKf+GJMgMB9IKmKcLVTJIJrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:44:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:44:32 +0000
Date:   Mon, 28 Nov 2022 09:44:31 -0400
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
Subject: Re: [PATCH v3 04/20] iommu/exynos: Remove detach_dev callback
Message-ID: <Y4S7P93gSdIp1HFJ@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128064648.1934720-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5051f1-1df7-4791-7c21-08dad146ae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C8tHrBSJyQww+OFFI3p94MZvgMzHCII8+LyuZXgI3U3H0wXlESObobhIP/24maJ796Nrc/TotkBTpHJNzyZxCVO3M6bWFhXWc8Wh6i0LYLh5R0FsXMKNgtvx6WkmrYjF453ccph9zg1GSyQJ7f2J8WwqtmINe8R5GHcUFASri9b4WvohVwcsPaHD1ZURFbinEnncPlJAIeRi9xrNSE6TtAEUUH7BhPpCxVznh2SVHcKQIwRvCFRCxqbTkf+xdAU7huAn56KqPMMHm32iHtAzQRM4QhFfIBNf05OBgHzVo53JI7OAJOZkmdTynkIzJvjYtybMBTf4nCln52vy9Qm5jcY6nK7H6dxgGK27XPyWP30MYNhhHC97KzEZy3iswHrusJrKu2MrhmDWHx47THoug4DK1vCy7Uoj1cXDds0uevt7KXDy3opUNzUgChim/7GjrEn3Du3Qk78jetpsX6o8AtxIz6a4KsoJPEul4f7XHjgLcmPKgTkAoXSAefsNiuk1kxg/OJ05GCGsrcigxmvG93BSgmMh67PwjxaPIQyr5d/txZvCvL/D/4MXo3sOrjXoycDlGP5EJ+ZZsvVf0Hvbqct5yxJFbiOnoPtv0HjA/8+J8PD1f4DGf7MyUwFBwCdq+Y/TmWn5U3mTgD+IAM3hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(66946007)(66556008)(66476007)(4744005)(7416002)(8936002)(5660300002)(41300700001)(36756003)(4326008)(86362001)(6506007)(26005)(6512007)(83380400001)(2616005)(186003)(54906003)(6916009)(316002)(6486002)(38100700002)(8676002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMeD3dse2JNnFZZdaK07IRZleBuRvXm3aQZyNZ/XVDwF0KbJwbf+wAAtrQqj?=
 =?us-ascii?Q?O8f8gKRRicXodFOn9COgXTb0y+Y3VszD6yPlp87QKkGYqZ/e6eYXWzkAdgDt?=
 =?us-ascii?Q?7KIn0f6iuJMKzM/kjZrIZpVnoVZLGExyPX9JO6SmJe5ZGJMYQ4iT0ycT8sxj?=
 =?us-ascii?Q?JiDsrrj21w/y3Q4zPMtZXnx1rd+rBDMbyoO7go3v9P8bxShJIVG+cPGEvht1?=
 =?us-ascii?Q?uTLqCsHs+5Zh6hD+2Pj3oEEMpcOphnjSfjP+K2fRrp/M2byMAZc6tNXpE9lV?=
 =?us-ascii?Q?DgsnQDxDKvnc43F+5ZXOgOl7rZF/sDgpUV64sgsZ8KMq3+9tKXUpHrAwqviR?=
 =?us-ascii?Q?mg0w1VYlhofQu4fi7IjzByD3Ss75ykj5Iv2/Rj0+h8/lhs5owm9h2Yw5fwuH?=
 =?us-ascii?Q?spOtV7f1A86vWTTKoalgbONIgdjCVlm12t9uGNsbz/Zi0qplKsXvJ9Qe0a9A?=
 =?us-ascii?Q?ShmFj4NKjKv7hDLdY0uuc33yaVD99VndP+WyVmOeZt+0Cy4ZPPaO3ii/nv3I?=
 =?us-ascii?Q?o+VwLUGtlYR7UVsPFwIMRrf7duPTl8hH8hCxRga3U3MnnlW4ipRRvZJ7hOJe?=
 =?us-ascii?Q?w2SmzXJa4fAjDMSnu/k5FkUqZw/Ipzsb/46S9VLq2mxf8ypK2dJGSge/X/6M?=
 =?us-ascii?Q?SjttFj0BAVcQwQxBU+Nb3L05GzPo0obcoBs17jz6FswgnB+u15BkZqdcUseu?=
 =?us-ascii?Q?nViK2JP11oaCLD1TrGu0eBtESbX+DZrIaaOBVRiiF1hTAipFcjfQMOuxAUHz?=
 =?us-ascii?Q?3D2uyhZ3tarj4M6tv3fJ0MRsXFt5A6FbzMnSP95DPP2OvFHQxfvjArszD+YF?=
 =?us-ascii?Q?1Wlxtg8AIx7vAgkWlM+ymjifWCi5ZMptcLrvbAh8FBOZ+EPG/Khx/5BJPmwc?=
 =?us-ascii?Q?NzkjvzS+/n+orFqe5dzOI0QUHVVJF+z6/kG3BCMQjC+0BSmlZe41bcKhvgV3?=
 =?us-ascii?Q?nucpPc9j4VzblPE0n3GSm47tXWozWCnW6XTw9EJ6wl51kkdTLUJ622WaY+FQ?=
 =?us-ascii?Q?4kiXY0zNrcnlHPboftp09Wo4cGOBGg0dbsx3cRjevpeSr/MJzeNMDO5Cw2xr?=
 =?us-ascii?Q?WeC2R2WWatcz+z8SBBCH/6HCIqcAN8wNuV17+jOYmjC9tkTdZMwanQG4Sj/G?=
 =?us-ascii?Q?qVw/KnBGLz/zcTHeOCOtwOcrDEVZLm+Q6XG12TRQ7kGI1V/wYkkEcBYrQnr1?=
 =?us-ascii?Q?doiVJUBeoWaUhLxs595VgEXR/6v63SH9TQy6R292B511jnptPX5m+CCs/95F?=
 =?us-ascii?Q?1zQ7tpK+XqUG8yhZvv/2Uvm+I5hODeaCHMEHdQ4cPVGjqX2vOg7pWXGRHaFG?=
 =?us-ascii?Q?F3soFocrHvDKb8yywLADWPq6nShiSw/yFYXKXC4gUwlU1XvNGex9Rh2H15dr?=
 =?us-ascii?Q?nskfPUP2lauW0sV2bVz34pWXHDsK9N5v0Odjx6spiEYXUFjw4FygWXWroUFE?=
 =?us-ascii?Q?7QSkVbrbs/hs00gCNDfNxPhvvzoGm5Ue0BDXN8FWKw8s0AVPKP78I/k5Fd7n?=
 =?us-ascii?Q?l1aqSzNYY48dxEhG8mskk8DVtGpxPUjHhQr8UummnjAGuFto9Urrq7PfHdJj?=
 =?us-ascii?Q?tOWLi7vyVXkUhVx/Hi0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5051f1-1df7-4791-7c21-08dad146ae06
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:44:32.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPXY4N7Paa9OodLlIJplFD99Y3Wku5JI86dAjo1pGgWD+f6sRpQGi4ZE9uRK6znD
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

On Mon, Nov 28, 2022 at 02:46:32PM +0800, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/exynos-iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
