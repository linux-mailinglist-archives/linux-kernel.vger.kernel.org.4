Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ADA73EE94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFZWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFZWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:18:36 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492093;
        Mon, 26 Jun 2023 15:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4K66eRMgiGjcZ9kFrm/Qhd89fCsCCddBetkLxfyrIahJHVfkDB911lEzXOfm7zyKdHY9rJF54s6mLepS0Sl7gfSrRL7yAuMRwiRmi5zRCcuJaIgBPVtGRqLq30Tx1O/WmIYGwIjw1NjVIMz6+o18nBP4LB4PlLTSJXHXS4WeuqRF5amPrhWKI/duSefj1NO4cI9og5BEOO48UQV6bp7tdKFgaYfI5k9zw3s/GQSWInoZglefMKqJDECay+4E37Cn9/heHWQXf3PEsj1s71EIo6xDpJvruDS3KMxzPvy4RNLmwiJdMC7702qUC6fu+NfXk2ZpXqBdoDk99x5V2Wlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kI/gw8SKfiSKqDR8uaPmeAjHZ7Lubzqvx3MLZko33A=;
 b=hLxdAbgQ73TKCd/oQUe23e3UCZKoScOX3loT23nVq3zeXZo90MQecpjG11uAvlbMh20XIcg+Km10RI48nGA7g26RlMX2J+DAhyEAh9grcl7mXcDy4QVwUJTG8Y4B2Kky/ClQ6KOTglZaH8bFGwPVoOrj2F5cEcOugt/1YHqsWaxF6NBDclBgnxGSD69qCdz1celBsFYKjQP3NaehkXUs52BrXkU73+7bynxON+nI4zAEIs3m6efZjpvW1r96/mCIVDo0CI4iWDTUsFWw/NOffLmHMDyPZO9hCZGO8hGZ1xTuKLlqDfvyHn8xKZbccMJ8b5hVzOXF2oqHXzEhUGZy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kI/gw8SKfiSKqDR8uaPmeAjHZ7Lubzqvx3MLZko33A=;
 b=cPlwX+aQJ+YA7PVB3lNUtU3ggIaGdYDb4Hg82FLVjzVeIJ7mlaceT+Xf7CCogll0V/v0qyoVFgq0bI2vR0xEyF4TivKY7xqB8onNaxvd7vzUTU7SOIsulP1fsYKQjaw/EH0DKWCQG0bbYV32jlFvavacqADy0jQsTN5f/nLVT7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 22:18:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 22:18:32 +0000
Date:   Tue, 27 Jun 2023 01:18:28 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port
 information from INCL_SRCPT
