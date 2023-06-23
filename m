Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83CE73BE5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjFWSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjFWSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:24:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CD2735
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:24:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9889952ed18so107871466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687544674; x=1690136674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6p1pSJMZSnLphn0xNTdoIm39lKtlKtDdmdgwXGqKIeE=;
        b=RBZ9A5clOgHcGjKFxtY/s2cdB61RUAPiqRnDhi5dvO814rE7HHjKQriqE36vISk4FR
         99cme0PQaLND7kexAihk10MS9izeUW7RPjygwMYUhnsTER/xFL3NPiqKbrL7MUT9my/o
         1Pv/jPSyylfBLaqRneuaeRFL6gs0qZELj9NAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687544674; x=1690136674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p1pSJMZSnLphn0xNTdoIm39lKtlKtDdmdgwXGqKIeE=;
        b=FqOpEIcHiDp06pF00CbI2elABAlt9/+ob7E/hsFrVUvVeguVpre/DEHCU48wKPZtyu
         aAhyxhJpvOhgF9AHdOWRLtY2IK0GbMUnbnn3/g5Lj1iTJfjRRIcX4QYGP0ihiL6ILeWa
         K/lJjWRjejD0abejCAl+4aPrh7d2wKneUqx0Cf1H0Pm4PDDZJ8+5ggRgVxHXYWcnb0ft
         TyPBw9Wrmzikye7HeTkRlIdKY45xLWUsSDIklcHeH8YMmjXqp6FsVbmEu1LFG+t8cAS3
         Tmr5m+FUVviIqW4VfOLFehcdwxE0HkaCfEGHZTcxr9mdh/SPZ6qiG/WcbV4qNGc0HSrX
         P+Pw==
X-Gm-Message-State: AC+VfDwQjyK0qjagQFagYPssYOjjkx+qC6DfDahrgGY87UerwI+GcM0k
        ELgoKc72ehiNjzlKvcOxwDvc5TnKp0bh88sdK+9Buia+
X-Google-Smtp-Source: ACHHUZ45kQ50jTeXegpuVVuCjrGaW8p7ssPugikj7abgxygrL1ONWct4ROt39PfBvlGjT9rKFlRTlw==
X-Received: by 2002:a17:906:db0b:b0:982:25d1:bfd3 with SMTP id xj11-20020a170906db0b00b0098225d1bfd3mr18489525ejb.15.1687544674421;
        Fri, 23 Jun 2023 11:24:34 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906614800b00989065149d0sm6250765ejl.86.2023.06.23.11.24.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:24:33 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51bfcb29372so610211a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:24:33 -0700 (PDT)
X-Received: by 2002:aa7:dbd9:0:b0:518:7ad9:64bb with SMTP id
 v25-20020aa7dbd9000000b005187ad964bbmr14484266edt.19.1687544673260; Fri, 23
 Jun 2023 11:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
In-Reply-To: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 11:24:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
Message-ID: <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Dave Airlie <airlied@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cb30c605fed01c95"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cb30c605fed01c95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2023 at 20:57, Dave Airlie <airlied@gmail.com> wrote:
>
> Not sure what changed (maybe I ended up with -Werror on recently), but
> my 32-bit arm build started to fail. 6.4.0-rc7.
>
> gcc version 13.1.1 20230519 (Red Hat Cross 13.1.1-2) (GCC)
>
> /home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c: In
> function =E2=80=98get_work_pwq=E2=80=99:
> /home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c:713:24:
> error: cast to pointer from integer of different size
> [-Werror=3Dint-to-pointer-cast]
>   713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>       |                        ^

Ok, that's some nasty code, but I'm not entirely sure why gcc has
started complaining about it now.

'data' is of type 'unsigned long', and we cast things to pointers all the t=
ime..

