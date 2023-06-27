Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEF74052F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjF0Uth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0Utf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:49:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92AEED
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:49:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so47773291fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687898972; x=1690490972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vt+JhOMyOcPiZWyS5N8b6JaFlqcnPvkA4fl5T3chmMY=;
        b=ejnDLJc8Ktcrnrr9zztrFiKUNQsbVoLhW0veAolOW8qy3AJR+i0nMgNKLX/p8+aQDq
         xkTfaoy2kjSVNCTcud7LJPbf0xSkLZShvDy4wV9DINYh8tCRA/k7k3A8hRDClsHEYkjf
         u/mJSAlyxysDgkQczLK3guWsxTbtIS5VoLX+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687898972; x=1690490972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vt+JhOMyOcPiZWyS5N8b6JaFlqcnPvkA4fl5T3chmMY=;
        b=E7QK1uaOH9InQs557H04+jXuvcxthZbJIrA/BxyXygbrPDY0AOBKvkKSaf9WKfJni3
         sZO2xeWGPyY+WKKwyTayB/g6L17DgLSIm1e0WCNLwBVnmRQuvTSG/opbo6wuNHqa97I5
         Z4erdh0GzyPGofOlUR9IZvgHgxILD7RnDwSXV1RRh3b5WjVRSfj9rdHzE71sRl0Wlgjh
         16SpMTVy/cJJjbtiUL1mMQtCthRGOhIKv8NS6hRZHjujiQkItz4qw6duY33bi2EiEdmN
         obmmhlUf9Oe0nx3JcolOZuau/Zb15irfnb0PV0RaRTw181lEBEcObHOX10LdfnZw1I2i
         HG0Q==
X-Gm-Message-State: AC+VfDyZS0mo51etQy/IJUtQEiqkACqARRfcTmFD7dQKY+oirNsLXlS6
        UBuByvnzrTEDqz8prA2ZdWtOPLiv9kslLlkiG7CwlQGR
X-Google-Smtp-Source: ACHHUZ4z3UUwnRz6VQc4IbogHZSrIWxdBICc7B9sqP+Lac288pT3Oc9A7b1rsg1ZKqTgsLHIRj9kYA==
X-Received: by 2002:a05:651c:105b:b0:2b6:9884:98c7 with SMTP id x27-20020a05651c105b00b002b6988498c7mr5487564ljm.44.1687898971740;
        Tue, 27 Jun 2023 13:49:31 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906858400b0098e025cda39sm4460016ejx.70.2023.06.27.13.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:49:31 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso3907562a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:49:30 -0700 (PDT)
X-Received: by 2002:aa7:d748:0:b0:51d:982d:cb77 with SMTP id
 a8-20020aa7d748000000b0051d982dcb77mr5048716eds.33.1687898970482; Tue, 27 Jun
 2023 13:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com> <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local>
In-Reply-To: <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 13:49:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
Message-ID: <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Borislav Petkov <bp@alien8.de>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008d9a5905ff229ade"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008d9a5905ff229ade
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jun 2023 at 13:38, Borislav Petkov <bp@alien8.de> wrote:
>
> And there's a third kind who relax by the pool with a nice drink,
> *while* playing around with inline asm. ;-P

That explains a lot.

> Btw, I'll send you a new version of this pull request with this patch
> dropped to let folks experiment with it more.

Oh, I already merged it. I don't hate the change, I just looked at it
and went "I would have done that differently" and started playing
around with it.

There's nothing hugely *wrong* with the code I merged, but I do think
that it did too much inside the inline asm (ie looping inside the asm,
but also initializing values that could have - and should have - just
been given as inputs to the asm).

And the whole "why have two different versions for 40-byte and 64-byte
areas, when you _could_ just do it with one 40-byte one that you then
also just unroll".

So I _think_ my version is nicer and shorter - assuming it works and
there are no other bugs than the one I already noticed - but I don't
think it's a huge deal.

