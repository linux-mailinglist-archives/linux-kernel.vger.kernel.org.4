Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5820675381
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjATLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:39:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206210A8C;
        Fri, 20 Jan 2023 03:39:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BC995F8DA;
        Fri, 20 Jan 2023 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674214764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt0dzgnbNKMCQqJFKoMqQhLrtTROGS4pnSwa975FQNw=;
        b=1otWayZoonGRoX6RyzCIiPtEaC6H3mML8XGosyOiC/KfF230W2kyyDuUbX9ixT+2LQjAs5
        V4/wQDkC08oVJc8Ixei79cqYq3M65Ys8S2uexaEnyYEGy4C3LmfVef4Q6ltftheSPFMnJp
        kcFwWM6xv/osqLaUVr/RHJwYV5vZ/rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674214764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt0dzgnbNKMCQqJFKoMqQhLrtTROGS4pnSwa975FQNw=;
        b=n8AtykF3dkvfXI4eea08BB+ZhgNpP2X7tbUMNp0otkn0ETGWh9uOxA8QFN4wxzooptL/NY
        k7TZgmLlnJRcFzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B0631390C;
        Fri, 20 Jan 2023 11:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j8tXCWx9ymPNewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 20 Jan 2023 11:39:24 +0000
Message-ID: <c51c25e7-a020-77c2-47b0-1e34b433116a@suse.de>
Date:   Fri, 20 Jan 2023 12:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Erhard F." <erhard_f@mailbox.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20230119095323.4659-1-msuchanek@suse.de>
 <8a9f7ba5-37a4-0927-4ab2-d212f1b098a9@csgroup.eu>
 <57e026bf-c412-0c47-8956-b565894948e0@suse.de>
 <20230119132330.GP16547@kitsune.suse.cz>
 <190c1c68-0249-a291-f2ab-45c9a7f716d7@suse.de>
 <20230120112759.GS16547@kitsune.suse.cz>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230120112759.GS16547@kitsune.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eOL2LSxv7pGv6l2l67m5v4be"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eOL2LSxv7pGv6l2l67m5v4be
Content-Type: multipart/mixed; boundary="------------46UaiGciE0ovYZInTiOeftTB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Erhard F." <erhard_f@mailbox.org>, Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 open list <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <c51c25e7-a020-77c2-47b0-1e34b433116a@suse.de>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
References: <20230119095323.4659-1-msuchanek@suse.de>
 <8a9f7ba5-37a4-0927-4ab2-d212f1b098a9@csgroup.eu>
 <57e026bf-c412-0c47-8956-b565894948e0@suse.de>
 <20230119132330.GP16547@kitsune.suse.cz>
 <190c1c68-0249-a291-f2ab-45c9a7f716d7@suse.de>
 <20230120112759.GS16547@kitsune.suse.cz>
In-Reply-To: <20230120112759.GS16547@kitsune.suse.cz>

