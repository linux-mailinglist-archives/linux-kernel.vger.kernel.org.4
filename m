Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C45750191
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjGLIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGLIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:31:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2083.outbound.protection.outlook.com [40.92.42.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEE2722
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNexGyX68Y40PlwSSSYQqYWVQm5OXT8HOGlUZFaG1g0B+FmOp+Md/PJm2MF0q9kg97DNcujokpQts8/hMnQtkHWCjJPFLN2ekDfTAuK7c0ohspqc8S98t1UKaKx0EYQDi+/SwtNk5zyStYz9iS/JsMd8Q2rQFc11IC07A/PGKsQUZ8X8h4O1k/ByDkTLwuKLTBcLGL25JW8XApPl3augLHYEeK7UTQzJZhxlibZxDNb08VrS3kXzBSNFMR7JrzTSMDkMxbA4BAns2gFDE7ztkZGtUoKFc5476NA0xE4Ei7tDYUv1useM48tIknHsolhbtoeDeYQw8YejlzYkCTx6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0VCnRzZleXFnn6OFJD4nN+va4AGWKVGu+c7VPKERiM=;
 b=ksG1/UMjWZg4jcplEgb5c/VbwBu6geCZovnprWqWnHkfskhyea46L+STGRJi2yXYvLfQY4aL6rSCy4iTTSN/Oe4EzGUdGFkHrF6UaQntSLquu51qmqiwxAkCZmCmYCHkhVNAuwdH5D0JnPbk7DD+qxN+UZ1HEaE9g29FIY0IOMXOY8b1Glyv2z6GnplhLHTlufmpVXh0yYOzHDnjRFi2QSL3Y48ZFG8d6Lt5a2qDKGqLyi7fc3zDgcW7hBLGXd9foNVUT8y4WBHejRemqZzlQyqbKAsMHyaUwsLYo5eswlk69tDmByz0aYxBZp/H2IkwnsyfNnVkyam1qlcqak6CrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0VCnRzZleXFnn6OFJD4nN+va4AGWKVGu+c7VPKERiM=;
 b=i+9UtFekGx5Z3IlfMwrCTv/8+MDybfobDDwvp7PDUbMIbRgrL/f/cS3k3b0bm52LO7zktzT60IZjqACgHyB5N5qqHBITuGdsi78h6u4/AxVo5sIS8ApcqjLHuKYEwqI3Uodxpgc3JXbJjOqKSaddE9GxzL7ZiA44RIXX61cCwmrzhQn/een75JnGiDapZotFXKS1sutsbCvD+85wzpZllAsj2xPxtEm3zjfF3dtCw0eyuDGHj/RxzO4mAL5QWGR2/i+z63SHi+BL2TRGlUfoWysyhlOQo+a+lnT4Q2BKRwWsaSoQM679HLL6RLqUsOiBE0U9HZ1JY9OtqYsoewqz5w==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:26:49 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::d0d5:479e:b686:7c]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::d0d5:479e:b686:7c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 08:26:49 +0000
