Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7832D6B3370
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCJBCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCJBB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:01:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CB108232
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLpy0ANTDqBbf9kWLbHINNBAirQ66U4TDe9PWJblTQkauJgVSqhCyoV31+gxBugAEWaVnJkl/u2Tg/6EvkIpwUrY8vstoPvT3k9Lc06+kLmik8E+Qtzgi9qNxgyfkrPyQJi8SDMjj+RRVYspVk3gYln2YZvYVF4hPTUDzNzxO26GSn7YuEzkz0B90XiaPeZGdeLeZl6mXq8U8deOPeVQefe73SV9MxBR7ovWqVyW4SoA7PrivfiiwJkAm7MmRZNMQMkro/p+CoXu1NprAuKnyx/4vz3E/VqRRhmQ0whN/QMGBJjcLawAXiWz5RNtXhySX/wOj9rw9zE+DcQ9uTfYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/olxAEJuk9eWvfemTaIg1NFJaYyUFpMyJ6FgjPFCezU=;
 b=jlX6xUvRC9x+Egnq2WW8FGRf0+hUXoI0m4KDmjojtnOl8lkUlpcPTAoybtSeV0RbarPxh0yHRMug+4P16P2AeD6sfPLHER7i+eL85gfg+jSUpiZDkRnc3UNpEUc4YrnlArKQdMHtNKoFJOYvvxmAG0xEFrtB4agb42Pqpx8DmTBMVUNvhHg50tgrI2FMtY6CI1siB8eMoiL2XlO3mYF6N39dibHh/OOTR23h/n/TBgjQrmjYwuYwoxIJhXPnD2R8wfaS+HvZnNf+mgqWmUdifw4j9HMXQDMISOCiQeChsOOg7YcSrTTGJXZIbOQMrcEDZRvJZtmDSKmi/RocmE4aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/olxAEJuk9eWvfemTaIg1NFJaYyUFpMyJ6FgjPFCezU=;
 b=lPKqbibc2M4DYeu2Y7ZeMoXxEqHlDdMoQbd+/DSQXdsilN9LpK4mdYqKCAPnvxEScEMpR7NCMF0himTcVi6mHWj6oqcAtRY/JaVucfA1kkuxWIt06tepggPcAxy65M4qcK1N211Rw7TG3IpqgbI3mfOyHvTVaTSVden6QKBvUHUnVKXBGq2O7fs8ugOd6AtpNJCdSpyUSdBIDeD4NVaKEHXPlKEuQcGmHVd36p2hXp7udLzGJ0yaosnzGlpLrS9615ScwxhorzuMgdELyUDVpsVmB9Cow0ycmf9hVgK6YDWN7VKQtHzVnXW99NWNLdD8nCA9I0mnDDgWpRzE537WPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 01:01:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:01:52 +0000
Date:   Thu, 9 Mar 2023 21:01:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iommu: Split iommu_group_remove_device() into
 helpers
