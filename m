Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADF68D607
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBGLzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjBGLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:54:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949FF752
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:54:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 392E638658;
        Tue,  7 Feb 2023 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675770894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbR6suLYqqOLXuiO1QkSDn6FDUD01CxxWkTNqAIH1aE=;
        b=HglHXMjiV1qqkxLTcqLFmaErc3HTvskC4UsSHGQdUZQgoSB5V4wlsOQ6CoSrNdi1lICCIP
        BuiM+oWdg6BTuwehMD5EnvhoSOAcBWe2pVI89QHO9HToRdyddNThjvca0zEf78tbKHDu72
        ttUDaQTyJ1J5unG6E+wl/Adxps8wYtQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFB9E139ED;
        Tue,  7 Feb 2023 11:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uYwLMQ084mMMSQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 11:54:53 +0000
Message-ID: <d8f27757-b33c-9701-e6e5-477ac6648393@suse.com>
Date:   Tue, 7 Feb 2023 12:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-6-jgross@suse.com> <Y+I5NyAeu4LWFBcA@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y+I5NyAeu4LWFBcA@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ox7uA8RfE1QKRJaXx6iIgCO3"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ox7uA8RfE1QKRJaXx6iIgCO3
Content-Type: multipart/mixed; boundary="------------2vS0rMHK9Eyf1hosjmAJ5sjR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, "Kani, Toshi" <toshi.kani@hpe.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d8f27757-b33c-9701-e6e5-477ac6648393@suse.com>
Subject: Re: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-6-jgross@suse.com> <Y+I5NyAeu4LWFBcA@zn.tnic>
In-Reply-To: <Y+I5NyAeu4LWFBcA@zn.tnic>

--------------2vS0rMHK9Eyf1hosjmAJ5sjR
Content-Type: multipart/mixed; boundary="------------047mB0EgWMNTMUbLnM3IW1xb"

