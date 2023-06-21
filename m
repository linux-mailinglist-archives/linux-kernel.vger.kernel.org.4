Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531E7386AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjFUOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjFUOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:19:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0208E199B;
        Wed, 21 Jun 2023 07:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiUWTVp0k5Os8nM1mTBlQE62RJD/UIoi80ShrMAVj5Wc2c6Tos6R8rpg5kz+Rn3QWLeGpNVMIcPaSiVSo9eHNFuSC8r7DJg/xGRNjm1BQ8t+7Cw8dSN4jJPjyk/caSldF1NaKd3nsKoaWt5bawA9lhHVjnTbUCQCtoN8O3oPl8sAMhmCqMIsFuFeLqk5TEBqc3ErPF9xIPJ3aQf/F73Qm13UOQ2CLHGBQd+pGMEjw/f8aLWxR1xPWr0XCL2R+FmONYWJ6vp2SN48bVkkyvY2JpUqhAn7rSMG2T9jcc3rCHtNmbNcN7dwkzRCvB9jvenSfX/jSU5Y5Yid5ewVlYGN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj4ken3aO+twRCAzfB0PcWSW9XUqE1NR7CKbEPDkj4c=;
 b=hf0HBBsI2VoeoYDJ0Ql1Mrlrzq/6jeON6txiWFGY+zxlpKj9n/J6OsW4Uj6uBVwl8yDQxvUCqb+Eedr5N77/Na+9PxsS0qyxZT45IhQ/dzhL30F4DunHTkvhkDI8TFlIo2sgZiPaFFO3EtvkMs/Ms2iJCi4tgwBHCuG9pp5gUgqZaQ9vERqPM+g4lW9QZZ3J3cbUs1/bjp17yUkvI1q+Am2OwhyS9PKTQGNsjl3V/Sm2Z7UNqw9cu4P3k4HmncYz8tZGjLbsaxgFMHk6Mi8sRabGkDjM9q8uU9cF2EkpMm6LrfwdiJygaNA0mKkQvCokoxZZpTRIc9/DE7acMhyMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj4ken3aO+twRCAzfB0PcWSW9XUqE1NR7CKbEPDkj4c=;
 b=Si+sKFx+TmK3o/OF8+eh+CZSyjZuXRfO2QpxF+6v8rp1Ao7A+KkTtN2Xy5V34OCgNLFFgHN4n02hl5LLMyRjNtlnKUDayyno3lSXDAIhDsuW2g5H4CPH99lPok4CjhIM3cA/Ib6hpF5iV/cF780EhZ/uN4g39xNXFnFrn80mBck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5402.namprd13.prod.outlook.com (2603:10b6:a03:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:19:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:19:13 +0000
Date:   Wed, 21 Jun 2023 16:19:06 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v4 01/12] can: m_can: Write transmit header and data in
 one transaction
Message-ID: <ZJMG2ovqLXjMjgZg@corigine.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
 <20230621092350.3130866-2-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092350.3130866-2-msp@baylibre.com>
