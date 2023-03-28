Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84E06CBCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC1K6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC1K6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:58:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B272AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:58:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA3DD219D0;
        Tue, 28 Mar 2023 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680001118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JcTpx7oqnqnbUFSMAXkJp9bY3dxx2D+gAhxJsUNceng=;
        b=a8Ut/Gbuwg1fLhLobNIxlJY2I1UuHRPp8TPslzsY1XAVH1lBzAlcbQh4j6SL2wGN42XHCG
        e9nyil4OMslMN3tQlbj+XDNsSz1uQFkS38svcZ3N4Qb4j2j77+fW3wWdmZBXGBrVC7ZjRZ
        3VXHpBCbpquf1eI8bVFkamBMfG+Psr0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90F371390D;
        Tue, 28 Mar 2023 10:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rWPrIV7IImRnfQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 28 Mar 2023 10:58:38 +0000
Message-ID: <bd3dbee2-2cae-228c-fd31-05911fef2a89@suse.com>
Date:   Tue, 28 Mar 2023 12:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] xen/pvcalls: don't call bind_evtchn_to_irqhandler() under
 lock
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230328093924.12260-1-jgross@suse.com>
 <a9799084-fef5-73b2-3631-6d61c713a18f@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <a9799084-fef5-73b2-3631-6d61c713a18f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8v2meAxAYsA631pM7Yk8AcmT"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8v2meAxAYsA631pM7Yk8AcmT
Content-Type: multipart/mixed; boundary="------------ZZ3Z0CuDQgh7Sc7u4VooHLRG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <bd3dbee2-2cae-228c-fd31-05911fef2a89@suse.com>
Subject: Re: [PATCH] xen/pvcalls: don't call bind_evtchn_to_irqhandler() under
 lock
References: <20230328093924.12260-1-jgross@suse.com>
 <a9799084-fef5-73b2-3631-6d61c713a18f@gmail.com>
In-Reply-To: <a9799084-fef5-73b2-3631-6d61c713a18f@gmail.com>

--------------ZZ3Z0CuDQgh7Sc7u4VooHLRG
Content-Type: multipart/mixed; boundary="------------KhWCnnap0ZD04wlpoW0NFLhH"

