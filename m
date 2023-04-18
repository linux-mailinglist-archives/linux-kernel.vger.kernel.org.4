Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F246E5F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDRLGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:06:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C02D40;
        Tue, 18 Apr 2023 04:06:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud9so71905943ejc.7;
        Tue, 18 Apr 2023 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681816006; x=1684408006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vu1SBYfLswBC9fPoY3IBP/c1hfDbt9cFF0LwKY1fVBg=;
        b=WkABlEPp4JNcJ72lxS88u9a6+qKHploQjP8EdCjd19yoOt/tuCyQGJPsIiGFCjoxWZ
         DLVtfbWOdsUwfqwgi7WCN7tJJFyXQAGGyPsKfI0P+Yl2Wx8PYD/0vS0JNkWIvjXznIkd
         1ZRa5/H8ajfy+IIjt6A9Mfw4sT7N4R1NeH7GF/+eFI5bG9dQwMiHmkwyroGuXy7uWRNH
         83ms5zKRG7ccxTyD008AfMXZyvcifMpae1lrvb/W0Cv7KgXoypy+HzDkIpV3Y3N8iUO6
         dnb5yVRH1P5zmG2AB5jzbhnEZBuBIC1WEh2pE/Os8dfUZHXaF6gKyTg6RBXk6U35JH+F
         Vyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681816006; x=1684408006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu1SBYfLswBC9fPoY3IBP/c1hfDbt9cFF0LwKY1fVBg=;
        b=HnG+FGhxzF7kGWUFoNI6ArAoLD5P1fF29ZxFmhR5LNM9NP2hI+zhpgHVmglhfxVsCL
         k4aXWckMSblgvN8EMkLpY1J6FjLEIGthumcZDs+oeq31hzl8uIcN2wr1xbEiP/QqU8r6
         MxzpP23YK9381UgBlxXXVjo64O+Kiuj5gH7FMqKLTNNTM9EXbfqGOSRBEJK9axYyzqob
         rYq903yjAwtxy4t7BEgrsdT5/8b7iQY23ubCdT/euS7Z49OShZCu6pU/vvaLTZwZ8Hyb
         TA40GM77vyxjlfBeZdqGXsu2pU9MwoJHy1eAkH+K2gTNMtahDNszrrn4xdSg68UAT8i1
         nXsQ==
X-Gm-Message-State: AAQBX9du/e6Z1BiVMQhSgO0DLrkjgx2e9pTBcSHPXP25V4dhpayTGUKe
        Dp8sYstc3S0ALpydarBfapqALsd206y1AdQL
X-Google-Smtp-Source: AKy350ZX2B40fUVQ9Gt2Uok+rMY44mJj9tFFvJ31wK15bLytE/YOfu6rzdl0c5jFHhL0ehN/ZICjdA==
X-Received: by 2002:a17:906:a945:b0:932:4255:5902 with SMTP id hh5-20020a170906a94500b0093242555902mr9931532ejb.76.1681816006152;
        Tue, 18 Apr 2023 04:06:46 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709064e9000b0094f663bced2sm3290738eju.33.2023.04.18.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:06:45 -0700 (PDT)
