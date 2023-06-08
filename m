Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15DE727BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjFHJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:55:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D426BA;
        Thu,  8 Jun 2023 02:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hej3JBBTw6gpslbOtvRxOczd2Zd6GpIMPyqXnhD4kG0YSnNg5ScLRjuMvhVfatfktZJwftsIydCT/LF9pbDm8cJyu/E4kwt1yU1Zsp1uEpg7hpHHr/4C276yMVaPwODc19UBvzFfcj5fT6EIhrVlgCb4GVDoTPDHipxDqZN3x7Gsyf1Af0BYb1I1DdQ5CDGsTzrsbcuCwTWKgVI/s2uXQXvw/qBa3lR4daWXjR1lXuX238kK+0/tJTSkM3nsKCm231Ul/D1S2x/DldcR9OFEGZFCY87fgB/P5IL6iZrAzJidciqQFcTomKSC8op0QPnwyLaOyB42JPVQsRt/ajNX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2+x/O7cKlrxITMvqOxWTeuGTN8JU+H00mUBNtY6uwk=;
 b=R10AMYttIWPgdTMt/3tiRV/+j8pI0IOcnMgfYUVg7GLgFRM/ayTWDq8MqfJ9shVrRRFMevEeBmEVrJje8H9zMlNSgF6VApiWH2urP8SGw1byUbXL3gYQVinglz49T2xZ5Z6mP53XtTlCvTRbr7i08mCoydn9OJCQmSmX/hsN0x5Jw5JkCJDletytNNc1qGsN/MoSLtnOhtwD2ZgremfFrhRzWXYgADRpgMdtYQWv8qyGySaeBldyBQL+Ywq7f6EOsq5IAuVdGu0OX46YLJcLP8ExtbPxUfvWweHZvi7716A2YtJWziakNUjlWsKgxEUgA6TrmclbdlOsQVq6MIOpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2+x/O7cKlrxITMvqOxWTeuGTN8JU+H00mUBNtY6uwk=;
 b=F7Ox6JMrzYcJVr27apCZ07dRCt/+RkHNE/MIH6rVQJMlcHdHMfQHcTgnUqHJpEfR/Ypn5LUSmUitKyFMYUycd/cl/+BFW4VodPeHhrNKHIUw5xDPjzKLpLyCOj7apTBaKr3eBERQ5PJq0mHkN5YHb2tvzVD+gLR4uGTxF5Ks3RsnGo478NunJkkUshrkCAxNHnBYqw0WAgSpquI3ARhshlVAYg5zC4eRRS+KnO9QrlPji+c+fiilzhGq5BE1eyi2FgLsjKU65se75rd5AXCyZTIkniMIExWh5uGZQ0QnpB29Xvgiom4acfsXJs6VWXcm6xkYT8NbqLowdDTJtkg3rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB9280.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 09:55:28 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b%2]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 09:55:28 +0000
