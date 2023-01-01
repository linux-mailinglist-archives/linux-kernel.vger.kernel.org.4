Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A465A9AB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 12:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAALGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 06:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAALGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 06:06:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA4B31;
        Sun,  1 Jan 2023 03:06:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m3so9469176wmq.0;
        Sun, 01 Jan 2023 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2el4ERZcTPvT5uDL3i+6aihFwH/fGE4CQf4W9vHimzQ=;
        b=YkZiALNfP2gR4Q5166RBKDAnad46y624pvaubO214ZDA57xbHJacl4PceATZ4Gw2RY
         MVhgmoKxsP+pKWtXx2ewu3b1XU3UbJiBinwfo9oPSaCGt+/6ULpFRFy+KRXzMPG0K7M7
         JiWirnLkTBqQ+TBWjMxaTkije/QrskG3zGqur64/aCZReOr8R7Vop4mzJoAN0JvV2gl2
         6MhFXw2/uesWGF69cw4i0oqqqN9VleXElN3WY/hrGKoEm0mHoNVEHdRz+0XivGf80h+B
         J/rTvzbIGm91aOdxrSbAjFNoEFr+ZIK5kg2Ps2FD6FzNDoO6UxN+Oio51V84UcVqa5nF
         n4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2el4ERZcTPvT5uDL3i+6aihFwH/fGE4CQf4W9vHimzQ=;
        b=lpCprTkILZW908FIig9R1wLio/X5nRKmHKaIDC3RT3o+WnA8kvqi3mdAyRmLEwGugz
         Q/BDEVmVDSSpqbtJZievUzPr8DwdtC8QxkSM8YhN6KBTsWgKk78xlPONZaoV9by1d2F5
         soemYmQvDbc/o7ngOnaPbdGOhtD2MTslo4a60OyivS2C/PEObYvHYsryrCqPXiyYXPs/
         wa0whrkleGURM/5lzZUK+Y+w6mIdQ5UtKOz6Prbl/v9wnyXnykIEv1D57oR4O0/p8f8/
         3FS66TUDXyTjbzTS7ki+NsRmdCrlqdTOq3/axGzU48brT/rZSCna0qf821m0fOXyJ8wn
         xzAQ==
X-Gm-Message-State: AFqh2krw9DDX8HOTAkLJ5xeYGfqR3lFztfZvgmhnK+AeKLwNwIcmpyCL
        GnipQEhNQEcc1GuQ3JSiVTM=
X-Google-Smtp-Source: AMrXdXtyQk1vTMr5CSacubfp/46/bASOgXI0uOL1B/tQiMxaYAjHIcahGPAXBmV/xE+ynuuQJJfaxg==
X-Received: by 2002:a05:600c:348b:b0:3d1:f16b:30e6 with SMTP id a11-20020a05600c348b00b003d1f16b30e6mr27020040wmq.28.1672571170358;
        Sun, 01 Jan 2023 03:06:10 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003d96efd09b7sm35795713wmp.19.2023.01.01.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 03:06:10 -0800 (PST)
Message-ID: <a46de52484ee62e073c80d0f2ddeebdcf8308c07.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: pressure: bmp280: Add preinit callback
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Jan 2023 12:06:08 +0100
In-Reply-To: <Y6tmcRlHCZTgT9jS@smile.fi.intel.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
         <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
         <Y6tmcRlHCZTgT9jS@smile.fi.intel.com>
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