--------------KhWCnnap0ZD04wlpoW0NFLhH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDMuMjMgMTI6MzQsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDI4LjAzLjIzIDEyOjM5LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVs
bG8gSnVlcmdlbg0KPiANCj4gDQo+PiBiaW5kX2V2dGNobl90b19pcnFoYW5kbGVyKCkgc2hv
dWxkbid0IGJlIGNhbGxlZCB1bmRlciBzcGlubG9jaywgYXMgaXQNCj4+IGNhbiBzbGVlcC4N
Cj4+DQo+PiBUaGlzIHJlcXVpcmVzIHRvIG1vdmUgdGhlIGNhbGxzIG9mIGNyZWF0ZV9hY3Rp
dmUoKSBvdXQgb2YgdGhlIGxvY2tlZA0KPj4gcmVnaW9ucy4gVGhpcyBpcyBubyBwcm9ibGVt
LCBhcyB0aGUgd29yc3Qgd2hpY2ggY291bGQgaGFwcGVuIHdvdWxkIGJlDQo+PiBhIHNwdXJp
b3VzIGNhbGwgb2YgdGhlIGludGVycnVwdCBoYW5kbGVyLCBjYXVzaW5nIGEgc3B1cmlvdXMg
d2FrZV91cCgpLg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxlcnJvcjI3
QGdtYWlsLmNvbT4NCj4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWStK
VUlsNjRVRG1ka2JvaEBrYWRhbS8NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy94ZW4vcHZjYWxscy1m
cm9udC5jIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9wdmNhbGxzLWZyb250LmMgYi9kcml2
ZXJzL3hlbi9wdmNhbGxzLWZyb250LmMNCj4+IGluZGV4IGQ1ZDU4OWJkYTI0My4uNmU1ZDcx
MmUzMTE1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy94ZW4vcHZjYWxscy1mcm9udC5jDQo+
PiArKysgYi9kcml2ZXJzL3hlbi9wdmNhbGxzLWZyb250LmMNCj4+IEBAIC0yMjcsMjIgKzIy
NywzMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgcHZjYWxsc19mcm9udF9ldmVudF9oYW5kbGVy
KGludCBpcnEsIA0KPj4gdm9pZCAqZGV2X2lkKQ0KPj4gwqAgc3RhdGljIHZvaWQgZnJlZV9h
Y3RpdmVfcmluZyhzdHJ1Y3Qgc29ja19tYXBwaW5nICptYXApOw0KPj4gLXN0YXRpYyB2b2lk
IHB2Y2FsbHNfZnJvbnRfZnJlZV9tYXAoc3RydWN0IHB2Y2FsbHNfYmVkYXRhICpiZWRhdGEs
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBzb2Nr
X21hcHBpbmcgKm1hcCkNCj4+ICtzdGF0aWMgdm9pZCBwdmNhbGxzX2Zyb250X2Rlc3Ryb3lf
YWN0aXZlKHN0cnVjdCBwdmNhbGxzX2JlZGF0YSAqYmVkYXRhLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNvY2tfbWFwcGluZyAqbWFw
KQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBpbnQgaTsNCj4+IMKgwqDCoMKgwqAgdW5iaW5k
X2Zyb21faXJxaGFuZGxlcihtYXAtPmFjdGl2ZS5pcnEsIG1hcCk7DQo+PiAtwqDCoMKgIHNw
aW5fbG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+PiAtwqDCoMKgIGlmICghbGlzdF9l
bXB0eSgmbWFwLT5saXN0KSkNCj4+IC3CoMKgwqDCoMKgwqDCoCBsaXN0X2RlbF9pbml0KCZt
YXAtPmxpc3QpOw0KPj4gLcKgwqDCoCBzcGluX3VubG9jaygmYmVkYXRhLT5zb2NrZXRfbG9j
ayk7DQo+PiArwqDCoMKgIGlmIChiZWRhdGEpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBzcGlu
X2xvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICgh
bGlzdF9lbXB0eSgmbWFwLT5saXN0KSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxp
c3RfZGVsX2luaXQoJm1hcC0+bGlzdCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxv
Y2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPj4gK8KgwqDCoCB9DQo+PiDCoMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCAoMSA8PCBQVkNBTExTX1JJTkdfT1JERVIpOyBpKyspDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZ250dGFiX2VuZF9mb3JlaWduX2FjY2VzcyhtYXAtPmFjdGl2
ZS5yaW5nLT5yZWZbaV0sIE5VTEwpOw0KPj4gwqDCoMKgwqDCoCBnbnR0YWJfZW5kX2ZvcmVp
Z25fYWNjZXNzKG1hcC0+YWN0aXZlLnJlZiwgTlVMTCk7DQo+PiArDQo+PiDCoMKgwqDCoMKg
IGZyZWVfYWN0aXZlX3JpbmcobWFwKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQg
cHZjYWxsc19mcm9udF9mcmVlX21hcChzdHJ1Y3QgcHZjYWxsc19iZWRhdGEgKmJlZGF0YSwN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNvY2tf
bWFwcGluZyAqbWFwKQ0KPj4gK3sNCj4+ICvCoMKgwqAgcHZjYWxsc19mcm9udF9kZXN0cm95
X2FjdGl2ZShiZWRhdGEsIG1hcCk7DQo+PiDCoMKgwqDCoMKgIGtmcmVlKG1hcCk7DQo+PiDC
oCB9DQo+PiBAQCAtNDMzLDE5ICs0NDIsMTggQEAgaW50IHB2Y2FsbHNfZnJvbnRfY29ubmVj
dChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QgDQo+PiBzb2NrYWRkciAqYWRkciwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBwdmNhbGxzX2V4aXRfc29jayhzb2NrKTsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gwqDCoMKgwqDCoCB9DQo+PiAtDQo+PiAt
wqDCoMKgIHNwaW5fbG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+PiAtwqDCoMKgIHJl
dCA9IGdldF9yZXF1ZXN0KGJlZGF0YSwgJnJlcV9pZCk7DQo+PiArwqDCoMKgIHJldCA9IGNy
ZWF0ZV9hY3RpdmUobWFwLCAmZXZ0Y2huKTsNCj4+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDAp
IHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmYmVkYXRhLT5zb2NrZXRfbG9j
ayk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZnJlZV9hY3RpdmVfcmluZyhtYXApOw0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHB2Y2FsbHNfZXhpdF9zb2NrKHNvY2spOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAg
cmV0ID0gY3JlYXRlX2FjdGl2ZShtYXAsICZldnRjaG4pOw0KPj4gKw0KPj4gK8KgwqDCoCBz
cGluX2xvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPj4gK8KgwqDCoCByZXQgPSBnZXRf
cmVxdWVzdChiZWRhdGEsICZyZXFfaWQpOw0KPj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkg
ew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZiZWRhdGEtPnNvY2tldF9s
b2NrKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBmcmVlX2FjdGl2ZV9yaW5nKG1hcCk7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgcHZjYWxsc19mcm9udF9kZXN0cm95X2FjdGl2ZShOVUxMLCBtYXAp
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHB2Y2FsbHNfZXhpdF9zb2NrKHNvY2spOw0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IEBA
IC04MjEsMjggKzgyOSwyOCBAQCBpbnQgcHZjYWxsc19mcm9udF9hY2NlcHQoc3RydWN0IHNv
Y2tldCAqc29jaywgc3RydWN0IA0KPj4gc29ja2V0ICpuZXdzb2NrLCBpbnQgZmxhZ3MpDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHZjYWxsc19leGl0X3NvY2soc29jayk7DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gLcKgwqDC
oCBzcGluX2xvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPj4gLcKgwqDCoCByZXQgPSBn
ZXRfcmVxdWVzdChiZWRhdGEsICZyZXFfaWQpOw0KPj4gK8KgwqDCoCByZXQgPSBjcmVhdGVf
YWN0aXZlKG1hcDIsICZldnRjaG4pOw0KPj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGZyZWVfYWN0aXZlX3JpbmcobWFwMik7DQo+PiArwqDCoMKg
wqDCoMKgwqAga2ZyZWUobWFwMik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2xlYXJfYml0
KFBWQ0FMTFNfRkxBR19BQ0NFUFRfSU5GTElHSFQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKHZvaWQgKikmbWFwLT5wYXNzaXZlLmZsYWdzKTsNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBzcGluX3VubG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+IA0KPiAN
Cj4gTG9va3MgbGlrZSB3ZSBhbHNvIG5lZWQgdG8gcmVtb3ZlIHNwaW5fdW5sb2NrKCkgYWJv
dmUsIGNvcnJlY3Q/DQoNClRoYW5rcyBmb3IgY2F0Y2hpbmchDQoNCg0KSnVlcmdlbg0KDQo=

