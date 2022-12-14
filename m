Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4044964D12D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiLNU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLNU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:26:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344C50D5E;
        Wed, 14 Dec 2022 12:14:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a9so4541412pld.7;
        Wed, 14 Dec 2022 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW+/9cTcFvcmFn8XcY69P7F/yxMAPc4sfKgSJO+0THU=;
        b=iVSDeb7jvQmFnVc2HkjpTVHu7MhZVJggToylfebESW8Hij6L/sVBkn6+tVEwz11x0m
         gG/S+5uP87ELsPFANThqpZpK8DVv8EKXqkou4AaSDEJbelvAyQQuU0KO9WCxsLzBR1Rj
         O98hKgB1fTssJ/RpB2Zfn8ybSrdfinEY3oi/0pxQzMXw+cOGEdR28iWEaXapzAGJNUvW
         t3EXEwKJWojCL1/ssMDGnKm0VV2yq7m5gqIt7UyEC2WveXSdDX+nKWMuk4qcbM6NDeoi
         SPnpPwU24gDurAYlmi63PViWPWmoUIZMLUIIHeRI+EK+BK+p3oE18D+cLbsMmqO6kiZk
         uomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW+/9cTcFvcmFn8XcY69P7F/yxMAPc4sfKgSJO+0THU=;
        b=DGsoOjoOvuAwLp61sRyLqDd6fTwKosu+gtSzLY7+Xbet4XYitpR5tQuWdqbTwvdLEI
         dPBVT2o32WkZfHjswUtQ8A9EM/Hkh6j8tbDM4hPl7wrbs/PnHfbO5gHVcT3BI9Os4b6i
         Hf+oDo7ND4Oj0kYr1OhwdiAxU+k/+qw9hNS+uulHE2TqzSFvvvIp2ZK70JUj7hhdDHU2
         XZZFcNDlY/0Akvy04pxO+JEbC8iJmXlsqaZyvHfLN7EuHusCOh++1FeJgkF+IqxHQFzU
         sOvyzP+ubBbEYXEXInEIiI2aw2LR1sTFzP4EbBWbwZJ9uhNv7LVfhZA66Lp2fzCn+Oa4
         BTpg==
X-Gm-Message-State: ANoB5pkGNN6fXtxzPsPZliCcFhy/IVIEgBQibQJ21pFv6kLZv2PSZJWo
        LX7H+xCV/ie9zg9cBT4xijKue+o5rY7v1L4M
X-Google-Smtp-Source: AA0mqf54ShiMkpIP+PMLkL2CgmNo4jMI2U+fg/DdfnYT33Xk8wxKDhP9cKi7XuiXes4/ysDmcWxKMw==
X-Received: by 2002:a17:902:6905:b0:189:8a36:2571 with SMTP id j5-20020a170902690500b001898a362571mr6616791plk.1.1671048882117;
        Wed, 14 Dec 2022 12:14:42 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00186b86ed450sm2251627plk.156.2022.12.14.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:14:41 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:14:35 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5ouq4Tkc4V/dlCi@mail.google.com>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212141124.736E3DE2A8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:29:37AM -0800, Kees Cook wrote:
> On Wed, Dec 14, 2022 at 09:42:00PM +1300, Paulo Miguel Almeida wrote:
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct RXBUF and refactor the rest of the code
> > accordingly.
> > 
> > It's worth mentioning that doing a build before/after this patch
> > results in no binary output differences.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> >  drivers/char/pcmcia/synclink_cs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> > index b2735be81ab2..1ab2d552f498 100644
> > --- a/drivers/char/pcmcia/synclink_cs.c
> > +++ b/drivers/char/pcmcia/synclink_cs.c
> > @@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
> >  typedef struct {
> >  	int count;
> >  	unsigned char status;
> > -	char data[1];
> > +	char data[];
> >  } RXBUF;
> >  
> >  /* The queue of BH actions to be performed */
> > @@ -2611,7 +2611,8 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
> >  static int rx_alloc_buffers(MGSLPC_INFO *info)
> >  {
> >  	/* each buffer has header and data */
> > -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > +	info->rx_buf_size = max(offsetof(typeof(RXBUF), data) + 1, sizeof(RXBUF))
> > +		+ info->max_frame_size;
> 
> It seems like there is an existing size bug here, and likely should be
> fixed separately?
> 
> i.e. this was already allocating 1 byte "too much". I'd expect this
> first:
> 
> -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> +	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;
> 
> and then the next patch:
> 
> -	char data[1];
> +	char data[];
> ...
> -	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;
> +	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> 
> The above would induce a binary output change, and the second would not.
> 
> Though this results in what you had for the v2 patch (but I can't
> believe it had no binary changes...)
> 
> -- 
> Kees Cook

Just realised that you made a comment on PATCH v1 and Andy made a
comment on PATCH v2. Please conside my answer for PATCH v2 as I have
abandoned the v1. Apologies for the confusion.

thanks!

- Paulo A.
