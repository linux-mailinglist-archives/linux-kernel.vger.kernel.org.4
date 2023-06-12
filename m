Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3001672CDB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjFLSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFLSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:17:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D493
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLwZICj7BJACya9ep42/ifRKBKA6DwT3HhwqhMVnzoKOZttvST2DCl6LKSt89i1fjqUKBFzzUf1Mamam+bDkHBPH1QnMUtYX8JXqWII9nPGKLeovVxcJGItgvWgu+sxi/4PdKq9Xu5Ak8E1JH/rDcXAGvjeDFEH6bAZMvWNkmaCEibCWz77ktA+ZmIF+GSA5zNlKhFNuaSDpCF8cX1zXGOp8gwdjBhFvOeaQqbUTphcp1TNl0x5nNsSeEw/GNLL2NWGCMydQ/kX25BnlkYinXjDlLQvCxrQPlZ6F2btpl8N3K/TVXOi2NN2yWtj5glmSh4t1G6helLz6PgQ3k9asuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mbWK7YS4l6xhoBi4zQtC3RqBFNGLtQ1Z4SuGXLd0A0=;
 b=Beu61JGN6K5fSRjWNmnMi4l5YM5pkSoW+ael9QbYMYL9oiZIuIXcDJFFI8icq3zS44/82V9qs0uDfVaWkiiLQLaDMqYIT1avntH5mfU+udhXhVy9C5eF79uUGj15awXJK/13CJElbCeHoVL5cyRDdMQC21SXFUVo0mqpEk3rrE+hJVSBv+27Go28SBFyLqPNBcUkHrxcBMnNYWAuWH0Afa6Y9bhvHc+qwsUqYZbSzB6VmOL2fUlpgr3qTn6TJrkcdQ7PaaSBGlel2R0o86El31jvwEk9BI1bHQOppPtm6GV8gHInDwaRsRUMeeGtIPuHJI1TWz/tSEWpnocx87JIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mbWK7YS4l6xhoBi4zQtC3RqBFNGLtQ1Z4SuGXLd0A0=;
 b=d2DQj2EUaAzUMn5xhMG+8NJufZj9GyMQ+qc45SRfthUPZ7ZYdpKZp0Bzjc/TJtJXb54tpmuYwklsolBJHEiTS16s2JByc2Zbfm5+AN9hRa4GJNrpp6npKuAKe7As5ncLjn0aiwpCXIky7FmRW0IyczMuRoZhOJUkQNtdD370A6XyXtnurtEcrl9A9yTilep8l0WcbuWK4pnmpEpe2JaQJDEsOF08OaXDXOl07mAsHm/UVmf+8iGHoYvoXqV/fNJlMuQkzQZuJgh7gby7/os+8ZW0Kbybb0TtTdNqk8RVYh8WLXCeMf+mlxZ8XkjWsPoIv3a354+SYG3whVwPTBYmRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 18:17:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:17:44 +0000
