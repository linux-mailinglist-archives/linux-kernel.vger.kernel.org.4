Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2527405CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjF0VpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjF0VpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:45:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11126AC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:45:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso2716778a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687902315; x=1690494315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+g/SHNbF7IyJUGpKyR3nCgsrDSWEANgM8Hk0z6POdA=;
        b=Yx1vHaeuOsjyYy6rXDBi9j23eoSBAYc02d9bI4uXVpi7QwuqY2WDfuXmMz1s50FlF/
         HIuRji5l/bYVc8QCvOJnabhyHs3qKeGb1bdfATWQMPU+AHRyc5zBeXuptWZ6Luqip8DA
         SmIwnSZZLD2GIf7Yg18shVdFStxgVfnM4DUww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902315; x=1690494315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+g/SHNbF7IyJUGpKyR3nCgsrDSWEANgM8Hk0z6POdA=;
        b=X7/WPNVbguGA4TllEhd1/pxzIa3UPWhdb0VrexG05oQrD3+vUlQf6xEGeVwMbpGIBB
         BvquCCGO9jXv1m9rCh5svSvgsMrRmqVqDeGeK4pRy4QSl5pzJ3+i3+bbl5SpB1YcNPtD
         OAmP8e/wAd95B1zwuHgPZ/ZCR0xzCYknFiwZHzC6fZzPl66NEWfNcPid0Skke3tp+JGA
         2hT5oFjsJw1vFExAQpj2qcUTLmT+c0pFlRbKc4QdFmiFjfBhBBRSE166F74Oz9l7oYqJ
         mJ+SJCXEzAxdgCIdZwBNKe9INn7EQ6lsMl1aZzbTPMMgl0Dp4tm3lK7CwTncRjy7AS+5
         2UFw==
X-Gm-Message-State: AC+VfDy3JG41Ck4wSC3eRlSexwRl5a2j14YED9lrYftqeaeH2KyUokAF
        4nwSQjoEPfcxCy9nbRAXycKq/f/BdIaV6IhFTl1KzkBO
X-Google-Smtp-Source: ACHHUZ7xkFjbTQmKOipgaT2s00sfqzhtkx8AhRwumJcQp0pDrqQdJS7TIuAsoHIcenZi20eBhg5dOA==
X-Received: by 2002:a05:6402:5141:b0:51b:e943:d192 with SMTP id n1-20020a056402514100b0051be943d192mr11706218edd.19.1687902315043;
        Tue, 27 Jun 2023 14:45:15 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id e2-20020a50ec82000000b0051dac65fa3csm944943edr.93.2023.06.27.14.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:45:12 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51d894b9b6cso3572907a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:45:12 -0700 (PDT)
X-Received: by 2002:aa7:d947:0:b0:51a:468c:b46c with SMTP id
 l7-20020aa7d947000000b0051a468cb46cmr22183298eds.30.1687902312308; Tue, 27
 Jun 2023 14:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
 <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local> <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
In-Reply-To: <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 14:44:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixYgM6Lz723vzAz8FoOH92zmydR20+J5xyn5yE_e-gpA@mail.gmail.com>
Message-ID: <CAHk-=wixYgM6Lz723vzAz8FoOH92zmydR20+J5xyn5yE_e-gpA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Borislav Petkov <bp@alien8.de>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000be810c05ff236164"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000be810c05ff236164
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jun 2023 at 13:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, before I throw my patch away, I'll just post it with the
> trivial fixes to use "+r", and with the "volatile" removed (I add
> "volatile" to asms by habit, but this one really isn't volatile).

Oh, never mind. I was about to throw it away, and then I realized that
the code *after* the loop relied on the range having been reduced down
to below 64 bytes, and checked for 32/16/8/4 byte ranges.

And my change to make it loop over 80 bytes had made that no longer be true.

But now I'm committed, and decided to fix that too, and just
re-organize the code to get all the cases right.

And now I'm going to actually boot-test the end result too.  Because
life is too short to spend all my time _just_ with merging.

               Linus

--000000000000be810c05ff236164
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Silly-csum-improvement.-Maybe.patch"
Content-Disposition: attachment; 
	filename="0001-Silly-csum-improvement.-Maybe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljetg0s70>
X-Attachment-Id: f_ljetg0s70

RnJvbSA3YWMxYjk5NTI4MTVkMDRkMTkwNmNjNmRkMDFiY2Y3NDJkNmE2ODkzIE1vbiBTZXAgMTcg
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
--000000000000be810c05ff236164--