--------------047mB0EgWMNTMUbLnM3IW1xb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDIuMjMgMTI6NDIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBG
ZWIgMDcsIDIwMjMgYXQgMDg6Mjk6MDFBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRvZGF5IHB1ZF9zZXRfaHVnZSgpIGFuZCBwbWRfc2V0X2h1Z2UoKSB0ZXN0IGZvciB0
aGUgTVRSUiB0eXBlIHRvIGJlDQo+PiBXQiBvciBJTlZBTElEIGFmdGVyIGNhbGxpbmcgbXRy
cl90eXBlX2xvb2t1cCgpLiBUaG9zZSB0ZXN0cyBjYW4gYmUNCj4+IGRyb3BwZWQsIGFzIHRo
ZSBvbmx5IHJlYXNvbiB0byBub3QgdXNlIGEgbGFyZ2UgbWFwcGluZyB3b3VsZCBiZQ0KPj4g
dW5pZm9ybSBiZWluZyAwLiBBbnkgTVRSUiB0eXBlIGNhbiBiZSBhY2NlcHRlZCBhcyBsb25n
IGFzIGl0IGFwcGxpZXMNCj4+IHRvIHRoZSB3aG9sZSBtZW1vcnkgcmFuZ2UgY292ZXJlZCBi
eSB0aGUgbWFwcGluZywgYXMgdGhlIGFsdGVybmF0aXZlDQo+PiB3b3VsZCBvbmx5IGJlIHRv
IG1hcCB0aGUgc2FtZSByZWdpb24gd2l0aCBzbWFsbGVyIHBhZ2VzIGluc3RlYWQgdXNpbmcN
Cj4+IHRoZSBzYW1lIFBBVCB0eXBlIGFzIGZvciB0aGUgbGFyZ2UgbWFwcGluZy4NCj4+DQo+
PiBTdWdnZXN0ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0
aW9uLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNl
LmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgfCA2ICsrLS0tLQ0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgYi9hcmNoL3g4Ni9t
bS9wZ3RhYmxlLmMNCj4+IGluZGV4IGU0ZjQ5OWViMGYyOS4uN2I5YzU0NDNkMTc2IDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jDQo+PiArKysgYi9hcmNoL3g4Ni9t
bS9wZ3RhYmxlLmMNCj4+IEBAIC03MjEsOCArNzIxLDcgQEAgaW50IHB1ZF9zZXRfaHVnZShw
dWRfdCAqcHVkLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdCBwcm90KQ0KPj4gICAJdTgg
bXRyciwgdW5pZm9ybTsNCj4+ICAgDQo+PiAgIAltdHJyID0gbXRycl90eXBlX2xvb2t1cChh
ZGRyLCBhZGRyICsgUFVEX1NJWkUsICZ1bmlmb3JtKTsNCj4+IC0JaWYgKChtdHJyICE9IE1U
UlJfVFlQRV9JTlZBTElEKSAmJiAoIXVuaWZvcm0pICYmDQo+PiAtCSAgICAobXRyciAhPSBN
VFJSX1RZUEVfV1JCQUNLKSkNCj4+ICsJaWYgKCF1bmlmb3JtKQ0KPj4gICAJCXJldHVybiAw
Ow0KPj4gICANCj4+ICAgCS8qIEJhaWwgb3V0IGlmIHdlIGFyZSB3ZSBvbiBhIHBvcHVsYXRl
ZCBub24tbGVhZiBlbnRyeTogKi8NCj4+IEBAIC03NDgsOCArNzQ3LDcgQEAgaW50IHBtZF9z
ZXRfaHVnZShwbWRfdCAqcG1kLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdCBwcm90KQ0K
Pj4gICAJdTggbXRyciwgdW5pZm9ybTsNCj4+ICAgDQo+PiAgIAltdHJyID0gbXRycl90eXBl
X2xvb2t1cChhZGRyLCBhZGRyICsgUE1EX1NJWkUsICZ1bmlmb3JtKTsNCj4+IC0JaWYgKCht
dHJyICE9IE1UUlJfVFlQRV9JTlZBTElEKSAmJiAoIXVuaWZvcm0pICYmDQo+PiAtCSAgICAo
bXRyciAhPSBNVFJSX1RZUEVfV1JCQUNLKSkgew0KPj4gKwlpZiAoIXVuaWZvcm0pIHsNCj4+
ICAgCQlwcl93YXJuX29uY2UoIiVzOiBDYW5ub3Qgc2F0aXNmeSBbbWVtICUjMDEwbGx4LSUj
MDEwbGx4XSB3aXRoIGEgaHVnZS1wYWdlIG1hcHBpbmcgZHVlIHRvIE1UUlIgb3ZlcnJpZGUu
XG4iLA0KPj4gICAJCQkgICAgIF9fZnVuY19fLCBhZGRyLCBhZGRyICsgUE1EX1NJWkUpOw0K
Pj4gICAJCXJldHVybiAwOw0KPj4gLS0gDQo+IA0KPiBTZWUgbXkgcmVwbHkgaGVyZToNCj4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZK0RMcVY1TWZ1QkpSbmI2QHpuLnRu
aWMNCj4gDQo+IEkgdW5kZXJzdGFuZCBpdCBhcyBXQiBpcyBvaywgZm9yIGV4YW1wbGUsIGV2
ZW4gaWYgbm90IHVuaWZvcm0uIFRoYXQNCj4gdGhpbmcgaW4gbXRycl90eXBlX2xvb2t1cCgp
Og0KPiANCj4gICAgICAgICAgLyoNCj4gICAgICAgICAgICogTG9vayB1cCB0aGUgZml4ZWQg
cmFuZ2VzIGZpcnN0LCB3aGljaCB0YWtlIHByaW9yaXR5IG92ZXINCj4gICAgICAgICAgICog
dGhlIHZhcmlhYmxlIHJhbmdlcy4NCj4gICAgICAgICAgICovDQo+ICAgICAgICAgIGlmICgo
c3RhcnQgPCAweDEwMDAwMCkgJiYNCj4gICAgICAgICAgICAgIChtdHJyX3N0YXRlLmhhdmVf
Zml4ZWQpICYmDQo+ICAgICAgICAgICAgICAobXRycl9zdGF0ZS5lbmFibGVkICYgTVRSUl9T
VEFURV9NVFJSX0ZJWEVEX0VOQUJMRUQpKSB7DQo+ICAgICAgICAgICAgICAgICAgaXNfdW5p
Zm9ybSA9IDA7DQo+ICAgICAgICAgICAgICAgICAgdHlwZSA9IG10cnJfdHlwZV9sb29rdXBf
Zml4ZWQoc3RhcnQsIGVuZCk7DQo+ICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAg
ICAgICAgIH0NCj4gDQo+IElmIHRoYXQgY2FuIHJldHVybiBXQiwgdGhlbiBJIGd1ZXNzIHRo
YXQgc2F5cyBpdCBpcyBzdGlsbCBvay4gQ2FuIHRoZQ0KPiBmaXhlZCByYW5nZXMgZXZlbiBj
b3ZlciBhLCBhdCBsZWFzdCBhIFBNRD8gSSBndWVzcyBJIG5lZWQgdG8gc3RhcmUgYXQNCj4g
dGhpcyBtb3JlLg0KDQpGaXhlZCBNVFJScyBhcmUgYWxsIGJlbG93IDFNQi4gU28gbm8sIHRo
ZXkgY2FuJ3QgY292ZXIgYSBQTUQuDQoNCg0KSnVlcmdlbg0K
--------------047mB0EgWMNTMUbLnM3IW1xb
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------047mB0EgWMNTMUbLnM3IW1xb--

--------------2vS0rMHK9Eyf1hosjmAJ5sjR--

--------------ox7uA8RfE1QKRJaXx6iIgCO3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPiPA0FAwAAAAAACgkQsN6d1ii/Ey8W
Fgf9F4H8lb1SjOG/Vc5fG1QBEc17Y6J1Ok/egN5GjHdp+pA4U4a55RaknccDrAxN2rJlmZYtjPGO
uWqjrrh+l0zFprd3JIDxwXS1d4RSAg+sBOnPh/ZEd6oVnXBjlIC7qhioU/7RxIp72yOamnXbKeJR
Uo8UHaesVvzdZgxaZg1mq28QCokK8PdV8y0r+SHLRhteKMOn+nHOm2z30cH0tZJkoIY/BGIDKbqe
fWfnONgtduI7vmrA410isw0qAYtseXs6AbIHF+X91RPOvhAf1OWtK2Z28vwnjM5kNkwBQzEpkX97
BKvjmyHXMRIdUriedJemlfwrlv9VrXTaW7HVKpzF9Q==
=YTID
-----END PGP SIGNATURE-----

--------------ox7uA8RfE1QKRJaXx6iIgCO3--
