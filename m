Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F04656949
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiL0KFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0KFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:05:22 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D981D2D4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672135500; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=e8ufoqB33em2gOtEPUVDFC+CvsJopt1iZg5J4H7B2lvi0CgPiaNFI4hYSMa2R9S2uciBiVqQmbij6M21kEIDA7OhjlCEr7ZCExLohfb7XDxPMl0p43rUsX4zOQ5A7qIKAH2opZJpSeaPgzYYnjtRfk+uapE1VnQWYFBTWZnSLNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672135500; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DAXSpzQd+Jsc9stx//zixRGHRdcARwpGOuARJ44D1lA=; 
        b=K0dm38x8JqK9fzvYaIyt9nEmZLO1vbbZeEnLsN7DdoWIUJkhFnI1kxih3/MuhKQNvt1Nf2AJ074HT6ALyLyE0hqL1PNwgw1E58KAdu3P8QUeFqNssui3l+UDZ9MLjM4gWbYTzYEKJ/rfioXhuNhg7uvFvxH42Ul+GU5G9KmopWY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672135500;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=DAXSpzQd+Jsc9stx//zixRGHRdcARwpGOuARJ44D1lA=;
        b=SchVgPQzuZMNjC5ranCx7xU+SWQMmjXMGJAWsstEx/IEv4cj+4J9fK7pdaAzx1O/
        7KVg9Qcw1I1b9990+ZbS7qFz+lQA3y+B0iQvTe9cOu2UMtobjV+410xTxsHgo9P6rTW
        W0zdlFzqrzAoH3j0+b8saui/RsiZm0w+3vKBVCEc=
Received: from edelgard.fodlan.icenowy.me (120.85.99.39 [120.85.99.39]) by mx.zohomail.com
        with SMTPS id 167213549979179.98103443094215; Tue, 27 Dec 2022 02:04:59 -0800 (PST)
Message-ID: <2c3bf520dec7e368f5b98d7c17811f027921dfa8.camel@icenowy.me>
Subject: Re: [PATCH 1/2] riscv: errata: fix T-Head dcache.cva encoding
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Dec 2022 18:04:55 +0800
In-Reply-To: <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
References: <20221227020258.303900-1-uwu@icenowy.me>
         <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTItMjfmmJ/mnJ/kuoznmoQgMTA6NDcgKzA4MDDvvIxHdW8gUmVu5YaZ6YGT77ya
