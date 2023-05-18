Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898070876C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjERSBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjERSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62A183;
        Thu, 18 May 2023 11:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D9E61B2D;
        Thu, 18 May 2023 18:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EC3C433D2;
        Thu, 18 May 2023 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684432902;
        bh=59A+hqhOuVhjHrUwNLNN0HW73+IWKkQkhOqFvPZjCAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmAH7SqHx2mdOqTG400uNgJxacMrrZNl2gF5fPkD/4vYcOasIAYKvVZfWNjSWWhjj
         lEqrjjY1EY0XwJPxBry2oYcAfLPD8tLtkwLTlYLXYfryRZXOz3fWse57oDmquwmXak
         I+jTkbyXKZFFJtDBGB37Q89Oyjfztgyc2LS9fII5L+BRgZlUbBLLDbebFd0prTP67B
         8b0zO5Nc38HJLl+uRBir4Nl4gH6o2Tsz3ssiU5hF3mesz0AwePeDceBxdKIfIfY40h
         QCH8Wt6nVv013VZK85bHbKcklfFQYZhbhoEvOnOUyna8m6vGu2RpgxMR9qr+cjPdTW
         Kt/JfXFLOA2Xw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 May 2023 21:01:38 +0300
Message-Id: <CSPLMMXED66E.AMJRQGTPHKIS@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Azeem Shaikh" <azeemshaikh38@gmail.com>,
        "David Howells" <dhowells@redhat.com>
Cc:     <linux-hardening@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Replace all non-returning strlcpy with strscpy
X-Mailer: aerc 0.14.0
References: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 18, 2023 at 7:15 AM EEST, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  security/keys/request_key_auth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key=
_auth.c
> index 41e9735006d0..8f33cd170e42 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -178,7 +178,7 @@ struct key *request_key_auth_new(struct key *target, =
const char *op,
>  	if (!rka->callout_info)
>  		goto error_free_rka;
>  	rka->callout_len =3D callout_len;
> -	strlcpy(rka->op, op, sizeof(rka->op));
> +	strscpy(rka->op, op, sizeof(rka->op));
> =20
>  	/* see if the calling process is already servicing the key request of
>  	 * another process */


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
