Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3EA710B44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjEYLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjEYLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:40:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D141A6;
        Thu, 25 May 2023 04:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtWV/s37IRBxCUHJFuTmuXtKoqb9kRZf4ez9z6FL3Omv+LVIVGVdwN+0o5miUWvBkQWs6W9bDW7Kk4EkkvFbAwh3IqbI6mDvv6KECgiTifaTjRup2wrQUNJL+Ud527TKI824UwVNYluzShY7ZU32Z19wxpPHsBoyV7eRXSlkuXRagHpeyDZQy/14rmA/MsErSeagKn95eLO4KWZIQImif3RcGInYUhtcZyYhdyC3sM1mq+NZYI4N9gyTaXodoTOF3iWVCJzr0TsYaGaa45rYpkNAgxMBc1VDha2PEiNFTthpzDKWfgb00xxH5xHqQm+jrn1yMtBvhNvpZFWIRjEH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiDrJOHqOfY2W/2tz03+cS9guyg1bSbGO6nsweNVq1M=;
 b=ev2slRM59u2UiAvRkzd6fowwZNDdhrnb8FsVnZb7NMfS1iZC3B9Y5j6LSkxwLVafZjx6Vv1JnkOFpR7yGOwjtTQIzN3qgyVCEpNbvGAQei5tRAyQZpYtiUW3GO+Tf0G7YpeogUoVMv2VipbtJ1Mz9OZqEdyvFnwOHqsUCzMX38Y55aMRksWnmHULoH66rlpgc/d/ku4zInprq+FaWtFm7DC1alY90g5U3R8VHvFiJOyZzejNundtSNg6xLTWl/ebrTO3vNOK/2/c5s+qnOA3ELR6n5RYOtSWGAgdx9EMOJVPQQX9lr7CYVQNXbCBNptZnS4cpSywnk0RLXBMOAixmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiDrJOHqOfY2W/2tz03+cS9guyg1bSbGO6nsweNVq1M=;
 b=JXUSCK+mwTTf//fI8Z3uNnOq7M0UvovdQyEMwpNE9zrduylO6TATTcb1v0LN+LSuFdgUWyGa13fFmU9IrlNYEbqSgUOoC5Y6Ue+i3V0XkgcnVvwOwS7VxiE5uE22fTmOiT4Jz4BFyEvNfrYu0l4sk4kEfjnFxY3CggkgJYVLg9H4jHfF77Hl93okUuj6H+XGCxqkfVzAH87CMdkpCNrellcxbe34k0MetfSgn7aeFSjDALTTvZLipj5MCvfbv+zmdSuoUeemyyRXH0N4EE6ovi23T6Z6lox090dLcl4hWbzcJgEFrFYfVzIljg5hYLSXBs+bTGM22d1zTL8zVAFDGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PA4PR04MB7775.eurprd04.prod.outlook.com
 (2603:10a6:102:c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 11:40:35 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::40b6:6355:a515:8caa]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::40b6:6355:a515:8caa%6]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 11:40:35 +0000
