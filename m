Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6565CEEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjADI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjADI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:59:26 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21C81F2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:59:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672822747; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=d5eZy/gk6QR6EU8i/njR8r3ZZHpMWIMIVJFfLzXnm9HTVOKh8dNr4ki5iBl/sOoehHF0/KrFDKJgmKV5JPPlcv49uPpxrSJnTUiB8/eGp0Awy7FkSoI4Xz/dj2Olbosu3Dw0mkOtZaBvlPZOuRqz+4a9jgE9M2S6Sm0MBhtg53Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672822747; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mGVEEqg9y41OGC1daXDP6Rf+M/fdNyUu5fMaF3ljaNI=; 
        b=bwcTxJ1E3mJQjGu/+VVD0QgaBlmG2zMZqIKQuyREfU7F0ufSfziXCIrCUezt0gk+z9tduvBZ2mnghYM0FNL8Jt377qrdnhOmxHRcDhZRz9RutqAuwYeN+TPRGkm1Qquht4D44i+tTnSwCsf6gOIcvs+nvwQyGSjSmPCH9wND8a4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672822747;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=mGVEEqg9y41OGC1daXDP6Rf+M/fdNyUu5fMaF3ljaNI=;
        b=Vk0Fjlc3K4sq3GmQZCScu/Z96MNb3aTZ31Uaa8YkZD3/jSWd5Mn0V53D5N2pI1jZ
        ZFXGTNMO6iqbV9c0Llx99tDnXG1X8ZW5OaurALPzzX28GFKPDG9xG6o5UGlvKDodDOf
        yRLAsdWCSIygmH/ofZ8YLlpoJGGatmTT3ggpFhfQ=
Received: from edelgard.fodlan.icenowy.me (120.85.96.143 [120.85.96.143]) by mx.zohomail.com
        with SMTPS id 1672822745390708.8255740342773; Wed, 4 Jan 2023 00:59:05 -0800 (PST)
Message-ID: <a2a8c7522b9b57f074d6962511b6d779cfd4b56b.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/3] riscv: use VA+PA variant of CMO macros for DMA
 synchorization
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jan 2023 16:59:00 +0800
In-Reply-To: <CAJF2gTSb4qEPHw8hy1ro+UMoyKQaoQESNGveSGLdPL=cXac8jQ@mail.gmail.com>
References: <20230104074146.578485-1-uwu@icenowy.me>
         <20230104074146.578485-3-uwu@icenowy.me>
         <CAJF2gTSb4qEPHw8hy1ro+UMoyKQaoQESNGveSGLdPL=cXac8jQ@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDEtMDTmmJ/mnJ/kuInnmoQgMTY6NTAgKzA4MDDvvIxHdW8gUmVu5YaZ6YGT77ya
