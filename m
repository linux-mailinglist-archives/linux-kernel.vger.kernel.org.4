Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310A6B33A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCJBcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJBcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:32:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3010113C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:32:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evAJcHPI0kzO15B6xLHtZb92bD6qrFZ8o2TZPoo+tjxIoOxes2nVL/xCO0d5X3XWsmqd2He+agPYZPRjBIl5wvvHar/m4+ojNhIYOVVMtT7uxLblVHtkiQWmvb7N3KXxjhjW0wejg/yot6IDg7ysjOVMR4pHsf6GIsXdHun8pi5JVdPc0C3DEKL/exJ0Z/7QbJ/DbJKvdX96SYMu9/M3tgFbSqwKVKnqMiaXNlfRR7Z3iHyE4dX/Oxc1NbTQCD+4yOOWU7WjX0GyYy+eqRwQxk60JRSdA/yiKMTF+zzwUfsQV3J/SBsyWrnK+jrVPlFitsRZS9ZCX+cebdWDZKrDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBiJK0Q4ak7jmSon9tjjOxdc4xTusRHKFa7c5n2VFYY=;
 b=BtoJ1JBQAIf6Xi//EC03isbgcP2LPGmUryOnPfwTRdckqGf45+i5ZPUgP6+/SX/n8sswIANj6AoB04JMRyRumqw4aqA5CqcN5Hvcg4DA8P3Jb5wFOAcIleBemQPe7wh8shvSzmrVPxPfu/7PYZYSDObflmfUWH9BddyYtekjY4O58exUrA0HOWy/ZlECjYN5pVTmbfMwri8GkzCW3zmubhFCcj7s4c0/znBTUrL8BRjL67oijlPygFmGd1tWIcZsmmNooJ02yKywqLUXxeCp/7MW/2xaRxhxOSyeX4eupRZT0VryMNOkFantAMrlnl2UOQsl43ANj8Wc+ePUVsCH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBiJK0Q4ak7jmSon9tjjOxdc4xTusRHKFa7c5n2VFYY=;
 b=AQDWcPfUE0RC6QqPmvg+xgQ87D3Q664g9di+i5fYT1anM/Wa7UWicDPMzS2dhEYhGk8x+uS52GSgV5fdKh8CsADenk4nIB2n0xTH6m6Q4wYXldkYxFOth5j2mBEcIQiFLrFwmG2NHA7xZ+wZW9vbHqUz+P41qOpIw4xX6Ns2zX6ESo2d3Ah8D2lSg0wkvviK/o3PgeTCbsBsHGlw7odJNJGNObjpHuuZtwLRvH90lPMmvVU7XAw6nGQ3t+8dv3OZ68g/85unkr9PWiSq5MOKBsdYGIvpz/pJ8WgeRpsxM3XsaA5PQvGhNPglYjETdHPc6952/j8fWWCI2lmRrTdjNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:32:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:32:11 +0000
Date:   Thu, 9 Mar 2023 21:32:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iommu: Extend changing default domain to normal
 group
