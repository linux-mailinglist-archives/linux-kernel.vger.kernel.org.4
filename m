Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5C65F4F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjAEUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjAEUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:06:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246D35938;
        Thu,  5 Jan 2023 12:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buqpwi7ClxCTzBwK0d2H+eKlTJb887KeJtS1XoCb7QgKr7CVnatL7pVeJOeP71x/7e62MOdS0ClvGw8V6iONYUsiaFogGdi357m8z1OB7TTSOaemRZTqJgjHVFCebE3Sri2VO7FeOppLzIMkxu72uHTtOD0aIhHqiGr+16prBEsqi2uVeNfjTWagevRsfrNRGhZc0Pl8qZbb1aTLHjj3M5ZvTBr3iWwZrp5d+AlfPH3Snqq94C73Q5HB/OmzC5sx1N8WP+ZEOsTKIQJBiEz2fUoRYz4v3d2FRKrv4/65HH0PfEkpWjgTemWwxtbMRrhq6TebGPhBFDeSt96syejTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLfeR3PNvLW38XWrcSZtW8Ck5WNdIPgA+8F1xgf3wNE=;
 b=bF3mOVRiCfkggoK+yP4ZTRvCLt0EaVQC3EvUtc2puzuuytoWGX+l0l+TyJIl2hkJ82IEoVDPMV7/dq85+whRlvJwsXDbhMIa0M3Yh9byX/Ioe1pPcDCd5t1yA9vLU9s80LcBbQ9u0I18Nbbcm1hXdvDkGYV1gSvuLDs7YitVV4/c0iuN82Slv2hdSzxieSz+v9n77AdY9c2askNP13Eq5aNlpONVDuqoYIj1ksPxwPCQ/kNt3nupBAzP8smfEmA0ZO+r3ofa7zU0dUFNwlkPs6bmXvba4VUQ8Uo5qe0Ovt1AyInXLQYHEN0L6tHx4efHXilxXDsCpF+RIE/vllKtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLfeR3PNvLW38XWrcSZtW8Ck5WNdIPgA+8F1xgf3wNE=;
 b=Ptj+vlRD4nSY2LKXbfvJhxrNvXbkegbt6Iv0aGY9l300gjJ2DDFV6/B59WwdykhYisTR620g16H7y3oX1XXXcgUCLwk9upF6kpBBaIEGWhHLEkSPZ++DWeyxtT+yB3YhXMNslDreI0ag+aLkoJ67ap/9sqRGzYrduFJ/nc9Jrvd0+9MzZXAajuUhKNY3lfzsvTMuotbXt2xc6wo0bd+TQNINFhtNuIu67Oa2gNLnci6tCJ5UMhuJkua3svKUbOFUMIQZbVv3uqj0fZUPslARiLGdcAellyk5e85Rcxzik3H3wpbN03M/43sSF0Q0hRr9A+dpHfnp9J2TPG6KtJZaLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 20:06:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:06:12 +0000
