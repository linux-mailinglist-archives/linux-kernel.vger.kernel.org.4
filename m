Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0269AA37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBQLVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjBQLVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847DD23D84;
        Fri, 17 Feb 2023 03:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1240B61924;
        Fri, 17 Feb 2023 11:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8066DC433D2;
        Fri, 17 Feb 2023 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676632874;
        bh=TYymLuHAKHOg75kxJhhRqder3kZtvUkxS0yzAEY7rTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ii6HlaR1dzVwRY2k9Ee4iONIk1u0ySksMKx8c5eJI3B9HAhdj60HjSnuRA65aYNYa
         iddD2VtWtSZ7xL+jbEt1YXtQqHNRxCX4Jrz/E6A1JSqvqqKiyGuh0eJILFxrmTtUj4
         X0ODHDlK2ZZuXP0uoLSxhB50lJnNSRAg/A5YiqQaY/v6VKX1BECC/lrO3MN+vkYCVt
         zUaBixe00sLKkw3DHFa3/NlXgrsQuPYCi3a2W46HjbsImat0JFWzbr8JRTUJI/D5UG
         qkIZXRZy7zvC5UKKY5XHDm8B3PP5IKuoWS9H803Q0kusLXzMwSAhMlnRu9pcYH7P/D
         /1aLFAb4RjT9A==
Date:   Fri, 17 Feb 2023 12:21:08 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] firmware: turris-mox-rwtm: Fix an error handling
 path in mox_get_board_info()
Message-ID: <20230217122108.4a93667f@dellmb>
In-Reply-To: <fb3a73fd378582bf02e6c5eeabb61d3a3662cbdc.1676453328.git.christophe.jaillet@wanadoo.fr>
References: <fb3a73fd378582bf02e6c5eeabb61d3a3662cbdc.1676453328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 10:30:02 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> wait_for_completion_timeout() returns 0 if timed out, and positive (at
> least 1, or number of jiffies left till timeout) if completed.
>=20
> In case of timeout, return -ETIMEDOUT.
>=20
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>=20
> v2:
>    - Fix some other wait_for_completion_timeout() calls
>=20
> ---
>  drivers/firmware/turris-mox-rwtm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris=
-mox-rwtm.c
> index 6ea5789a89e2..d6fc37ba897d 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -200,8 +200,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
>  		return ret;
> =20
>  	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> -	if (ret < 0)
> -		return ret;
> +	if (ret =3D=3D 0)
> +		return -ETIMEDOUT;
> =20
>  	ret =3D mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
>  	if (ret =3D=3D -ENODATA) {
> @@ -236,8 +236,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
>  		return ret;
> =20
>  	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> -	if (ret < 0)
> -		return ret;
> +	if (ret =3D=3D 0)
> +		return -ETIMEDOUT;
> =20
>  	ret =3D mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
>  	if (ret =3D=3D -ENODATA) {
> @@ -275,8 +275,8 @@ static int check_get_random_support(struct mox_rwtm *=
rwtm)
>  		return ret;
> =20
>  	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> -	if (ret < 0)
> -		return ret;
> +	if (ret =3D=3D 0)
> +		return -ETIMEDOUT;
> =20
>  	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
>  }

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
