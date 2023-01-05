Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57B465E9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjAELQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAELQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:16:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DE1D0F0;
        Thu,  5 Jan 2023 03:16:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6E6023335;
        Thu,  5 Jan 2023 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672917391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7n2TLWZUeXlz4UUe5JOJfFdhwFDZQCcQTs4uHbEOxA=;
        b=UbGQPfMUThQHZkdpxN1mAEKxlhi3GOxxTtP/vcWT2uu2loDTBIl4pTHLBMTt38Sy6jITHG
        wCVgk955j2VElID8hRO7jx1fvvX/Y9muWIR8DWjItODFHdjRRTC26jKlBH7GMhiSOAZ347
        qSVu1rRHoMew2tu5CQlk7Cqcoptk6fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672917391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7n2TLWZUeXlz4UUe5JOJfFdhwFDZQCcQTs4uHbEOxA=;
        b=s6sLvnGN4C+Nv1uMX0QxXPm5h4Sir0ilHDpMS1ekLIsHnszX2sTCIj6Rr2VuKNU/J9CRmA
        bJFBs/G+3995wgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63CD413338;
        Thu,  5 Jan 2023 11:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b7QVF4+xtmNJKgAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 05 Jan 2023 11:16:31 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] crypto: xts - drop redundant xts key check
In-Reply-To: <20221229211710.14912-4-vdronov@redhat.com> (Vladis Dronov's
        message of "Thu, 29 Dec 2022 22:17:07 +0100")
References: <20221229211710.14912-1-vdronov@redhat.com>
        <20221229211710.14912-4-vdronov@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 05 Jan 2023 12:16:30 +0100
Message-ID: <87pmbtb59t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladis,

the patch subject prefix is a bit misleading IMO, it kind of suggests
that this patch would apply to the generic crypto/xts.c. How about using
a format similar to e.g. the one from commit 7988fb2c03c8 ("crypto:
s390/aes - convert to skcipher API"), i.e.

  "crypto: s390/aes - drop redundant xts key check"

?

Vladis Dronov <vdronov@redhat.com> writes:

> xts_fallback_setkey() in xts_aes_set_key() will now enforce key size
> rule in FIPS mode when setting up the fallback algorithm keys,

I think it would be nice to make it more explicit why/how
xts_fallback_setkey() happens to enforce the key size rules now.

Perhaps amend the above sentence by something like

  "xts_fallback_setkey() in xts_aes_set_key() will now implictly enforce
   the key size rule in FIPS mode by means of invoking the generic xts
   implementation with its key checks for setting up the fallback
   algorithm,"

?

> which makes the check in xts_aes_set_key() redundant or
> unreachable. So just drop this check.
>
> xts_fallback_setkey() now makes a key size check in xts_verify_key():
>
> xts_fallback_setkey()
>   crypto_skcipher_setkey() [ skcipher_setkey_unaligned() ]
>     cipher->setkey() { .setkey =3D xts_setkey }
>       xts_setkey()
>         xts_verify_key()
>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  arch/s390/crypto/aes_s390.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 526c3f40f6a2..c773820e4af9 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -398,10 +398,6 @@ static int xts_aes_set_key(struct crypto_skcipher *t=
fm, const u8 *in_key,
>  	if (err)
>  		return err;
>=20=20
> -	/* In fips mode only 128 bit or 256 bit keys are valid */
> -	if (fips_enabled && key_len !=3D 32 && key_len !=3D 64)
> -		return -EINVAL;
> -

The change itself looks good, but it might be worth adding a comment
right at the invocation of xts_fallback_setkey() that this includes an
implicit xts_verify_key() check? So that if anybody ever was about to
remove the xts_fallback_setkey() for some reason in the future, it would
give a clear indication that xts_verify_key() needs to get called
directly instead?

Thanks!

Nicolai

>  	/* Pick the correct function code based on the key length */
>  	fc =3D (key_len =3D=3D 32) ? CPACF_KM_XTS_128 :
>  	     (key_len =3D=3D 64) ? CPACF_KM_XTS_256 : 0;

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