--------------46UaiGciE0ovYZInTiOeftTB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjAuMDEuMjMgdW0gMTI6Mjcgc2NocmllYiBNaWNoYWwgU3VjaMOhbmVrOg0K
PiBIZWxsbywNCj4gDQo+IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDA0OjIwOjU3UE0gKzAx
MDAsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gSGkNCj4+DQo+PiBBbSAxOS4wMS4y
MyB1bSAxNDoyMyBzY2hyaWViIE1pY2hhbCBTdWNow6FuZWs6DQo+Pj4gT24gVGh1LCBKYW4g
MTksIDIwMjMgYXQgMDI6MTE6MTNQTSArMDEwMCwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6
DQo+Pj4+IEhpDQo+Pj4+DQo+Pj4+IEFtIDE5LjAxLjIzIHVtIDExOjI0IHNjaHJpZWIgQ2hy
aXN0b3BoZSBMZXJveToNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gTGUgMTkvMDEvMjAyMyDDoCAx
MDo1MywgTWljaGFsIFN1Y2hhbmVrIGEgw6ljcml0wqA6DQo+Pj4+Pj4gVGhlIGNvbW1pdCAy
ZDY4MWQ2YTIzYTEgKCJvZjogTWFrZSBvZiBmcmFtZWJ1ZmZlciBkZXZpY2VzIHVuaXF1ZSIp
DQo+Pj4+Pj4gYnJlYWtzIGJ1aWxkIGJlY2F1c2Ugb2Ygd3JvbmcgYXJndW1lbnQgdG8gc25w
cmludGYuIFRoYXQgY2VydGFpbmx5DQo+Pj4+Pj4gYXZvaWRzIHRoZSBydW50aW1lIGVycm9y
IGJ1dCBpcyBub3QgdGhlIGludGVuZGVkIG91dGNvbWUuDQo+Pj4+Pj4NCj4+Pj4+PiBBbHNv
IHVzZSBzdGFuZGFyZCBkZXZpY2UgbmFtZSBmb3JtYXQgb2YtZGlzcGxheS5OIGZvciBhbGwg
Y3JlYXRlZA0KPj4+Pj4+IGRldmljZXMuDQo+Pj4+Pj4NCj4+Pj4+PiBGaXhlczogMmQ2ODFk
NmEyM2ExICgib2Y6IE1ha2Ugb2YgZnJhbWVidWZmZXIgZGV2aWNlcyB1bmlxdWUiKQ0KPj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBTdWNoYW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+
DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gdjI6IFVwZGF0ZSB0aGUgZGV2aWNlIG5hbWUgZm9ybWF0
DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgICBkcml2ZXJzL29mL3BsYXRmb3JtLmMgfCAxMiAr
KysrKysrKy0tLS0NCj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9vZi9wbGF0Zm9ybS5jIGIvZHJpdmVycy9vZi9wbGF0Zm9ybS5jDQo+Pj4+Pj4gaW5kZXgg
ZjJhNWQ2NzlhMzI0Li44YzFiMWRlMjIwMzYgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9vZi9wbGF0Zm9ybS5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9vZi9wbGF0Zm9ybS5jDQo+
Pj4+Pj4gQEAgLTUyNSw3ICs1MjUsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBvZl9wbGF0Zm9y
bV9kZWZhdWx0X3BvcHVsYXRlX2luaXQodm9pZCkNCj4+Pj4+PiAgICAgIAlpZiAoSVNfRU5B
QkxFRChDT05GSUdfUFBDKSkgew0KPj4+Pj4+ICAgICAgCQlzdHJ1Y3QgZGV2aWNlX25vZGUg
KmJvb3RfZGlzcGxheSA9IE5VTEw7DQo+Pj4+Pj4gICAgICAJCXN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKmRldjsNCj4+Pj4+PiAtCQlpbnQgZGlzcGxheV9udW1iZXIgPSAxOw0KPj4+Pj4+
ICsJCWludCBkaXNwbGF5X251bWJlciA9IDA7DQo+Pj4+Pj4gKwkJY2hhciBidWZbMTRdOw0K
Pj4+Pj4NCj4+Pj4+IENhbiB5b3UgZGVjbGFyZSB0aGF0IGluIHRoZSBmb3IgYmxvY2sgd2hl
cmUgaXQgaXMgdXNlZCBpbnN0ZWFkID8NCj4+Pj4+DQo+Pj4+Pj4gKwkJY2hhciAqb2ZfZGlz
cGxheV9mb3JtYXQgPSAib2YtZGlzcGxheS4lZCI7DQo+Pj4+Pg0KPj4+Pj4gU2hvdWxkIGJl
IGNvbnN0ID8NCj4+Pj4NCj4+Pj4gVGhhdCBzaG91bGQgYmUgc3RhdGljIGNvbnN0IG9mX2Rp
c3BsYXlfZm9ybWF0W10gPSB0aGVuDQo+Pj4NCj4+PiBXaHk/IEl0IHNvdW5kcyBjb21wbGV0
ZWx5IGZpbmUgdG8gaGF2ZSBhIGNvbnN0IHBvaW50ZXIgdG8gYSBzdHJpbmcNCj4+PiBjb25z
dGF0bnQuDQo+Pg0KPj4gR2VuZXJhbGx5IHNwZWFraW5nOg0KPj4NCj4+ICdzdGF0aWMnIGJl
Y2F1c2UgeW91ciBjb25zdCBwb2ludGVyIGlzIHRoZW4gbm90IGEgbG9jYWwgdmFyaWFibGUs
IHNvIGl0DQo+PiB0YWtlcyBwcmVzc3VyZSBvZmYgdGhlIHN0YWNrLiBGb3IgZ2xvYmFsIHZh
cmlhYmxlcywgeW91IGRvbid0IHdhbnQgdGhlbSB0bw0KPj4gc2hvdyB1cCBpbiBhbnkgbGlu
a2VyIHN5bWJvbCB0YWJsZXMuDQo+IA0KPiBUaGlzIHNvdW5kcyBhIGxvdCBsaWtlIGFuIGV4
ZW1wbGFyIGNhc2Ugb2YgcHJlbWF0dXJlIG9wdGltaXphdGlvbi4NCj4gQSBzaW1wbGlzdGlj
IGNvbXBpbGVyIG1pZ2h0IGRvIGV4YWN0bHkgd2hhdCB5b3Ugc2F5LCBhbmQgYWxsb2NhdGUg
YSBzbG90DQo+IGZvciB0aGUgdmFyaWFibGUgb24gdGhlIHN0YWNrIHRoZSBtb21lbnQgdGhl
IGZ1bmN0aW9uIGlzIGVudGVyZWQuDQo+IA0KPiBIb3dldmVyLCBpbiByZWFsIGNvbXBpbGVy
cyB0aGVyZSBpcyBubyBzdGFjayBwcmVzc3VyZSBmcm9tIGhhdmluZyBhDQo+IGxvY2FsIHZh
cmlhYmxlOg0KPiAgIC0gdGhlIGNvbXBpbGVyIGNhbiBwdXQgdGhlIHZhcmlhYmxlIGludG8g
YSByZWdpc3Rlcg0KPiAgIC0gaXQgY2FuIGNvbXBsZXRlbHkgb21pdCB0aGUgdmFyaWFibGUg
YmVmb3JlIGFuZCBhZnRlciBpdCdzIGFjdHVhbGx5DQo+ICAgICB1c2VkIHdoaWNoIGlzIHRo
YXQgc3BlY2lmaWMgZnVuY3Rpb24gY2FsbA0KPiANCj4+IFRoZSBzdHJpbmcgIm9mLWRpc3Bs
YXkuJWQiIGlzIHN0b3JlZCBhcyBhbiBhcnJheSBpbiB0aGUgRUxGIGRhdGEgc2VjdGlvbi4N
Cj4+IEFuZCB5b3VyIGNoYXIgcG9pbnRlciBpcyBhIHJlZmVyZW5jZSB0byB0aGF0IGFycmF5
LiBGb3Igc3RhdGljIHBvaW50ZXJzLA0KPj4gdGhlc2UgaW5kaXJlY3Rpb25zIHRha2UgQ1BV
IGN5Y2xlcyB0byB1cGRhdGUgd2hlbiB0aGUgbG9hZGVyIGhhcyB0byByZWxvY2F0ZQ0KPiAN
Cj4gUHJvdmlkZWQgdGhhdCB0aGUgY2hhciBwb2ludGVyIGV2ZXIgZXhpc3RzIGluIHRoZSBj
b21waWxlZCBjb2RlLiBJdHMNCj4gYWRkcmVzcyBpcyBub3QgdGFrZW4gc28gaXQgZG9lcyBu
b3QgbmVlZCB0by4NCj4gDQo+PiBzZWN0aW9ucy4gSWYgeW91IGRlY2xhcmUgb2ZfZGlzcGxh
eV9mb3JtYXRbXSBkaXJlY3RseSBhcyBhcnJheSwgeW91IGF2b2lkDQo+PiB0aGUgcmVmZXJl
bmNlIGFuZCB3b3JrIGRpcmVjdGx5IHdpdGggdGhlIGFycmF5Lg0KPj4NCj4+IE9mIGNvdXJz
ZSwgdGhpcyBpcyBhIGtlcm5lbCBtb2R1bGUgYW5kIHRoZSBzdHJpbmcgaXMgc2VsZi1jb250
YWluZWQgd2l0aGluDQo+PiB0aGUgZnVuY3Rpb24uIFNvIHRoZSBjb21waWxlciBjYW4gcHJv
YmFibHkgZGV0ZWN0IHRoYXQgYW5kIG9wdGltaXplIHRoZSBjb2RlDQo+PiB0byBiZSBsaWtl
IHRoZSAnc3RhdGljIGNvbnN0IFtdJyB2ZXJzaW9uLiBJdCdzIHN0aWxsIGdvb2QgdG8gZm9s
bG93IGJlc3QNCj4+IHByYWN0aWNlcywgYXMgc29tZW9uZSBtaWdodCBjb3B5IGZyb20gdGhp
cyBmdW5jdGlvbi4NCj4gDQo+IElmIGl0IGNvdWxkIG5vdCBkZXRlY3QgaXQgdGhlcmUgd291
bGQgYmUgYSBsb3Qgb2YgdHJvdWJsZSBhbGwgYXJvdW5kLg0KDQpUaGUgaXNzdWVzIGRlZmlu
aXRlbHkgZXhpc3QgaW4gdXNlcnNwYWNlIGNvZGUuIEtlcm5lbCBtb2R1bGVzIGFyZSANCnNp
bXBsZXIsIHNvIGNvbXBpbGVyIG9wdGltaXphdGlvbiBpcyBlYXNpZXIuDQoNCkJ1dCBJJ20g
bm90IHJlYWxseSB0cnlpbmcgdG8gbWFrZSBhIHRlY2huaWNhbCBhcmd1bWVudC4gTXkgcG9p
bnQgaGVyZSBpcyANCnRoYXQgc29tZW9uZSBtaWdodCByZWFkIHlvdXIgY29kZSBhbmQgZHVw
bGljYXRlIHRoZSBwYXR0ZXJuLiBUaGF0J3Mgbm90IA0KdW5yZWFzb25hYmxlOiBpdCdzIGNv
cmUgTGludXggY29kZSwgc28gaXQgY2FuIGJlIGFzc3VtZWQgdG8gYmUgZ29vZCAob3IgDQph
dCBsZWFzdCBub3QgYmFkKS4gQnV0IHlvdXIgY3VycmVudCBjb2RlIHRlYWNoZXMgdGhlIHJl
YWRlciBhIGJhZCANCnByYWN0aWNlcywgd2hpY2ggc2hvdWxkIGJlIGF2b2lkZWQuIEl0IGlz
IGJldHRlciB0byBkbyB0aGUgY29ycmVjdCANCnRoaW5nLCBldmVuIGlmIGl0IG1ha2VzIG5v
IGRpZmZlcmVuY2UgdG8gdGhlIGNvbXBpbGVkIGNvZGUuDQoNCkJlc3QgcmVnYXJkcw0KVGhv
bWFzDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gTWljaGFsDQoNCi0tIA0KVGhvbWFzIFppbW1l
cm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJt
YW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRzZsO8aHJlcjogSXZv
IFRvdGV2DQo=