Message-ID: <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
Date:   Thu, 25 May 2023 13:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, lennart@poettering.net
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230524213620.3509138-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1648560e-d089-44f7-617d-08db5d14da6d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHL1sABiMMr3wH7Gf1WriVDY88BtxbFMWK1Lyc9g2DX97xYldZ+AkCWpyvyu/L/aPJ3cV30zB0+ZUME02/08JHIDEDR6/22pWbf/3XHKr9XYBPEhyBc4ZC3+Y27qlTnJosTBCu8jsZISFCVCK9LnLOXXwtfHPLSaXf29cpLEBLQiT7EVD00nWe3BLNUUYsOkiIP75GQAHjOJ1zHjQWmo/eIJZ+M49mOQMC0mxMY7xOjQI0n2gXPDd/q7LngLfb7zUfSZZhJEU+DnDtGgsB/M/4jlpwX1taNe44VowAFZ/Itvdegf2wuYE1Y2le2UwZ/CCnizJRsDFksLHnGOBP8aSvL3vfelBheyZdemFeUc85OkIoRaDW4wB1NMNGZR93Va4FTArgeBaGpFupBbHPHEJtuQHHJNygz6kK9pmvpWrU0ve2G6ERVYTJ5QvGHwHQZcQiuHjJS3BZ2ArUWbglRvliPulDK5api2MTQF1mWdvFHVeWRf8UjOTn6zHkjGFgrksu2DxgYnb93EzyYo0lC8bOCjtAgQVHClGuIxQagmpjIzlMLV1xiCL+ZHxZNl/9ObLvhJ33XkSsr+RBOZBenml+JzwjzDnBosrADGgF4kUqc2OeEgAOUc/z1TtDY2iyofltI/FpvxRI6iDjICOxyh3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66946007)(6916009)(4326008)(66476007)(31686004)(66556008)(316002)(478600001)(6486002)(41300700001)(6666004)(186003)(86362001)(55236004)(6512007)(6506007)(26005)(8676002)(8936002)(44832011)(7416002)(83380400001)(2906002)(31696002)(53546011)(36756003)(38100700002)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlNKY3kxT2pkRnBISE4vUitWSFpRa053ZlBkdzdYcFQ4NmtZbGFuWGJKbHJ4?=
 =?utf-8?B?VDRkK3lNWXBIMWJKNUpZdGtxS3RnQ3hBY3k0OHNNUVVTK2Exd0dzNWhPSm9S?=
 =?utf-8?B?TjltR1dhYVUyZ3lzYzQyenVBYjJqTmVKUTJROUZ2d2Z1L29UZ1l5a0JOK3FI?=
 =?utf-8?B?QmgyN2UyVmR4b1RrQnlvTXhITDBqdHdZNkN2cTY3a1d6NURsYms5ZS8rVmdP?=
 =?utf-8?B?ZysydlBvTVE4UVVqNEZaRnBjWmRPdmx4Q081Und6ckhmcVJxYTNYQ2pxdkpr?=
 =?utf-8?B?NzNRNzZLZXN2MDJWNWM3Ylh5MjM1REVlR1M4TUwzWi9NR2ZkZ0UvM21EQXJN?=
 =?utf-8?B?VzRJbmZwd0VEVXAzT05rM1JQSXlPQWFtSGNzbHNFTjdZeVNhc210T1IwTXph?=
 =?utf-8?B?ejVUeGlMY1NxQnNCRjFSODVVV0tSZzN1Q2VVSXVidG5UMlZKdm41NTBuL29U?=
 =?utf-8?B?UHN2Y2k4M010VHAvZlVjYWQ4bjVXNXNucFVBRzdIQmYzd1BkVk1TcTErc0xp?=
 =?utf-8?B?ZXdMclhlMFVaWFYrOUFiYWpodVp5LzNxY0JJT005NVpvNVVVeEgwK2NHK3VX?=
 =?utf-8?B?cnZ5d3V3MXM0Z09QbjJjR053aW1Xb0lSMzRHbVdCblJMVEFXU3N6czVHbUlm?=
 =?utf-8?B?cXovVTl1cEIwZ09tdXAxSGorQ1hYbEIvUnlNbWkzU2EvNzJuS3Vla3RqS0Zz?=
 =?utf-8?B?Z0t4MGowZ0JueUFGdVpaMW0zUWZiVlI3RE91endrczBaVThxV0xoSU5QSkhi?=
 =?utf-8?B?WmtEVHV6MS9TVFpjbGhMa2FkSGZlbHlDYmMwb0VYa3NqeVlmZC9CUllxdHJS?=
 =?utf-8?B?dVp2eWdsa1JqbVVvT0JWU3l4UFJoZWlpbi9CRm9wWDY2RlpJakxGRmxpMklp?=
 =?utf-8?B?M1I2QmRmaGtRYXhITm5oSnNieVljejR2ZzBPZ1FtU3F0Q2FmSXVld1FrSng4?=
 =?utf-8?B?bHVZVzVMdHR0WE81emMrd2pLK0dlRWJtbzdTeGRTaTBtcFhROFhqa3oxK3Nw?=
 =?utf-8?B?c2NPenp5SWRoRjREYitlVzIrOVJBTEZsdE1FVmRtMUVWQ0ZpdkhtZDlCZXJM?=
 =?utf-8?B?b1NKWER4L04yM1dlUG9Zc1FJaWZrL0t5QldxSk0waGliTHcySTdrbWNoN0Vr?=
 =?utf-8?B?ZE93NGxSN0FyWkV5NXY3UEU4S0Z6M3ZHQzMzSTE5OEhlcWpUOTVsQmRJa09u?=
 =?utf-8?B?bm5WejFYTHVPeTB1QmNQNDcwNVZ1ak5CWkdnZDQwRUYrWnRuL2pQNU5WU1Vn?=
 =?utf-8?B?RDNUUDRLbVpta0x4WTMyM0VTc3VaR0UxNzBRNHFXcHR4dS9IZXhDcmt1SkRz?=
 =?utf-8?B?ZGp6UGx4bFdETHMrOW9hUkJtK29DT0xzTzlkczY5VmZwS2g5T3QxNVBPTmhS?=
 =?utf-8?B?eFlodG5adTJWZ25DN1duUlpXMFA5WmhMVitlY0U3TVJFNG05eG9SNTlxL1B3?=
 =?utf-8?B?VWJDeStFMzJZVGdvbmxoVWQyMnFuWEJzd3laSEFHRW8rd3RIcHpoeDhSb2xO?=
 =?utf-8?B?ODA2c3BTZ0hYNm9JZWJCTjBuWGt4UDI5MDg5OXVCdHlCTFZReVlFUVNmTGtX?=
 =?utf-8?B?MStSWFlwcmlKR01zN29LNFZKbHpoVHZBL2tGQ3FLbzVDYVlaMHdzc2VoSHZJ?=
 =?utf-8?B?TUNSck9JV1FOREVZWXpwYXRDeG12Nm5td0ZxZk5rUlNNY3Foa251VGhvY2lZ?=
 =?utf-8?B?UDJvM2x2dTFYUW9vZkNORDBsOHRING9DUzR0Q0tYWmF3VEtQME1wWERZRGJX?=
 =?utf-8?B?MU9oZCsvSVR4OSt0ekMzRlRZNDVHczFkUVFKZGZtRWxQUTdZRFdpWElHMUd3?=
 =?utf-8?B?VGp2MXVHcDFpcm1LMEkwaTB3SHU1ckFZdFN1Y0g3R3M1OWJCV2cwaXdtcmZF?=
 =?utf-8?B?UzJtaFYxNGtFT1N2UkF2VWhpaTF6SDh4OWFFU2loUDV1eWdmbzd6dU9BMDgz?=
 =?utf-8?B?RkJFM3ZCVEZMNkRTb2lTb3NxWEVxb3Ztb3FJa3pNODl2eU5ockVHTFlDSFBQ?=
 =?utf-8?B?U3J0K0VtMTdQSjhMZ1ZTaVdIVHpCSGVwUDhiYnhsYlo4QXdHV3k3L1N0bXAz?=
 =?utf-8?B?NWpnNktuSXhlTnVHdEQvT1FaTUFBemdSZ3Nsc2RqZmFaSm50VkFGWFc1YzhW?=
 =?utf-8?Q?R/dwZETvueTp1vOC5gPe4wo2X?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1648560e-d089-44f7-617d-08db5d14da6d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 11:40:35.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef09p0Mx/GXxjnz3lbENM6W9v7gRZIvkdpEaAK0wXNR/T9CmGDe60zZUDdijekm7PUTwL44zCTBQvIm+SblwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 23:36, Luis Chamberlain wrote:
