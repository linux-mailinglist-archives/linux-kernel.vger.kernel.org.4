Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2232E74176E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF1RpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjF1RpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:45:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0942134
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:44:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f122ff663eso8796816e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687974296; x=1690566296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5iwGD4XHWkWOIfZ3yQGIh6iTIUnFByvMDl0Vq0m8Go=;
        b=EmsspnBzEw/jQHMY0ZC6hqmpzYPwXz49Nr5F3m9lZwltrrIbjpg86UxQ+BIALTUHtC
         GJkgEuePI9cVYBNs1TCByp/Du2Oh87sFptpCgzbJCzXQTXN1i/nU7yXc9jFS9+Ad9NRB
         lkDs5CJUVPvZOjnlPt+qKLsa3EIXP4lvu041Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974296; x=1690566296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5iwGD4XHWkWOIfZ3yQGIh6iTIUnFByvMDl0Vq0m8Go=;
        b=jHcYp62JIuMwUOOab0eGqOi9xzDVT462JDjp0LCAHwu8hXzymmGTKCvdbp6m2C26TG
         oZv7sNn9cRBAbXDRboZbNtHOZkfA23DqUam9ZoHF4N4QrTYdcnhsjTYUqr7Kb1HZQtOT
         25QgHB2Fo7NJkKis6v8UHlUAAZO41bX3Bpv89J7W2KFADVrI7jpQT0Udj6cZKFBHZl8g
         fAS41bhuN6dl1IZDvTE+nSiya3XHed3fo4puCveR9Y6yjhlmgwukio+liW0PF6WA3TNy
         tejkDKwWiGLNNre6MOjRjg/PdYbDHpieiy2J/tjaCP7KIm6N+t5VdOwXrV74WuUX43Q2
         FNHQ==
X-Gm-Message-State: AC+VfDx0vKShc1ITeGEbyVI6THShAmmMWy7EL9jWPd/enVNld1f2lE1h
        SddZyB+yinqt3pqkEy2+zkm7B9HycuCOjJP9V4lJI5ir
X-Google-Smtp-Source: ACHHUZ7OF/LQh0apXePecR+CuFAzAEhvO3FI24xgUnqC6Dd+8pO/69I40gniWeNIY9lzYCb72dOMwA==
X-Received: by 2002:ac2:4f0a:0:b0:4fb:7404:538b with SMTP id k10-20020ac24f0a000000b004fb7404538bmr7872835lfr.66.1687974296366;
        Wed, 28 Jun 2023 10:44:56 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004ec84d24818sm2003255lfe.282.2023.06.28.10.44.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 10:44:54 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso5316339e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:44:54 -0700 (PDT)
X-Received: by 2002:a05:6512:2527:b0:4fa:a0c3:ef9d with SMTP id
 be39-20020a056512252700b004faa0c3ef9dmr8121152lfb.18.1687974294238; Wed, 28
 Jun 2023 10:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local> <CAFUsyfKYQk87fxCDj9FpM9xzLwZVRrfUZgyUCF5G+HuC0N2pXg@mail.gmail.com>
In-Reply-To: <CAFUsyfKYQk87fxCDj9FpM9xzLwZVRrfUZgyUCF5G+HuC0N2pXg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 10:44:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1fe4Pa0zLxUTiMjaxEXW84HBup+Hv=fe-U8PoFzrm5g@mail.gmail.com>
Message-ID: <CAHk-=wj1fe4Pa0zLxUTiMjaxEXW84HBup+Hv=fe-U8PoFzrm5g@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        edumazet@google.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000033860005ff34249b"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000033860005ff34249b
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 08:32, Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> Linus, if you're planning a patch and want to just integrate the codes
> here I'm happy drop this patch

No, that patch looks good to me.

In fact, I wasn't planning on integrating my patch at all. I literally
did it as a "I would have done it this way instead" exercise.

And while I am currently running with my patch in the kernel, I don't
even really know if it works and does the right thing. Maybe my use
doesn't even trigger csum_partial() at all. I did not do any testing
that "yes, I get the same checksum as a result".

So

 (a) removing the pointless one-byte alignment looks good to me.

 (b) I'd actually hope that somebody who _cares_ about this path and