X-ClientProxiedBy: AM3PR04CA0131.eurprd04.prod.outlook.com (2603:10a6:207::15)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: d77e0882-2091-4698-a135-08db72627d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N52h1dfHbM088AIjmqVN/mea0ijDWkHyuWzZdhc5l7j+YS7Z6bbB1KvO9YZmhJH561BL6Zw9fQcpeNElv0YOrFfIq4oKwmHd+Zyqp+8+tYxKIHyR0ZLdBH8wtNmMMDV2rOYaEbPVFFbJjZF2HIjMsTSKQt2NB69OKn+c0Rs9+d8z5lFuCzQE0u4aDQlcWc72zGxsOQfi202Uwb+KgGYb70UgPUyOBUYruGqYdm5TTESmC/iSfmuTaOuySQjHwZ1jKgUx3agvTptnAOCgGHz3rD7aw4WQ0xtXNUYOUNZl8g8F9v4YgHYawMYvuiXdgBpN4W633NS0CyoasFfvvaD1f0D455jcbHIqF+upDHl7eq2lRkWSgZ+M+YwhPcbKfRP8ilXt1YJoRuUwtzPu5jO6OGlD5xnBdwFnKEp1V6DKRfHbVStGQmuVgGF3VLan0iXRoXHC+CdsckR0Y+q9MVAw1tI2P4zpo4yr0gS7byAA0abL3hAPTppkyYCw2Fy71QZWK10khaACCXB6nNd8DQ6+ycCj9mX81j4QwHYBA6zQiK42vzZjETQlzhJb3YCJt6PvlPGXyE39n/LmVz8uXaxCrSiNBOpwMET8nk8aNcSOouM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39840400004)(376002)(396003)(451199021)(8936002)(2906002)(8676002)(5660300002)(54906003)(6666004)(44832011)(316002)(41300700001)(7416002)(6916009)(4326008)(66556008)(66476007)(66946007)(36756003)(6486002)(478600001)(38100700002)(86362001)(2616005)(186003)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RBYkj7S6CTDiKC9md2smgaVzpJE2e4Ly8RztaJbuyQ1NUOOtpqQM2kJjev7?=
 =?us-ascii?Q?yenbRbGNWwdvuv/Jc58wYEl8w0QYkFcxpY3BsZkElyI2RdxtKth3IgHVNEdN?=
 =?us-ascii?Q?RVIaWyB8rbBXxaVPf0msboWJw+VIcfCTz8q6rOt6d1OILZubMlvvDrIvAX7N?=
 =?us-ascii?Q?prbTJlXvDJlfw2iwIEHGxOvdNShm2RZdP5FWwefl2hS3Uzb0MlSXxh4a22aw?=
 =?us-ascii?Q?LJw3GHMPzUF6hh3avIZUGC6NijjG0EEqNahRAiDgWORNGShQQHSXdbd41o5p?=
 =?us-ascii?Q?EAlX/N0gTKb7yrJ1YsJGRJFXY+/NJZIzWjtR4FQa2bgmQXmCwq2JAwml/VNj?=
 =?us-ascii?Q?1dCeeF4TyRtIaa/ZhTFEa++DgezFSneeJm+h95/0dOX8hmt0ENU8/IQ3bJka?=
 =?us-ascii?Q?Pv/MJU90y7kpaGKMnnS3LwcOYM/eSZrFuP1g6uTERc1OdGe/K7Q5rlsVibyE?=
 =?us-ascii?Q?voIYRBk1fcM69RlNkO0wMiN8/uMkJGcD+rdsP7y6dGYrK/oeUsw0xJXnMa7/?=
 =?us-ascii?Q?JlZlxY9eFLsmu6L+w4FV+2zWWsR0NmK1wvAzZkr20n9vzdObJWAqAHxzvABf?=
 =?us-ascii?Q?49TzIcCGWB9CTIXphqY8NgRByKk9QmQw2I+qeFFalLzEHM+uMZQwp+myeBty?=
 =?us-ascii?Q?aErNYLQXn/o8S/t7CDsUHqkJWr53N1R7vpqpJCNM/e1EPhxX/UhH7jOow+h4?=
 =?us-ascii?Q?qe3OO+u6Yt1EDEptQwfvppfHn1ZVnFfpXxlAOW6b9yESBpnJPTSklFldYJmz?=
 =?us-ascii?Q?QZT/gLk+a3VqlNpd+EkpMQJoIamQh7TW1njU0hJ3h7QC8cyLNlTyMcn2AwNd?=
 =?us-ascii?Q?UJLh9zDUnIotLj+RJV0Sl+4pWqiOVuP/TMGNDbjhXGRgUbPtCU052J3o2g78?=
 =?us-ascii?Q?jrXsENkQmzz/Mt07J44mvX4J7oIbILvC3l6oK/xT/PVSh11jj+slbu0v5AmX?=
 =?us-ascii?Q?LfjrxA9VOGoH3FBkeHT3U9NGONKb3wqTgcfcVzEp/V6YDBMJ1aAvhSQmkH+x?=
 =?us-ascii?Q?b4uBKX8wF8Se2Zd+UyqsvXqXaYS2OfW0eGvlM+45+lgDiRvpDXZfHCg7XXLS?=
 =?us-ascii?Q?1CTEzysFps84eCKFUQXIZ6fLFdmyfZyMwBzh3kfv1KNhqqW2ZdgKrxz4JAEw?=
 =?us-ascii?Q?qYW+0laSq6D/bm2mc7hy1bSg6iTpS02lhyjU2dlQIoni+NB386NjJcKU43GN?=
 =?us-ascii?Q?P1FsXAVTH+uQ8WHC9u/QrQHvCWTzM1Waxo6BS28hpZQt2WrWIUkIr7PbVtaQ?=
 =?us-ascii?Q?T4oAPz9ds15+I/xC6KxxvYBsqXhkwgkQ6z7fIDknwMSRgT07AxyU2SBfU1JU?=
 =?us-ascii?Q?J8mLcRJieWXpsnIGAWSBWNORTac+BjADmApR/ggqdA6hNQa9MZaBjJYmO9bm?=
 =?us-ascii?Q?kDz+hiBu5Dg6bIWWpCQWJejpN/fy8kSGXNiUvCu3F+DOdIzCb9ftSfgdTXnv?=
 =?us-ascii?Q?F7Y12edxjPDCakWk5NGoL2ucrW86iA9oyG8RhB//8dn4RzMipCQL2vGMZEhI?=
 =?us-ascii?Q?VLK3rgvgwGPsbsPXuhYDAWBhJOKT2PhBUIpvrtU1mKFMKJcmq++SmOFj99sW?=
 =?us-ascii?Q?CfBRLyVTUVTRpFzIfe5r5AAhpQ75cKCFxfolJm9u4UhCodQvaHuOdMflR9Wr?=
 =?us-ascii?Q?OhmrYp28KOp/w2wEbttJFR03XLGd5cWEiYWoIi1MHI4d1pHVrk/+vKDC4+Wr?=
 =?us-ascii?Q?HQKgqQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e0882-2091-4698-a135-08db72627d1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:19:13.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhbcMIvOLlaDG0RD102Pnc9yEY4KH3ayaTE7xs6cjQF3b6POCqPKamzUC2t/7seHqikwgBWHZY5B+1vdqVksWzQTS++UeiBJEb7bznDqYOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5402
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:23:39AM +0200, Markus Schneider-Pargmann wrote:
> Combine header and data before writing to the transmit fifo to reduce
> the overhead for peripheral chips.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a5003435802b..5251073987ee 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -317,6 +317,12 @@ struct id_and_dlc {
>  	u32 dlc;
>  };
>  
> +struct m_can_fifo_element {
> +	u32 id;
> +	u32 dlc;
> +	u8 data[CANFD_MAX_DLEN];
> +};
> +
>  static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
>  {
>  	return cdev->ops->read_reg(cdev, reg);
> @@ -1622,6 +1628,8 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
>  static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
>  {
>  	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
> +	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
> +	struct m_can_fifo_element fifo_element;
>  	struct net_device *dev = cdev->net;
>  	struct sk_buff *skb = cdev->tx_skb;
>  	struct id_and_dlc fifo_header;

Hi Markus,

GCC 12.3.0 complains that fifo_header is not (no longer) used.

 drivers/net/can/m_can/m_can.c:1635:20: warning: unused variable 'fifo_header' [-Wunused-variable]
         struct id_and_dlc fifo_header;

-- 
pw-bot: changes-requested

