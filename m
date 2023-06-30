Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13297743AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjF3LTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjF3LTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:19:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAE3F5;
        Fri, 30 Jun 2023 04:19:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF40B2199D;
        Fri, 30 Jun 2023 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688123945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1Gx6mFpSOKHxssrIhyp5t0rgZJ0EW8z5+rWVJJ4tF8=;
        b=nXG8KMUx12JkAYsBGWH9UnFT0WzWJP+XU0wM5+QladevXK+ls0oqbut/x2VIzCDFZfAp1v
        xm9dACmA2TsZmI86h++TJ7keMJTi9U9xeA5uwRFZtprPgY+DHhr9PDZDB3Y8dVbzVgu+4b
        TRdEPYcR05EOMV4W+Zcd7VS4wtpio10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688123945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1Gx6mFpSOKHxssrIhyp5t0rgZJ0EW8z5+rWVJJ4tF8=;
        b=06rHMPH+2HgtrU/ihXPVIwOcBahhR/hruY5Zv5Ni5z+aGfr8lM8nU5SjhNy58KEYTxGE15
        AG5OLM8u+S+V+/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82973138F8;
        Fri, 30 Jun 2023 11:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RubfHim6nmTLJAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 30 Jun 2023 11:19:05 +0000
Message-ID: <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
Date:   Fri, 30 Jun 2023 13:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
References: <20230629225113.297512-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230629225113.297512-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xeFqM8lRJxgTubYUJlsMpGP3"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xeFqM8lRJxgTubYUJlsMpGP3
Content-Type: multipart/mixed; boundary="------------J4USewP0j2Cr1AH77YTCDkXf";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Airlie <airlied@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, x86@kernel.org
Message-ID: <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
References: <20230629225113.297512-1-javierm@redhat.com>
In-Reply-To: <20230629225113.297512-1-javierm@redhat.com>

--------------J4USewP0j2Cr1AH77YTCDkXf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmF2aWVyDQoNCkFtIDMwLjA2LjIzIHVtIDAwOjUxIHNjaHJpZWIgSmF2aWVyIE1hcnRp
bmV6IENhbmlsbGFzOg0KPiBUaGlzIHBhdGNoIHNlcmllcyBzcGxpdHMgdGhlIGZiZGV2IGNv
cmUgc3VwcG9ydCBpbiB0d28gZGlmZmVyZW50IEtjb25maWcNCj4gc3ltYm9sczogRkIgYW5k
IEZCX0NPUkUuIFRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIGlzIHRvIGFsbG93IENPTkZJR19G
QiB0bw0KPiBiZSBkaXNhYmxlZCwgd2hpbGUgc3RpbGwgaGF2aW5nIHRoZSB0aGUgY29yZSBm
YmRldiBzdXBwb3J0IG5lZWRlZCBmb3IgdGhlDQo+IENPTkZJR19EUk1fRkJERVZfRU1VTEFU
SU9OIHRvIGJlIGVuYWJsZWQuIFRoZSBtb3RpdmF0aW9uIGlzIGF1dG9tYXRpY2FsbHkNCj4g
ZGlzYWJsaW5nIGFsbCBmYmRldiBkcml2ZXJzIGluc3RlYWQgb2YgaGF2aW5nIHRvIGJlIGRp
c2FibGVkIGluZGl2aWR1YWxseS4NCj4gDQo+IFRoZSByZWFzb24gZm9yIGRvaW5nIHRoaXMg
aXMgdGhhdCBub3cgd2l0aCBzaW1wbGVkcm0sIHRoZXJlJ3Mgbm8gbmVlZCBmb3INCj4gdGhl
IGxlZ2FjeSBmYmRldiAoZS5nOiBlZmlmYiBvciB2ZXNhZmIpIGRyaXZlcnMgYW55bW9yZSBh
bmQgbWFueSBkaXN0cm9zDQo+IG5vdyBkaXNhYmxlIHRoZW0uIEJ1dCBpdCB3b3VsZCBzaW1w
bGlmeSB0aGUgY29uZmlnIGEgbG90IGZvIGhhdmUgYSBzaW5nbGUNCj4gS2NvbmZpZyBzeW1i
b2wgdG8gZGlzYWJsZSBhbGwgZmJkZXYgZHJpdmVycy4NCg0KSSBzdGlsbCBkb24ndCBnZXQg
dGhlIHBvaW50IG9mIHRoaXMgY2hhbmdlLiBXZSd2ZSBkaXNhYmxlZCB0aGUgZmJkZXYgDQpk
cml2ZXJzIG9uY2UuIEFuZCB0aGV5IGFyZSBvZmYgbm93IGFuZCByZW1haW4gb2ZmLg0KDQpU
aGUgcGF0Y2hzZXQgbm93IGludHJvZHVjZXMgRkJfQ09SRSwgd2hpY2gganVzdCBhZGRzIG1v
cmUgb3B0aW9ucy4gQnV0IA0KeW91J3JlIG5vdCByZWR1Y2luZyB0aGUgY29kZSBvciBjb21w
aWxlIHRpbWUgb3IgYW55IHRoaW5nIHNpbWlsYXIuDQoNCkknZCBsaWtlIHRvIHN1Z2dlc3Qg
YSBjaGFuZ2UgdG8gdGhlc2UgcGF0Y2hlczogcmF0aGVyIHRoZW4gbWFraW5nIEZCIGFuZCAN
CkRSTV9GQkRFVl9FTVVMQVRJT04gZGVwZW5kIG9uIEZCX0NPUkUsIG1ha2UgdGhlbSBzZWxl
Y3QgRkJfQ09SRS4gVGhhdCANCndpbGwgYWxsb3cgdGhlIERSTSBzdWJzeXN0ZW0gdG8gZW5h
YmxlIGZyYW1lYnVmZmVyIGVtdWxhdGlvbiANCmluZGVwZW5kZW50bHkgZnJvbSBmcmFtZWJ1
ZmZlciBkZXZpY2VzLiBJZiBlaXRoZXIgaGFzIGJlZW4gc2V0LCB0aGUgDQpmYmRldiBjb3Jl
IHdpbGwgYmUgc2VsZWN0ZWQuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IEkn
dmUgYnVpbGQgdGVzdGVkIHdpdGggcG9zc2libGUgY29tYmluYXRpb25zIG9mIENPTkZJR19G
QiwgQ09ORklHX0ZCX0NPUkUsDQo+IENPTkZJR19EUk1fRkJERVZfRU1VTEFUSU9OIGFuZCBD
T05GSUdfRkJfREVWSUNFIHN5bWJvbHMgc2V0IHRvICd5JyBvciAnbicuDQo+IA0KPiBQYXRj
aCAxLzIgbWFrZXMgdGhlIENPTkZJR19GQiBzcGxpdCB0aGF0IGlzIG1lbnRpb25lZCBhYm92
ZSBhbmQgcGF0Y2ggMi8yDQo+IG1ha2VzIERSTSBmYmRldiBlbXVsYXRpb24gZGVwZW5kIG9u
IHRoZSBuZXcgRkJfQ09SRSBzeW1ib2wgaW5zdGVhZCBvZiBGQi4NCj4gDQo+IA0KPiBKYXZp
ZXIgTWFydGluZXogQ2FuaWxsYXMgKDIpOg0KPiAgICBmYmRldjogU3BsaXQgZnJhbWUgYnVm
ZmVyIHN1cHBvcnQgaW4gRkIgYW5kIEZCX0NPUkUgc3ltYm9scw0KPiAgICBkcm06IE1ha2Ug
ZmJkZXYgZW11bGF0aW9uIGRlcGVuZCBvbiBGQl9DT1JFIGluc3RlYWQgb2YgRkINCj4gDQo+
ICAgYXJjaC94ODYvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBhcmNo
L3g4Ni92aWRlby9NYWtlZmlsZSAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9LY29uZmlnICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy92aWRlby9jb25z
b2xlL0tjb25maWcgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25m
aWcgICAgICAgfCA2MiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgZHJp
dmVycy92aWRlby9mYmRldi9jb3JlL01ha2VmaWxlIHwgMTQgKysrLS0tLQ0KPiAgIDYgZmls
ZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQo+IA0KDQot
LSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0Niwg
OTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMs
IEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJu
YmVyZykNCg==

