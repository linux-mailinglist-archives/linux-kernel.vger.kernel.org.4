Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D21750A66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGLOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjGLOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6F19BC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:01:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29A451FDA2;
        Wed, 12 Jul 2023 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689170480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71bsqRrpI75eb4hLcpTJVpTZ3P0WLAVfHpiZmg+38eo=;
        b=uEUVFi90Py5Hdtsm6N/lmlDZNtlK546uM+woKEm3u85Vr3ElrMPZBmb09031KbAnzvPNxV
        JYjq0SImPzFTWNT0CHwXiuYttMMwP3CfQ0kShDWcoYYQXQZsJ74v9FRyr5p7apww5bfGzY
        ROiuYExibjw2QEa103cKM3sdU1Qyybc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689170480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71bsqRrpI75eb4hLcpTJVpTZ3P0WLAVfHpiZmg+38eo=;
        b=YTO/8myYCCbwuJB0eyC2OmvKLOG/YiK+yKDu+mUpp5YCy8rqUQQ8tJpFQJuKY7gJivbUx0
        zMF0ljbbeInmeCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6DDA133DD;
        Wed, 12 Jul 2023 14:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nsNYNy+yrmRiAQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 12 Jul 2023 14:01:19 +0000
Message-ID: <eed24ade-2912-7764-a006-ca2ed302273c@suse.de>
Date:   Wed, 12 Jul 2023 16:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/gem-fb-helper: Consistenly use drm_dbg_kms()
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <7c2182b365c5b0a574744a2832e0209aa1fc009e.1689169087.git.geert+renesas@glider.be>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <7c2182b365c5b0a574744a2832e0209aa1fc009e.1689169087.git.geert+renesas@glider.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wDW1QzVWh0h5ND5Ds0Le1js1"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wDW1QzVWh0h5ND5Ds0Le1js1
Content-Type: multipart/mixed; boundary="------------ZzGoxZTD7qYOewANJPcZyXr5";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <eed24ade-2912-7764-a006-ca2ed302273c@suse.de>
Subject: Re: [PATCH] drm/gem-fb-helper: Consistenly use drm_dbg_kms()
References: <7c2182b365c5b0a574744a2832e0209aa1fc009e.1689169087.git.geert+renesas@glider.be>
In-Reply-To: <7c2182b365c5b0a574744a2832e0209aa1fc009e.1689169087.git.geert+renesas@glider.be>