Now, WORK_STRUCT_WQ_DATA_MASK is this odd enum type, and very very
arguably that is absolutely *horrible*, but the code does

  enum {
        [..]
        WORK_STRUCT_FLAG_BITS   =3D WORK_STRUCT_COLOR_SHIFT +
                WORK_STRUCT_COLOR_BITS,
        [..]
        WORK_STRUCT_FLAG_MASK   =3D (1UL << WORK_STRUCT_FLAG_BITS) - 1,
        WORK_STRUCT_WQ_DATA_MASK =3D ~WORK_STRUCT_FLAG_MASK,
  }

and while the above is absolutely disgusting and the type is not very
well defined, an enum type should be wide enough to contain all the
values of the enum. It should all default to 'int', but gcc has some
extensions.

The 'intent' here is that WORK_STRUCT_FLAG_MASK is of type UL, but
that's not actually how enum types necessarily work. Again, the enum
should be large enough to contain the *values* of the elements, not
necessarily the *types* of the elements. The type is always going to
be that enum.

(And again, I think according to the standard, it's always of type
'int', but every compiler does some kind of type widening for larger
values as an extension, and may use a smaller type for storage).

But even if WORK_STRUCT_FLAG_MASK isn't an unsigned long, and is
something smaller, the expression '~WORK_STRUCT_FLAG_MASK' must be *at
least* an 'int', and would be a negative one if so. That's just how C
integer expressions work - the '~' operator is guaranteed to make it
at *least* an int.

Now, again, the final type of an enum is not determined by the types
of the element initializers, but by their *values*. But that means
that the final type of an enum will have two choices:

 - either ~WORK_STRUCT_FLAG_MASK was extended to be 'int', and the
value is negative, and the enum type has to be a signed type that can
contain that negative value.

   IOW, the enum might actually be of type 'signed char', but then
doing that 'data & enum' will sign-extend the mask and everything is
fine.

 - *or* the type of WORK_STRUCT_FLAG_MASK was interpreted to be an
unsigned type >=3D int, and the negation made it a really big unsigned
value, and that enum must thus be a large unsigned type to fit it

   IOW, the enum might be an unsigned type, but it will be at LEAST of
size 'int', and I don't see why it would be a problem on 32-bit ARM.
Making it be 'unsigned long long' sounds insane. But maybe that is
what happened.

In either case, the code above should do the right thing, at least on
32-bit, but the warning is, I feel, valid.

Because as you can tell, the 'type' of an enum really isn't very obvious.

I think the whole 'type of an enum' is not only a very very bad thing
to rely on, I think it's something that C23 ends up codifying new
rules for. It may be why gcc started complaining now.

Anyway, that code absolutely has to be fixed. Using enums for types is
wrong, wrong, wrong. You should consider an enum to be a weakly typed
integer expression with some specific advantages (the automatic
incrementing at definition time, and the compiler being able to limit
ranges in switch() statements and maybe doing limited type warnings
elsewhere)

Any time you think it has a specific type size, you're setting
yourself up for pain and suffering. Gcc is right to warn when we do
odd arithmetic with it and rely on the width of the result.

So I really think that code needs fixing, and the gcc warning was very vali=
d.

Maybe something like the attached. Does this fix the gcc warning?
Tejun, comments?

                      Linus

--000000000000cb30c605fed01c95
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lj8wig7t0>
X-Attachment-Id: f_lj8wig7t0

