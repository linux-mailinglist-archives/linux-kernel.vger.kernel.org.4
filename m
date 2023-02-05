Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E201668B2E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBEXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:39:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512F199E5;
        Sun,  5 Feb 2023 15:39:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso7575724wms.3;
        Sun, 05 Feb 2023 15:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9NAil0WJwzTC1czQfG48SHPcwzSUnGRlyuzIVecGHpE=;
        b=d9EtlRDOo2FcRbze9aQ4+HaCITIzt62qxPX4OAxL8/Mx786zCJv/8PnXG+K9JZA8Vz
         VufmRfz1oIApFzRp8bWsqBSPfT/7N/mcrFxgo3z65COI36cvvC2Is8EBadc2w/GYbLqq
         Dk86s3B4n3f47sOtjH/owf5KPAvB7JjoyW3jN5E2Q38FqVF6S3itIBLU9JtO23MM16VT
         nQvfSBwa7A/Reo7xPtQt38G/oo56ytQz15K3hlaRmlileG3pkNOC5JyWlbHGt50iltsT
         2scSPFrgwQ2eAY/yW8rfRBWZcDnPeKbTQ1JDZsdp0d9xgQ8OowCxEvLv+D9sc7FiKjBW
         gD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NAil0WJwzTC1czQfG48SHPcwzSUnGRlyuzIVecGHpE=;
        b=EnL0Y6JybxKfO/3PaUO5LcBImwBV9ZfI/aVPLXdO9fcyWvVHBwOUV8tDIO3sKDOlPR
         MI/hXezfXnAnSGwZw1PlH6H5KGGiy9YHB1mincbdp8bBXHodG/LTmVDp5OPQyrbBKuKp
         DDw78xaNnIbS6FCZmdsa9TyZk3DYaggcrxlXZYeGDoalQ7IyYjEZC6s76vjPzjPikTns
         m7/4RFn4uydLY5zYarArJ6lfoGxRq/XXx4FePyvbbiqIqJEXJ+MgecXJNQGW2ndKdNNS
         SYnLlKsFCMsQWLFxyU6UMjtTIRXoEDwOnCrV6MP/z5M7rSvRN/eL8bdz3O3A9qDjgnq2
         93dg==
X-Gm-Message-State: AO0yUKUifWZtpp41EY4nl4d+HVZVk+TR/yK60KXXD4UKXyj0EhRxuvK3
        tFB/uVwIjMahpJbNo5VAAQY=
X-Google-Smtp-Source: AK7set/dwnSveZT2Kk+W0ykb3rkJzTCbeyrSC4jCS4sn7Dv7v8jSEjfDiRdRLj5ZB5FIs3Ohjacovw==
X-Received: by 2002:a05:600c:45cd:b0:3df:e57d:f4ba with SMTP id s13-20020a05600c45cd00b003dfe57df4bamr12956045wmo.7.1675640350485;
        Sun, 05 Feb 2023 15:39:10 -0800 (PST)
