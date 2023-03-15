Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C676BA450
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCOAwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCOAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:52:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC535BC93
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so39157421edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678841525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vDSR0zMCDUWRCKBzx6s9aAqkGkCEHbHPaVHOVnFdDM=;
        b=DHXUCI4tMoXMW8pomWv2uJgpBuWfRbjK2rdspfOAs2FQb/lbN9l/OjgMGgveKNvosP
         dEojqisVzjiOVb+yshMH04/QXAhzmviWCd9ksOhET+0TaoPKZH0lMnHD5fpRXQV/wEMd
         KugqRAHG36EttDRA+HNk7GPQ7ea4JbrlSiyWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678841525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vDSR0zMCDUWRCKBzx6s9aAqkGkCEHbHPaVHOVnFdDM=;
        b=UtTrRBhWD6Im92ATFzt4AEL7N1ov6NCu6v0/RfF7ru1QulIYpv/FmcJdEODU7EKHzN
         kLKDaDKlS7NrERlHs6hzGcjw+7g1LEbuPTB4OSMLGOUqe5xpuGe3djrpqDZt4/z0LZFb
         b+0VXRExJUqiNv8dVlMX6Nf1+jApUJXJuky+AT0PnPlSOBee8+UoW2IU5RJFvbtKpQX2
         6T/GSToxDRD2Ak1WY740Uv8OoK6qpSL1PQRdzsdfJfx+MXA7/7M+quOf/5Exv/29gibn
         B9ZZLf77/g04YzwJTmLchx7cjmHeAjRbhf8Scpgnwoh4NPKqER3yHj35zpXTYeda8fXC
         s2Gg==
X-Gm-Message-State: AO0yUKW4iJRHwvWK5q06AtK7FInUgpyDCOavA0hOFVodaKAU7NXXQuIw
        +995SI2HYkC4StWFko+abL9uWENlYfL/2Xc6NBU8Eg==
X-Google-Smtp-Source: AK7set+aeQjGAz10iLr6tJOZ66oW/rhAkV8ViuKd3ZYQRGxNX2dksiE2pg0ewM1ZnyzvOyFUOiLYNw==
X-Received: by 2002:a17:906:d936:b0:8f8:35c2:1357 with SMTP id rn22-20020a170906d93600b008f835c21357mr4180030ejb.23.1678841525139;
        Tue, 14 Mar 2023 17:52:05 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ga17-20020a170906b85100b00922e3221c88sm1754234ejb.117.2023.03.14.17.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 17:52:04 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id eh3so13404716edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:04 -0700 (PDT)
X-Received: by 2002:a17:907:72c1:b0:8e5:1a7b:8ab2 with SMTP id
 du1-20020a17090772c100b008e51a7b8ab2mr2644453ejc.4.1678841524039; Tue, 14 Mar
 2023 17:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <7d026744-6bd6-6827-0471-b5e8eae0be3f@arm.com>
In-Reply-To: <7d026744-6bd6-6827-0471-b5e8eae0be3f@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 17:51:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
Message-ID: <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
Subject: Re: [BUG] v6.3-rc2 regresses sched_getaffinity() for arm64
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="000000000000ad0e4805f6e5c0e6"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ad0e4805f6e5c0e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 3:41=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Apologies if this is the wrong channel for reporting this - I couldn't fi=
nd a
> suitable mail on the list for this patch to reply to. Happy to direct it
> somewhere else if appropriate.

No, this is good.

> nproc is calling sched_getaffinity() with a 1024 entry cpu_set mask, then=
 adds
> up all the set bits to find the number of CPUs. I wrote a test program an=
d can
> see that the first 8 bits are always correctly set and most of the other =
bits
> are always correctly 0. But bits ~64-224 are randomly set/clear from call=
 to call.

Ahh.

Yes, I see what's happening. The code does

                unsigned int retlen =3D min(len, cpumask_size());

and our cpu mask allocation size is set to 4 words - but since your
'nr_cpu_ids' is just 8, only the first word has actually been filled
with valid data.

That "cpumask_size()" thing is meant to be how big the allocation size
is, but clearly there is at least one user that has then taken it to
mean how much data it contains.

Interestingly, that same code already actually checks the length
against the right thing (nr_cpu_ids) elsewhere, but does it kind of
stupidly - first testing that the result fits in the bytes, then
checks that the thing is long-word aligned.

The immediate fix for your issue is likely the attached patch, but I'm
not particularly happy with it. I'd need to at the very least also fix
the same issue in the compat code, but there might be other cases of
this too, where people use the "allocation size" as the "valid bits
size".

Let me think about it some more, but in the meantime you can test if
this patch does indeed fix things for you.

             Linus

--000000000000ad0e4805f6e5c0e6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lf8yvt9b0>
X-Attachment-Id: f_lf8yvt9b0

IGtlcm5lbC9zY2hlZC9jb3JlLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUu
YyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMKaW5kZXggYWYwMTdlMDM4YjQ4Li5mZGJlN2YzYjU1ZjAg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMKKysrIGIva2VybmVsL3NjaGVkL2NvcmUu
YwpAQCAtODQxMywxOCArODQxMywxNyBAQCBTWVNDQUxMX0RFRklORTMoc2NoZWRfZ2V0YWZmaW5p
dHksIHBpZF90LCBwaWQsIHVuc2lnbmVkIGludCwgbGVuLAogCQlyZXR1cm4gLUVJTlZBTDsKIAlp
ZiAobGVuICYgKHNpemVvZih1bnNpZ25lZCBsb25nKS0xKSkKIAkJcmV0dXJuIC1FSU5WQUw7CisJ
bGVuID0gQklUU19UT19MT05HUyhucl9jcHVfaWRzKSAqIHNpemVvZih1bnNpZ25lZCBsb25nKTsK
IAogCWlmICghYWxsb2NfY3B1bWFza192YXIoJm1hc2ssIEdGUF9LRVJORUwpKQogCQlyZXR1cm4g
LUVOT01FTTsKIAogCXJldCA9IHNjaGVkX2dldGFmZmluaXR5KHBpZCwgbWFzayk7CiAJaWYgKHJl
dCA9PSAwKSB7Ci0JCXVuc2lnbmVkIGludCByZXRsZW4gPSBtaW4obGVuLCBjcHVtYXNrX3NpemUo
KSk7Ci0KLQkJaWYgKGNvcHlfdG9fdXNlcih1c2VyX21hc2tfcHRyLCBtYXNrLCByZXRsZW4pKQor
CQlpZiAoY29weV90b191c2VyKHVzZXJfbWFza19wdHIsIG1hc2ssIGxlbikpCiAJCQlyZXQgPSAt
RUZBVUxUOwogCQllbHNlCi0JCQlyZXQgPSByZXRsZW47CisJCQlyZXQgPSBsZW47CiAJfQogCWZy
ZWVfY3B1bWFza192YXIobWFzayk7CiAK
--000000000000ad0e4805f6e5c0e6--
