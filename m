Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E29710399
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEYEA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEYEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:00:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F8E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:00:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso21629166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684987222; x=1687579222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9wvkrHiO2vLfdNjz3Lr8jzqTeFi37UzWEdwoU59g04=;
        b=EWp2V1FBv1aqQurjV8pfFEsaZFS9P8p1UAfqYOgaR8Td7ABfNpwyir3kgqWUmDJ2yf
         qBsPP7zq7pVIQIqaXCwxi6RQje+dU7w5NJhT4MwnUFJ3j67yqkV8aWZ4oHzSg+rBuoPa
         PLFOE8kIBZ1AZPb+bZkM24IO+g1UgtxhXiy/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684987222; x=1687579222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9wvkrHiO2vLfdNjz3Lr8jzqTeFi37UzWEdwoU59g04=;
        b=incdADAanhb+kbI2VU8kAhpcrdHG456OMGQZF5w2OVLuLEz4LYx4uCrB6qYsBSFlKA
         E5v/k1x5K/V1snpmCnWk0HzSFqhV31AmjPWPsklvMJI1wHHZxGvMWQwJFw42ookjp+dE
         dMvVZlq2pAA2/QF+o5zNFPCql7BG8tm3CX6op4sjcttDIV29E68eWWt9k3h3IQxiEBCP
         49rwkIH3hmlSIPgSC2S5q+iCCjFiqlFbu8MM2UQm9cqyZqzwBVMdoCNHAr29aCVHTQSD
         SNyPlDSlVgVfH8D7f04WeoH6U0xo0OEeBZ4wvCaygaxE7ABdQmFctXLrFM4MxYIsILhB
         HdUg==
X-Gm-Message-State: AC+VfDz54DjzCnCxV8h6VFVdzcgzsG3Nid3wuNc1GaOSZYkZ9pbTWLmp
        LTsEOBDQ+IiGgNogr3VFioRtkLnNTuo6/jZKyk+BV/AX
X-Google-Smtp-Source: ACHHUZ6HJhxTAAtQ7OyirAsmRbfsPQ5DurbzxMNz/Vismdr9inUeMD3Z5RkV/zTcHSFqOEpPcbwlhw==
X-Received: by 2002:a17:907:934c:b0:94e:e859:7b07 with SMTP id bv12-20020a170907934c00b0094ee8597b07mr159574ejc.32.1684987219910;
        Wed, 24 May 2023 21:00:19 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id x23-20020a170906149700b00969dc13d0b1sm250266ejc.43.2023.05.24.21.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 21:00:19 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-970028cfb6cso20258066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:00:19 -0700 (PDT)
X-Received: by 2002:a17:907:985:b0:968:4ce9:677a with SMTP id
 bf5-20020a170907098500b009684ce9677amr154847ejc.38.1684987218743; Wed, 24 May
 2023 21:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 21:00:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
Message-ID: <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: multipart/mixed; boundary="000000000000a047aa05fc7ca823"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a047aa05fc7ca823
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 2:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is all disgusting.

Bringing back the original thread, because I just sent an alternate
patch to Luis to test.

That one is also disgusting, but for different reasons: it needs some
polish if it works. It's a very simple patch, in that it just extends
our existing i_writecount and ETXTBSY logic to also have a "exclusive"
mode, and says that we do the module file reading in that exclusive
mode (so if/when udev in its incompetence tries to load the same
module X number of times at the same time, only one will read at a
time).

The disgusting part is mainly the hacky test for "id =3D=3D
READING_MODULE", and it would probably be better with some kind of
"exclusive flag" field for general use, but right now READING_MODULE
is basically that one user.

Luis having explained _why_ we'd want this (and honestly, it took a
couple of tries), I can only say that udev is horribly broken, and
this most definitely should be fixed in user mode. udev randomly
loading the same module multiple times just because it gets confused
is not ok.

Any udev developer that goes "we can't fix it in user space" should be
ashamed of themselves. Really? Just randomly doing the same thing in
parallel and expecting the kernel to sort out your mess? What a crock.

