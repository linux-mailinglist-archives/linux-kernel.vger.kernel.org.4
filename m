Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC66408A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiLBOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLBOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:43:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07AD2FA40;
        Fri,  2 Dec 2022 06:42:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJL/BN7gb3hf9Bl++loOznSKm34CoP6cOKVJzwoxSMm9p3cTkkl+PpSNQ6PQzX5x+Mun6O5Hy2pwThOwkq1xiz9oVHTOozPBiXDyd/u60+YdegW5sHvdXhjE7/OhwzEPfCUayEmuIpBicq1u5Ibnd4S94uxvG1VEd3sApXzyOzWcxoUba+wzn+nprdgnrhjmEjUc3mB+NUum7A9mNVCBd9ETG1iM2Z8WzJSwg6YcEYDCGA4cRZJLOAr5XN0HC/DEQd8AZA7n7y5DcZERHJaJPeaA+lvdcStzKL7OyLQiMnW/GbN6kR4UqTuwBTln9rlBvBUykeI7PwXZrECKihZ55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfiJSV1PJmQgsZc04/yh31/avuce7LcHbapf6BU+I+o=;
 b=fPLO4rrhZgOkF4CKVvg5Yo1yffN8gKZi7rgt62UzsrMj9rcNxCxuvtPQ6GhpJmISXbuwR2Teiqf2fOK/8Id5l3NK7iiOnWaaNiBAZOeRZ60t9pvLr/bmdUCUEPjLlEq+jBp+Gje/G0qtj750UAcshJC/mdHX1WpkkOnq+MyXy5U8hH2y0O693180T8YGpIupdJqrqXLgI11+uHnGPZeOxeSDBwMHUBoe3bajq3lLFWxiqtToSL0l0WwxJJewad+SooCq2X5U1I3NntXblEsYk9Xfz/rELwOhOdDFi/lGEj3cVsERXX/vRjPODF1EHeQjBQi4NnhQqCgPcQMr9a8IQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfiJSV1PJmQgsZc04/yh31/avuce7LcHbapf6BU+I+o=;
 b=Cncc87TKYnk0Ay3bfnx3KLinKnIeg3r3m7qU5B8r/IuQYuau4nQIH9ZWr5kvy7HEn88RMbkaUt1q3Q631J2vNxKO3XipmpiXaxiD92Jus4V4IsF0uOXINwzhz2G70jDJcuTo6t0yA7m1baY+qsKlLNYv1WS9lybLv/BhyM6eSoTfsmx6utO9Th8mWQFHGoj9Kwpkt6Tnt65mhRBn0av6zhXSFOTj6+aSuPjUW17ER0TTLKSLRjaaEqQn9IG0/cGUGaKNOhXCOSizV8AdJy/dIH0BzxjC/H15hYZSPiVsDhownsGaYd/taEAE7FG2oLxbgahBOZktPl6/y0mJ6pxpxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 14:42:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 14:42:58 +0000
