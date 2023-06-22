Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30D73A07D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFVMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFVMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:04:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50E19BF;
        Thu, 22 Jun 2023 05:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmdPYziSqncs+wQ/2VsHTeFvu64gQ2Laxc3TowuBmoTbvnAM36rnnjZC1ikP8buBR+UEGaB7Rb0O7lL/eF9kC9Ucv0w1+Y4RUdN3lnSTAJfgq89IP/KQ7U2j+l9IPyQOuBP3Nijom9FRLAOhogSnTfDGcEg9fJgeZc62DvAOzt6n/esdKhOJ1Ho7XHPeixHqIS0oyhTI3PeMUO2NLt2NuvwlND06kaMJD6vUkhY0pmg5lYNUAC1T/C3eK7VprQbAzkB4kVFrgRMmcWgcuM+TnT4skuGd2VWKrhI8ysEJ+Ii/jzjLfysQOHCfWhm4WeO0j/cSBZV9FlXczvKhlu59hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEpRwbGBlTga8FlYx/wRem031kpGZkeYvYIuFRG+GXg=;
 b=l5dEP0zbmEgChFrg573we69yVg0htiNSIodkyNa4P7iaKrayP+8OKElgdzj6OFdUonL5MZVzIYm3nc4xuJ1Mz8opW4AbMExuNUfLK1TPWaDyun7rSdsQv3VEf/dz9htbsongo+Czc9XSktKbl6U4taLrjw/hC9/6wx78K4Jt/VSoUP+21sWYHj0LpVoiUKGxkTj/j1gedk3a64TuOOXyUPtgFY7w7q1G7/Yf5OGLKkFHKmF5PsW1o1YVwDDsOuroyMo0fKZcrC/5ex7eARTg883yn8jTDhcAQN5Asq47+wOuFgmGQSjeHOp+JMMqH8u9DheQSgDFTi8zMp3ynELAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEpRwbGBlTga8FlYx/wRem031kpGZkeYvYIuFRG+GXg=;
 b=LAXmoPxSC12gBzwGBa8PW3KVFK/EUYIQW6cxoK/8HpF0RR4BogZFFWqcCa86jGIkL0XfRwps0UO9XF3S2wKL7Jothawsg+RdioE2LEjd6B/KeMgmjKMgFVPOnmLQnHFUo8e5XG97oveLI4MX52KnDsonPKepL76hqy4BzPTk75A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3902.namprd13.prod.outlook.com (2603:10b6:208:1e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:03:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 12:03:27 +0000
Date:   Thu, 22 Jun 2023 14:03:20 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: use pcpu 64 bit statistics
 where necessary
Message-ID: <ZJQ4iONJwezOs2CZ@corigine.com>
References: <20230619165220.2501-1-jszhang@kernel.org>
 <20230619165220.2501-3-jszhang@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619165220.2501-3-jszhang@kernel.org>
X-ClientProxiedBy: AM0PR10CA0114.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: 70badf84-5a90-46d7-365a-08db7318b038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xO9OiFtkwGdlPtBFN9JQrm8Bx6ksIDXHGAvA/+qGpQdoZZu6pVvWLBygj+igbsVTihjxN7RmBnAjghaV+08knPyQsBSgWEsEiBacH07HXC+BylMGYAUNPB9+S3/H5LDzamMssKP7EMHDszqroODhLxjfeBVjsBZ45lmHgZZ2FeS3tkbhLae6/hniYfLRyATIR4RO9Y7XfXXCCWw6+0eNTkHce6f2kiamGTpb0LPF5PKf+qcks3jhk1Eeh/NAOwBJZSRFRzYZsCNjrXHjPxq7385sVExP7Ss8u1lMKTvrjWeTvFl78pVCvmTIjJ3F2gFGHOru2x9rXd3jVVYV3TLSa6PTvNSFz2soU3DfG/Et6PjgCw7WYfZ4bRSK6wSLAzHVXbWpMGjfX4LMq1d2d8TR72+0iZ4LqW9mujYN6inL075LHMZqtcnF0iDI+ED2gVELSEDL8Y6JEf0OZC5luGY/UR3MsQnMoaKdJYh23e4mSLhrbmt8DdLi9lf21qtn6BWwSkTjXa0Yjwpq5+JkjbmQOFdMVMqM/C2XL8b20wBkLHoCCpphqW0wKWiBHrBDtnHR9Ff3Z4NHlHNIBqOqcDfR1gEt+NC/sMbQGiCY73cquCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(136003)(366004)(396003)(376002)(451199021)(6512007)(6506007)(186003)(2616005)(4326008)(316002)(6486002)(6666004)(36756003)(6916009)(2906002)(66556008)(66946007)(66476007)(86362001)(41300700001)(38100700002)(83380400001)(54906003)(478600001)(5660300002)(7416002)(8676002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFta2fTNENuj7XJFFMxI2HKGLRmqqzvU7mnXq3ZfGmJIexha58NdtGb3zxYL?=
 =?us-ascii?Q?f3Lsw7WpIPt//kPTkh/PwrEE7KBqU+1v71A8E0weJ8FMOR9sfSaGuzF2GmvU?=
 =?us-ascii?Q?yKVRpy5uh3bGis40QhXBk9BV4Uz02QvJqrVHXoO0bmci67y93CIZ90tDhpsA?=
 =?us-ascii?Q?KsqdbxTvUyDz3l7QtjZa0wg5hCCvjHxX+NtlKFpjCXrZD289RYQqI+ItZNqX?=
 =?us-ascii?Q?V9j+0Zk2Ot9zl1S3YwXMu64vXdlyd6hmIX9i1lLro6UryOZmGqUYd0ekRAyF?=
 =?us-ascii?Q?fwU1RMb0YLg5gVcF8j7rj5B7+DEQhG/4roNNWz/UVoqZUK+TBQZ7YVtWKqUx?=
 =?us-ascii?Q?ruJ8pIlzSRiHGKRqhJDYRtQOJAK6+6bEOdnn3huyAE9Gd2L1Lw/ADf57/waZ?=
 =?us-ascii?Q?Jg2I320AgjEHdrh2CF57/AOvmILkrYdFzXHRhUaxRNIVY82WZZl8EKjwkc/U?=
 =?us-ascii?Q?5GD1AVkkm8E/zgvpd+QExDUKyqEOAzK3gLJqfAqiZr0iV11/9IJR73SGJiR1?=
 =?us-ascii?Q?jcOKLrCgoI3XItUErusM39RpCvC/TUAMrF0vt1GBUGzDUlEUbJ4ZjwpAeq3S?=
 =?us-ascii?Q?i4bnzz4RHW3AUNi7WSwKfPC7ZmS7vSvTjaJbV0AGDG9uUvHKQQeHabKNCSqk?=
 =?us-ascii?Q?v+R0BZauGbSMTiue1WS3r+CRDoLR/QE0+gKQQzrVer6i1HGhvuX9MpzGGKfY?=
 =?us-ascii?Q?w1KbtxfkEmvuubIGW4pRIzOPah4qIsCBYroVigTSId0MEbOh6cJGEfyPjaGA?=
 =?us-ascii?Q?WR0pf0Fe9Zyu1xbvHJNTi6O0S++/Xm4RUGgxDtzVJr65wJ6HBfyz9fadf/kZ?=
 =?us-ascii?Q?wAIexnx5YOUYdVywGCKIrQk6FB1nzoQ/oX+4MWBH0AVq+19ltTyf4Ky513wf?=
 =?us-ascii?Q?g+GV8W1ltJ6uMsPI31/hmL7e+1BGFhrlWzSaY2VvoqUN2/Dx/MZXOG9z8LOI?=
 =?us-ascii?Q?IJsnI6batCGdQ7burYgwboQDv4jCiER2r27hbpFn23QLypLaEQWScdDrvGMJ?=
 =?us-ascii?Q?C2L0jAzFt1bSUTfLUYZhuhVC97JR6fI80BtvngqPJdX7m5zewgnwvJEPIUT4?=
 =?us-ascii?Q?nRio29j1QnNbgO/I6zH2wag8QG85vIxrSwlC6+2GIvHykqfHIqgQOFdC4sqM?=
 =?us-ascii?Q?sPStDBHNZJurZb0ka2IXkgptqEH4ukV4j4cAD/fVi3Fhnxa9dUGs5Pc0ITRa?=
 =?us-ascii?Q?oXTZyOn8+MU0QR5r1AlyveAClvsctOa60qMyDiGz6kWeC8mXuP/1ReavwJ5P?=
 =?us-ascii?Q?dOi4aumFk2LVEkVXwOGF6JoT9auDRobZbyic4PvX5dMMgyyXN9LRqzG9nbR5?=
 =?us-ascii?Q?jf8Qxad8AJGMuqegV9V9WKO1nEh5uaqf1LRxa4OKWg0HiBrjYNrMUNnuwn6G?=
 =?us-ascii?Q?2dUIfL3nqoqlmYvYPPvIOxUrgjP6iD08C6imvGt/CYoUb4xTLWqJdAgqj90q?=
 =?us-ascii?Q?Qf8ac3tkmhKDwtThGJ9zZNo3r6FTkwGgfBcYleVnGjYM4AJwtfU2nQPicz94?=
 =?us-ascii?Q?j0L68BZTRewBhQqc0/Ad3gT6UKEWgTi3Aowtj/+lT8TpQIaov43y14IHP1rZ?=
 =?us-ascii?Q?EO5SePERzXF4qGwo1NnBGok34ZZrhOwMfKHcpbvVBdN/3i3r5PxxRaWl3vMn?=
 =?us-ascii?Q?/VVjKKAMWGGqOVBigjusIbN+bjJkxyY32f7+uVOhlXHcd1jPQ3o21SaFZ0cV?=
 =?us-ascii?Q?u7kcyQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70badf84-5a90-46d7-365a-08db7318b038
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:03:27.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dup04i3r4WVVloPaWveG1aVo+nSdmG4O6NZcv/HluCbBvYBaAhEeplHqNs9EdqomNwDnykYFU0hnLsgFjCOAyEyv0Xd2ij0X6L0agXIN65o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3902
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:52:20AM +0800, Jisheng Zhang wrote:

...

Hi Jisheng Zhang,

some minor feedback from my side, as it seems there will be a v4 anyway.

> @@ -535,23 +548,37 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
>  {
>  	u32 tx_cnt = priv->plat->tx_queues_to_use;
>  	u32 rx_cnt = priv->plat->rx_queues_to_use;
> -	int q, stat;
> +	unsigned int start;
> +	int q, stat, cpu;
>  	char *p;
> -
> -	for (q = 0; q < tx_cnt; q++) {
> -		p = (char *)priv + offsetof(struct stmmac_priv,
> -					    xstats.txq_stats[q].tx_pkt_n);
> -		for (stat = 0; stat < STMMAC_TXQ_STATS; stat++) {
> -			*data++ = (*(unsigned long *)p);
> -			p += sizeof(unsigned long);
> +	u64 *pos;

Please use reverse xmas tree - longest line to shortest - for local
variable declarations in new Networking code.

...

> @@ -563,7 +590,8 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
>  	u32 rx_queues_count = priv->plat->rx_queues_to_use;
>  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
>  	unsigned long count;
> -	int i, j = 0, ret;
> +	unsigned int start;
> +	int i, j = 0, pos, ret, cpu;

Ditto.

...

> @@ -606,6 +633,22 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
>  		data[j++] = (stmmac_gstrings_stats[i].sizeof_stat ==
>  			     sizeof(u64)) ? (*(u64 *)p) : (*(u32 *)p);
>  	}
> +	pos = j;
> +	for_each_possible_cpu(cpu) {
> +		struct stmmac_pcpu_stats *stats, snapshot;
> +
> +		stats = per_cpu_ptr(priv->xstats.pstats, cpu);
> +		j = pos;
> +		do {
> +			start = u64_stats_fetch_begin(&stats->syncp);
> +			snapshot = *stats;
> +		} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +		for (i = 0; i < STMMAC_PCPU_STATS_LEN; i++) {
> +			char *p = (char *)&snapshot + stmmac_gstrings_pcpu_stats[i].stat_offset;

Blank line here please.

> +			data[j++] += *(u64 *)p;
> +		}
> +	}
>  	stmmac_get_per_qstats(priv, &data[j]);
>  }
>  

...

> @@ -695,6 +738,11 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  				ETH_GSTRING_LEN);
>  			p += ETH_GSTRING_LEN;
>  		}
> +		for (i = 0; i < STMMAC_PCPU_STATS_LEN; i++) {
> +			memcpy(p, stmmac_gstrings_pcpu_stats[i].stat_string,
> +				ETH_GSTRING_LEN);

The indentation of the line above isn't quite right: it should align
with the inside of the opening parentheses on the previous line.

			memcpy(p, stmmac_gstrings_pcpu_stats[i].stat_string,
			       ETH_GSTRING_LEN);

> +			p += ETH_GSTRING_LEN;
> +		}
>  		stmmac_get_qstats_string(priv, p);
>  		break;
>  	case ETH_SS_TEST:

...

> @@ -5015,8 +5042,10 @@ static struct stmmac_xdp_buff *xsk_buff_to_stmmac_ctx(struct xdp_buff *xdp)
>  
>  static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  {
> +	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pstats);
>  	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
>  	unsigned int count = 0, error = 0, len = 0;
> +	u32 rx_errors = 0, rx_dropped = 0;
>  	int dirty = stmmac_rx_dirty(priv, queue);
>  	unsigned int next_entry = rx_q->cur_rx;
>  	unsigned int desc_size;

Reverse xmas tree here too.

...
