Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B43706DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEQQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC3AD14
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVK+tv9wr1M+VdfkGS/7IGocfqQ1jifnVZkih3tdFThR5mbRcyy8G/tcnB+kgqdkLYs2l1Ua73laq5Dwv4Jh0txNCGT0i7PSSHBPCYRHtsvqkkffm+D+qW1uYaN6+c3UV+i+j2tcLwXbR1K1l906SLIADBCjCSS+WrBbZK+gwCuxJ3s4Sli8Y8UIocltymFkTbmVoHW6JItxbLoAUunyMHEUkWVGXy9UAcNQguYbOLhtYzgMX7MIcxUJVvEl+Mz8XXXYflL8A7kWfGjMsD87F8WBRf/G5N5VqAnd8ZYr08CN5FwwusU6JdRZlnDlYVGN2CDmGl9uupSe+0GouOI2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v121jv8GMmAHlYv4VcrMjyjy8Vd1gO6mgfdsBegQSTI=;
 b=GCeFMz3EHag+nf/L+yI46L8KAtJtWUVUJlAR3vpD0aZDnBocMt0xkKRGx2uAal1uy2AMG6GSRNi+v+1ufnXZTofoSP+ITja++FlKTSxk+OMdgpk8h/2FrxYu1EkuFeMXTrXwr9rNjGfMvEWsbcS0OCKJGvx63x0KtWRnCfU0nKUGlb60mQzZprXa9pMcMYIfXRNRJSHMR475ADEy4aCm5OAei0/zdPUqfxVcK7z3R5T+FRwZbkSbkNu0GmdhV7vfTgo8qntKLpU+mfeG6RCfrQV5jVDbej0eo99SbTSztVZ3Fb8vkT9jCv7IgeVKCJyK6qsj8qXdBrEkX7+Fb1p+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v121jv8GMmAHlYv4VcrMjyjy8Vd1gO6mgfdsBegQSTI=;
 b=UbY7pn76jjgW+ysUSz6dqsFSOjPsQeELsxOpZePiCZ8zwLBpGvqAgz+37qnOuwbbvPSAoBwmLYb9x9hNBuJG0DubyJrSfpeodVK90g2O2qEOGWJWE6Weowebiggk7sFSgH8p0fq1RKhNZNBFZqu0vwETl63oggnUaub35oYGa71aDIDWX8xHYHBTzgd8KxX5ABYYFhQs4FXqIh0dEcLzizBSjcYLB++dRzXMPlZXWqaMQGRv6wN1fIshCD3bVp8MN2c0Kbw75fL3HLXygSXlVtgKWLiGPg0/kWPbFfWO646kFPiEZIHm1p7/MQLj/qx21DNdYkEySzaPO0kdHN78aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:17:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:17:18 +0000
