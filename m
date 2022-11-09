Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4336227F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiKIKGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKIKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:06:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37989F009;
        Wed,  9 Nov 2022 02:06:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0DD41F8D2;
        Wed,  9 Nov 2022 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667988377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNpDpEZXLt94VEJ8mUzOzUj6ooYgifJ9t78nlAa0rog=;
        b=etxxpe6FqF/j1vzd/lvzJ6Hsq0hwVYYUklGqfdCvtrvng6XG7R8yfkcNZtDQR1AKKt3lDB
        nxwDguxGGvYuKA4Y9ZP705Ml2FoHswF6TPZe7+8BiP/rdcYhfYHCPgVluhYArPuhQr0aT7
        bI8y457jeCA+gALsosKPteiAQK/XZZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667988377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNpDpEZXLt94VEJ8mUzOzUj6ooYgifJ9t78nlAa0rog=;
        b=9teakqvrfc+HSn0KfqtDHaSb0+pT2QqHscpp/YmFg+20zJsTYucsDpi6bYjdKxQ6gAFsAk
        4i1I1T5BaBIQ+SAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5C35139F1;
        Wed,  9 Nov 2022 10:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iykzJ5l7a2OjCwAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 09 Nov 2022 10:06:17 +0000
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
        <MW5PR84MB1842EEC44A8CB6594D4D0CD0AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Wed, 09 Nov 2022 11:06:17 +0100
In-Reply-To: <MW5PR84MB1842EEC44A8CB6594D4D0CD0AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
        (Robert Elliott's message of "Tue, 8 Nov 2022 20:34:10 +0000")
Message-ID: <8735asfnmu.fsf@suse.de>
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
> There's another function in the same file called xts_check_key()=20
> that is used by some of the hardware drivers:

Right, thanks for spotting.

AFAICT, xts_check_key() is the older of the two variants,
xts_verify_key() had been introduced with commit f1c131b45410 ("crypto:
xts - Convert to skcipher"). There had initially only been a single
call from generic crypto/xts.c and the main difference to
xts_check_key() had been that it took a crypto_skcipher for its tfm
argument rather than a plain crypto_tfm as xts_check_key() did.

It seems that over time, xts crypto drivers adopted the newer
xts_verify_key() variant then.

>
> arch/s390/crypto/paes_s390.c:    * xts_check_key verifies the key length =
is not odd and makes
>  [that references it in the comment but actually calls xts_verify_key in =
the code]
> drivers/crypto/axis/artpec6_crypto.c:   ret =3D xts_check_key(&cipher->ba=
se, key, keylen);
> drivers/crypto/cavium/cpt/cptvf_algs.c: err =3D xts_check_key(tfm, key, k=
eylen);
> drivers/crypto/cavium/nitrox/nitrox_skcipher.c: ret =3D xts_check_key(tfm=
, key, keylen);
> drivers/crypto/ccree/cc_cipher.c:           xts_check_key(tfm, key, keyle=
n)) {
> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:       ret =3D xts_check=
_key(crypto_skcipher_tfm(tfm), key, keylen);
> drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c:     ret =3D xts_check=
_key(crypto_skcipher_tfm(tfm), key, keylen);
> drivers/crypto/atmel-aes.c:     err =3D xts_check_key(crypto_skcipher_tfm=
(tfm), key, keylen);
>
> It already has one check qualified by fips_enabled:
>
>         /* ensure that the AES and tweak key are not identical */
>         if (fips_enabled && !crypto_memneq(key, key + (keylen / 2), keyle=
n / 2))
>                 return -EINVAL;
>
> Should that implement the same key length restrictions?

From a quick glance, all of the above drivers merely convert some
crypto_skcipher to a crypto_tfm before passing it to xts_check_key().

So I think these should all be made to call xts_verify_key() directly
instead, the former xts_check_key() could then get dropped. But that's
more of a cleanup IMO and would probably deserve a separate patch series
on its own.

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
