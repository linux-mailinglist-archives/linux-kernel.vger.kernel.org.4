Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB67683972
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjAaWhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjAaWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:37:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ADA530FB;
        Tue, 31 Jan 2023 14:36:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so15679148wrv.0;
        Tue, 31 Jan 2023 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+2nyXegReOu8jUxiMGB5palVRTeOJ+I1UHYLKAdwCtY=;
        b=RFo38UKcYBx5o1Bb5fsP/sr+jl2BnGOHqltKsAyxLMuHyWikMnLfczvzWnrrHi9l5H
         EAikqs768XxfuNNVUZcKw6+hRmr8wgM2PSxV1p3qdhBgDmOjB3r8k2HeveKS2P1k1J8k
         0oVI3nXse2jvMrSzmXYM/Zurl5LbrOw/2tQk2IQvNWzgl8VmA9y9Kk0WaAM37JYXqKXl
         6fT2tjAMpyZIz5941zm5x1NU85yfYWGDuZk3MPIigK9XngU00aX2A/a7DcFPVvHqKZjS
         t7Ct46zBTFtarUkPMx0LwyzXBEVpRKQbljg1C+faka9QOeG2d9qIZfwosPUaeovlxsqc
         3FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2nyXegReOu8jUxiMGB5palVRTeOJ+I1UHYLKAdwCtY=;
        b=Z00viHjqhWO4jIAIwYbmHMZhMzOve3M1C/ncgGRtWFI6uo+uzHagzWVSZV8P7yAxmq
         3AFA9mPeeCtKaxaUPQhxx/emb1bLuVf1NMKVvSRb3Il1pejsY4ofyfngkNQ16t9hVu3a
         V9vrR30SlTUlG6psMYemODn1+f8l0WZNkp5HR2530UYwicqcAID4sbo6uS/QnHZqH52I
         LvcAakTExwuMXXfg+2n5US9lj+D2n+mwA3Q6ML1g0RYbhCg/KFlslzZtOVMpnJXEubM9
         zVruyaylhqXH5Hw1WkdIyb7IjOn+cSHsNJRMmHeXsmVZc8ONSsYXFvm0qRNMo0KG39bW
         rE6g==
X-Gm-Message-State: AO0yUKVaNtWWZKBfcJHtFQH8cGCRInPpu1q/IONkGhpwbUSPCljn9Qy6
        7O3Ls7uaTblCY8ooT31eCks=
X-Google-Smtp-Source: AK7set90rpA4ZQJVazlfBbK/Uu73azbwA5+NWjVqg0ebSg5dMWw+xP966xjiMn5hYIFZzhj+b8DeMA==
X-Received: by 2002:a5d:40c3:0:b0:2bf:b746:6224 with SMTP id b3-20020a5d40c3000000b002bfb7466224mr501837wrq.0.1675204576537;
        Tue, 31 Jan 2023 14:36:16 -0800 (PST)
