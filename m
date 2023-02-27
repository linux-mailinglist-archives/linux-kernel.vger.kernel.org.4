Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA26A3BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjB0IEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0IEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:04:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF71285F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:04:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72843219E9;
        Mon, 27 Feb 2023 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677485091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SL3hNZ1PhZNtjYXOI8bgqaxWiXRExCffqLVe0/4Pqxc=;
        b=EYiafKnwKunGFHSNwIkvCEr09Duztld4s1w87kMdF5qD/Hqyr7XTBJVExnN6SQLs9YIZyl
        +r7WOW9WJsVg5gPYp3PFJmChFjD5CHfs8RAfQMBbgHhuUAtm9Mv9GUbvtQllVw8kxZ+x3y
        GqXQEMxWLL+z3malgFwl4551ntwSVqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677485091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SL3hNZ1PhZNtjYXOI8bgqaxWiXRExCffqLVe0/4Pqxc=;
        b=x41VCA+g2/tVofUbCNcy+xuP++d/1K3VGA8wxe43Bh2gaVxoXRMspff0iEGvvMwvOemLw1
        VROaZpp2FxizeoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ECF813A43;
        Mon, 27 Feb 2023 08:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eG9ADiNk/GPGKwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 27 Feb 2023 08:04:51 +0000
Message-ID: <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
Date:   Mon, 27 Feb 2023 09:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        asahi@lists.linux.dev
References: <20230205125124.2260-1-lina@asahilina.net>
 <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
 <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
 <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J1Lb5TSRvy34253xYuFZL0Nn"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------J1Lb5TSRvy34253xYuFZL0Nn
Content-Type: multipart/mixed; boundary="------------v7YMrJxP0MzJrghKXAGDAzMQ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Asahi Lina <lina@asahilina.net>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 asahi@lists.linux.dev
Message-ID: <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
References: <20230205125124.2260-1-lina@asahilina.net>
 <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
 <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
 <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
In-Reply-To: <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>

--------------v7YMrJxP0MzJrghKXAGDAzMQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjcuMDIuMjMgdW0gMDg6NTUgc2NocmllYiBBc2FoaSBMaW5hOg0KPiBPbiAy
Ny8wMi8yMDIzIDE2LjQ1LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+IEhpDQo+Pg0K
Pj4gQW0gMjUuMDIuMjMgdW0gMjI6NTEgc2NocmllYiBEbWl0cnkgT3NpcGVua286DQo+Pj4g
T24gMi81LzIzIDE1OjUxLCBBc2FoaSBMaW5hIHdyb3RlOg0KPj4+PiAtRVhQT1JUX1NZTUJP
TF9HUEwoZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0KTsNCj4+Pj4gK0VYUE9SVF9TWU1C
T0woZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0KTsNCj4+Pg0KPj4+IE5vdGUgaXQgd2Fz
IGEgR1BMIHN5bWJvbC4gSSBleHBlY3QgdGhhdCBhbGwgZHJtLXNobWVtIGV4cG9ydHMgc2hv
dWxkIGJlIEdQTC4NCj4+DQo+PiBSaWdodC4gSSBkaWRuJ3Qgbm90aWNlIHRoYXQgY2hhbmdl
LCBidXQgaXQncyBwcm9iYWJseSBub3QgYWxsb3dlZC4gVGhpcw0KPj4gbmVlZHMgdG8gYmUg
cmV2ZXJ0ZWQgdG8gYSBHUEwgZXhwb3J0DQo+IA0KPiBJJ20gc29ycnksIHRoaXMgd2FzIG5v
dCBpbnRlbnRpb25hbCEgSSB0aGluayBJIHJlbW92ZWQgYW5kIHJlLWFkZGVkIHRoZQ0KPiBl
eHBvcnQgYXMgcGFydCBvZiBtYWtpbmcgdGhlIHdyYXBwZXIgYW5kIGRpZG4ndCBub3RpY2Ug
aXQgdXNlZCB0byBiZSBfR1BMLi4uDQo+IA0KPiBEbyB5b3Ugd2FudCBtZSB0byBzZW5kIGEg
cGF0Y2ggdG8gYWRkIGl0IGJhY2s/DQoNClllcywgcGxlYXNlIGRvLiBUaGUgRml4ZXMgdGFn
IGlzDQoNCiAgIEZpeGVzOiBkZGRkZWRhYTBkYjkgKCJkcm0vc2htZW0taGVscGVyOiBGaXgg
bG9ja2luZyBmb3IgDQpkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19zZ3QoKSIpDQoNClRoaXMg
Y29tbWl0IGlzIGluIGRybS1taXNjLW5leHQtZml4ZXMuIEJ1dCB0aGUgYnJhbmNoIGlzIGNs
b3NlZCBhbHJlYWR5IA0KYXMgd2UncmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgbWVyZ2Ugd2lu
ZG93LiBJIHRoaW5rIGl0J3MgYmVzdCB0byBtZXJnZSANCnRoZSBmaXggdGhyb3VnaCBkcm0t
bWlzYy1maXhlcyBhZnRlciB0aGUgLXJjMSBocyBiZWVuIHRhZ2dlZC4NCg0KQmVzdCByZWdh
cmRzDQpUaG9tYXMNCg0KPiANCj4gfn4gTGluYQ0KDQotLSANClRob21hcyBaaW1tZXJtYW5u
DQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
ZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0K
KEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rl
dg0K

--------------v7YMrJxP0MzJrghKXAGDAzMQ--

--------------J1Lb5TSRvy34253xYuFZL0Nn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmP8ZCIFAwAAAAAACgkQlh/E3EQov+AT
sBAAnwuKmArPei56rq2mShl4mx6s6vOVNxdFN3Clr/wzgd0Pjb0VVME0daAlpTmr9IY6hneL+Cqt
87A7r05pYu6G+yqghRf7d40ZVeioYhiK1allBzmZR0xJlsD7FKKzRm8dI4LJF2OtEj+WPvy4d4Ny
WXP0P42nWxb+RPS5In+UIDrM7+5XBaJbKWkzU8mhKL1b0Qo8AZRD6zTdHjivkfPmUO8Hk00WFm+X
f2ijOvzBHMsW77qtxFgASXnNiXQr9qgb+i6SObYBcPihPkMxAQhBVMgwVWh9OERPfs80ixz2Fq1B
QpcoCLFLHewopdRbdpGgKhhXyt9W4pWJAGb/Y+VN3c6CgZdn1E2p9+w7iq3XYiLb7MmISQzN35bU
d/RVBnMC7raqkq84ei0f6u15bts4mTFVCrR/28WMAITDuWV/Zm8yOhquojig4I82SPB7SUUcXoXR
3rfmbKJ6eNbb8oO7BQ+P9cI53ZTxY3/MfyzyXikxl8a+xr5aDKJC52Fk8bsQRKu+x40hbuX8pNzw
ZD/N/EGrAKTfHaLgMcNsictAjh+730irHOqvGwbg5IWdqMRpyGb01VThfwE+vCbWUT0GYj7rWGOg
55zFXpvrshMf7UTJqpr8dEOqFmL1aR1pxFxgC66SbGkVebEXwFo4A8fSGMUf+IV81tW/kHYDxt6E
emU=
=pxG9
-----END PGP SIGNATURE-----

--------------J1Lb5TSRvy34253xYuFZL0Nn--
