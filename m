Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1B6DB428
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDGT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDGT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:26:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A34C01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:26:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso5704236a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680895605; x=1683487605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lDVG+YuCtOfPArlPeceyFS6/KZPuKxel0YfKe2g/9k=;
        b=ShnxziVNL8Rs1oL16YVk5LhRZs8WUFIUIubnnQiwatt6ZlbnN0vYs6P5wgW8tzPnMC
         BbEQzuGHpr9+WgdWc+X27ZuKL+GcwfcZpHrw45zAQUL3ro7URbsJWB+SuMUO6bx5ZZqH
         OeQ4mIqSQq4XhRSkP2IvychE+FKVVMSoNaEsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895605; x=1683487605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lDVG+YuCtOfPArlPeceyFS6/KZPuKxel0YfKe2g/9k=;
        b=a5R12n2M3LxPxuKVvs+3FFEtKkyvEGaffeJ7n2BtWV7JVZONMht3Ry35Qe+rBBHfFl
         hyr27ayZ+txA7ef7LIaUJECnub1Be4DMcI+touaWydpPoH27RUpdYX1yp9czcao4wA1O
         pYbYZAsXUR8FHSs3Lej4Oh/1375RWm1vn0TT6pAQsWfET99r46g+c7M7jh2IOs+cTjhY
         FwSWJhoM/MLitdheXvK9bUV7ic4BiyocivqDslqQdM7ctK6Z5DCjmjcmq+zlWzC05YCa
         XW8+QtQ6OD//3qC9j15DSN8P+/hTlj7OMJhVbR0TS0mdg3Tge+mK8738VLJfU9m8fjCL
         NndQ==
X-Gm-Message-State: AAQBX9fJ4RQebXG4Pz6ufVC/qUwBqolgcMGPqLEbO5JaL507DZt+tLFG
        mAB+v3YZqbSVtq/1BBQv3F+71CA8J4/eebONbS4Olw==
X-Google-Smtp-Source: AKy350YV91idVOZBEAGvRza8MMAiXY09MRQLYWFLJWqJDJ1VXdGJ/xBQS/Q/xf1jD1DgqLXL7meKNw==
X-Received: by 2002:a05:6402:14c2:b0:502:4182:648a with SMTP id f2-20020a05640214c200b005024182648amr3000053edx.9.1680895605065;
        Fri, 07 Apr 2023 12:26:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id t19-20020a50d713000000b005021d17d896sm2181704edi.21.2023.04.07.12.26.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:26:43 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id cw23so10425554ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:26:43 -0700 (PDT)
X-Received: by 2002:a17:907:7282:b0:8e5:411d:4d09 with SMTP id
 dt2-20020a170907728200b008e5411d4d09mr214858ejc.15.1680895603165; Fri, 07 Apr
 2023 12:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com> <dd933c50df674dd69f6e630a53cfee77@AcuMS.aculab.com>
In-Reply-To: <dd933c50df674dd69f6e630a53cfee77@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Apr 2023 12:26:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA+n+9_AzzPaoxMDgh9YHvif+LC0ZhFuUg-qED=oynHQ@mail.gmail.com>
Message-ID: <CAHk-=whA+n+9_AzzPaoxMDgh9YHvif+LC0ZhFuUg-qED=oynHQ@mail.gmail.com>
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: multipart/mixed; boundary="0000000000005514f705f8c401d3"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005514f705f8c401d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 7, 2023 at 5:25=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> I think it depends on why the driver is asking for more
> interrupts than the hardware supports.
> Potentially the driver could do:
>         for (i =3D 0; i < 8; i++)
>                 msix_tbl[i].entry =3D 2 * i;
> if the hardware supports 8 interrupts perhaps it
> should return 4?

Hmm.

Something like this might get that case right too. Again - entirely
untested, but looks superficially sane to me.

It just returns how many of the msix_entry[] entries can be used (or
negative for error). So then the (only) caller can just say "is that
still enough for what we required". Seems reasonable, and would get
that non-contiguous case right, I think.

Thomas?

I'm going to drop this and assume I'll get a pull from you with what
you consider the proper fix, but since I was looking at this anyway, I
decided I might as well send out this RFC patch.

                Linus

--0000000000005514f705f8c401d3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lg6xtwmq0>
X-Attachment-Id: f_lg6xtwmq0

