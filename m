Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769D5E69EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiIVRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:51:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09FF962B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7fTtQWBrsB+Yak5nTeesGqMxj1KhEI5mmXQK3jUNclX9Y6m3aeZvRuQpOEX6R9zwaW4qs+3dpS8trf2ZXS0k+O7cbVLOCGsvJWGPWQaJRfrsdv+YDTJHCTa3TibP8nDi77jxS4z3oqyQme4K6/rXcGp2mdOl2nHTmL3I6h6ptrT6ml72tVwDyMydYnXUagX9Dz5qqbUY1zmikBcTiqXMikm0UK0okfgpN7tsTCEKBmxfHNdfAtr1bNudDrVOEMCfTCJ18FRY0Pgn3ZfzexxHg05HBbfCCPdvaCPhpDmhN+srpP8GOCcPFwCqZBFeu+ocEKinkS8YC7KLL/EukhDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gc3/Dl9Zi/F2VuDvD7OEkQyvNFxK3kDdwEH9h2Bx3g=;
 b=GvqdYMpBGKdJO3q2cqIbLdhTkjKzbC6BCINurKEnhD8+wJygQ0MjxMPlsa94vGvv72FqZiF01mzW+uzYpUptFD7DrrbXyKzj1tBCBJ/55ClaAE9QdPpnWD/5TsPXay7I99oqu+ycue0S7WaDMIpHB2qjDbJWLePL9/GFVx2NUTOl44SZII4Kda04D2mI9mVjc9fDLBPP8YOYU9hFzOsWsUJROAeRKFuD0RN78dSLS8a5sz/DEL8gjg0QFHOrHXsGhCoYKAgUJNFPdWKe4WSDxDyJtDEw4EnmWMmC8h5APaTMeQjKWCEFkRnpnHMtufignGnNyQ5SW/Ym44VN1FXeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gc3/Dl9Zi/F2VuDvD7OEkQyvNFxK3kDdwEH9h2Bx3g=;
 b=Lkx25gzasBvgV6Xmr0ihDlPb5MoSjd9j4kIlv9MLpPXOdaSwpf4s1lBU1QzWgHugbSy8GPtqRWYqxsA2xgDWgVSguQYwxeEK4OqUnmTJDgV3g2LzbyOajT7vfRdNOghT/r9o5rWKl6NeNLl45KQ1ZRa8SA5N0mcgwdxA1AgMz8GjIGM0SIzKaW5E9za2rtinvUMlKwEfyLHihXPoV/9LP2n2E4uLuPGaH1xX2+IIwECVhBWJ/DFW6xhbymxdfDFeitjy/9427ts3qN/9iGlX6aUmItmvQstbBQkW6nGLQDsDXCz/2unTsfvFl/cbXM3leLgv6t7q6TwrF+/E+D7UFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:51:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:51:22 +0000
Date:   Thu, 22 Sep 2022 14:51:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, matthias.bgg@gmail.com,
        jean-philippe@linaro.org, kevin.tian@intel.com,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 6/6] iommu: Propagate return value in ->attach_dev
 callback functions
