Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE773E743
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjFZSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFZSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:12:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B51BF8;
        Mon, 26 Jun 2023 11:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbjaUsLFq0JrnwNhshQOGoD7hb5fdEdH47x2e4ahk2Aw2P6ZmutInqRrcFt4VZB5EaoJ+76HNvEXGi6ihXcTImcOSvZO0dilH/h7+hYYl7qoY4YvPrYqqBQz/vgR4rn9/HqayuuFfyEKSD6uqorlGPWvHeSv4/HXyFNXH3d+jj0DWssvHScrVlvpm1Amd+dNvJ5xa8Zynpd0z+YeNIwS5f0Qzy0k16V+ynXpwMtOxWS+7o5KaqvFS78oRf90Q4lXRetURGCVYa3PlC8kBUNMDKCBigSzrLMazZ1NDjGpS8S1P4IEoOajyD+f6lC/fx1WXGXxGgzfPMqf6MgQ6WPo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4FWj5G9EFufV8pRQJpQrGUMJYkrxwleLghWXdKZKyY=;
 b=OK8OdxeekwEio1TtwTfrit8Gxe72rCfsgUJz8YZ0hQVCnYGgJXFsYU8GzxOWyw2kW8ebDq0H+tLGgEQ1EMHHqr/z928nFSBGmLG6rP8R1U977SeNPQMz72zIsM5Veav3E2FBBU/xDLAzhm8mAxbByP9tFCxkpSQxTRqdQY+Ls2/Ny/NCKLtw/Y8iXijiMdG0CiJpPRwyfS6b+Ie3TP4l35qp1LLvfMsT3T7x5LfbWfaYS9fiJVhNG6NOGWblxGtqtW5NpdY4uHIvBRrnos14/eXVSknvQyIliXyIHg8FPOKwavynrCi/wJ4ZITmh/ex27Rk0UWWaxf9883nZ7KomvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4FWj5G9EFufV8pRQJpQrGUMJYkrxwleLghWXdKZKyY=;
 b=TtEHb/IF9Gm4SAp+eSA/nGeDS1DOGMZDOVGVGja7HS+cFnTvknz0yxrdB6waPt+6ZAgeZhhJW/XDfp869TmNf9FSgopouEBtR1C7t67VcBPmY+eQvQp3Ul9LC7/y3l3DhobMjQI5NChdAG8j5kOlPpEGKwKEMy3HW9H6lJqnIsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5263.namprd13.prod.outlook.com (2603:10b6:806:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 18:11:59 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 18:11:59 +0000
Date:   Mon, 26 Jun 2023 20:11:53 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port
 information from INCL_SRCPT
Message-ID: <ZJnU6WntVQW2AgvZ@corigine.com>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
 <20230626155112.3155993-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626155112.3155993-3-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: c76b0e7d-0e31-441c-1191-08db7670d517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuvfzG1/Eh0juF4o0XnACWnQlaZNLWoNia+Xv2H4ggOOK9lJyR6B97oRuVdD++OE13Z1jYFIezgRE+TkJ0bYCBLGgNSRoD9FUjaqxq+XRQXKIt7cg8UQ9M3ByVCf6/hkUqdVZ5bfeYiOZX7C5SBl2SXoppBOZt4kdAn2QR+X2Iqzxih5qL3SMbfmJsZls10UUd/Vtexhce9H8FziZ9l9piN9HE2x9Xwwq3DCOHXOk9iST3ipXmh1h1GQw3ZM3Ws2F3SNKat8XMxdKEfpzqEH5SonEBZQnXOfJV+hbWYKBOUGL33CzlBQqLAHph3NfVRXMJMsHpyrE5mN7YNlK1xm0J0GYuQ3AamgPMOlqyQzmGXhdpQ/yxZ82+KNZeMTMFc5ELaLZ581psA7xRblIiWbhZtyp/x+/1QkxTcGSHfJ5pDrqyVy2/AFUBdgnNevIOuTv6BP1KKLtHVNUVv2yVXUZgCAS4QmMx+vaeRjmcvtdUe/Mtc3SCMv6RlVWnB/Qu7aRLvW/aS1+0FxZchMFpcREjag9kkN13TB3s+uQZs46fQq02MPiPmdISM3lFeRGeDW3hnNjEa8hycrcWk127DKIExraNi5UKOTXvCoQXPZIJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39840400004)(396003)(136003)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(186003)(966005)(41300700001)(86362001)(54906003)(478600001)(66556008)(66476007)(316002)(66946007)(4326008)(6916009)(8676002)(8936002)(5660300002)(36756003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72cLIinK2OUoT8kbT5JEw9YJRdoBV7B5J0xZxos19VZMuG04/k81MIsNUv0j?=
 =?us-ascii?Q?u5T1cl4DaYr44YhEcO0/ZIY+AQ9/MMO0fpFH+xbBINhloGPfxphafGqaJj4q?=
 =?us-ascii?Q?ewupZVHjYJwftylKGoZd3Mn9B/OkVjKQsu5Ta6pKo6URTQWhYT2UswXj3Sdj?=
 =?us-ascii?Q?MUG71UwNPy1++3ipAlejJoHIVjBZpY3FpQvUgEhJP8rVWaztTRdXCjobwZj7?=
 =?us-ascii?Q?837lPQ6FfWTvVnVIHDjmJ3foEAD+0Zdw1U+IOqb7N0kteuCNhANLSf7+c85u?=
 =?us-ascii?Q?rqQ4Q8hp0LUU8fNYpTLjfAQy6HUzrkSAh7LbqjjKqXIEBTP0cjKDy8b7NjuG?=
 =?us-ascii?Q?XPUmGtbWA+REFq8yCOUsLEgGMAhVrVcUdjyPO9Fqa/UVNTzBb/hzz1tH/GIf?=
 =?us-ascii?Q?EMFsrP5HZEPhna31Bt+UsS5HgwBsHUUGj1lc5I0JZ0uE8NAzoL6CdfQa0hvz?=
 =?us-ascii?Q?JcnyFhBbb0qyg/Mukq5ZGc5IWpBkTb0FWpzbH3Y8orpPYD8i8MkhN7tP/SaV?=
 =?us-ascii?Q?0QHKCnrifT0E3coQpWbJhfoATD/IZ2r+Cu1dee1nCQZMFKIsH9qFW3LiQwNr?=
 =?us-ascii?Q?o98KyDg0pz+MdW/8QwxD1qfnRZUKrT/dlzz01r5U2TA/FFJQMFp7QNO30kfW?=
 =?us-ascii?Q?FSrEF4BNDnQkvSN1yp7vH8/c+NgEiKt05dk+Vy9zp2m/HZPR05taF1g/wYEq?=
 =?us-ascii?Q?hIzR9m2zGwLZJbqqSIsTnuGCP5qLTg0xVeOG4ECwH3WJBf8VgaanaZ9Zfoh7?=
 =?us-ascii?Q?IV/ofXfynPYf1tOMVAvGhfgOx4Dspjz+tJdiIJUo6D8SSYQVNJf1y8KgM4J+?=
 =?us-ascii?Q?Uw6iqj6e1/n2UHL8D+4Y0QLRBpe3OYjeieBHQJU1gY35dZjQELGgfI6vaY+B?=
 =?us-ascii?Q?aCjpSIsDY0kDisRTAemr/H76yif1KrYbSydp1BA21au1RnwQBA7cxY6FyhDv?=
 =?us-ascii?Q?W18pklT3yTy2kuP0q2yGrVWMj99cwoRQbzjJUukIl1knLxsCkWmeD7uQuYrj?=
 =?us-ascii?Q?0sAupvjy7PUAyqXNYnH0EPKOel60te/g+zCiqxGXiGna5kFW/YeX+u0CtB5B?=
 =?us-ascii?Q?mD9Qh+8tBR0NpP12bhTfwu7ggULWj/D9zhZPA96j4Dh1NC/gx6RIbAHpadI4?=
 =?us-ascii?Q?1AdlbZ6ZxSKeWEdt09YbI6VYEQM9L3/prfk879p/ssBGxMfthQeNCkpcidiE?=
 =?us-ascii?Q?gNXaf9ZmRYRI1DCKJ+K383VHKwyy8/K8c5ovURmqXdZdOsEYQodcneNMnN2p?=
 =?us-ascii?Q?oOrNgob3Xy+qPO9gskPTcF+/WnjMjkIC8oqerMAbxmUcJMQ+xQa8GnQub094?=
 =?us-ascii?Q?mHpJz/y+I9Ncx3dT1o+uwSj6hn0WiBg/o9SQEZx3/Okt13mJjg2zHwdzxe5a?=
 =?us-ascii?Q?Xr+GLddIPhp/gHAwDnUvvblRnsJei9iGSBThI/eMnJkpQl6ISREnrSuTzeTm?=
 =?us-ascii?Q?HEx+X/4ajsqm8+pbVxKvep+RMiIAGQQnrG3kror345lXgltKQkdw0yjJ/dvP?=
 =?us-ascii?Q?et/AnJsikIyUBatzVwlwWTbPOmnEusbAtePPFqdC1m9+8W3pNGq5P9L2iRxp?=
 =?us-ascii?Q?iIOCg+bypSFeYSTZ4v3SKFkkW8jEepz54k+m4RxOOkrM0PSTVYdO/uJ8BDT+?=
 =?us-ascii?Q?bYx1rFalp1JiUT/7AupZhcQoCuz0y724ENXVGA9BWItlbLg1DE+JtP1xZ+jL?=
 =?us-ascii?Q?T2ncBA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b0e7d-0e31-441c-1191-08db7670d517
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 18:11:59.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsLdalju03hgLiqy6R72A6syN64Pe/fW1mScz5+0o2EFuc6cOK6JzkEU4AYCWgCVPscd7iXAYnYj8glob/kxt9ObBXXPNpeWegmcPh6ifpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5263
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:51:12PM +0300, Vladimir Oltean wrote:
> Currently the sja1105 tagging protocol prefers using the source port
> information from the VLAN header if that is available, falling back to
> the INCL_SRCPT option if it isn't. The VLAN header is available for all
> frames except for META frames initiated by the switch (containing RX
> timestamps), and thus, the "if (is_link_local)" branch is practically
> dead.
> 
> The tag_8021q source port identification has become more loose
> ("imprecise") and will report a plausible rather than exact bridge port,
> when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
> traffic always needs to know the precise source port. With incorrect
> source port reporting, for example PTP traffic over 2 bridged ports will
> all be seen on sockets opened on the first such port, which is incorrect.
> 
> Now that the tagging protocol has been changed to make link-local frames
> always contain source port information, we can reverse the order of the
> checks so that we always give precedence to that information (which is
> always precise) in lieu of the tag_8021q VID which is only precise for a
> standalone port.
> 
> Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
> Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/dsa/tag_sja1105.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
> index a5f3b73da417..0e62eab8f251 100644
> --- a/net/dsa/tag_sja1105.c
> +++ b/net/dsa/tag_sja1105.c
> @@ -545,10 +545,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
>  	is_link_local = sja1105_is_link_local(skb);
>  	is_meta = sja1105_is_meta_frame(skb);
>  
> -	if (sja1105_skb_has_tag_8021q(skb)) {
> -		/* Normal traffic path. */
> -		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
> -	} else if (is_link_local) {
> +	if (is_link_local) {
>  		/* Management traffic path. Switch embeds the switch ID and
>  		 * port ID into bytes of the destination MAC, courtesy of
>  		 * the incl_srcpt options.
> @@ -562,16 +559,34 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
>  		sja1105_meta_unpack(skb, &meta);
>  		source_port = meta.source_port;
>  		switch_id = meta.switch_id;
> -	} else {
> -		return NULL;
>  	}
>  
> -	if (vbid >= 1)
> +	/* Normal data plane traffic and link-local frames are tagged with
> +	 * a tag_8021q VLAN which we have to strip
> +	 */
> +	if (sja1105_skb_has_tag_8021q(skb)) {
> +		int tmp_source_port = -1, tmp_switch_id = -1;
> +
> +		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vbid,
> +				 &vid);
> +		/* Preserve the source information from the INCL_SRCPT option,
> +		 * if available. This allows us to not overwrite a valid source
> +		 * port and switch ID with zeroes when receiving link-local
> +		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
> +		 * VLAN-aware bridged port (non-zero vid).
> +		 */
> +		if (source_port == -1)
> +			source_port = tmp_source_port;
> +		if (switch_id == -1)
> +			switch_id = tmp_switch_id;
> +	}
> +
> +	if (source_port != -1 && switch_id != -1)
> +		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
> +	else if (vbid >= 1)
>  		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
> -	else if (source_port == -1 || switch_id == -1)
> -		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
>  	else
> -		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
> +		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);

Hi Vladimir,

A similar comment to that made for [1], though the code is somewhat
different to that case: are you sure vid is initialised here?
GCC 12 and Smatch seem unsure about it.

[1] Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based on 8021q
    https://lore.kernel.org/all/ZJg2M+Qvg3Fv73CH@corigine.com/

>  	if (!skb->dev) {
>  		netdev_warn(netdev, "Couldn't decode source port\n");
>  		return NULL;
> -- 
> 2.34.1
> 
> 
