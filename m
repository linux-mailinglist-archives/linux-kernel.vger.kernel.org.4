Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C945EA868
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiIZOaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiIZO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:29:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CC6610E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:42:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA736218EF;
        Mon, 26 Sep 2022 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664191073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRZ2THjGw43K91frVQ0cavLJnfTwAj7TQu8exTP2YGQ=;
        b=RWkpCHTHCIzWIBxoSgaw6qYqGGcxZ+hmp1mWx6qO0BI90JK5pm01vMJ3XVX2VjFeL0gMjN
        8w1puqwBcCstmcEqtZNG8EnxDX8ZNBufuDq9UdsjPmj6EMZ9HxDdy2CfR/4cpaA6zcPojd
        X0NX00sizPKxJso+ziqll+02QMwdZTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664191073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRZ2THjGw43K91frVQ0cavLJnfTwAj7TQu8exTP2YGQ=;
        b=eXPjOygx/KWE7XUjMCwk7MrNGcJLOBKZxPlXQ/Jvo5S+/38MBAL3J3Yy/+kF548YhBlIhk
        JJh0es3dPtW7TIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F81313486;
        Mon, 26 Sep 2022 11:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M7jUEWGKMWO+LQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 26 Sep 2022 11:17:53 +0000
Message-ID: <c714b53d-8e18-9105-9e27-8b783f246082@suse.de>
Date:   Mon, 26 Sep 2022 13:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 10/33] drm/modes: Add a function to generate analog
 display modes
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Ben Skeggs <bskeggs@redhat.com>,
        linux-sunxi@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-f733a0ed9f90@cerno.tech>
 <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
 <20220926101716.urehomr2lzv5pqln@houat>
 <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ugjNnt50fIMLVu6urhLXoAKy"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ugjNnt50fIMLVu6urhLXoAKy
Content-Type: multipart/mixed; boundary="------------3WYvgZonJe2p1UqhQXWVMRE6";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Maxime Ripard <maxime@cerno.tech>
Cc: Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Phil Elwell <phil@raspberrypi.com>, Emma Anholt <emma@anholt.net>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Ben Skeggs <bskeggs@redhat.com>, linux-sunxi@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Dom Cobley <dom@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 linux-kernel@vger.kernel.org,
 Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <c714b53d-8e18-9105-9e27-8b783f246082@suse.de>
Subject: Re: [PATCH v2 10/33] drm/modes: Add a function to generate analog
 display modes
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-f733a0ed9f90@cerno.tech>
 <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
 <20220926101716.urehomr2lzv5pqln@houat>
 <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>
In-Reply-To: <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>

