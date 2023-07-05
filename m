Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8074805E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGEJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:03:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BE10FB;
        Wed,  5 Jul 2023 02:03:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so104020151fa.1;
        Wed, 05 Jul 2023 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688547825; x=1691139825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Sulw2g3PMm/3FrSz/QYnyj8lRHAo71cCYrKZqBOx5k=;
        b=qzYKXX8uGRCnxOM21RDqV4Nog/XcNiUITIdY4fzKB7YmFRG3ZNBKHb8ndNZz/8q8wE
         HMyyLWUA/UepnLCXmrfmgrw1gejH2xEjd/43h3OBmNLDV4sXmkV9Nz2KqRk26/0fEiaY
         +Mag6mhjFlUDX2RBHpvNVODteCEGp3/+JP6ktExK7hemkkpEP0ukv4uVJBHmyCX+ang9
         7OnVJV14Hm0FBVKssS2mxqPnD5zTEba1TiKYnBFY0OXDy/YUogPojhGrnIOhMWITEPIi
         65d9zjtAbNuTi3Oc7GfVI7YV8xRca52J67mjqq8Q++ccfdBDrp+PLjFcZlQsU5J6Atj/
         TH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547825; x=1691139825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Sulw2g3PMm/3FrSz/QYnyj8lRHAo71cCYrKZqBOx5k=;
        b=OBhgOML+S+M5MtOixahbqTTRq11Uc8wCCqTTMoLyzCt3dmeJUHzOzZQhxybQ3IbgoB
         z8Nyp1IijfRchFhyi9bqRIJugIBkNnVHXm9fUiy/gPTaixNTJcG71hbohtuwMw7Rki2v
         B9I1jMJSFYDenrV3ecAna7kBTaUk+9OIB0+v7E4hp9YFH8eKlKGN28k18CcYAjdOqRrI
         XSxgxTrVd9zZTBNpeAoBioaaV8kTRPdOqDXL1hs4DlrP/8u86t3Fdam+eps8fot9niDq
         xhp0oftIO9R34w7uE2DGag6W9uG66WhmrpSuH9feSGFrUmHOQmYavFMkDUEliFLRorhN
         H6+g==
X-Gm-Message-State: ABy/qLb2Rd3/jPNC/xq8slSfQkwIEtwUJfaROPh381KYJBYF+AoPy5Lh
        W5Kg7uhb1JGkQhZ9Ue4Ik8VXGeYaHIqmkYpB
X-Google-Smtp-Source: APBJJlH+rN0WBHUDaTbHgB8qj8FfCjSbJCTMIwdWLAiUiRUj/irmZM+xlSGEfpY9sC3zdt/4Sv4maA==
X-Received: by 2002:a2e:9483:0:b0:2b6:a682:9aa5 with SMTP id c3-20020a2e9483000000b002b6a6829aa5mr9261197ljh.38.1688547824985;
        Wed, 05 Jul 2023 02:03:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b00989257be620sm14143918ejr.200.2023.07.05.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:03:44 -0700 (PDT)
Message-ID: <098e96f6fb3c1892121d337497e3579f09e017d4.camel@gmail.com>
Subject: Re: [PATCH v3] iio: adc: add buffering support to the TI LMP92064
 ADC driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Jul 2023 11:03:44 +0200
In-Reply-To: <20230703103908.27691-1-l.goehrs@pengutronix.de>
References: <20230703103908.27691-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

