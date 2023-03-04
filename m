Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D26AAC98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCDVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:01:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34951B56C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 13:01:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u9so23751266edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677963696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rTqAZV6NnaF+BuzP84YYZ0fwXjGGKlLExj98t3olyRc=;
        b=KG79ZoClPdr8OGohiMoRdoOVaq7zYY0bnmnoQKELVjbdhHIUCH28b6Vv15za3fgt2Y
         E6ty4VLBPU7mpYHLH9fioNMuDB1hw2U3W6tiv3Ry+GIWmREDU1dNWWRFPggeblZY92dP
         FeMXajnSMl42A82w+Bgb4k+FQFVgiF9qUMaUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677963696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTqAZV6NnaF+BuzP84YYZ0fwXjGGKlLExj98t3olyRc=;
        b=mhP3PzjHjVEXtPWLLt1VWudfLexAUoRqhsmokuGErzllBm0BxWu5jc+EWCFCVHjS1m
         rd5E0jCPaQRt4zDiRCZS3r/fX/W1x/8Mqy8gW4HwNEciU9z8fb04u+5KKYDKVfZ5Qs4T
         51gIrbFdSGKfd/PKY7kloH0HrIuJPNKKb+bcizInaWba2r8A5IYuc9u3LnEdu5IV7Y+l
         T3CRtzcjsOjuI3bd8AfeS2B1sIEQTyJ938+NNjGghkuMPJ0BZEPsybRHHG1KTt1hncCq
         s9VVlx8GlqywM1Nm+7roR7S1xR+E06/UiqKN6GsUKkHRVBWK077hg0SUDZEaciyfwa47
         EkWg==
X-Gm-Message-State: AO0yUKUBSUT1pfVVQb0R5YIpfDwbe++/wKNjsOx8QucONNrzPWIuDwLh
        jxxH2w2PeyisQMbAvCGGV4Y7XyEjCDNaV4TuiielFg==
X-Google-Smtp-Source: AK7set8T+y/9bXa5K/YJ5aPoeisO6x2WLehl098wK87QY/kjZez7mVfnboOZojZwc3OOwD41XrSNUA==
X-Received: by 2002:a17:907:20aa:b0:878:814d:bc99 with SMTP id pw10-20020a17090720aa00b00878814dbc99mr5964733ejb.66.1677963695972;
        Sat, 04 Mar 2023 13:01:35 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709064ad900b008c22a35e684sm2400151ejt.196.2023.03.04.13.01.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:01:34 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id cy23so23525416edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:01:33 -0800 (PST)
X-Received: by 2002:a50:bae3:0:b0:4c0:ef64:9299 with SMTP id
 x90-20020a50bae3000000b004c0ef649299mr3306882ede.5.1677963693249; Sat, 04 Mar
 2023 13:01:33 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop>
In-Reply-To: <ZAOvUuxJP7tAKc1e@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 13:01:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
Message-ID: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e204f405f6195d05"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e204f405f6195d05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 4, 2023 at 12:51=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> > That particular code sequence is arguably broken to begin with.
> > setall() should really only be used as a mask, most definitely not as
> > some kind of "all possible cpus".
>
> Sorry, don't understand this.

See the example patch I sent out.

Literally just make the rule be "we play games with cpumasks in that
they have two different 'sizes', so just make sure the bits in the
bigger and faster size are always clear".

That simple rule just means that we can then use that bigger constant
size in all cases where "upper bits zero" just don't matter.

Which is basically all of them.

Your for_each_cpu_not() example is actually a great example: it should
damn well not exist at all. I hadn't even noticed how broken it was.
Exactly like the other broken case (that I *did* notice -
cpumask_complement), it has no actual valid users. It _literally_ only
exists as a pointless test-case.

So this is *literally* what I'm talking about: you are making up silly
cases that then act as "arguments" for making all the _real_ cases
slower.

Stop it.

Silly useless cases are just that - silly and useless. They should not
be arguments for the real cases then being optimized and simplified.

