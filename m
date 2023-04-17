Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE96E49A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDQNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjDQNPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:15:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BBE61
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTStuDwVMgf13YUZwuIWaxUGlVU4MuwqPF3ZVopRewxo4k/ZZo6RnR7pzfdEETZ8WJbu4kcuvdvC0PTXTxBTL+uOLyy6ZrYe1ddIkkeoJNMrg8ENfkxGBRvkAZzW0VTDL8t00v/4SkuZNBrAUVyqgYZuC7TzLComaczyxCC1xeqiolEe7Am/JbzCLr7mKiY1atlPo+ojs6//GYWFHa6/+OrDNWaRfSX5ehaNc7dpOsnc0mL63yrFsnQlNxlR27vFgV946C+tfouY+ToNallcMXSm5ifzeY2AlNiUX8PkaqX5q1nqEWaYVb/zdgYT68MTlAbMfJqRfVAf9pZf18zyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29Pq134fycUMZVhLqlm9qj/WxEYaAQ1YjYnfxj+WWg4=;
 b=BQvjkLTzw3TbXPDfT6D4oGF/+Rfaaiob/wKYoYTNk/JRYAC7Fr5/tSZ8/0VA8TLqW57KFbX4Gc3MAsqdZn0BIjb5BWk0QhPqCMxy/J24+gRgLzMKAdpF/sjebUaZZwWM7qHevN+LAet5z6+yMdrcizwVdKOO6GMcNKQZAYwunxmvIIL/TcckzUFEAmJfliAnBhSU3Sn0RzTRUngh7WleIeJ/dP7u+zxJXOWzB5/ILyDnKFlKkHCbbuvHVAYyjE3Vk3YDHhO+F2Re4Z23feN25GaI17nZ9P8UhuBOTM995hnghZcWLFgDFQQjYNuzAvBG0XG7O4DJmfLX0nA+H02HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29Pq134fycUMZVhLqlm9qj/WxEYaAQ1YjYnfxj+WWg4=;
 b=H+eCWnGzVyqcKMWOkOE/6v9tDL6wNDWWJy2iQDnk9nYHWWXZHmuNu/oR2FjJBS4i+FzlfUFQwI5L3FZKQ2c5HrgsS3b1R+aC+S+BW9TK+3KSx9r/g826a4dqECzw+11bGYgkVbl8S+hm50IOiurlmCC3rIbtnOCLl0K4qs0l9HL1O4BKYYm2f2myYNP2la+v1/iGhn1XAVh87k9kMOvit5NIjXegqkHB2jZVLIc/e/wJTyMWxegHqRzY3Jd69WGXiAOTEcARnr9PQwwPv7ukoMjzg0U3FvH2nClhcILMnYabRRNy2KoC/tbt9TSugSydVrarCVrb2GwvddADnhPtRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 13:14:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 13:14:05 +0000
