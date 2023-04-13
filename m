Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6816E151A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDMTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDMTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:20:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25818D;
        Thu, 13 Apr 2023 12:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CFEB1FD72;
        Thu, 13 Apr 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681413625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbqARjeHd1//MBj7hADKQRHDq0K548anuKS8lmWYJvQ=;
        b=ODC1rcTgzwvJN3TtSP4LxF/Rjyy5eu7XRg3+Rigd/b9vUNkoQIq30e+boBatcweKK+JeLD
        jYHuKHexdUCuD+KbUVzxt3YK1PZzToI08MTqSp6C+JkD3fFlS812XWqZCKUX643gu9MBXx
        Vm/htOBkqowLmDqy0k1bt0+WaZJmvDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681413625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbqARjeHd1//MBj7hADKQRHDq0K548anuKS8lmWYJvQ=;
        b=bjpxSNdmwWp52OCRH+tsTINdKfBTHDWDDi+zzeDnALsg3v7z2hndjtUOEg7Noqiq/U+GeH
        7K7sLTML3Q3pzKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC6FF1390E;
        Thu, 13 Apr 2023 19:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id st7tGvhVOGTaRQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 13 Apr 2023 19:20:24 +0000
Message-ID: <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
Date:   Thu, 13 Apr 2023 21:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
 <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn>
 <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
 <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pgvBM7074Br404IT7p6s9CzS"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pgvBM7074Br404IT7p6s9CzS
Content-Type: multipart/mixed; boundary="------------tGm6EbuekSzi29quXttoaFCO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <15330273260@189.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 loongson-kernel@lists.loongnix.cn
Message-ID: <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
 <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn>
 <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
 <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
In-Reply-To: <ZDhQW6El6ztyHK4M@phenom.ffwll.local>

--------------tGm6EbuekSzi29quXttoaFCO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTMuMDQuMjMgdW0gMjA6NTYgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KWy4u
Ll0NCj4gDQo+IFRoaXMgc2hvdWxkIHN3aXRjaCB0aGUgZXhpc3RpbmcgY29kZSBvdmVyIHRv
IHVzaW5nIGRybV9mcmFtZWJ1ZmZlciBpbnN0ZWFkDQo+IG9mIGZiZGV2Og0KPiANCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYw0KPiBpbmRleCBlZjRlYjhiMTI3NjYuLjk5Y2E2
OWRkNDMyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jDQo+IEBAIC02NDcs
MjIgKzY0NywyNiBAQCBzdGF0aWMgdm9pZCBkcm1fZmJfaGVscGVyX2RhbWFnZShzdHJ1Y3Qg
ZHJtX2ZiX2hlbHBlciAqaGVscGVyLCB1MzIgeCwgdTMyIHksDQo+ICAgc3RhdGljIHZvaWQg
ZHJtX2ZiX2hlbHBlcl9tZW1vcnlfcmFuZ2VfdG9fY2xpcChzdHJ1Y3QgZmJfaW5mbyAqaW5m
bywgb2ZmX3Qgb2ZmLCBzaXplX3QgbGVuLA0KPiAgIAkJCQkJICAgICAgIHN0cnVjdCBkcm1f
cmVjdCAqY2xpcCkNCj4gICB7DQo+ICsJc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciA9
IGluZm8tPnBhcjsNCj4gKw0KPiAgIAlvZmZfdCBlbmQgPSBvZmYgKyBsZW47DQo+ICAgCXUz
MiB4MSA9IDA7DQo+ICAgCXUzMiB5MSA9IG9mZiAvIGluZm8tPmZpeC5saW5lX2xlbmd0aDsN
Cj4gLQl1MzIgeDIgPSBpbmZvLT52YXIueHJlczsNCj4gLQl1MzIgeTIgPSBESVZfUk9VTkRf
VVAoZW5kLCBpbmZvLT5maXgubGluZV9sZW5ndGgpOw0KPiArCXUzMiB4MiA9IGhlbHBlci0+
ZmItPmhlaWdodDsNCj4gKwl1bnNpZ25lZCBzdHJpZGUgPSBoZWxwZXItPmZiLT5waXRjaGVz
WzBdOw0KPiArCXUzMiB5MiA9IERJVl9ST1VORF9VUChlbmQsIHN0cmlkZSk7DQo+ICsJaW50
IGJwcCA9IGRybV9mb3JtYXRfaW5mb19icHAoaGVscGVyLT5mYi0+Zm9ybWF0LCAwKTsNCg0K
UGxlYXNlIERPTlQgZG8gdGhhdC4gVGhlIGNvZGUgaGVyZSBpcyBmYmRldiBjb2RlIGFuZCBz
aG91bGRuJ3QgYm90aGVyIA0KYWJvdXQgRFJNIGRhdGEgc3RydWN0dXJlcy4gQWN0dWFsbHks
IGl0IHNob3VsZG4ndCBiZSBoZXJlOiBhIG51bWJlciBvZiANCmZiZGV2IGRyaXZlcnMgd2l0
aCBkZWZlcnJlZCBJL08gY29udGFpbiBzaW1pbGFyIGNvZGUgYW5kIHRoZSBmYmRldiANCm1v
ZHVsZSBzaG91bGQgcHJvdmlkZSB1cyB3aXRoIGEgaGVscGVyLiAoSSB0aGluayBJIGV2ZW4g
aGFkIHNvbWUgcGF0Y2hlcyANCnNvbWV3aGVyZS4pDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCj4gICANCj4gICAJaWYgKCh5MiAtIHkxKSA9PSAxKSB7DQo+ICAgCQkvKg0KPiAgIAkJ
ICogV2UndmUgb25seSB3cml0dGVuIHRvIGEgc2luZ2xlIHNjYW5saW5lLiBUcnkgdG8gcmVk
dWNlDQo+ICAgCQkgKiB0aGUgbnVtYmVyIG9mIGhvcml6b250YWwgcGl4ZWxzIHRoYXQgbmVl
ZCBhbiB1cGRhdGUuDQo+ICAgCQkgKi8NCj4gLQkJb2ZmX3QgYml0X29mZiA9IChvZmYgJSBp
bmZvLT5maXgubGluZV9sZW5ndGgpICogODsNCj4gLQkJb2ZmX3QgYml0X2VuZCA9IChlbmQg
JSBpbmZvLT5maXgubGluZV9sZW5ndGgpICogODsNCj4gKwkJb2ZmX3QgYml0X29mZiA9IChv
ZmYgJSBzdHJpZGUpICogODsNCj4gKwkJb2ZmX3QgYml0X2VuZCA9IChlbmQgJSBzdHJpZGUp
ICogODsNCj4gICANCj4gLQkJeDEgPSBiaXRfb2ZmIC8gaW5mby0+dmFyLmJpdHNfcGVyX3Bp
eGVsOw0KPiAtCQl4MiA9IERJVl9ST1VORF9VUChiaXRfZW5kLCBpbmZvLT52YXIuYml0c19w
ZXJfcGl4ZWwpOw0KPiArCQl4MSA9IGJpdF9vZmYgLyBicHA7DQo+ICsJCXgyID0gRElWX1JP
VU5EX1VQKGJpdF9lbmQsIGJwcCk7DQo+ICAgCX0NCj4gICANCj4gICAJZHJtX3JlY3RfaW5p
dChjbGlwLCB4MSwgeTEsIHgyIC0geDEsIHkyIC0geTEpOw0KPiANCj4+DQo+Pj4+Pj4+PiAr
ICBzY3JlZW5fc2l6ZSA9IHNpemVzLT5zdXJmYWNlX2hlaWdodCAqIGJ1ZmZlci0+ZmItPnBp
dGNoZXNbMF07DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiAgICAgICAgICAgICAgc2NyZWVuX2J1
ZmZlciA9IHZ6YWxsb2Moc2NyZWVuX3NpemUpOw0KPj4+Pj4+Pj4gICAgICAgICAgICAgIGlm
ICghc2NyZWVuX2J1ZmZlcikgew0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gLUVOT01FTTsNCj4+Pj4+Pj4gQ2hlZXJzLCBEYW5pZWwNCj4+Pj4+Pj4NCj4+Pj4+Pj4+
IC0tDQo+Pj4+Pj4+PiAyLjI1LjENCj4+Pj4+Pj4+DQo+Pj4NCj4+Pg0KPiANCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNm
w7xocmVyOiBJdm8gVG90ZXYNCg==

