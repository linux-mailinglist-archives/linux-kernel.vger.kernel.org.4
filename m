Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C792A72768C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjFHFQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjFHFQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71A26B6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7CCA1FDCC;
        Thu,  8 Jun 2023 05:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686201357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9gJiPyN5uUZaRAOL4t3zxuJ8jj+Ni5BCZiIrfQ/IHUU=;
        b=cKcE1uop5+F6xdcx/Atk5SQDtYt+7VXjwx8fCTaozF33UZ164NNXqWEs+lJYS7EfPDCUcX
        8LbGtWExk9UXiS3aBkz6zbTjHeepc/3Lm0dzg2qfGxgBU3/Win7D5qk8a6Gcelw0Fp7i/U
        jpAuedcGlmS22C6pp3MXpf6pUUUEV+U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7572D1346D;
        Thu,  8 Jun 2023 05:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4AFuGg1kgWSUAQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 08 Jun 2023 05:15:57 +0000
Message-ID: <a05f418a-2b5f-9417-8b4a-cbdcafddbcd5@suse.com>
Date:   Thu, 8 Jun 2023 07:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/mm: Fix PAT bit missing from page protection
 modify mask
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "janusz.krzysztofik@linux.intel.com" 
        <janusz.krzysztofik@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
References: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
 <a20344fd-8130-013e-e773-acae81aad55a@intel.com>
 <38324471.J2Yia2DhmK@jkrzyszt-mobl2.ger.corp.intel.com>
 <ad762335fd209fd8c1555401bc03e196eb53caef.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ad762335fd209fd8c1555401bc03e196eb53caef.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X0gF9tLy8wFWtDwR07yfl1wR"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X0gF9tLy8wFWtDwR07yfl1wR
Content-Type: multipart/mixed; boundary="------------ixkpeHNCvDt32YUyICLMJjrk";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Hansen, Dave" <dave.hansen@intel.com>,
 "janusz.krzysztofik@linux.intel.com" <janusz.krzysztofik@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Message-ID: <a05f418a-2b5f-9417-8b4a-cbdcafddbcd5@suse.com>
Subject: Re: [PATCH v2] x86/mm: Fix PAT bit missing from page protection
 modify mask
References: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
 <a20344fd-8130-013e-e773-acae81aad55a@intel.com>
 <38324471.J2Yia2DhmK@jkrzyszt-mobl2.ger.corp.intel.com>
 <ad762335fd209fd8c1555401bc03e196eb53caef.camel@intel.com>
In-Reply-To: <ad762335fd209fd8c1555401bc03e196eb53caef.camel@intel.com>

--------------ixkpeHNCvDt32YUyICLMJjrk
Content-Type: multipart/mixed; boundary="------------n7B8OwmlJAnv5K3wOMPfXf96"

