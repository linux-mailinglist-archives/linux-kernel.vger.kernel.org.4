Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B165A9B1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 12:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAALJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 06:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjAALJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 06:09:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E56177;
        Sun,  1 Jan 2023 03:09:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l26so16792435wme.5;
        Sun, 01 Jan 2023 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5PT8q9BxmBpzjhbUsqPnpb+0zMREfMJNYd0Y1lM8e8=;
        b=fIj7I5D4IRn7p+KGxQY9FI6KOOZaTS+kio1/Q5hNgKVzNgKQs7S+s0c8AS/XWoX6Y0
         yYfQC46/mvfC9XZFFkjVHcyDyA8iKuaPeS+aGRksLaPDnYwg99Jy+RHh6cJ+r90M9AZ2
         ak8TEVYm7beWCuJhkcSjYX9LQNOWuw716ih7/1LTkGL/qXjwQKwn8CQJ0GUDEsRWBRZP
         Redp6ovsDSd5rbozT6NDz2lTac6c1jiFchtgSq/mY71hxRSriEccqkLB3taXRsnL2RRu
         VK1djaIXyCnVJG28NcrjbKBG1wA+ltUgppwdXXrZH9g0EtItZngPBeo76cvtMHZIqHVw
         5w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5PT8q9BxmBpzjhbUsqPnpb+0zMREfMJNYd0Y1lM8e8=;
        b=e0P35g7arFSCYKVfSuZPTSusov+P5fnSHhfH+X+v0hybSBEcd1JjdDOcaXVBHCh6HP
         sPk+b0jIPcYET1GcuJ8kts+jkrPrdhlyG9FtJSr8LP+foJKcDxrBqoMusk54HwWWN8Pm
         BbLHMnEwjC4ST+r2OZqs1LX9J0hEC3uNbh3DIJGY5erQy67a562NbmJKkfjmCJNFXQjY
         1QXcWkPNIa+d5l4zoZL8xHWHGeUZq5C/xugldsr6JJpMrQFZgPHa5iNGDqf8wQwV80Vn
         ESaENut8lr2Fl+5eMC/HjDbQnT7ysyhzaXixiWGTe+rr1IHRochunYN3A+JstC0i5rsF
         nx8w==
X-Gm-Message-State: AFqh2krCSiY4OldliUAJ/VHrfS/E5DwwlM0DvqbRXEdNbqN1bOESa6+G
        guL5kteJUoAncuWnidvnIUgXozY0fM8=
X-Google-Smtp-Source: AMrXdXvhUTRGyN7tu1CC8JDlHkNZNkArT47HdE2XJJk6hcK5yi6Wf+ZWV/0OVa6mMVQ90kjiXMgucg==
X-Received: by 2002:a05:600c:ace:b0:3d1:fe0a:f134 with SMTP id c14-20020a05600c0ace00b003d1fe0af134mr26566718wmr.19.1672571364600;
        Sun, 01 Jan 2023 03:09:24 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003cfd4e6400csm37758452wms.19.2023.01.01.03.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 03:09:24 -0800 (PST)
Message-ID: <c8e312d7584a0c4d42264a2dbeeccb9adb676dd6.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: pressure: bmp280: Add preinit callback
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Jan 2023 12:09:23 +0100
In-Reply-To: <20221230181839.43191be2@jic23-huawei>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
         <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
         <20221230181839.43191be2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTMwIGF0IDE4OjE4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIE1vbiwgMjYgRGVjIDIwMjIgMTU6Mjk6MjEgKzAxMDAKPiBBbmdlbCBJZ2xlc2lhcyA8
