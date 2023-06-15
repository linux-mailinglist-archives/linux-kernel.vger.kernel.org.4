Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AD7317E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbjFOLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjFOLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:49:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC774C1D;
        Thu, 15 Jun 2023 04:45:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51878f8e541so3901449a12.3;
        Thu, 15 Jun 2023 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686829463; x=1689421463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PsB/lTh8ezN+o2RMhrgiAkKWObZXXCXjnY1D91YDpxU=;
        b=ANsdqW65dcCX2WTsAXbKhVaPY84BRLwpT/fb1uAmQcG5HOSaBywrukPYcc0wJFqO5J
         MYRBpaIHU8lBhVC+6nZwgbkCFtvHMftO+1ucfKM6i4DgZwJ4rQQ5yvFgkkv+SWhrQnkO
         QadCWpb1dQyUi+PkwtcYQoqZ5UE58PP2vLcInh7oI97MaINgZCmPOHTOZHtNyR1w7vbS
         MZm/Uw/1DGHElmqQijiYhocBA1g0VoJFoJceZgep35GWCe+BTAxwYdde9Z9xc8uhZfsg
         7YDb7yK/Pa9BU+MjBo9VfYrXRofFsVIiK0YBecM+NNYt/ab57MHXo6soem7sH/AkCXTF
         NF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686829463; x=1689421463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsB/lTh8ezN+o2RMhrgiAkKWObZXXCXjnY1D91YDpxU=;
        b=SCWFeGmC1Ivf65IxepnBgEuglstwNhrmr3+hQueVrJ3ceecIv3jK8cpeXXJ71qIsCf
         SWGqGjQJm4U5lrw4Iv9fjGNWqUFu2UTu+8NPeX50MLdyFNq8yUn7uw+ufZ/B3UsjNlb0
         2hTaK/CHMMV9VQ6dQeH93oTtdlSF67JsBgNdYwETAaJaSr41fG2KMtWOmMZ5XUT1iBL2
         4G+yj9PHVatA3oVn64Bbpbz3DIAQZaXMuOxYFUAlspwnPz1ln/AmKqE/ckwQUHDQ/D4y
         yEvkzGtdsMsv2bRfaswiEH9PcwCZAo/08eohx/IknfOl1gnAGWIDFxT8G0A52OtutEbM
         ojvw==
X-Gm-Message-State: AC+VfDwkUXM20+5kQgVIybVarm4jgkN8hvWLL8q420q22TiEX/UNYCR7
        aVkjRFAdsL9HjYbFeOkdXeU=
X-Google-Smtp-Source: ACHHUZ6RzWHFSaGw8cn8eRvJn8As/DQXwTkv1B/wA6aGk2IXfELhI/RLREK2k0OjWZhCMoHrOFo/Eg==
X-Received: by 2002:a05:6402:358:b0:514:a69e:67cc with SMTP id r24-20020a056402035800b00514a69e67ccmr10702186edw.28.1686829462818;
        Thu, 15 Jun 2023 04:44:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c795000000b0050dfd7de30dsm8735856eds.94.2023.06.15.04.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:44:22 -0700 (PDT)
