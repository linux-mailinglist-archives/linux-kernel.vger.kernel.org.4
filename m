Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A834273D10F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjFYMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFYMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:42:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::70d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512FAE51;
        Sun, 25 Jun 2023 05:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZf9TAT/miRRfetcjxAn0JGAbYTARHpKM+PsiFl+Hk64+rGxzJRsnY5DnWAjhJZ2wCJ4v3WLjJ6O6w11AR+uAcB5TfhHAZeEfbNE+cRlBU9kEJPPjCVgGxKfQVqU1LGtlgrGivFG4bCGJVkNH3TcWpxNPmCZaIFZ9ttgxaQnqPL5XDx6VvQO5uvJKQl3C70nURQpMaOLAM8b3pWBqDwPsrdGhETjvJHF2DhjD2w8U+TGuA1lJJJWBukdg4be/IUfXafw6532RcWJT0013/o/2jcEg/A9LV8YgwwqCuTGFpzXkKnOOFoOcD3AC34QXWCly8MogZLjnpfzk2O/z32Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgbweR0YYAHqwHlD11oHU17KIiR4xgQq+oZfg93vC5Q=;
 b=egFpm9bXmfMhRxw+6SuwqkqYLnfrysVF1YF8Tet9ow+4ubGUwFitv1eXi3ikofJI+TR/WEZg8EkaEX+O7TsmgIaEl0QeQFPcMXjxDcleeeD5Vmp1WUlhBOuR7zufFOWaiPYuSY9TJ7FgNPDroe1pqlhynFPmhwzLeNhLnp97ETpw/S25Xl86QKCfj2MVI42iYN5L75801jNTS7LJ4/zXJDa8yCHIA7n7yHf7KwxWoDdfJqRdCqLAzaoZwyM7duaONPCJwHAbcP5SZTg9Few/qx7C2UBdtOQthHtPHwtI7g86btMxEl2P7NC0l3/JumpNADT8v/mS2gL5IY7My7DyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgbweR0YYAHqwHlD11oHU17KIiR4xgQq+oZfg93vC5Q=;
 b=nzsekuU/X+ZQ+OC2hRDTJkEJ8hF380fwwC0mOANQbJ4e4VONuMu0UNJ2oRDKM+11mg/vTXq4mDDn2lTWMLaReCgGKSB6zic319lEgEZw/BpLC5NKMjgBV/4zyL0wnrshrpnn+1kl4Ta7SvxuPCtQvyRqXwVH0XUPo3vK2AHxAWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB5200.namprd13.prod.outlook.com (2603:10b6:408:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 12:42:34 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sun, 25 Jun 2023
 12:42:34 +0000
Date:   Sun, 25 Jun 2023 14:42:27 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based
 on 8021q
Message-ID: <ZJg2M+Qvg3Fv73CH@corigine.com>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-4-paweldembicki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-4-paweldembicki@gmail.com>
X-ClientProxiedBy: AM0PR03CA0064.eurprd03.prod.outlook.com (2603:10a6:208::41)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d29f0b8-428e-401b-f9c5-08db7579a5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cuT0SkceznXPTOoo1nRKRWVwZJspVAv0bYGJY8bwYeZh1f1xKDvjXlU0wZdnpRQU3nwXipobBma6rxe8W3xTCZ0bd0vmrS+DsToZLjRyn+9e8ugLw/D77iwU/FYUA1Qd/wt32FyyHW0fSNyRdg4bCDB4A04tkaSOm3SmKjPtvGmFmz/uf3IessnuP4BoYVmuNg97JcRjUhgzcGFbD5g5UkgzlqwxajpeUWFY+oeZFNHU6WLicHB1ZVUjm0hE+6BER6PzXbDXLK1yl+tz4KVfGobA65htHNMYo44+K9v+pxKfSqHJpoc0OrcvG3QtlF2RCh4RkfgC0AtQ5ocTM+U934FS7OrQJC/usayyDwUUjj0h+Rte5ZMwtFmS/a7yncAmsXLFNP7vOeM6LsXdVrgEvV9rFcsXNCTo0BsNEJYfLq1I3ogugWGXTrSgt5yDx7NC6bnLOF3X5GeSFcO0rAmOTPyFDVqoxErCnzOikUkWhnOfzUywKyI9VXoZi7uWq2Stl+xvezQ2IPc3/o5F9ntfHzANYtK33znCHiEkDUEjgX9vf6XehXr35gsn5SiqqpsyIT916eDBFZGDEaLV4ug1p8Bbds9oGjl7aHwsZU5bmQpa1gB6s7qkZfi7IimTh+pd9gHd9bAoUaB02H4ppIw2rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39840400004)(136003)(376002)(366004)(451199021)(186003)(2906002)(6666004)(7416002)(8676002)(36756003)(6916009)(316002)(54906003)(478600001)(6486002)(86362001)(4326008)(2616005)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(66946007)(66476007)(6512007)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+jAQ5J318OpA2PfFJzxRvftnuFzz6Xu4GOw4Acw5bmuvnA+qAtyIimmXhqP?=
 =?us-ascii?Q?iF1/vBm02O/sGCmaSuZPbDWqS1I8j+JOYVv/dBxpMkfgBDFBetmrSRgajazG?=
 =?us-ascii?Q?2i6klgVshtugXpDT0cNQxB4drtZ55MlnYn4bgK8kNuxraOrO41X/563mKb2m?=
 =?us-ascii?Q?iSq96fy14r7z7PUmyO/G0whdA8LJCZb9yTOpoEULfjKNaW8WGe6GalilRKem?=
 =?us-ascii?Q?Yuwi1777q0Ew5YRHL+dbw9jDloYqC50/kXu64IQWnFbgJ4vsDNhSyW9PINeS?=
 =?us-ascii?Q?5rpVOVB99+hX5QxX/56Ii6mV3jB9wazjSaTXKYkqgc07FkO70uzdi6Cpd6Nt?=
 =?us-ascii?Q?HovnDLehQ1WJRnpbQNuNmmOK5XCc/4vtr5eooxOn7wrivZ/Fl6HrxvdlJ0jj?=
 =?us-ascii?Q?IOl1De5actxNGuWDVcbHhwaoVNNs+lQcaQqOPIOGuXZmaMiNDkZs2yvPnATT?=
 =?us-ascii?Q?AxL0M3QOhTNF/WgMt3T/HDJUhWK5UfSd4tlMrurt7OCz88V17Bn7Hu3TWhAS?=
 =?us-ascii?Q?CqQPUwMR/Yt/SylYgMt2LQdyuZfIf5iPxeQb1wHapZdErYJ2uW9kvBeh64cS?=
 =?us-ascii?Q?x3XDjjnJh5ADeSR+y2rpINirXD7N0ArEBMoXjhBNXaTVCDyX69b0KbfPOlGe?=
 =?us-ascii?Q?dddX2QooQDk87stcsRWLUQfZ01W+COOJRHon8CgK4ma0F7UUkrvFVNJXDR8c?=
 =?us-ascii?Q?29FR9q/5L4bneqdUhpwLDx/znC2lioZ8wjQTuELAOVLyiMycGcKm1U7VnG0O?=
 =?us-ascii?Q?ttK410rNkKpRvqfdfJD6U8qB8ggve+gNoK1tqaqPNCjDadbr2R28GwB69wCx?=
 =?us-ascii?Q?8sZXXzfs54XKfjfy5Ugh6uGGU/eCNdg7HW+iBOqDxF2n0KTcT61JALpXo6Az?=
 =?us-ascii?Q?8PgzQmsCQHTI/YqAnTNTRsAoKoThEswn+JzLSiQJpGo5Lu5WoCeheTJ3zLU9?=
 =?us-ascii?Q?LhxcrZlUkQ7E25nNdsEpdLIy8IXActnOlzpC8TVH2FqMHpx7SXPABkaKXCuI?=
 =?us-ascii?Q?fLiNHDy5Vgtkgki52rgbqNOcjXDhcqTylLLJ16q/5RLkyGgoZVqiZjwxhog+?=
 =?us-ascii?Q?i3i+sBHOQHUVR+J1UPhRRmkzzUZf4EGGncRb+h9vqXXnFwbfS0ttiK9Iysko?=
 =?us-ascii?Q?1NmV9Rk91vMpnt1haSF2TcKTf/1zmP3QQfaIzKkNIevBcIjKzDAx75zIP4uQ?=
 =?us-ascii?Q?NQbiEOBN84cI+m7B7cO4zq0MEXtV3fGqNlw3lxyd6vh96AMhwBwXEN4vr6Rk?=
 =?us-ascii?Q?vBAFgupbCbU2qVUDHJR+Ct7HPVzDZukFtnh/daO73kSGdkXjnc/XcesAIBhb?=
 =?us-ascii?Q?hnIA+sHaWpy3o1wdIch3TqgYb8MTSm8Or7Us6NJ2H2bEnvb7Y50gwnFrtrRd?=
 =?us-ascii?Q?33eZP4d+msYYYylEGmjNjhey8mv9IriNQQj6G3aTpWZft2nIPv48p8gZbijN?=
 =?us-ascii?Q?mE6jzeN1tyxPTrRdoV2kntbNi5Dp+x+XcjMbUZHSuemAbDe74uIHZjNRVET9?=
 =?us-ascii?Q?dyDdsZmG3EYSm+DW0OR2XKuHyaxpO9SxBMm5131J2vjNCU4eSKFNY7TwS8ce?=
 =?us-ascii?Q?yZGXVlqdZqpxKhdq3/oRL6nahuXc7MJiPm/kun+FwC5jIO8K8I4N3ntAiZXt?=
 =?us-ascii?Q?VO6ItWBrm6OCRJOTOgJiB+Qxjn32M4nCPERGRVPpfUG1GWgk7blzxuvXHiYX?=
 =?us-ascii?Q?a6K3GA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d29f0b8-428e-401b-f9c5-08db7579a5f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:42:34.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4MLqiqPAUUWd5ZQ/nNm3VW4CsiKZlQ0e9YcciqfMhKWFMtyujyYIothzfIGhPJ2zmDWWLCF5HbEoKYEKKIz5YM8Td72ShlLeXUR8QsOJNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5200
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dan Carpenter