--------------3WYvgZonJe2p1UqhQXWVMRE6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjYuMDkuMjIgdW0gMTI6MzQgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46
DQo+IEhpIE1heGltZSwNCj4gDQo+IE9uIE1vbiwgU2VwIDI2LCAyMDIyIGF0IDEyOjE3IFBN
IE1heGltZSBSaXBhcmQgPG1heGltZUBjZXJuby50ZWNoPiB3cm90ZToNCj4+IE9uIEZyaSwg
U2VwIDIzLCAyMDIyIGF0IDExOjA1OjQ4QU0gKzAyMDAsIFRob21hcyBaaW1tZXJtYW5uIHdy
b3RlOg0KPj4+PiArICAgLyogNjMuNTU2dXMgKiAxMy41TUh6ID0gODU4IHBpeGVscyAqLw0K
Pj4+DQo+Pj4gSSBraW5kIG9mIGdldCB3aGF0IHRoZSBjb21tZW50IHdhbnRzIHRvIHRlbGwg
bWUsIGJ1dCB0aGUgdW5pdHMgZG9uJ3QgYWRkIHVwLg0KPj4NCj4+IEknbSBub3Qgc3VyZSBo
b3cgaXQgZG9lc24ndCBhZGQgdXA/DQo+Pg0KPj4gV2UgaGF2ZSBhIGZyZXF1ZW5jeSBpbiBI
eiAoZXF1aXZhbGVudCB0byBzXi0xKSBhbmQgYSBkdXJhdGlvbiBpbiBzLCBzbw0KPj4gdGhl
IHJlc3VsdCBlbmRzIHVwIHdpdGggbm8gZGltZW5zaW9uLCB3aGljaCBpcyB0byBiZSBleHBl
Y3RlZCBmb3IgYQ0KPj4gbnVtYmVyIG9mIHBlcmlvZHM/DQo+IA0KPiBUbyBtYWtlIHRoZSB1
bml0cyBhZGQgdXAsIGl0IHNob3VsZCBiZSAxMy41IE1waXhlbC9zDQo+ICh3aGljaCBpcyB3
aGF0IGEgcGl4ZWwgY2xvY2sgb2YgMTMuNSBNSHogcmVhbGx5IG1lYW5zIDstKQ0KDQpTb3J0
IG9mLiBJdCBsZWF2ZXMgdGhlIHRpbWUgdmFsdWUgYXMgYSBtYWdpYyBudW1iZXIsIHdoaWNo
IG9iZnVzY2F0ZXMgDQp3aGF0J3MgaGFwcGVuaW5nLg0KDQpUaGUgdW5pdCBmb3IgaHRvdGFs
IGlzIHBpeGVscy9zY2FubGluZSBiZWNhdXNlIGlmIHlvdSBtdWx0aXBseSBpdCB3aXRoIA0K
dGhlIG51bWJlciBvZiBzY2FubGluZXMgcGVyIGZyYW1lICh3aGljaCBpcyBpbiB2dG90YWwp
LCB5b3UgZ2V0IA0KcGl4ZWxzL2ZyYW1lLiBNdWx0aXBseWluZyB3aXRoIHRoZSBmcmFtZXMg
cGVyIHNlY29uZCByZXN1bHRzIGluIHRoZSANCnBpeGVsIGNsb2NrIGluIHBpeGVscy9zZWNv
bmQuDQoNClRoYXQncyBhIGJpdCBtdWNoIGZvciB0aGlzIGNvbW1lbnQuIEhlbmNlLCBJIHN1
Z2dlc3RlZCB0byByZW1vdmUgdGhlc2UgDQpjb21tZW50cyBlbnRpcmVseSBhbmQgZG9jdW1l
bnQgdGhlIHJlbGF0aW9uIGFtb25nIHRoZSBudW1iZXJzIGluIGEgbW9yZSANCnByb21pbmVu
dCBsb2NhdGlvbi4gVGhlIGRvY3VtZW50YXRpb24gZm9yIGRybV9kaXNwbGF5X21vZGUgd291
bGQgYmUgYSANCmdvb2QgcGxhY2UsIEkgZ3Vlc3MuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+
IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFs
ZHMNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Bl
cg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykN
Ckdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------3WYvgZonJe2p1UqhQXWVMRE6--

--------------ugjNnt50fIMLVu6urhLXoAKy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmMximAFAwAAAAAACgkQlh/E3EQov+DJ
1g//RygY42C2g9i/xd+0ILDL66FTDjnaa8D93msjwX0RgMc50KzIbRpbsiRLSPZNLMpkrIcA3uSR
N0x4eWgJrZSQWWZycl0SoM3hDsueWGj7o27kJ6dP9K8km0/CQKlF9Bz5TzQkvnihiU4tVEJ1975m
N+OU1qG+gGOf3Slcjobwou/k8aeXOBtisOaIvtx13xhp99eTp5HLoYN2q2szoF+PIdBGFJDQFugU
sxGCQlMaTTFl67ajM1oZg8tpQU7mfmL86cAzqp4azLGYVsDBMvA6Rf6hmJHTa9v6w1oRdA8wu1xQ
Z/T5rXPuWQDx65f79HtkQ7UJ06sTSlNFbrjbuuuo5/DMW9bXg0Amlz6tCra3bdg0xcPZauA26rAS
/QTU3gBYzzjo0m/Uu+xe0hrK/mfHRBgNtbVeKYKWEI5OSSl6oUzonl/QVCOTf1IxUDx1yBu/aCzV
jzDoAzHpN91aIIjaiUuKdFbJqz1baeo0SZpqSW0hIhEFEGNSgWDGtSlkDdrBEpvVdLElo9hXn3Ue
EIShw8OUahXUdnh21r6NKPpv1/qjYZCn1H3AvHDNZDMnX+ALFx9pDOixXd1NUW9y3LMzj0/cLaPI
usAR4M1Q0dVG4JunLeNnzR7HrFaH6cT194xjmHpiNZEvdkXmc6V6dEkUmB+TFER1utnMweRJtLs+
YSA=
=1G2G
-----END PGP SIGNATURE-----

--------------ugjNnt50fIMLVu6urhLXoAKy--
