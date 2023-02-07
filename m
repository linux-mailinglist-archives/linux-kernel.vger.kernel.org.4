Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0E68D573
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBGL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjBGL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:29:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430258A7E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:29:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFE4B34CCD;
        Tue,  7 Feb 2023 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675769392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CstnpObWbSH1VuzZOMyTwrZPwoXryoEC+928GT558WA=;
        b=m23qK4o8l1KemjFSGqbj0v0hWAure28dU8KoxNRsbgvOoB68lr1AVg9KAZ1IFzt2LpJ+D9
        ifm8PITf33mp1WR1miTs0kTBrUvnuucYDIuDhaY3fwQltT/fJKDk1uFPTuaWmN38tCJ9kM
        XBTerZd9WeHpCfISpvh0HPVQhAK8E0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675769392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CstnpObWbSH1VuzZOMyTwrZPwoXryoEC+928GT558WA=;
        b=VEynmn/fyhYUloqQWg4hSdpde2ILbnA1Fm6nNKMtU9oDivR0Xs5MfjF//zQeJ9VQxenJbG
        qDOkiQm2WSMDn9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD05B139ED;
        Tue,  7 Feb 2023 11:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5UE/KTA24mM6PgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 07 Feb 2023 11:29:52 +0000
Message-ID: <77be28c1-52ff-87c8-b7f7-f99273d48267@suse.de>
Date:   Tue, 7 Feb 2023 12:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230205125124.2260-1-lina@asahilina.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rdru5Yj00h0D36L3aQGi8PxT"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rdru5Yj00h0D36L3aQGi8PxT
Content-Type: multipart/mixed; boundary="------------z0J1c34GJttYkTYx2Hf0Qi2v";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Asahi Lina <lina@asahilina.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, asahi@lists.linux.dev,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Message-ID: <77be28c1-52ff-87c8-b7f7-f99273d48267@suse.de>
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
References: <20230205125124.2260-1-lina@asahilina.net>
In-Reply-To: <20230205125124.2260-1-lina@asahilina.net>

