Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7626D26E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCaRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCaRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:45:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3356422227;
        Fri, 31 Mar 2023 10:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELkIEU2IYjwXP/M+i+BkHGRkrFwOPHPs9PTaep/iXfxZluD/ARbZLDfbIx1vkp4J67+tCItT6+7yZW+d71QQ7iQTMbFsaBcudqkFsRS426vy0LksqHwOFIgCT/Vi8HmI3SnKs7F0hk2118GOGElXY6yllIlAJQGQidNKldYPcjTxe/xUCE2x6nDL7SRO07Pi0jZX5ldegmtB6fjC0RP3Zf6MXYS3DzPG4Oiba2uqdlxO4repq7c6k3Y6IQFbus8tt5mELvNyX5b7xbODwjmFS/mr2w1jY6w4fSYPg79FjdhF/k+PJLtALG+nLFa4l3lxNGtquO6ubAEiOZI00vJ5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd9kqN4pgza0Js6gBFkoWeefwI9q/Ve6oWBpR8AxXGw=;
 b=j35pEKMW23B9ni+DuQNhjowcBFnHYrScJOFOGYTd8roF/leemCL5/nvdudS5ioHuCA4LahexhnWCuaP7glQOwvDf8rcn3g27gBeqKlyC+SOeAL/yDxZn1BGugEtTyTxQRPfE5naZ9dbxsfgQTTMu4O3IxIDryEPFPm/jRrXacgIVc6JWG5SrV0DhFDGW6vOB3SO6UZTDHpAte3BRCd+b+xdOr+UlpGtJ9+eRT6bP7MG1VYiKmoe1S9T8O7dIwkklPG5MIzHQ2XKk6bLyu+0IqTVkm3qUqZfuhK/VfBMJ+6OxJH2DmXy/YiIk4389xw1SlvKfvE6d2xC9R33BwY8Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd9kqN4pgza0Js6gBFkoWeefwI9q/Ve6oWBpR8AxXGw=;
 b=Jiv5E3GVbNntejGe2H14Ni3UcUoB/zq3mQw/0SXdb07sD4DbfZCu4sgDpa6Th+Ld+zCID5Ct1338uYX0ZyWq/WUnM5L10U6lK/w1TmMuBb0MVzGvuCsJ8aVz8fIg2p/5Y36n6Ezm0F/8eOZGcktEMvVejJ+SqSjHHZO36jJI+cDohELgYWCW6M8RZtJMaeckvWu7k6Q74RWBXoP7vsPmz3Fs/xoYJK0GoqtXcl++Nm1YPXsuTpE0ijynUH5lne6hbu2U/5MiQbOHJjcfPXIN3hYYYn57aoXdux251QdpXldyfQ4suVGLBsp35g8X8lL3VCSpa8Ny34GnS/jlIJmN9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 17:45:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 17:45:10 +0000