On Sun, Jun 25, 2023 at 01:53:39PM +0200, Pawel Dembicki wrote:
> This patch is simple implementation of 8021q tagging in vsc73xx driver.
> At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> family doesn't provide any tag support for external ethernet ports.
> 
> The only way is vlan-based tagging. It require constant hardware vlan
> filtering. VSC73XX family support provider bridging but QinQ only without
> fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
> 
> In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> frames.
> 
> Tag driver introduce most simple funcionality required for proper taging
> support.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

...

> +static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
> +			     int *switch_id, int *vbid, u16 *vid)
> +{
> +	if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
> +		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
> +
> +	/* Try our best with imprecise RX */
> +	*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
> +}
> +
> +static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb,
> +				   struct net_device *netdev)
> +{
> +	int src_port = -1, switch_id = -1, vbid = -1;
> +	u16 vid;
> +
> +	if (skb_vlan_tag_present(skb))
> +		/* Normal traffic path. */
> +		vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
> +
> +	if (vbid >= 1)
> +		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
> +	else if (src_port == -1 || switch_id == -1)
> +		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);

Hi Pawel,

Smatch warns that vid may be used uninitialised here.
And it's not clear to me why that cannot be the case.

> +	else
> +		skb->dev = dsa_master_find_slave(netdev, switch_id, src_port);
> +	if (!skb->dev) {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	if (dsa_port_is_vlan_filtering(dsa_slave_to_port(skb->dev)) &&
> +	    eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
> +		__vlan_hwaccel_clear_tag(skb);
> +
> +	return skb;
> +}

...
