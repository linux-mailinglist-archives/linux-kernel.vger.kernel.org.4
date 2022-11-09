Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8176F6228A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKIKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKIKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:39:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EC1CB04;
        Wed,  9 Nov 2022 02:39:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A49F1F85D;
        Wed,  9 Nov 2022 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667990360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDh4D/lowW+cKoGphNyyhhicP75Q+8FcnZtIV8Bc6j8=;
        b=F8hZZ8Rb4zWaiKKol9lmsSSJsVmstxOU9rbJ331eqhxbz0svps7X7JJz6a2MDii5xvH6c2
        YXgKrY0Gu37vTB2Je5Sli7jDUwGgLNufl76+uEp4spOefPT9h+vYWvoP3W8ApFNqgwvl0w
        RQmzgTK5PgALPSjlFV180CKcGDnR3yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667990360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDh4D/lowW+cKoGphNyyhhicP75Q+8FcnZtIV8Bc6j8=;
        b=tpjkIUz+w55Ap5sAbastYjECyHmW359FhWBJ4QwYqQu+6kzFc1sZAsONQlBwilbhHMHH5H
        Vzk3k4EL8pseM0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E784139F1;
        Wed,  9 Nov 2022 10:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2AUhBliDa2MKHgAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 09 Nov 2022 10:39:20 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] crypto: xts - restrict key lengths to approved
 values in FIPS mode
References: <20221108142025.13461-1-nstange@suse.de>
        <20221108142025.13461-2-nstange@suse.de>
        <MW5PR84MB1842A19B7BDA70A7C81AFB98AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Wed, 09 Nov 2022 11:39:19 +0100
In-Reply-To: <MW5PR84MB1842A19B7BDA70A7C81AFB98AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
        (Robert Elliott's message of "Tue, 8 Nov 2022 17:12:21 +0000")
Message-ID: <87h6z8e7jc.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
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

"Elliott, Robert (Servers)" <elliott@hpe.com> writes:

>> diff --git a/include/crypto/xts.h b/include/crypto/xts.h
> ...
>> @@ -35,6 +35,13 @@ static inline int xts_verify_key(struct crypto_skciph=
er
>> *tfm,
>>  	if (keylen % 2)
>>  		return -EINVAL;
>>=20
>> +	/*
>> +	 * In FIPS mode only a combined key length of either 256 or
>> +	 * 512 bits is allowed, c.f. FIPS 140-3 IG C.I.
>> +	 */
>> +	if (fips_enabled && keylen !=3D 32 && keylen !=3D 64)
>> +		return -EINVAL;
>> +
>>  	/* ensure that the AES and tweak key are not identical */
>>  	if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
>>  			      CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
>> --
>> 2.38.0
>
> arch/s390/crypto/aes_s390.c has similar lines:
>
> static int xts_aes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
>                            unsigned int key_len)
> {
>         struct s390_xts_ctx *xts_ctx =3D crypto_skcipher_ctx(tfm);
>         unsigned long fc;
>         int err;
>
>         err =3D xts_fallback_setkey(tfm, in_key, key_len);
>         if (err)
>                 return err;
>
>         /* In fips mode only 128 bit or 256 bit keys are valid */
>         if (fips_enabled && key_len !=3D 32 && key_len !=3D 64)
>                 return -EINVAL;
>
>
> xts_fallback_setkey will now enforce that rule when setting up the
> fallback algorithm keys, which makes the xts_aes_set_key check
> unreachable.

Good finding!

>
> If that fallback setup were not present, then a call to xts_verify_key
> might be preferable to enforce any other rules like the WEAK_KEYS
> rule.
>

So if this patch here would get accepted, I'd propose to remove the then
dead code from aes_s390 afterwards and make an explicit call to
xts_verify_key() instead.

Or shall I split out the XTS patch from this series here and post these
two changes separately then? Herbert, any preferences?

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