Date:   Fri, 2 Dec 2022 10:42:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
Message-ID: <Y4oO8O4wCnWAeoGS@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-8-schnelle@linux.ibm.com>
 <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
 <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
 <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
 <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
 <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:208:237::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dc841b-29c7-4422-374f-08dad473815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRvlDo/fLirDjt0YMbvg+ZMuVjYLimhMcK0JEWwwzRiaWs1BzxDZ/O6qRLEiZFQOTLb+fMXZIrgobiAHKEoVLDU8Kh2wh0Xx3qsndkix3QHtLe7RcUNtK5NryG9VJVKzbEQhweOQKyA+0QBvw7YFVWJbWCLSCl21t7FFS58cBR2hj6UrfdVdM4E/rVbh48gytTY3hSJAKugu5zGwVKJb2RW8P5uhGxdDFXnwa4/X7ysy98LFss9iFgv4+///R1zhFePJKIKXU7g6WOWxdzPE1hqhlgaMB4/LEQkrylEv/6pEjzCw4KSvdLU3OTnpXH/9VLMvYjLV/VIxwqmfQBo0VvRj0O8qPFC04t8YlLUG4MesKgpyc7LrUm5kqyzfikahrVFj7xBYoIKNktJaML6ATutAXViJeXJw2gxyvkhARp/T18xJXdXs7gSEGfDCWzstg0PcxlzTkpUD4FZNKg6r5omSz+yjoFi3yGP+Qkk4NmJZ+k8TOaqK2lM1ujcLBabkS8qXthGfcOF3uYVlPlNBHnhMJxyr3C+UUN45M3wnQQ53Ws4jj8+/gTsFzZcqu2hcHmQr0oIX09Rv9rLIsnIG42Hh2rezqWQDbLtTzopJAjgb7gnqScMyLojF98dJa+SLkr/A2w6Bah4K4YtQSGLDaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(38100700002)(6506007)(86362001)(6916009)(2906002)(54906003)(8936002)(6512007)(316002)(26005)(186003)(36756003)(41300700001)(4326008)(8676002)(66946007)(66476007)(6486002)(66556008)(4744005)(7416002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9W5hpTeNnO0ochUX0Dp2p3ZptyS/aQn8rjXSBQgVCgbEwAnWF2+aHls1jU/i?=
 =?us-ascii?Q?NC3Q94DcpNT2YGmvv2UBR6Rxg19eNG3BpMZmzYlnD+oE0g02JLv2mq7139YM?=
 =?us-ascii?Q?p6I9n5r8aL4bnY2upH2N5gm6EFnvizo1lk7LYxrNKkk2pdHitkTRRop8WdKd?=
 =?us-ascii?Q?alq94pmxszlcbHTH0b0JcU2M0w+yk1jgQjvchMo4iP6zV+ZDnWm+sWeFto9p?=
 =?us-ascii?Q?b9xLlSbDaCnieN94/d4IzwYk7YnOWBPnu7Dz7nzXBRzND5JkQwTMM698IWRu?=
 =?us-ascii?Q?5tvNtEaEx0u0+butU8SC9xtbQ4BWUuziAsrH9UharAoeo5CF9w4hpFyR/qrR?=
 =?us-ascii?Q?S92IuPUmU6vqLJnjIKdgf0QR658tDoQgL/3RCNizLvtvBRBC5/93g71V2BJR?=
 =?us-ascii?Q?/eOahXtC2AKlcmyVH3Xa70TKi9feOdIb60s6D4XjtE3nyOYXJy7PmqDcJ+ju?=
 =?us-ascii?Q?mD171/qCvhHYCcfDioe8GwKaIXaM1WRhdDbxoL2/ruxIjrpj8crP1OAHDfw9?=
 =?us-ascii?Q?1/cU3Rq9ZdcQniJ4kb5nNbCc3qljExhCd9fPd+saFfHYFokL5e4M9RYWzv6Z?=
 =?us-ascii?Q?11M5j0+S9kOIx+I2nce9TcV9CTtuz1lKk05ypjXCpMuLHbseTLvQ8BHKW6sW?=
 =?us-ascii?Q?fNyBHO4mOWqav1+AnjtjZzg8+p3CpdNrJxLxf6v76VHJTeFTv7wW8HwXPIHF?=
 =?us-ascii?Q?mbDX/PcMEG2CqAbo1A6lNOCsOM967htOci6Cgo8q9/XdTUmgyTD/aUiMJ08n?=
 =?us-ascii?Q?zQVWHc8ChBuOfA/2dLsd/Lp/Hveu8hsInB8wwzeEn3QbM6LpG09D1VD1YZTe?=
 =?us-ascii?Q?QRTyS59Qzahw74oug5EN3949UK8SNsgrgcSPcelcfoDSPkHvCyHrSr67QwbJ?=
 =?us-ascii?Q?gwfg2lc2/vpx9H5v+gU9hmpMBaFbJMyQPQM5cSI1eysTVFPmRljsfVrHK0oB?=
 =?us-ascii?Q?EGy+8kGSI6S2ipVZPkEk7nN/4n5SwH81KP1NWE8eh+pchFRl2O/to9Y8WGg4?=
 =?us-ascii?Q?v74usGVY1RJ2cqd33t1PMC2CsY9+Vnl0iNnU/V6bqatWRqq9sp1+8MyN+NwA?=
 =?us-ascii?Q?2ZiLM0VZUTaABRApZafZa7zF+Gc+eCzDGfwkyktwav6vQUinA6aRo6wQjKQF?=
 =?us-ascii?Q?R6KcezoG691gbNxLHSUspmlPzj0/IJaAjlI0ZLSBU13CCgAjVN2r/tkE5Mnq?=
 =?us-ascii?Q?NmBHaByOyY4l7J5MYKkgqhzpakrDpXGZjYHbgVKOIvWLR+uXdc/7nUfAKS4c?=
 =?us-ascii?Q?hgjEJhnwbRHqTpsvvUjhuoSK3nkdjzprldCczy8lFKG8v6LErDxjrSbdejhW?=
 =?us-ascii?Q?yfMu7nNZySJXwkXwLzLdXDNyczJmakACJuuCLltHAJdlzaAS7aJBfKU4/jhp?=
 =?us-ascii?Q?LqIk9tT6S2OGRaeVzjzcffttdo+RdKnFZ63O218afm9t/Z/AjyAZU1Qz/U/5?=
 =?us-ascii?Q?npJFJULT8v/qUvyJn5VFyuIJHzXo3k5t6EvMTiQtIxryVx9QGlN2LWuI46sa?=
 =?us-ascii?Q?2sHLgnoQPhytDLWEjOSs8/wLS4TIQen9E+Eqq2+R91h4mIdq7H2wG2MZflLT?=
 =?us-ascii?Q?LY7skx7rpYvWNktmKH0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc841b-29c7-4422-374f-08dad473815c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 14:42:58.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf7IPjqcovdS9cke59wZAkAZWS52osUsBtGqcshoHc26MVsYI5E5ghvi1kQckLCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:29:50PM +0100, Niklas Schnelle wrote:

> @Robin @Joerg, if you are open to changing .iotlb_sync_map such that it
> can return and error and then failing the mapping operation I think
> this is a great approach. One advantage over the previous approach of
> flushing the queue isthat this should work for the pure IOMMU API too.

I think it is pretty important that the "pure" IOMMU API work with
whatever your solution its, the iommu_domain implementation in a
driver should not be sensitive to if the dma-iommu.c is operating the
domain or something else.

Jason