T24gVHVlLCAyMDIyLTEyLTI3IGF0IDIzOjQxICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gTW9uLCBEZWMgMjYsIDIwMjIgYXQgMDM6Mjk6MjFQTSArMDEwMCwgQW5nZWwgSWdsZXNp
YXMgd3JvdGU6Cj4gPiBBZGRzIHByZWluaXQgY2FsbGJhY2sgdG8gZXhlY3V0ZSBvcGVyYXRpb25z
IG9uIHByb2JlIGJlZm9yZSBhcHBseWluZwo+ID4gaW5pdGlhbCBjb25maWd1cmF0aW9uLgo+IAo+
IC4uLgo+IAo+ID4gQEAgLTkzNSw2ICs5MzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGJtcDI4
MF9jaGlwX2luZm8gYm1wMjgwX2NoaXBfaW5mbyA9Cj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
LnJlYWRfdGVtcCA9IGJtcDI4MF9yZWFkX3RlbXAsCj4gPiDCoMKgwqDCoMKgwqDCoMKgLnJlYWRf
cHJlc3MgPSBibXAyODBfcmVhZF9wcmVzcywKPiA+IMKgwqDCoMKgwqDCoMKgwqAucmVhZF9jYWxp
YiA9IGJtcDI4MF9yZWFkX2NhbGliLAo+ID4gK8KgwqDCoMKgwqDCoMKgLnByZWluaXQgPSBOVUxM
LAo+ID4gwqB9Owo+ID4gwqAKPiA+IMKgc3RhdGljIGludCBibWUyODBfY2hpcF9jb25maWcoc3Ry
dWN0IGJtcDI4MF9kYXRhICpkYXRhKQo+ID4gQEAgLTk3OSw2ICs5ODEsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGJtcDI4MF9jaGlwX2luZm8gYm1lMjgwX2NoaXBfaW5mbyA9Cj4gPiB7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgLnJlYWRfcHJlc3MgPSBibXAyODBfcmVhZF9wcmVzcywKPiA+IMKgwqDC
oMKgwqDCoMKgwqAucmVhZF9odW1pZCA9IGJtcDI4MF9yZWFkX2h1bWlkLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoC5yZWFkX2NhbGliID0gYm1lMjgwX3JlYWRfY2FsaWIsCj4gPiArwqDCoMKgwqDCoMKg
wqAucHJlaW5pdCA9IE5VTEwsCj4gPiDCoH07Cj4gCj4gVXNlbGVzcyBjaGFuZ2VzLgo+IAo+IC4u
Lgo+IAo+ID4gQEAgLTE2MDQsNiArMTYxNCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYm1wMjgw
X2NoaXBfaW5mbyBibXAxODBfY2hpcF9pbmZvCj4gPiA9IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqAu
cmVhZF90ZW1wID0gYm1wMTgwX3JlYWRfdGVtcCwKPiA+IMKgwqDCoMKgwqDCoMKgwqAucmVhZF9w
cmVzcyA9IGJtcDE4MF9yZWFkX3ByZXNzLAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5yZWFkX2NhbGli
ID0gYm1wMTgwX3JlYWRfY2FsaWIsCj4gPiArwqDCoMKgwqDCoMKgwqAucHJlaW5pdCA9IE5VTEws
Cj4gPiDCoH07Cj4gCj4gRGl0dG8uCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+
ID4gK8KgwqDCoMKgwqDCoMKgICogU29tZSBjaGlwcyBsaWtlIHRoZSBCTVAzeHggaGF2ZSBwcmVp
bml0IHRhc2tzIHRvIHJ1bgo+ID4gK8KgwqDCoMKgwqDCoMKgICogYmVmb3JlIGFwcGx5aW5nIHRo
ZSBpbml0aWFsIGNvbmZpZ3VyYXRpb24uCj4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChkYXRhLT5jaGlwX2luZm8tPnByZWluaXQpIHsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBkYXRhLT5jaGlwX2luZm8tPnByZWluaXQoZGF0YSk7
Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJlcnJv
ciBydW5uaW5nIHByZWluaXQgdGFza3MiKTsKPiAKPiBIdWg/ISBJIGd1ZXNzIHlvdSB3YW50ZWQK
ClRoZSBkYW5nZXJzIG9mIGNvcHlpbmcgcGFzdGUgYW5kIHJ1c2hpbmcgdGhpbmdzIGV0Yy4gU29y
cnkgZm9yIHRoaXMgYnJhaW4gZmFydCEKClRoYW5rcyBmb3IgeW91ciB0aW1lLApBbmdlbAoKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IAo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IDwgMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBkZXZfZXJyX3Byb2JlKC4uLik7Cj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKg
fQo+IAoK

