Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C86EAD08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjDUOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjDUOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:35:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3829ECF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:35:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2840221A4A;
        Fri, 21 Apr 2023 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682087703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O897qBKMLNrTQgrC3wnw3yjiFh10KFnNeBIpFrM0pZA=;
        b=oOVJwz74JNNcdSGx2s6uXoRXXdz1y5XtGWGRqiO9jL0ybMkdPqUB0o+WyuB1s0Exh2DDC9
        YwUxXrzbe7vS2uhUBvv5I9W/VjRrGYwSqmrSmXRah6/T4ymCmEDB7zMX9GZAPx4UT0VfiZ
        DLfQLSXcylwn6IIcgowlurG9Sy3fJiI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBEC013456;
        Fri, 21 Apr 2023 14:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DcM5NBafQmRdfgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 21 Apr 2023 14:35:02 +0000
Message-ID: <269cf003-3f96-727d-4a7c-72d52dba8854@suse.com>
Date:   Fri, 21 Apr 2023 16:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
 <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
 <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
 <20230421112355.GAZEJyS+w84odQ9s2i@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230421112355.GAZEJyS+w84odQ9s2i@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6pcm0QV1K0FZzcr9yvhpQ3cz"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6pcm0QV1K0FZzcr9yvhpQ3cz
Content-Type: multipart/mixed; boundary="------------Y0tfvXFDe0WlXAwBPZVMalxO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <269cf003-3f96-727d-4a7c-72d52dba8854@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
 <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
 <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
 <20230421112355.GAZEJyS+w84odQ9s2i@fat_crate.local>
In-Reply-To: <20230421112355.GAZEJyS+w84odQ9s2i@fat_crate.local>

--------------Y0tfvXFDe0WlXAwBPZVMalxO
Content-Type: multipart/mixed; boundary="------------wbCWNjASVD9ymPRnsnzYe6HG"

--------------wbCWNjASVD9ymPRnsnzYe6HG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDQuMjMgMTM6MjMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjAsIDIwMjMgYXQgMDU6MTA6MDNQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEkgdGhpbmsgdGhpcyB3aWxsIG5lZWQgYW5vdGhlciBmaW5hbCBsb29wIG92ZXIgdGhl
IE1UUlJzIHRvIGNoZWNrIGFnYWluc3QgdGhlDQo+PiBjb25zdHJ1Y3RlZCBtYXAgaWYgYSBN
VFJSIGlzIGNvbXBsZXRlbHkgdXNlbGVzcy4NCj4gDQo+IFllYWgsIEkgc2xlcHQgb24gaXQ6
IHNvIEkgdGhpbmsgdGhlcmUgc2hvdWxkIGJlIGEgcGF0Y2ggb250b3Agd2hpY2ggZG9lcw0K
PiBhZGQgZGVidWcgb3V0cHV0IC0gZGlzYWJsZWQgYnkgZGVmYXVsdCBhbmQgY29udHJvbGxh
YmxlIGJ5IGFkZGluZw0KPiAibXRycj1kZWJ1ZyIgb24gdGhlIGNtZGxpbmUgb3Igc28gLSB3
aGljaCBkdW1wcyB0aGUgY2FjaGUgbWFwIG9wZXJhdGlvbnMNCj4gKGFkZC9yZW1vdmUpIGFu
ZCB0aGUgZmluYWwgdGFibGUuDQoNCk9rYXkuDQoNCj4gVGhlIHJlYXNvbiBiZWluZywgd2hl
biB0aGlzIGNhY2hlX21hcCB0aGluZyBoaXRzIHVwc3RyZWFtLCB3ZSB3b3VsZCBuZWVkDQo+
IGEgd2F5IHRvIGRlYnVnIGFueSBwb3RlbnRpYWwgaXNzdWVzIHdoaWNoIHBlb3BsZSBtaWdo
dCByZXBvcnQgc28gYXNraW5nDQo+IHRoZW0gdG8gZG8gYSAibXRycj1kZWJ1ZyIgYm9vdCB3
b3VsZCBiZSBhIGdvb2QgaGVscC4NCj4gDQo+IEFuZCBwbHMgbWFrZSB0aGUgcHJpbnRzIHBy
X2luZm8oKSBhbmQgbm90IHByX2RlYnVnKCkgYmVjYXVzZSBwZW9wbGUNCj4gc2hvdWxkIG5v
dCBoYXZlIHRvIHJlY29tcGlsZSBpbiBvcmRlciB0byBlbmFibGUgdGhhdC4NCg0KQWdyZWVk
Lg0KDQo+PiBBbm90aGVyIHF1ZXN0aW9uOiBpbiBjYXNlIHdlIGRldGVjdCBzdWNoIGEgaGlk
ZGVuIE1UUlIsIHNob3VsZCBpdCBiZSBkaXNhYmxlZA0KPj4gaW4gb3JkZXIgdG8gaGF2ZSBt
b3JlIE1UUlJzIGF2YWlsYWJsZSBmb3IgcnVuLXRpbWUgYWRkaW5nPw0KPiANCj4gTGV0J3Mg
bm90IGRvIGFueXRoaW5nIGZvciBub3cgYW5kIGFkZHJlc3MgdGhpcyBpZiByZWFsbHkgbmVl
ZGVkLg0KDQpPa2F5Lg0KDQoNCkp1ZXJnZW4NCg==
--------------wbCWNjASVD9ymPRnsnzYe6HG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wbCWNjASVD9ymPRnsnzYe6HG--

--------------Y0tfvXFDe0WlXAwBPZVMalxO--

--------------6pcm0QV1K0FZzcr9yvhpQ3cz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRCnxYFAwAAAAAACgkQsN6d1ii/Ey/c
4gf/ex4969ryl7HeiEatKKkUcdgs/u1dKHh3RrRal09UH5kgHteNtTD+fzW9qMfRp3JtVCksC0kr
cN4qnp9LEroUMotFcL1I+7YR7X7eZDV08xgdsUeoceLk6yW3YdBxwGxEATn45Qjbct/NCrBXEd/3
e7r3gf7rqlWrLWbDmRRoLgjYMZEIimwuU6wjRW2dVQk+iH4B7359oc4jWQPF5IC3uaIE4Rm8Y4Ob
Jier7w/ZMwN1jvDnQ3VLTpFuTcRNCbJs+rEdhltqOhkpy1h1eQghQHIzmJdd+Z0xeqmuFDpaJbTr
JOY9MH8R0owIbE/8nWUgocdw7T3J7QXP9jwLTPvSnA==
=oOQN
-----END PGP SIGNATURE-----

--------------6pcm0QV1K0FZzcr9yvhpQ3cz--