Received: from DreamMachine2.lan (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002bdf3809f59sm15362561wrq.38.2023.01.31.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:36:16 -0800 (PST)
Message-ID: <2be3109edf0c29178aab58705ed2cf60b6b30a62.camel@gmail.com>
Subject: Re: [PATCH v3 7/7] iio: pressure: bmp280: Add nvmem operations for
 BMP580
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 23:36:14 +0100
In-Reply-To: <Y9e4KFhB2E6E4EQb@smile.fi.intel.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
         <013686653a60092227c842ae2fd0197f2509ad7c.1674954271.git.ang.iglesiasg@gmail.com>
         <Y9e4KFhB2E6E4EQb@smile.fi.intel.com>
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

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDE0OjI5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gU3VuLCBKYW4gMjksIDIwMjMgYXQgMDI6MzM6MDlBTSArMDEwMCwgQW5nZWwgSWdsZXNp
YXMgd3JvdGU6Cj4gPiBUaGUgcHJlc3N1cmUgc2Vuc29yIEJNUDU4MCBjb250YWlucyBhIG5vbi12
b2xhdGlsZSBtZW1vcnkgdGhhdCBzdG9yZXMKPiA+IHRyaW1taW5nIGFuZCBjb25maWd1cmF0aW9u
IHBhcmFtcy4gVGhhdCBtZW1vcnkgcHJvdmlkZXMgYW4gcHJvZ3JhbW1hYmxlCj4gPiB1c2VyIHJh
bmdlIG9mIHRocmVlIDItYnl0ZSB3b3Jkcy4KPiAKPiAuLi4KPiAKPiA+ICsjZGVmaW5lIE5WTV9S
RUFEwqDCoMKgwqDCoMKgwqBmYWxzZQo+ID4gKyNkZWZpbmUgTlZNX1dSSVRFwqDCoMKgwqDCoMKg
dHJ1ZQo+IAo+IEhvdyBpcyBpdCBoZWxwZnVsIGFuZCB3aHkgaXQncyBub3QgbmFtZXNwYWNlZCBw
cm9wZXJseSAoY2FuIGNvbGxpZGUgd2l0aAo+IE5WTSBmcmFtZXdvcmspPwoKSSB0aG91Z2h0IGl0
IGNvdWxkIHByb3ZpZGUgY2xhcml0eSB1c2luZyB0aG9zZSBhbGlhc2VzIGNhbGxpbmcKYm1wNTgw
X252bV9vcGVyYXRpb24oKSBoZWxwZXIgZnVuY3Rpb24gb24gbnZtZW4gY2FsbGJhY2tzLCBpbnN0
ZWFkIG9mIHVzaW5nCmp1c3QgdHJ1ZSBvciBmYWxzZS4gTm90IG15IGJyaWdodGVzdCBpZGVhIGZv
ciBzdXJlLgoKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFdhaXQgdW50aWwgTlZNIGlz
IHJlYWR5IGFnYWluICovCj4gPiArwqDCoMKgwqDCoMKgwqBkbyB7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX3JlYWQoZGF0YS0+cmVnbWFwLCBCTVA1ODBf
UkVHX1NUQVRVUywgJnJlZyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHJldCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZXJyKGRhdGEtPmRldiwgImZhaWxlZCB0byBjaGVjayBudm0gc3RhdHVzXG4iKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnICY9IH5C
TVA1ODBfU1RBVFVTX05WTV9SRFlfTUFTSzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqB9IHdoaWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBk
ZWFkbGluZSkgJiYgIShyZWcgJgo+ID4gQk1QNTgwX1NUQVRVU19OVk1fUkRZX01BU0spKTsKPiAK
PiByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoKT8KClllcywgdGhhbmtzIGZvciBwb2ludGluZyBv
dXQsIHRoYXQncyB3YXkgYmV0dGVyIHRoYW4gdGhlIGN1cnJlbnQgbG9vcC4KCj4gCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAoIShyZWcgJiBCTVA1ODBfU1RBVFVTX05WTV9SRFlfTUFTSykpIHsKPiAK
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLi4uCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGV2X2VycihkYXRhLT5kZXYsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCJyZWFjaGVkIHRpbWVvdXQgd2FpdGluZyBmb3IgbnZtIG9wZXJhdGlvbgo+
ID4gY29tcGxldGlvblxuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIC1FVElNRURPVVQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gCj4gLi4uCj4gCj4gPiArwqDC
oMKgwqDCoMKgwqB3aGlsZSAoYnl0ZXMgPj0gc2l6ZW9mKHUxNikpIHsKPiAKPiBzaXplb2YoKmRz
dCkgPwo+IAo+IE9yIHNpemVvZihkYXRhLT5sZTE2KT8KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBhZGRyID0gYm1wNTgwX252bWVtX2FkZHJzW29mZnNldCAvIHNpemVvZih1
MTYpXTsKPiAKPiBEaXR0by4KPiAKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBieXRlcyAtPSBzaXplb2YodTE2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBvZmZzZXQgKz0gc2l6ZW9mKHUxNik7Cj4gCj4gRGl0dG8uCj4gCj4gPiArwqDCoMKg
wqDCoMKgwqB9Cj4gCj4gLi4uCj4gCj4gPiArc3RhdGljIGludCBibXA1ODBfbnZtZW1fd3JpdGUo
dm9pZCAqcHJpdiwgdW5zaWduZWQgaW50IG9mZnNldCwgdm9pZCAqdmFsLAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCBi
eXRlcykKPiA+ICt7Cj4gCj4gU2FtZSBjb21tZW50cyBhcyBwZXIgYWJvdmUgZnVuY3Rpb24uCgpH
b3QgaXQhCgo+ID4gwqB9Cj4gCj4gCgpUaGFua3MgZm9yIHlvdXIgdGltZSwKQW5nZWwK

