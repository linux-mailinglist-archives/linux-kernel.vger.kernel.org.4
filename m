Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEB74D726
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGJNNO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGJNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:13:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500EBB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:13:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-g_5tey9eP9ugS51RLSz6Gw-1; Mon, 10 Jul 2023 14:13:07 +0100
X-MC-Unique: g_5tey9eP9ugS51RLSz6Gw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 10 Jul
 2023 14:13:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 10 Jul 2023 14:13:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Azeem Shaikh' <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Topic: [PATCH] kobject: Replace strlcpy with strscpy
Thread-Index: AQHZrdj8Qo2zsxXODk+YaMEZxqXK9K+zA4Wg
Date:   Mon, 10 Jul 2023 13:13:06 +0000
Message-ID: <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
References: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Azeem Shaikh
> Sent: 03 July 2023 19:05
> 
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  lib/kobject_uevent.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..e5497fa0a2d2 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -254,8 +254,8 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
>  	int buffer_size = sizeof(env->buf) - env->buflen;
>  	int len;
> 
> -	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> -	if (len >= buffer_size) {
> +	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> +	if (len < 0) {
>  		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
>  			buffer_size, len);
>  		return -ENOMEM;

The size in the error message is now wrong.
It has to be said that mostly all the strings that get copied
in the kernel are '\0' terminated - so maybe it is all moot.
OTOH printing (at least some of) the string that didn't fit
is a lot more useful than its length.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

