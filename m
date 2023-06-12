Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C0A72C2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFLLeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjFLLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:34:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744DA59DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:11:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-DewxziyUPXuyU4DjMJIpxA-1; Mon, 12 Jun 2023 12:11:22 +0100
X-MC-Unique: DewxziyUPXuyU4DjMJIpxA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Jun
 2023 12:11:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 12 Jun 2023 12:11:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: RE: [PATCH v3 3/4] vsscanf(): do not skip spaces
Thread-Topic: [PATCH v3 3/4] vsscanf(): do not skip spaces
Thread-Index: AQHZm9wFvdHGuD5F0k2o+1T0Ru69aa+HA4AQ
Date:   Mon, 12 Jun 2023 11:11:11 +0000
Message-ID: <0c8bb9a3d2de4cf5b06f912d784e7292@AcuMS.aculab.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-4-demi@invisiblethingslab.com>
In-Reply-To: <20230610204044.3653-4-demi@invisiblethingslab.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Demi Marie Obenour
> Sent: 10 June 2023 21:41
> 
> Passing spaces before e.g. an integer is usually
> not intended.  This was suggested by Christoph in
> https://lore.kernel.org/lkml/ZIQrohcizoj4bZWx@infradead.org/.

This is contrary to libc scanf and could easily affect userspace
writing fixed width values into sysctl nodes (etc).

IIRC strtoul() (etc) are also expected to strip leading spaces.
Removing the sign in sscanf() may lead to "-    12" being
valid - which may not be desired.

	David

> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  lib/vsprintf.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 9e53355c35b1d6260631868228ede1d178fe3325..665f6197f8313d653f67d7886b12c43942e058dd 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3551,8 +3551,6 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			char *s = (char *)va_arg(args, char *);
>  			if (field_width == -1)
>  				field_width = SHRT_MAX;
> -			/* first, skip leading white space in buffer */
> -			str = skip_spaces(str);
> 
>  			/* now copy until next white space */
>  			while (*str && !isspace(*str) && field_width--)
> @@ -3639,11 +3637,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			return num;
>  		}
> 
> -		/* have some sort of integer conversion.
> -		 * first, skip white space in buffer.
> -		 */
> -		str = skip_spaces(str);
> -
> +		/* have some sort of integer conversion. */
>  		digit = *str;
>  		if (is_sign && digit == '-') {
>  			if (field_width == 1)
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