Cj4gT24gV2VkLCBKYW4gNCwgMjAyMyBhdCAzOjQzIFBNIEljZW5vd3kgWmhlbmcgPHV3dUBpY2Vu
b3d5Lm1lPiB3cm90ZToKPiA+IAo+ID4gRE1BIHN5bmNob3JpemF0aW9uIGlzIGRvbmUgb24gUEEg
YW5kIHRoZSBWQSBpcyBjYWxjdWxhdGVkIGZyb20gdGhlCj4gPiBQQS4KPiA+IAo+ID4gVXNlIHRo
ZSBhbHRlcm5hdGl2ZSBtYWNybyB2YXJpYW50IHRoYXQgdGFrZXMgYm90aCBWQSBhbmQgUEEgYXMK
PiA+IHBhcmFtZXRlcnMsIHRodXMgaW4gY2FzZSB0aGUgSVNBIGV4dGVuc2lvbiB1c2VkIHN1cHBv
cnQgUEEKPiA+IGRpcmVjdGx5LCB0aGUKPiA+IG92ZXJoZWFkIGZvciByZS1jb252ZXJ0aW5nIFZB
IHRvIFBBIGNhbiBiZSBvbWl0dGVkLgo+ID4gCj4gPiBTdWdnZXN0ZWQtYnk6IEd1byBSZW4gPGd1
b3JlbkBrZXJuZWwub3JnPgo+ID4gU2lnbmVkLW9mZi1ieTogSWNlbm93eSBaaGVuZyA8dXd1QGlj
ZW5vd3kubWU+Cj4gPiAtLS0KPiA+IMKgYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYyB8
IDggKysrKy0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vZG1hLW5vbmNvaGVy
ZW50LmMgYi9hcmNoL3Jpc2N2L21tL2RtYS0KPiA+IG5vbmNvaGVyZW50LmMKPiA+IGluZGV4IGQ5
MTllZmFiNmViYS4uYTc1MWY0YWVjZTYyIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9yaXNjdi9tbS9k
bWEtbm9uY29oZXJlbnQuYwo+ID4gKysrIGIvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQu
Ywo+ID4gQEAgLTE5LDEzICsxOSwxMyBAQCB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2RldmljZShw
aHlzX2FkZHJfdAo+ID4gcGFkZHIsIHNpemVfdCBzaXplLAo+ID4gCj4gPiDCoMKgwqDCoMKgwqDC
oCBzd2l0Y2ggKGRpcikgewo+ID4gwqDCoMKgwqDCoMKgwqAgY2FzZSBETUFfVE9fREVWSUNFOgo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19PUChjbGVhbiwgdmFkZHIs
IHNpemUsCj4gPiByaXNjdl9jYm9tX2Jsb2NrX3NpemUpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQUxUX0NNT19PUF9WUEEoY2xlYW4sIHZhZGRyLCBwYWRkciwgc2l6ZSwKPiA+
IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gQUxUX0NNT19PUCAtPiBBTFRfQ01PX09QX1ZQQSwg
aXMgdGhlIHJlbmFtaW5nIG5lY2Vzc2FyeT8KCkkgZGlkbid0IHJlbmFtZSB0aGUgb3JpZ2luYWwg
QUxUX0NNT19PUCwgQUxUX0NNT19PUF9WUEEgaXMgc29tZXRoaW5nCm5ldy4KCj4gCj4gT3RoZXJz
Ogo+IFJldmlld2VkLWJ5OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KPiAKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2Ug
RE1BX0ZST01fREVWSUNFOgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NN
T19PUChjbGVhbiwgdmFkZHIsIHNpemUsCj4gPiByaXNjdl9jYm9tX2Jsb2NrX3NpemUpOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19PUF9WUEEoY2xlYW4sIHZhZGRy
LCBwYWRkciwgc2l6ZSwKPiA+IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoCBjYXNlIERNQV9C
SURJUkVDVElPTkFMOgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19P
UChmbHVzaCwgdmFkZHIsIHNpemUsCj4gPiByaXNjdl9jYm9tX2Jsb2NrX3NpemUpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19PUF9WUEEoZmx1c2gsIHZhZGRyLCBw
YWRkciwgc2l6ZSwKPiA+IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gQEAgLTQyLDcgKzQyLDcg
QEAgdm9pZCBhcmNoX3N5bmNfZG1hX2Zvcl9jcHUocGh5c19hZGRyX3QgcGFkZHIsCj4gPiBzaXpl
X3Qgc2l6ZSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKg
wqDCoMKgwqDCoMKgIGNhc2UgRE1BX0ZST01fREVWSUNFOgo+ID4gwqDCoMKgwqDCoMKgwqAgY2Fz
ZSBETUFfQklESVJFQ1RJT05BTDoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFM
VF9DTU9fT1AoZmx1c2gsIHZhZGRyLCBzaXplLAo+ID4gcmlzY3ZfY2JvbV9ibG9ja19zaXplKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFMVF9DTU9fT1BfVlBBKGZsdXNoLCB2
YWRkciwgcGFkZHIsIHNpemUsCj4gPiByaXNjdl9jYm9tX2Jsb2NrX3NpemUpOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqAgZGVmYXVs
dDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IC0tCj4gPiAy
LjM4LjEKPiA+IAo+IAo+IAoK