> Add support to use the new kread_uniq_fd() to avoid duplicate kernel
> reads on modules. At the cost of about ~945 bytes to your kernel size,
> enabling this on a 255 CPU x86_64 qemu guest this saves about ~1.8 GiB
> of memory during boot which would otherwise be free'd, and reduces boot
> time by about ~11 seconds.
> 
> Userspace loads modules through finit_module(), this in turn will
> use vmalloc space up to 3 times:
> 
>   a) The kernel_read_file() call
>   b) Optional module decompression
>   c) Our final copy of the module
> 
> Commit 064f4536d139 ("module: avoid allocation if module is already
> present and ready") shows a graph of the amount of vmalloc space
> observed allocated but freed for duplicate module request which end
> up in the trash bin. Since there is a linear relationship with the
> number of CPUs eventually this will bite us and you end up not being
> able to boot. That commit put a stop gap for c) but to avoid the
> vmalloc() space wasted on a) and b) we need to detect duplicates
> earlier.
> 
> We could just have userspace fix this, but as reviewed at LSFMM 2023
> this year in Vancouver, fixing this in userspace can be complex and we
> also can't know when userpace is fixed. Fixing this in kernel turned
> out to be easy with the inode and with a simple kconfig option we can
> let users / distros decide if this full stop gap is worthy to enable.

kmod normally uses finit_module() only if a module is not compressed,
otherwise it decompresses it first and then invokes init_module().

Looking at Fedora and openSUSE Tumbleweed, they compress kernel modules
with xz and zstd, respectively. They also have their kernels built
without any CONFIG_MODULE_COMPRESS_{GZIP,XZ,ZSTD} options.

It means that these and similarly organized distributions end up using
init_module(), and adding complexity to optimize finit_module() wouldn't
actually help in their case.

-- Petr
