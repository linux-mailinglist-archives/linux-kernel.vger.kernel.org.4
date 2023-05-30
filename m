Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B83716318
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjE3OGA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjE3OF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:05:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8405F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:05:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-106-Am8f-XMVN6K4UDEwCA02rg-1; Tue, 30 May 2023 15:05:51 +0100
X-MC-Unique: Am8f-XMVN6K4UDEwCA02rg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 May
 2023 15:05:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 30 May 2023 15:05:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Min-Hua Chen' <minhuadotchen@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] capabilities: use logical OR
Thread-Topic: [PATCH] capabilities: use logical OR
Thread-Index: AQHZkoCZLKnbYMsJn0ez1CCVI83RJq9y2m1A
Date:   Tue, 30 May 2023 14:05:48 +0000
Message-ID: <db536b16e33648fdb44629fc9c1c1afc@AcuMS.aculab.com>
References: <20230529225440.7315-1-minhuadotchen@gmail.com>
In-Reply-To: <20230529225440.7315-1-minhuadotchen@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min-Hua Chen <minhuadotchen@gmail.com>
> Sent: 29 May 2023 23:55
> 
> Use logical OR to fix the following sparse warnings:
> 
> security/commoncap.c:1358:41: sparse: warning: dubious: !x | y
> 
> No functional changes intended.

Except it will run just that teeny, weeny bit slower.

	David

> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 0b3fc2f3afe7..b8e34f6204b2 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1355,7 +1355,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			return commit_creds(new);
>  		}
> 
> -		if (((!cap_valid(arg3)) | arg4 | arg5))
> +		if (((!cap_valid(arg3)) || arg4 || arg5))
>  			return -EINVAL;
> 
>  		if (arg2 == PR_CAP_AMBIENT_IS_SET) {
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

