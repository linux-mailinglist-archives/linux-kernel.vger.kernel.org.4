Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F216816BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbjA3Qno convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Jan 2023 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjA3Qnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:43:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FBF16AE7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:43:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMXFV-0000yZ-SL; Mon, 30 Jan 2023 17:43:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMXFW-001VW6-33; Mon, 30 Jan 2023 17:43:17 +0100
Received: from localhost ([127.0.0.1])
        by ptz.office.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMXFU-00H7Oy-Ga; Mon, 30 Jan 2023 17:43:16 +0100
Message-ID: <faf0b767d910f11c0e9b458614e002534880e12a.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] certs: Fix build error when PKCS#11 URI contains
 semicolon
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 30 Jan 2023 17:43:15 +0100
In-Reply-To: <CAK7LNAReD_97qWRT8f47VKx9cScTWUJcHNkUyhXQoMAYPwAPUQ@mail.gmail.com>
References: <20230130141553.3825449-1-jlu@pengutronix.de>
         <20230130141553.3825449-2-jlu@pengutronix.de>
         <CAK7LNAReD_97qWRT8f47VKx9cScTWUJcHNkUyhXQoMAYPwAPUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (by Flathub.org) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-31 at 00:18 +0900, Masahiro Yamada wrote:
> On Mon, Jan 30, 2023 at 11:16 PM Jan Luebbe <jlu@pengutronix.de> wrote:
> > 
> > When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*) and contains a
> > semicolon, signing_key.x509 fails to build:
> > 
> >   certs/extract-cert pkcs11:token=foo;object=bar;pin-value=1111 certs/signing_key.x509
> >   Usage: extract-cert <source> <dest>
> > 
> > Add quotes to the PKCS11_URI variable to avoid splitting by the shell.
> > 
> > Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > ---
> >  certs/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/certs/Makefile b/certs/Makefile
> > index 9486ed924731..cda21811ed88 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -67,7 +67,7 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x509
> > 
> >  PKCS11_URI := $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
> >  ifdef PKCS11_URI
> > -$(obj)/signing_key.x509: extract-cert-in := $(PKCS11_URI)
> > +$(obj)/signing_key.x509: extract-cert-in := "$(PKCS11_URI)"
> >  endif
> > 
> >  $(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(obj)/extract-cert FORCE
> > --
> > 2.30.2
> > 
> 
> Instead, how about this?
> 
> 
> 
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index 9486ed924731..799ad7b9e68a 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -23,8 +23,8 @@ $(obj)/blacklist_hash_list:
> $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
>  targets += blacklist_hash_list
> 
>  quiet_cmd_extract_certs  = CERT    $@
> -      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> -extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
> +      cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
> +extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))
> 
>  $(obj)/system_certificates.o: $(obj)/x509_certificate_list

Thanks, this works im my tests, too.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
