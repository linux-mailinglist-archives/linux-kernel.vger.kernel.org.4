Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C6742929
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjF2PLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:11:38 -0400
Received: from mail-dm6nam10on2091.outbound.protection.outlook.com ([40.107.93.91]:58401
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbjF2PLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoqzT/csyuuEC2Wm4/QtsCcXMf/2Sh+AhQaiZUBI+T6CHl9FIIii0VvI5JK4DdrYY5fs4p1NIBoO3fY99gpSCUeqfzv7HhGapAwMsgX+JGJAL+GnYfjyl/+hJY9okZX+OdniN7kMaBLu02cVpzImBz3lv2h21VPHHY8TPf6kDbhmz7b9tZ0N5ZoFfgXrKmr3wE13Kg2f84NtYyFH+0Ps6HkHudXAxOHZ1wziU9Mvj7nVrsSdyoX/qUBsm+FoVau909VCP41im/AS9zMolgioZb/SOqsTBT72UjRoGqy+lm/Hfpf64oyPwJ9OvBfTYuRtaIzM+obV6PionxsHwhEKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAjyYwDFd/X8kODfQ1FGGG/Y/9aTBIR5bOuWk2BIAiA=;
 b=Gt3+4DN6MxoVN7eeZM1Pc8PIVZsM7iS2UMHQQ+9lD+ztG4LtIGDNSEqdeueone8dYheIpgZU+4d9X5cIVUIl4Bx5Twkh8+I0qhsyj4hRo63re2JZfKcUjOsIh420HB1tbGjUTKzyGKrEzk85ZQA86C8g5O+hoLogyowkvDSW/9uWMEGJfi+aoGD/jNxdbodOONpynpZk7SVbk1xlH5KunSfByr4OQbeUVneDbqc1BkLpf4d9hqYwEqPR+4GZGO1oExQBFA4ZHZjVQKvjDN9j0wM78Ucp2GH9w8UbYZ77JOWpV7iq5as/NC3wLAnsVWyskmkdQQjjhELcVU7q+XXP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAjyYwDFd/X8kODfQ1FGGG/Y/9aTBIR5bOuWk2BIAiA=;
 b=f5Ws5BbncsANw/rZbaWUlE/iQIvrOy8W1pCz3UrQkuyA7lo7nELPClipC+4+RWfxEIPs+ugYNv5uMAazsZl1Vw5yRotJUfJN1gWj50aaklwQchJEgkkB04an85im6DgjSlYNh6cAphW/ma87svJTmlSA17T8cJsLUXcQn/nuKyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5791.namprd13.prod.outlook.com (2603:10b6:806:21a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 29 Jun
 2023 15:11:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 15:11:29 +0000
Date:   Thu, 29 Jun 2023 17:11:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/1] netlink: Don't use int as bool in
 netlink_update_socket_mc()
Message-ID: <ZJ2fG/2AzJ5O0IFr@corigine.com>
References: <20230629133131.83284-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629133131.83284-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: AM8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2c6354-4f1a-44cc-59d5-08db78b31d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqaqCqkFzkzdkneIWsSiavHu8NTU3gWTf+P6P6bSs4nI2iiWLV7sPmYf2T/muwhy6dThXWTjYuj4Mq/pypnwyAbwx/3Rp5bcGUJhc3FNwh6E4Af81iow38R/yb+YVe4VhhjeidjeM0aenAsaYBBHIVS1qllWJDHn28zl5wgJuAGQwyNJrXkXd985sR2GMOql4xVR6fHowrlc1DpTyX/bVpzaw1JP39imU5UMbFBo3VfUau/ndJDiws74kMBujl8bylCFA1Gr7TT6OkaYRHuUaBsWThbzsSdW4dBOSCvgQ8CIQr5yPQBFSR692vrub6KlyRoOUlKN3pg9kr7MauUl7C2fur8IXHj1uDkzAs8YHwCWGf/PAp8Pz0XZEXFI1XSHOiqGbT0Y8sN1zn33wdQ48+36HtNRCPmetsrQQFIYXgLCRfyuQ21iNKhPT9SfLVNRAE5q2B7w9M35AQStfoDmKEUrSDia9k8yB4JgMY5t8RJSsk/8Z1bbYcq6VAgvF3amLjq6v7xlH8kVjlL/3ZaCK5qiDDUaIWga/uYE+bZ3P6X4h6k35iERka9F1ed3hki6ASbVC3+r2EViKbxuxf1ZSXu1hG97atRvWP2O/YKjPZFjwApYqougpfenULMF2jgwd2FJ1dIwltsJsb45NxvN+YXxPbmK+2j8WJMZTW7MVWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(136003)(346002)(396003)(451199021)(6666004)(41300700001)(316002)(6486002)(2616005)(44832011)(186003)(6512007)(86362001)(2906002)(83380400001)(6506007)(38100700002)(8936002)(5660300002)(36756003)(66946007)(6916009)(66556008)(54906003)(478600001)(4326008)(8676002)(66476007)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31OCaLbZzI7oJqM4UsGgbuL0yB/54LIm/pKEmQGow9ZUBI2K6IWSIFMM3M3M?=
 =?us-ascii?Q?NBFVKgw2Rr2sT+Z4yz1QtaMDnuWJhBoWKW4nPeAKQIyV0d/8jTzve4h6QV3b?=
 =?us-ascii?Q?46wRI7apjhqbxR5gkcGX4yX9O6Z2biJTUq4Y2Cgd2mWYuVGxvFfNvaUs46So?=
 =?us-ascii?Q?smRf0b42vs3q8yAwsx/KF4Sk70Kz5+ovH4b8tqm2Hs8tKvw/pv8Pbitqa8fa?=
 =?us-ascii?Q?ppKn+qTX/f5Vl25ZzURGfXfagvNH4CIbTkT8H+F5vUBny+08r0hTYBESVR48?=
 =?us-ascii?Q?TDYfjOfIxfLHDrnN3gyTYXbn1gervZKRK/u6/bVU9FAJN2niRw9atBNiuaBb?=
 =?us-ascii?Q?cKnSw9EkfX/sdXjCNH1wKm1z5fIq7NT42YWUf5Z81ko9Xq+HsLIXVwJcskMw?=
 =?us-ascii?Q?pXij2JPwZ51+uoWNB2vji6BYrwYJWPW+srYvhggWGP+l4IcJycYxkcCC0H3Z?=
 =?us-ascii?Q?jyMfRtSKRdDmyqScaV9L66H9wZ5FndYr199CteYj57nHrYTuj5BXjE4hNDJp?=
 =?us-ascii?Q?orkCsJ8bk2vaYiTwdmQMEITGbTWSHC6t4lBT/1SEMtHK8XwxSsoyjlhbZzTR?=
 =?us-ascii?Q?1FcX99Z8aMadhcm6rcIHENv09EzsIjIsP51ZiGRi6fXpGxdZHsiqZiTy+C1R?=
 =?us-ascii?Q?2rGyNcr8HqkmHy8xfxdZoxu8oera/QlXDKt97K/1W69eozekUsoT5QIhnWR9?=
 =?us-ascii?Q?nnxPoRVltBquAxv9P++c8zg6ye7HW1KalkOfHF3/j9IIn5NQBhSBGStKALug?=
 =?us-ascii?Q?nMsLKwH5nZrrkCr2HcrYslDM8bLDXa6tAC7S/m3OOK5Wk3ouPt0Ud/ORka3m?=
 =?us-ascii?Q?HamtK7yRivFcDUHcyrscJWr+UBWudlPcHA1UbRqVFUK4wisvrZ20ooRg2VEc?=
 =?us-ascii?Q?b2GpMV+UZj27fn7CHz/+REofw+yE+JD3LcNm/aIfVpZmsezHGQTmLOZyGmc0?=
 =?us-ascii?Q?u1kTrbuva/+/Xdcq4e+54Jf36sjaCuXHjJSQ8mAJxbQcwYJlIlHvhgiv4H0l?=
 =?us-ascii?Q?PcRbX6GWGI7G+lXSuxVazj+0S81ZsMIESl9eHhDu8RMapIfbe8CPjCkJcGYP?=
 =?us-ascii?Q?a8POpv4DiR47J4iPRaseSJ914YnJj2XfSrQBwBQ0m8Zz7ebqXUyEoXA0xXmf?=
 =?us-ascii?Q?Z/3xeLOlHWcabKRXgMyPlJRg/1U6WjZxKmug1WDd9eBpxhh888i3cTQt74sW?=
 =?us-ascii?Q?N8LwgBk1fX8kmqyNgqt+8nW5FIJFY7SXaMv64ioA3seQfsXtOis4BX6n93dP?=
 =?us-ascii?Q?6luWbuCXQmuiTEnvs2xOmh9CgZBv7p43SQNA0Rqkuo+Co9SzcrjSHlZ5J5En?=
 =?us-ascii?Q?sbDeihHdbB9fsmzcSh2Zhp0G0TBP4sf6SJJINzZzu9DOrqOHhDjrfPmqdxIX?=
 =?us-ascii?Q?CqqOi+azXuGdbMbZivoF88tTG6pBeKJUotMpLUBNu6sQUuCr32hihQLUIwP5?=
 =?us-ascii?Q?rhEYdztBEEX3xL5QJ5jgBR0obhiXOVjKZgBiGBFhVfr0lbq17S2vAy4vWRT1?=
 =?us-ascii?Q?vkG7asugdbMQB02QJUAqFWE1eC16xxNaWT9BWPQCAapJZpKNXOHSZk7bqZYK?=
 =?us-ascii?Q?W6Ww6WhebsfcZ/CkfPbB54ZL7MrtQy1qv665kmfHYzMb7kVlBEZE7i/p7kqS?=
 =?us-ascii?Q?uZChPWgFrK2agOSYl8yvglpn4mTyEVsYdZ/MSh3pnvS9WgqgE8dq7o+kMsVM?=
 =?us-ascii?Q?GXZmoQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2c6354-4f1a-44cc-59d5-08db78b31d80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:11:29.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: indXXDV5fE9QaMq1mEvKN2NAg+apBvYhTqSXste/dYti4claNzja4FNYUJkvv1ebTvVN+7s++2AutSdB0oqfHdCM1Z2vNS/nFFAYthvTlDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5791
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:31:31PM +0300, Andy Shevchenko wrote:
> The bit operations take boolean parameter and return also boolean
> (in test_bit()-like cases). Don't threat booleans as integers when
> it's not needed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  net/netlink/af_netlink.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 9c9df143a2ec..81e4b802f3f9 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
>  /* must be called with netlink table grabbed */
>  static void netlink_update_socket_mc(struct netlink_sock *nlk,
>  				     unsigned int group,
> -				     int is_new)
> +				     bool new)
>  {
> -	int old, new = !!is_new, subscriptions;
> +	int subscriptions;
> +	bool old;
>  
>  	old = test_bit(group - 1, nlk->groups);
>  	subscriptions = nlk->subscriptions - old + new;

Hi Andy,

Doing arithmetic with boolean values doesn't seem right to me.

In any case, net-next is closed.
Please consider reposting once it re-opens, after 10th July.

--
pw-bot: deferred