--------------z0J1c34GJttYkTYx2Hf0Qi2v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMDIuMjMgdW0gMTM6NTEgc2NocmllYiBBc2FoaSBMaW5hOg0KPiBPdGhl
ciBmdW5jdGlvbnMgdG91Y2hpbmcgc2htZW0tPnNndCB0YWtlIHRoZSBwYWdlcyBsb2NrLCBz
byBkbyB0aGF0IGhlcmUNCg0KUmVhbGx5PyBJIHdhcyBqdXN0IGxvY2tpbmcgYXQgdGhlIExp
bWEgZHJpdmVyIGFuZCBpdCBhcHBhcmVudGx5IGFjY2VzcyANCnNndCB3aXRob3V0IGxvY2tp
bmcgaW4gWzFdLiBOb3QgdGhhdCBJIGRpc2FncmVlIHdpdGggdGhlIHBhdGNoIGluIGdlbmVy
YWwuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNClsxXSANCmh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2xpbWEvbGlt
YV9nZW0uYyNMMjENCg0KPiB0b28uIGRybV9nZW1fc2htZW1fZ2V0X3BhZ2VzKCkgJiBjbyB0
YWtlIHRoZSBzYW1lIGxvY2ssIHNvIG1vdmUgdG8gdGhlDQo+IF9sb2NrZWQoKSB2YXJpYW50
cyB0byBhdm9pZCByZWN1cnNpdmUgbG9ja2luZy4NCj4gDQo+IERpc2NvdmVyZWQgd2hpbGUg
YXVkaXRpbmcgbG9ja2luZyB0byB3cml0ZSB0aGUgUnVzdCBhYnN0cmFjdGlvbnMuDQo+IA0K
PiBGaXhlczogMjE5NGE2M2E4MThkICgiZHJtOiBBZGQgbGlicmFyeSBmb3Igc2htZW0gYmFj
a2VkIEdFTSBvYmplY3RzIikNCj4gRml4ZXM6IDRmYTNkNjZmMTMyYiAoImRybS9zaG1lbTog
RG8gZG1hX3VubWFwX3NnIGJlZm9yZSBwdXJnaW5nIHBhZ2VzIikNCj4gU2lnbmVkLW9mZi1i
eTogQXNhaGkgTGluYSA8bGluYUBhc2FoaWxpbmEubmV0Pg0KPiAtLS0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYyB8IDU0ICsrKysrKysrKysrKysrKyst
LS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDIwIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2Vt
X3NobWVtX2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVy
LmMNCj4gaW5kZXggYjYwMmNkNzJhMTIwLi4yYzU1OWIzMTBjYWQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jDQo+IEBAIC02ODEsMjMgKzY4MSw3
IEBAIHN0cnVjdCBzZ190YWJsZSAqZHJtX2dlbV9zaG1lbV9nZXRfc2dfdGFibGUoc3RydWN0
IGRybV9nZW1fc2htZW1fb2JqZWN0ICpzaG1lbSkNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJP
TF9HUEwoZHJtX2dlbV9zaG1lbV9nZXRfc2dfdGFibGUpOw0KPiAgIA0KPiAtLyoqDQo+IC0g
KiBkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19zZ3QgLSBQaW4gcGFnZXMsIGRtYSBtYXAgdGhl
bSwgYW5kIHJldHVybiBhDQo+IC0gKgkJCQkgc2NhdHRlci9nYXRoZXIgdGFibGUgZm9yIGEg
c2htZW0gR0VNIG9iamVjdC4NCj4gLSAqIEBzaG1lbTogc2htZW0gR0VNIG9iamVjdA0KPiAt
ICoNCj4gLSAqIFRoaXMgZnVuY3Rpb24gcmV0dXJucyBhIHNjYXR0ZXIvZ2F0aGVyIHRhYmxl
IHN1aXRhYmxlIGZvciBkcml2ZXIgdXNhZ2UuIElmDQo+IC0gKiB0aGUgc2cgdGFibGUgZG9l
c24ndCBleGlzdCwgdGhlIHBhZ2VzIGFyZSBwaW5uZWQsIGRtYS1tYXBwZWQsIGFuZCBhIHNn
DQo+IC0gKiB0YWJsZSBjcmVhdGVkLg0KPiAtICoNCj4gLSAqIFRoaXMgaXMgdGhlIG1haW4g
ZnVuY3Rpb24gZm9yIGRyaXZlcnMgdG8gZ2V0IGF0IGJhY2tpbmcgc3RvcmFnZSwgYW5kIGl0
IGhpZGVzDQo+IC0gKiBhbmQgZGlmZmVyZW5jZSBiZXR3ZWVuIGRtYS1idWYgaW1wb3J0ZWQg
YW5kIG5hdGl2ZWx5IGFsbG9jYXRlZCBvYmplY3RzLg0KPiAtICogZHJtX2dlbV9zaG1lbV9n
ZXRfc2dfdGFibGUoKSBzaG91bGQgbm90IGJlIGRpcmVjdGx5IGNhbGxlZCBieSBkcml2ZXJz
Lg0KPiAtICoNCj4gLSAqIFJldHVybnM6DQo+IC0gKiBBIHBvaW50ZXIgdG8gdGhlIHNjYXR0
ZXIvZ2F0aGVyIHRhYmxlIG9mIHBpbm5lZCBwYWdlcyBvciBlcnJubyBvbiBmYWlsdXJlLg0K
PiAtICovDQo+IC1zdHJ1Y3Qgc2dfdGFibGUgKmRybV9nZW1fc2htZW1fZ2V0X3BhZ2VzX3Nn
dChzdHJ1Y3QgZHJtX2dlbV9zaG1lbV9vYmplY3QgKnNobWVtKQ0KPiArc3RhdGljIHN0cnVj
dCBzZ190YWJsZSAqZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0X2xvY2tlZChzdHJ1Y3Qg
ZHJtX2dlbV9zaG1lbV9vYmplY3QgKnNobWVtKQ0KPiAgIHsNCj4gICAJc3RydWN0IGRybV9n
ZW1fb2JqZWN0ICpvYmogPSAmc2htZW0tPmJhc2U7DQo+ICAgCWludCByZXQ7DQo+IEBAIC03
MDgsNyArNjkyLDcgQEAgc3RydWN0IHNnX3RhYmxlICpkcm1fZ2VtX3NobWVtX2dldF9wYWdl
c19zZ3Qoc3RydWN0IGRybV9nZW1fc2htZW1fb2JqZWN0ICpzaG1lbSkNCj4gICANCj4gICAJ
V0FSTl9PTihvYmotPmltcG9ydF9hdHRhY2gpOw0KPiAgIA0KPiAtCXJldCA9IGRybV9nZW1f
c2htZW1fZ2V0X3BhZ2VzKHNobWVtKTsNCj4gKwlyZXQgPSBkcm1fZ2VtX3NobWVtX2dldF9w
YWdlc19sb2NrZWQoc2htZW0pOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJcmV0dXJuIEVSUl9Q
VFIocmV0KTsNCj4gICANCj4gQEAgLTczMCwxMCArNzE0LDQwIEBAIHN0cnVjdCBzZ190YWJs
ZSAqZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0KHN0cnVjdCBkcm1fZ2VtX3NobWVtX29i
amVjdCAqc2htZW0pDQo+ICAgCXNnX2ZyZWVfdGFibGUoc2d0KTsNCj4gICAJa2ZyZWUoc2d0
KTsNCj4gICBlcnJfcHV0X3BhZ2VzOg0KPiAtCWRybV9nZW1fc2htZW1fcHV0X3BhZ2VzKHNo
bWVtKTsNCj4gKwlkcm1fZ2VtX3NobWVtX3B1dF9wYWdlc19sb2NrZWQoc2htZW0pOw0KPiAg
IAlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiAgIH0NCj4gLUVYUE9SVF9TWU1CT0xfR1BMKGRy
bV9nZW1fc2htZW1fZ2V0X3BhZ2VzX3NndCk7DQo+ICsNCj4gKy8qKg0KPiArICogZHJtX2dl
bV9zaG1lbV9nZXRfcGFnZXNfc2d0IC0gUGluIHBhZ2VzLCBkbWEgbWFwIHRoZW0sIGFuZCBy
ZXR1cm4gYQ0KPiArICoJCQkJIHNjYXR0ZXIvZ2F0aGVyIHRhYmxlIGZvciBhIHNobWVtIEdF
TSBvYmplY3QuDQo+ICsgKiBAc2htZW06IHNobWVtIEdFTSBvYmplY3QNCj4gKyAqDQo+ICsg
KiBUaGlzIGZ1bmN0aW9uIHJldHVybnMgYSBzY2F0dGVyL2dhdGhlciB0YWJsZSBzdWl0YWJs
ZSBmb3IgZHJpdmVyIHVzYWdlLiBJZg0KPiArICogdGhlIHNnIHRhYmxlIGRvZXNuJ3QgZXhp
c3QsIHRoZSBwYWdlcyBhcmUgcGlubmVkLCBkbWEtbWFwcGVkLCBhbmQgYSBzZw0KPiArICog
dGFibGUgY3JlYXRlZC4NCj4gKyAqDQo+ICsgKiBUaGlzIGlzIHRoZSBtYWluIGZ1bmN0aW9u
IGZvciBkcml2ZXJzIHRvIGdldCBhdCBiYWNraW5nIHN0b3JhZ2UsIGFuZCBpdCBoaWRlcw0K
PiArICogYW5kIGRpZmZlcmVuY2UgYmV0d2VlbiBkbWEtYnVmIGltcG9ydGVkIGFuZCBuYXRp
dmVseSBhbGxvY2F0ZWQgb2JqZWN0cy4NCj4gKyAqIGRybV9nZW1fc2htZW1fZ2V0X3NnX3Rh
YmxlKCkgc2hvdWxkIG5vdCBiZSBkaXJlY3RseSBjYWxsZWQgYnkgZHJpdmVycy4NCj4gKyAq
DQo+ICsgKiBSZXR1cm5zOg0KPiArICogQSBwb2ludGVyIHRvIHRoZSBzY2F0dGVyL2dhdGhl
ciB0YWJsZSBvZiBwaW5uZWQgcGFnZXMgb3IgZXJybm8gb24gZmFpbHVyZS4NCj4gKyAqLw0K
PiArc3RydWN0IHNnX3RhYmxlICpkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19zZ3Qoc3RydWN0
IGRybV9nZW1fc2htZW1fb2JqZWN0ICpzaG1lbSkNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiAr
CXN0cnVjdCBzZ190YWJsZSAqc2d0Ow0KPiArDQo+ICsJcmV0ID0gbXV0ZXhfbG9ja19pbnRl
cnJ1cHRpYmxlKCZzaG1lbS0+cGFnZXNfbG9jayk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0
dXJuIEVSUl9QVFIocmV0KTsNCj4gKwlzZ3QgPSBkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19z
Z3RfbG9ja2VkKHNobWVtKTsNCj4gKwltdXRleF91bmxvY2soJnNobWVtLT5wYWdlc19sb2Nr
KTsNCj4gKw0KPiArCXJldHVybiBzZ3Q7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGRybV9n
ZW1fc2htZW1fZ2V0X3BhZ2VzX3NndCk7DQo+ICAgDQo+ICAgLyoqDQo+ICAgICogZHJtX2dl
bV9zaG1lbV9wcmltZV9pbXBvcnRfc2dfdGFibGUgLSBQcm9kdWNlIGEgc2htZW0gR0VNIG9i
amVjdCBmcm9tDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBE
ZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVs
ZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xy
bmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------z0J1c34GJttYkTYx2Hf0Qi2v--