Message-ID: <b45eb4c3-77c6-d0ae-9e90-a120fcab869b@suse.com>
Date:   Thu, 8 Jun 2023 11:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] keys: Fix linking a duplicate key to a keyring's
 assoc_array
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323130412.32097-1-petr.pavlu@suse.com>
 <20230330001355.dyazfwx4tyiyvux2@kernel.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230330001355.dyazfwx4tyiyvux2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ad9e1-855f-47da-9b55-08db68067d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDb8Kv6rrMueRk3V0xhjtZ8hPno4NKA8fvKvPFH7eyLzxKYG8GRXcDzoGSbHkbsHgL9KHQhCnkXIUfWsF8pdb+h76oCKsvnq/kDdm5OqwyhEOrCNeLZl9ZfvzbakC1gLziz6YPZ+JfKUckaQAvU8vpRj556b3P4K/lOTcRcp470WATu/Uc3GNDMps5utSKTlhEH8qfqQrIDPlPVV6mzpKL0dOgJj5hoWd8+bG88iH2v+uDyLr1qFkoteUZ+SAMDYNH2NdHJ6Lhfyjs7noRMVC85OyRIAznh+6HYzVdmT5IVozcN6XwGvxzxa+IC3IlTFa6WlIoxKHzr5ZdhriY6VgSakHiljlnwQDUEUevZrNlOuclvC4EftkQ3GzeSXOUtKTRdOIgEehYqZTfynSLGpv5DIExXv8G4+UnsPThAqh+x9D7lBPJXfrFLmqORXwRRJYXil0E7NK6iuWak/x2kye6PCnfbfLjxMB6o3hUndrTRpDdAtr2rPrvOMknvDq/Usc+EUNoKy/nJgX6ge4stxW/2BzVXE58yrtXubewzrJ173ktH6znms4S1FuSjrIiHpBi4iCd5IDobj4/LXrB7obSSlhFUQ31GRjZHl3eGxU3VdImwAYQhuMW+/i6kt2C64btSAO5twpRVci1GO72HWfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(26005)(186003)(6506007)(53546011)(6512007)(55236004)(2616005)(31686004)(83380400001)(86362001)(2906002)(36756003)(6486002)(8676002)(44832011)(478600001)(31696002)(6916009)(5660300002)(41300700001)(66476007)(4326008)(66946007)(316002)(38100700002)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlxRFFOWExIN2NkMHNWaS9LVXYrODNaYzFiUFhlY2xoWUlGS0IwMXoyK05V?=
 =?utf-8?B?SGtwaHpYdkdTemFiTGljRDF5QkM5NTFnZUN1bFRDaEgwWEJSa2lENVh2TFA2?=
 =?utf-8?B?SUs0ZjZma0xUaUk4OCtwazZuN2ZBTXZMWFBGN0xXSHhyUGJYdzBhSjBCNzht?=
 =?utf-8?B?WTlvbHhoaGhJdlhFQUhBWEV2NGNjL3RoZmFoakMwNHR1WjN3eTYyYjdpYm1W?=
 =?utf-8?B?b3NuQ2VDYmZOSEVmY0NqNjhhQ040VFlVYmx0dnQzT3FDUHJMc3RCWGZzUHc1?=
 =?utf-8?B?WXp2MDZOOHNlRkpENnFHUGtsZkYwR2l4d3NYUXNhTEJwNGtYWElheFM2TVdt?=
 =?utf-8?B?dE1pT2pYT2gwS0MrUlBXRmNYbW9HdjI1dTZ0a1BpOWtES3VtWmtpUlFaMktC?=
 =?utf-8?B?aHRnSHJKUDd6S1RPTis0cXJqSjJHVDdRQUdwR1NNV09vQmNNRU5QS3hhSzh2?=
 =?utf-8?B?bUhwcWNDVFBWWHRaWEg2dm9NZ3dYVDY3bjZoaWZSbSsweWxjcnRzZHc4cVo4?=
 =?utf-8?B?aFk0SXIrVlZGem5ZQzg5UzJXckhUeW4rZjlZanZkbTVtNDRJVHdxWTIxbGtn?=
 =?utf-8?B?d1VSSzkyMnREN1V3RkxzODNoNWt2ZjBPckp3cjVqdGZhMUFpWWV1ZWlOU00w?=
 =?utf-8?B?eWkxd0lrRTRzUklwVFUyTEZScjVvazZRN1lIaWxwbEdlVjJFdi9CanlZdVFs?=
 =?utf-8?B?WTJBRWJhbjJzNjJ2WDN3MHRMYUdRdHc2a1VQVWhlUEFjZzZSM1I3UDRDbnoy?=
 =?utf-8?B?ME9tMGR2NUFaNGJFZnczWm11SHYrM21ONE5LclM5SVQ0TENHUFlRSi9CUHRj?=
 =?utf-8?B?NjZPNUNzZXprT0ZGUzN4K1Z4bkUrMlBXVjhUUmJObmVuTnlpWUVuRWhEU3lp?=
 =?utf-8?B?Sys1bk5sYmsvTFBibHNEWEd4ajh1R1oxL210dXVXU01rTHhjVFFYYU5od21j?=
 =?utf-8?B?c1lBZmVublVoNmtLYnlhUi9xbER3TDJiVzhlazVMWGNIcmR1Q3hyLytmbmQ5?=
 =?utf-8?B?aXc5U1M3RGZYS2pHYUNKSnI3RWpzRUJYeThsMmc3Z0d2QjliK1YzK0UyMERh?=
 =?utf-8?B?VThwTjhTU1g4cURFemFCc3ZFVkxQTDJtdXRxbFpDOTBRU2NLQTFhKytTK3lI?=
 =?utf-8?B?eFBGTGQyRFhublYybStpWVVEMkkzWnZ1YVRzN3BTNG5BSkNiRmNmbWxLWHZX?=
 =?utf-8?B?c29OZ29EczZiTFNsMEZ0cTM5WjFBcjhUWW5vdWNLUkp6eXRSUndGemdUMTlz?=
 =?utf-8?B?dkw5TU5mYVBUbVNWZGhXZTN4THp1clMvTWJUKzM2U0t3bHFRRFY2cGdQY204?=
 =?utf-8?B?UFVPeVdqakxMYkpIakVnU3MzZG8zK1FLckI1VHZrNHprQ3FXYTRKVHdmcUlY?=
 =?utf-8?B?QTc4aFR2K3FQdW9nNCs5VmVvczZGeXI3NCtRY3JHNUZWbERNUU5MczBlZTVJ?=
 =?utf-8?B?YTRxck4wc2lyZEYrTWNVcG1wQmw2UVFGcUxsd3JLdkZVdnA4Zk1KdmRnaUJn?=
 =?utf-8?B?L2R1cm1vZTdqYUdWZ1dVZmc1VkdINmdXcG92RExKamVlM3NLNEkvcmhTTE42?=
 =?utf-8?B?ZDdDSlhzQjh1WXl0NGlWclI3UU03WVlORC9kdDhOazR2amY1SVVidDh4dUlJ?=
 =?utf-8?B?aTArOXdrajQyczlVQ0dGdGJlamhrQk9YZFJrR1p5ZzVFazJ5WXNRYlYvYml6?=
 =?utf-8?B?Z2p1Q0RJSHZoYmYxRHZBYmhua0dJdTU1dDBDbk1Vbm8rVVUxS0ZBWWZkcEFr?=
 =?utf-8?B?UEg1Q0EvcEtSY3RWOXloNVN1VEFZNncvZWxnTkQvaTcvTmpDNDUxZGd3cDFk?=
 =?utf-8?B?TGgyYmp1MXBOZ1lPcmpnWnptUEtLVFpiamYrS2JzaG5GUFloWGxxOVVSRng4?=
 =?utf-8?B?M003dGRnYTFkT24xc3hjc2dGOU1aTWFrUGJKR01SNitiMllxWWNFbUdiMXNV?=
 =?utf-8?B?b2VINmszVzVqdE9OQW8zRjJoWTNXdy8xZXVmL0xSRzcybkFIK2hHNC9xNHpN?=
 =?utf-8?B?dkE3Q1kwWktzSllDdDNhSGxkaVpjOFdoTmYwMUNVdVd0UGwwU29KT3lmeXhj?=
 =?utf-8?B?bGZNSG83aXpUSTVFWWZUUi9nak9lWENHTzgwUWtsNU5BemVZRDF1aVJsdlpx?=
 =?utf-8?Q?PkpArkEsZiveHEPXvVx8TQwhO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ad9e1-855f-47da-9b55-08db68067d1c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:55:28.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQIEBGhJkS9Ygajx4FZaO93F+ouwuZVNIm2YggWxZ/ql144R2lQEltyLiLRRAu8mIG84vjKEKUQRMmqylmyUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 02:13, Jarkko Sakkinen wrote:
