Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C06BE4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCQJA3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjCQI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:59:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A1415161
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:58:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-uqQwu3-2Ni6M2bibkxFdew-1; Fri, 17 Mar 2023 08:58:11 +0000
X-MC-Unique: uqQwu3-2Ni6M2bibkxFdew-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Fri, 17 Mar
 2023 08:58:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Fri, 17 Mar 2023 08:58:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bhaskar Chowdhury' <unixbhaskar@gmail.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: RE: [PATCH] Kbuild: Elevate sha1sum to sha256sum for atomic headers
 check
Thread-Topic: [PATCH] Kbuild: Elevate sha1sum to sha256sum for atomic headers
 check
Thread-Index: AQHZVz7+3Ra3OwIixEm7c88WA//5ha7+rdKg
Date:   Fri, 17 Mar 2023 08:58:09 +0000
Message-ID: <0bbdd88ca0cb465a85d7b90ebacb5e83@AcuMS.aculab.com>
References: <20230315130518.4496-1-unixbhaskar@gmail.com>
In-Reply-To: <20230315130518.4496-1-unixbhaskar@gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaskar Chowdhury
> Sent: 15 March 2023 13:05
> 
> Thought it would be a good idea to use a elevated mechanism i.e sha256sum

How can this change possibly work.
It is just a list of definitions read by another makefile.
You've changed the name of a definition without changing where it is used.
Also if the code is looking for a change, you'd need to change
what it is compared against.
In any case no one is worried about malicious attempts to change
things without being noticed, even sha1 is OTT.

	David

> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Kbuild | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Kbuild b/Kbuild
> index 464b34a08f51..b74040346d76 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -45,14 +45,14 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
> 
>  # Check the manual modification of atomic headers
> 
> -quiet_cmd_check_sha1 = CHKSHA1 $<
> -      cmd_check_sha1 = \
> -	if ! command -v sha1sum >/dev/null; then \
> -		echo "warning: cannot check the header due to sha1sum missing"; \
> +quiet_cmd_check_sha256 = CHKSHA256 $<
> +      cmd_check_sha256 = \
> +	if ! command -v sha256sum >/dev/null; then \
> +		echo "warning: cannot check the header due to sha256sum missing"; \
>  		exit 0; \
>  	fi; \
>  	if [ "$$(sed -n '$$s:// ::p' $<)" != \
> -	     "$$(sed '$$d' $< | sha1sum | sed 's/ .*//')" ]; then \
> +	     "$$(sed '$$d' $< | sha256sum | sed 's/ .*//')" ]; then \
>  		echo "error: $< has been modified." >&2; \
>  		exit 1; \
>  	fi; \
> --
> 2.39.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