--------------KhWCnnap0ZD04wlpoW0NFLhH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------KhWCnnap0ZD04wlpoW0NFLhH--

--------------ZZ3Z0CuDQgh7Sc7u4VooHLRG--

--------------8v2meAxAYsA631pM7Yk8AcmT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQiyF4FAwAAAAAACgkQsN6d1ii/Ey9/
mgf/TGZU4d8NiAWB/fAAkjSv8TdEWj4SIWKAAK1xecKxikwhj7N8Unb1gZPjUlZCJUAw0gH1U3dq
KScRvGE+oFEh7bVMQprQFdWxhYzuj3dSogUaF61xQpdZpJMvFXU6Cf1aRx6lgyC46aUMyRZJCMNI
yNkASNOdGmAqJMPMhU0SzS7P7qHHOJd1U6B8dfv4Xfijsxxsr5wGjA4h2na21T2I0GwSlS3x9PKz
00ehNV6zJYmWkCQg7V6CtW8coi7pdBcpJUgAuqac+GnrJuNwMF3COvdd4azqqDW6RSzNPAx8FNAe
l6Uap5Zfqy8PiVYgvbJ6lW1oqD3LLywXpIMjadbSYQ==
=7MIr
-----END PGP SIGNATURE-----

--------------8v2meAxAYsA631pM7Yk8AcmT--