YW5nLmlnbGVzaWFzZ0BnbWFpbC5jb20+IHdyb3RlOgo+IAo+ID4gQWRkcyBwcmVpbml0IGNhbGxi
YWNrIHRvIGV4ZWN1dGUgb3BlcmF0aW9ucyBvbiBwcm9iZSBiZWZvcmUgYXBwbHlpbmcKPiA+IGlu
aXRpYWwgY29uZmlndXJhdGlvbi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWwgSWdsZXNp
YXMgPGFuZy5pZ2xlc2lhc2dAZ21haWwuY29tPgo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vcHJlc3N1cmUvYm1wMjgwLWNvcmUuYwo+ID4gYi9kcml2ZXJzL2lpby9wcmVzc3VyZS9i
bXAyODAtY29yZS5jCj4gPiBpbmRleCA0Njk1OWE5MTQwOGYuLmMzN2NmMmNhZWM2OCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvaWlvL3ByZXNzdXJlL2JtcDI4MC1jb3JlLmMKPiA+ICsrKyBiL2Ry
aXZlcnMvaWlvL3ByZXNzdXJlL2JtcDI4MC1jb3JlLmMKPiA+IEBAIC0yMTcsNiArMjE3LDcgQEAg
c3RydWN0IGJtcDI4MF9jaGlwX2luZm8gewo+ID4gwqDCoMKgwqDCoMKgwqDCoGludCAoKnJlYWRf
cHJlc3MpKHN0cnVjdCBibXAyODBfZGF0YSAqLCBpbnQgKiwgaW50ICopOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoGludCAoKnJlYWRfaHVtaWQpKHN0cnVjdCBibXAyODBfZGF0YSAqLCBpbnQgKiwgaW50
ICopOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGludCAoKnJlYWRfY2FsaWIpKHN0cnVjdCBibXAyODBf
ZGF0YSAqKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCAoKnByZWluaXQpKHN0cnVjdCBibXAyODBf
ZGF0YSAqKTsKPiA+IMKgfTsKPiA+IMKgCj4gPiDCoC8qCj4gPiBAQCAtOTM1LDYgKzkzNiw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYm1wMjgwX2NoaXBfaW5mbyBibXAyODBfY2hpcF9pbmZvID0K
PiA+IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqAucmVhZF90ZW1wID0gYm1wMjgwX3JlYWRfdGVtcCwK
PiA+IMKgwqDCoMKgwqDCoMKgwqAucmVhZF9wcmVzcyA9IGJtcDI4MF9yZWFkX3ByZXNzLAo+ID4g
wqDCoMKgwqDCoMKgwqDCoC5yZWFkX2NhbGliID0gYm1wMjgwX3JlYWRfY2FsaWIsCj4gPiArwqDC
oMKgwqDCoMKgwqAucHJlaW5pdCA9IE5VTEwsCj4gQyBzdGFuZGFyZCBndWFyYW50ZWVzIHRob3Nl
IGFyZSBzZXQgdG8gTlVMTCBhbnl3YXkgKyB0aGUgZGVmYXVsdCBpcyBvYnZpb3VzLgo+IEhlbmNl
IGRvbid0IHNldCB0aGVtIHRvIE5VTEwsIGp1c3QgbGVhdmUgdGhlIGF1dG9tYXRpYyBpbml0aWFs
aXphdGlvbiBvZgo+IHVuc3BlY2lmaWVkIHN0cnVjdHVyZSBlbGVtZW50cyB0byBoYW5kbGUgaXQg
Zm9yIHlvdS4KCk9LISBOb3RlIHRvIHNlbGY6IGNvbXBpbGVyIGtub3dzIGJlc3QhCgo+ID4gwqB9
Owo+ID4gwqAKPiA+IMKgc3RhdGljIGludCBibWUyODBfY2hpcF9jb25maWcoc3RydWN0IGJtcDI4
MF9kYXRhICpkYXRhKQo+ID4gQEAgLTk3OSw2ICs5ODEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGJtcDI4MF9jaGlwX2luZm8gYm1lMjgwX2NoaXBfaW5mbyA9Cj4gPiB7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgLnJlYWRfcHJlc3MgPSBibXAyODBfcmVhZF9wcmVzcywKPiA+IMKgwqDCoMKgwqDCoMKg
wqAucmVhZF9odW1pZCA9IGJtcDI4MF9yZWFkX2h1bWlkLAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5y
ZWFkX2NhbGliID0gYm1lMjgwX3JlYWRfY2FsaWIsCj4gPiArwqDCoMKgwqDCoMKgwqAucHJlaW5p
dCA9IE5VTEwsCj4gPiDCoH07Cj4gPiDCoAo+ID4gwqAvKgo+ID4gQEAgLTEyMjAsNiArMTIyMywx
MiBAQCBzdGF0aWMgY29uc3QgaW50IGJtcDM4MF9vZHJfdGFibGVbXVsyXSA9IHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBbQk1QMzgwX09EUl8wXzAwMTVIWl3CoMKgwqA9IHswLCAxNTI2fSwKPiA+IMKg
fTsKPiA+IMKgCj4gPiArc3RhdGljIGludCBibXAzODBfcHJlaW5pdChzdHJ1Y3QgYm1wMjgwX2Rh
dGEgKmRhdGEpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgLyogQk1QM3h4IHJlcXVpcmVzIHNv
ZnQtcmVzZXQgYXMgcGFydCBvZiBpbml0aWFsaXphdGlvbiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIGJtcDM4MF9jbWQoZGF0YSwgQk1QMzgwX0NNRF9TT0ZUX1JFU0VUKTsKPiA+ICt9Cj4g
PiArCj4gPiDCoHN0YXRpYyBpbnQgYm1wMzgwX2NoaXBfY29uZmlnKHN0cnVjdCBibXAyODBfZGF0
YSAqZGF0YSkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgY2hhbmdlID0gZmFsc2Us
IGF1eDsKPiA+IEBAIC0xMzQ5LDYgKzEzNTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGJtcDI4
MF9jaGlwX2luZm8gYm1wMzgwX2NoaXBfaW5mbwo+ID4gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
LnJlYWRfdGVtcCA9IGJtcDM4MF9yZWFkX3RlbXAsCj4gPiDCoMKgwqDCoMKgwqDCoMKgLnJlYWRf
cHJlc3MgPSBibXAzODBfcmVhZF9wcmVzcywKPiA+IMKgwqDCoMKgwqDCoMKgwqAucmVhZF9jYWxp
YiA9IGJtcDM4MF9yZWFkX2NhbGliLAo+ID4gK8KgwqDCoMKgwqDCoMKgLnByZWluaXQgPSBibXAz
ODBfcHJlaW5pdCwKPiA+IMKgfTsKPiA+IMKgCj4gPiDCoHN0YXRpYyBpbnQgYm1wMTgwX21lYXN1
cmUoc3RydWN0IGJtcDI4MF9kYXRhICpkYXRhLCB1OCBjdHJsX21lYXMpCj4gPiBAQCAtMTYwNCw2
ICsxNjE0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBibXAyODBfY2hpcF9pbmZvIGJtcDE4MF9j
aGlwX2luZm8KPiA+ID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoC5yZWFkX3RlbXAgPSBibXAxODBf
cmVhZF90ZW1wLAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5yZWFkX3ByZXNzID0gYm1wMTgwX3JlYWRf
cHJlc3MsCj4gPiDCoMKgwqDCoMKgwqDCoMKgLnJlYWRfY2FsaWIgPSBibXAxODBfcmVhZF9jYWxp
YiwKPiA+ICvCoMKgwqDCoMKgwqDCoC5wcmVpbml0ID0gTlVMTCwKPiA+IMKgfTsKPiA+IMKgCj4g
PiDCoHN0YXRpYyBpcnFyZXR1cm5fdCBibXAwODVfZW9jX2lycShpbnQgaXJxLCB2b2lkICpkKQo+
ID4gQEAgLTE3NjIsOSArMTc3MywxMyBAQCBpbnQgYm1wMjgwX2NvbW1vbl9wcm9iZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RUlOVkFMOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqAv
KiBCTVAzeHggcmVxdWlyZXMgc29mdC1yZXNldCBhcyBwYXJ0IG9mIGluaXRpYWxpemF0aW9uICov
Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoY2hpcF9pZCA9PSBCTVAzODBfQ0hJUF9JRCkgewo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGJtcDM4MF9jbWQoZGF0YSwgQk1Q
MzgwX0NNRF9TT0ZUX1JFU0VUKTsKPiA+ICvCoMKgwqDCoMKgwqDCoC8qCj4gPiArwqDCoMKgwqDC
oMKgwqAgKiBTb21lIGNoaXBzIGxpa2UgdGhlIEJNUDN4eCBoYXZlIHByZWluaXQgdGFza3MgdG8g
cnVuCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBiZWZvcmUgYXBwbHlpbmcgdGhlIGluaXRpYWwgY29u
ZmlndXJhdGlvbi4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+IEkgd291bGQgZHJvcCB0aGlzIGNv
bW1lbnQuIEl0J3Mga2luZCBvZiBvYnZpb3VzIHRoYXQgc29tZSBkZXZpY2VzIG5lZWQgeW91Cj4g
dG8gY2FsbCBzb21ldGhpbmcgaGVyZSAtIG90aGVyd2lzZSB3aHkgaGF2ZSB0aGUgY2xlYXJseSBv
cHRpb25hbCBjYWxsYmFjaz8KPiBUaGUgc3BlY2lmaWMgQk1QM3h4IHJlcXVpcmVtZW50cyBhcmUg
d2VsbCBjb21tZW50ZWQgaW4geW91ciBuZXcgY2FsbGJhY2sgYWJvdmUKPiBzbyBkb24ndCB3YW50
IHRvIGJlIGhlcmUgYXMgd2VsbC4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChkYXRhLT5jaGlw
X2luZm8tPnByZWluaXQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQg
PSBkYXRhLT5jaGlwX2luZm8tPnByZWluaXQoZGF0YSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJlcnJvciBydW5uaW5nIHByZWluaXQgdGFza3MiKTsK
PiAKPiBFcnJvciBtZXNzYWdlIHByaW50ZWQgb24gc3VjY2Vzcy4uLgoKWXVwLCBzb3JyeSBhYm91
dCB0aGF0Li4uCgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0
IDwgMCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiByZXQ7Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJlcnJvciBydW5uaW5nIHBy
ZWluaXQKPiB0YXNrcyIpOwo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiAKVGhhbmtzIGZvciB5
b3VyIHRpbWUhCkFuZ2VsCg==