IGluY2x1ZGUvbGludXgvd29ya3F1ZXVlLmggfCAxNSArKysrKysrKy0tLS0tLS0KIGtlcm5lbC93
b3JrcXVldWUuYyAgICAgICAgfCAxMyArKysrKysrKy0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvd29ya3F1ZXVlLmggYi9pbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5oCmluZGV4IDM5OTJjOTk0
Nzg3Zi4uNjgzZWZlMjlmYTY5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5o
CisrKyBiL2luY2x1ZGUvbGludXgvd29ya3F1ZXVlLmgKQEAgLTY4LDcgKzY4LDYgQEAgZW51bSB7
CiAJV09SS19PRkZRX0ZMQUdfQkFTRQk9IFdPUktfU1RSVUNUX0NPTE9SX1NISUZULAogCiAJX19X
T1JLX09GRlFfQ0FOQ0VMSU5HCT0gV09SS19PRkZRX0ZMQUdfQkFTRSwKLQlXT1JLX09GRlFfQ0FO
Q0VMSU5HCT0gKDEgPDwgX19XT1JLX09GRlFfQ0FOQ0VMSU5HKSwKIAogCS8qCiAJICogV2hlbiBh
IHdvcmsgaXRlbSBpcyBvZmYgcXVldWUsIGl0cyBoaWdoIGJpdHMgcG9pbnQgdG8gdGhlIGxhc3QK
QEAgLTc5LDEyICs3OCw2IEBAIGVudW0gewogCVdPUktfT0ZGUV9QT09MX1NISUZUCT0gV09SS19P
RkZRX0ZMQUdfQkFTRSArIFdPUktfT0ZGUV9GTEFHX0JJVFMsCiAJV09SS19PRkZRX0xFRlQJCT0g
QklUU19QRVJfTE9ORyAtIFdPUktfT0ZGUV9QT09MX1NISUZULAogCVdPUktfT0ZGUV9QT09MX0JJ
VFMJPSBXT1JLX09GRlFfTEVGVCA8PSAzMSA/IFdPUktfT0ZGUV9MRUZUIDogMzEsCi0JV09SS19P
RkZRX1BPT0xfTk9ORQk9ICgxTFUgPDwgV09SS19PRkZRX1BPT0xfQklUUykgLSAxLAotCi0JLyog
Y29udmVuaWVuY2UgY29uc3RhbnRzICovCi0JV09SS19TVFJVQ1RfRkxBR19NQVNLCT0gKDFVTCA8
PCBXT1JLX1NUUlVDVF9GTEFHX0JJVFMpIC0gMSwKLQlXT1JLX1NUUlVDVF9XUV9EQVRBX01BU0sg
PSB+V09SS19TVFJVQ1RfRkxBR19NQVNLLAotCVdPUktfU1RSVUNUX05PX1BPT0wJPSAodW5zaWdu
ZWQgbG9uZylXT1JLX09GRlFfUE9PTF9OT05FIDw8IFdPUktfT0ZGUV9QT09MX1NISUZULAogCiAJ
LyogYml0IG1hc2sgZm9yIHdvcmtfYnVzeSgpIHJldHVybiB2YWx1ZXMgKi8KIAlXT1JLX0JVU1lf
UEVORElORwk9IDEgPDwgMCwKQEAgLTk0LDYgKzg3LDE0IEBAIGVudW0gewogCVdPUktFUl9ERVND
X0xFTgkJPSAyNCwKIH07CiAKKy8qIENvbnZlbmllbmNlIGNvbnN0YW50cyAtIG9mIHR5cGUgJ3Vu
c2lnbmVkIGxvbmcnLCBub3QgJ2VudW0nISAqLworI2RlZmluZSBXT1JLX09GRlFfQ0FOQ0VMSU5H
CSgxdWwgPDwgX19XT1JLX09GRlFfQ0FOQ0VMSU5HKQorI2RlZmluZSBXT1JLX09GRlFfUE9PTF9O
T05FCSgoMXVsIDw8IFdPUktfT0ZGUV9QT09MX0JJVFMpIC0gMSkKKyNkZWZpbmUgV09SS19TVFJV
Q1RfTk9fUE9PTAkoV09SS19PRkZRX1BPT0xfTk9ORSA8PCBXT1JLX09GRlFfUE9PTF9TSElGVCkK
KworI2RlZmluZSBXT1JLX1NUUlVDVF9GTEFHX01BU0sgICAgKCgxdWwgPDwgV09SS19TVFJVQ1Rf
RkxBR19CSVRTKSAtIDEpCisjZGVmaW5lIFdPUktfU1RSVUNUX1dRX0RBVEFfTUFTSyAofldPUktf
U1RSVUNUX0ZMQUdfTUFTSykKKwogc3RydWN0IHdvcmtfc3RydWN0IHsKIAlhdG9taWNfbG9uZ190
IGRhdGE7CiAJc3RydWN0IGxpc3RfaGVhZCBlbnRyeTsKZGlmZiAtLWdpdCBhL2tlcm5lbC93b3Jr
cXVldWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYwppbmRleCA0NjY2YTFhOTJhMzEuLmM5MTNlMzMz
Y2NlOCAxMDA2NDQKLS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jCisrKyBiL2tlcm5lbC93b3JrcXVl
dWUuYwpAQCAtNzA1LDEyICs3MDUsMTcgQEAgc3RhdGljIHZvaWQgY2xlYXJfd29ya19kYXRhKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAlzZXRfd29ya19kYXRhKHdvcmssIFdPUktfU1RSVUNU
X05PX1BPT0wsIDApOwogfQogCitzdGF0aWMgaW5saW5lIHN0cnVjdCBwb29sX3dvcmtxdWV1ZSAq
d29ya19zdHJ1Y3RfcHdxKHVuc2lnbmVkIGxvbmcgZGF0YSkKK3sKKwlyZXR1cm4gKHN0cnVjdCBw
b29sX3dvcmtxdWV1ZSAqKShkYXRhICYgV09SS19TVFJVQ1RfV1FfREFUQV9NQVNLKTsKK30KKwog
c3RhdGljIHN0cnVjdCBwb29sX3dvcmtxdWV1ZSAqZ2V0X3dvcmtfcHdxKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKIHsKIAl1bnNpZ25lZCBsb25nIGRhdGEgPSBhdG9taWNfbG9uZ19yZWFkKCZ3
b3JrLT5kYXRhKTsKIAogCWlmIChkYXRhICYgV09SS19TVFJVQ1RfUFdRKQotCQlyZXR1cm4gKHZv
aWQgKikoZGF0YSAmIFdPUktfU1RSVUNUX1dRX0RBVEFfTUFTSyk7CisJCXJldHVybiB3b3JrX3N0
cnVjdF9wd3EoZGF0YSk7CiAJZWxzZQogCQlyZXR1cm4gTlVMTDsKIH0KQEAgLTczOCw4ICs3NDMs
NyBAQCBzdGF0aWMgc3RydWN0IHdvcmtlcl9wb29sICpnZXRfd29ya19wb29sKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKIAlhc3NlcnRfcmN1X29yX3Bvb2xfbXV0ZXgoKTsKIAogCWlmIChkYXRh
ICYgV09SS19TVFJVQ1RfUFdRKQotCQlyZXR1cm4gKChzdHJ1Y3QgcG9vbF93b3JrcXVldWUgKikK
LQkJCShkYXRhICYgV09SS19TVFJVQ1RfV1FfREFUQV9NQVNLKSktPnBvb2w7CisJCXJldHVybiB3
b3JrX3N0cnVjdF9wd3EoZGF0YSktPnBvb2w7CiAKIAlwb29sX2lkID0gZGF0YSA+PiBXT1JLX09G
RlFfUE9PTF9TSElGVDsKIAlpZiAocG9vbF9pZCA9PSBXT1JLX09GRlFfUE9PTF9OT05FKQpAQCAt
NzYwLDggKzc2NCw3IEBAIHN0YXRpYyBpbnQgZ2V0X3dvcmtfcG9vbF9pZChzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCiAJdW5zaWduZWQgbG9uZyBkYXRhID0gYXRvbWljX2xvbmdfcmVhZCgmd29y
ay0+ZGF0YSk7CiAKIAlpZiAoZGF0YSAmIFdPUktfU1RSVUNUX1BXUSkKLQkJcmV0dXJuICgoc3Ry
dWN0IHBvb2xfd29ya3F1ZXVlICopCi0JCQkoZGF0YSAmIFdPUktfU1RSVUNUX1dRX0RBVEFfTUFT
SykpLT5wb29sLT5pZDsKKwkJcmV0dXJuIHdvcmtfc3RydWN0X3B3cShkYXRhKS0+cG9vbC0+aWQ7
CiAKIAlyZXR1cm4gZGF0YSA+PiBXT1JLX09GRlFfUE9PTF9TSElGVDsKIH0K
--000000000000cb30c605fed01c95--