--------------46UaiGciE0ovYZInTiOeftTB--

--------------eOL2LSxv7pGv6l2l67m5v4be
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPKfWsFAwAAAAAACgkQlh/E3EQov+Ah
kQ/+In0kC8jzeshYx4PTaT6sZTmUTJukvffI7Y09FTD8LLhiRLN8qGSkyv9Jj9xmwqCBDmxMOeS8
NpJhsembAUb6+qakHdEvQUJHVss4TJbXMTaqxwCNFALTVh4vGGSCYDzAZ2YGhP0ooRd8tayWemHu
S+xDCfVloKUQh+lqaEQCmYsy97WRmeBZF9jSyElCs+PprJMD7mq3HARI5wCNpzPEKIkD7IEPJDeT
X/J5ILIPB+rpoA0AVMBXuaVojLZzYOkKAgAbaQ7LlgN44w6QNlMJatYJDxaGkrHT2h3wQV6ofudD
q2AKTKe+MhamTo2qjF2h96twz3RNLARR991lAvrb2E4qz+uUusTUAnPDV2oBW4dihKJhmtZ2W/rR
QuDV7Drqub9GffteJNZ1FbJdNYPgMZy6wYBBWPWabOIpfxa9L858jqjfvalZaVZONstNxqtJMxQU
XDfpqH0LXQRdfkKYvZWW4KPKELtbtZc4QnaHMzGo3RWJiI5Cq9Iakw/MHxmHrL/0nU/H87o66Be9
txlJHvtqnGVWzLluVnK9Jsa0wXGwceUXcLsEw/qH/uOz4AsO8bpj37d/wEscm/7rzmLUGrd/m1Sq
AIIMZgi9+puYjAqdq2665wtfc1Y94IMbFCTMn33lPZj00wq6t+T/rxJfVMXuJD1RwFtKZ7iEbn39
+Ys=
=MU8O
-----END PGP SIGNATURE-----

--------------eOL2LSxv7pGv6l2l67m5v4be--
