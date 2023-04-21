Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F56EA1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjDUCjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDUCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:39:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8B1FC3;
        Thu, 20 Apr 2023 19:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI178A0KDcpE2gBXueNdxMTZmVpVtnBCszXlgF2juGjCKdrrFOhKYvz1RRSDDGCs8x7NPE8ubhCgrF7N/5jkUz9JRK1UWJQrub37tKsvvljlhLQfsG1TZ6LjQcO9dXnC7ukdVs5S5JPvYJwXE48WKtLKt+6Q3Q1Pm71HaTVbaVXg1254IeKb1A5vNBu/Z2jtLeu7+ycKQCz4T4RGvf4xtSaAGPUdNqdTga84IbDQhmkHnVhCLpFpsYQ9pL41JapybeZ+S2/C4QZPH6YXUl/kTYZHoeS+8zrgZ8DV4eZMIRAeGGaT7kEU/U1oFBxHdWtazoJmsXo0Z6PzGHDg0ggovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIWk1ybtJymJzNJ1H3nDudOeUvWndaGNFznjMz8QE+Y=;
 b=ILCc0bBj6ubKxL6pnuyfCCgsk3yLkQRdet5bKZBH6cmH0W89J21QV856ibflDyzB67JLNyu8cJnPA1Y5ds3lbxNG9ylzSdKHUZA6ODDADTXWFCMC12J06sDYEgx4PhuEnd7Lgv2W8KPLenQq/CREFaaRb+D8mFnp4iXV0R3lUrxSH3CHOi692R1sCogIU2PA8gBavTXFPVak4/DPG9qOOfSGvGKTf3ZFZMk/igS6wsIg8GaUI5bmqBCl3rhMBXa7NshPiKl6wyp7QmfIe3qZhtjwGfp5krNKY0jrjwXwFx7eD28rnahpgGsA5w9mksZ9CVkRCwflDQ8eMfSzRs6KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIWk1ybtJymJzNJ1H3nDudOeUvWndaGNFznjMz8QE+Y=;
 b=AlwALCWm+pHjaPw9a5TVxxLavrPWiqc7z4jj+r9KMuwKqCMOF/4noxxmhOuveTvsA+CeYp5hxuzWLYdA9uNOHimac8prxwrtl1X3EE4COwx5wgTWJQIu0qBm7LeR1zTzpdDq6g7qt/rwlzmWMlTyGDZpAgIArS5/yzmsM7MpVpIJTWClXNi6KqS9GOnfZMBJeDLnY/jMpiTH3FFI83E5i0JIwwKzD9cbhwcKxHFVosIGTbPXLOZXP7Aei9zawhT3VBfLM8UmdyAWUZZ2twXApc6v0/Iwz6p8aNdBnYWAC5ZoO7cjoK4I2q11/0hgxzXH7sBU8nBW4yUJy8ZYRmzKLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 02:39:13 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2d2:b31e:7a15:db70]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2d2:b31e:7a15:db70%7]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 02:39:13 +0000
Date:   Fri, 21 Apr 2023 10:39:01 +0800
From:   joeyli <jlee@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix linking a duplicate key to a keyring's
 assoc_array
