Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53CB66465D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjAJQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjAJQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A95133B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673368904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2D5nUSU+0DUNDOHAwrQcfQIiMgma8cBzDuSUmWCZsU=;
        b=LppJnA2O87b3SLehgzZvbu3NjNXceOmeqdR0Klva99blk2TWOmvlAqfLkFD2RAz3UDCYKT
        8J9gQjrkK0owIDdyYN+TV0GXeXsGo1ay5ini+ZD6LUcCIokw0BKU+GJOsLYQZ5SCjpynTS
        bJwi9/fmPiuaI1BotgFsRNlL5LeDD4g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-0MnBfp3XNHK-EpT7ZrVs_w-1; Tue, 10 Jan 2023 11:41:43 -0500
X-MC-Unique: 0MnBfp3XNHK-EpT7ZrVs_w-1
Received: by mail-lj1-f197.google.com with SMTP id y8-20020a2e9d48000000b0027f1feabc75so3015829ljj.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2D5nUSU+0DUNDOHAwrQcfQIiMgma8cBzDuSUmWCZsU=;
        b=bZrY14bQtMoSHQaEEepqBU2uIqOCfgeCadYVYH2ceDH2MCEuy++/dBLllMaZejHaNn
         /BvJmHCU1shiDxyVrsodXUngA0GCT3EeqPPs9puSdavfiMRNTOxw9DZxKquObNtSvAXY
         asXrV2MHCZYa+gUr8X858U58TYR5QGZJ8B/dlFM54WTDVun3dQfjtnwQv0DUejTvSo8O
         6LmOEsKhhAAQaow+lOX2XeEiYdvaCgW/+Vg6VNwJSEYa1Kvr+zkWW4DIPgUeGX0mkxLG
         zLJux7rdwH2rzP82ND6lEbxxhQdjcFunoChMVNvmbCAtXlQokKP8JKIM+r9fdin4Z/9L
         hOOQ==
X-Gm-Message-State: AFqh2krjFIM0AUYglf9hJdZtk6SZc7GG3h+0SNeWIN3Twsm5xhCCj4Xc
        jK7inZyVl1OeTRX5rbdxmMdIJmLeunmVxB24kl7wnUgV3e4D9vVyWTdKxEOES2Z8rriMTSMiNPO
        aIkuELsq0UpqcDOjkXFQ1IL8O
X-Received: by 2002:a05:6512:70a:b0:4c0:4214:cd2c with SMTP id b10-20020a056512070a00b004c04214cd2cmr17074131lfs.43.1673368901806;
        Tue, 10 Jan 2023 08:41:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvHIn8I95b25WPkAD939sFhwT/03iSeUqX+5B9goWI7LXaw9tTuBAWfrDMtGIz/bjML64/OJw==
X-Received: by 2002:a05:6512:70a:b0:4c0:4214:cd2c with SMTP id b10-20020a056512070a00b004c04214cd2cmr17074128lfs.43.1673368901635;
        Tue, 10 Jan 2023 08:41:41 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512200600b004caf6f0b08csm2242676lfb.107.2023.01.10.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:41:41 -0800 (PST)
Message-ID: <b4ab67415708b67a2bd323acb69edf6dd3f3705b.camel@redhat.com>
Subject: Re: [PATCH 4/6] composefs: Add filesystem implementation
From:   Alexander Larsson <alexl@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 10 Jan 2023 17:41:40 +0100
In-Reply-To: <Y7gRofheB9EaR4Mi@x1>
References: <cover.1669631086.git.alexl@redhat.com>
         <1f0bd3e3a0c68ee19dd96ee0d573bb113428f1b6.1669631086.git.alexl@redhat.com>
         <Y7gRofheB9EaR4Mi@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDA3OjE4IC0wNTAwLCBCcmlhbiBNYXNuZXkgd3JvdGU6Cj4g
