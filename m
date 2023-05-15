Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6767031E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjEOPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjEOPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:54:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6AFF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:54:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so17971368a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684166059; x=1686758059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzJTVdNPJahN4ZaYSD0w8tFsg1kEZiXFWub3q5MNDtA=;
        b=U+fyHzrgCISHQTmjmFGe4guvDIc2B3otJoWd81uxPuhAgICsQnB9um8nw4ffASawyK
         5/BwEVZXEXSzOkYZGBsxilEmhDBdvCkEFrruS2t3ImgapQVRjwpuIROMRaCeAT8ZEjcm
         DqUYIRTIIW7c/u5MagufCbX9AQI4xwWQt3Ync=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166059; x=1686758059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzJTVdNPJahN4ZaYSD0w8tFsg1kEZiXFWub3q5MNDtA=;
        b=M/1nTuRrn8F9+/DJIwKVydNTqi5AFqQIMFXpH0i9XZgW+M6tsGiKFXmIQWN9irDv7b
         7BE9uc577C5mt+lz6ZUIxaNniyc0JOPQCSbA0/vTPf4pyFhWCm1ene5je5Rd+C4O9Awy
         RWolfAAdOOGUoTeuhVeXBpyhMDnSPGA8F9AUHOTE1mYJLchM7csmKkWROZwfg/DGbYj2
         LVdtLBbFU26cLkARjXuvK+pcaUyv6RkicWS1+WdzRdTGJDJkApqDUSq+VUpjbHCynCnk
         lLZyxoQQyMsYUlCBx0k7fhXSIGIH+XFpbWbeX+Pxi9stWCMSMNAZEK/RKons93+IphqY
         gqRA==
X-Gm-Message-State: AC+VfDzvUjXWl6ZULL9vrLIsQiNphW+XDh5FR4WAGEwOw39uYVq6i5H4
        zrXzwGSxlTc0h8ce84egZ4SDboG7fYHB3G71n8fo3g==
X-Google-Smtp-Source: ACHHUZ57e8aQYvC+W1yM/BUP+lImqjzoTH5UclG10oCU8co/o0dWSWdpdiF85GG5E+lLoWYDA9tb3g==
X-Received: by 2002:a17:906:478a:b0:969:b88c:b8a2 with SMTP id cw10-20020a170906478a00b00969b88cb8a2mr24882570ejc.10.1684166059000;
        Mon, 15 May 2023 08:54:19 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709067e4b00b00965f6ad266bsm9630916ejr.119.2023.05.15.08.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:54:18 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96652cb7673so1578766066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:54:18 -0700 (PDT)
X-Received: by 2002:a17:907:720d:b0:966:a691:55ed with SMTP id
 dr13-20020a170907720d00b00966a69155edmr26683920ejc.70.1684166057908; Mon, 15
 May 2023 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner> <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
In-Reply-To: <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 08:54:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
Message-ID: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mike Christie <michael.christie@oracle.com>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a0257505fbbd77bc"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a0257505fbbd77bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 8:52=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/23 9:44?AM, Linus Torvalds wrote:
> >
> > So I think the patch should just look something like the attached.
> > Mike, can you test this on whatever vhost test-suite?
>
> Seems like that didn't get attached...

Blush. I decided to built-test it, and then forgot to attach it. Here.

                  Linus

--000000000000a0257505fbbd77bc
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhp0yu7e0>
X-Attachment-Id: f_lhp0yu7e0