--------------rdru5Yj00h0D36L3aQGi8PxT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPiNjAFAwAAAAAACgkQlh/E3EQov+AY
qxAAzKurG9MXQXR5nLjC0RAKxoLyINYmrQOU++KMXUZj7SeUi0HRs5AmtPddf6DWOp06FvKDtlSS
7m4vvMPrJXujERWuQgc9zvlAW3Nd9DbNpbCYrkYNFvaUlIgcD527swu5cv61J107c8lY1p5c6Ny/
PDvZIvp6IPVcLN4O82eiF7V43jwkCoAIsk3vIIy7+bTStERH1vPYFrcLsBkRt3M7XjStDzyY41cM
aA/A+0d1YNfd7LLnxdcFN5zOdCNK1v3pHOCvjZNE1QFzA3nWqV6sRHx+6R8Gv8/yawjoaq6l59R5
/KsBbdZYwfh26dknN9SXEpHDX9T42Z32BL6knE7pcI4jQGRLaSv2VaBpzsH3OrujeZuNZvRxvhVu
XPqrpZinbNanpQJMmIoOTXpo40OpaEvmyaZ6W0c+qpJ0ScDxFSXqbRKH80YO+aC5FxXzaK9bgEYJ
Bb4AUXRMncj+AmYnGPSrZtXPs2RG+9nFAHtu1kxr7VBs9ofe7IF2T/y06GnSnjXgHlu+0+rXzBgi
s2/GWXoc89pXva/hfBbbpZIL/J11XK3XVMFN4sEj54fF4kPmoIa4WQLChcHMmyTZ89PsfgQCHSqV
JDgr6RRtal8GUyDCStGgwi/mSgulO3yfhFdDYpkJTEbBjHXiT2iAcMrKC4ojhOh+QTKFmTtOjO3y
QDQ=
=Ab7O
-----END PGP SIGNATURE-----

--------------rdru5Yj00h0D36L3aQGi8PxT--