T24gTW9uLCBOb3YgMjgsIDIwMjIgYXQgMTI6MTc6MTJQTSArMDEwMCwgQWxleGFuZGVyIExhcnNz
b24gd3JvdGU6Cj4gPiBUaGlzIGlzIHRoZSBiYXNpYyBpbm9kZSBhbmQgZmlsZXN5c3RlbSBpbXBs
ZW1lbnRhdGlvbi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIExhcnNzb24gPGFs
ZXhsQHJlZGhhdC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBHaXVzZXBwZSBTY3JpdmFubyA8Z3Nj
cml2YW5AcmVkaGF0LmNvbT4KPiAKPiBOb3RlOiBJJ20gbG9va2luZyBhdCB0aGlzIGZyb20gdGhl
IFZGUyB2aWV3cG9pbnQgc2luY2UgSSBoYXZlbid0IGRvbmUKPiBhbnl0aGluZyBpbiB0aGlzIHN1
YnN5c3RlbS4gSnVzdCBsb29raW5nIGZvciBzb21lIGdlbmVyaWMKPiBzdWdnZXN0aW9ucy4KPiAK
PiA+IAo+ID4gKwo+ID4gK3N0cnVjdCBjZnNfaW5vZGUgewo+ID4gK8KgwqDCoMKgwqDCoMKgLyog
bXVzdCBiZSBmaXJzdCBmb3IgY2xlYXIgaW4gY2ZzX2FsbG9jX2lub2RlIHRvIHdvcmsgKi8KPiA+
ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbm9kZSB2ZnNfaW5vZGU7Cj4gCj4gWyBzbmlwIF0KPiAK
PiA+ICtzdGF0aWMgc3RydWN0IGlub2RlICpjZnNfYWxsb2NfaW5vZGUoc3RydWN0IHN1cGVyX2Js
b2NrICpzYikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY2ZzX2lub2RlICpjaW5v
ID0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbGxvY19pbm9kZV9zYihzYiwg
Y2ZzX2lub2RlX2NhY2hlcCwgR0ZQX0tFUk5FTCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIWNpbm8pCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBtZW1zZXQoKHU4ICopY2lubyArIHNpemVvZihzdHJ1
Y3QgaW5vZGUpLCAwLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1
Y3QgY2ZzX2lub2RlKSAtIHNpemVvZihzdHJ1Y3QgaW5vZGUpKTsKPiAKPiBXaHkgbm90IHVzZSBj
b250YWluZXJfb2YoKSB0byBsb29rIHVwIHRoZSB2ZnNfaW5vZGUgYW5kIHRoZW4geW91IGNhbgo+
IGdldAo+IHJpZCBvZiB0aGUgcmVzdHJpY3Rpb24gb2YgdGhpcyBiZWluZyBmaXJzdC4gVGhpcyBt
YXkgYWxzbyBicmVhayB3aXRoCj4gc3RydWN0dXJlIHJhbmRvbWl6YXRpb24gdHVybmVkIG9uLgoK
VGhpcyBpcyBub3QgY2xlYXJpbmcgdmZzX2lub2RlIHRob3VnaCwgaXQgaXMgY2xlYXJpbmcgZXZl
cnl0aGluZyBhZnRlcgp2ZnNfaW5vZGUsIGJlY2F1c2Ugd2UncmUgdXNpbmcgYW4gYWxsb2NhdGlv
biBjYWNoZSBmb3IgdGhlIHZmc19pbm9kZQpwYXJ0LiBJIGRvbid0IHNlZSBob3cgY29udGFpbmVy
X29mIGNhbiBoZWxwIHVzIGhlcmU/CgpBbHNvLCBzdXJlbHkgc3RydWN0dXJlIHJhbmRvbWl6YXRp
b24gd29uJ3QgY2hhbmdlIHRoZSBvZmZzZXQgb2YgdGhlCmZpcnN0IGVsZW1lbnQgb2YgdGhlIHN0
cnVjdD8gVGhhdCB3aWxsIGJyZWFrIGFsbCBzb3J0cyBvZiAiZGVyaXZlZApvYmplY3QiIHVzZWNh
c2VzLgoKPiAKPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBjZnNfaW5vZGUgKkNGU19JKHN0cnVj
dCBpbm9kZSAqaW5vZGUpCj4gCj4gQ0ZTX0kgaW4gdXBwZXIgY2FzZSBkb2Vzbid0IG1hdGNoIG5h
bWluZyBjb252ZW50aW9ucyBpbiB0aGUgcmVzdCBvZgo+IHRoZSBrZXJuZWwuCj4gCgpJdCBpcyBz
aW1pbGFyIHRvIFZGU19JLCBYRlNfSSwgQlRSRlNfSSwgRVhUNF9JLCBldGMKCj4gPiArc3RhdGlj
IHVuc2lnbmVkIGludCBjZnNfc3BsaXRfYmFzZWRpcnMoY2hhciAqc3RyKQo+ID4gK3sKPiA+ICvC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBjdHIgPSAxOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2hh
ciAqcywgKmQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKHMgPSBkID0gc3RyOzsgcysr
LCBkKyspIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKnMgPT0gJ1xc
Jykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
Kys7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIGlmICgqcyA9PSAn
OicpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
KmQgPSAnXDAnOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjdHIrKzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29udGludWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCpkID0gKnM7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKCEqcykKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gY3RyOwo+ID4gK30KPiAKPiBUbyBleHBhbmQgb24gdGhlIGNvbW1l
bnQsIHRoaXMgaXMgb3ZsX3NwbGl0X2xvd2VyZGlycyBpbgo+IGZzL292ZXJsYXlmcy9zdXBlci5j
LiBJdCdkIGJlIG5pY2UgaWYgdGhlcmUgd2FzIGEgY29tbW9uIHBsYWNlIHdoZXJlCj4gdGhpcyBj
b3VsZCBnby4KPiAKCkl0IHdvdWxkIGJlIG5pY2UsIGJ1dCBpdHMgbm90IGxpa2UgYSBodWdlIGFt
b3VudCBvZiBjb2RlIGR1cGxpY2F0aW9uLAphcyBpdCBpcyByYXRoZXIgc3BlY2lhbGl6ZWQuCgo+
IAo+IAoKLS0gCj0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS0KPS09LT0KIEFsZXhhbmRlciBMYXJzc29uICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZWQgSGF0LApJbmMgCiAgICAgICBh
bGV4bEByZWRoYXQuY29tICAgICAgICAgICAgYWxleGFuZGVyLmxhcnNzb25AZ21haWwuY29tIApI
ZSdzIGEgc3VwZXJodW1hbmx5IHN0cm9uZyBuZXVyb3RpYyBiYXJiYXJpYW4gd2l0aCBubyBuYW1l
LiBTaGUncyBhCmJsaW5kIApjaWdhci1jaG9tcGluZyBib3VudHkgaHVudGVyIGZyb20gYSBkaWZm
ZXJlbnQgdGltZSBhbmQgcGxhY2UuIFRoZXkKZmlnaHQgCmNyaW1lISAK

