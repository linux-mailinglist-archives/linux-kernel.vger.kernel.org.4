Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7274F787
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGKRvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:51:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B810F2;
        Tue, 11 Jul 2023 10:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOSQmNr/HjAr7VwxuI4LFC7/m1yrUNhsMrhvfkODPefu1HbCvU49OU13gg6fRr9oJvpeIV+k5DEmjZCggRiOsQc9bZjnyAGtBBrJiub6CUGnoZRf6G9IGmE7ex2UuTW4xPkuLZ7ugRRtX3INq53hMzyhOgJ2ZYDZmVwdgI7Gin/qh8TKubkDsg0j1RL3hFJym1yUgDpevgCT6MuhhcpIx0iLRTkN6O2pF/+Deh4Xuop+YzPBirW4Ffk8LgkuPgBWcotuEbpsVqoStD/HKbGLh8A7ms9kycwgbeVrkTH0q85GMawn40+UvYCcRXcifm4DQy4I79l3eJSiZBpMB/N11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdFEZPKJSS+kFuI5JNmOF8XvvlQAMKf0VbmwXpqgbtY=;
 b=XT5vmpie/oq2xb2AGFqJcIhxNdm/RJlallJHRUvSXPimT+s3gI9H4Ohdd9jE1ynnCeREHbd5omDzjl354JqKfpZU0eZccNC4PJdQVDnou4Qfb+H5m8vJdF9XJ1IVyPIzdTec5ODTkhulKThlahcVrD/PxtpHugVsrypv4SF8rnB8LI4PSGzpQ2esZIOQICKgxlkNlTHz+BgG+Udnetf6B+JV/DQYMexjLH5BX0kvlS8eo6QT8ORO6+PLbfY2+yOZJYQRr8FEnvd6PRwH+DcwOrGIWQfeoqWwm7XKi0Bj8U+vGdfKMl876DqRSDzsPq32erFDd6Y5q2/jf1Sfifvysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdFEZPKJSS+kFuI5JNmOF8XvvlQAMKf0VbmwXpqgbtY=;
 b=cFA81hL8bIEnt2n0yb/WJNiz0qIo1rOQ1oCkwIyWRPKJgVUlcplROFQ4kVd7Yj4CuxOzMy+8hNZpq1/E9hx0Rt4637ILFLTef2DWVWfTKuiFx6zRcvFPs3N/+qkQVHS0O1lUzcD2ObDEWYPtj2ECl3nCVa41B/zYkjhl2qi/gWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6280.namprd13.prod.outlook.com (2603:10b6:806:2e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 11 Jul
 2023 17:51:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 17:51:02 +0000
Date:   Tue, 11 Jul 2023 18:50:55 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     mostrows@earthlink.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xeb@mail.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: Re: [PATCH net-next v2 03/10] net: ppp: Remove unnecessary (void*)
 conversions
Message-ID: <ZK2Wf4man0H4e9Zz@corigine.com>
References: <20230710064027.173298-1-suhui@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064027.173298-1-suhui@nfschina.com>
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: a98ccd2b-9bd1-4de3-4bd8-08db823764b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pq99FAezGU7ElrFBD2gBlANu7JmYaFqFKPquRwJCtZB7IHfgx7F3D2ueNMVUF/3Ty8jJFLIEeD146uxp5w1IrVVvFP48Yrrg+711YvPgax/hoZyHOCu2zuYs97qjYs8LaEp1RwhA0qY5a2gW0T99kFAeuGDYdFBBRvYarRaSO388fY3hcXHnkgqxZ8802V+3tS8l/EeeSDk+wOtCCG5SO/9rJaskoPm5F816bPthXg+Z09NeJaJy7NZljrO4A14l0V1JGQt2jVF5YEEs3hLTAXzyIXtXsXTTNJtYjiyYXb6ZL/V59UHpgrkhNCZRvnUzjtiS4J4p818Kol4VQPvKd61769kph907Fn4WFQOQpjACLKuAezakeWGGgZDewywDidYi6r01P8JMnGuL9h096uV8nd6n9vIqxFtkLXKHUA/QI+N+NnqGhxxecbImgdTnCRl//o5XkJCGQyC/qK6qyRFqEF4cvILEjTutim88TAcfUplt2McwBvZ7Q9b21faNdJjITdi7ysVNEi+AS+/qV5Tiu0ppURd83CCfQe4AQIGMvMjfE1jBbsiR3MXcDdkrElN0AZcXcSElYxk76QJMnqvphNmPL4Mv6S6kCJe0n1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39840400004)(346002)(376002)(451199021)(8676002)(8936002)(478600001)(316002)(66476007)(5660300002)(4326008)(6916009)(7416002)(2906002)(38100700002)(6666004)(66946007)(44832011)(66556008)(41300700001)(6486002)(86362001)(6506007)(6512007)(26005)(186003)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6oNzj96Lx15/wKJvurwUWJJh96C02UDVrs5IBIdybel8jB3UaiT/Z8NWmBY?=
 =?us-ascii?Q?EIrcQUotJ3oJxPbt4t7ppCBUINylDMGZ9jCYF5Kb5RloRZy1gzwv4MFyo0WH?=
 =?us-ascii?Q?vRq3QvwJ9BfMAObtQFWJCHszPHl3Cb6dOGVtvelCs/bYvMvcXnpu/U2aflR7?=
 =?us-ascii?Q?bgfJvFcOQlvULbDp92SRYeZRG5MWrWBnnPFJYgvL3fgpJindbrUjCGQzoEM6?=
 =?us-ascii?Q?In9ATjtq+qmragYQoKNu41EP0bGdZJXQzSz+5TatF8jcNVyt2mFYcZzXTmBE?=
 =?us-ascii?Q?yk+lNIhsSIOiH4TopmaqDdmzPi7kee0f+wCQO5gTCW2bUpyI3TOLPYcuHXJ2?=
 =?us-ascii?Q?FwTWlRdKPRIY+3oFKjmJImtxvz/BEfL7G+urlnG7OiH/ATy4n1PhZW1+EVNn?=
 =?us-ascii?Q?hoRjniL1fV8jh6vG8B9yjhCs/kqbFwaeRS66ulPYqjXK66lrEip3LS9DsIId?=
 =?us-ascii?Q?N3HtlaFU98Qgu3atniJG4Qx1F0i5KR27oSWmCDQVipoannhO1DPY0M61Otip?=
 =?us-ascii?Q?wQXAPji8lkJaOv/lbS0TeQ5wfOTUCmlOXiBlTdskUe4snK4mPfM5mNBOr4Li?=
 =?us-ascii?Q?95aF9IGOjzH63db38lZkXvR1LO0bOpiyBEDtfaSK8BSoNMfkpneUMGfeQxVV?=
 =?us-ascii?Q?LMgF6cYzSl5E8BZsPzM+IkBZV05/Y55fdFBIPk+DQ8zBp1lTpM5Cgn3L/pjN?=
 =?us-ascii?Q?JDsqwSbnw6lqdKt+CKCpjAgF9xr7jP192umJxnnqpnaT1tcDQ0XDsUd2U/bg?=
 =?us-ascii?Q?B3R9viSQg79X8TuJAEqP9BKDqkeHQBQx9uij2HmSQoN/Lzq74CgJZg+OPeiE?=
 =?us-ascii?Q?d1R7jrAyvKUikYUqxBbD/LjXWDDPgfo3v0gEAPPmSbcC//97MIt3Quutim9p?=
 =?us-ascii?Q?RIMoMrJZp76ZKpY15Qes81tTBVu3hKc7fPaOU3F3Bs3wulSxrYinyAG0F135?=
 =?us-ascii?Q?biQ78y0tQQUwVo+uyVhJ+YTPHUO6BWGOWouQXVP3l+sEeJFR6tqiYFMp5+1e?=
 =?us-ascii?Q?qPb8p1SSlaqcW1mIckv44qIIgKwDnp8ht4UQxrw8Lu/RH/K7zuwSvUEhaWmC?=
 =?us-ascii?Q?/o69oXkHrcMR/B8b8LVXGMImLW0hFx108VVT/8dUm5cW8SLxNBMHvH+AYXO+?=
 =?us-ascii?Q?SaiVwR4un8NYe0nSf+jm6oiPdUu2Pzd2yIT4KlKu7w1OEuy/5pqsC1Rr52vu?=
 =?us-ascii?Q?cI7n5Lu/zpnjaDg6pjwgRjV0Ye861iXnTAgUzp8AudSC2mGGhvXccVXe8fja?=
 =?us-ascii?Q?Yuvh1WSmhQ0bGRj6xw2Gx/pj12ux6+dX1heVnAJ2kpIXfxc1UNFug3xNmJFL?=
 =?us-ascii?Q?aW1zsymKosPqBu26gRgfGVhYO7XncsRQDCRHQOW6Mu8Fr3cbqIMEUMAluwpb?=
 =?us-ascii?Q?qJvsVfVsBKSRYOKca17pWAVc9yPRkZCIwGEljAzYPvBDMbeSBQ5Nhx8QTDBL?=
 =?us-ascii?Q?nDDb8OaEf1EmeBFuheCqfSRkAklVnZ94ESs99vkzuTGtBlZUnBukih0tUvXw?=
 =?us-ascii?Q?DPZYYB3yckpriYntZ/zkZA8Eywn2QlQruU0owY7A8c68nLVdAXCLRhwjfkmG?=
 =?us-ascii?Q?CSWOECNwDtVHZbzD1urwu+r87cGp6IAZHXvj6nKtAnKrJj4eaBueGBSyISMz?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98ccd2b-9bd1-4de3-4bd8-08db823764b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:51:02.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR9dUpYE9D91xz5rvG07t5CCYVLSe07HF2VzXz8IdPAADjZ4GT/C89QSwoT/n5DPeSclAVZOZdtmrLtMxj1XJjsLFmkFBp32Js97uohTAcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6280
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:40:27PM +0800, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
> 
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  drivers/net/ppp/pppoe.c | 4 ++--
>  drivers/net/ppp/pptp.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 3b79c603b936..ba8b6bd8233c 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -968,7 +968,7 @@ static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb)
>   ***********************************************************************/
>  static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>  {
> -	struct sock *sk = (struct sock *)chan->private;
> +	struct sock *sk = chan->private;
>  	return __pppoe_xmit(sk, skb);
>  }
>  
> @@ -976,7 +976,7 @@ static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
>  				   struct net_device_path *path,
>  				   const struct ppp_channel *chan)
>  {
> -	struct sock *sk = (struct sock *)chan->private;
> +	struct sock *sk = chan->private;
>  	struct pppox_sock *po = pppox_sk(sk);
>  	struct net_device *dev = po->pppoe_dev;

Hi,

Please don't break reverse xmas tree ordering - longest line to shortest -
of local variable declarations in Networking code.

-- 
pw-bot: changes-requested