SGkgTGVvbmFyZCwKCkxHVE0sIG9ubHkgb25lIGNvbW1lbnQgZnJvbSBtZS4gU2VlIGJlbG93Li4u
Ck9uIE1vbiwgMjAyMy0wNy0wMyBhdCAxMjozOSArMDIwMCwgTGVvbmFyZCBHw7ZocnMgd3JvdGU6
Cj4gRW5hYmxlIGJ1ZmZlcmVkIHJlYWRpbmcgb2Ygc2FtcGxlcyBmcm9tIHRoZSBMTVA5MjA2NCBB
REMuCj4gVGhlIG1haW4gYmVuZWZpdCBvZiB0aGlzIGNoYW5nZSBpcyBiZWluZyBhYmxlIHRvIHJl
YWQgb3V0IGN1cnJlbnQgYW5kCj4gdm9sdGFnZSBtZWFzdXJlbWVudHMgaW4gYSBzaW5nbGUgdHJh
bnNmZXIsIGFsbG93aW5nIGluc3RhbnRhbmVvdXMgcG93ZXIKPiBtZWFzdXJlbWVudHMuCj4gCj4g
UmVhZHMgaW50byB0aGUgYnVmZmVyIGNhbiBiZSB0cmlnZ2VyZWQgYnkgYW55IHNvZnR3YXJlIHRy
aWdnZXJzLCBlLmcuCj4gdGhlIGlpby10cmlnLWhydGltZXI6Cj4gCj4gwqDCoMKgICQgbWtkaXIg
L3N5cy9rZXJuZWwvY29uZmlnL2lpby90cmlnZ2Vycy9ocnRpbWVyL215LXRyaWdnZXIKPiDCoMKg
wqAgJCBjYXQgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UzL25hbWUKPiDCoMKgwqAg
bG1wOTIwNjQKPiDCoMKgwqAgJCBpaW9fcmVhZGRldiAtdCBteS10cmlnZ2VyIC1iIDE2IGlpbzpk
ZXZpY2UzIHwgaGV4ZHVtcAo+IMKgwqDCoCBXQVJOSU5HOiBIaWdoLXNwZWVkIG1vZGUgbm90IGVu
YWJsZWQKPiDCoMKgwqAgMDAwMDAwMCAwMDAwIDAxNzYgMDEwMSAwMDAxIDU1MDcgYWJkNSA3NjQ1
IDE3NjgKPiDCoMKgwqAgMDAwMDAxMCAwMDAwIDAxNmQgMDEwMSAwMDAxIGVlMWUgYWM2YiA3NjQ1
IDE3NjgKPiDCoMKgwqAgLi4uCj4gCj4gU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBHw7ZocnMgPGwu
Z29laHJzQHBlbmd1dHJvbml4LmRlPgo+IC0tLQo+IENoYW5nZXMgdjEtPnYyOgo+IAo+IMKgIC0g
UmVtb3ZlIHN1cGVyZmx1b3VzIC5zaGlmdCA9IDAgaW5pdGlhbGl6YXRpb24gaW4gc2Nhbl90eXBl
Lgo+IMKgIC0gUmVwbGFjZSBrbWFsbG9jIGJ1ZmZlciBhbGxvY2F0aW9uIGZvciBldmVyeSByZWFk
IHdpdGggYSBzdGFjawo+IMKgwqDCoCBhbGxvY2F0ZWQgc3RydWN0dXJlLgo+IMKgwqDCoCBBIHN0
cnVjdCBpcyB1c2VkIHRvIGVuc3VyZSBjb3JyZWN0IGFsaWdubWVudCBvZiB0aGUgdGltZXN0YW1w
IGZpZWxkLgo+IMKgwqDCoCBTZWUgZS5nLiBhZGMvcm9ja2NoaXBfc2FyYWRjLmMgZm9yIG90aGVy
IHVzZXJzIG9mIHRoZSBzYW1lIHBhdHRlcm4uCj4gwqAgLSBVc2UgYXZhaWxhYmxlX3NjYW5fbWFz
a3MgYW5kIGFsd2F5cyBwdXNoIGJvdGggdm9sdGFnZSBhbmQgY3VycmVudAo+IMKgwqDCoCBtZWFz
dXJlbWVudHMgdG8gdGhlIGJ1ZmZlci4KPiAKPiBDaGFuZ2VzIHYyLT52MzoKPiAKPiDCoCAtIEhh
bmRsZSBlcnJvcnMgcmV0dXJuZWQgYnkgbG1wOTIwNjRfcmVhZF9tZWFzKCkgb3V0LW9mLWxpbmUg
dmlhCj4gwqDCoMKgIGEgZ290byBlcnI7Cj4gCj4gLS0tCj4gwqBkcml2ZXJzL2lpby9hZGMvdGkt
bG1wOTIwNjQuYyB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hZGMvdGktbG1wOTIwNjQuYyBiL2RyaXZlcnMvaWlvL2FkYy90aS1sbXA5MjA2NC5jCj4g
aW5kZXggYzMwZWQ4MjQ5MjRmMy4uNzM1MDRhMjdhOGUyMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvdGktbG1wOTIwNjQuYwo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy90aS1sbXA5MjA2
NC5jCj4gQEAgLTE2LDcgKzE2LDEwIEBACj4gwqAjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPgo+
IMKgCj4gwqAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPgo+ICsjaW5jbHVkZSA8bGludXgvaWlv
L2J1ZmZlci5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L2lpby9kcml2ZXIuaD4KPiArI2luY2x1ZGUg
PGxpbnV4L2lpby90cmlnZ2VyZWRfYnVmZmVyLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9paW8vdHJp
Z2dlcl9jb25zdW1lci5oPgo+IMKgCj4gwqAjZGVmaW5lIFRJX0xNUDkyMDY0X1JFR19DT05GSUdf
QSAweDAwMDAKPiDCoCNkZWZpbmUgVElfTE1QOTIwNjRfUkVHX0NPTkZJR19CIDB4MDAwMQo+IEBA
IC05MSw2ICs5NCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgbG1wOTIw
NjRfYWRjX2NoYW5uZWxzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
YWRkcmVzcyA9IFRJX0xNUDkyMDY0X0NIQU5fSU5DLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmluZm9fbWFza19zZXBhcmF0ZSA9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQklUKElJT19DSEFOX0lORk9fUkFXKSB8IEJJVChJSU9f
Q0hBTl9JTkZPX1NDQUxFKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNjYW5f
aW5kZXggPSBUSV9MTVA5MjA2NF9DSEFOX0lOQywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLnNjYW5fdHlwZSA9IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5zaWduID0gJ3UnLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLnJlYWxiaXRzID0gMTIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc3RvcmFnZWJpdHMgPSAxNiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5kYXRhc2hlZXRfbmFtZSA9ICJJTkMiLAo+IMKgwqDCoMKgwqDCoMKgwqB9LAo+IMKgwqDCoMKg
wqDCoMKgwqB7Cj4gQEAgLTk4LDggKzEwNywyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19j
aGFuX3NwZWMgbG1wOTIwNjRfYWRjX2NoYW5uZWxzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAuYWRkcmVzcyA9IFRJX0xNUDkyMDY0X0NIQU5fSU5WLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmluZm9fbWFza19zZXBhcmF0ZSA9Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQklUKElJT19DSEFOX0lORk9f
UkFXKSB8IEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLnNjYW5faW5kZXggPSBUSV9MTVA5MjA2NF9DSEFOX0lOViwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNjYW5fdHlwZSA9IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zaWduID0gJ3UnLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnJlYWxiaXRzID0gMTIsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc3RvcmFnZWJpdHMgPSAx
NiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5kYXRhc2hlZXRfbmFtZSA9ICJJTlYiLAo+IMKgwqDCoMKgwqDCoMKg
wqB9LAo+ICvCoMKgwqDCoMKgwqDCoElJT19DSEFOX1NPRlRfVElNRVNUQU1QKDIpLAo+ICt9Owo+
ICsKPiArc3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcgbG1wOTIwNjRfc2Nhbl9tYXNrc1tdID0g
ewo+ICvCoMKgwqDCoMKgwqDCoEJJVChUSV9MTVA5MjA2NF9DSEFOX0lOQykgfCBCSVQoVElfTE1Q
OTIwNjRfQ0hBTl9JTlYpLAo+ICvCoMKgwqDCoMKgwqDCoDAKPiDCoH07Cj4gwqAKPiDCoHN0YXRp
YyBpbnQgbG1wOTIwNjRfcmVhZF9tZWFzKHN0cnVjdCBsbXA5MjA2NF9hZGNfcHJpdiAqcHJpdiwg
dTE2ICpyZXMpCj4gQEAgLTE3MSw2ICsxOTIsMzAgQEAgc3RhdGljIGludCBsbXA5MjA2NF9yZWFk
X3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqB9
Cj4gwqAKPiArc3RhdGljIGlycXJldHVybl90IGxtcDkyMDY0X3RyaWdnZXJfaGFuZGxlcihpbnQg
aXJxLCB2b2lkICpwKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlpb19wb2xsX2Z1bmMg
KnBmID0gcDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gcGYt
PmluZGlvX2RldjsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbG1wOTIwNjRfYWRjX3ByaXYgKnBy
aXYgPSBpaW9fcHJpdihpbmRpb19kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUxNiB2YWx1ZXNbMl07Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGludDY0X3QgdGltZXN0YW1wOwo+ICvCoMKgwqDCoMKgwqDCoH0g
ZGF0YTsKPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ICsKCkkgdGhpbmsgeW91IG5lZWQgdG8g
ZXhwbGljaXRseSBfX2FsaWduKDgpIHlvdXIgdGltZXN0YW1wIGRhdGEuIFRoZSByZWFzb24gaXMg
dGhhdAooSUlSQykgZm9yIHg4NiAzMiBiaXRzLCBhIGxvbmcgbG9uZyBpcyBub3QgbmF0dXJhbGx5
IGFsaWduZWQgdG8gNjRiaXRzIGJ1dCAzMi4KCllvdSBhbHNvIG5lZWQgdG8gZXhwbGljaXRseSBt
ZW1zZXQoMCkgeW91ciBkYXRhIHNvIHdlIGRvbid0IGxlYWsgZGF0YSB0byB1c2Vyc3BhY2UuCgot
IE51bm8gU8OhIAo=