Message-ID: <YyygmTZfa9ZJJ4Mx@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <8040df414a1d4bc007a25553b8341acf37ead670.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8040df414a1d4bc007a25553b8341acf37ead670.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d77cde-89ab-4929-edea-08da9cc30f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiwSxppvAszd1JDpo86xgT5DZPxRSmknVk6Zj3UZ3VS3sfvzEivY8j3OQ1sgUE16Ny9Lv9u2qOQfVHalW799GtjYkBj4hx0xgIqiUgxEC+tk1tI3dyBX8aiLOtOQudC1HGo/i0mg62reWiGNvqXi+GZeEtqTsm/jGR3tfqFUZdj0/52wZO+6aUe7DeQOpcakjCsUFafi8HyRzyrpAC+cLRLTak7Mrki22l7ELp6+Q9orQgA7DR0UAjCO8jytmrMDA1FH33mXReVPuV5rIxAZyNMAO4u2VcyQZwXS5kr0Qx629tcsaU6T1Z/didya9Mls+S2DUPbyvS9YJRCBCJN8Dbt/mtpmPN4Q9uoG709e753a7fa3kztm6KqWNkkok9+ITREFvfUJUznL2j2yIWuMPw0uCwY1YoJ2FTb3off7KxbL9i+vHUP28E/bt2igLitd1QpfkBjJ0ofCSqfsCjF9HQoGZYOVeJUyii1NtMyHyVkBEZmtvy1i4HgpOx5eyXO1sFoSHz4RjBI3I2e1iL+fVhE5crvNXA5g9IctK+NTWsq62rf21OOYwHyvUzSWeKFd4WMtrNipoua5Z2iojbgHaS/BBBXJjBck9YeU6dSN4rWPIjZYVKmCHdSqYMBWjIfcY6qinCFNke6QvIBdGYzswRv2mL5KfSHkgWHDIGIRtJjr4LI+y9KTeClmGxTTS1aFY0iTK3F+quyxxj/twLqwBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(38100700002)(2906002)(478600001)(41300700001)(4326008)(6636002)(7416002)(86362001)(4744005)(6486002)(5660300002)(6506007)(66476007)(316002)(36756003)(6862004)(37006003)(8676002)(2616005)(66946007)(66556008)(83380400001)(6512007)(26005)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZewODiwpv5B7M/+fFWOiz3FglXf6NmmfxPpKKDIO05y+9spZ8WyPIuH1O8LE?=
 =?us-ascii?Q?RJL+n9KGIJIO8rc34NXQvNNjcFW5yAYedmItiK8wM2gPT7p1zeysPZ34HPGh?=
 =?us-ascii?Q?Zddw0ef32F3tueo6W5jAM4b9LAXXcR3kgMVBor2noylIFZxnmhqssma4T9HY?=
 =?us-ascii?Q?WyQXqIT2ewzUeQp2iH2Vb+AcsIf3qTyqWF8P4XsreKzVbNxbnRrPxRb/pn3N?=
 =?us-ascii?Q?Ml3uSklqHpvuRPRoRZvW21z8I23+RSadPjGwP2L6ODBDg7DykpkcU1j0w0d+?=
 =?us-ascii?Q?CGSdJVPW90srazMQM96nZ5VclNLdwN70eko5YNI60CFNJ9ggLqtbVVceqsyD?=
 =?us-ascii?Q?wULO8bBwuT39n3qwbOyfMVcWJfj4X6r7qEVhuoJekSSWixvfkQSR7luiNlj1?=
 =?us-ascii?Q?xZszN3OW04GLLCaxoIPb7ZyPoxPvijMcYNLunzxFby48j2GIAEVXVDivetzy?=
 =?us-ascii?Q?CIDZr5q/zl8o+sgC16lvUNk+GNPDclkbX3LXp9RvihKVKnMV18VkGBtuKuod?=
 =?us-ascii?Q?8l3ywyRZEhGsjI5cJ0rhkShHLZDue8MszVPdvr9IzkyusF3wySeXkJVnNFDX?=
 =?us-ascii?Q?IOtU0hIiefzdMVgxSvXChd7XgsnY/QnVTgcpJHiwddzhC6iFCpWAepDoNVI6?=
 =?us-ascii?Q?2wJ7bwOywXEgLEJSNw/4HmSuUdHJ0wqxJi72BMg9n+y6OJ0MhgzmVBfIL7dQ?=
 =?us-ascii?Q?FyDDVPqPYBDH7cNiJuBD6yV5nKf/VHCL8OwScyoCIeSdywSfbVfMCQ85NlxV?=
 =?us-ascii?Q?6vLbSnHX/22Rv18Zf9eKAMt69f+0niXmF1XWGUuq/5BvPqMMzMfbGlQ56bfe?=
 =?us-ascii?Q?QGwfeu/gmFj4YWMLiWDhL08Bn9FRKX/olI7/OxEc0XDNKTFJe0ewBEu0+y7X?=
 =?us-ascii?Q?oacTfWf7j9wZdU0qSI8MkFeAjbbfNev8DD00vSm6lIO3qDu+hepcV43FNRs5?=
 =?us-ascii?Q?7srRCrVeM3rsX+LJTxgBmnIjC5Tg2RioaDwJo0biqNTNNeO+B5eYiT9djIOw?=
 =?us-ascii?Q?eJyIVi1HU/ZjYVowbqKd3xP+3fM5l7tw1rP0hLDkzhhs3DtDdLEjfsERLv3M?=
 =?us-ascii?Q?9n6AFhXMJssqfpThs9PXSJ7eBWK5YAivBE1rQSdlESY7CdPMpQXedKTT5d8J?=
 =?us-ascii?Q?UV68GfnCTzBxDpW0cOU9djSLmvqHhJFWazOMynkr3KKcZZMYOh0O+XiNYIVN?=
 =?us-ascii?Q?H758qWqo+IVuqDk4ZJVoJCzMocZ0gQId+dAEy+mIMxWgZnmVRxzcDbydfU4e?=
 =?us-ascii?Q?5nDQ6axvYxN1IFZ9cQWEBD8vvYpzF4FRQfTFXNR/zG2sKY9HiasdGm4OC36m?=
 =?us-ascii?Q?aPpVW7A4zOVWrDQL5ddtfmX2XoVyalle+S2jBPbcQdV7UCSwTlAMdAq+03bI?=
 =?us-ascii?Q?KGQDXYua3gt0HQoO7cRWTNERUXLKVM14EIu3ufbOdk3j5pMkPSkSwwb4ZUMR?=
 =?us-ascii?Q?CyipyWQB5BJEVV47174nzh39HVyFxye+QPKZF6V0K1y8+t7xwvQo98XolkAs?=
 =?us-ascii?Q?KH3RKT97Slc8wAlleNVNviAn9kGdLe+euDc4683T5DPlH+PYr+7wQc4TzNdJ?=
 =?us-ascii?Q?BnxbXdX/zZYMR9OJFSPPHqMCopJrotRuFhcxsd6E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d77cde-89ab-4929-edea-08da9cc30f84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:51:22.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZbHx5KEHGnVUi+mumBvc5t64pahvzK5c9quJruU6L9O8zUj4IFGC0BK8G636Cf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:54:45AM -0700, Nicolin Chen wrote:
> The mtk_iommu and virtio drivers have places in the ->attach_dev callback
> functions that return hardcode errnos instead of the returned values, but
> callers of these ->attach_dv callback functions may care. Propagate them
> directly without the extra conversions.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 2 +-
>  drivers/iommu/virtio-iommu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
