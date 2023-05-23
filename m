Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172370E5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjEWTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjEWTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53AE5C;
        Tue, 23 May 2023 12:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 988E7614CA;
        Tue, 23 May 2023 19:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FB0C433A7;
        Tue, 23 May 2023 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870293;
        bh=fEQZfZn5b2tz3jlTtblP8a+rszppmN0jg8sXDGhtXeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usU278Wr4c/mRirtZ2tN9HB9e6QlVRR7/csvABxkapYIaECGkRuQLe+XJ2avGzkLq
         JniTVZGWmFyXqiTY8FVE6BBdbuwdZFIC3khMY1/LbcbNp2MaVzzgYlA4OJeuPPpSMm
         hWIaeVvzKFFOz5seILA1exrJCTNRMv6Pt5smylLikyx2iEGhfJHOTAWBOQsyGUBhDm
         yBW8/SXlOG8z4dDEJU0GTh/HXdgB4/usV5xhj2QAQUjefEpsft/cxenOV52A/Bf6x5
         EzHH4JB1h0lLsh2PZT94HyYmf56XHDh+k0u2hlg+3MK3SZH7eM2m46q7UgmdiA0P9A
         LW/0oX4Yn6d+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 22:31:29 +0300
Message-Id: <CSTWO5EA6LPR.32BAX2H2GMPZ6@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        <selinux@vger.kernel.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] security: keys: perform capable check only on
 privileged operations
X-Mailer: aerc 0.14.0
References: <20230511123252.723185-1-cgzones@googlemail.com>
In-Reply-To: <20230511123252.723185-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 11, 2023 at 3:32 PM EEST, Christian G=C3=B6ttsche wrote:
> If the current task fails the check for the queried capability via
> `capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
> Issuing such denial messages unnecessarily can lead to a policy author
> granting more privileges to a subject than needed to silence them.
>
> Reorder CAP_SYS_ADMIN checks after the check whether the operation is
> actually privileged.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/keys/keyctl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d54f73c558f7..19be69fa4d05 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, =
gid_t group)
>  	ret =3D -EACCES;
>  	down_write(&key->sem);
> =20
> -	if (!capable(CAP_SYS_ADMIN)) {
> +	{
> +		bool is_privileged_op =3D false;
> +
>  		/* only the sysadmin can chown a key to some other UID */
>  		if (user !=3D (uid_t) -1 && !uid_eq(key->uid, uid))
> -			goto error_put;
> +			is_privileged_op =3D true;
> =20
>  		/* only the sysadmin can set the key's GID to a group other
>  		 * than one of those that the current process subscribes to */
>  		if (group !=3D (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid=
))
> +			is_privileged_op =3D true;
> +
> +		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
>  			goto error_put;
>  	}
> =20
> @@ -1088,7 +1093,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t=
 perm)
>  	down_write(&key->sem);
> =20
>  	/* if we're not the sysadmin, we can only change a key that we own */
> -	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
> +	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
>  		key->perm =3D perm;
>  		notify_key(key, NOTIFY_KEY_SETATTR, 0);
>  		ret =3D 0;
> --=20
> 2.40.1

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