IGtlcm5lbC9mb3JrLmMgICAgICAgfCAxMiArKystLS0tLS0tLS0KIGtlcm5lbC92aG9zdF90YXNr
LmMgfCAgMyArKy0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2ZvcmsuYwppbmRleCBl
ZDRlMDFkYWNjYWEuLmNkMDZiMTM3NDE4ZiAxMDA2NDQKLS0tIGEva2VybmVsL2ZvcmsuYworKysg
Yi9rZXJuZWwvZm9yay5jCkBAIC0yMzM4LDE0ICsyMzM4LDEwIEBAIF9fbGF0ZW50X2VudHJvcHkg
c3RydWN0IHRhc2tfc3RydWN0ICpjb3B5X3Byb2Nlc3MoCiAJCXAtPmZsYWdzIHw9IFBGX0tUSFJF
QUQ7CiAJaWYgKGFyZ3MtPnVzZXJfd29ya2VyKQogCQlwLT5mbGFncyB8PSBQRl9VU0VSX1dPUktF
UjsKLQlpZiAoYXJncy0+aW9fdGhyZWFkKSB7Ci0JCS8qCi0JCSAqIE1hcmsgdXMgYW4gSU8gd29y
a2VyLCBhbmQgYmxvY2sgYW55IHNpZ25hbCB0aGF0IGlzbid0Ci0JCSAqIGZhdGFsIG9yIFNUT1AK
LQkJICovCisJaWYgKGFyZ3MtPmlvX3RocmVhZCkKIAkJcC0+ZmxhZ3MgfD0gUEZfSU9fV09SS0VS
OworCWlmIChhcmdzLT5pZ25vcmVfc2lnbmFscykKIAkJc2lnaW5pdHNldGludigmcC0+YmxvY2tl
ZCwgc2lnbWFzayhTSUdLSUxMKXxzaWdtYXNrKFNJR1NUT1ApKTsKLQl9CiAKIAlpZiAoYXJncy0+
bmFtZSkKIAkJc3Ryc2NweV9wYWQocC0+Y29tbSwgYXJncy0+bmFtZSwgc2l6ZW9mKHAtPmNvbW0p
KTsKQEAgLTI1MTcsOSArMjUxMyw2IEBAIF9fbGF0ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3Ry
dWN0ICpjb3B5X3Byb2Nlc3MoCiAJaWYgKHJldHZhbCkKIAkJZ290byBiYWRfZm9ya19jbGVhbnVw
X2lvOwogCi0JaWYgKGFyZ3MtPmlnbm9yZV9zaWduYWxzKQotCQlpZ25vcmVfc2lnbmFscyhwKTsK
LQogCXN0YWNrbGVha190YXNrX2luaXQocCk7CiAKIAlpZiAocGlkICE9ICZpbml0X3N0cnVjdF9w
aWQpIHsKQEAgLTI4NjEsNiArMjg1NCw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCAqY3JlYXRlX2lv
X3RocmVhZChpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAqYXJnLCBpbnQgbm9kZSkKIAkJLmZuX2Fy
ZwkJPSBhcmcsCiAJCS5pb190aHJlYWQJPSAxLAogCQkudXNlcl93b3JrZXIJPSAxLAorCQkuaWdu
b3JlX3NpZ25hbHMJPSAxLAogCX07CiAKIAlyZXR1cm4gY29weV9wcm9jZXNzKE5VTEwsIDAsIG5v
ZGUsICZhcmdzKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC92aG9zdF90YXNrLmMgYi9rZXJuZWwvdmhv
c3RfdGFzay5jCmluZGV4IGI3Y2JkNjZmODg5ZS4uMmUzMzRiMmQ3Y2M0IDEwMDY0NAotLS0gYS9r
ZXJuZWwvdmhvc3RfdGFzay5jCisrKyBiL2tlcm5lbC92aG9zdF90YXNrLmMKQEAgLTc1LDcgKzc1
LDggQEAgc3RydWN0IHZob3N0X3Rhc2sgKnZob3N0X3Rhc2tfY3JlYXRlKGludCAoKmZuKSh2b2lk
ICopLCB2b2lkICphcmcsCiAJCQkJICAgICBjb25zdCBjaGFyICpuYW1lKQogewogCXN0cnVjdCBr
ZXJuZWxfY2xvbmVfYXJncyBhcmdzID0gewotCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBDTE9ORV9V
TlRSQUNFRCB8IENMT05FX1ZNLAorCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBDTE9ORV9VTlRSQUNF
RCB8IENMT05FX1ZNIHwKKwkJCQkgIENMT05FX1RIUkVBRCB8IENMT05FX1NJR0hBTkQsCiAJCS5l
eGl0X3NpZ25hbAk9IDAsCiAJCS5mbgkJPSB2aG9zdF90YXNrX2ZuLAogCQkubmFtZQkJPSBuYW1l
LAo=
--000000000000a0257505fbbd77bc--