IGRyaXZlcnMvcGNpL21zaS9tc2kuYyB8IDMwICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL21zaS9tc2kuYyBiL2RyaXZlcnMvcGNpL21zaS9tc2kuYwpp
bmRleCAxZjcxNjYyNGNhNTYuLmQxNTFiZGU4YjhlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kv
bXNpL21zaS5jCisrKyBiL2RyaXZlcnMvcGNpL21zaS9tc2kuYwpAQCAtNzUwLDMyICs3NTAsMzMg
QEAgc3RhdGljIGludCBtc2l4X2NhcGFiaWxpdHlfaW5pdChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBz
dHJ1Y3QgbXNpeF9lbnRyeSAqZW50cmllcywKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgYm9v
bCBwY2lfbXNpeF92YWxpZGF0ZV9lbnRyaWVzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCBt
c2l4X2VudHJ5ICplbnRyaWVzLAotCQkJCSAgICAgIGludCBudmVjLCBpbnQgaHdzaXplKQorc3Rh
dGljIGludCBwY2lfbXNpeF92YWxpZGF0ZV9lbnRyaWVzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0
cnVjdCBtc2l4X2VudHJ5ICplbnRyaWVzLAorCQkJCSAgICAgaW50IG52ZWMsIGludCBod3NpemUp
CiB7CiAJYm9vbCBub2dhcDsKLQlpbnQgaSwgajsKKwlpbnQgbWF4dmVjOwogCiAJaWYgKCFlbnRy
aWVzKQotCQlyZXR1cm4gdHJ1ZTsKKwkJcmV0dXJuIG52ZWM7CiAKIAlub2dhcCA9IHBjaV9tc2lf
ZG9tYWluX3N1cHBvcnRzKGRldiwgTVNJX0ZMQUdfTVNJWF9DT05USUdVT1VTLCBERU5ZX0xFR0FD
WSk7CiAKLQlmb3IgKGkgPSAwOyBpIDwgbnZlYzsgaSsrKSB7CisJbWF4dmVjID0gLUVJTlZBTDsK
Kwlmb3IgKGludCBpID0gMDsgaSA8IG52ZWM7IGkrKykgewogCQkvKiBFbnRyeSB3aXRoaW4gaGFy
ZHdhcmUgbGltaXQ/ICovCi0JCWlmIChlbnRyaWVzW2ldLmVudHJ5ID49IGh3c2l6ZSkKLQkJCXJl
dHVybiBmYWxzZTsKKwkJaWYgKGVudHJpZXNbaV0uZW50cnkgPCBod3NpemUpCisJCQltYXh2ZWMg
PSBpKzE7CiAKIAkJLyogQ2hlY2sgZm9yIGR1cGxpY2F0ZSBlbnRyaWVzICovCi0JCWZvciAoaiA9
IGkgKyAxOyBqIDwgbnZlYzsgaisrKSB7CisJCWZvciAoaW50IGogPSBpICsgMTsgaiA8IG52ZWM7
IGorKykgewogCQkJaWYgKGVudHJpZXNbaV0uZW50cnkgPT0gZW50cmllc1tqXS5lbnRyeSkKLQkJ
CQlyZXR1cm4gZmFsc2U7CisJCQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0KIAkJLyogQ2hlY2sgZm9y
IHVuc3VwcG9ydGVkIGdhcHMgKi8KIAkJaWYgKG5vZ2FwICYmIGVudHJpZXNbaV0uZW50cnkgIT0g
aSkKLQkJCXJldHVybiBmYWxzZTsKKwkJCXJldHVybiAtRUlOVkFMOwogCX0KLQlyZXR1cm4gdHJ1
ZTsKKwlyZXR1cm4gbWF4dmVjOwogfQogCiBpbnQgX19wY2lfZW5hYmxlX21zaXhfcmFuZ2Uoc3Ry
dWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IG1zaXhfZW50cnkgKmVudHJpZXMsIGludCBtaW52ZWMs
CkBAIC04MDUsOCArODA2LDExIEBAIGludCBfX3BjaV9lbmFibGVfbXNpeF9yYW5nZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LCBzdHJ1Y3QgbXNpeF9lbnRyeSAqZW50cmllcywgaW50CiAJaWYgKGh3c2l6
ZSA8IDApCiAJCXJldHVybiBod3NpemU7CiAKLQlpZiAoIXBjaV9tc2l4X3ZhbGlkYXRlX2VudHJp
ZXMoZGV2LCBlbnRyaWVzLCBudmVjLCBod3NpemUpKQotCQlyZXR1cm4gLUVJTlZBTDsKKwludmVj
ID0gcGNpX21zaXhfdmFsaWRhdGVfZW50cmllcyhkZXYsIGVudHJpZXMsIG52ZWMsIGh3c2l6ZSk7
CisJaWYgKG52ZWMgPCAwKQorCQlyZXR1cm4gbnZlYzsKKwlpZiAobnZlYyA8IG1pbnZlYykKKwkJ
cmV0dXJuIC1FTk9TUEM7CiAKIAlpZiAoaHdzaXplIDwgbnZlYykgewogCQkvKiBLZWVwIHRoZSBJ
UlEgdmlydHVhbCBoYWNrZXJ5IHdvcmtpbmcgKi8K
--0000000000005514f705f8c401d3--
