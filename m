Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F776ACDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCFTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCFTTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:19:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0399E305D4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:19:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i34so43110875eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678130370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26htM1axkal7sqOhMrnjS0P/S0qx0VUSglB5M8yc+lw=;
        b=WrIOunxLdtzj5NYHGJNgIqU3aqwk2ohPiMCAHDyNXyUZ7cQhs7urMrC9i4Xz8xmKNx
         qc9ut+WZjeQUXvPda8kuYshgkEPnpk2ux+fwTP9Fru1ISSKbMpEIwcuqX206xI1S/AsH
         7X9/rI9rCl+ZDT0nVutGm4itHyVl0xBNH6fbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26htM1axkal7sqOhMrnjS0P/S0qx0VUSglB5M8yc+lw=;
        b=t1MN6UeOVIdn1rcKZnoVZj4mMv1A7Y9kP6eisUlmwTdePh7Nzb9wg630N1axV2edPS
         RCcq/qm9eJIaowcfYhWvZxIr2+TvqfyCqmJ61Pt4TxD2kEnf0kqTutiGTHmNcvLDU0wO
         eR4+FO8fxcRUInKAi/Q0zg8PsEt/pHd7PykC10lSizNEyCEhcnM6vchl5v6r2IPf17dg
         GccqWD/xKqrQZ9MiD8N6lXV2E+l3XMJ0wKZanPgJ1grdZNNcm6ZefhBODK2smAtom0BE
         JEYhP515/JQ9uDF9UVQKgQGcm60hS2QlJbxxOT4nkX0Sdijojbgp3+1vwp+0O6buf1fg
         yAhg==
X-Gm-Message-State: AO0yUKUd6l/37AIQ+yJzc5VPol2rRZ/e5MJVbCcwKtc2LZe9JxAJciBr
        InNaGp8l10XgGCnjTCEQvVAXTMvTQiWiCj51WQiCSg==
X-Google-Smtp-Source: AK7set/lTimx5lEsudHCKkoQBh3uavsk4OcqWTngAVbFbC5EdDRrMFoQ24OcwHFrSToBoFhJwTcBWQ==
X-Received: by 2002:a17:906:6a14:b0:8b2:7150:dd03 with SMTP id qw20-20020a1709066a1400b008b27150dd03mr17700589ejc.35.1678130370071;
        Mon, 06 Mar 2023 11:19:30 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b008d8f1b238fdsm5017280ejq.149.2023.03.06.11.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:19:29 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id s11so43086677edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:19:29 -0800 (PST)
X-Received: by 2002:a17:906:b10d:b0:878:561c:6665 with SMTP id
 u13-20020a170906b10d00b00878561c6665mr5805618ejy.0.1678130368883; Mon, 06 Mar
 2023 11:19:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdUKo_Sf7TjKzcNDa8Ve+6QrK+P8nSQrSQ=6LTRmcBKNww@mail.gmail.com>
In-Reply-To: <CAMuHMdUKo_Sf7TjKzcNDa8Ve+6QrK+P8nSQrSQ=6LTRmcBKNww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 11:19:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiAxtKyxs6BPEzirrXw1kXJ-7ZyGpgOrbzhmC=ud-6jBA@mail.gmail.com>
Message-ID: <CAHk-=wiAxtKyxs6BPEzirrXw1kXJ-7ZyGpgOrbzhmC=ud-6jBA@mail.gmail.com>
Subject: Re: cpumask: re-introduce constant-sized cpumask optimizations
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000086571e05f6402c49"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000086571e05f6402c49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 6, 2023 at 3:20=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Your final commit 596ff4a09b898179 ("cpumask: re-introduce
> constant-sized cpumask optimizations") in v6.3-rc1 introduced a
> regression.  During Debian userspace startup, the kernel crashes with:

I'm pretty sure the attached patch should fix it. If you can confirm,
that would be lovely.

The only relevant part is actually just the oneliner to
drivers/char/random.c - the others are fixing the exact same problem
elsewhere, but that's not the case you're actually hitting.

> Presumably using small_cpumask_bits instead of nr_cpu_ids accesses
> some uninitialized array members?

No, it's actually the other way around - some drivers end up using
that "nr_cpumask_bits" in invalid ways, and the small_cpumask_bits
optimization then made that just _very_ obvious.