--------------n7B8OwmlJAnv5K3wOMPfXf96
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDYuMjMgMjM6MTIsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiBPbiBXZWQs
IDIwMjMtMDYtMDcgYXQgMTk6MTEgKzAyMDAsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90ZToN
Cj4+IE9uIFdlZG5lc2RheSwgNyBKdW5lIDIwMjMgMTc6MzE6MjQgQ0VTVCBEYXZlIEhhbnNl
biB3cm90ZToNCj4+PiBPbiA2LzcvMjMgMDg6MjMsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90
ZToNCj4+Pj4NCj4+Pj4gRXh0ZW5kIGJpdG1hc2sgdXNlZCBieSBwZ3Byb3RfbW9kaWZ5KCkg
Zm9yIHNlbGVjdGluZyBiaXRzIHRvIGJlDQo+Pj4+IHByZXNlcnZlZA0KPj4+PiB3aXRoIF9Q
QUdFX1BBVCBiaXQuwqAgSG93ZXZlciwgc2luY2UgdGhhdCBiaXQgY2FuIGJlIHJldXNlZCBh
cw0KPj4+PiBfUEFHRV9QU0UsDQo+Pj4+IGFuZCB0aGUgX1BBR0VfQ0hHX01BU0sgc3ltYm9s
LCBwcmltYXJseSB1c2VkIGJ5IHB0ZV9tb2RpZnkoKSwgaXMNCj4+Pj4gbGlrZWx5DQo+Pj4+
IGludGVudGlvbmFsbHkgZGVmaW5lZCB3aXRoIHRoYXQgYml0IG5vdCBzZXQsIGtlZXAgdGhh
dCBzeW1ib2wNCj4+Pj4gdW5jaGFuZ2VkLg0KPj4+DQo+Pj4gSSdtIHJlYWxseSBoYXZpbmcg
YSBoYXJkIHRpbWUgcGFyc2luZyB3aGF0IHRoYXQgbGFzdCBzZW50ZW5jZSBpcw0KPj4+IHNh
eWluZy4NCj4+Pg0KPj4+IENvdWxkIHlvdSB0cnkgYWdhaW4sIHBsZWFzZT8NCj4+DQo+PiBP
SywgYnV0IHRoZW4gSSBuZWVkIHRvIGdldCBteSBkb3VidHMgYWRkcmVzc2VkIGJ5IHNvbWVv
bmUgZmlyc3QsDQo+PiBvdGhlcndpc2UgSSdtDQo+PiBub3QgYWJsZSB0byBwcm92aWRlIGEg
YmV0dGVyIGp1c3RpZmljYXRpb24gZnJvbSBteSBoZWFydC4NCj4+DQo+PiBUaGUgaXNzdWUg
bmVlZHMgdG8gYmUgZml4ZWQgYnkgaW5jbHVkaW5nIF9QQUdFX1BBVCBiaXQgaW50byBhIGJp
dG1hc2sNCj4+IHVzZWQNCj4+IGJ5IHBncHJvdF9tb2RpZnkoKSBmb3Igc2VsZWN0aW5nIGJp
dHMgdG8gYmUgcHJlc2VydmVkLsKgIFdlIGNhbiBlaXRoZXINCj4+IGRvDQo+PiB0aGF0IGlu
dGVybmFsbHkgdG8gcGdwcm90X21vZGlmeSgpIChteSBpbml0aWFsIHByb3Bvc2FsLCB3aGlj
aCBteQ0KPj4gcG9vcmx5DQo+PiB3b3JkZWQgcGFyYWdyYXBoIHdhcyBzdGlsbCB0cnlpbmcg
dG8gZGVzY3JpYmUgYW5kIGp1c3RpZnkpLCBvciBieQ0KPj4gbWFraW5nDQo+PiBfUEFHRV9Q
QVQgYSBwYXJ0IG9mIF9QQUdFX0NIR19NQVNLLCBhcyBzdWdnZXN0ZWQgYnkgQm9yaXNsYXYg
YW5kDQo+PiByZWZsZWN0ZWQgaW4NCj4+IG15IHYyIGNoYW5nZWxvZy7CoCBCdXQgZm9yIHRo
ZSBsYXR0ZXIsIEkgdGhpbmsgd2UgbmVlZCB0byBtYWtlIHN1cmUNCj4+IHRoYXQgd2UNCj4+
IGRvbid0IGJyZWFrIG90aGVyIHVzZXJzIG9mIF9QQUdFX0NIR19NQVNLLsKgIE1heWJlIEJv
cmlzbGF2IGNhbg0KPj4gY29uZmlybSB0aGF0J3MNCj4+IHRoZSBjYXNlLg0KPj4NCj4+IFNp
bmNlIF9QQUdFX1BBVCBpcyB0aGUgc2FtZSBhcyBfUEFHRV9QU0UsIF9IUEFHRV9DSEdfTUFT
SyAtLSBhIGh1Z2UNCj4+IHBtZHMnDQo+PiBjb3VudGVycGFydCBvZiBfUEFHRV9DSEdfTUFT
SywgaW50cm9kdWNlZCBieSBjb21taXQgYzQ4OWYxMjU3YjhjDQo+PiAoInRocDogYWRkDQo+
PiBwbWRfbW9kaWZ5IiksIGRlZmluZWQgYXMgKF9QQUdFX0NIR19NQVNLIHwgX1BBR0VfUFNF
KSAtLSB3aWxsIG5vDQo+PiBsb25nZXIgZGlmZmVyDQo+PiBmcm9tIF9QQUdFX0NIR19NQVNL
IGFzIHNvb24gYXMgd2UgYWRkIF9QQUdFX1BBVCBiaXQgdG8gdGhlIGxhdHRlci4NCj4+IElm
IHN1Y2gNCj4+IG1vZGlmaWNhdGlvbiBvZiBfUEFHRV9DSEdfTUFTSyB3YXMgaXJyZWxldmFu
dCB0byBpdHMgdXNlcnMgdGhlbiBvbmUNCj4+IG1heSBhc2sNCj4+IHdoeSBhIG5ldyBzeW1i
b2wgd2FzIGludHJvZHVjZWQgaW5zdGVhZCBvZiByZXVzaW5nIHRoZSBleGlzdGluZyBvbmUN
Cj4+IHdpdGggdGhhdA0KPj4gb3RoZXJ3aXNlIGlycmVsZXZhbnQgYml0IChfUEFHRV9QU0Ug
aW4gdGhhdCBjYXNlKSBhZGRlZC7CoCBJJ3ZlDQo+PiBpbml0aWFsbHkNCj4+IGFzc3VtZWQg
dGhhdCBrZWVwaW5nIF9QQUdFX0NIR19NQVNLIHdpdGhvdXQgX1BBR0VfUFNFICh2ZWwgX1BB
R0VfUEFUKQ0KPj4gaW5jbHVkZWQNCj4+IGludG8gaXQgd2FzIGludGVudGlvbmFsIGZvciBz
b21lIHJlYXNvbi7CoCBNYXliZSBKb2hhbm5lcyBXZWluZXIsIHRoZQ0KPj4gYXV0aG9yIG9m
DQo+PiB0aGF0IHBhdGNoIChhZGRpbmcgaGltIHRvIENjOiksIGNvdWxkIHNoZWQgbW9yZSBs
aWdodCBvbiB0aGF0Lg0KPiANCj4gU28gc2luY2UgX1BBR0VfUFNFIGlzIGFjdHVhbGx5IHRo
ZSBzYW1lIHZhbHVlIGFzIF9QQUdFX1BBVCwgeW91IGRvbid0DQo+IGFjdHVhbGx5IG5lZWQg
dG8gaGF2ZSBfUEFHRV9QU0UgaW4gX0hQQUdFX0NIR19NQVNLIGluIG9yZGVyIHRvIGdldA0K
PiBmdW5jdGlvbmFsIGNvcnJlY3RuZXNzLiBJcyB0aGF0IHJpZ2h0Pw0KPiANCj4gSSB0aGlu
ayBpdCBpcyBzdGlsbCBhIGxpdHRsZSBoaWRkZW4gKGV2ZW4gYmVmb3JlIHRoaXMpIGFuZCBJ
IHdvbmRlcg0KPiBhYm91dCBzZXBhcmF0aW5nIG91dCB0aGUgY29tbW9uIGJpdHMgaW50bywg
bGlrZSwgX0NPTU1PTl9QQUdFX0NIR19NQVNLDQo+IG9yIHNvbWV0aGluZy4gVGhlbiBzZXR0
aW5nIHNwZWNpZmljIFBBR0UgYW5kIEhQQUdFIGJpdHMgKGxpa2UNCj4gX1BBR0VfUEFULCBf
UEFHRV9QU0UgYW5kIF9QQUdFX1BBVF9MQVJHRSkgaW4gdGhlaXIgc3BlY2lmaWMgZGVmaW5l
Lg0KPiBXb3VsZCBpdCBiZSBtb3JlIHJlYWRhYmxlIHRoYXQgd2F5Pw0KDQpJJ2QgZ28gdGhh
dCByb3V0ZS4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgcmVseSBvbiBfUEFHRV9QU0UgPT0g
X1BBR0VfUEFUDQpoZXJlLg0KDQoNCkp1ZXJnZW4NCg==
--------------n7B8OwmlJAnv5K3wOMPfXf96
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------n7B8OwmlJAnv5K3wOMPfXf96--

--------------ixkpeHNCvDt32YUyICLMJjrk--

--------------X0gF9tLy8wFWtDwR07yfl1wR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSBZAwFAwAAAAAACgkQsN6d1ii/Ey+F
Ugf/XrQi7H83HuZ1iffJSMxvR+1fFL+034evWdq3z+1Y2/lVHjRnr/iYDc/ovbsKAP3BBhUPezOa
ZhPyItEe1vX18CJuLLYynBpo881t+VNBFCbDrnAxix5LQaOwbYCewv7GA9y2muVEDGJxLJ3v0BZV
scy1a8hJKiu+oKdumYLAa6seRBQhU1e+VYkRWQQXjoyrLGFYMycMbnVCeKF63bpV4OgpMKlkkaVW
r4gAvozSbvjPgMTaTwGZ29M9rER5B45IgUA6Im2QlaNHS6pfqFu0cDvJtGWbu4EZm1g6XsVjwjV0
JOJCBbcRLMgvqh7zek2uo4ha9rH2C7ocJnOtXxl1sQ==
=ODRz
-----END PGP SIGNATURE-----

--------------X0gF9tLy8wFWtDwR07yfl1wR--