Message-ID: <5c8f68f0157d9ae66e6d88d648fcfd26e68be307.camel@gmail.com>
Subject: Re: [PATCH v2] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Apr 2023 13:08:54 +0200
In-Reply-To: <20230414102744.150-1-honda@mechatrax.com>
References: <20230414102744.150-1-honda@mechatrax.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDE5OjI3ICswOTAwLCBNYXNhaGlybyBIb25kYSB3cm90ZToK
PiBUaGUgU2lnbWEtRGVsdGEgQURDcyBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIgY2FuIHVzZSBT
RE8gYXMgYW4gaW50ZXJydXB0Cj4gbGluZSB0byBpbmRpY2F0ZSB0aGUgY29tcGxldGlvbiBvZiBh
IGNvbnZlcnNpb24uIEhvd2V2ZXIsIHNvbWUgZGV2aWNlcwo+IGNhbm5vdCBwcm9wZXJseSBkZXRl
Y3QgdGhlIGNvbXBsZXRpb24gb2YgYSBjb252ZXJzaW9uIGJ5IGFuIGludGVycnVwdC4KPiBUaGlz
IGlzIGZvciB0aGUgcmVhc29uIG1lbnRpb25lZCBpbiB0aGUgZm9sbG93aW5nIGNvbW1pdC4KPiAK
PiBjb21taXQgZTk4NDk3NzdkMGUyICgiZ2VuaXJxOiBBZGQgZmxhZyB0byBmb3JjZSBtYXNrIGlu
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpc2FibGVfaXJx
W19ub3N5bmNdKCkiKQo+IAo+IEEgcmVhZCBvcGVyYXRpb24gaXMgcGVyZm9ybWVkIGJ5IGFuIGV4
dHJhIGludGVycnVwdCBiZWZvcmUgdGhlIGNvbXBsZXRlCj4gY29udmVyc2lvbi4gVGhpcyBwYXRj
aCBwcm92aWRlcyBhbiBvcHRpb24gdG8gZml4IHRoZSBpc3N1ZSBieSBzZXR0aW5nCj4gSVJRX0RJ
U0FCTEVfVU5MQVpZIGZsYWcuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gSG9uZGEgPGhv
bmRhQG1lY2hhdHJheC5jb20+Cj4gLS0tCj4gdjI6Cj4gwqAtIFJld29yayBjb21taXQgbWVzc2Fn
ZS4KPiDCoC0gQWRkIGEgbmV3IGVudHJ5IGluIHRoZSBLY29uZmlnLgo+IMKgLSBDYWxsIGlycV9j
bGVhcl9zdGF0dXNfZmxhZ3MoaXJxLCBJUlFfRElTQUJMRV9VTkxBWlkpIHdoZW4gZnJlZWluZyB0
aGUgSVJRLgo+IHYxOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlpby8yMDIzMDMw
NjA0NDczNy44NjItMS1ob25kYUBtZWNoYXRyYXguY29tLwo+IAo+IMKgZHJpdmVycy9paW8vYWRj
L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrKysrKysrKwo+IMKgZHJpdmVy
cy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnIGIvZHJpdmVycy9p
aW8vYWRjL0tjb25maWcKPiBpbmRleCA0NWFmMjMwMmIuLjc4YWI2ZTJkOCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9LY29uZmln
Cj4gQEAgLTIxLDYgKzIxLDIwIEBAIGNvbmZpZyBBRF9TSUdNQV9ERUxUQQo+IMKgwqDCoMKgwqDC
oMKgwqBzZWxlY3QgSUlPX0JVRkZFUgo+IMKgwqDCoMKgwqDCoMKgwqBzZWxlY3QgSUlPX1RSSUdH
RVJFRF9CVUZGRVIKPiDCoAo+ICtpZiBBRF9TSUdNQV9ERUxUQQo+ICsKPiArY29uZmlnIEFEX1NJ
R01BX0RFTFRBX1VTRV9MQVpZX0lSUQo+ICvCoMKgwqDCoMKgwqDCoGJvb2wgIlVzZSBsYXp5IElS
USBmb3Igc2lnbWEtZGVsdGEgQURDcyIKPiArwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIEFEX1NJ
R01BX0RFTFRBCj4gK8KgwqDCoMKgwqDCoMKgZGVmYXVsdCBuCj4gK8KgwqDCoMKgwqDCoMKgaGVs
cAo+ICvCoMKgwqDCoMKgwqDCoMKgIFNvbWUgaW50ZXJydXB0IGNvbnRyb2xsZXJzIGhhdmUgZGF0
YSByZWFkIHByb2JsZW0gd2l0aCBBRENzIGRlcGVuZHMKPiBvbgo+ICvCoMKgwqDCoMKgwqDCoMKg
IEFEX1NJR01BX0RFTFRBLgo+ICvCoMKgwqDCoMKgwqDCoMKgIFNheSB5ZXMgaGVyZSB0byBhdm9p
ZCB0aGUgcHJvYmxlbSBhdCB0aGUgY29zdCBvZiBwZXJmb3JtYW5jZQo+IG92ZXJoZWFkLgo+ICvC
oMKgwqDCoMKgwqDCoMKgIElmIHVuc3VyZSwgc2F5IE4gKGJ1dCBpdCdzIHNhZmUgdG8gc2F5ICJZ
IikuCj4gKwo+ICtlbmRpZiAjIGlmIEFEX1NJR01BX0RFTFRBCj4gKwo+IMKgY29uZmlnIEFENDEz
MAo+IMKgwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiQW5hbG9nIERldmljZSBBRDQxMzAgQURDIERy
aXZlciIKPiDCoMKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBTUEkKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMKPiBiL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdt
YV9kZWx0YS5jCj4gaW5kZXggZDg1NzBmNjIwLi5iOWVhZTFlODAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMKPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWRf
c2lnbWFfZGVsdGEuYwo+IEBAIC01NjUsNiArNTY1LDE2IEBAIGludCBhZF9zZF92YWxpZGF0ZV90
cmlnZ2VyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsCj4gc3RydWN0IGlpb190cmlnZ2VyICp0
cmlnKQo+IMKgfQo+IMKgRVhQT1JUX1NZTUJPTF9OU19HUEwoYWRfc2RfdmFsaWRhdGVfdHJpZ2dl
ciwgSUlPX0FEX1NJR01BX0RFTFRBKTsKPiDCoAo+ICtzdGF0aWMgdm9pZCBhZF9zZF9mcmVlX2ly
cSh2b2lkICpzZCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAq
c2lnbWFfZGVsdGEgPSBzZDsKPiArCj4gKyNpZmRlZiBDT05GSUdfQURfU0lHTUFfREVMVEFfVVNF
X0xBWllfSVJRCj4gK8KgwqDCoMKgwqDCoMKgaXJxX2NsZWFyX3N0YXR1c19mbGFncyhzaWdtYV9k
ZWx0YS0+c3BpLT5pcnEsIElSUV9ESVNBQkxFX1VOTEFaWSk7Cj4gKyNlbmRpZgo+ICvCoMKgwqDC
oMKgwqDCoGZyZWVfaXJxKHNpZ21hX2RlbHRhLT5zcGktPmlycSwgc2lnbWFfZGVsdGEpOwo+ICt9
Cj4gKwo+IMKgc3RhdGljIGludCBkZXZtX2FkX3NkX3Byb2JlX3RyaWdnZXIoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgaWlvX2Rldgo+ICppbmRpb19kZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAqc2lnbWFfZGVsdGEgPQo+IGlpb19kZXZpY2VfZ2V0
X2RydmRhdGEoaW5kaW9fZGV2KTsKPiBAQCAtNTg0LDExICs1OTQsMjIgQEAgc3RhdGljIGludCBk
ZXZtX2FkX3NkX3Byb2JlX3RyaWdnZXIoc3RydWN0IGRldmljZSAqZGV2LAo+IHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZQo+IMKgwqDCoMKgwqDCoMKgwqBpbml0X2NvbXBsZXRpb24oJnNpZ21hX2Rl
bHRhLT5jb21wbGV0aW9uKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBzaWdtYV9kZWx0YS0+aXJx
X2RpcyA9IHRydWU7Cj4gLcKgwqDCoMKgwqDCoMKgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYs
IHNpZ21hX2RlbHRhLT5zcGktPmlycSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZF9zZF9kYXRhX3JkeV90cmlnX3BvbGwsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2lnbWFfZGVsdGEtPmluZm8tPmlycV9mbGFncyB8IElSUUZfTk9fQVVUT0VOLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
ZGlvX2Rldi0+bmFtZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaWdtYV9kZWx0YSk7Cj4gKyNpZmRlZiBDT05GSUdfQURfU0lH
TUFfREVMVEFfVVNFX0xBWllfSVJRCj4gK8KgwqDCoMKgwqDCoMKgaXJxX3NldF9zdGF0dXNfZmxh
Z3Moc2lnbWFfZGVsdGEtPnNwaS0+aXJxLCBJUlFfRElTQUJMRV9VTkxBWlkpOwo+ICsjZW5kaWYK
PiArwqDCoMKgwqDCoMKgwqByZXQgPSByZXF1ZXN0X2lycShzaWdtYV9kZWx0YS0+c3BpLT5pcnEs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZF9z
ZF9kYXRhX3JkeV90cmlnX3BvbGwsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzaWdtYV9kZWx0YS0+aW5mby0+aXJxX2ZsYWdzIHwgSVJRRl9OT19B
VVRPRU4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbmRpb19kZXYtPm5hbWUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzaWdtYV9kZWx0YSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+
ICsjaWZkZWYgQ09ORklHX0FEX1NJR01BX0RFTFRBX1VTRV9MQVpZX0lSUQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpcnFfY2xlYXJfc3RhdHVzX2ZsYWdzKHNpZ21hX2RlbHRhLT5z
cGktPmlycSwKPiBJUlFfRElTQUJMRV9VTkxBWlkpOwoKSSdtIG5vdCByZWFsbHkga2VlbiB3aXRo
IGhhdmluZyB0aGUgS2NvbmZpZyBvcHRpb24uIEknbSBmYWlybHkgY29udmluY2VkIHRoYXQKdGhp
cyBtaWdodCBiZSBhIHByb2JsZW0gYWZmZWN0aW5nIGFsbCBzaWdtYSBkZWx0YSBBRENzIGFuZCBl
dmVuIGlmIHRoZXkgYXJlbid0CmFmZmVjdGVkLCBJIGRvIG5vdCB0aGluayB0aGF0IHNldHRpbmcg
dGhpcyBJUlEgZmxhZyB3aWxsIGRvIGFueSBhcm0gKG90aGVyIHRoYW4KbGVzcyBlZmZpY2llbmN5
IG1heWJlKS4KCgpJZiB5b3UgcmVhbGx5IHdhbnQgdG8gYmUgb24gdGhlIHNhZmUgc2lkZSwgd2Ug
Y291bGQgYWRkIGEgbmV3IGJvb2xlYW4gdG8gJ3N0cnVjdAphZF9zaWdtYV9kZWx0YV9pbmZvJyB0
aGF0IHdvdWxkIGJlIGVuYWJsZWQgZm9yIHlvdXIgZGV2aWNlIGFuZCB3aGVuIHRydWUsIHRoZQpM
QVpZIGJpdCBpcyBzZXQuIE9uY2Ugd2UgcHJvdmUgdGhhdCBhbGwgZGV2aWNlcyBtaWdodCBiZSBh
ZmZlY3RlZCBieSB0aGlzIGlzc3VlLAp3ZSBjb3VsZCByZW1vdmUgdGhlIGJvb2xlYW4gYW5kIG1h
a2UgaXQgYSBkZWZhdWx0IHNldHRpbmcuCgotIE51bm8gU8OhCg==