Message-ID: <b8693c52df5cf520d6994b872bac0768901a0a6d.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Fix ac excitation feature
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Alisa Roman <alisa.roman@analog.com>
Cc:     stable@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Jun 2023 13:46:44 +0200
In-Reply-To: <20230614155242.160296-1-alisa.roman@analog.com>
References: <20230614155242.160296-1-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 
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

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDE4OjUyICswMzAwLCBBbGlzYSBSb21hbiB3cm90ZToKPiBB
QyBleGNpdGF0aW9uIGVuYWJsZSBmZWF0dXJlIGV4cG9zZWQgdG8gdXNlciBvbiBBRDcxOTIsIGFs
bG93aW5nIGEgYml0Cj4gd2hpY2ggc2hvdWxkIGJlIDAgdG8gYmUgc2V0LiBUaGlzIGZlYXR1cmUg
aXMgc3BlY2lmaWMgb25seSB0byBBRDcxOTUuIEFDCj4gZXhjaXRhdGlvbiBhdHRyaWJ1dGUgbW92
ZWQgYWNjb3JkaW5nbHkuCj4gCj4gSW4gdGhlIEFENzE5NSBkb2N1bWVudGF0aW9uLCB0aGUgQUMg
ZXhjaXRhdGlvbiBlbmFibGUgYml0IGlzIG9uIHBvc2l0aW9uCj4gMjIgaW4gdGhlIENvbmZpZ3Vy
YXRpb24gcmVnaXN0ZXIuIEFDWCBtYWNybyBjaGFuZ2VkIHRvIG1hdGNoIGNvcnJlY3QKPiByZWdp
c3RlciBhbmQgYml0Lgo+IAo+IE5vdGUgdGhhdCB0aGUgZml4IHRhZyBpcyBmb3IgdGhlIGNvbW1p
dCB0aGF0IG1vdmVkIHRoZSBkcml2ZXIgb3V0IG9mCj4gc3RhZ2luZy4KPiAKPiBGaXhlczogYjU4
MWY3NDhjY2UwICgic3RhZ2luZzogaWlvOiBhZGM6IGFkNzE5MjogbW92ZSBvdXQgb2Ygc3RhZ2lu
ZyIpCj4gU2lnbmVkLW9mZi1ieTogQWxpc2EgUm9tYW4gPGFsaXNhLnJvbWFuQGFuYWxvZy5jb20+
Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KCkhpIEFsaXNhLAoKSSBzZWUgeW91
IGltcHJvdmVkIHRoZSBjb21taXQgbWVzc2FnZSB0byBleHBsYWluIHdoYXQncyBnb2luZyBvbiBi
dXQgeW91IHNob3VsZApoYXZlIHZlcnNpb25lZCB5b3VyIHBhdGNoZXMgYWNjb3JkaW5nbHkuIEFu
eXdheXMsIGRvbid0IGZvcmdldCB0byBkbyBpdCBuZXh0CnRpbWUgOikuIFlvdSBjb3VsZCBhbHNv
IG1lbnRpb24gdGhlIG5hbWUgY2hhbmdlIEFENzE5Ml9NT0RFX0FDWCAtPgpBRDcxOTJfQ09ORklH
X0FDWCBldmVuIHRob3VnaCBpdCdzIGEgYml0IG9idmlvdXMuIEFueXdheXM6CgpSZXZpZXdlZC1i
eTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgoKPiDCoGRyaXZlcnMvaWlvL2FkYy9hZDcx
OTIuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9h
ZDcxOTIuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+IGluZGV4IDg2ODVlMGI1OGE4My4u
N2JjM2ViZmU4MDgxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+ICsr
KyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+IEBAIC02Miw3ICs2Miw2IEBACj4gwqAjZGVm
aW5lIEFENzE5Ml9NT0RFX1NUQV9NQVNLwqDCoMKgQklUKDIwKSAvKiBTdGF0dXMgUmVnaXN0ZXIg
dHJhbnNtaXNzaW9uIE1hc2sKPiAqLwo+IMKgI2RlZmluZSBBRDcxOTJfTU9ERV9DTEtTUkMoeCnC
oMKgKCgoeCkgJiAweDMpIDw8IDE4KSAvKiBDbG9jayBTb3VyY2UgU2VsZWN0ICovCj4gwqAjZGVm
aW5lIEFENzE5Ml9NT0RFX1NJTkMzwqDCoMKgwqDCoMKgQklUKDE1KSAvKiBTSU5DMyBGaWx0ZXIg
U2VsZWN0ICovCj4gLSNkZWZpbmUgQUQ3MTkyX01PREVfQUNYwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBCSVQoMTQpIC8qIEFDIGV4Y2l0YXRpb24gZW5hYmxlKEFENzE5NQo+IG9ubHkp
Ki8KPiDCoCNkZWZpbmUgQUQ3MTkyX01PREVfRU5QQVLCoMKgwqDCoMKgwqBCSVQoMTMpIC8qIFBh
cml0eSBFbmFibGUgKi8KPiDCoCNkZWZpbmUgQUQ3MTkyX01PREVfQ0xLRElWwqDCoMKgwqDCoEJJ
VCgxMikgLyogQ2xvY2sgZGl2aWRlIGJ5IDIgKEFENzE5MC8yIG9ubHkpKi8KPiDCoCNkZWZpbmUg
QUQ3MTkyX01PREVfU0NZQ0xFwqDCoMKgwqDCoEJJVCgxMSkgLyogU2luZ2xlIGN5Y2xlIGNvbnZl
cnNpb24gKi8KPiBAQCAtOTEsNiArOTAsNyBAQAo+IMKgLyogQ29uZmlndXJhdGlvbiBSZWdpc3Rl
ciBCaXQgRGVzaWduYXRpb25zIChBRDcxOTJfUkVHX0NPTkYpICovCj4gwqAKPiDCoCNkZWZpbmUg
QUQ3MTkyX0NPTkZfQ0hPUMKgwqDCoMKgwqDCoMKgQklUKDIzKSAvKiBDSE9QIGVuYWJsZSAqLwo+
ICsjZGVmaW5lIEFENzE5Ml9DT05GX0FDWMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
QklUKDIyKSAvKiBBQyBleGNpdGF0aW9uIGVuYWJsZShBRDcxOTUKPiBvbmx5KSAqLwo+IMKgI2Rl
ZmluZSBBRDcxOTJfQ09ORl9SRUZTRUzCoMKgwqDCoMKgQklUKDIwKSAvKiBSRUZJTjEvUkVGSU4y
IFJlZmVyZW5jZSBTZWxlY3QgKi8KPiDCoCNkZWZpbmUgQUQ3MTkyX0NPTkZfQ0hBTih4KcKgwqDC
oMKgKCh4KSA8PCA4KSAvKiBDaGFubmVsIHNlbGVjdCAqLwo+IMKgI2RlZmluZSBBRDcxOTJfQ09O
Rl9DSEFOX01BU0vCoMKgKDB4N0ZGIDw8IDgpIC8qIENoYW5uZWwgc2VsZWN0IG1hc2sgKi8KPiBA
QCAtNDcyLDcgKzQ3Miw3IEBAIHN0YXRpYyBzc2l6ZV90IGFkNzE5Ml9zaG93X2FjX2V4Y2l0YXRp
b24oc3RydWN0IGRldmljZQo+ICpkZXYsCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYgPSBkZXZfdG9faWlvX2RldihkZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgYWQ3MTkyX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwgISEoc3QtPm1vZGUgJiBBRDcx
OTJfTU9ERV9BQ1gpKTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIl
ZFxuIiwgISEoc3QtPmNvbmYgJiBBRDcxOTJfQ09ORl9BQ1gpKTsKPiDCoH0KPiDCoAo+IMKgc3Rh
dGljIHNzaXplX3QgYWQ3MTkyX3Nob3dfYnJpZGdlX3N3aXRjaChzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4gQEAgLTUxMywxMyArNTEzLDEzIEBAIHN0YXRpYyBzc2l6ZV90IGFkNzE5Ml9zZXQoc3RydWN0
IGRldmljZSAqZGV2LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZF9z
ZF93cml0ZV9yZWcoJnN0LT5zZCwgQUQ3MTkyX1JFR19HUE9DT04sIDEsIHN0LT5ncG9jb24pOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKg
Y2FzZSBBRDcxOTJfUkVHX01PREU6Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBBRDcxOTJfUkVHX0NP
TkY6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodmFsKQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtPm1vZGUgfD0gQUQ3MTky
X01PREVfQUNYOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc3QtPmNvbmYgfD0gQUQ3MTkyX0NPTkZfQUNYOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZWxzZQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3QtPm1vZGUgJj0gfkFENzE5Ml9NT0RFX0FDWDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0LT5jb25mICY9IH5BRDcxOTJfQ09ORl9BQ1g7
Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRfc2Rfd3JpdGVfcmVnKCZz
dC0+c2QsIEFENzE5Ml9SRUdfTU9ERSwgMywgc3QtPm1vZGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBhZF9zZF93cml0ZV9yZWcoJnN0LT5zZCwgQUQ3MTkyX1JFR19DT05GLCAz
LCBzdC0+Y29uZik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiDC
oMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldCA9IC1FSU5WQUw7Cj4gQEAgLTU3OSwxMiArNTc5LDExIEBAIHN0YXRpYyBJSU9fREVWSUNF
X0FUVFIoYnJpZGdlX3N3aXRjaF9lbiwgMDY0NCwKPiDCoAo+IMKgc3RhdGljIElJT19ERVZJQ0Vf
QVRUUihhY19leGNpdGF0aW9uX2VuLCAwNjQ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFkNzE5Ml9zaG93X2FjX2V4Y2l0YXRpb24sIGFkNzE5Ml9zZXQs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBRDcxOTJfUkVH
X01PREUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUQ3
MTkyX1JFR19DT05GKTsKPiDCoAo+IMKgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmFkNzE5Ml9h
dHRyaWJ1dGVzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCZpaW9fZGV2X2F0dHJfZmlsdGVyX2xv
d19wYXNzXzNkYl9mcmVxdWVuY3lfYXZhaWxhYmxlLmRldl9hdHRyLmF0dHIsCj4gwqDCoMKgwqDC
oMKgwqDCoCZpaW9fZGV2X2F0dHJfYnJpZGdlX3N3aXRjaF9lbi5kZXZfYXR0ci5hdHRyLAo+IC3C
oMKgwqDCoMKgwqDCoCZpaW9fZGV2X2F0dHJfYWNfZXhjaXRhdGlvbl9lbi5kZXZfYXR0ci5hdHRy
LAo+IMKgwqDCoMKgwqDCoMKgwqBOVUxMCj4gwqB9Owo+IMKgCj4gQEAgLTU5NSw2ICs1OTQsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBhZDcxOTJfYXR0cmlidXRlX2dy
b3VwCj4gPSB7Cj4gwqBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqYWQ3MTk1X2F0dHJpYnV0ZXNb
XSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgJmlpb19kZXZfYXR0cl9maWx0ZXJfbG93X3Bhc3NfM2Ri
X2ZyZXF1ZW5jeV9hdmFpbGFibGUuZGV2X2F0dHIuYXR0ciwKPiDCoMKgwqDCoMKgwqDCoMKgJmlp
b19kZXZfYXR0cl9icmlkZ2Vfc3dpdGNoX2VuLmRldl9hdHRyLmF0dHIsCj4gK8KgwqDCoMKgwqDC
oMKgJmlpb19kZXZfYXR0cl9hY19leGNpdGF0aW9uX2VuLmRldl9hdHRyLmF0dHIsCj4gwqDCoMKg
wqDCoMKgwqDCoE5VTEwKPiDCoH07Cj4gwqAKCg==