> On Thu, Mar 23, 2023 at 02:04:12PM +0100, Petr Pavlu wrote:
>> When making a DNS query inside the kernel using dns_query(), the request
>> code can in rare cases end up creating a duplicate index key in the
>> assoc_array of the destination keyring. It is eventually found by
>> a BUG_ON() check in the assoc_array implementation and results in
>> a crash.
>>
>> Example report:
>> [2158499.700025] kernel BUG at ../lib/assoc_array.c:652!
>> [2158499.700039] invalid opcode: 0000 [#1] SMP PTI
>> [2158499.700065] CPU: 3 PID: 31985 Comm: kworker/3:1 Kdump: loaded Not tainted 5.3.18-150300.59.90-default #1 SLE15-SP3
>> [2158499.700096] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>> [2158499.700351] Workqueue: cifsiod cifs_resolve_server [cifs]
>> [2158499.700380] RIP: 0010:assoc_array_insert+0x85f/0xa40
>> [2158499.700401] Code: ff 74 2b 48 8b 3b 49 8b 45 18 4c 89 e6 48 83 e7 fe e8 95 ec 74 00 3b 45 88 7d db 85 c0 79 d4 0f 0b 0f 0b 0f 0b e8 41 f2 be ff <0f> 0b 0f 0b 81 7d 88 ff ff ff 7f 4c 89 eb 4c 8b ad 58 ff ff ff 0f
>> [2158499.700448] RSP: 0018:ffffc0bd6187faf0 EFLAGS: 00010282
>> [2158499.700470] RAX: ffff9f1ea7da2fe8 RBX: ffff9f1ea7da2fc1 RCX: 0000000000000005
>> [2158499.700492] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000000
>> [2158499.700515] RBP: ffffc0bd6187fbb0 R08: ffff9f185faf1100 R09: 0000000000000000
>> [2158499.700538] R10: ffff9f1ea7da2cc0 R11: 000000005ed8cec8 R12: ffffc0bd6187fc28
>> [2158499.700561] R13: ffff9f15feb8d000 R14: ffff9f1ea7da2fc0 R15: ffff9f168dc0d740
>> [2158499.700585] FS:  0000000000000000(0000) GS:ffff9f185fac0000(0000) knlGS:0000000000000000
>> [2158499.700610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [2158499.700630] CR2: 00007fdd94fca238 CR3: 0000000809d8c006 CR4: 00000000003706e0
>> [2158499.700702] Call Trace:
>> [2158499.700741]  ? key_alloc+0x447/0x4b0
>> [2158499.700768]  ? __key_link_begin+0x43/0xa0
>> [2158499.700790]  __key_link_begin+0x43/0xa0
>> [2158499.700814]  request_key_and_link+0x2c7/0x730
>> [2158499.700847]  ? dns_resolver_read+0x20/0x20 [dns_resolver]
>> [2158499.700873]  ? key_default_cmp+0x20/0x20
>> [2158499.700898]  request_key_tag+0x43/0xa0
>> [2158499.700926]  dns_query+0x114/0x2ca [dns_resolver]
>> [2158499.701127]  dns_resolve_server_name_to_ip+0x194/0x310 [cifs]
>> [2158499.701164]  ? scnprintf+0x49/0x90
>> [2158499.701190]  ? __switch_to_asm+0x40/0x70
>> [2158499.701211]  ? __switch_to_asm+0x34/0x70
>> [2158499.701405]  reconn_set_ipaddr_from_hostname+0x81/0x2a0 [cifs]
>> [2158499.701603]  cifs_resolve_server+0x4b/0xd0 [cifs]
>> [2158499.701632]  process_one_work+0x1f8/0x3e0
>> [2158499.701658]  worker_thread+0x2d/0x3f0
>> [2158499.701682]  ? process_one_work+0x3e0/0x3e0
>> [2158499.701703]  kthread+0x10d/0x130
>> [2158499.701723]  ? kthread_park+0xb0/0xb0
>> [2158499.701746]  ret_from_fork+0x1f/0x40
>>
>> The situation occurs as follows:
>> * Some kernel facility invokes dns_query() to resolve a hostname, for
>>   example, "abcdef". The function registers its global DNS resolver
>>   cache as current->cred.thread_keyring and passes the query to
>>   request_key_net() -> request_key_tag() -> request_key_and_link().
>> * Function request_key_and_link() creates a keyring_search_context
>>   object. Its match_data.cmp method gets set via a call to
>>   type->match_preparse() (resolves to dns_resolver_match_preparse()) to
>>   dns_resolver_cmp().
>> * Function request_key_and_link() continues and invokes
>>   search_process_keyrings_rcu() which returns that a given key was not
>>   found. The control is then passed to request_key_and_link() ->
>>   construct_alloc_key().
>> * Concurrently to that, a second task similarly makes a DNS query for
>>   "abcdef." and its result gets inserted into the DNS resolver cache.
>> * Back on the first task, function construct_alloc_key() first runs
>>   __key_link_begin() to determine an assoc_array_edit operation to
>>   insert a new key. Index keys in the array are compared exactly as-is,
>>   using keyring_compare_object(). The operation finds that "abcdef" is
>>   not yet present in the destination keyring.
>> * Function construct_alloc_key() continues and checks if a given key is
>>   already present on some keyring by again calling
>>   search_process_keyrings_rcu(). This search is done using
>>   dns_resolver_cmp() and "abcdef" gets matched with now present key
>>   "abcdef.".
>> * The found key is linked on the destination keyring by calling
>>   __key_link() and using the previously calculated assoc_array_edit
>>   operation. This inserts the "abcdef." key in the array but creates
>>   a duplicity because the same index key is already present.
>>
>> Fix the problem by postponing __key_link_begin() in
>> construct_alloc_key() until an actual key which should be linked into
>> the destination keyring is determined.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  security/keys/request_key.c | 35 ++++++++++++++++++++++++-----------
>>  1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
>> index 2da4404276f0..04eb7e4cedad 100644
>> --- a/security/keys/request_key.c
>> +++ b/security/keys/request_key.c
>> @@ -398,17 +398,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>>  	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
>>  
>>  	if (dest_keyring) {
>> -		ret = __key_link_lock(dest_keyring, &ctx->index_key);
>> +		ret = __key_link_lock(dest_keyring, &key->index_key);
>>  		if (ret < 0)
>>  			goto link_lock_failed;
>> -		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
>> -		if (ret < 0)
>> -			goto link_prealloc_failed;
>>  	}
>>  
>> -	/* attach the key to the destination keyring under lock, but we do need
>> +	/*
>> +	 * Attach the key to the destination keyring under lock, but we do need
>>  	 * to do another check just in case someone beat us to it whilst we
>> -	 * waited for locks */
>> +	 * waited for locks.
>> +	 *
>> +	 * The caller might specify a comparison function which looks for keys
>> +	 * that do not exactly match but are still equivalent from the caller's
>> +	 * perspective. The __key_link_begin() operation must be done only after
>> +	 * an actual key is determined.
>> +	 */
>>  	mutex_lock(&key_construction_mutex);
>>  
>>  	rcu_read_lock();
>> @@ -417,12 +421,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>>  	if (!IS_ERR(key_ref))
>>  		goto key_already_present;
>>  
>> -	if (dest_keyring)
>> +	if (dest_keyring) {
>> +		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
>> +		if (ret < 0)
>> +			goto link_alloc_failed;
>>  		__key_link(dest_keyring, key, &edit);
>> +	}
>>  
>>  	mutex_unlock(&key_construction_mutex);
>>  	if (dest_keyring)
>> -		__key_link_end(dest_keyring, &ctx->index_key, edit);
>> +		__key_link_end(dest_keyring, &key->index_key, edit);
>>  	mutex_unlock(&user->cons_lock);
>>  	*_key = key;
>>  	kleave(" = 0 [%d]", key_serial(key));
>> @@ -435,10 +443,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>>  	mutex_unlock(&key_construction_mutex);
>>  	key = key_ref_to_ptr(key_ref);
>>  	if (dest_keyring) {
>> +		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
>> +		if (ret < 0)
>> +			goto link_alloc_failed_unlocked;
>>  		ret = __key_link_check_live_key(dest_keyring, key);
>>  		if (ret == 0)
>>  			__key_link(dest_keyring, key, &edit);
>> -		__key_link_end(dest_keyring, &ctx->index_key, edit);
>> +		__key_link_end(dest_keyring, &key->index_key, edit);
>>  		if (ret < 0)
>>  			goto link_check_failed;
>>  	}
>> @@ -453,8 +464,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>>  	kleave(" = %d [linkcheck]", ret);
>>  	return ret;
>>  
>> -link_prealloc_failed:
>> -	__key_link_end(dest_keyring, &ctx->index_key, edit);
>> +link_alloc_failed:
>> +	mutex_unlock(&key_construction_mutex);
>> +link_alloc_failed_unlocked:
>> +	__key_link_end(dest_keyring, &key->index_key, edit);
>>  link_lock_failed:
>>  	mutex_unlock(&user->cons_lock);
>>  	key_put(key);
>> -- 
>> 2.35.3
>>
> 
> A good catch, thanks.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you for the review. Can this be picked through your tree?

Cheers,
Petr