Message-ID: <ZAqBfFxVXxuI8oG0@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a992db0-f7e8-4646-18a5-08db210308e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJ/UXIM67w+Zscxkpol+5VtHb3Kz11m4Y6BlAR31lqelmndQ/saaD5ICXL1LaX6LIrLFxd10e0Dkv3Xtot5MTZHy0tLadf414oIfHxsEQ+CwDdmJIZDIXsBQbgvRNigLqW2ARB4D8zlBkjuH9dbGlzojJgtR0DFa8JXWNPemFCp3/j4seA8+ZYryk0iB43kfm28s4/PhTT6Es+p/wlLRaF9mo6BcP1omM9Ym4l5ZTC7dlT5/Ug7A/dxga2SnKajvkz/6XP95vACcGzb6yekXhwOFRwD2jo7znB4xewk5VAxQiZJE6LApNQikyyl5Be/htm7TLBPdU3FgQ4rtYBcM5HEBZAAT5Tc9UFdL++ogb8ckXEaS1W233pti4z/3AMzVs1Kg/on1Wbdax5pwZR2+aQeb1WVEHFgybOsNNG2u8GCJeTPeQ+4VIK5d+2icOPgUkEE6RfvXCo7iGLtTd0240WloAXtiX49HQgDT1fkeXj7OGKFFAVCGKGCQVKCqplS6X972fCaRGduIJyy3U76vl9u6WA7m4TW5tIZw8qdNZ3GipOa4ZQz6xGqIV7ScT9DN3nt+yTM5DYwVWnQT8SOk4NJsNPF4Wwwo59ASSQR1YoC2/ZnScuZ6du+7crHY6EiwlCgFzoXXz/8QJWYyZJ0xLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(186003)(38100700002)(2906002)(26005)(2616005)(4744005)(6506007)(6512007)(5660300002)(6666004)(8936002)(41300700001)(66476007)(6486002)(66946007)(86362001)(66556008)(8676002)(4326008)(6916009)(478600001)(316002)(83380400001)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdeiInno5cmkM+DqordbK6kO4f7JbkkoUJEf1LJd7qB7WtgHHA99VquzJzcP?=
 =?us-ascii?Q?W6FYJXFwfkwoVX/SBCUTl0MSYCleRc+eVmBLwCgbMV1/4g/G0la3B4EDyGul?=
 =?us-ascii?Q?ahFIx1kQye4LgmUWKJ+qsPy9WxWw6A81jvT0u6zizNxBcJ3YVRFKZ8KQOsM3?=
 =?us-ascii?Q?YrrEsGW9n2kthAYJBdCl6FY6V3tAkDL+VgmTTWCpywpqjpH/+CWac/Rc2ZIj?=
 =?us-ascii?Q?i3SwmeD2Clr7sg7oWVeidvccPN2cMhR0RanIfEty4AKmEceZzernH5YJ/W/u?=
 =?us-ascii?Q?TLDZ4nVHmLx0yWKoHzCH03Ax9ACQQ4GOypVAFbINk0NTjD6J2tNgAmz8y5Mt?=
 =?us-ascii?Q?0Nem55uoziFVjD36+wuYN/MZYv9YoMLljp1fDVSSvvIQAUX5709fB2creZ/Q?=
 =?us-ascii?Q?I1CgMHePxVS7THO83VPbbUor2Hchj0+TmnVr48lVV4GzTtWuKKQ0iyTxvDfN?=
 =?us-ascii?Q?aEGwLSVYtl+yHo9vtQH9oXAyq4ALDnxxPl++J/NFJlgvwcQq2IU11KVBwpGK?=
 =?us-ascii?Q?cScWbTloJHzZkZDspG+lU7odgV75xIf6At9h+OlMMgL4+T1vAms8XMrMdvXW?=
 =?us-ascii?Q?KaHEMj7bULnMw3qMkOhzVEX4vSqomITztRe+5WCdC9c8jfUq9o9T1QZ9agOu?=
 =?us-ascii?Q?gx8XF8UUj2c5IKhSnYtgywOuanf+SWYgCXNxviuL2md+A/53hMooVwsAWnZA?=
 =?us-ascii?Q?51HCThk+u6JRyNlh7vvGjLOUzocOqn/88lpNy5kmZ9P3KO07jiWETJVPVRb8?=
 =?us-ascii?Q?6xmhBb488YgfHKeZ3lA+G3Bq/XkY6/dNpD5uZY2o1JmOdSuLYJ8JQ0Qq1+Hx?=
 =?us-ascii?Q?LF18llQ/r5fhTZemszboXlqH1rfOQdR8h7KJWy4MEImVYxjen4KReEjYZ7St?=
 =?us-ascii?Q?e1ydQ8Kn2O2twRiK8V+lEyJhIwK5TVk3Ov93BWGnNDhh02NSX+ZqlMxMJpLY?=
 =?us-ascii?Q?xM48a3DtHHJdXNVj2A2knVYQH+zIr5peyK75f7P/eWQoxOur8eZWD832JMDJ?=
 =?us-ascii?Q?MxdHAxCdByQXmvhCY4X9uXlajosXYqzmw4nO2ktvXBcygrIabNKd+bm02efh?=
 =?us-ascii?Q?IEVFQPlNSdWFOlWmTc2t3sXMnXI6LcUeKgxmsKpXPADmBVVtKCNGBJpXUMdn?=
 =?us-ascii?Q?b62P+M2eGwPYJnTAphjL78RtD3RFERGH4hmpKxpXmLSb4qcI267ExUhx/bgn?=
 =?us-ascii?Q?kHqETv1ojtCkZcU64uOnuF6iWlroy2wyPPhOew/yVnNBxx1NYL++46Vl706I?=
 =?us-ascii?Q?7Ko2wr1MHwLrbrRs0Ny/7VLSvZP7BwEq7kIBcHD7ZZOmQ8mvqpcjTiuN0wxN?=
 =?us-ascii?Q?U94sOoR+g2hAN268senfgYLZ1HnVT6HFuIgbxHiq9c9NZnwWt01lUNK+f/55?=
 =?us-ascii?Q?YUURa849Wnfbt0/ZFwmIwfi5Cyk8e/v/99ZeaDKX63hknzySZKMpxHAhGMZq?=
 =?us-ascii?Q?Oyt7a5wQHjTnvo5Hl6ukZpKcztI++XZg9XX98+PQtdHihJdWBKRi0FwJG7WR?=
 =?us-ascii?Q?lFHX2ghFAiN14r7QJrBpHEO/LD7m6ocPJ9pMTW+1mmZvM1mnrZ1xmZ/QEEPX?=
 =?us-ascii?Q?oog/yD2L01F/ySA3phSIROAQCNCE7JyDqJeju2hW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a992db0-f7e8-4646-18a5-08db210308e2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:01:52.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yy1QEzbGowHe8W0O0V3KSkBQOmH7g6FpACDfSQ2zHp3unN5JGNBaOoDsBSa8ewp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:58:00AM +0800, Lu Baolu wrote:
> So that code could be re-used by iommu_release_device() in the subsequent
> change. No intention for functionality change.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 64 +++++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