Date:   Thu, 5 Jan 2023 16:06:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, logang@deltatee.com,
        hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Message-ID: <Y7ctsw8ffhSsBZ4v@nvidia.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105112339.107969-1-yishaih@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c02daf-b08a-435b-0f88-08daef584b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FckoPDHzJwRo7OLfOm1iH6EwvH/18tk0bVmprqj91MPIonm9xyWFuFlkGyjbxQnq1lSaA5nrqc7qlS3XmKyKR8nlas7vtRzT+qm22l0UjATN3ezBWTycSxPjVxFquzvzcNaNqXqoZGR8+JbVNMak2crcYhnHlIuPzCYCHWLASUJCZDVxOOZjdPr8FnioiJ/q/7T6DSByCz1ORH7HuymJVemuKPiWsMaw9T42U67I2gnPGWrKXELi7vi68GSQxZPHsHQvk/QXXE9stceC1cN9ZpqwhPEm0nPCuw/cQgA9XcsNXnWLy52rNvyF/0/dz6IDSs98x4Zi8uVFX/wn1qfYsE/xfYowqlQq86SbqwEv6PIz4eOu9lD1jFlc3SSTr6M8gxuxGGkqVquQR18BDgSBHzdY9K6GZrOIt6q2BmJO+wkWME5L5L05QjgBaLGQylBR4tNiQIujXAmLfihWLHkuRuQkaXpnMc82VLIsXpaKv2f8z9+YFY6Idzi/WG/xyC9LFMiCMNWbp0Jn+OMFtXaOUP/BOR7nBjtUAaixddkK9TKl4kCqebiBAhlj1P2akrgczzz754a+qhY32+tE+M/BFh9YAI9PKqfJ6HmJrWr9c+x7FA9HTuJLBH8pg7E9vptzxxixZL9FnEmb5W1m/wvoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(83380400001)(86362001)(8936002)(2906002)(6862004)(38100700002)(5660300002)(41300700001)(107886003)(478600001)(186003)(8676002)(2616005)(316002)(6506007)(6512007)(66476007)(4326008)(26005)(66946007)(6486002)(66556008)(6636002)(37006003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f55CRH72kn4n85XLXG0Dl1sQpOiI7T1iBvn7e86LBAz8XP5I+2y/kFoNcQ9s?=
 =?us-ascii?Q?d1s68p4jtGhxZpaMGNSt7ibL+7k01Caq+NzEfoaoS9EBRJCkv1VBYDvimSCv?=
 =?us-ascii?Q?4xhBMBFUpZis0lG8x1qxHTto4a78ztdsMhVSRzrNtvlNwjgHk2hKqtusJXkc?=
 =?us-ascii?Q?UHaEyY9gaVj5/RPUi+1iUPrGsLM5L1OcwesxKtBR5J6YlnbHcEJa/4PMuoU7?=
 =?us-ascii?Q?a3ZjjDjhEqCPamxXQ7qDOmElIRh8mt4K+cTGkEGu2Bk4nCHeb0+pKSwP10bd?=
 =?us-ascii?Q?Nj+x97aRVKkdpDARzds2i+8QqC5QeaSjVoBbBGvIl6xc7lsqurSP6azaqt2D?=
 =?us-ascii?Q?RRVmSBN246aCbLIt6jZSBVD5PlxuCH1lJLs7dlUyXtoJA0j4+lbpaYVtMXjh?=
 =?us-ascii?Q?n3BAfj0k2YLO+oYSVOx4vHxmZI7SlZbmD+PvYXdkUQ9RpSy8SNMw9W/Xta+3?=
 =?us-ascii?Q?F8cWi6uU7TC7LLsPlG4fegK5jq3H1fTlNuJyZkABuy3cK0CV+zwFsxfzsp1d?=
 =?us-ascii?Q?yEUwZQHKLJh6iw04IAGqUuwIKdeik2+4imB8OT0WSZoXIHDKpPC2sXKtpBY/?=
 =?us-ascii?Q?vzTYEY4PP2P0fgfEsNCEgHf0E59UzLOxxaOF7UlpEwjb2OB8OJ/eZ7kq8nFf?=
 =?us-ascii?Q?S5hYiokjsw338P/IUQGXw5fDKNzBKHtNp0/gN8U8+8gNhQMPfqq/NaNdI9oj?=
 =?us-ascii?Q?c5ZEm+XDwkcNhABMrYQ4G63iYwmSDGb95V1Iw10092Xlxqoze44AyfRdPhpO?=
 =?us-ascii?Q?OB/dvaJQQGnPdzF4vAHxhNxLR4YDwLfQfctgIuvuJXZ5FCSeBtOKQvGudsei?=
 =?us-ascii?Q?10cYm4lMBHhO0YvLGDwCNsh8dHRoutAdcLuuVFQFeDg573b2xKTcDJg6wsjS?=
 =?us-ascii?Q?McTNa2SpOl1toL41YIxn07MQf3WGGxcLC3ZCAKfN+RMjCs/U9CIyj4WqBejt?=
 =?us-ascii?Q?xziKygA4Mce8T6Pk6w/2gN8dmbvLrav2ksylKI/xipiS7R86p4XCjdJWE9aY?=
 =?us-ascii?Q?hhLfWi4gbfXMoLDUDrIXLh1CXqgH3272jesChBwN8lcP5wy6ZhaItSxTlsYY?=
 =?us-ascii?Q?B3e8p1vNh1GgOvjxfk+Ts5CYFKokEn1y+jYHHZCqiDrcSiugd0uwzzkqq8FN?=
 =?us-ascii?Q?slsfHMUO7quPOhCmxLr9hgw4Vz8qVLLtelaXLfVnMLdM2VC0vWsfpIEsJyfX?=
 =?us-ascii?Q?tAOvv0hDVi05nhq3RA/8258agYuBI+T0VsMqxDwsoYlmpbMK+DNcZ2NQ2QEI?=
 =?us-ascii?Q?0y/gTO0+FvJlft63dP65I4RgwEm9MRzTwDAYz5UDu4LYBPfqu7qBRZJc1Qrd?=
 =?us-ascii?Q?CtkpdSzJwUc408y7Z8kZY27nelAcEMMIUdLPwQTZHwXFMMdyqkBCmDLEs16r?=
 =?us-ascii?Q?Cz3bBli0PjN7ryloyzo7omudbVCibZkjy0N5/mNgXY8SdB1Dfm35LjG/u1Fd?=
 =?us-ascii?Q?SyPuuhirB/J+sn1mW6OlpfQEBejBZsPFmHW7Iwxn6MLSy1KPtMechj8yBWgx?=
 =?us-ascii?Q?/6bzxY6MeZWhVOEtQy7SLs2svaR/95KxnY6DwzzducfjcL+ajLVLiBDNpga/?=
 =?us-ascii?Q?AKy4pJ2cDroAmky6HlWlM2ow3f6ubFGxv4mF9jtt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c02daf-b08a-435b-0f88-08daef584b35
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 20:06:12.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3vls5ZlTUv3QyNE1lDjVDK8rRrfqqs71Jt/PYOt/XEKJcbfEU9uz9ryWVcECkvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
> When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
> in its 'sgt_append->prv' flow to check whether it can merge contiguous
> pages into the last SG, it passes the page arguments in the wrong order.
> 
> The first parameter should be the next candidate page to be merged to
> the last page and not the opposite.
> 
> The current code leads to a corrupted SG which resulted in OOPs and
> unexpected errors when non-contiguous pages are merged wrongly.
> 
> Fix to pass the page parameters in the right order.
> 
> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  lib/scatterlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

rdma is pretty much the only user of this API and this bug is causing
bad data corruption, so I'm going to take it to the rdma tree and send
it tomorrow.

Which raises the question why the original patch was done at all,
nothing ever inputs pgmap pages into this function?

Thanks,
Jason