--------------tGm6EbuekSzi29quXttoaFCO--

--------------pgvBM7074Br404IT7p6s9CzS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ4VfcFAwAAAAAACgkQlh/E3EQov+Bo
Wg/8Cxx7Tn6g7+XPUBRkRrxSmTsA3CdibJ7iya3BC+6BOqUWTbIJhi5zU5zPqRYxKmg57WD+Zn0l
Bt1WWts73ghr4iq2LvZGkO0QdxuC/LOZdJrp2ezMcsUtjYoDN3MBNim0VytF4De/rpjk9IdxNbxN
wzCGCw/yVwoxdpc0+glRMRJQoCtoGrUsbSqdrP+kikMvxIVdHfg9+9ef5Ztty4ITnehOx1fKwPuu
JYMt/GFDuoTbvISOYxcMbZIJpGXJpns1U2u1YduyRYEGQlGr8z2HByF/43aKD/iJaoqVYDxwjgQk
fJ6gkGaRJ6O2lkGukQLQ7WLa5csSbirg8w2itdbOAXvJ/V8PxXIZeMAWKQOYLM5K2acYNP22HJUo
f3KrG6SsS9vADSXAMzTxJvROVThlQk9kzbcN+pc+JPo4A4PsMim11aaz9Q3Atq73C4kdgXpg+vi3
fneqvTwPOyLPXKDFgcFt+A/pP5OzDbaRWAMK/diG3UlXvQJb1iGPc9zbR8EA39KMpKqDB/puBKDt
8tp4DvB7NcPP2n/su/vxlr75bH7Zo+TFiHOR1JvHVoiKu3raL1OdrWJc6kbQ5qGH7EdNH0wAzXBU
PPUNYXyo3AemU9KeiC803L0Fs+d7BCsYFVFIDijJPQoDr2ftydHCqrIxknKb/aMlsgRNVmBlNchH
ils=
=WuX9
-----END PGP SIGNATURE-----

--------------pgvBM7074Br404IT7p6s9CzS--