Received: from DreamMachine2.lan (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003db06493ee7sm15832423wmb.47.2023.02.05.15.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:39:10 -0800 (PST)
Message-ID: <d0ed98480b600c48c36b45b84dd21285b021ee9b.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] iio: pressure: bmp280: Add support for new
 sensor BMP580
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Feb 2023 00:39:08 +0100
In-Reply-To: <20230205145331.1d67b5e6@jic23-huawei>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
         <97a234ddac057eea1e6790d7fa4a66564abec2ed.1674954271.git.ang.iglesiasg@gmail.com>
         <20230205145331.1d67b5e6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (by Flathub.org) 
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

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE0OjUzICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIFN1biwgMjkgSmFuIDIwMjMgMDI6MzM6MDcgKzAxMDAKPiBBbmdlbCBJZ2xlc2lhcyA8
YW5nLmlnbGVzaWFzZ0BnbWFpbC5jb20+IHdyb3RlOgo+IAo+ID4gQWRkcyBjb21wYXRpYmlsaXR5
IHdpdGggdGhlIG5ldyBzZW5zb3IgZ2VuZXJhdGlvbiwgdGhlIEJNUDU4MC4KPiA+IAo+ID4gVGhl
IG1lYXN1cmVtZW50IGFuZCBpbml0aWFsaXphdGlvbiBjb2RlcGF0aHMgYXJlIGFkYXB0ZWQgZnJv
bQo+ID4gdGhlIGRldmljZSBkYXRhc2hlZXQgYW5kIHRoZSByZXBvc2l0b3J5IGZyb20gbWFudWZh
Y3R1cmVyIGF0Cj4gPiBodHRwczovL2dpdGh1Yi5jb20vYm9zY2hzZW5zb3J0ZWMvQk1QNS1TZW5z
b3ItQVBJLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbCBJZ2xlc2lhcyA8YW5nLmlnbGVz
aWFzZ0BnbWFpbC5jb20+Cj4gPiAKPiAKPiBIaSBBbmdlbCwKPiAKPiBBcyB5b3UgYXJlIGRvaW5n
IG9uZSBtb3JlIHZlcnNpb24gYW55d2F5LCBhIGZldyByZWFsbHkgbWlub3IgY29tbWVudHMgaW5s
aW5lLgo+IAo+IFRoYW5rcywKPiAKPiBKb25hdGhhbgo+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL3ByZXNzdXJlL2JtcDI4MC1jb3JlLmMKPiA+IGIvZHJpdmVycy9paW8vcHJlc3N1cmUv
Ym1wMjgwLWNvcmUuYwo+ID4gaW5kZXggMjJhZGRhYWE1MzkzLi5jNjVmYjQwMjVhZDkgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9wcmVzc3VyZS9ibXAyODAtY29yZS5jCj4gPiArKysgYi9k
cml2ZXJzL2lpby9wcmVzc3VyZS9ibXAyODAtY29yZS5jCj4gCj4gPiDCoC8qCj4gPiDCoCAqIFRo
ZXNlIGVudW1zIGFyZSB1c2VkIGZvciBpbmRleGluZyBpbnRvIHRoZSBhcnJheSBvZiBjb21wZW5z
YXRpb24KPiA+IMKgICogcGFyYW1ldGVycyBmb3IgQk1QMjgwLgo+ID4gQEAgLTEyMTYsNiArMTI1
MiwzMDMgQEAgY29uc3Qgc3RydWN0IGJtcDI4MF9jaGlwX2luZm8gYm1wMzgwX2NoaXBfaW5mbyA9
IHsKPiA+IMKgfTsKPiA+IMKgRVhQT1JUX1NZTUJPTF9OUyhibXAzODBfY2hpcF9pbmZvLCBJSU9f
Qk1QMjgwKTsKPiA+IMKgCj4gPiArLyoKPiA+ICsgKiBCTVA1eHggc29mdCByZXNldCBwcm9jZWR1
cmUKPiAKPiBXaWxkIGNhcmRzIGFyZSBvZnRlbiBhIGJhZCBpZGVhLCBldmVuIGluIGNvbW1lbnRz
LsKgIFRlbmQgdG8gZW5kIHVwIGNvdmVyaW5nCj4gc29tZSBkZXZpY2UgdGhhdCB3b3JrcyBkaWZm
ZXJlbnRseS7CoCBXaXRoIHRoYXQgaW4gbWluZCwgbm90IHN1cmUgdGhpcyBjb21tZW50Cj4gYWRk
cyBhbnl0aGluZyBvdmVyIHRoZSBmdW5jdGlvbiBuYW1lLgo+IAo+ID4gKyAqLwo+ID4gK3N0YXRp
YyBpbnQgYm1wNTgwX3NvZnRfcmVzZXQoc3RydWN0IGJtcDI4MF9kYXRhICpkYXRhKQo+ID4gK3sK
PiA+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCByZWc7Cj4gPiArwqDCoMKgwqDCoMKgwqBp
bnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyogV3JpdGUgcmVzZXQgd29yZCB0byBD
TUQgcmVnaXN0ZXIgKi8KPiBOb3QgdGhhdCBpbmZvcm1hdGl2ZSBhcyBjb21tZW50cyBnby4KClVu
ZGVyc3Rvb2QhCgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX3dyaXRlKGRhdGEt
PnJlZ21hcCwgQk1QNTgwX1JFR19DTUQsCj4gPiBCTVA1ODBfQ01EX1NPRlRfUkVTRVQpOwo+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRldl9lcnIoZGF0YS0+ZGV2LCAiZmFpbGVkIHRvIHNlbmQgcmVzZXQgY29tbWFuZCB0bwo+
ID4gZGV2aWNlXG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Owo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgLyogV2FpdCAybXMg
Zm9yIHJlc2V0IGNvbXBsZXRpb24gKi8KPiBub3IgaXMgdGhpcyBvbmUgLSBkcm9wIHRoZW0gYm90
aC4KPiA+ICvCoMKgwqDCoMKgwqDCoHVzbGVlcF9yYW5nZSgyMDAwLCAyNTAwKTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoC8qIER1bW15IHJlYWQgb2YgY2hpcF9pZCAqLwo+IE5vdyB0aGlzIG9u
ZSBpcyBnb29kIGFzIG5vdCBvYnZpb3VzIHdoeSByZWFkIGlzIGhlcmUgc28ga2VlcCBpdCEKPiA+
ICvCoMKgwqDCoMKgwqDCoHJldCA9IHJlZ21hcF9yZWFkKGRhdGEtPnJlZ21hcCwgQk1QNTgwX1JF
R19DSElQX0lELCAmcmVnKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRhdGEtPmRldiwgImZhaWxlZCB0byBy
ZWVzdGFibGlzaCBjb21tcyBhZnRlcgo+ID4gcmVzZXRcbiIpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqAvKiBDaGVjayBpZiBQT1IgYml0IGlzIHNldCBvbiBpbnRlcnJ1cHQg
cmVnICovCj4gTm90IHN1cmUgdGhlIGNvbW1lbnQgYWRkcyBhbnl0aGluZyBub3Qgb2J2aW91c2x5
IGZyb20gY29kZS7CoCBJJ2QgYmUgaW5jbGluZWQKPiB0byBkcm9wIGl0Lgo+ID4gK8KgwqDCoMKg
wqDCoMKgcmV0ID0gcmVnbWFwX3JlYWQoZGF0YS0+cmVnbWFwLCBCTVA1ODBfUkVHX0lOVF9TVEFU
VVMsICZyZWcpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGF0YS0+ZGV2LCAiZXJyb3IgcmVhZGluZyBpbnRl
cnJ1cHQgc3RhdHVzCj4gPiByZWdpc3RlclxuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKg
wqDCoGlmICghKHJlZyAmIEJNUDU4MF9JTlRfU1RBVFVTX1BPUl9NQVNLKSkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGF0YS0+ZGV2LCAiZXJyb3IgcmVzZXR0
aW5nIHNlbnNvclxuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IC1FSU5WQUw7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKPiA+ICt9Cj4gPiArCj4gPiArLyoKPiA+ICsgKiBDb250cmFyeSB0byBwcmV2aW91
cyBzZW5zb3JzIGZhbWlsaWVzLCBjb21wZW5zYXRpb24gYWxnb3JpdGhtIGlzCj4gPiBidWlsdGlu
Lgo+ID4gKyAqIFdlIGFyZSBvbmx5IHJlcXVpcmVkIHRvIHJlYWQgdGhlIHJlZ2lzdGVyIHJhdyBk
YXRhIGFuZCBhZGFwdCB0aGUgcmFuZ2VzCj4gPiArICogZm9yIHdoYXQgaXMgZXhwZWN0ZWQgb24g
SUlPIEFCSS4KPiA+ICsgKi8KPiA+ICsKPiA+ICtzdGF0aWMgaW50IGJtcDU4MF9yZWFkX3RlbXAo
c3RydWN0IGJtcDI4MF9kYXRhICpkYXRhLCBpbnQgKnZhbCkKPiA+ICt7Cj4gPiArwqDCoMKgwqDC
oMKgwqBzMzIgcmF3X3RlbXA7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChkYXRhLT5yZWdtYXAsIEJNUDU4
MF9SRUdfVEVNUF9YTFNCLCBkYXRhLQo+ID4gPmJ1ZiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihkYXRhLT5idWYp
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXZfZXJyKGRhdGEtPmRldiwgImZhaWxlZCB0byByZWFkIHRlbXBlcmF0dXJl
XG4iKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4g
K8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmF3X3RlbXAgPSBnZXRf
dW5hbGlnbmVkX2xlMjQoZGF0YS0+YnVmKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYXdfdGVt
cCA9PSBCTVA1ODBfVEVNUF9TS0lQUEVEKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2X2VycihkYXRhLT5kZXYsICJyZWFkaW5nIHRlbXBlcmF0dXJlIHNraXBwZWRcbiIp
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlPOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKg
wqDCoCAqIFRlbXBlcmF0dXJlIGlzIHJldHVybmVkIGluIENlbHNpdXMgZGVncmVlcyBpbiBmcmFj
dGlvbmFsCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBmb3JtIGRvd24gMl4xNi4gV2UgcmVlc2NhbGUg
YnkgeDEwMDAgdG8gcmV0dXJuIG1pbGxpIENlbHNpdXMKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHRv
IHJlc3BlY3QgSUlPIEFCSS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDC
oMKgKnZhbCA9IChyYXdfdGVtcCAqIDEwMDApID4+IDE2Owo+IAo+IFdoeSBub3QgdXNlIElJT19W
QUxfRlJBQ1RJT05fTE9HMiBhbmQga2VlcCB0aGUgcHJlY2lzaW9uPwoKQWx0aG91Z2ggdGhpcyBz
ZW5zb3IgaGFzIGEgcmVzb2x1dGlvbiBvZiAxLzJeMTYsIGl0cyBhYnNvbHV0ZSBhY2N1cmFjeSBp
cyBvZgorLy0gMC41wrpDIHNvIEkgc3VwcG9zZSBpbiB0aGUgZW5kIHdlIGFyZW4ndCByZWFsbHkg
bG9zaW5nIHByZWNpc2lvbi4gQnV0IGluIHRoZQpmdXR1cmUgYSBoaWdoIGFjY3VyYWN5IHZhcmlh
bnQgb2YgdGhlIHNlbnNvciBtaWdodCBwb3AgdXAgKGxpa2UgdGhlIGJtcDM4NCBpbgp0aGUgcHJl
dmlvdXMgZ2VuKSBzbyBJIHRoaW5rIGlzIGEgZ29vZCBpZGVhIHRvIGtlZXAgdGhlIHByZWNpc2lv
bi4gVGhhbmtzIGZvcgp0aGUgaGVhZHMgdXAhCgo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIElJ
T19WQUxfSU5UOwo+ID4gK30KPiAKPiAKVGhhbmtzIGZvciB5b3VyIHRpbWUhCkFuZ2VsCgo=