Message-ID: <20230626221828.qzjeo6dedjnyme6k@skbuf>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
 <20230626155112.3155993-3-vladimir.oltean@nxp.com>
 <ZJnU6WntVQW2AgvZ@corigine.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJnU6WntVQW2AgvZ@corigine.com>
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c6c987-da5a-48d4-b80d-08db769346d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cCsSUwNI38JfP77L8NCtt8AWi2GNrTSKSKW8IxE1o4vRt91+vqshKxpr06vTBeLiZWhPx53QYzuV8hmwrXDTlbXZ0VS/o4rjpnX+qmO0KlcKaDXu4CTk0tNhQt7d6ksvCYFhOAHnhWN6rn/DN6/56PyjcUqpc4zOUuzxwITGK3OyUmaM/4NiiqgkzwXD8o9yiE8nZLwTVja7Y1iAbURAoAzIbLX81cD6j3TRwbc4ASrtk8Wmnm3ZCjNfhOtmHbKXh3kxeJVOP+QApn1xTEKdGkLqJhrkksrtUu6IprQyvurcjuzae8Dcy5l0E5Bk77lHFd1bdCSKWFmyoBKxJXTABMXDdvSIbk+rUupJMBIHEMDJNuL9pQdcZWgVRnK3Lf02AGj+ij6lPVklEjLpv5AgVLM4sn2RhWN/EDQCl9+7lsomvkMa+UsWBAcjq0oG4tiVP9MOe1IKvR2XBUSJJwqftxo4vmIlEFwzs1N1qFMdKHCOmIdoh243vB2BegL+aasGneQqSDgi0LxM9KWR2LOR6c7kKX0pHYMv8Q3e4rhKZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(26005)(2906002)(44832011)(186003)(33716001)(8676002)(6666004)(6916009)(478600001)(54906003)(316002)(966005)(6486002)(4326008)(86362001)(38100700002)(1076003)(41300700001)(5660300002)(83380400001)(8936002)(66476007)(66556008)(66946007)(9686003)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6/wY2FbVXYPMQgCHGLQUJ/tKNr3ujAGw6vR9i824SzgG1dQ0sqrcb7TARFk?=
 =?us-ascii?Q?cDWZ8LspCiFXWuppJucv4Oq8DRT/XuvfmhAU5xrbNeWNcugAugCusLPINE/Q?=
 =?us-ascii?Q?VfHito+tDxpajsPC/j3/U3LOWOOen220QBVWROB27iI7o986hDQpppECU+Xf?=
 =?us-ascii?Q?C4ZHq+w7ZVhqWkf21YrHqb2vaoIMcY5w+PjiQhNnZlePd6g7zo5IisvxQlfF?=
 =?us-ascii?Q?1ox1lGBeOjtzCFnYGrVhcQqy5JSf88NdmaXIByZ8i6uyW2ixEczrfrSu0bbM?=
 =?us-ascii?Q?Y43mr2Ccf7KEmgoiFrqmL0E1rh1uSvVeoMsffPzjcFrUIzpRr5bUmdlVUZ7F?=
 =?us-ascii?Q?e3zMhHjNRpDDmbVDWZwHum7I842h6XA7GlbJeAMI04+4XTqtHPIgcw41wau5?=
 =?us-ascii?Q?oHfh7naH2KM7z3dvEjPoxC/RGHqDj62bpQr/3waYX71QGrWflXccsiV0HqA1?=
 =?us-ascii?Q?3WcE2AT1CEYXQJqiE3srpXA4VcdnxOzodaZ3F33HRVXSmnvi+ypOx2h1PoFv?=
 =?us-ascii?Q?NgkJpMHknL9KBS01olOjg3re7/JQTDktIrVOcjaFlTJivEYWU+KLLKFVZBlB?=
 =?us-ascii?Q?W7h5I5CD5VbJtq1AQsENYl/yf+GLe5QhuCLHE2CSPBIcES1t1v1ZjXD3U9i3?=
 =?us-ascii?Q?LbqboW+sJtH8y1UP75/MtCqRjg45Z+vzWbekVYfM0t/ZLvPsz9lNhDHGftCF?=
 =?us-ascii?Q?fF6NzNakoQjMzENsdvrphm7UoEH9YgIlHwwh3LqbL7jvRY3muPQMgxPq4XyP?=
 =?us-ascii?Q?OKGJlp+Y2NlE1ptfc/Wd/5ztcgZ5Ao0sy0pwzoTwTD8/whgwkM55M1Fp6ZvT?=
 =?us-ascii?Q?Ht6A/E19eEDaWefMZws3mqnoGKR343bb6iamVOhXV9uCsQVrnSJHXDvCJ2w+?=
 =?us-ascii?Q?is+i+jc0yrxbaJBUjNIhzaggjWzYtKFi3YwoOcnHC0cRi+yPgV8iZruSYptY?=
 =?us-ascii?Q?oexEBcXhoc8LW+MI86Wnx4JG1ZAgPblo9LHKecfYiMtDx+M/HK1/F+e5m/ku?=
 =?us-ascii?Q?L5lbbbD7ZZYvKoG3s8DrEDonMQx55qJfjIKUdXnaMZajlqv/kIMwsiuJjHe4?=
 =?us-ascii?Q?vf+h1p09sIHm9YmD6Z70vS8nmJrzAQ36myiaepO/yqs/iw8ApwuFSKoVKeZY?=
 =?us-ascii?Q?ZrEguDTU/gniT1KL+TX8Bn4Z+MwcrogyKMXICCyixzzFM/istLIr743W7pko?=
 =?us-ascii?Q?SmoVhx506P28PaKkfjI65gr0EOK+QtF9x1h3s1Fyccofcc2H6YmAmbSf6QCH?=
 =?us-ascii?Q?XLHwwOOxVf763Z8720Ydzls/srCNYhfa1dfgN9DNqoyqdwbqmCEl51dy2mRV?=
 =?us-ascii?Q?lSVsiXYc5iQNU01NKC3Md8+b4wKsa+q/Wzm5OiPQrUvQwf5+UzbVxok/xdpp?=
 =?us-ascii?Q?PDbmGhLuA6ikX0enheTnVaYF+14B8Zb1Crfv6K1CuLhVOKuLFDJqlTqYoIgu?=
 =?us-ascii?Q?2Up3mCpONKHt55CmGWh761vw7JTx0eG6McT+8lo6vNKka6wR4t1v3oHWSlki?=
 =?us-ascii?Q?tEGT7FKF5GhHEh2wcTDzUkdel1BX1hbQthp/23y4BDs70hgdSpT15hDzU5yS?=
 =?us-ascii?Q?olNEHRh/7k6bTN/qdP0VreaCvz9JpcC2xkHALZUkFBwpojcyrvLOGHESsMid?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c6c987-da5a-48d4-b80d-08db769346d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 22:18:32.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQuZDxkxmNHXffmciEGqPabriC5wdSJcndITsN1NNXnVkqashsuqf3PvM+pyy8EIBfPTcUAFAoaFUcGkSRJIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Mon, Jun 26, 2023 at 08:11:53PM +0200, Simon Horman wrote:
> Hi Vladimir,
> 
> A similar comment to that made for [1], though the code is somewhat
> different to that case: are you sure vid is initialised here?
> GCC 12 and Smatch seem unsure about it.
> 
> [1] Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based on 8021q
>     https://lore.kernel.org/all/ZJg2M+Qvg3Fv73CH@corigine.com/

"vid" can be uninitialized if the tagger is fed a junk packet (a
non-link-local, non-meta packet that also has no tag_8021q header).

The immediate answer that comes to mind is: it depends on how the driver
configures the hardware to send packets to the CPU (and it will never
configure the switch in that way).

But, between the sja1105 driver configuring the switch in a certain way
and the tag_sja1105 driver seeing the results of that, there's also the
DSA master driver (can be any net_device) which can alter the packet in
a nonsensical way, like remove the VLAN header for some reason.

Considering the fact that the DSA master can have tc rules on its
ingress path which do just that, it would probably be wise to be
defensive about this. So I can probably add:

	if (sja1105_skb_has_tag_8021q(skb)) {
		... // existing call to sja1105_vlan_rcv() here
	} else if (source_port == -1 && switch_id == -1) {
		/* Packets with no source information have no chance of
		 * getting accepted, drop them straight away.
		 */
		return NULL;
	}

This "else if" block should ensure that when "vid" is uninitialized,
either "source_port" and "switch_id", or "vbid", always have valid values.