Date:   Wed, 17 May 2023 13:17:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Suppress empty whitespaces in prints
Message-ID: <ZGT+DbMf4NB0OSBO@nvidia.com>
References: <20230509191049.1752259-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509191049.1752259-1-f.fainelli@gmail.com>
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 10828fff-14d7-4572-df0a-08db56f22f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eMzmicmANYJ+RcSrFynU7XwarKCAwQSmRH1qxX2uOl0IeQL6e3PaoQ0fuv7O33koehRUYrGn1gN3yeSr24xmzKthsNF23GbPKqXwKxfNDyRzDanXCNsAoaKwQ3pX+YvAClblTTsJpq11Vo7SKDvnmaqEMrB7F8Malwb6BWn8KExIgqzdIX12kU6NS6m6EQpUIExwFL8vfTmv8agXGc2asWMEcS0woxo8EykZ2ctT7cDVHeJWH0RqBkNBSsAKq0b9Qw+y7Pyf25Mk/tjqNJhgnbJd9mXAU6pY2QSjeHhSPdSOXAiFQmclNfKZ4308hCuEFOjtlTIWin1c+I6/WKpauHw/0HLHsNN2VSr9Ld/AfuJ09/EYsCsCjtIQWdRgepc1erMzDs5/sFbw0Eg+ayohP9bXs7JVlUriIuiCRQIvf0oj2NKdJcFPVDq3i80J1d8oV6XTtMWE2PM4RzXbjUr3qSKCDGcnyhWgdzHteNCpUqM0Q/vpSoFGQIm+ifGXErzK+HvrhYY2v4mMNheU+GO2UVsqm5aCUKIqAzOP1OivGu0i4SnRursetPUtHYRUhRBOVq5hYAefnvfpQ/ZY0c0dOYSqODKbk+LXu7oTHEflIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(5660300002)(41300700001)(2906002)(83380400001)(2616005)(36756003)(4744005)(86362001)(38100700002)(186003)(26005)(6512007)(6506007)(8936002)(8676002)(66556008)(66476007)(66946007)(6486002)(478600001)(54906003)(6916009)(316002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5UX6oGh5NWtOWMw3TX4EbWQGzbkox9Lr6xNckjFDHWA0UknstIXRtBkKb3Z?=
 =?us-ascii?Q?mFLowTlK3vA4YodJtmmj0VRZNWxc1BT5M8EiBye5tuEU4xa9UAt6rms6c3Or?=
 =?us-ascii?Q?8LKWCh8qx4sX4VE7qxEMV7tWMtrIIAHbJPcKdekrVmQLQWRecTAhZ/RFgddW?=
 =?us-ascii?Q?+8Wk525dY34YcdvhtYz+5178GbTcAPvoUBAKOAlGFPqEiMxe6LV10xIgQCtB?=
 =?us-ascii?Q?2TzLbGLH9BYYnTgGbV7tcNXniQ8P7KZy+dqdY/VGLsppWdfOXgZBnVCfedWN?=
 =?us-ascii?Q?/rNOWsgmHV0rZhjQJ8VfiOnSDCxpNFKCfkozcqUs6sHiKrBeWo5a/Wn77Xj+?=
 =?us-ascii?Q?lYRGSNaX08/AsW35nt7iS+5nqsQz+lrWjWbFyaY+hrXETIFLSAbm+8uwJ+tZ?=
 =?us-ascii?Q?WA7xld+eF3h85iTYTdPKjqmZItLPHuHc8exGNxTX+u19wsbNOssBBR32QXKz?=
 =?us-ascii?Q?nclUmMQQasDtyW8ce5qVImzBmwR4Ahp6YpYyUctT4jtcaUwNqdWahoWZmqYU?=
 =?us-ascii?Q?IvgJJHerPR37xFzsGYNmh/vuLw58Mkk+thmanO5PpzEw/5ZlUSKsjZ5lCdGU?=
 =?us-ascii?Q?wGejP7VS9vnSapGJPISRtC7qyEmo/Zzxgrg2PrI2zadFwWshJrVNrTpaejpj?=
 =?us-ascii?Q?clu+O5j1z9jgeGpfvaGf2N5jBmHDcdCOWp5CiMf+ndlvQrkKnh4Dj4AOMfgA?=
 =?us-ascii?Q?SQokqlLccQ351/ioqpkT6ekeksw/iEu9iJXR/7wQz0tNk27vfZs+SjiU0Ihi?=
 =?us-ascii?Q?ArocALoq5GV+blUCMIbuLzmZwWtUBnlXGoR3+RDnZJRL/sRX5RJWWNxAUqeA?=
 =?us-ascii?Q?QXpFeJ09E7BFyRro1CGB/DX061YSH663i+ar1sij8qg6uRFVzIoOrFaGZocT?=
 =?us-ascii?Q?rBvcXGsUgkJcDX32mA+MpdgioVljRmjTsVKAnC12qPJTeMfFlVFDatBhPT/P?=
 =?us-ascii?Q?eNf0ZKYXXVYJ+82fPD6RWOuRTsmZGjMkdOtRvvyp9KdpDpmu0hEJXxVG2oai?=
 =?us-ascii?Q?XMkGlv1fhY+9elm92T8IDx07dDXEsfrb/5EFLO8hwhIDNg2d/wZMsycyFEso?=
 =?us-ascii?Q?l/EDBvy0H4PrQ++uOqIKDhuxgb0SQ5IVErasRV4JMX+CaM+4E4H3OPQ+SdjF?=
 =?us-ascii?Q?3YKPB2nJvGkbntiG6501EX9VNgCa9SKb8zMTHtFEZqYRh0iTXWslZK6MtBmP?=
 =?us-ascii?Q?QKyUoEoP69+DyR/F67ej2yJvQLfnnav9SBv1VJENrw9zeCyaRYAwnSzF9YUP?=
 =?us-ascii?Q?RFCiLzdGVeshpYtJ19teHjJqKRcU0Csi65RuQwPX33v91Egv3ARcSPL30Xeh?=
 =?us-ascii?Q?NwRsLDeZsEEu77XMk9XJnwWKk904178yJcBK+I7OoZBBpaoCotv09t6IbE/+?=
 =?us-ascii?Q?+Jv+NV96QW/lr03mvUDgdK+kBWbDsxlaY4EalSQiNYNspn3HDhRLyL+F5L2E?=
 =?us-ascii?Q?5QQaE1MgbH6UrCWKi4mohxWP67+8elfIV0wwWJxP9md8iwru68EJMtT1epj0?=
 =?us-ascii?Q?cC1toB97UHqHEWwKgZUFpQldVEYzK8W442r0uoR1rPVLZ4yuIJ1Dmx36+ACI?=
 =?us-ascii?Q?mjdeS5m0rp/VVcSRaZqhtAPQfWjNh0FrZnblCSeF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10828fff-14d7-4572-df0a-08db56f22f44
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:17.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naG/ht1dPYC4Pua++qrZ9sT7HtazdP+1uYUATWsJcU8ZoPyEoN/0tr8o2I5+Eg9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 12:10:48PM -0700, Florian Fainelli wrote:
> If IOMMU_CMD_LINE_DMA_API or IOMMU_CMD_LINE_STRICT are not set in
> iommu_cmd_line, we will be emitting a whitespace before the newline.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