--------------J4USewP0j2Cr1AH77YTCDkXf--

--------------xeFqM8lRJxgTubYUJlsMpGP3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSeuigFAwAAAAAACgkQlh/E3EQov+An
3hAArNuE3n0Tcr7i/lMsh+KwCwHo2DeNcEtR22lsj1wK+8EeBWNn01XjsmmrWY3pBzM8DBGNF56g
mdzrfEqlZCt3JfUvWT9t0YdW0a0mQ0ByWwSGKfi/nLlPEThLYc7+wQwGP7lS5PgDEgN/SF7gnFWO
BcqcwtSsOvprwnEX/y1UhFQV9SFsLYO5oMDJgKrlWt2Ms+uFpp+re9RUdkzfGS6nj264slQvKEZN
oVRI7j8y8I7pGJWFhwF7xym8uthbNgTz2PlQevPDUndr2LP1VWitxMQduou235KqFyYF5/9omPSH
eLBJGvT73/Oy9Z0LRDuWUoss3lePhXKJEBy31O5veHvSMN5JKomQBH5NClBoo4PclvdVZWsqLPBv
n5Vn552D19S/lzx9MG2LNj9FOBAm5FJjw7Q3nv2DyT4lUsMPjcyUzQCRnA6r1k7LB56pbAoSvBCo
P6TECCVWR3RIU8hmjNXd1fwnssgx0YmM+c1dL2V8CyIpGZSYQRoMX2Oaq5h/oo6RJ7Q/7l+M6Jct
DOLWiHVpeE69RBdKEOS6DZkpM2tgN/EoyaYuSXvbAX9A/TyZX8r3axFZolXSb21KOZdUB4/m0FFE
EiumvBfrhPLrS66saqEgJVZz/tWz+UcFXZ63QT1taXteGC7J41vD/KM7Hjv/XU4DJ4CGy59k22CH
2KU=
=z/0A
-----END PGP SIGNATURE-----

--------------xeFqM8lRJxgTubYUJlsMpGP3--