has put some real work into it (as opposed to my "superficial
dabbling") would look at my patch and either go "yeah, not worth it",
or "looks good, I'll take it".

and I'm including that final patch of mine here again in case there
was any confusion with the earlier versions (there were at least two
known-broken versions I posted).

*If* somebody likes it, and verifies that the checksum result is
correct, feel free to do anything with that patch, including adding my
signed-off-by for it (or taking the credit all for yourself -
Mwahahahahaahaa!)

              Linus

--00000000000033860005ff34249b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Silly-csum-improvement.-Maybe.patch"
Content-Disposition: attachment; 
	filename="0001-Silly-csum-improvement.-Maybe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljg0at1j0>
X-Attachment-Id: f_ljg0at1j0

RnJvbSAyNGExZDUzM2Q5NjA3NDIyMDkyN2Q4NDRhNjE5YTU0NDE5YjY5YjgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMjcgSnVuIDIwMjMgMTM6NTU6MzIgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBTaWxseSBjc3VtIGltcHJvdmVtZW50LiBNYXliZS4KCi0tLQogYXJjaC94ODYvbGli
L2NzdW0tcGFydGlhbF82NC5jIHwgODMgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDQ1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYyBiL2FyY2gveDg2L2xpYi9j
c3VtLXBhcnRpYWxfNjQuYwppbmRleCBjZWEyNWNhOGI4Y2YuLmQ5NmUxZGE2NjA0YSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYvbGliL2NzdW0tcGFydGlhbF82NC5jCisrKyBiL2FyY2gveDg2L2xpYi9j
c3VtLXBhcnRpYWxfNjQuYwpAQCAtMzMsNiArMzMsMjAgQEAgc3RhdGljIGlubGluZSBfX3dzdW0g
Y3N1bV90YWlsKHU2NCB0ZW1wNjQsIGludCBvZGQpCiAJcmV0dXJuIChfX2ZvcmNlIF9fd3N1bSly
ZXN1bHQ7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB1cGRhdGVfY3N1bV80MGIo
dW5zaWduZWQgbG9uZyBzdW0sIGNvbnN0IHVuc2lnbmVkIGxvbmcgbVs1XSkKK3sKKwlhc20oImFk
ZHEgJTEsJTBcblx0IgorCSAgICAgImFkY3EgJTIsJTBcblx0IgorCSAgICAgImFkY3EgJTMsJTBc
blx0IgorCSAgICAgImFkY3EgJTQsJTBcblx0IgorCSAgICAgImFkY3EgJTUsJTBcblx0IgorCSAg
ICAgImFkY3EgJDAsJTAiCisJCToiK3IiIChzdW0pCisJCToibSIgKG1bMF0pLCAibSIgKG1bMV0p
LCAibSIgKG1bMl0pLAorCQkgIm0iIChtWzNdKSwgIm0iIChtWzRdKSk7CisJcmV0dXJuIHN1bTsK
K30KKwogLyoKICAqIERvIGEgY2hlY2tzdW0gb24gYW4gYXJiaXRyYXJ5IG1lbW9yeSBhcmVhLgog
ICogUmV0dXJucyBhIDMyYml0IGNoZWNrc3VtLgpAQCAtNTksNTIgKzczLDMxIEBAIF9fd3N1bSBj
c3VtX3BhcnRpYWwoY29uc3Qgdm9pZCAqYnVmZiwgaW50IGxlbiwgX193c3VtIHN1bSkKIAkJYnVm
ZisrOwogCX0KIAotCS8qCi0JICogbGVuID09IDQwIGlzIHRoZSBob3QgY2FzZSBkdWUgdG8gSVB2
NiBoZWFkZXJzLCBidXQgYW5ub3RhdGluZyBpdCBsaWtlbHkoKQotCSAqIGhhcyBub3RpY2VhYmxl
IG5lZ2F0aXZlIGFmZmVjdCBvbiBjb2RlZ2VuIGZvciBhbGwgb3RoZXIgY2FzZXMgd2l0aAotCSAq
IG1pbmltYWwgcGVyZm9ybWFuY2UgYmVuZWZpdCBoZXJlLgotCSAqLwotCWlmIChsZW4gPT0gNDAp
IHsKLQkJYXNtKCJhZGRxIDAqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAxKjgo
JVtzcmNdKSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgMio4KCVbc3JjXSksJVtyZXNdXG5cdCIK
LQkJICAgICJhZGNxIDMqOCglW3NyY10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSA0KjgoJVtz
cmNdKSwlW3Jlc11cblx0IgotCQkgICAgImFkY3EgJDAsJVtyZXNdIgotCQkgICAgOiBbcmVzXSAi
K3IiKHRlbXA2NCkKLQkJICAgIDogW3NyY10gInIiKGJ1ZmYpLCAibSIoKihjb25zdCBjaGFyKCop
WzQwXSlidWZmKSk7Ci0JCXJldHVybiBjc3VtX3RhaWwodGVtcDY0LCBvZGQpOwotCX0KLQlpZiAo
dW5saWtlbHkobGVuID49IDY0KSkgewotCQkvKgotCQkgKiBFeHRyYSBhY2N1bXVsYXRvcnMgZm9y
IGJldHRlciBJTFAgaW4gdGhlIGxvb3AuCi0JCSAqLwotCQl1NjQgdG1wX2FjY3VtLCB0bXBfY2Fy
cmllczsKKwkvKiBEbyB0d28gNDAtYnl0ZSBjaHVua3MgaW4gcGFyYWxsZWwgdG8gZ2V0IGJldHRl
ciBJTFAgKi8KKwlpZiAobGlrZWx5KGxlbiA+PSA4MCkpIHsKKwkJdTY0IHRlbXA2NF8yID0gMDsK
KwkJZG8geworCQkJdGVtcDY0ID0gdXBkYXRlX2NzdW1fNDBiKHRlbXA2NCwgYnVmZik7CisJCQl0
ZW1wNjRfMiA9IHVwZGF0ZV9jc3VtXzQwYih0ZW1wNjRfMiwgYnVmZiArIDQwKTsKKwkJCWJ1ZmYg
Kz0gODA7CisJCQlsZW4gLT0gODA7CisJCX0gd2hpbGUgKGxlbiA+PSA4MCk7CiAKLQkJYXNtKCJ4
b3JsICVrW3RtcF9hY2N1bV0sJWtbdG1wX2FjY3VtXVxuXHQiCi0JCSAgICAieG9ybCAla1t0bXBf
Y2Fycmllc10sJWtbdG1wX2NhcnJpZXNdXG5cdCIKLQkJICAgICJzdWJsICQ2NCwgJVtsZW5dXG5c
dCIKLQkJICAgICIxOlxuXHQiCi0JCSAgICAiYWRkcSAwKjgoJVtzcmNdKSwlW3Jlc11cblx0Igot
CQkgICAgImFkY3EgMSo4KCVbc3JjXSksJVtyZXNdXG5cdCIKLQkJICAgICJhZGNxIDIqOCglW3Ny
Y10pLCVbcmVzXVxuXHQiCi0JCSAgICAiYWRjcSAzKjgoJVtzcmNdKSwlW3Jlc11cblx0IgotCQkg
ICAgImFkY2wgJDAsJWtbdG1wX2NhcnJpZXNdXG5cdCIKLQkJICAgICJhZGRxIDQqOCglW3NyY10p
LCVbdG1wX2FjY3VtXVxuXHQiCi0JCSAgICAiYWRjcSA1KjgoJVtzcmNdKSwlW3RtcF9hY2N1bV1c
blx0IgotCQkgICAgImFkY3EgNio4KCVbc3JjXSksJVt0bXBfYWNjdW1dXG5cdCIKLQkJICAgICJh
ZGNxIDcqOCglW3NyY10pLCVbdG1wX2FjY3VtXVxuXHQiCi0JCSAgICAiYWRjbCAkMCwla1t0bXBf
Y2Fycmllc11cblx0IgotCQkgICAgImFkZHEgJDY0LCAlW3NyY11cblx0IgotCQkgICAgInN1Ymwg
JDY0LCAlW2xlbl1cblx0IgotCQkgICAgImpnZSAxYlxuXHQiCi0JCSAgICAiYWRkcSAlW3RtcF9h
Y2N1bV0sJVtyZXNdXG5cdCIKLQkJICAgICJhZGNxICVbdG1wX2NhcnJpZXNdLCVbcmVzXVxuXHQi
Ci0JCSAgICAiYWRjcSAkMCwlW3Jlc10iCi0JCSAgICA6IFt0bXBfYWNjdW1dICI9JnIiKHRtcF9h
Y2N1bSksCi0JCSAgICAgIFt0bXBfY2Fycmllc10gIj0mciIodG1wX2NhcnJpZXMpLCBbcmVzXSAi
K3IiKHRlbXA2NCksCi0JCSAgICAgIFtsZW5dICIrciIobGVuKSwgW3NyY10gIityIihidWZmKQot
CQkgICAgOiAibSIoKihjb25zdCBjaGFyICopYnVmZikpOworCQlhc20oImFkZHEgJTEsJTBcblx0
IgorCQkgICAgImFkY3EgJDAsJTAiCisJCSAgICA6IityIiAodGVtcDY0KTogInIiICh0ZW1wNjRf
MikpOworCX0KKworCS8qCisJICogbGVuID09IDQwIGlzIHRoZSBob3QgY2FzZSBkdWUgdG8gSVB2
NiBoZWFkZXJzLCBzbyByZXR1cm4KKwkgKiBlYXJseSBmb3IgdGhhdCBleGFjdCBjYXNlIHdpdGhv
dXQgY2hlY2tpbmcgdGhlIHRhaWwgYnl0ZXMuCisJICovCisJaWYgKGxlbiA+PSA0MCkgeworCQl0
ZW1wNjQgPSB1cGRhdGVfY3N1bV80MGIodGVtcDY0LCBidWZmKTsKKwkJbGVuIC09IDQwOworCQlp
ZiAoIWxlbikKKwkJCXJldHVybiBjc3VtX3RhaWwodGVtcDY0LCBvZGQpOworCQlidWZmICs9IDQw
OwogCX0KIAogCWlmIChsZW4gJiAzMikgewotLSAKMi40MS4wLjIwMy5nYTRmMmNkMzJiYi5kaXJ0
eQoK
--00000000000033860005ff34249b--