Date:   Fri, 31 Mar 2023 14:45:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iommufd tree
Message-ID: <ZCccJY21OgobfXwo@nvidia.com>
References: <20230331154102.1758a9ee@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331154102.1758a9ee@canb.auug.org.au>
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9c86ca-725e-49fd-091a-08db320fac85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xMKGgpSStlj5obXx1LIcy6XV9n0J+ZKHKttny6b06q3cbd9/kxbr9CGHIcI6aOXjk9ec44qT3ROl1xOZp9lHHz9uN64QNuLxZJjFSt5/zayn/r9W1s0nMTzx0OoBlUOghsBBkW3Ll/E1Yz24K5DKPf8Qwal2TrI0qg8nStjTNvXj0B0sDaDklU70PyH1Y4jFNOCQGls20Xi/0VJk7vezb01qCzMhpW4IB+lKnDXMMa/lU5HEnPPuyd6JhCyrIiL7zR1ftSGm41/eBfdFVolUOI5zWUtdjKbNzyELs+UF8AH3sx4GomAmY3EY1FHbi4GIwiQBpS4i11dcfofHpLcUbuLWeBjiyb32x29gDzEeJMUuib5xG/P7XheqeBGWfKjpzGME0UctxfvdvrB9s8dZOF0DQfRQykWSYFIQnC4zhdhKF6Woc7FILumES7ct56xOZmiP5XHxGK5fR9PeIEozHQpz/18p3b3sMzioVNgKGxULrxvc+6/QfDE2xvXXrM8k3fFRf7sbQqnhG4J50Hy4jLpamunREaygQr6xjB0u/eDs9U/6LfoAZ3XaKw0Msv6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(38100700002)(66476007)(66556008)(4326008)(66946007)(41300700001)(8676002)(6916009)(478600001)(54906003)(316002)(86362001)(6512007)(83380400001)(6506007)(186003)(2616005)(6486002)(2906002)(5660300002)(36756003)(8936002)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1u2vDABGGoPZQ3SbJzMO5QDWVeEhsIExzcIGWKxBz/2UX74hX7Zim/xdyzw?=
 =?us-ascii?Q?+VK56ksyZ5UV7RFmv+iXQ6kG+/jcbsh2LDwo5iLC2HWg10oGRkWgpvGIHpF3?=
 =?us-ascii?Q?iw9BFr30lROWy2owf/uoErsOf1hB9YV730vZpc0Qa5vAPmRxYYR+nV6rZc3A?=
 =?us-ascii?Q?0+IgyoiovsNtAbJ6rXyjTFICda+7fksaiH017pllZXiAMmzixqe14b3ezq3F?=
 =?us-ascii?Q?MkLalBMufSUt8wR4bWYhFxku0kip5zNmMlB/Svw+ZTQ9Q/kajz/QVgCEgSc4?=
 =?us-ascii?Q?zM8rGmRSFjmJ9TL+SWYMSpzdvLmohiFiExMCfLeV029/bnoluZKi5Sk3MXUF?=
 =?us-ascii?Q?E8BqrAxO07KTbVqu1R+sw9UlSyP3aMSjOWCETok0chRysIscGVOlPP8qvf42?=
 =?us-ascii?Q?fK0WaLIZ7KjGAmgpbPbNHA/HVNJSEHZbn/3r/AIlh8+Nn7lOi4KmSYgSoEcv?=
 =?us-ascii?Q?Bb1C8RI4bOvevZOLv+HJOZwM9Rv4amZ91FeBLoQDlRc0jqZPxThr0nP7FSu/?=
 =?us-ascii?Q?X3zfkox98aN17MseywhFP3RcMNTh12gsXTzypNH1y9JToM6hKWQOHgGZO6i2?=
 =?us-ascii?Q?ZO0jPFCmit/k3rG79j+GH/NdnCunIiJI1StJAjha/ieBiEx0BQZy0bFU6loy?=
 =?us-ascii?Q?v77uuBFz41353JmO1JagGnxB3fhJCkIXmvbPpcAVC/EqOPIl0jeqwdJJ7Eph?=
 =?us-ascii?Q?/2I3eSDAp0Ejw87KaQ4lXnlQfCN9Cpm5nhcmaQ3Qs40uqGWHSrPFnhdI20Ko?=
 =?us-ascii?Q?cHxUTblvt2rs/0cATxur/bkeYey+HMKtO/sfYuvblwZd6uyXlJLiuOJTzsHY?=
 =?us-ascii?Q?5uZfZr2NpQ9jFf3i2Dd/noZvkNAOZ2aFvp/pS6qNxmDr50eZQksxj8OYzOXd?=
 =?us-ascii?Q?dGVQVxAsOxnvKM6XWvQDzD+xaSvL+3zvHMDlK1ALn+2wzx4qvR1AzVqxGYtX?=
 =?us-ascii?Q?WHsYZkGo8ipvYBBNsChqsmoTiMJJeN4c8vjkYU1l+j3Tu0cGLxE6rAwm6Xka?=
 =?us-ascii?Q?h0ahC+6cGy+BWhbXpZyLqxe0zTIGLeRx3CPf60AfWHsu14P5ZaFss+n6elv4?=
 =?us-ascii?Q?2S5YyGcFppMRss6NcJkzHL2TNQZkGCggxykD+9+E0YWbFs35PNRmTRO5VQSz?=
 =?us-ascii?Q?N6Qr7GO2V3WnyKVg4bVJkSZDmGCpfz/UjDCzwZm3kwSvrOnBN1y3JisuNRhA?=
 =?us-ascii?Q?8RXiSwGat3R1tnENdG7No7eDWbgFPozFiS2wZqbYuN277YLQu1fC0pfXbJce?=
 =?us-ascii?Q?HmysM0XBQqCzKVsNpRVM4D9hrbPdQ6WuPVGW21XaBdJSJGnWh7oLBvhfNhtF?=
 =?us-ascii?Q?QKRp4FnufgdBlIMRmt58F9zFGV9d9jEiP5KldedIRUc8LJIBvkJVIZSDS1Lm?=
 =?us-ascii?Q?QG7JJLGin854qq2E5pVQQ5X2xkAamWiqB7An2lTR9AgAFmHbWpBsxILxaMAU?=
 =?us-ascii?Q?qlQP7EPaPqsNlYWm8wkyjoMJfoyMjH6EVkmz5ltRuwEIxqE9vV9Yk7aGM5Hk?=
 =?us-ascii?Q?vjiFjZLC1RBlg4B4aASzMiUEZz2X75OkdolqxSuxBeanP896t0JmCI12sGs7?=
 =?us-ascii?Q?P6BfrHNdd+Xr/vU+Z9F92BL4Mxn9JSchPzXvtBBT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9c86ca-725e-49fd-091a-08db320fac85
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 17:45:10.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aFiiyAQIsQA3n79DXlIMDM9fDnLlvTdHlm8z9oNFR/aTKabeg9SrG+ROBAvD1Jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 03:41:02PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the iommufd tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/userspace-api/iommufd:184: drivers/iommu/iommufd/device.c:613: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   e8b57a50334c ("iommufd: Add iommufd_device_replace()")

Got it, thanks

Jason 


