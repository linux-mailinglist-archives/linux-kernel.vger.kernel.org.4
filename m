Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E338A5F6244
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJFIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJFIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:05:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0945F7F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:05:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEC281F8E3;
        Thu,  6 Oct 2022 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665043522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUUR2UbJ0YzkcI6KzPhYHq2A2xLv/oqT/Dwhrd+tXOA=;
        b=c5v30QrN7NrllteZEVlz8Iu5Zj9ldNCx8agArvngoKQZdYl+Mcfb29JrwXKgV0/q2CuwhH
        s+xEW99p7tosSoOlI/nzf/tVbGfHnuMzG6H8bpE6Ertb7dMVSjiLKn7gAxqwyhR9MmTUyD
        +u7S34UP5Oq2QIlgwx43nBV3w0IKVww=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8458713AC8;
        Thu,  6 Oct 2022 08:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ginOHUKMPmM/KgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 08:05:22 +0000
Message-ID: <85471e4e-086a-6229-7fd1-e1d5556b94ed@suse.com>
Date:   Thu, 6 Oct 2022 10:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
Content-Language: en-US
To:     Xenia Ragiadakou <burzalodowa@gmail.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20221005174823.1800761-1-olekstysh@gmail.com>
 <20221005174823.1800761-2-olekstysh@gmail.com>
 <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZJH7GOTQr00upljzwvPE4pWt"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZJH7GOTQr00upljzwvPE4pWt
Content-Type: multipart/mixed; boundary="------------8kW5IUQoXA6saWh3aZAJ5lik";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Xenia Ragiadakou <burzalodowa@gmail.com>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <85471e4e-086a-6229-7fd1-e1d5556b94ed@suse.com>
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
References: <20221005174823.1800761-1-olekstysh@gmail.com>
 <20221005174823.1800761-2-olekstysh@gmail.com>
 <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
In-Reply-To: <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>

--------------8kW5IUQoXA6saWh3aZAJ5lik
Content-Type: multipart/mixed; boundary="------------e5voAR9ahx30a4DjEYB2zzcZ"

--------------e5voAR9ahx30a4DjEYB2zzcZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMDk6MzUsIFhlbmlhIFJhZ2lhZGFrb3Ugd3JvdGU6DQo+IA0KPiBPbiAx
MC81LzIyIDIwOjQ4LCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+IEZyb206IE9s
ZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCj4+
DQo+PiBUYWtlIHBhZ2Ugb2Zmc2V0IGludG8gdGhlIGFjY291bnQgd2hlbiBjYWxjdWxhdGlu
ZyB0aGUgbnVtYmVyIG9mIHBhZ2VzDQo+PiB0byBiZSBncmFudGVkLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0Bl
cGFtLmNvbT4NCj4+IEZpeGVzOiBkNmFjYTM1MDRjN2QgKCJ4ZW4vZ3JhbnQtZG1hLW9wczog
QWRkIG9wdGlvbiB0byByZXN0cmljdCBtZW1vcnkgYWNjZXNzIA0KPj4gdW5kZXIgWGVuIikN
Cj4+IC0tLQ0KPj4gwqAgZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jIHwgNSArKystLQ0K
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJp
dmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBpbmRleCA4OTczZmMxZTljY2MuLjE5OThk
MGU4Y2U4MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0K
Pj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBAQCAtMTUzLDcgKzE1
Myw3IEBAIHN0YXRpYyBkbWFfYWRkcl90IHhlbl9ncmFudF9kbWFfbWFwX3BhZ2Uoc3RydWN0
IGRldmljZSANCj4+ICpkZXYsIHN0cnVjdCBwYWdlICpwYWdlLA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhdHRycykN
Cj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHhlbl9ncmFudF9kbWFfZGF0YSAqZGF0
YTsNCj4+IC3CoMKgwqAgdW5zaWduZWQgaW50IGksIG5fcGFnZXMgPSBQRk5fVVAoc2l6ZSk7
DQo+PiArwqDCoMKgIHVuc2lnbmVkIGludCBpLCBuX3BhZ2VzID0gUEZOX1VQKG9mZnNldCAr
IHNpemUpOw0KPiANCj4gSGVyZSwgd2h5IGRvIHdlIHVzZSBQRk5fVVAgYW5kIG5vdCBYRU5f
UEZOX1VQPw0KPiBBbHNvLCBzaW5jZSB0aGUgdmFyaWFibGUgJ25fcGFnZXMnIHNlZW1zIHRv
IHJlZmVyIHRvIHRoZSBudW1iZXIgb2YgZ3JhbnRzIA0KPiAodW5sZXNzIEkgZ290IGl0IGFs
bCBlbnRpcmVseSB3cm9uZyAuLi4pLCB3b3VsZG4ndCBpdCBiZSBtb3JlIHN1aXRhYmxlIHRv
IGNhbGwgDQo+IGV4cGxpY2l0bHkgZ250dGFiX2NvdW50X2dyYW50KCk/DQoNCkdvb2QgcG9p
bnQuDQoNCkkgdGhpbmsgdGhpcyB3aWxsIG5lZWQgYW5vdGhlciBwYXRjaCBmb3Igc3dpdGNo
aW5nIGdyYW50LWRtYS1vcHMuYyB0bw0KdXNlIFhFTl9QQUdFX1NJWkUgYW5kIFhFTl9QQUdF
X1NISUZULg0KDQoNCkp1ZXJnZW4NCg0K
--------------e5voAR9ahx30a4DjEYB2zzcZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------e5voAR9ahx30a4DjEYB2zzcZ--

--------------8kW5IUQoXA6saWh3aZAJ5lik--

--------------ZJH7GOTQr00upljzwvPE4pWt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM+jEIFAwAAAAAACgkQsN6d1ii/Ey/Y
jggAlOBlnMSX/Eda/hfdrLDTn4dLywVeGEP7ryeHGrqA7NK+lr85SpyxaMGtk1xNXa2LniXutpV2
gpqk4Vxo/Cm+V1Kbd7ipnwrKLpEIeRNf5dEU1BoVtU5ig+U4M+9L9fAtWoVyf5ynEcnuzYu8B8Kp
8zTLxXckDShgSZVpRyKwYyIql3rlcx1BeBAfNSe5wJbpPbSX6uKMt+l5evPGWp19DikOpTsJZLr3
ZUXuYaoBe+LWX39WeYPuc6Hr2M+wzb9bAD9o9J6R4RILLxXDmMr91rVApG0C033O76Kk1Xzz8+vS
tCrQlYDATCa8ekzbOUTHOHczwuIHA5xtg39aFEXWpQ==
=9+jX
-----END PGP SIGNATURE-----

--------------ZJH7GOTQr00upljzwvPE4pWt--