Date:   Mon, 12 Jun 2023 15:17:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        vasant.hegde@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Message-ID: <ZIdhR1Z0QNTEeFJL@nvidia.com>
References: <20230608021933.856045-1-suhui@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608021933.856045-1-suhui@nfschina.com>
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f034a3a-38e8-4881-776b-08db6b715159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2n+zYi8Qf2FJXe4egg9wgFzzjwMfBl3YzR+HrA6MDCKwu4L3S3jNLH0b1WeFxPGNu3W9zUgBoObPgePBHcvmogt3+G1UsvmfOEb8+TQg4TTzxmkSZws6DB8djffwacQbePq4qY+ls9d1A5WOR1ZvnLvplx8pkQND+kjGWhE9xttyTOJsk4F5XBj9NoAxQjp4VQxVBpb+iNmOO3PbP7qbZqtmGAhXftNHLLm4xnSJT6hhQn9zs74j3kjk69u1dr1Cxd6Iqm7Jy69btcm4/CZrTPLIhNV714wrXiHasNPCKm5iRzgF9rJJ97qv+xYrIrwh3czkkMY+Y+xXr0UzkhXAj7nRU4Ackr4+aot4KOG6y9ApBrOaJDJGprv5O9r4jWfG05T1QLkrlQWLYSWE+JHtBcdH+HpPSkAYvN3ybmC4F+IP3YfOOmVbFPjCkqIW3ylUhm6daeSPRQitRciL1S00XV2nLWHhK1DxlLTFRisDJYbPpCpDWIOQRlInKyLtacqP4PEh+f4kiObb1tbiEWlAEI6vHHAIlbMnlmRM1v6FhaM9xEW6HN2E82lKjwvJxsvy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(86362001)(6486002)(316002)(8676002)(41300700001)(83380400001)(5660300002)(26005)(6512007)(38100700002)(6506007)(8936002)(66476007)(36756003)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(4744005)(2906002)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zg6zNioW8N5U1l5brxvv0svF/JkUdeOFo9c0wMQY+pMbvT/2Hky/xdATd7wV?=
 =?us-ascii?Q?Gf2ovf3Nt2HTmM0sTny3md/nb0JaBTVOmtO+2XXck7okL+shdyjyNpw6PbKL?=
 =?us-ascii?Q?RfC55EJ3YGrvvtAGPANP3aO6xrz1c6VyEByOZyfmZ+Q2yEC9zqA1S+QygCyT?=
 =?us-ascii?Q?4qVjOxtjBNhOHz+vOy5yXTnqsAo7JYn3g2k7IY0oUV8wUEdxSPz7TKA+OHFG?=
 =?us-ascii?Q?ptt3wk1cVMKtOcswDu37bJNBhDBIgEM9QgbgELIqpbB8ikoT1AelkNm7DJVx?=
 =?us-ascii?Q?Ri/Gehf2y3zDLylFH2ElDlTBu7E982HaMTzorpCMZdaVqwWQeGMn3FhSqORZ?=
 =?us-ascii?Q?0KdS2bFOpr2CoQs+bWNSTGY4+6F3P2H0N0KJ8e3oTTQYO8jBBW/Z9huy3o/s?=
 =?us-ascii?Q?SDgSBgUpaiNLnQe6xsTiyDf3pRYKIpOdoZI6q8YQMfixhLx2mkJS4B0BgiMZ?=
 =?us-ascii?Q?/363xOIUmHtBu3AlGr2DUo3+2qLNlhJsP+axHaKmHakoBZEDxHoP/U5QfGRO?=
 =?us-ascii?Q?uzJ2FIY7jxW5f/ecRX9+hzHQuk0ngDx11R0PKFJaGR4lr2v8D1Q6YM2qNPIg?=
 =?us-ascii?Q?RjiYb6o2ANPCvdBptQmv4UYJgJt1OWGa4oLqyRFjKXkenKE9x62Vq1fYdOIM?=
 =?us-ascii?Q?z0JthDlVwbT2uyvMYJZLFHEtmMMePUPOYNaSr86yPMeC2x47hxgfF+KLfzuv?=
 =?us-ascii?Q?4L99ZGeJFosg7aUXZNnYvP0u45DzPcrxUhk8JW0tHgVD+TgmV9FwsE1TW7JJ?=
 =?us-ascii?Q?N1TeqQhuwvw/gy6K/yOL/EwsT3gWfj/UH3P/+0uqInVkDCnMZa7p2Mxs6foC?=
 =?us-ascii?Q?YmSZDRVze3TBFLauPmletMLIy1XgQ7GEAk/i1W0eqxJG2PyWa1zz0gwdsDit?=
 =?us-ascii?Q?/Wc5BX5DjJ+QLlB8izQDijJAsVjqgyCpM93AW4ZaJXpiJIl8J+6bmVr0ZaVx?=
 =?us-ascii?Q?tzUSMbFWbMapxDIMF1bmhqSKLHc309L/FjSlB24M8AMbN/H3Jv4CaXPPVjUY?=
 =?us-ascii?Q?Ccn5eS8hYfDAticeo4TBFzi4q9FpN2XN5h36W7SULoAYWEoupT8MV90FSaDY?=
 =?us-ascii?Q?Onvr7X/0ntvoOVMEkjyE5N6myd/2KokRuU2dhXynI8khHsQtjKH4PlJB2II/?=
 =?us-ascii?Q?QxLCdm7K0YySaDqLnR9P1Givcocrli2RnrvXbATmYvucHYsbL7TfbnC73pZ3?=
 =?us-ascii?Q?0HNs/KRcHlefljQyHBK7kym7enp6FZx10Pbyr5XKQCG5UEN9TCPZijIfAMhi?=
 =?us-ascii?Q?RbhAnFq8d+/4iVOOxCCTYvJB6PUFFG0n8pdSscvZG3NMYv+l4EmotVyka/Qh?=
 =?us-ascii?Q?uEeN1rVxG4EJJSByUH9LJ3XNT5kaQzaigNWkwOXv0V5RSjFQ3YnUqRrl7ioA?=
 =?us-ascii?Q?UUfzW893R6nAui5WCR/2cz3d7HDqYei09Rl0vIZb/HXsz5NRnmyQT+DqDtv9?=
 =?us-ascii?Q?FEYxXnn9oTzyqDyTYH9YEeiFu4Gr5JIHg19sNXGzLclc1/lUVHheOMBKlUKD?=
 =?us-ascii?Q?EpqrS6gFR4HJl5DniB2X5v1g3SPY/Vvy8sjVNFIajNGAN+HmPOaysCSi+1ML?=
 =?us-ascii?Q?2K7jt3zwzbscKSZVBvT2azoFH94wa3bxO0GJE4Sr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f034a3a-38e8-4881-776b-08db6b715159
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:17:44.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH22pg5frCHSB77g9WTfjeHl6WB2VZN+WHL1Jl7cBQyRRprL8h7qpzxT9VAO9bcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:19:34AM +0800, Su Hui wrote:
> Move allocation code down to avoid memory leak.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> Changes in v2:
> 	change code order is better and more consistent with other
> drivers. 
>  drivers/iommu/amd/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
