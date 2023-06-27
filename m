Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42EC740459
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjF0ULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjF0ULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:11:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C21BEA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:11:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e0c1d5289so454295166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687896691; x=1690488691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spqpAIVvWSDKdq+JhBRTuiyu6y54nfPRFhEzoG0Wh7c=;
        b=aprmocVGNGXGz0KkfmUQEQUe9qqp/++cG0o1c855BiZ6eeSx25a53dt+kNjn/9oCjw
         xyG7kYRY37pcs71kouxp+odgtWiBHLz4itqY4TgMJiFsaXDyPghrKkTRVLcyN3hkOpXG
         Pht8j174TTIb+8J7vpTZmhY+S4/lGbEDgYhOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687896691; x=1690488691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spqpAIVvWSDKdq+JhBRTuiyu6y54nfPRFhEzoG0Wh7c=;
        b=Sv1z3qNebK+hSbOlVESFx+Lxe+1F0FU2zykEiITkQf7/XfH4aM8AvjFUjXV7Xw4dEK
         e1wW3qTxOubqCQW9x1zRvjEUBKIjkBJUeJnJdNOjg/G8fKszcECyO3X1t/0/qS9cXsYA
         XKxnIGio71nTvReuTBBOe9vLumMqUqkb8HeMEwJl/z/1//qNM3X2RXh9OnrhIyYdg68q
         sZkFCWC4LmK3puUhZqEPcTR4jSq4poaKbL2JF3a4KcqIpH04WkfAOos72mZsRBPga6Tc
         j4/j7rMvYdPyPP4V55jiP47r7RNB4NHjpZ1yf7gVvMyKkNBZ2HW+LIUW85B6+ub2pd7T
         a5pQ==
X-Gm-Message-State: AC+VfDxLhYb3DPW8m8eaw3/c2CtkeJkaj2uA2D2w6XBlZIxZG0XXy2bd
        wCqk09p/hQGBUlVPWAtvrETv3izWnuhY1O7h+BOLX1qN
X-Google-Smtp-Source: ACHHUZ5oJSvpi7O2DdtbnvYQFxCCX1z42JevOHKA3KnluP0xCanVmHmVMKUHoJKf6YiVKjBJjayKxw==
X-Received: by 2002:a17:907:7f0f:b0:989:1f66:e452 with SMTP id qf15-20020a1709077f0f00b009891f66e452mr19741887ejc.2.1687896691570;
        Tue, 27 Jun 2023 13:11:31 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b0098d2f91c850sm4859685ejb.89.2023.06.27.13.11.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:11:30 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso4310209a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:11:30 -0700 (PDT)
X-Received: by 2002:a05:6402:1389:b0:51a:441f:75d7 with SMTP id
 b9-20020a056402138900b0051a441f75d7mr20895375edv.6.1687896690137; Tue, 27 Jun
 2023 13:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
In-Reply-To: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 13:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
Message-ID: <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a27f7c05ff2212f9"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a27f7c05ff2212f9
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jun 2023 at 04:00, Borislav Petkov <bp@alien8.de> wrote:
>
> - Improve csum_partial()'s performance

Honestly, looking at that patch, my reaction is "why did it get
unrolled in 64-byte chunks, if 40 bytes is the magic value"?

Particularly when there is then that "do a carry op each 32 bytes to
make 32-byte chunks independent and increase ILP". So even the 64-byte
case isn't *actuall* doing a 64-byte unrolling, it's really doing two
32-byte unrollings in parallel.

So you have three "magic" values, and the only one that really matters
is likely the 40-byte one.

Yes, yes, 64 bytes is the usual cacheline size, and is "traditional"
for unrolling. But there's nothing really magical about it here.

End result: wouldn't it have been nice to just do 40-byte chunks, and
make the 64-byte "two overlapping 32-byte chunks" be two of the
40-byte chunks.

Something like the (ENTIRELY UNTESTED!) attached patch?

Again: this is *not* tested. I took a quick look at the generated
assembly, and it looked roughly like what I expected it to look like,
but it may be complete garbage.

