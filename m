Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114BC74251C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF2Lon convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:44:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8721D30F0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:44:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-_FrFPb42NJGKPaNKG2-yvg-1; Thu, 29 Jun 2023 12:44:35 +0100
X-MC-Unique: _FrFPb42NJGKPaNKG2-yvg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 12:44:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 12:44:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'You Kangren' <youkangren@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v3] wifi: ray_cs: Replace the ternary conditional operator
 with min()
Thread-Topic: [PATCH v3] wifi: ray_cs: Replace the ternary conditional
 operator with min()
Thread-Index: AQHZqLBYZ8a+0OdHa0iQ2j8sJOpYz6+hrI0g
Date:   Thu, 29 Jun 2023 11:44:34 +0000
Message-ID: <ab5f3f7ff5d24d659b2988d549499c5f@AcuMS.aculab.com>
References: <20230627043151.19576-1-youkangren@vivo.com>
In-Reply-To: <20230627043151.19576-1-youkangren@vivo.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: You Kangren <youkangren@vivo.com>
> Sent: 27 June 2023 05:32
> 
> Replace the ternary conditional operator with min_t() to simplify the code
> 
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/net/wireless/legacy/ray_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
> index 8ace797ce951..25edbc655738 100644
> --- a/drivers/net/wireless/legacy/ray_cs.c
> +++ b/drivers/net/wireless/legacy/ray_cs.c
> @@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
>  			rx_data(dev, prcs, pkt_addr, rx_len);
> 
>  		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
> -				  rx_len < sizeof(struct beacon_rx) ?
> -				  rx_len : sizeof(struct beacon_rx));
> +				  min_t(size_t, rx_len, sizeof(struct beacon_rx));

You should really consider changing the type of rx_len
before using min_t().

	David

> 
>  		local->beacon_rxed = 1;
>  		/* Get the statistics so the card counters never overflow */
> --
> 2.39.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