Message-ID: <20230421023901.GO8569@linux-l9pv.suse>
References: <20230323130412.32097-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323130412.32097-1-petr.pavlu@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:404:14::28) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: bc235180-45c7-47dc-9a8d-08db42119791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbwxfkEkrCTIJejiFb18EWeru3EQNqi4McugvOdB6K7tnGFUSd+4/RB3vSviXEIc5YUbDwX7ZZsSUU2GBdMqbCJPwX1jAB9tNEhQs4kw4Exx0xl6e+jGVKXSiyDokn0qyxHsTc5QjJ5p3LTsfJbz1QNFlrrF/5TxgatDJgx1Er9jaQDnnyWFn5Nb0kqyas1aaYoRNGFhxHRw9PTFPvP8gCiVQd0etdmJIAxKH1aC149WWx/w5UmUGlfZfq8JQskEFlm6sVScjZEvzWfw3ily17dn31DVYswG9Uyl3kOC2AWoi8eohJmXefDiUACwbeKz9CQL3XxsiJKzejSMPtaANvjlR05U4kYmcSPJAgbxlhmnlCaE3KMXoVirA49RL/75I56Ff/0m2XaHY5q8lQtsqzaMAPZIU0qb3hGiQQ+zB6zVluM9kRFT4dOdH/zLwrc02MRHUZ1GdgTWtGhUxqdgmwZ1azVI4te+pLLUYqBA4wPyToGeqgX5LKnDVuB/5Jbs5sKZzFs4fvAXkVFrEswgN0ZY2sapegL01zGPDncj4JBhEIx0XGps2/LOFjFH1qleSitG9pKubMJf3D2zk9zkWUZS01VqsxmVY6tF/r5tCqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(8936002)(8676002)(6666004)(36756003)(6486002)(6862004)(5660300002)(6512007)(6506007)(33656002)(41300700001)(26005)(186003)(1076003)(9686003)(83380400001)(2906002)(38100700002)(66556008)(66476007)(4326008)(66946007)(6636002)(316002)(478600001)(86362001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2YP4jGMp4frIBPtd9njT9rbb0wsk+NpEkIl5R7dDL/4l8Y5QJwtpwo+47OS?=
 =?us-ascii?Q?xmw+iFz+JDxhdY4so+cyFuTxwmg/J/mYrtjiGcnjh229Y7v7y4e2Uu+Uf/0T?=
 =?us-ascii?Q?EGwwH+s/xlHO8H+fHvj5su1bGbEUsyalWTWsUNPAMMXgY/pqAN/yFFDRhq9A?=
 =?us-ascii?Q?wHVOym7/wHjJoQm19+a1rTj+ialovaDN3wyzII6lt+KbXasVJW2XHy2GUCJn?=
 =?us-ascii?Q?El+eh1CgvgTmuxOnaAc9y704sSx6ULvXOStsqgLTBGkJUcP/h7+KWi6bsKpv?=
 =?us-ascii?Q?ss0vfkmyCJN6UQg7bjUoJcQ4StrPrIj8XPGLRj6tkfT1ePoD/hqCAtP3vnct?=
 =?us-ascii?Q?+V3hRwyTlpNUwopg/4WMHn8aLZwnXOCnbNE6cSFkrQJQaK9dG4LLVKP6OI24?=
 =?us-ascii?Q?0h6KdEGcp1ELtFX4FjCW8SoizB+Nk3Et6no9ub9dXAeB0R2wMJ6sjz3Ia9WR?=
 =?us-ascii?Q?DoVUEbWFRdz3ZlNaE7sY/nD89O8mR+gTsD2oe30n/cTgssmDrDrdyz7avT9O?=
 =?us-ascii?Q?0I9F4B9xxB78ZMxRgwhprDQ8QfZQ/PzpMfCb9MOms0AdZfP3ZgP0/OCj1kUC?=
 =?us-ascii?Q?6YDqlRCsX90Ko8xA1K2HAbCOmrzjnFowk9v1ou38PlJAuFIIBXCj72HNVt6T?=
 =?us-ascii?Q?a1rYl0ew0+/9PHD6Yyx5X3ns8NnVsaqBBZItsKmswdUeXyGiYiwUIpCMuRUe?=
 =?us-ascii?Q?rxXkZY9WxvQSoSA29KoI3/pQx1rndaV7o9zGVDzeECn5VEM/TvRl1KSuv0P0?=
 =?us-ascii?Q?S5fcG/nIXThK2UF0x6PqFagnCz8LqIi+bpDjibhO3Vy+vS9eSzF1kpPcaoTJ?=
 =?us-ascii?Q?g6WG5+FvGlFErnJrW8Ool3B6YKtFxgLgOXWVsDvKs1DkUjdys78sHoSvokPT?=
 =?us-ascii?Q?hK5wfQ9SpoP+qnuiO1oCy5EX5P6HsEdnSw8r09mvNNNPX3AwKC8pJnN/+HZo?=
 =?us-ascii?Q?JG5szJ9SUIPR/I9HgwT97YszbMYJvYiKosACVXNW94UEnh0Ku+vuwMZ8m69K?=
 =?us-ascii?Q?+TcPakjVA76AxgCVNa0GYvpbYr+ZnMqhCFiQC8SBvUVnL4ThYtMW3qL7Pnko?=
 =?us-ascii?Q?DGgQPcj9LTz+0MWiBPkRiYUp96XJU7ekIWRa6MPbb9VT+iOAeRdIsU928MlK?=
 =?us-ascii?Q?QyrXuTEJmxwiQzB2zjlwABPEwp75NRPnAHLn9wGi8kwZmbb2lz4jzH1xAktD?=
 =?us-ascii?Q?p5fohpWn0nIrDtop/FW5PSzmoBQK07J17OXOx8w0wJAvflv5JmW8QinNkDb5?=
 =?us-ascii?Q?t8k/N1h+zhoRXiJbVYchCCAUCsgQyAzCVEG4IEpWFDyYN93q0HLaWqPoSCJj?=
 =?us-ascii?Q?5rYAjSNNs3u5yK448GuMfizFULi/sTP1Ubi1uJnRhmFt+FEzt5zz6AywqaTe?=
 =?us-ascii?Q?VszDH+V96r38CWS83M5MEGG8WxR5QtSu+xsEoGZweXhgqG+3ToRuB2w5CIxa?=
 =?us-ascii?Q?zi4vU6g0iEcftBeDUGZgD/d5qwU7mwai6f3I3lX5Olt3mIZQn+mR9TyU0PLO?=
 =?us-ascii?Q?raBXx/keBCEpnqOMt9PTYMripbVhVy1nx2rz74BdCNy8jkjiAeGIa9fIpsKf?=
 =?us-ascii?Q?vneh5tDcQpuP3T7ClyQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc235180-45c7-47dc-9a8d-08db42119791
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 02:39:12.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVhTtE891PwwpwBEjBtZx3e+SnP64fJpqq+TDS/KWA7QyFC8H8IaDenWfWVFnBWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:04:12PM +0100, Petr Pavlu wrote:
> When making a DNS query inside the kernel using dns_query(), the request
> code can in rare cases end up creating a duplicate index key in the
> assoc_array of the destination keyring. It is eventually found by
> a BUG_ON() check in the assoc_array implementation and results in
> a crash.
> 
> Example report:
> [2158499.700025] kernel BUG at ../lib/assoc_array.c:652!
> [2158499.700039] invalid opcode: 0000 [#1] SMP PTI
> [2158499.700065] CPU: 3 PID: 31985 Comm: kworker/3:1 Kdump: loaded Not tainted 5.3.18-150300.59.90-default #1 SLE15-SP3
> [2158499.700096] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [2158499.700351] Workqueue: cifsiod cifs_resolve_server [cifs]
> [2158499.700380] RIP: 0010:assoc_array_insert+0x85f/0xa40
> [2158499.700401] Code: ff 74 2b 48 8b 3b 49 8b 45 18 4c 89 e6 48 83 e7 fe e8 95 ec 74 00 3b 45 88 7d db 85 c0 79 d4 0f 0b 0f 0b 0f 0b e8 41 f2 be ff <0f> 0b 0f 0b 81 7d 88 ff ff ff 7f 4c 89 eb 4c 8b ad 58 ff ff ff 0f
> [2158499.700448] RSP: 0018:ffffc0bd6187faf0 EFLAGS: 00010282
> [2158499.700470] RAX: ffff9f1ea7da2fe8 RBX: ffff9f1ea7da2fc1 RCX: 0000000000000005
> [2158499.700492] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000000
> [2158499.700515] RBP: ffffc0bd6187fbb0 R08: ffff9f185faf1100 R09: 0000000000000000
> [2158499.700538] R10: ffff9f1ea7da2cc0 R11: 000000005ed8cec8 R12: ffffc0bd6187fc28
> [2158499.700561] R13: ffff9f15feb8d000 R14: ffff9f1ea7da2fc0 R15: ffff9f168dc0d740
> [2158499.700585] FS:  0000000000000000(0000) GS:ffff9f185fac0000(0000) knlGS:0000000000000000
> [2158499.700610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [2158499.700630] CR2: 00007fdd94fca238 CR3: 0000000809d8c006 CR4: 00000000003706e0
> [2158499.700702] Call Trace:
> [2158499.700741]  ? key_alloc+0x447/0x4b0
> [2158499.700768]  ? __key_link_begin+0x43/0xa0
> [2158499.700790]  __key_link_begin+0x43/0xa0
> [2158499.700814]  request_key_and_link+0x2c7/0x730
> [2158499.700847]  ? dns_resolver_read+0x20/0x20 [dns_resolver]
> [2158499.700873]  ? key_default_cmp+0x20/0x20
> [2158499.700898]  request_key_tag+0x43/0xa0
> [2158499.700926]  dns_query+0x114/0x2ca [dns_resolver]
> [2158499.701127]  dns_resolve_server_name_to_ip+0x194/0x310 [cifs]
> [2158499.701164]  ? scnprintf+0x49/0x90
> [2158499.701190]  ? __switch_to_asm+0x40/0x70
> [2158499.701211]  ? __switch_to_asm+0x34/0x70
> [2158499.701405]  reconn_set_ipaddr_from_hostname+0x81/0x2a0 [cifs]
> [2158499.701603]  cifs_resolve_server+0x4b/0xd0 [cifs]
> [2158499.701632]  process_one_work+0x1f8/0x3e0
> [2158499.701658]  worker_thread+0x2d/0x3f0
> [2158499.701682]  ? process_one_work+0x3e0/0x3e0
> [2158499.701703]  kthread+0x10d/0x130
> [2158499.701723]  ? kthread_park+0xb0/0xb0
> [2158499.701746]  ret_from_fork+0x1f/0x40
> 
> The situation occurs as follows:
> * Some kernel facility invokes dns_query() to resolve a hostname, for
>   example, "abcdef". The function registers its global DNS resolver
>   cache as current->cred.thread_keyring and passes the query to
>   request_key_net() -> request_key_tag() -> request_key_and_link().
> * Function request_key_and_link() creates a keyring_search_context
>   object. Its match_data.cmp method gets set via a call to
>   type->match_preparse() (resolves to dns_resolver_match_preparse()) to
>   dns_resolver_cmp().
> * Function request_key_and_link() continues and invokes
>   search_process_keyrings_rcu() which returns that a given key was not
>   found. The control is then passed to request_key_and_link() ->
>   construct_alloc_key().
> * Concurrently to that, a second task similarly makes a DNS query for
>   "abcdef." and its result gets inserted into the DNS resolver cache.
> * Back on the first task, function construct_alloc_key() first runs
>   __key_link_begin() to determine an assoc_array_edit operation to
>   insert a new key. Index keys in the array are compared exactly as-is,
>   using keyring_compare_object(). The operation finds that "abcdef" is
>   not yet present in the destination keyring.
> * Function construct_alloc_key() continues and checks if a given key is
>   already present on some keyring by again calling
>   search_process_keyrings_rcu(). This search is done using
>   dns_resolver_cmp() and "abcdef" gets matched with now present key
>   "abcdef.".
> * The found key is linked on the destination keyring by calling
>   __key_link() and using the previously calculated assoc_array_edit
>   operation. This inserts the "abcdef." key in the array but creates
>   a duplicity because the same index key is already present.
> 
> Fix the problem by postponing __key_link_begin() in
> construct_alloc_key() until an actual key which should be linked into
> the destination keyring is determined.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

I have reviewed this patch. Feel free to add: 

Reviewed-by: Joey Lee <jlee@suse.com>

Thanks
Joey Lee

> ---
>  security/keys/request_key.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index 2da4404276f0..04eb7e4cedad 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -398,17 +398,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
>  
>  	if (dest_keyring) {
> -		ret = __key_link_lock(dest_keyring, &ctx->index_key);
> +		ret = __key_link_lock(dest_keyring, &key->index_key);
>  		if (ret < 0)
>  			goto link_lock_failed;
> -		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
> -		if (ret < 0)
> -			goto link_prealloc_failed;
>  	}
>  
> -	/* attach the key to the destination keyring under lock, but we do need
> +	/*
> +	 * Attach the key to the destination keyring under lock, but we do need
>  	 * to do another check just in case someone beat us to it whilst we
> -	 * waited for locks */
> +	 * waited for locks.
> +	 *
> +	 * The caller might specify a comparison function which looks for keys
> +	 * that do not exactly match but are still equivalent from the caller's
> +	 * perspective. The __key_link_begin() operation must be done only after
> +	 * an actual key is determined.
> +	 */
>  	mutex_lock(&key_construction_mutex);
>  
>  	rcu_read_lock();
> @@ -417,12 +421,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	if (!IS_ERR(key_ref))
>  		goto key_already_present;
>  
> -	if (dest_keyring)
> +	if (dest_keyring) {
> +		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
> +		if (ret < 0)
> +			goto link_alloc_failed;
>  		__key_link(dest_keyring, key, &edit);
> +	}
>  
>  	mutex_unlock(&key_construction_mutex);
>  	if (dest_keyring)
> -		__key_link_end(dest_keyring, &ctx->index_key, edit);
> +		__key_link_end(dest_keyring, &key->index_key, edit);
>  	mutex_unlock(&user->cons_lock);
>  	*_key = key;
>  	kleave(" = 0 [%d]", key_serial(key));
> @@ -435,10 +443,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	mutex_unlock(&key_construction_mutex);
>  	key = key_ref_to_ptr(key_ref);
>  	if (dest_keyring) {
> +		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
> +		if (ret < 0)
> +			goto link_alloc_failed_unlocked;
>  		ret = __key_link_check_live_key(dest_keyring, key);
>  		if (ret == 0)
>  			__key_link(dest_keyring, key, &edit);
> -		__key_link_end(dest_keyring, &ctx->index_key, edit);
> +		__key_link_end(dest_keyring, &key->index_key, edit);
>  		if (ret < 0)
>  			goto link_check_failed;
>  	}
> @@ -453,8 +464,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
>  	kleave(" = %d [linkcheck]", ret);
>  	return ret;
>  
> -link_prealloc_failed:
> -	__key_link_end(dest_keyring, &ctx->index_key, edit);
> +link_alloc_failed:
> +	mutex_unlock(&key_construction_mutex);
> +link_alloc_failed_unlocked:
> +	__key_link_end(dest_keyring, &key->index_key, edit);
>  link_lock_failed:
>  	mutex_unlock(&user->cons_lock);
>  	key_put(key);