Cj4gR29vZCBjYXRjaC4gQnV0IEkgaG9wZSBjOTA2LzkxMCBjYW4gZGlyZWN0bHkgdXNlIHBhZGRy
IGhlcmUuIEl0J3MKPiB1bm5lY2Vzc2FyeSB0byBjYXVzZSBzb2Z0d2FyZSB0cmFuc2xhdGlvbiAm
IG1tdSB0cmFuc2xhdGlvbiBoZXJlLgoKVGhpcyBjb3VsZCBiZSBhbiBlbmhhbmNlbWVudCBpbmRl
cGVuZGVudCBvZiB0aGlzIHBhdGNoc2V0LgoKSW4gYWRkaXRpb24sIEkgdGhpbmsgdGhpcyBpcyBz
b21lIHJlbWFpbmluZyBvZiB0aGUgZGVzaWduIG9mIHRoZQpvcmlnaW5hbCBwYXRjaHNldCwgaW4g
d2hpY2ggYWRkcyBaaWNib20gc3VwcG9ydCBhbmQgdGhlbiBYdGhlYWRjbW8Kc3VwcG9ydCBhcyBz
b21lIGVycmF0YS4KCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vZG1hLW5vbmNvaGVy
ZW50LmMgYi9hcmNoL3Jpc2N2L21tL2RtYS0KPiBub25jb2hlcmVudC5jCj4gaW5kZXggYjBhZGQ5
ODM1MzBhLi4zMDY1MGEwYzQ0ODEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9yaXNjdi9tbS9kbWEtbm9u
Y29oZXJlbnQuYwo+ICsrKyBiL2FyY2gvcmlzY3YvbW0vZG1hLW5vbmNvaGVyZW50LmMKPiBAQCAt
MjQsMTMgKzI0LDEzIEBAIHZvaWQgYXJjaF9zeW5jX2RtYV9mb3JfZGV2aWNlKHBoeXNfYWRkcl90
IHBhZGRyLAo+IHNpemVfdCBzaXplLAo+IAo+IMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAoZGlyKSB7
Cj4gwqDCoMKgwqDCoMKgwqAgY2FzZSBETUFfVE9fREVWSUNFOgo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEFMVF9DTU9fT1AoY2xlYW4sIHZhZGRyLCBzaXplLAo+IHJpc2N2X2Nib21f
YmxvY2tfc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19PUChj
bGVhbiwgdmFkZHIsIHBhZGRyLCBzaXplLAo+IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7CgpNYXli
ZSB0aGUgbWFjcm8gc2hvdWxkIGJlIHJlbmFtZWQgYXMgQUxUX0NNT19PUF9WUEEgb3Igc2ltaWxh
ciB0aGluZywKdGhhdCBtZWFucyBib3RoIFZBIGFuZCBQQSBhcmUgcHJvdmlkZWQgYW5kIHRoZSBt
b3N0IGVmZmljaWVudCBvbmUgd2lsbApiZSBjaG9zZW4sIGJlY2F1c2UgQ01PIG9wZXJhdGlvbnMg
d2l0aCBQQSBpcyBzdGlsbCBzb21lIFQtSGVhZC1vbmx5CnRoaW5nIChaaWNib20gb25seSBzdXBw
b3J0cyBWQSkuCgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKg
wqDCoMKgwqDCoCBjYXNlIERNQV9GUk9NX0RFVklDRToKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBBTFRfQ01PX09QKGNsZWFuLCB2YWRkciwgc2l6ZSwKPiByaXNjdl9jYm9tX2Jsb2Nr
X3NpemUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFMVF9DTU9fT1AoY2xlYW4s
IHZhZGRyLCBwYWRkciwgc2l6ZSwKPiByaXNjdl9jYm9tX2Jsb2NrX3NpemUpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoCBjYXNlIERNQV9C
SURJUkVDVElPTkFMOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFMVF9DTU9fT1Ao
Zmx1c2gsIHZhZGRyLCBzaXplLAo+IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQUxUX0NNT19PUChmbHVzaCwgdmFkZHIsIHBhZGRyLCBzaXpl
LAo+IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+IEBAIC00Nyw3ICs0Nyw3IEBAIHZvaWQgYXJjaF9zeW5jX2Rt
YV9mb3JfY3B1KHBoeXNfYWRkcl90IHBhZGRyLAo+IHNpemVfdCBzaXplLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoCBjYXNlIERNQV9GUk9N
X0RFVklDRToKPiDCoMKgwqDCoMKgwqDCoCBjYXNlIERNQV9CSURJUkVDVElPTkFMOgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFMVF9DTU9fT1AoZmx1c2gsIHZhZGRyLCBzaXplLAo+
IHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
QUxUX0NNT19PUChmbHVzaCwgdmFkZHIsIHBhZGRyLCBzaXplLAo+IHJpc2N2X2Nib21fYmxvY2tf
c2l6ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKg
wqDCoMKgIGRlZmF1bHQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+
IEBAIC01Nyw4ICs1Nyw5IEBAIHZvaWQgYXJjaF9zeW5jX2RtYV9mb3JfY3B1KHBoeXNfYWRkcl90
IHBhZGRyLAo+IHNpemVfdCBzaXplLAo+IMKgdm9pZCBhcmNoX2RtYV9wcmVwX2NvaGVyZW50KHN0
cnVjdCBwYWdlICpwYWdlLCBzaXplX3Qgc2l6ZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoCB2b2lk
ICpmbHVzaF9hZGRyID0gcGFnZV9hZGRyZXNzKHBhZ2UpOwo+ICvCoMKgwqDCoMKgwqAgcGh5c19h
ZGRyX3QgcGFkZHIgPSBQRk5fUEhZUyhwYWdlX3RvX3Bmbih4KSk7Cj4gCj4gLcKgwqDCoMKgwqDC
oCBBTFRfQ01PX09QKGZsdXNoLCBmbHVzaF9hZGRyLCBzaXplLCByaXNjdl9jYm9tX2Jsb2NrX3Np
emUpOwo+ICvCoMKgwqDCoMKgwqAgQUxUX0NNT19PUChmbHVzaCwgZmx1c2hfYWRkciwgcGFkZHIs
IHNpemUsCj4gcmlzY3ZfY2JvbV9ibG9ja19zaXplKTsKPiDCoH0KPiAKPiBPbiBUdWUsIERlYyAy
NywgMjAyMiBhdCAxMDowMyBBTSBJY2Vub3d5IFpoZW5nIDx1d3VAaWNlbm93eS5tZT4KPiB3cm90
ZToKPiA+IAo+ID4gVGhlIGRjYWNoZS5jdmEgZW5jb2Rpbmcgc2hvd24gaW4gdGhlIGNvbW1lbnRz
IGFyZSB3cm9uZywgaXQncyBmb3IKPiA+IGRjYWNoZS5jdmFsMSAod2hpY2ggaXMgcmVzdHJpY3Rl
ZCB0byBMMSkgaW5zdGVhZC4KPiA+IAo+ID4gRml4IHRoaXMgaW4gdGhlIGNvbW1lbnQgYW5kIGlu
IHRoZSBoYXJkY29kZWQgaW5zdHJ1Y3Rpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEljZW5v
d3kgWmhlbmcgPHV3dUBpY2Vub3d5Lm1lPgo+ID4gLS0tCj4gPiBUaGUgY29kZSBpcyB0ZXN0ZWQg
b24gYSBMaXRlWCBTb0Mgd2l0aCBPcGVuQzkwNiBjb3JlLCBhbmQgaXQKPiA+IHN1Y2Nlc3NmdWxs
eSBib290cyB0byBTeXN0ZW1kIG9uIGEgU0QgY2FyZCBjb25uZWN0ZWQgdG8gTGl0ZVNEQ2FyZC4K
PiA+IAo+ID4gVGhpcyBjaGFuZ2Ugc2hvdWxkIGJlIG5vdCBub3RpY2FibGUgb24gQzkwNiwgYnV0
IG9uIG11bHRpLWNvcmUgQzkxMAo+ID4gY2x1c3RlciBpdCBzaG91bGQgZml4ZXMgc29tZXRoaW5n
LiBVbmZvcnR1bmF0ZWx5IFRIMTUyMCBzZWVtcyB0byBiZQo+ID4gbm90Cj4gPiBzbyByZWFkeSB0
byB0ZXN0IG1haW5saW5lIHBhdGNoZXMgb24uCj4gPiAKPiA+IMKgYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9lcnJhdGFfbGlzdC5oIHwgNCArKy0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL2VycmF0YV9saXN0LmgKPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9l
cnJhdGFfbGlzdC5oCj4gPiBpbmRleCA0MTgwMzEyZDJhNzAuLjYwNTgwMGJkMzkwZSAxMDA2NDQK
PiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vZXJyYXRhX2xpc3QuaAo+ID4gKysrIGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lcnJhdGFfbGlzdC5oCj4gPiBAQCAtMTAyLDcgKzEwMiw3
IEBAIGFzbQo+ID4gdm9sYXRpbGUoQUxURVJOQVRJVkUowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiA+IMKgICogfCAzMSAtIDI1IHwgMjQgLSAyMCB8IDE5IC0gMTUgfCAxNCAtIDEyIHwg
MTEgLSA3IHwgNiAtIDAgfAo+ID4gwqAgKsKgwqAgMDAwMDAwMcKgwqDCoCAwMTAwMcKgwqDCoMKg
wqAgcnMxwqDCoMKgwqDCoMKgIDAwMMKgwqDCoMKgwqAgMDAwMDDCoCAwMDAxMDExCj4gPiDCoCAq
IGRjYWNoZS5jdmEgcnMxIChjbGVhbiwgdmlydHVhbCBhZGRyZXNzKQo+ID4gLSAqwqDCoCAwMDAw
MDAxwqDCoMKgIDAwMTAwwqDCoMKgwqDCoCByczHCoMKgwqDCoMKgwqAgMDAwwqDCoMKgwqDCoCAw
MDAwMMKgIDAwMDEwMTEKPiA+ICsgKsKgwqAgMDAwMDAwMcKgwqDCoCAwMDEwMcKgwqDCoMKgwqAg
cnMxwqDCoMKgwqDCoMKgIDAwMMKgwqDCoMKgwqAgMDAwMDDCoCAwMDAxMDExCj4gPiDCoCAqCj4g
PiDCoCAqIGRjYWNoZS5jaXBhIHJzMSAoY2xlYW4gdGhlbiBpbnZhbGlkYXRlLCBwaHlzaWNhbCBh
ZGRyZXNzKQo+ID4gwqAgKiB8IDMxIC0gMjUgfCAyNCAtIDIwIHwgMTkgLSAxNSB8IDE0IC0gMTIg
fCAxMSAtIDcgfCA2IC0gMCB8Cj4gPiBAQCAtMTE1LDcgKzExNSw3IEBAIGFzbQo+ID4gdm9sYXRp
bGUoQUxURVJOQVRJVkUowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKgICrCoMKg
IDAwMDAwMDDCoMKgwqAgMTEwMDHCoMKgwqDCoCAwMDAwMMKgwqDCoMKgwqAgMDAwwqDCoMKgwqDC
oCAwMDAwMMKgIDAwMDEwMTEKPiA+IMKgICovCj4gPiDCoCNkZWZpbmUgVEhFQURfaW52YWxfQTAg
Ii5sb25nIDB4MDI2NTAwMGIiCj4gPiAtI2RlZmluZSBUSEVBRF9jbGVhbl9BMCAiLmxvbmcgMHgw
MjQ1MDAwYiIKPiA+ICsjZGVmaW5lIFRIRUFEX2NsZWFuX0EwICIubG9uZyAweDAyNTUwMDBiIgo+
ID4gwqAjZGVmaW5lIFRIRUFEX2ZsdXNoX0EwICIubG9uZyAweDAyNzUwMDBiIgo+ID4gwqAjZGVm
aW5lIFRIRUFEX1NZTkNfU8KgwqAgIi5sb25nIDB4MDE5MDAwMGIiCj4gPiAKPiA+IC0tCj4gPiAy
LjM4LjEKPiA+IAo+IAo+IAoK