But this *might* mitigate that udev horror. And not introduce any new
kernel-side horror, just a slight extension of our existing writer
exclusion logic to allow "full exclusive access".

(Note: it's not actually excluding other purely regular readers - but
it *is* excluding not just writers, but also other "special readers"
that want to exclude writers)

I'd like to point out that this patch really is completely untested.
It built for me, but that's all the testing it has gotten. It's
_small_. Tiny, even. But that "id =3D=3D READING_MODULE" thing really is
pretty disgusting and I feel this needs more thought.

                         Linus

--000000000000a047aa05fc7ca823
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_li2ltl2y0>
X-Attachment-Id: f_li2ltl2y0

IGZzL2tlcm5lbF9yZWFkX2ZpbGUuYyB8IDYgKysrKystCiBpbmNsdWRlL2xpbnV4L2ZzLmggICAg
fCA2ICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZnMva2VybmVsX3JlYWRfZmlsZS5jIGIvZnMva2VybmVsX3JlYWRf
ZmlsZS5jCmluZGV4IDVkODI2Mjc0NTcwYy4uZmYzZTg5NGY4Y2Q0IDEwMDY0NAotLS0gYS9mcy9r
ZXJuZWxfcmVhZF9maWxlLmMKKysrIGIvZnMva2VybmVsX3JlYWRfZmlsZS5jCkBAIC00OCw3ICs0
OCwxMSBAQCBzc2l6ZV90IGtlcm5lbF9yZWFkX2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZf
dCBvZmZzZXQsIHZvaWQgKipidWYsCiAJaWYgKCFTX0lTUkVHKGZpbGVfaW5vZGUoZmlsZSktPmlf
bW9kZSkpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JcmV0ID0gZGVueV93cml0ZV9hY2Nlc3MoZmls
ZSk7CisJLyogTW9kdWxlIHJlYWRpbmcgd2FudHMgKmV4Y2x1c2l2ZSogYWNjZXNzIHRvIHRoZSBm
aWxlICovCisJaWYgKGlkID09IFJFQURJTkdfTU9EVUxFKQorCQlyZXQgPSBleGNsdXNpdmVfZGVu
eV93cml0ZV9hY2Nlc3MoZmlsZSk7CisJZWxzZQorCQlyZXQgPSBkZW55X3dyaXRlX2FjY2Vzcyhm
aWxlKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgKaW5kZXggMjFhOTgxNjgwODU2Li43MjJiNDJh
NzdkNTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4
L2ZzLmgKQEAgLTI1NjYsNiArMjU2NiwxMiBAQCBzdGF0aWMgaW5saW5lIGludCBkZW55X3dyaXRl
X2FjY2VzcyhzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9p
bm9kZShmaWxlKTsKIAlyZXR1cm4gYXRvbWljX2RlY191bmxlc3NfcG9zaXRpdmUoJmlub2RlLT5p
X3dyaXRlY291bnQpID8gMCA6IC1FVFhUQlNZOwogfQorc3RhdGljIGlubGluZSBpbnQgZXhjbHVz
aXZlX2Rlbnlfd3JpdGVfYWNjZXNzKHN0cnVjdCBmaWxlICpmaWxlKQoreworCWludCBvbGQgPSAw
OworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOworCXJldHVybiBhdG9t
aWNfdHJ5X2NtcHhjaGcoJmlub2RlLT5pX3dyaXRlY291bnQsICZvbGQsIC0xKSA/IDAgOiAtRVRY
VEJTWTsKK30KIHN0YXRpYyBpbmxpbmUgdm9pZCBwdXRfd3JpdGVfYWNjZXNzKHN0cnVjdCBpbm9k
ZSAqIGlub2RlKQogewogCWF0b21pY19kZWMoJmlub2RlLT5pX3dyaXRlY291bnQpOwo=
--000000000000a047aa05fc7ca823--