Message-ID: <CY5PR12MB6455091C997D0E219ED5D466C636A@CY5PR12MB6455.namprd12.prod.outlook.com>
Date:   Wed, 12 Jul 2023 13:56:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] FS: JFS: (trivial) Fix grammatical error in extAlloc
From:   Immad Mir <mirimmad@outlook.com>
Cc:     Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CY5PR12MB64558542113D0368DD98FA62C624A@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CY5PR12MB64558542113D0368DD98FA62C624A@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [K6i77ZsWM3Qp48whz5hFZhF84lzePFbkP253aF5FaSFEbnAZ80g+yBWQPI1cxWyZ]
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <873223c6-3a77-2b5f-ff51-f2a5b8ac5852@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: c403c2c5-e9e8-4889-f973-08db82b1bc8b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnImrOmI2fASczElczUo+vM1ybzrwi7rvMCP+fEmZo4UofXpfIE9VUWaxzhRYx15vYLMAZjeOGsBzmW07blUws4RaH1FwmEqLxDsKom/Ed3cRQVTzl/CLnuFif7jjs1DxFu7bR6kRP3PZ+q6KsTukQnibAKy7H3HhSgffBnWB5vc3R+pKqPKQmtpsCi520Ar3tIGJyDIVnThg2gW+OKx7cwfdbiVua/mADTUWPAz3OH5RClJa6ek8aeNlrMSeCaI5MxIHAtbmEb6YkKfIqs1gkh5om4g0y0Z3EtpgrpCKtIFCdZUS5eh525XrKTwQbdqFpu5hqi1xRM5tP1WkPP9fVNChvi3veexQ+uf4radraMpdQ//FJ6Ae41LSFJTyUWr4x7oMqoBJQyUeuU9Ppl9ZSNJInkkBI8AyPcv3BoR+DKiPbIj03mCtrZ9lqKKAqJzFrVN4EUB4cpXzqk/dVWyBvHr/ZBd4P/3M9sHqM4pWSyfhiGkmh/IhuTmWiJ/5ZTDT8x9X3YVOHGacsY7LHrpBUtnuLb1UCcM75RfHgpkQezUwOl+Qr/5p2gkHRiZxtBt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlY1ZjErWWdWR3JWSkpUYjhlQ012QkEreVlLckRYUUlMNmJ4Vlo2Tk1LeTVK?=
 =?utf-8?B?MU1Wb1gwd1JTR3ZKTkQxL3Urd2Zmdi91OVpnZmsvbHlkRGpoQ0dNM0lJOXph?=
 =?utf-8?B?aUU5alVvam8wTHNGM1FFSUYxbkdjSWwwY0ozcGwydVlsZkIzVSt0ZHV1ek1h?=
 =?utf-8?B?S3NaYjNuSEQrVnNhYThxL3NnaS8veUFHblhMUC9TTzRGWG4ybzhlWkhxQU4y?=
 =?utf-8?B?SWxHWmY0NEFwOUdrRG8xNXV2N0lKSEU0MTN4OWhxcDJEdXhYUjI3ZFZRd2gx?=
 =?utf-8?B?dUE0M2ZDenk3NVFKUHRpaW9WanFoejNGNkNDTXM4eHhsNEhBYnBFYm1PTTd6?=
 =?utf-8?B?WE8vNzRUcTl6dENrMCtISjFlVlZ2WjVuQVhma080b200dHluTTFTa2g5UmRH?=
 =?utf-8?B?clV5alQwWHl5SDZ1aGppaHUwY3RYSkR4QmZOSHdwY2F6MW5lL3BIbTdyblBm?=
 =?utf-8?B?RnVGV1hINHBCTEFwSkN6OVRBTUpsU0Z5bzBXaURDRXVaQmpFbFJvaDBpb0Q3?=
 =?utf-8?B?aXR1aWdpK1ZVT3dJNmVPMThhZ29GWXFXUHpMem5Ud05CeHJLTVo4MFZiTjc1?=
 =?utf-8?B?eU1yQXdxU2RYMjJBcFZSMXRUWVNrZjZwdHIyUmdYSTMxYXpYanRZZXRoaFpr?=
 =?utf-8?B?Y2RGSmRjQjM1VGpoVmxuSnZTMWMxY3FNUHJCeFRYYkNYMXE1WDBVOVhYVjJQ?=
 =?utf-8?B?MmZaNnZQcktROVZHSHNvZEE5UzlrZCtYMno0Z2JkNllsS3Fsb1hLZGFNY2ho?=
 =?utf-8?B?d0lBa21NTC9KN3FlQU9pNmNRUHA2OWxyRnhhQ2NHV1ZjQ2ErUmlXTXd0QWFF?=
 =?utf-8?B?eVdoQnVoQUF4UGU0UUNKaGQzNWRjMnNheDJMUU5FRnMvbkpKT1U5TnhMYW4y?=
 =?utf-8?B?dEZENVZyR2U2V013R3lWQTk2UjR3b2dNbTlJdWUrRHpQQnhDeVpOcXZlQjBD?=
 =?utf-8?B?bGpMS3JzMHpLR1V3QVdEYnZKRkl3YTRvdEZnQmMyRnFtNGV6UnRnTU5qMENO?=
 =?utf-8?B?WXFLRG1kVUc5bWwzSFlKR3JFVHRMNVVPZTdlZHB5NDZzWjN3U2UyUGhVUi9V?=
 =?utf-8?B?NEc5OVBmemhlcU5FNnBubGovaEQ2WkJSTkFDc2lmVDJrdk9rL0xXSktFUjRS?=
 =?utf-8?B?Snd6YmlIWHNJa2lWdWd6Z3V2YlEwU3FOREo1ZURMcGlJamk4OWpOOVArK0wx?=
 =?utf-8?B?cjI1WEJTb0g1K3hWYzlDcEhSQmZEOUZLb2JoVWFONkp1ZnBxTTJsdnp2UkpV?=
 =?utf-8?B?RWZtSXBpUTdwb0JWWlZWS015MjVHYm5ORnNZZkVONnl5ZjZlSUNHYWJ0QmR2?=
 =?utf-8?B?U3NINk9rUEd3VzR5Ui9hNktRU1ZUZi8yUHdoaVJwNHV0TkIvSTBnK2o1bHFv?=
 =?utf-8?B?cEdrL2VPOE9SL0pyMFNPc3dSU1NEb2ZFeEgvQUFxMmlweUcvR3g5Ryt1MTNw?=
 =?utf-8?B?NGxkbzl2bVBWT05hTlNXZ1J4NFp5MHNIZjlYVDNNOFNJR3haV2FJU0VndHda?=
 =?utf-8?B?WjNaYW12UEVnSmtFRFkxb0lhOHdYb0ptYkFjRXBYQjhYTGwxbUFtQm9pc08z?=
 =?utf-8?B?ZFNkZG5uL1Q1NzRsZGZMa3N4Uys1YTd6NE5makpta3BHaFNPWDNjakdrcVd6?=
 =?utf-8?B?di9MY0lZNmJRSExIRHFtOFhEZ3dnKzRhcGw5bGVRakJkRzIvVGdUclJPQlBJ?=
 =?utf-8?B?WXRqQlA4VzJVWkozdG5BcjdGQ1Baa1RrV201NGFvekhCOGdpeFlTUmR3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c403c2c5-e9e8-4889-f973-08db82b1bc8b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:26:49.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,MISSING_HEADERS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, May I please request a review on this patch.


On 28/06/23 1:14 pm, mirimmad@outlook.com wrote:
> From: Immad Mir <mirimmad17@gmail.com>
>
>   There is a grammatical error in one the commnents
>   in extAlloc function.
>
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>   fs/jfs/jfs_extent.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
> index ae99a7e23..399492308 100644
> --- a/fs/jfs/jfs_extent.c
> +++ b/fs/jfs/jfs_extent.c
> @@ -166,7 +166,7 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
>   	/*
>   	 * COMMIT_SyncList flags an anonymous tlock on page that is on
>   	 * sync list.
> -	 * We need to commit the inode to get the page written disk.
> +	 * We need to commit the inode to get the page written to the disk.
>   	 */
>   	if (test_and_clear_cflag(COMMIT_Synclist,ip))
>   		jfs_commit_inode(ip, 0);
> --
> 2.40.0
>