Message-ID: <ZAqImOaQLMuWXhsv@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 81039d8c-2590-4da8-32fd-08db21074555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 249Yol0TEOub9Nnij/BlWLUPqDGc4mg77qvstKFkclpyI/W6wW7FeuLErCF+SwUZ7iNzZLVFUBmUVt/qGpDXOq5BD35+zQk9c6R4w3Wk0sgtU3dzNMDnwY5r8KKezKzSny38Izm+PedfzqDUIv1NQlGBA94ixHdWXUGH/Ck1iHio2FxxVmSf9nKOg1LHejAnENbBrhA4F9EPj/tYwhJdfq0PZr+klsYsMmVcJ06uDmYbu4zqK95vMMlK5+fCIBR9MtGK63pLy9oVgvrw7SvL0/Ygk89Yd+xcsyg4qSQGN/XJH0pNJWnDzM3RYyjQ0hHAS5jrOU1v/MFhnOH7ll+xflDuXQLjKH6FEGzeJ4mOsz8O16LoUH+5WbkHQ+LcluQM42SD0oivANwy2jTlH3LPiNI1ye0Jss93dXYTzV6JIfdanC5RtbtnHtypYhhMXUPBB4yyI+ZplL0UEX9C4k1cD8+DX1ydzvbVHIHV8apgZGV3GSEp3o/Oc8YFeLS2C6109nG29GDXcLPDSiDIpVfrqK3eEsnyBuf0lveE9p16xdNOq+TIzTpWk8NTUYob+jdL/+TD5iaoIY+Dls9kpHdakTV2oN1vqcAPKPxoPeYL13oR0sCRNltyvQ8IVfni8Fny0YdZMBWktXP4uEj8vYw6KXRENNA6niQC8nfMFvoRLKVSzsW8Lo5sE3zePJlZgmuX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(84040400005)(451199018)(83380400001)(36756003)(54906003)(110136005)(478600001)(316002)(38100700002)(6486002)(2616005)(966005)(6666004)(6506007)(6512007)(186003)(26005)(41300700001)(5660300002)(8676002)(66476007)(66946007)(66556008)(2906002)(8936002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2ie2KWD1rj4PIyqALRJrI+PKZSYWHF4N3s44m8ymqkWHT7ejydsjksyBQNz?=
 =?us-ascii?Q?6KA4YpvWmWywyj1KGFdishVs8x5bXAxEwQjEjliw2Lxm61rx/Ym7d8/R1BuT?=
 =?us-ascii?Q?9KFhH2l4GSktsZngKuWkji9jyfFT1zeozAf8n0E9GeCWXvfMe4qglzH41dtL?=
 =?us-ascii?Q?3Wzz5zC7S9JsoaWFglvmiUVJRvheS4pEPqKe1a7uovXkiZhFUnX14Mau9Ja7?=
 =?us-ascii?Q?5oag8mNqTsI75+Z8lAXBLdNh63hcCGmcBUlXUCCKAu6p4tIKbcNJ67+elVzy?=
 =?us-ascii?Q?K9U9DL5XNGWJpOn4GXRELuUnb8bvV3nND7O6+D16JKCBsl6fJ8W+H1Btyw0K?=
 =?us-ascii?Q?nLiKYPQ4NkBxJ9dIPNEhdqxdLSwtplIv1nuIsXehcMT55NyvndYdwkIEfI3p?=
 =?us-ascii?Q?ab4Xz/QHsX0+eE6p3MoNNf82ShtPdbbCE/eMoApjtN86o6IESluF9eK5iza8?=
 =?us-ascii?Q?C3/fR+XlXSOLt6dBScsQW4MVGcuehYUs3bLFEw7Q3bZSW+0+/ZctU0yfNI1y?=
 =?us-ascii?Q?RmI95TJH053ZL8Bo0eprlEubK7pqugOIChMPskIXNhyyNIV2hyyhMQYKRU3Y?=
 =?us-ascii?Q?3hQNLcaqAGAvhMc/GNDJE30Cbl3IV8VzW5ntgi3+GnW6VIQOxb6DIpt4Ux11?=
 =?us-ascii?Q?VWCk2d2KiVahem+UyUZs9yczWAXIHRZ8FOQVQcH3+qIHjrv3vGSBYpBCptDp?=
 =?us-ascii?Q?W85036MoinJuGAwmHaqc8OWh6UhG6hWKTMZepgFhAP8880A2kKQ2XbXqLZ/7?=
 =?us-ascii?Q?njMmGuWpdZz2MaNZMf6fBXaKoJ+UW9f2GOGGKJsXJpHxYiCe5UCOmnyuSz1v?=
 =?us-ascii?Q?LypRp3Jfy9jORxw6CNwaGyH2Zqo1POxX+rEV9Y3GvmjApcSrzd6IyoDfAWxc?=
 =?us-ascii?Q?FO+pDg99Cl6RNLXzOIP/TJfwcQKeG7rD5Q0kM3O0pe67NfgjR7pDmtKvH59v?=
 =?us-ascii?Q?4/g8GoZ8TonM4a8nPECE/v0R4qBCPnXrLuzfDrWrGxYtuAlK/e7ZWp1ogENg?=
 =?us-ascii?Q?GPlFQ0hcEZh2h0Cr6UEtcErbmiM5ZaN2A2XPNLhsAdZvgPHdhKapK9NZA1Ii?=
 =?us-ascii?Q?B9wZJM4F9n0yA5e3QpAiXZ9bfdHcw9Zo2CK32B7oeE5uwz7F9oXuWcu+Pz7h?=
 =?us-ascii?Q?Nc4WH2o4wJAvGbVHwiAwh9AAE8J7+CtpyUmwOU49Y+4TLuJr+22iDHpBOGQx?=
 =?us-ascii?Q?BWuUu890C2SZ3VBIzbCTfwLUms4HOzU7CD1Tk72viHZBnce8b7okIF68Edmz?=
 =?us-ascii?Q?ap5F5DLlEq1LwoOfD5aXDVp6W89rlXofMPX9RL3d63SOPGi49gPE3O3v9DIB?=
 =?us-ascii?Q?LhGnilpwPsZQ2Yw1YovHhBQvKSwK0k8wlRIe2qIpQRE8aP+MfgZglOOjrysa?=
 =?us-ascii?Q?FWYFwlw+H/a7iSXVfve1MoT0Y6BmPnyBr7KTNoCAYyOyerlGylBsbjVTbqr8?=
 =?us-ascii?Q?fpdlwK+uRqDVcs2gerGvHfJf3mUfymkhXqRToHQYsTSHiAm44opmfRhagmKr?=
 =?us-ascii?Q?nZXQXPZ9YO56CaKdOovtlE1SnqkQ/MjLqmdh0s+DcdyebhMNmNSEg2iuNYX8?=
 =?us-ascii?Q?S4dRGvI6Tjyt+G0egs4IL0JnUs5N8/6VHeWFc9rp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81039d8c-2590-4da8-32fd-08db21074555
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:32:11.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8FcgC4zLHqQFgCNTqnzZT7Tk/zzRooNp7tt72Uhn0Q3InXc3QE5pRvMp4YLwXxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:57:58AM +0800, Lu Baolu wrote:
> The IOMMU group sysfs interface allows users to change the default
> domain of a group. The current implementation uses device_lock() to make
> sure that the devices in the group are not bound to any driver and won't
> be bound during the process of changing the default domain. In order to
> avoid a possible deadlock caused by lock order of device_lock and
> group->mutex, it limits the functionality to singleton groups only.
> 
> The recently implemented DMA ownership framework can be applied here to
> replace device_lock(). In addition, use group->mutex to ensure that the
> iommu ops of the device are always valid during the process of changing
> default domain.
> 
> With above replacement and enhancement, the device_lock() could be
> removed and the singleton-group-only limitation could be removed.
> 
> This series is based on v6.3-rc1 with below series from Robin applied,
> https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/

Joerg can you help Lu with patch planning here? Can we get Robin's
series, this one and a maybe few more that clash on this for the
cycle?

Should this one go before Robin's series? It didn't seem obviously
dependent beyond using the same helper function?

Thanks,
Jason
