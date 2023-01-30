Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE56805EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjA3GRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA3GR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:17:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EE24C8C;
        Sun, 29 Jan 2023 22:17:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mf7so9961153ejc.6;
        Sun, 29 Jan 2023 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7rK3vQ2htRQ1Q11HASgdV9Y9x1Ww70EwQDSvH029+4=;
        b=OLzAKikzFDM0Bta/uPdZW1pZVj0KmmFdA7B8WSgGJPHd3WzqsCJNQNMasNCPfrH1Fs
         x4UPQusuEbZAklFcWMD/Tkp6xrMIZV3fttvPlJiTlNTREstC927Ossp9EmmDAaACQ2CA
         tH3yR59+SwAf3OJYE2w8//yuEjnvhV/GENTa/NhKo1B+uqEZz8XZTD9cV6T6hGtugRFc
         kNQxuH3+xv65hdczV31fgCZDY0DtRFwLI83jFd5yBppA35Z8Kvz+1SF+o3ZJ6fPhTUxD
         MxfHHEWK++Lgtu7lQJ+Qdfx213BVkyDYCOOl/sGMcjfKuv1fu/xs63ChdKn0tp3woejk
         hEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7rK3vQ2htRQ1Q11HASgdV9Y9x1Ww70EwQDSvH029+4=;
        b=6dNLQapjnZkgxs5wrxCv/MMhYeowf3ZjinPLDUBT0xfA9VUndqq52SmB6fZMv4v3s3
         IPM2PHz1gk0/QM4IJHj8qMxAoBb+drASlx8aS63FOtE2DrWk9xUIav1ffBq+zQKiEY6h
         e0GqWCx7va2iIiBLsKXCBVljLJQ53MoEEPT8KyBucZrLjGYxKp/+dy3MgPovUk+0Ztni
         QPCwcYn+DESj4OIdS20+BGsCCPXmY1BSSZz+TGk5wORWYPuCah7H86ldXzwwfb5Wbbjh
         ZuXbgLYjkSvekRlkZkZu33/IsTHiBnMT+9TubPzb4mEmow/5U9KF2FA7zByIhn97VCQK
         iApA==
X-Gm-Message-State: AO0yUKX8lTvZzjYRTMV/HYbqr4eGoth8gA+pstsIqPjvDXVKjqmbMYBl
        3whc/A/ssY8OTuvGjxQt0P0=
X-Google-Smtp-Source: AK7set/2Zrn31J0wmnFpf3XeNa3OBumAmPD7+Xxss0QB4LG7+uCsw3ColYVLSX8vXrfqb2JjqIcqtA==
X-Received: by 2002:a17:906:6c87:b0:87b:59d9:5a03 with SMTP id s7-20020a1709066c8700b0087b59d95a03mr10909226ejr.36.1675059447283;
        Sun, 29 Jan 2023 22:17:27 -0800 (PST)
Received: from sakura.myxoz.lan (90-224-45-44-no2390.tbcn.telia.com. [90.224.45.44])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906594e00b00857c2c29553sm6385095ejr.197.2023.01.29.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:17:26 -0800 (PST)
Message-ID: <49bcd14a3a940a0a9000c2d59b3319cd237215fe.camel@gmail.com>
Subject: Re: [PATCH] Input: exc3000 - properly stop timer on shutdown
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Stahl, Michael" <mstahl@moba.de>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 30 Jan 2023 07:17:25 +0100
In-Reply-To: <Y9dK57BFqtlf8NmN@google.com>
References: <Y9dK57BFqtlf8NmN@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
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

T24gU3VuLCAyMDIzLTAxLTI5IGF0IDIwOjQzIC0wODAwLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6
Cj4gV2UgbmVlZCB0byBzdG9wIHRoZSB0aW1lciBvbiBkcml2ZXIgdW5iaW5kIG9yIHByb2JlIGZh
aWx1cmVzLAo+IG90aGVyd2lzZQo+IHdlIGdldCBVQUYvT29wcy4KPiAKPiBGaXhlczogN2U1Nzdh
MTdmMmVlICgiSW5wdXQ6IGFkZCBJMkMgYXR0YWNoZWQgRUVUSSBFWEMzMDAwIG11bHRpCj4gdG91
Y2ggZHJpdmVyIikKPiBSZXBvcnRlZC1ieTogIlN0YWhsLCBNaWNoYWVsIiA8bXN0YWhsQG1vYmEu
ZGU+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21h
aWwuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9leGMzMDAwLmMgfCAx
MCArKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2V4YzMwMDAuYwo+IGIvZHJpdmVy
cy9pbnB1dC90b3VjaHNjcmVlbi9leGMzMDAwLmMKPiBpbmRleCA0YjdlZWUwMWM2YWEuLjY5ZWFl
NzllMjA4NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2V4YzMwMDAu
Ywo+ICsrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZXhjMzAwMC5jCj4gQEAgLTEwOSw2
ICsxMDksMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIGV4YzMwMDBfc2NoZWR1bGVfdGltZXIoc3Ry
dWN0Cj4gZXhjMzAwMF9kYXRhICpkYXRhKQo+IMKgwqDCoMKgwqDCoMKgwqBtb2RfdGltZXIoJmRh
dGEtPnRpbWVyLCBqaWZmaWVzICsKPiBtc2Vjc190b19qaWZmaWVzKEVYQzMwMDBfVElNRU9VVF9N
UykpOwo+IMKgfQo+IMKgCj4gK3N0YXRpYyB2b2lkIGV4YzMwMDBfc2h1dGRvd25fdGltZXIodm9p
ZCAqdGltZXIpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB0aW1lcl9zaHV0ZG93bl9zeW5jKHRpbWVy
KTsKPiArfQo+ICsKPiDCoHN0YXRpYyBpbnQgZXhjMzAwMF9yZWFkX2ZyYW1lKHN0cnVjdCBleGMz
MDAwX2RhdGEgKmRhdGEsIHU4ICpidWYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQgPSBkYXRhLT5jbGllbnQ7Cj4gQEAgLTM4Niw2ICszOTEsMTEgQEAg
c3RhdGljIGludCBleGMzMDAwX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50Cj4gKmNsaWVudCkKPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKGVycm9yKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGVycm9yOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgZXJyb3IgPSBkZXZtX2FkZF9h
Y3Rpb25fb3JfcmVzZXQoJmNsaWVudC0+ZGV2LAo+IGV4YzMwMDBfc2h1dGRvd25fdGltZXIsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZGF0YS0+dGltZXIpOwo+ICvCoMKgwqDCoMKgwqDCoGlm
IChlcnJvcikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycm9yOwo+
ICsKPiDCoMKgwqDCoMKgwqDCoMKgZXJyb3IgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCZj
bGllbnQtPmRldiwgY2xpZW50LT5pcnEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxM
LCBleGMzMDAwX2ludGVycnVwdCwKPiBJUlFGX09ORVNIT1QsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjbGllbnQtPm5hbWUsIGRhdGEpOwo+IC0tIAo+IDIuMzkuMS40NTYuZ2ZjNTQ5N2Rk
MWItZ29vZwo+IAo+IAoKVGhpcyBzaG91bGQgcHJvYmFibHkgYmUgQ2MnZWQgdG8gdGhlIHN0YWJs
ZSBtYWlsaW5nIGxpc3QuCi0tIAp+bWlrbwo=