Updated patch to remove 'for_each_cpu_not()' attached.

It's still completely untested. Treat this very much as a "Let's make
the common cases faster, at least for !MAXSMP".

                   Linus

--000000000000e204f405f6195d05
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_leug8vnc0>
X-Attachment-Id: f_leug8vnc0

IC5jbGFuZy1mb3JtYXQgICAgICAgICAgIHwgIDEgLQogYXJjaC9pYTY0L2tlcm5lbC9hY3BpLmMg
fCAgNCArLS0KIGluY2x1ZGUvbGludXgvY3B1bWFzay5oIHwgNjggKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogbGliL2NwdW1hc2tfa3VuaXQuYyAgICAg
fCAxMiAtLS0tLS0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgNDggZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvLmNsYW5nLWZvcm1hdCBiLy5jbGFuZy1mb3JtYXQKaW5k
ZXggMmM2MWI0NTUzMzc0Li5kOTg4ZTlmYTliMjYgMTAwNjQ0Ci0tLSBhLy5jbGFuZy1mb3JtYXQK
KysrIGIvLmNsYW5nLWZvcm1hdApAQCAtMjI2LDcgKzIyNiw2IEBAIEZvckVhY2hNYWNyb3M6CiAg
IC0gJ2Zvcl9lYWNoX2NvbnNvbGVfc3JjdScKICAgLSAnZm9yX2VhY2hfY3B1JwogICAtICdmb3Jf
ZWFjaF9jcHVfYW5kJwotICAtICdmb3JfZWFjaF9jcHVfbm90JwogICAtICdmb3JfZWFjaF9jcHVf
d3JhcCcKICAgLSAnZm9yX2VhY2hfZGFwbV93aWRnZXRzJwogICAtICdmb3JfZWFjaF9kZWR1cF9j
YW5kJwpkaWZmIC0tZ2l0IGEvYXJjaC9pYTY0L2tlcm5lbC9hY3BpLmMgYi9hcmNoL2lhNjQva2Vy
bmVsL2FjcGkuYwppbmRleCA5NmQxM2NiN2MxOWYuLjE1ZjZjZmRkY2MwOCAxMDA2NDQKLS0tIGEv
YXJjaC9pYTY0L2tlcm5lbC9hY3BpLmMKKysrIGIvYXJjaC9pYTY0L2tlcm5lbC9hY3BpLmMKQEAg
LTc4MywxMSArNzgzLDkgQEAgX19pbml0IHZvaWQgcHJlZmlsbF9wb3NzaWJsZV9tYXAodm9pZCkK
IAogc3RhdGljIGludCBfYWNwaV9tYXBfbHNhcGljKGFjcGlfaGFuZGxlIGhhbmRsZSwgaW50IHBo
eXNpZCwgaW50ICpwY3B1KQogewotCWNwdW1hc2tfdCB0bXBfbWFwOwogCWludCBjcHU7CiAKLQlj
cHVtYXNrX2NvbXBsZW1lbnQoJnRtcF9tYXAsIGNwdV9wcmVzZW50X21hc2spOwotCWNwdSA9IGNw
dW1hc2tfZmlyc3QoJnRtcF9tYXApOworCWNwdSA9IGNwdW1hc2tfZmlyc3RfemVybyhjcHVfcHJl
c2VudF9tYXNrKTsKIAlpZiAoY3B1ID49IG5yX2NwdV9pZHMpCiAJCXJldHVybiAtRUlOVkFMOwog
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaCBiL2luY2x1ZGUvbGludXgvY3B1
bWFzay5oCmluZGV4IDEwYzkyYmQ5YjgwNy4uYzhiYjAzMmFmYTdkIDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L2NwdW1hc2suaAorKysgYi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaApAQCAtNTAs
OCArNTAsMzAgQEAgc3RhdGljIGlubGluZSB2b2lkIHNldF9ucl9jcHVfaWRzKHVuc2lnbmVkIGlu
dCBucikKICNlbmRpZgogfQogCi0vKiBEZXByZWNhdGVkLiBBbHdheXMgdXNlIG5yX2NwdV9pZHMu
ICovCi0jZGVmaW5lIG5yX2NwdW1hc2tfYml0cwlucl9jcHVfaWRzCisvKgorICogVGhlIGRpZmZl
cmVuY2UgYmV0d2VlbiBucl9jcHVtYXNrX2JpdHMgYW5kIG5yX2NwdV9pZHMgaXMgdGhhdAorICog
J25yX2NwdV9pZHMnIGlzIHRoZSBhY3R1YWwgbnVtYmVyIG9mIENQVSBpZHMgaW4gdGhlIHN5c3Rl
bSwgd2hpbGUKKyAqIG5yX2NwdW1hc2tfYml0cyBpcyBhICJyZWFzb25hYmxlIHVwcGVyIHZhbHVl
IiB0aGF0IGlzIG9mdGVuIG1vcmUKKyAqIGVmZmljaWVudCBiZWNhdXNlIGl0IGNhbiBiZSBhIGZp
eGVkIGNvbnN0YW50LgorICoKKyAqIFNvIHdoZW4gY2xlYXJpbmcgb3IgdHJhdmVyc2luZyBhIGNw
dW1hc2ssIHVzZSAnbnJfY3B1bWFza19iaXRzJywKKyAqIGJ1dCB3aGVuIGNoZWNraW5nIGV4YWN0
IGxpbWl0cyAoYW5kIHdoZW4gX3NldHRpbmdfIGJpdHMpLCB1c2UgdGhlCisgKiB0aWdodGVyIGV4
YWN0IGxpbWl0IG9mICducl9jcHVfaWRzJy4KKyAqCisgKiBOT1RFISBUaGUgY29kZSBkZXBlbmRz
IG9uIGFueSBleHl0YSBiaXRzIGluIG5yX2NwdW1hc2tfYml0cyBhIGFsd2F5cworICogYmVpbmcg
KGEpIGFsbG9jYXRlZCBhbmQgKGIpIHplcm8sIHNvIHRoYXQgdGhlIG9ubHkgZWZmZWN0IG9mIHVz
aW5nCisgKiAnbnJfY3B1bWFza19iaXRzJyBpcyB0aGF0IHdlIG1pZ2h0IHJldHVybiBhIGhpZ2hl
ciBtYXhpbXVtIENQVSB2YWx1ZQorICogKHdoaWNoIGlzIHdoeSB3ZSBoYXZlIHRoYXQgcGF0dGVy
biBvZgorICoKKyAqICAgUmV0dXJucyA+PSBucl9jcHVfaWRzIGlmIG5vIGNwdXMgc2V0LgorICoK
KyAqIGZvciBtYW55IG9mIHRoZSBmdW5jdGlvbnMgLSB0aGV5IGNhbiByZXR1cm4gdGhhdCBoaWdo
ZXIgdmFsdWUpLgorICovCisjaWZkZWYgQ09ORklHX0NQVU1BU0tfT0ZGU1RBQ0sKKyAjZGVmaW5l
IG5yX2NwdW1hc2tfYml0cyAoKHVuc2lnbmVkIGludClOUl9DUFVTKQorI2Vsc2UKKyAjZGVmaW5l
IG5yX2NwdW1hc2tfYml0cwlucl9jcHVfaWRzCisjZW5kaWYKIAogLyoKICAqIFRoZSBmb2xsb3dp
bmcgcGFydGljdWxhciBzeXN0ZW0gY3B1bWFza3MgYW5kIG9wZXJhdGlvbnMgbWFuYWdlCkBAIC0x
MTQsNyArMTM2LDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGNwdV9tYXhfYml0c193
YXJuKHVuc2lnbmVkIGludCBjcHUsIHVuc2lnbmVkIGludCBiaXQKIC8qIHZlcmlmeSBjcHUgYXJn
dW1lbnQgdG8gY3B1bWFza18qIG9wZXJhdG9ycyAqLwogc3RhdGljIF9fYWx3YXlzX2lubGluZSB1
bnNpZ25lZCBpbnQgY3B1bWFza19jaGVjayh1bnNpZ25lZCBpbnQgY3B1KQogewotCWNwdV9tYXhf
Yml0c193YXJuKGNwdSwgbnJfY3B1bWFza19iaXRzKTsKKwljcHVfbWF4X2JpdHNfd2FybihjcHUs
IG5yX2NwdV9pZHMpOwogCXJldHVybiBjcHU7CiB9CiAKQEAgLTI0OCwxNiArMjcwLDYgQEAgdW5z
aWduZWQgaW50IGNwdW1hc2tfbmV4dF9hbmQoaW50IG4sIGNvbnN0IHN0cnVjdCBjcHVtYXNrICpz
cmMxcCwKICNkZWZpbmUgZm9yX2VhY2hfY3B1KGNwdSwgbWFzaykJCQkJXAogCWZvcl9lYWNoX3Nl
dF9iaXQoY3B1LCBjcHVtYXNrX2JpdHMobWFzayksIG5yX2NwdW1hc2tfYml0cykKIAotLyoqCi0g
KiBmb3JfZWFjaF9jcHVfbm90IC0gaXRlcmF0ZSBvdmVyIGV2ZXJ5IGNwdSBpbiBhIGNvbXBsZW1l
bnRlZCBtYXNrCi0gKiBAY3B1OiB0aGUgKG9wdGlvbmFsbHkgdW5zaWduZWQpIGludGVnZXIgaXRl
cmF0b3IKLSAqIEBtYXNrOiB0aGUgY3B1bWFzayBwb2ludGVyCi0gKgotICogQWZ0ZXIgdGhlIGxv
b3AsIGNwdSBpcyA+PSBucl9jcHVfaWRzLgotICovCi0jZGVmaW5lIGZvcl9lYWNoX2NwdV9ub3Qo
Y3B1LCBtYXNrKQkJCQlcCi0JZm9yX2VhY2hfY2xlYXJfYml0KGNwdSwgY3B1bWFza19iaXRzKG1h
c2spLCBucl9jcHVtYXNrX2JpdHMpCi0KICNpZiBOUl9DUFVTID09IDEKIHN0YXRpYyBpbmxpbmUK
IHVuc2lnbmVkIGludCBjcHVtYXNrX25leHRfd3JhcChpbnQgbiwgY29uc3Qgc3RydWN0IGNwdW1h
c2sgKm1hc2ssIGludCBzdGFydCwgYm9vbCB3cmFwKQpAQCAtNDk1LDEwICs1MDcsMTQgQEAgc3Rh
dGljIF9fYWx3YXlzX2lubGluZSBib29sIGNwdW1hc2tfdGVzdF9hbmRfY2xlYXJfY3B1KGludCBj
cHUsIHN0cnVjdCBjcHVtYXNrICoKIC8qKgogICogY3B1bWFza19zZXRhbGwgLSBzZXQgYWxsIGNw
dXMgKDwgbnJfY3B1X2lkcykgaW4gYSBjcHVtYXNrCiAgKiBAZHN0cDogdGhlIGNwdW1hc2sgcG9p
bnRlcgorICoKKyAqIE5vdGU6IHNpbmNlIHdlIHNldCBiaXRzLCB3ZSBzaG91bGQgdXNlIHRoZSB0
aWdodGVyICdiaXRtYXBfc2V0KCknIHdpdGgKKyAqIHRoZSBlYWN0IG51bWJlciBvZiBiaXRzLCBu
b3QgJ2JpdG1hcF9maWxsKCknIHRoYXQgd2lsbCBmaWxsIHBhc3QgdGhlCisgKiBlbmQuCiAgKi8K
IHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVtYXNrX3NldGFsbChzdHJ1Y3QgY3B1bWFzayAqZHN0cCkK
IHsKLQliaXRtYXBfZmlsbChjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2NwdW1hc2tfYml0cyk7CisJ
Yml0bWFwX3NldChjcHVtYXNrX2JpdHMoZHN0cCksIDAsIG5yX2NwdV9pZHMpOwogfQogCiAvKioK
QEAgLTU2OSwxOCArNTg1LDYgQEAgc3RhdGljIGlubGluZSBib29sIGNwdW1hc2tfYW5kbm90KHN0
cnVjdCBjcHVtYXNrICpkc3RwLAogCQkJCQkgIGNwdW1hc2tfYml0cyhzcmMycCksIG5yX2NwdW1h
c2tfYml0cyk7CiB9CiAKLS8qKgotICogY3B1bWFza19jb21wbGVtZW50IC0gKmRzdHAgPSB+KnNy
Y3AKLSAqIEBkc3RwOiB0aGUgY3B1bWFzayByZXN1bHQKLSAqIEBzcmNwOiB0aGUgaW5wdXQgdG8g
aW52ZXJ0Ci0gKi8KLXN0YXRpYyBpbmxpbmUgdm9pZCBjcHVtYXNrX2NvbXBsZW1lbnQoc3RydWN0
IGNwdW1hc2sgKmRzdHAsCi0JCQkJICAgICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKnNyY3ApCi17
Ci0JYml0bWFwX2NvbXBsZW1lbnQoY3B1bWFza19iaXRzKGRzdHApLCBjcHVtYXNrX2JpdHMoc3Jj
cCksCi0JCQkJCSAgICAgIG5yX2NwdW1hc2tfYml0cyk7Ci19Ci0KIC8qKgogICogY3B1bWFza19l
cXVhbCAtICpzcmMxcCA9PSAqc3JjMnAKICAqIEBzcmMxcDogdGhlIGZpcnN0IGlucHV0CkBAIC02
NDgsNyArNjUyLDcgQEAgc3RhdGljIGlubGluZSBib29sIGNwdW1hc2tfZW1wdHkoY29uc3Qgc3Ry
dWN0IGNwdW1hc2sgKnNyY3ApCiAgKi8KIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVtYXNrX2Z1bGwo
Y29uc3Qgc3RydWN0IGNwdW1hc2sgKnNyY3ApCiB7Ci0JcmV0dXJuIGJpdG1hcF9mdWxsKGNwdW1h
c2tfYml0cyhzcmNwKSwgbnJfY3B1bWFza19iaXRzKTsKKwlyZXR1cm4gYml0bWFwX2Z1bGwoY3B1
bWFza19iaXRzKHNyY3ApLCBucl9jcHVfaWRzKTsKIH0KIAogLyoqCkBAIC02OTQsNyArNjk4LDcg
QEAgc3RhdGljIGlubGluZSB2b2lkIGNwdW1hc2tfc2hpZnRfbGVmdChzdHJ1Y3QgY3B1bWFzayAq
ZHN0cCwKIAkJCQkgICAgICBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqc3JjcCwgaW50IG4pCiB7CiAJ
Yml0bWFwX3NoaWZ0X2xlZnQoY3B1bWFza19iaXRzKGRzdHApLCBjcHVtYXNrX2JpdHMoc3JjcCks
IG4sCi0JCQkJCSAgICAgIG5yX2NwdW1hc2tfYml0cyk7CisJCQkJCSAgICAgIG5yX2NwdV9pZHMp
OwogfQogCiAvKioKQEAgLTc0Miw3ICs3NDYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3B1bWFz
a19jb3B5KHN0cnVjdCBjcHVtYXNrICpkc3RwLAogc3RhdGljIGlubGluZSBpbnQgY3B1bWFza19w
YXJzZV91c2VyKGNvbnN0IGNoYXIgX191c2VyICpidWYsIGludCBsZW4sCiAJCQkJICAgICBzdHJ1
Y3QgY3B1bWFzayAqZHN0cCkKIHsKLQlyZXR1cm4gYml0bWFwX3BhcnNlX3VzZXIoYnVmLCBsZW4s
IGNwdW1hc2tfYml0cyhkc3RwKSwgbnJfY3B1bWFza19iaXRzKTsKKwlyZXR1cm4gYml0bWFwX3Bh
cnNlX3VzZXIoYnVmLCBsZW4sIGNwdW1hc2tfYml0cyhkc3RwKSwgbnJfY3B1X2lkcyk7CiB9CiAK
IC8qKgpAQCAtNzU3LDcgKzc2MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNwdW1hc2tfcGFyc2Vs
aXN0X3VzZXIoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwgaW50IGxlbiwKIAkJCQkgICAgIHN0cnVj
dCBjcHVtYXNrICpkc3RwKQogewogCXJldHVybiBiaXRtYXBfcGFyc2VsaXN0X3VzZXIoYnVmLCBs
ZW4sIGNwdW1hc2tfYml0cyhkc3RwKSwKLQkJCQkgICAgIG5yX2NwdW1hc2tfYml0cyk7CisJCQkJ
ICAgICBucl9jcHVfaWRzKTsKIH0KIAogLyoqCkBAIC03NjksNyArNzczLDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgY3B1bWFza19wYXJzZWxpc3RfdXNlcihjb25zdCBjaGFyIF9fdXNlciAqYnVmLCBp
bnQgbGVuLAogICovCiBzdGF0aWMgaW5saW5lIGludCBjcHVtYXNrX3BhcnNlKGNvbnN0IGNoYXIg
KmJ1Ziwgc3RydWN0IGNwdW1hc2sgKmRzdHApCiB7Ci0JcmV0dXJuIGJpdG1hcF9wYXJzZShidWYs
IFVJTlRfTUFYLCBjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2NwdW1hc2tfYml0cyk7CisJcmV0dXJu
IGJpdG1hcF9wYXJzZShidWYsIFVJTlRfTUFYLCBjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2NwdV9p
ZHMpOwogfQogCiAvKioKQEAgLTc4MSw3ICs3ODUsNyBAQCBzdGF0aWMgaW5saW5lIGludCBjcHVt
YXNrX3BhcnNlKGNvbnN0IGNoYXIgKmJ1Ziwgc3RydWN0IGNwdW1hc2sgKmRzdHApCiAgKi8KIHN0
YXRpYyBpbmxpbmUgaW50IGNwdWxpc3RfcGFyc2UoY29uc3QgY2hhciAqYnVmLCBzdHJ1Y3QgY3B1
bWFzayAqZHN0cCkKIHsKLQlyZXR1cm4gYml0bWFwX3BhcnNlbGlzdChidWYsIGNwdW1hc2tfYml0
cyhkc3RwKSwgbnJfY3B1bWFza19iaXRzKTsKKwlyZXR1cm4gYml0bWFwX3BhcnNlbGlzdChidWYs
IGNwdW1hc2tfYml0cyhkc3RwKSwgbnJfY3B1X2lkcyk7CiB9CiAKIC8qKgpkaWZmIC0tZ2l0IGEv
bGliL2NwdW1hc2tfa3VuaXQuYyBiL2xpYi9jcHVtYXNrX2t1bml0LmMKaW5kZXggZDFmYzZlY2Uy
MWYzLi5hYjc5ODM2NWI3ZGMgMTAwNjQ0Ci0tLSBhL2xpYi9jcHVtYXNrX2t1bml0LmMKKysrIGIv
bGliL2NwdW1hc2tfa3VuaXQuYwpAQCAtMjMsMTYgKzIzLDYgQEAKIAkJS1VOSVRfRVhQRUNUX0VR
X01TRygodGVzdCksIG1hc2tfd2VpZ2h0LCBpdGVyLCBNQVNLX01TRyhtYXNrKSk7CVwKIAl9IHdo
aWxlICgwKQogCi0jZGVmaW5lIEVYUEVDVF9GT1JfRUFDSF9DUFVfTk9UX0VRKHRlc3QsIG1hc2sp
CQkJCQlcCi0JZG8gewkJCQkJCQkJCVwKLQkJY29uc3QgY3B1bWFza190ICptID0gKG1hc2spOwkJ
CQkJXAotCQlpbnQgbWFza193ZWlnaHQgPSBjcHVtYXNrX3dlaWdodChtKTsJCQkJXAotCQlpbnQg
Y3B1LCBpdGVyID0gMDsJCQkJCQlcCi0JCWZvcl9lYWNoX2NwdV9ub3QoY3B1LCBtKQkJCQkJXAot
CQkJaXRlcisrOwkJCQkJCQlcCi0JCUtVTklUX0VYUEVDVF9FUV9NU0coKHRlc3QpLCBucl9jcHVf
aWRzIC0gbWFza193ZWlnaHQsIGl0ZXIsIE1BU0tfTVNHKG1hc2spKTsJXAotCX0gd2hpbGUgKDAp
Ci0KICNkZWZpbmUgRVhQRUNUX0ZPUl9FQUNIX0NQVV9PUF9FUSh0ZXN0LCBvcCwgbWFzazEsIG1h
c2syKQkJCVwKIAlkbyB7CQkJCQkJCQkJXAogCQljb25zdCBjcHVtYXNrX3QgKm0xID0gKG1hc2sx
KTsJCQkJCVwKQEAgLTExMywxNCArMTAzLDEyIEBAIHN0YXRpYyB2b2lkIHRlc3RfY3B1bWFza19u
ZXh0KHN0cnVjdCBrdW5pdCAqdGVzdCkKIHN0YXRpYyB2b2lkIHRlc3RfY3B1bWFza19pdGVyYXRv
cnMoc3RydWN0IGt1bml0ICp0ZXN0KQogewogCUVYUEVDVF9GT1JfRUFDSF9DUFVfRVEodGVzdCwg
Jm1hc2tfZW1wdHkpOwotCUVYUEVDVF9GT1JfRUFDSF9DUFVfTk9UX0VRKHRlc3QsICZtYXNrX2Vt
cHR5KTsKIAlFWFBFQ1RfRk9SX0VBQ0hfQ1BVX1dSQVBfRVEodGVzdCwgJm1hc2tfZW1wdHkpOwog
CUVYUEVDVF9GT1JfRUFDSF9DUFVfT1BfRVEodGVzdCwgYW5kLCAmbWFza19lbXB0eSwgJm1hc2tf
ZW1wdHkpOwogCUVYUEVDVF9GT1JfRUFDSF9DUFVfT1BfRVEodGVzdCwgYW5kLCBjcHVfcG9zc2li
bGVfbWFzaywgJm1hc2tfZW1wdHkpOwogCUVYUEVDVF9GT1JfRUFDSF9DUFVfT1BfRVEodGVzdCwg
YW5kbm90LCAmbWFza19lbXB0eSwgJm1hc2tfZW1wdHkpOwogCiAJRVhQRUNUX0ZPUl9FQUNIX0NQ
VV9FUSh0ZXN0LCBjcHVfcG9zc2libGVfbWFzayk7Ci0JRVhQRUNUX0ZPUl9FQUNIX0NQVV9OT1Rf
RVEodGVzdCwgY3B1X3Bvc3NpYmxlX21hc2spOwogCUVYUEVDVF9GT1JfRUFDSF9DUFVfV1JBUF9F
USh0ZXN0LCBjcHVfcG9zc2libGVfbWFzayk7CiAJRVhQRUNUX0ZPUl9FQUNIX0NQVV9PUF9FUSh0
ZXN0LCBhbmQsIGNwdV9wb3NzaWJsZV9tYXNrLCBjcHVfcG9zc2libGVfbWFzayk7CiAJRVhQRUNU
X0ZPUl9FQUNIX0NQVV9PUF9FUSh0ZXN0LCBhbmRub3QsIGNwdV9wb3NzaWJsZV9tYXNrLCAmbWFz
a19lbXB0eSk7Cg==
--000000000000e204f405f6195d05--