I added a couple of "likely()" things just because it made the
generated asm look more natural (ie it followed the order of the
source code there), they are otherwise questionable annotations.

Finally: did I already mention that this is completely untested?

             Linus

--000000000000a27f7c05ff2212f9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljeq3dde0>
X-Attachment-Id: f_ljeq3dde0

IGFyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYyB8IDY2ICsrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxf
NjQuYyBiL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYwppbmRleCBjZWEyNWNhOGI4Y2Yu
LjlmMWZhNDdjY2JlMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvbGliL2NzdW0tcGFydGlhbF82NC5j
CisrKyBiL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYwpAQCAtMzMsNiArMzMsMjAgQEAg
c3RhdGljIGlubGluZSBfX3dzdW0gY3N1bV90YWlsKHU2NCB0ZW1wNjQsIGludCBvZGQpCiAJcmV0
dXJuIChfX2ZvcmNlIF9fd3N1bSlyZXN1bHQ7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyB1cGRhdGVfY3N1bV80MGIodW5zaWduZWQgbG9uZyBzdW0sIGNvbnN0IHVuc2lnbmVkIGxv
bmcgbVs1XSkKK3sKKwlhc20gdm9sYXRpbGUoImFkZHEgJTEsJTBcblx0IgorCQkgICAgICJhZGNx
ICUyLCUwXG5cdCIKKwkJICAgICAiYWRjcSAlMywlMFxuXHQiCisJCSAgICAgImFkY3EgJTQsJTBc
blx0IgorCQkgICAgICJhZGNxICU1LCUwXG5cdCIKKwkJICAgICAiYWRjcSAkMCwlMCIKKwkJCToi
PXIiIChzdW0pCisJCQk6Im0iIChtWzBdKSwgIm0iIChtWzFdKSwgIm0iIChtWzJdKSwKKwkJCSAi
bSIgKG1bM10pLCAibSIgKG1bNF0pLCAiMCIgKHN1bSkpOworCXJldHVybiBzdW07Cit9CisKIC8q
CiAgKiBEbyBhIGNoZWNrc3VtIG9uIGFuIGFyYml0cmFyeSBtZW1vcnkgYXJlYS4KICAqIFJldHVy
bnMgYSAzMmJpdCBjaGVja3N1bS4KQEAgLTY0LDQ3ICs3OCwyMyBAQCBfX3dzdW0gY3N1bV9wYXJ0
aWFsKGNvbnN0IHZvaWQgKmJ1ZmYsIGludCBsZW4sIF9fd3N1bSBzdW0pCiAJICogaGFzIG5vdGlj
ZWFibGUgbmVnYXRpdmUgYWZmZWN0IG9uIGNvZGVnZW4gZm9yIGFsbCBvdGhlciBjYXNlcyB3aXRo
CiAJICogbWluaW1hbCBwZXJmb3JtYW5jZSBiZW5lZml0IGhlcmUuCiAJICovCi0JaWYgKGxlbiA9
PSA0MCkgewotCQlhc20oImFkZHEgMCo4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJICAgICJhZGNx
IDEqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAyKjgoJVtzcmNdKSwlW3Jlc11c
blx0IgotCQkgICAgImFkY3EgMyo4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJICAgICJhZGNxIDQq
OCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAkMCwlW3Jlc10iCi0JCSAgICA6IFty
ZXNdICIrciIodGVtcDY0KQotCQkgICAgOiBbc3JjXSAiciIoYnVmZiksICJtIigqKGNvbnN0IGNo
YXIoKilbNDBdKWJ1ZmYpKTsKKwlpZiAobGlrZWx5KGxlbiA9PSA0MCkpIHsKKwkJdGVtcDY0ID0g
dXBkYXRlX2NzdW1fNDBiKHRlbXA2NCwgYnVmZik7CiAJCXJldHVybiBjc3VtX3RhaWwodGVtcDY0
LCBvZGQpOwogCX0KLQlpZiAodW5saWtlbHkobGVuID49IDY0KSkgewotCQkvKgotCQkgKiBFeHRy
YSBhY2N1bXVsYXRvcnMgZm9yIGJldHRlciBJTFAgaW4gdGhlIGxvb3AuCi0JCSAqLwotCQl1NjQg
dG1wX2FjY3VtLCB0bXBfY2FycmllczsKIAotCQlhc20oInhvcmwgJWtbdG1wX2FjY3VtXSwla1t0
bXBfYWNjdW1dXG5cdCIKLQkJICAgICJ4b3JsICVrW3RtcF9jYXJyaWVzXSwla1t0bXBfY2Fycmll
c11cblx0IgotCQkgICAgInN1YmwgJDY0LCAlW2xlbl1cblx0IgotCQkgICAgIjE6XG5cdCIKLQkJ
ICAgICJhZGRxIDAqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAxKjgoJVtzcmNd
KSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgMio4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJICAg
ICJhZGNxIDMqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjbCAkMCwla1t0bXBfY2Fy
cmllc11cblx0IgotCQkgICAgImFkZHEgNCo4KCVbc3JjXSksJVt0bXBfYWNjdW1dXG5cdCIKLQkJ
ICAgICJhZGNxIDUqOCglW3NyY10pLCVbdG1wX2FjY3VtXVxuXHQiCi0JCSAgICAiYWRjcSA2Kjgo
JVtzcmNdKSwlW3RtcF9hY2N1bV1cblx0IgotCQkgICAgImFkY3EgNyo4KCVbc3JjXSksJVt0bXBf
YWNjdW1dXG5cdCIKLQkJICAgICJhZGNsICQwLCVrW3RtcF9jYXJyaWVzXVxuXHQiCi0JCSAgICAi
YWRkcSAkNjQsICVbc3JjXVxuXHQiCi0JCSAgICAic3VibCAkNjQsICVbbGVuXVxuXHQiCi0JCSAg
ICAiamdlIDFiXG5cdCIKLQkJICAgICJhZGRxICVbdG1wX2FjY3VtXSwlW3Jlc11cblx0IgotCQkg
ICAgImFkY3EgJVt0bXBfY2Fycmllc10sJVtyZXNdXG5cdCIKLQkJICAgICJhZGNxICQwLCVbcmVz
XSIKLQkJICAgIDogW3RtcF9hY2N1bV0gIj0mciIodG1wX2FjY3VtKSwKLQkJICAgICAgW3RtcF9j
YXJyaWVzXSAiPSZyIih0bXBfY2FycmllcyksIFtyZXNdICIrciIodGVtcDY0KSwKLQkJICAgICAg
W2xlbl0gIityIihsZW4pLCBbc3JjXSAiK3IiKGJ1ZmYpCi0JCSAgICA6ICJtIigqKGNvbnN0IGNo
YXIgKilidWZmKSk7CisJLyogRG8gdHdvIDQwLWJ5dGUgY2h1bmtzIGluIHBhcmFsbGVsIHRvIGdl
dCBiZXR0ZXIgSUxQICovCisJaWYgKGxpa2VseShsZW4gPj0gODApKSB7CisJCXU2NCB0ZW1wNjRf
MiA9IDA7CisJCWRvIHsKKwkJCXRlbXA2NCA9IHVwZGF0ZV9jc3VtXzQwYih0ZW1wNjQsIGJ1ZmYp
OworCQkJdGVtcDY0XzIgPSB1cGRhdGVfY3N1bV80MGIodGVtcDY0XzIsIGJ1ZmYgKyA0MCk7CisJ
CQlidWZmICs9IDgwOworCQkJbGVuIC09IDgwOworCQl9IHdoaWxlIChsZW4gPj0gODApOworCQlh
c20oImFkZHEgJTEsJTBcblx0IgorCQkgICAgImFkY3EgJDAsJTAiCisJCSAgICA6Ij1yIiAodGVt
cDY0KTogInIiICh0ZW1wNjRfMikpOwogCX0KIAogCWlmIChsZW4gJiAzMikgewo=
--000000000000a27f7c05ff2212f9--