Anyway, before I throw my patch away, I'll just post it with the
trivial fixes to use "+r", and with the "volatile" removed (I add
"volatile" to asms by habit, but this one really isn't volatile).

I just checked that both gcc and clang seem to be happy with it, but
that's the only testing this patch has gotten: it compiles for me.

Do with it what you will.

                 Linus

--0000000000008d9a5905ff229ade
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljerge1u0>
X-Attachment-Id: f_ljerge1u0

IGFyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYyB8IDY2ICsrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxf
NjQuYyBiL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYwppbmRleCBjZWEyNWNhOGI4Y2Yu
LjYxZThjM2Q5N2MwNCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvbGliL2NzdW0tcGFydGlhbF82NC5j
CisrKyBiL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYwpAQCAtMzMsNiArMzMsMjAgQEAg
c3RhdGljIGlubGluZSBfX3dzdW0gY3N1bV90YWlsKHU2NCB0ZW1wNjQsIGludCBvZGQpCiAJcmV0
dXJuIChfX2ZvcmNlIF9fd3N1bSlyZXN1bHQ7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyB1cGRhdGVfY3N1bV80MGIodW5zaWduZWQgbG9uZyBzdW0sIGNvbnN0IHVuc2lnbmVkIGxv
bmcgbVs1XSkKK3sKKwlhc20oImFkZHEgJTEsJTBcblx0IgorCSAgICAgImFkY3EgJTIsJTBcblx0
IgorCSAgICAgImFkY3EgJTMsJTBcblx0IgorCSAgICAgImFkY3EgJTQsJTBcblx0IgorCSAgICAg
ImFkY3EgJTUsJTBcblx0IgorCSAgICAgImFkY3EgJDAsJTAiCisJCToiK3IiIChzdW0pCisJCToi
bSIgKG1bMF0pLCAibSIgKG1bMV0pLCAibSIgKG1bMl0pLAorCQkgIm0iIChtWzNdKSwgIm0iICht
WzRdKSk7CisJcmV0dXJuIHN1bTsKK30KKwogLyoKICAqIERvIGEgY2hlY2tzdW0gb24gYW4gYXJi
aXRyYXJ5IG1lbW9yeSBhcmVhLgogICogUmV0dXJucyBhIDMyYml0IGNoZWNrc3VtLgpAQCAtNjQs
NDcgKzc4LDIzIEBAIF9fd3N1bSBjc3VtX3BhcnRpYWwoY29uc3Qgdm9pZCAqYnVmZiwgaW50IGxl
biwgX193c3VtIHN1bSkKIAkgKiBoYXMgbm90aWNlYWJsZSBuZWdhdGl2ZSBhZmZlY3Qgb24gY29k
ZWdlbiBmb3IgYWxsIG90aGVyIGNhc2VzIHdpdGgKIAkgKiBtaW5pbWFsIHBlcmZvcm1hbmNlIGJl
bmVmaXQgaGVyZS4KIAkgKi8KLQlpZiAobGVuID09IDQwKSB7Ci0JCWFzbSgiYWRkcSAwKjgoJVtz
cmNdKSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgMSo4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJ
ICAgICJhZGNxIDIqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAzKjgoJVtzcmNd
KSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgNCo4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJICAg
ICJhZGNxICQwLCVbcmVzXSIKLQkJICAgIDogW3Jlc10gIityIih0ZW1wNjQpCi0JCSAgICA6IFtz
cmNdICJyIihidWZmKSwgIm0iKCooY29uc3QgY2hhcigqKVs0MF0pYnVmZikpOworCWlmIChsaWtl
bHkobGVuID09IDQwKSkgeworCQl0ZW1wNjQgPSB1cGRhdGVfY3N1bV80MGIodGVtcDY0LCBidWZm
KTsKIAkJcmV0dXJuIGNzdW1fdGFpbCh0ZW1wNjQsIG9kZCk7CiAJfQotCWlmICh1bmxpa2VseShs
ZW4gPj0gNjQpKSB7Ci0JCS8qCi0JCSAqIEV4dHJhIGFjY3VtdWxhdG9ycyBmb3IgYmV0dGVyIElM
UCBpbiB0aGUgbG9vcC4KLQkJICovCi0JCXU2NCB0bXBfYWNjdW0sIHRtcF9jYXJyaWVzOwogCi0J
CWFzbSgieG9ybCAla1t0bXBfYWNjdW1dLCVrW3RtcF9hY2N1bV1cblx0IgotCQkgICAgInhvcmwg
JWtbdG1wX2NhcnJpZXNdLCVrW3RtcF9jYXJyaWVzXVxuXHQiCi0JCSAgICAic3VibCAkNjQsICVb
bGVuXVxuXHQiCi0JCSAgICAiMTpcblx0IgotCQkgICAgImFkZHEgMCo4KCVbc3JjXSksJVtyZXNd
XG5cdCIKLQkJICAgICJhZGNxIDEqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAy
KjgoJVtzcmNdKSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgMyo4KCVbc3JjXSksJVtyZXNdXG5c
dCIKLQkJICAgICJhZGNsICQwLCVrW3RtcF9jYXJyaWVzXVxuXHQiCi0JCSAgICAiYWRkcSA0Kjgo
JVtzcmNdKSwlW3RtcF9hY2N1bV1cblx0IgotCQkgICAgImFkY3EgNSo4KCVbc3JjXSksJVt0bXBf
YWNjdW1dXG5cdCIKLQkJICAgICJhZGNxIDYqOCglW3NyY10pLCVbdG1wX2FjY3VtXVxuXHQiCi0J
CSAgICAiYWRjcSA3KjgoJVtzcmNdKSwlW3RtcF9hY2N1bV1cblx0IgotCQkgICAgImFkY2wgJDAs
JWtbdG1wX2NhcnJpZXNdXG5cdCIKLQkJICAgICJhZGRxICQ2NCwgJVtzcmNdXG5cdCIKLQkJICAg
ICJzdWJsICQ2NCwgJVtsZW5dXG5cdCIKLQkJICAgICJqZ2UgMWJcblx0IgotCQkgICAgImFkZHEg
JVt0bXBfYWNjdW1dLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAlW3RtcF9jYXJyaWVzXSwlW3Jl
c11cblx0IgotCQkgICAgImFkY3EgJDAsJVtyZXNdIgotCQkgICAgOiBbdG1wX2FjY3VtXSAiPSZy
Iih0bXBfYWNjdW0pLAotCQkgICAgICBbdG1wX2NhcnJpZXNdICI9JnIiKHRtcF9jYXJyaWVzKSwg
W3Jlc10gIityIih0ZW1wNjQpLAotCQkgICAgICBbbGVuXSAiK3IiKGxlbiksIFtzcmNdICIrciIo
YnVmZikKLQkJICAgIDogIm0iKCooY29uc3QgY2hhciAqKWJ1ZmYpKTsKKwkvKiBEbyB0d28gNDAt
Ynl0ZSBjaHVua3MgaW4gcGFyYWxsZWwgdG8gZ2V0IGJldHRlciBJTFAgKi8KKwlpZiAobGlrZWx5
KGxlbiA+PSA4MCkpIHsKKwkJdTY0IHRlbXA2NF8yID0gMDsKKwkJZG8geworCQkJdGVtcDY0ID0g
dXBkYXRlX2NzdW1fNDBiKHRlbXA2NCwgYnVmZik7CisJCQl0ZW1wNjRfMiA9IHVwZGF0ZV9jc3Vt
XzQwYih0ZW1wNjRfMiwgYnVmZiArIDQwKTsKKwkJCWJ1ZmYgKz0gODA7CisJCQlsZW4gLT0gODA7
CisJCX0gd2hpbGUgKGxlbiA+PSA4MCk7CisJCWFzbSgiYWRkcSAlMSwlMFxuXHQiCisJCSAgICAi
YWRjcSAkMCwlMCIKKwkJICAgIDoiK3IiICh0ZW1wNjQpOiAiciIgKHRlbXA2NF8yKSk7CiAJfQog
CiAJaWYgKGxlbiAmIDMyKSB7Cg==
--0000000000008d9a5905ff229ade--