The bug was pre-existing, it's just that you couldn't trigger it before.

> A similar kernel on an arm64 system that does have 8 CPU cores works fine=
.
> On an arm64 system with 2 CPU cores, it crashes in a similar way.

Yeah, it's rather machine-specific, and that's why I never saw it in
my local testing either.

So on my machine I always either filled up the cpumask entirely
(because I did my testing on my beefy desktop), or NR_CPUS was so
large that the problem case never happened in the first place because
nr_cpumask_bits was the same as small_cpumask_bits.

I thought I had tested the interesting cases, but in this case, the
case that fails is actually the really trivial case. It's just that my
big machine would never trigger it, because it has so many cores.

               Linus

--00000000000086571e05f6402c49
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lex7f0du0>
X-Attachment-Id: f_lex7f0du0

IGFyY2gvcG93ZXJwYy94bW9uL3htb24uYyAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvY2hhci9y
YW5kb20uYyAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvbmV0L3dpcmVndWFyZC9xdWV1ZWlu
Zy5oIHwgIDIgKy0KIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jICAgIHwgMTQgKysrKysr
Ky0tLS0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3htb24veG1vbi5jIGIvYXJjaC9wb3dlcnBj
L3htb24veG1vbi5jCmluZGV4IDczYzYyMGMyYTNhMS4uZTc1M2E2YmQ0ODg4IDEwMDY0NAotLS0g
YS9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMKKysrIGIvYXJjaC9wb3dlcnBjL3htb24veG1vbi5j
CkBAIC0xMjc1LDcgKzEyNzUsNyBAQCBzdGF0aWMgaW50IHhtb25fYmF0Y2hfbmV4dF9jcHUodm9p
ZCkKIAl3aGlsZSAoIWNwdW1hc2tfZW1wdHkoJnhtb25fYmF0Y2hfY3B1cykpIHsKIAkJY3B1ID0g
Y3B1bWFza19uZXh0X3dyYXAoc21wX3Byb2Nlc3Nvcl9pZCgpLCAmeG1vbl9iYXRjaF9jcHVzLAog
CQkJCQl4bW9uX2JhdGNoX3N0YXJ0X2NwdSwgdHJ1ZSk7Ci0JCWlmIChjcHUgPT0gbnJfY3B1bWFz
a19iaXRzKQorCQlpZiAoY3B1ID49IG5yX2NwdV9pZHMpCiAJCQlicmVhazsKIAkJaWYgKHhtb25f
YmF0Y2hfc3RhcnRfY3B1ID09IC0xKQogCQkJeG1vbl9iYXRjaF9zdGFydF9jcHUgPSBjcHU7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMgYi9kcml2ZXJzL2NoYXIvcmFuZG9tLmMK
aW5kZXggY2UzY2NkMTcyY2M4Li4yNTNmMmRkYjg5MTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hh
ci9yYW5kb20uYworKysgYi9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKQEAgLTEzMTEsNyArMTMxMSw3
IEBAIHN0YXRpYyB2b2lkIF9fY29sZCB0cnlfdG9fZ2VuZXJhdGVfZW50cm9weSh2b2lkKQogCQkJ
LyogQmFzaWMgQ1BVIHJvdW5kLXJvYmluLCB3aGljaCBhdm9pZHMgdGhlIGN1cnJlbnQgQ1BVLiAq
LwogCQkJZG8gewogCQkJCWNwdSA9IGNwdW1hc2tfbmV4dChjcHUsICZ0aW1lcl9jcHVzKTsKLQkJ
CQlpZiAoY3B1ID09IG5yX2NwdW1hc2tfYml0cykKKwkJCQlpZiAoY3B1ID49IG5yX2NwdV9pZHMp
CiAJCQkJCWNwdSA9IGNwdW1hc2tfZmlyc3QoJnRpbWVyX2NwdXMpOwogCQkJfSB3aGlsZSAoY3B1
ID09IHNtcF9wcm9jZXNzb3JfaWQoKSAmJiBudW1fY3B1cyA+IDEpOwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlZ3VhcmQvcXVldWVpbmcuaCBiL2RyaXZlcnMvbmV0L3dpcmVndWFyZC9x
dWV1ZWluZy5oCmluZGV4IDU4M2FkYjM3ZWUxZS4uMTI1Mjg0YjM0NmE3IDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC93aXJlZ3VhcmQvcXVldWVpbmcuaAorKysgYi9kcml2ZXJzL25ldC93aXJlZ3Vh
cmQvcXVldWVpbmcuaApAQCAtMTA2LDcgKzEwNiw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHdnX2Nw
dW1hc2tfY2hvb3NlX29ubGluZShpbnQgKnN0b3JlZF9jcHUsIHVuc2lnbmVkIGludCBpZCkKIHsK
IAl1bnNpZ25lZCBpbnQgY3B1ID0gKnN0b3JlZF9jcHUsIGNwdV9pbmRleCwgaTsKIAotCWlmICh1
bmxpa2VseShjcHUgPT0gbnJfY3B1bWFza19iaXRzIHx8CisJaWYgKHVubGlrZWx5KGNwdSA+PSBu
cl9jcHVfaWRzIHx8CiAJCSAgICAgIWNwdW1hc2tfdGVzdF9jcHUoY3B1LCBjcHVfb25saW5lX21h
c2spKSkgewogCQljcHVfaW5kZXggPSBpZCAlIGNwdW1hc2tfd2VpZ2h0KGNwdV9vbmxpbmVfbWFz
ayk7CiAJCWNwdSA9IGNwdW1hc2tfZmlyc3QoY3B1X29ubGluZV9tYXNrKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19p
bml0LmMKaW5kZXggNjE5NThhMjRhNDNkLi43M2I1NDRiZmJiMmUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jCisrKyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5p
dC5jCkBAIC0xMjU2Myw3ICsxMjU2Myw3IEBAIGxwZmNfY3B1X2FmZmluaXR5X2NoZWNrKHN0cnVj
dCBscGZjX2hiYSAqcGhiYSwgaW50IHZlY3RvcnMpCiAJCQkJCWdvdG8gZm91bmRfc2FtZTsKIAkJ
CQluZXdfY3B1ID0gY3B1bWFza19uZXh0KAogCQkJCQluZXdfY3B1LCBjcHVfcHJlc2VudF9tYXNr
KTsKLQkJCQlpZiAobmV3X2NwdSA9PSBucl9jcHVtYXNrX2JpdHMpCisJCQkJaWYgKG5ld19jcHUg
Pj0gbnJfY3B1X2lkcykKIAkJCQkJbmV3X2NwdSA9IGZpcnN0X2NwdTsKIAkJCX0KIAkJCS8qIEF0
IHRoaXMgcG9pbnQsIHdlIGxlYXZlIHRoZSBDUFUgYXMgdW5hc3NpZ25lZCAqLwpAQCAtMTI1Nzcs
NyArMTI1NzcsNyBAQCBscGZjX2NwdV9hZmZpbml0eV9jaGVjayhzdHJ1Y3QgbHBmY19oYmEgKnBo
YmEsIGludCB2ZWN0b3JzKQogCQkJICogc2VsZWN0aW5nIHRoZSBzYW1lIElSUS4KIAkJCSAqLwog
CQkJc3RhcnRfY3B1ID0gY3B1bWFza19uZXh0KG5ld19jcHUsIGNwdV9wcmVzZW50X21hc2spOwot
CQkJaWYgKHN0YXJ0X2NwdSA9PSBucl9jcHVtYXNrX2JpdHMpCisJCQlpZiAoc3RhcnRfY3B1ID49
IG5yX2NwdV9pZHMpCiAJCQkJc3RhcnRfY3B1ID0gZmlyc3RfY3B1OwogCiAJCQlscGZjX3ByaW50
Zl9sb2cocGhiYSwgS0VSTl9JTkZPLCBMT0dfSU5JVCwKQEAgLTEyNjEzLDcgKzEyNjEzLDcgQEAg
bHBmY19jcHVfYWZmaW5pdHlfY2hlY2soc3RydWN0IGxwZmNfaGJhICpwaGJhLCBpbnQgdmVjdG9y
cykKIAkJCQkJZ290byBmb3VuZF9hbnk7CiAJCQkJbmV3X2NwdSA9IGNwdW1hc2tfbmV4dCgKIAkJ
CQkJbmV3X2NwdSwgY3B1X3ByZXNlbnRfbWFzayk7Ci0JCQkJaWYgKG5ld19jcHUgPT0gbnJfY3B1
bWFza19iaXRzKQorCQkJCWlmIChuZXdfY3B1ID49IG5yX2NwdV9pZHMpCiAJCQkJCW5ld19jcHUg
PSBmaXJzdF9jcHU7CiAJCQl9CiAJCQkvKiBXZSBzaG91bGQgbmV2ZXIgbGVhdmUgYW4gZW50cnkg
dW5hc3NpZ25lZCAqLwpAQCAtMTI2MzEsNyArMTI2MzEsNyBAQCBscGZjX2NwdV9hZmZpbml0eV9j
aGVjayhzdHJ1Y3QgbHBmY19oYmEgKnBoYmEsIGludCB2ZWN0b3JzKQogCQkJICogc2VsZWN0aW5n
IHRoZSBzYW1lIElSUS4KIAkJCSAqLwogCQkJc3RhcnRfY3B1ID0gY3B1bWFza19uZXh0KG5ld19j
cHUsIGNwdV9wcmVzZW50X21hc2spOwotCQkJaWYgKHN0YXJ0X2NwdSA9PSBucl9jcHVtYXNrX2Jp
dHMpCisJCQlpZiAoc3RhcnRfY3B1ID49IG5yX2NwdV9pZHMpCiAJCQkJc3RhcnRfY3B1ID0gZmly
c3RfY3B1OwogCiAJCQlscGZjX3ByaW50Zl9sb2cocGhiYSwgS0VSTl9JTkZPLCBMT0dfSU5JVCwK
QEAgLTEyNzA0LDcgKzEyNzA0LDcgQEAgbHBmY19jcHVfYWZmaW5pdHlfY2hlY2soc3RydWN0IGxw
ZmNfaGJhICpwaGJhLCBpbnQgdmVjdG9ycykKIAkJCQlnb3RvIGZvdW5kX2hkd3E7CiAJCQl9CiAJ
CQluZXdfY3B1ID0gY3B1bWFza19uZXh0KG5ld19jcHUsIGNwdV9wcmVzZW50X21hc2spOwotCQkJ
aWYgKG5ld19jcHUgPT0gbnJfY3B1bWFza19iaXRzKQorCQkJaWYgKG5ld19jcHUgPj0gbnJfY3B1
X2lkcykKIAkJCQluZXdfY3B1ID0gZmlyc3RfY3B1OwogCQl9CiAKQEAgLTEyNzE5LDcgKzEyNzE5
LDcgQEAgbHBmY19jcHVfYWZmaW5pdHlfY2hlY2soc3RydWN0IGxwZmNfaGJhICpwaGJhLCBpbnQg
dmVjdG9ycykKIAkJCQlnb3RvIGZvdW5kX2hkd3E7CiAKIAkJCW5ld19jcHUgPSBjcHVtYXNrX25l
eHQobmV3X2NwdSwgY3B1X3ByZXNlbnRfbWFzayk7Ci0JCQlpZiAobmV3X2NwdSA9PSBucl9jcHVt
YXNrX2JpdHMpCisJCQlpZiAobmV3X2NwdSA+PSBucl9jcHVfaWRzKQogCQkJCW5ld19jcHUgPSBm
aXJzdF9jcHU7CiAJCX0KIApAQCAtMTI3MzAsNyArMTI3MzAsNyBAQCBscGZjX2NwdV9hZmZpbml0
eV9jaGVjayhzdHJ1Y3QgbHBmY19oYmEgKnBoYmEsIGludCB2ZWN0b3JzKQogIGZvdW5kX2hkd3E6
CiAJCS8qIFdlIGZvdW5kIGFuIGF2YWlsYWJsZSBlbnRyeSwgY29weSB0aGUgSVJRIGluZm8gKi8K
IAkJc3RhcnRfY3B1ID0gY3B1bWFza19uZXh0KG5ld19jcHUsIGNwdV9wcmVzZW50X21hc2spOwot
CQlpZiAoc3RhcnRfY3B1ID09IG5yX2NwdW1hc2tfYml0cykKKwkJaWYgKHN0YXJ0X2NwdSA+PSBu
cl9jcHVfaWRzKQogCQkJc3RhcnRfY3B1ID0gZmlyc3RfY3B1OwogCQljcHVwLT5oZHdxID0gbmV3
X2NwdXAtPmhkd3E7CiAgbG9naXQ6Cg==
--00000000000086571e05f6402c49--
