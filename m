Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FB6ACC22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCFSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCFSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:12:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308626F60A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:12:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec29so11546491edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678126339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzIY86ayC91gpJX8O4HM8FSlFRgaR4tQVqiVh7znpjg=;
        b=IUb+Ih7gSc20L8DzGs+5daIjQD48NSGkgaEzw0pyyqogCdYnJA7ZmjSgeee8zvN7JK
         KuSeDNm+u5KAzT4gXQhbvaCGDm7farQubOz6unIwGatxST3SLGwBOIWRyS0E3TRCY6Eo
         qiYigHpx8TSnwW6qd8t2IctFG4CPHULXckf/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzIY86ayC91gpJX8O4HM8FSlFRgaR4tQVqiVh7znpjg=;
        b=3hccvQ5cnA+WofbD0tZ8fpYU4ZOWwzHwZ3yrWr7ee16Q5GUMtFGv/B7P2br5QeGGJT
         Jj7FUyg6xYUPPboBcKa9Lt7+7OJwXgESl21xw9IwNigt3/ljGExxgtiziC1B4P4Reeuc
         kO9jxg1RodpT7xYtf4KsguvPpEIit4qLKhuwfYoMa1p3cR5gntYPxwPEDSq1r3r3nk7O
         s5+CRlUb8l9kIqt0sYiMF0NX+F8cTRfUQdc3R/M/t1Szaypj9ZLzQi7euu783XF53Oo/
         1JRGivzrDh4Q/KpDQh0rCzkoDhtBr9OhF03J7V6GGeXPumHn9CNgfyvy/dif/NrR5Hjg
         ekcQ==
X-Gm-Message-State: AO0yUKWZezRFLEe8Z/eG9GkMnefCv2nAZVF+AA8cIuu1+C9Au/Gld9Tc
        mdtFnWwZBrDDHgfyEXWYvEUa4SPUNj2fLshwlPCL4A==
X-Google-Smtp-Source: AK7set+5ONQnO6TOZw1lOghCVnhHwhcHZCLLqtzN9MNNUGlkA67R0hEy6XshTxk8L9c6BYdnEILRpA==
X-Received: by 2002:a17:907:1909:b0:8b1:304b:8e2c with SMTP id ll9-20020a170907190900b008b1304b8e2cmr12338768ejc.0.1678126339409;
        Mon, 06 Mar 2023 10:12:19 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906040800b008bda61ff999sm4891710eja.130.2023.03.06.10.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:12:18 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id o12so42308235edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:12:18 -0800 (PST)
X-Received: by 2002:a17:906:2bc2:b0:8f1:4cc5:f14c with SMTP id
 n2-20020a1709062bc200b008f14cc5f14cmr5706607ejg.0.1678126338388; Mon, 06 Mar
 2023 10:12:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
 <481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net>
In-Reply-To: <481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 10:12:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj16E7+Q7hcRrKT-HR-hfj4We3C4wr9Mw=bU5RdYwaY6A@mail.gmail.com>
Message-ID: <CAHk-=wj16E7+Q7hcRrKT-HR-hfj4We3C4wr9Mw=bU5RdYwaY6A@mail.gmail.com>
Subject: Re: Linux 6.3-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000049f32505f63f3c08"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000049f32505f63f3c08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 6, 2023 at 8:52=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Various crashes, affecting several architectures.
>
> [   11.664666] BUG: unable to handle page fault for address: 000000000002=
d3db
> [   11.667043]  lock_acquire+0xcb/0x330
> [   11.667163]  _raw_spin_lock+0x2b/0x40
> [   11.667255]  add_timer_on+0x92/0x150
> [   11.667302]  try_to_generate_entropy+0x256/0x280

Ok, this seems to be due to the issue discussed here

   https://lore.kernel.org/all/CAHk-=3DwitXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNd=
aPwngMVEg@mail.gmail.com/

and I think the fix is as per the appended patch (that particular
crash is due to the random.c part, but I did the others that 'git
grep' picked out too).

Can you run your test-runs on this patch?

              Linus

--00000000000049f32505f63f3c08
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lex52qfd0>
X-Attachment-Id: f_lex52qfd0

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
--00000000000049f32505f63f3c08--