--------------ZzGoxZTD7qYOewANJPcZyXr5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTIuMDcuMjMgdW0gMTU6NDIgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46
DQo+IEFsbCBkZWJ1ZyBtZXNzYWdlcyBpbiBkcm1fZ2VtX2ZyYW1lYnVmZmVyX2hlbHBlci5j
IHVzZSBkcm1fZGJnX2ttcygpLA0KPiBleGNlcHQgZm9yIG9uZSwgd2hpY2ggdXNlcyBkcm1f
ZGJnKCkuDQo+IFJlcGxhY2UgdGhlIG91dGxpZXIgYnkgZHJtX2RiZ19rbXMoKSB0byByZXN0
b3JlIGNvbnNpc3RlbmN5Lg0KPiANCj4gRml4ZXM6IGM5MWFjZGEzYTM4MGJjYWYgKCJkcm0v
Z2VtOiBDaGVjayBmb3IgdmFsaWQgZm9ybWF0cyIpDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNClJldmlld2VkLWJ5
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCg0KVGhhbmtzLiBJ
SVJDIGRybV9kYmcoKSBpcyBmb3IgZHJpdmVycy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMN
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9mcmFtZWJ1ZmZlcl9oZWxw
ZXIuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9n
ZW1fZnJhbWVidWZmZXJfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9mcmFt
ZWJ1ZmZlcl9oZWxwZXIuYw0KPiBpbmRleCBiOGE2MTVhMTM4Y2Q2NzVmLi4zYmRiNmJhMzdm
ZjQyZmI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9mcmFtZWJ1
ZmZlcl9oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9mcmFtZWJ1
ZmZlcl9oZWxwZXIuYw0KPiBAQCAtMTY4LDggKzE2OCw4IEBAIGludCBkcm1fZ2VtX2ZiX2lu
aXRfd2l0aF9mdW5jcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAgIAlpZiAoZHJtX2Ry
dl91c2VzX2F0b21pY19tb2Rlc2V0KGRldikgJiYNCj4gICAJICAgICFkcm1fYW55X3BsYW5l
X2hhc19mb3JtYXQoZGV2LCBtb2RlX2NtZC0+cGl4ZWxfZm9ybWF0LA0KPiAgIAkJCQkgICAg
ICBtb2RlX2NtZC0+bW9kaWZpZXJbMF0pKSB7DQo+IC0JCWRybV9kYmcoZGV2LCAiVW5zdXBw
b3J0ZWQgcGl4ZWwgZm9ybWF0ICVwNGNjIC8gbW9kaWZpZXIgMHglbGx4XG4iLA0KPiAtCQkJ
Jm1vZGVfY21kLT5waXhlbF9mb3JtYXQsIG1vZGVfY21kLT5tb2RpZmllclswXSk7DQo+ICsJ
CWRybV9kYmdfa21zKGRldiwgIlVuc3VwcG9ydGVkIHBpeGVsIGZvcm1hdCAlcDRjYyAvIG1v
ZGlmaWVyIDB4JWxseFxuIiwNCj4gKwkJCSAgICAmbW9kZV9jbWQtPnBpeGVsX2Zvcm1hdCwg
bW9kZV9jbWQtPm1vZGlmaWVyWzBdKTsNCj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiAgIAl9
DQo+ICAgDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZl
bG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0
cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFu
ZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgw
OSAoQUcgTnVlcm5iZXJnKQ0K

--------------ZzGoxZTD7qYOewANJPcZyXr5--

--------------wDW1QzVWh0h5ND5Ds0Le1js1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSusi8FAwAAAAAACgkQlh/E3EQov+Bc
Qw//RjYJT6jmL2tAAmqxdVDMsm0tJBROkTv5bdgQOmVllBGPKX8lW+akhiipPXZsBJYdgbLMiEqE
biXfTv7LLbH6/RewWk0UCWkKlFknt8G50nmPQJGDhPO7NfpTg+cbEHZuCY5hdX81R1uIY0+CJHDs
9P9Jo0gOppGeeDZ8MblZ1NVN44HfKe38g8/5oFi347RQ7qd68af15GiHa3cCtxK/q+8TYn+g0mE+
DC/hZaQFjaj2zCaMCogKL0U3SutfNOIYIXAGphe6h8AFra0S4iS5tyBxOKrsQGfISFIMz2ihywWn
R3o504cHgmRnlIsNV0ytlegnMCah2VdbLXLlWjRl96wk/yaEUS51mJQSsZyPB6QU7NqFKF2JslPW
3HfGC2yjFxoJUrWhvsocHctDKSUVe5OyuMK3vAIUMjQgzDGRmTew2ekoBAgwctxy6lJouqul6fGZ
ieiavaaL8kkCY0c8Gyp6Scw/3AVd90NKZBl9Qf6KucuLNyzyGhJOIub7YF9+lXbocXAMy7eOMDwm
6NRcFt0i66k5sdxim+z3X+HAPAvFe3a6cjcg7FuyaesiCRD38k4vi48cJnG0ZJNm1DpiI42bj2/8
gyHqMrRWU07iymHJ8j3ZBIYnTkZ4i9F462KUk8Zfbrzhn9Q/9o4hmE8icz/J/QMbVgxEoNwf7sRb
ZL0=
=EeNu
-----END PGP SIGNATURE-----

--------------wDW1QzVWh0h5ND5Ds0Le1js1--