Date:   Mon, 17 Apr 2023 10:14:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Message-ID: <ZD1GGiHBOj1mRDu4@nvidia.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <7ed66bd5243f7535030e0fa6a8a94b76dc5033f1.1681508038.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed66bd5243f7535030e0fa6a8a94b76dc5033f1.1681508038.git.lstoakes@gmail.com>
X-ClientProxiedBy: BY5PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea84544-a12f-4325-37cd-08db3f459ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CacxklZa1hYmxLn+dPeIogmexxj8H0PS1Wwc0y00il6du1gfor50GWwdlbLgiv965gbzEEeNGf6msQEyTRRZR96OFfdRPBjbwZMhBUm828xqepn3ivrfJD41BzPhqYB+Fz70OfX1rChCKn3ySGTMp58acpZaUSrNj6J1cL+XQYLktdflZnoRhxCacklYr6tJIMtLtsGbxREll4KcGjpZgCbJ9J8Dv+VpYdab1V9mT57jeNCjwAVjvjcEmV+YRAwxuhFutlrXAE3Y89JqcPFduqkTRuyK5bXXdGoYwsjDGPi2IG7P/IWkyFzCjdz53h6pHvQ/ieWPyvNiBuNZ28B/m0Z8TqTvjL9tETjlmZ0OubPs8Y8ps7E5yoejgMKOGUZdhGpvpRG7Z6wsc9XO1kg7VojkulvAQ8CLncTIRdjr9NeJJtRKOToG8H84U6vw3ERlbWNpSKNPNLZ/jHlf5IvTRz1XRbV1WedJTNhu2Loe75xfgNLGoEWuOKW//+kG5X3l8F3Jx+CMfLpOoxQV8nds/nmBTsDfJX88+2gwg0HgCKqQoJa5JunpleMlIAlwqGja
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(4326008)(316002)(6916009)(54906003)(66476007)(66946007)(66556008)(36756003)(186003)(6506007)(6512007)(26005)(38100700002)(2616005)(83380400001)(41300700001)(5660300002)(8676002)(8936002)(478600001)(6486002)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/RPR+f3ry1XdXr+soSLB55FCsrOP1p3XBHPFmBnuisuY4dSXlXG3u/85bVa?=
 =?us-ascii?Q?iP2oR67zG3TWeHoN3OgDqoI2WdbUc1aDNyMP17bNMJO8Rh+bD17KajAGK6Dl?=
 =?us-ascii?Q?NS/G9uzN2QM8PduNpapeHGwyVn6ULT1TpOFYoWe/cij3OkqfFHKC0tHwyEnQ?=
 =?us-ascii?Q?ihzfa+Z4mSmL5U9yOO2U6RcG0L1mnB6FMjQmUKVtTLxwJ5f8DLhqPnT5aWXx?=
 =?us-ascii?Q?4I8q6UDQb+eNfP+ZkIr9MdX5YzJ1UgkVkN6+y3+DRRefOjXeQYUSbkwPAUtp?=
 =?us-ascii?Q?9m4M90h0qvlP+47BBwa+/9zcR1SA6JQo+3GnrBaof7RqL2kIDbqbhw7O9AUo?=
 =?us-ascii?Q?3YtIxN/7GGSFVSulYf0wQNNx6AH6rH2NdYEKGV2qwvXEPi8kA4rmjURSXwpq?=
 =?us-ascii?Q?ddDZAv9TOMQ5CL8t9L/FQdn9mQUxKFpSxo1rmu9jH+tPzA/4mPyZO6E4IdZZ?=
 =?us-ascii?Q?bhjR+b5zxgQx6BGdcl/jSJtzgbq55tGGKis/XtWU9bObyNybaC5bNHbEalxV?=
 =?us-ascii?Q?Kgtnv0oRp5fK8Z7CA3FZNgmc0Ojxu+3DP35njIVZvHuM/lYSJGCDVW1RWZm2?=
 =?us-ascii?Q?zF+gP7hI/Yxcf2nwF+4GV20rLvq5igt++I69jISiiiQ5P1p/sDQvtmFZZM+w?=
 =?us-ascii?Q?XCPbnGRw8cYjTYQwTWxcVGRiRmYtvLxQNwcRLW/gyfRsqOewyzSP51Mblpq1?=
 =?us-ascii?Q?LOyJCK1SWaYHD60tu9GKfPXnskSQvGsKCzVjF8fp4KfeLUnosX+K5LUMO0c+?=
 =?us-ascii?Q?EqbJIYA5T9zEsahONYiEswxYRaX5ZdWDMEMbyQFtkhmClqEvSUzFtpognfYi?=
 =?us-ascii?Q?Ok+lvm+6BZb4gm73mtyBHlS4jIiapIz93RrjhZ/k9WKwF7T7h0GzhP6zfXlr?=
 =?us-ascii?Q?zkjCDAC2uJYWVSTKRXRSJeSXd/3/clhnTGimejlSMlLd9GAPKmwydawJ/SFp?=
 =?us-ascii?Q?mUofBE7Z0Zbrer4izSTmEUFh62vWfOTmDXsPsiVeX/FeWLfdJM4S5jNVEIDV?=
 =?us-ascii?Q?oX0I3SI8GCxUcg23AZtMe1ITjvOC0LWtFAciOMJ6tLXRumkwN2JfSvNpcbOv?=
 =?us-ascii?Q?1aRIwVytmzqsXoOGlcwJHOyTd7JAKZfcp8bPkxzilE7lB9WplvV8tiZb0WAr?=
 =?us-ascii?Q?0xGU3cM9pyJrYqw6l7J2olqeRDPc4p1Zvd3brXLG1YK/fgIX7z6AqqlbhsIb?=
 =?us-ascii?Q?802yxggCqJ9fBL4TOY9ku1MKyduK0tx3DhBIqlkV7GVGDPh+kMktkp49EBz2?=
 =?us-ascii?Q?USeGo01m/8iD/WDfqoeuPcB9UQaL2Im6SFji124nNtk/j9Kmr/y5ii8Sp+eu?=
 =?us-ascii?Q?NnTTsGqE1di0t5ltfwpbvCL/x1RPeJS0iQ7IWTcgsviYQoWFyeuNY76n84dw?=
 =?us-ascii?Q?ECCh+QLkGoMUSg1hGcFP5IVtGTiwxn9+xeY3W3zFHOVZJ/4Qvx6gzkAU5CzK?=
 =?us-ascii?Q?9i2EzTH7sFcoNv/wRiYyU30pjJIu7kF6cboWzJoiZ/7YKFMZsjGnUPCSPhkk?=
 =?us-ascii?Q?auxKHkq1wD3I/PC/nGxK9oxMQluZeQaks5w7iHTSiv6Es+bTCVJN2AbOyOAE?=
 =?us-ascii?Q?orG4t5KoqekRe5AMD5KsrzlLYTVadQQnZCGvNMLY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea84544-a12f-4325-37cd-08db3f459ec4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:14:05.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E07f6LMlHiH7ymsHVQJbHbuSZ7BOBrxjCzaUOucMSv/o6TwCDbTgi+3k/NNEZNUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 12:27:40AM +0100, Lorenzo Stoakes wrote:
> This flag causes GUP to assert that all VMAs within the input range possess
> the same vma->vm_file. If not, the operation fails.
> 
> This is part of a patch series which eliminates the vmas parameter from the
> GUP API, implementing the one remaining assertion within the entire kernel
> that requires access to the VMAs associated with a GUP range.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm_types.h |  2 ++
>  mm/gup.c                 | 16 ++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fc9e680f174..84d1aec9dbab 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1185,6 +1185,8 @@ enum {
>  	FOLL_PCI_P2PDMA = 1 << 10,
>  	/* allow interrupts from generic signals */
>  	FOLL_INTERRUPTIBLE = 1 << 11,
> +	/* assert that the range spans VMAs with the same vma->vm_file */
> +	FOLL_SAME_FILE = 1 << 12,

I hope we don't add this flag, but it needs to be rejected in
internal_get_user_pages_fast()

Jason
