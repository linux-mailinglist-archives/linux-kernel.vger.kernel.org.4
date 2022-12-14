Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8564D013
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiLNT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:29:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A9B19C2B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:29:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4399651pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4++XUu80LunZaKsdjvyt+0/rbOtR+T2hXuJjGDgzM8=;
        b=Vqg62PaCJgKuNsInFR+NrrhkFl7LCAyJQpOT+rN4+5PWgz53ql6NQbSv1OQLy41Ea4
         5b5RhppCBdu00GK8YuC/8xE2xUMOner2rJBPtPQ7r2faAhN2Sz4q02psIb8PuWrWbWi0
         zo63+jvVRRHaiIVppslJ4P5nU8YmzBsHFRhfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4++XUu80LunZaKsdjvyt+0/rbOtR+T2hXuJjGDgzM8=;
        b=43zK6G/ICgf0l3tWAXCfc0wQK9lq/teUlOkozJkhd1S4JSk0vCiXNipXBdQQgqvg1J
         GsK3dGGpTZZv2TIxHXeFK+u+mmndsIjwbTQHsIzNYAIG2Jo4Qw4Qo9L3CQLp8XhPQCBo
         5u961SfDrI2B3gzAEoLDIiVNBN4zSnY/2MkDgGn6TyK5A/Tb4iwWxBef3yCkrC4pxPvD
         /SOsb956thtqKNCq7lp0ZiKlLvzM1lqkgTVMx9QCOMqhP1kJAcrNZzdwUssoawb52oyj
         Q/62GFodBkSpzqbCWN6H60Zt7nHSAZzSvSdREohSdwEinncipZ0GNGSzkfaIVFQlqy8H
         GczA==
X-Gm-Message-State: ANoB5plaKSV033WLorZIEJ3VY4QXa0XoGr0awxEvpJZPt/7zKlGXv8u+
        eF0i+OQSJoeCOxVwUmLN6q73wQ==
X-Google-Smtp-Source: AA0mqf4FCTnVVGW1zIz1kB1g1jaIgdsnsX5UF8AWC9o/lb2p9JZINkIcGvmamvdSFtwLW5owoNYRgQ==
X-Received: by 2002:a17:902:f211:b0:189:8f0c:d314 with SMTP id m17-20020a170902f21100b001898f0cd314mr23098980plc.39.1671046178866;
        Wed, 14 Dec 2022 11:29:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b00186616b8fbasm2266487ple.10.2022.12.14.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:29:38 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:29:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <202212141124.736E3DE2A8@keescook>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5mMWEtHWKOiPVU+@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:42:00PM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct RXBUF and refactor the rest of the code
> accordingly.
> 
> It's worth mentioning that doing a build before/after this patch
> results in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index b2735be81ab2..1ab2d552f498 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
>  typedef struct {
>  	int count;
>  	unsigned char status;
> -	char data[1];
> +	char data[];
>  } RXBUF;
>  
>  /* The queue of BH actions to be performed */
> @@ -2611,7 +2611,8 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
>  static int rx_alloc_buffers(MGSLPC_INFO *info)
>  {
>  	/* each buffer has header and data */
> -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> +	info->rx_buf_size = max(offsetof(typeof(RXBUF), data) + 1, sizeof(RXBUF))
> +		+ info->max_frame_size;

It seems like there is an existing size bug here, and likely should be
fixed separately?

i.e. this was already allocating 1 byte "too much". I'd expect this
first:

-	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
+	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;

and then the next patch:

-	char data[1];
+	char data[];
...
-	info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;
+	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;

The above would induce a binary output change, and the second would not.

Though this results in what you had for the v2 patch (but I can't
believe it had no binary changes...)

-- 
Kees Cook
