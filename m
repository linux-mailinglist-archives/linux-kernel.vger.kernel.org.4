Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE263C8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiK2UGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK2UGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:06:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1A17412
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:06:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr1so1601780qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBDigO8cXsl151+f1kxyOXhtKDN/t9jZfYYR+tqe1FI=;
        b=J75a+XZRucJpkWKfZnJAadpeLUoZo6N917WrCEz3+Ivwc0sBkVWb3b9IbnWzBvgrxk
         UlS/E4pvPks4qPG2fKytuultWyqziAdIE+IzNhILkl2PTzG0D/4elmlc/JMo7VA4mng5
         KYRuxo2LTcHE4lpCmhp8kexvbXwIYf1PlaqgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBDigO8cXsl151+f1kxyOXhtKDN/t9jZfYYR+tqe1FI=;
        b=PZukdb1zK7CZrieVGlZcK+343s1BBtT4aTIyYFg/SPBxInYZFmaFiatoszBQc8BSWW
         jgk7ecv6RnNI1RzuyJjirMfiVtOoOR1PuG8gJJM5fsQOKrTFc4FltOYf98rSqUAo1WTw
         ygQVydWn1bRTfv5da2kawpqk9P0JQaH1/eUT+s9wtO5FTpMDVwNmDzIPsjxtjypIeNfR
         gQgfPHYhLTaVbxif4LR1BUFuT/lMwBkoApAHWdXk6NynP4L74Kwvfdd5cOlAhhbOIQfy
         c00XoKwKTgraXEeX9NxKxZdFHBPpJ3dXHUHxTPRNek4ulvvOROA7hA0M5gpiidc1Qk1l
         q2RQ==
X-Gm-Message-State: ANoB5plfFbRqI2sG69ql7YZmymmF47QPM0iRu04G60N6YRcQZxB/Nfb/
        fcTJyXu0RD3cThNBz9vU4bftoD4c4ekABg==
X-Google-Smtp-Source: AA0mqf7gxjQVlcF323rL9AIwCxTOnCaOT5ktv+q2/hjj4Y+B37YAaJh7pu/3tn5vLg8azMu6TSJx6w==
X-Received: by 2002:ac8:7285:0:b0:3a5:9dc:d83f with SMTP id v5-20020ac87285000000b003a509dcd83fmr53874400qto.28.1669752403062;
        Tue, 29 Nov 2022 12:06:43 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id c11-20020ac81e8b000000b003a4c3c4d2d4sm9210772qtm.49.2022.11.29.12.06.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 12:06:39 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id u10so4924105qvp.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:06:38 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr35701730qvj.130.1669752398653; Tue, 29
 Nov 2022 12:06:38 -0800 (PST)
MIME-Version: 1.0
References: <Y4YiArbU5h3h4n3s@linutronix.de> <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
In-Reply-To: <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Nov 2022 12:06:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ9BoQadX7aefY8LEEZ4CJFTEWpAyKV0CzL3yu3Xybdw@mail.gmail.com>
Message-ID: <CAHk-=wiJ9BoQadX7aefY8LEEZ4CJFTEWpAyKV0CzL3yu3Xybdw@mail.gmail.com>
Subject: Re: [PATCH] signal: Allow tasks to cache one sigqueue struct (again).
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: multipart/mixed; boundary="00000000000095fe0d05eea1860e"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000095fe0d05eea1860e
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 29, 2022 at 10:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That very much means "don't try to revive a patch that was already
> reverted because it was broken and didn't make sense". Throw this
> patch AWAY. It's not worth reviving. Start from scratch, with that
> "this needs to be _obviously_ correct" as the starting point.

Ok, so I realize that I said "obviously correct", and then I'm sending
out this ENTIRELY UNTESTED PATCH as an attachment. And I even made it
not build, on purpose.

In other words, the attached patch is anything *but* obviously
correct, but I'm sending it out as a "start from scratch" suggestion
for "maybe something like this".

Maybe this doesn't catch enough cases to really be worth it, but as a
starting point it

 (a) obviously done under the sighand->siglock or when the task is
dead and cannot be dereferenced

 (b) only adds sigqueues that have SIGQUEUE_PREALLOC set, and with an
empty queue

where (a) makes me at least go "the locking is fairly simple" and (b)
makes me go "and we don't have any rlimit counting issues" and it
really just acts as a single front-end cache.

As a result of (b), the freeing part should be just that kmem_cache_free().

And yeah, that doesn't actually build as-is, because 'sigqueue_cachep'
is local to kernel/signal.c, but rather than fix that I left this just
broken because I get the feeling that __exit_signal() should just be
*moved* into kernel/signal.c, but I didn't think about it enough.

In other words, this is *really* meant as not a good patch, but as a
"can we please go in this direction instead".

And yes, maybe some other "free this siginfo" paths should *also* do
that "try to add it to the cache, and if so, you're done" after doing
the accounting. So this is probably all mis-guided, but I ended up
wanting to just see how an alternative approach would look, and this
feels a lot safer to me.

We already have that SIGQUEUE_PREALLOC case, why not use some of the
same logic for the cached entry. Sure, it bypasses the rlimit, but
what else is new?

Maybe it all needs to do accounting, but at least in this form it
feels "safe", in that you have to free one of those unaccounted
entries in order to get another unaccounted entry.

              Linus

--00000000000095fe0d05eea1860e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lb2nb2h50>
X-Attachment-Id: f_lb2nb2h50

IGluY2x1ZGUvbGludXgvc2NoZWQuaCB8ICAxICsKIGtlcm5lbC9leGl0LmMgICAgICAgICB8ICA0
ICsrKysKIGtlcm5lbC9mb3JrLmMgICAgICAgICB8ICAyICsrCiBrZXJuZWwvc2lnbmFsLmMgICAg
ICAgfCAyMCArKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC5oIGIvaW5jbHVkZS9saW51
eC9zY2hlZC5oCmluZGV4IGZmYjZlYjU1Y2QxMy4uYWM0NGVkNWJiMGFiIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L3NjaGVkLmgKKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC5oCkBAIC0xMTAz
LDYgKzExMDMsNyBAQCBzdHJ1Y3QgdGFza19zdHJ1Y3QgewogCS8qIFNpZ25hbCBoYW5kbGVyczog
Ki8KIAlzdHJ1Y3Qgc2lnbmFsX3N0cnVjdAkJKnNpZ25hbDsKIAlzdHJ1Y3Qgc2lnaGFuZF9zdHJ1
Y3QgX19yY3UJCSpzaWdoYW5kOworCXN0cnVjdCBzaWdxdWV1ZQkJCSpzaWdxdWV1ZV9jYWNoZTsK
IAlzaWdzZXRfdAkJCWJsb2NrZWQ7CiAJc2lnc2V0X3QJCQlyZWFsX2Jsb2NrZWQ7CiAJLyogUmVz
dG9yZWQgaWYgc2V0X3Jlc3RvcmVfc2lnbWFzaygpIHdhcyB1c2VkOiAqLwpkaWZmIC0tZ2l0IGEv
a2VybmVsL2V4aXQuYyBiL2tlcm5lbC9leGl0LmMKaW5kZXggMzVlMGEzMWEwMzE1Li44ZDI4N2M4
NDgxYjQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9leGl0LmMKKysrIGIva2VybmVsL2V4aXQuYwpAQCAt
MTU3LDYgKzE1NywxMCBAQCBzdGF0aWMgdm9pZCBfX2V4aXRfc2lnbmFsKHN0cnVjdCB0YXNrX3N0
cnVjdCAqdHNrKQogCSAqLwogCWZsdXNoX3NpZ3F1ZXVlKCZ0c2stPnBlbmRpbmcpOwogCXRzay0+
c2lnaGFuZCA9IE5VTEw7CisJaWYgKHRzay0+c2lncXVldWVfY2FjaGUpIHsKKwkJa21lbV9jYWNo
ZV9mcmVlKHNpZ3F1ZXVlX2NhY2hlcCwgdHNrLT5zaWdxdWV1ZV9jYWNoZSk7CisJCXRzay0+c2ln
cXVldWVfY2FjaGUgPSBOVUxMOworCX0KIAlzcGluX3VubG9jaygmc2lnaGFuZC0+c2lnbG9jayk7
CiAKIAlfX2NsZWFudXBfc2lnaGFuZChzaWdoYW5kKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3Jr
LmMgYi9rZXJuZWwvZm9yay5jCmluZGV4IDA4OTY5ZjVhYTM4ZC4uOTZmZmJjZTg4YWEzIDEwMDY0
NAotLS0gYS9rZXJuZWwvZm9yay5jCisrKyBiL2tlcm5lbC9mb3JrLmMKQEAgLTUzNSw2ICs1MzUs
OCBAQCB2b2lkIHB1dF90YXNrX3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQogCiB2b2lk
IGZyZWVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykKIHsKKwlpZiAodHNrLT5zaWdxdWV1
ZV9jYWNoZSkKKwkJa21lbV9jYWNoZV9mcmVlKHNpZ3F1ZXVlX2NhY2hlcCwgdHNrLT5zaWdxdWV1
ZV9jYWNoZSk7CiAJcmVsZWFzZV91c2VyX2NwdXNfcHRyKHRzayk7CiAJc2NzX3JlbGVhc2UodHNr
KTsKIApkaWZmIC0tZ2l0IGEva2VybmVsL3NpZ25hbC5jIGIva2VybmVsL3NpZ25hbC5jCmluZGV4
IGQxNDA2NzIxODVhNC4uY2NjMGM3YWE4NGU2IDEwMDY0NAotLS0gYS9rZXJuZWwvc2lnbmFsLmMK
KysrIGIva2VybmVsL3NpZ25hbC5jCkBAIC0xMTA3LDYgKzExMDcsMTIgQEAgc3RhdGljIGludCBf
X3NlbmRfc2lnbmFsX2xvY2tlZChpbnQgc2lnLCBzdHJ1Y3Qga2VybmVsX3NpZ2luZm8gKmluZm8s
CiAJaWYgKChzaWcgPT0gU0lHS0lMTCkgfHwgKHQtPmZsYWdzICYgUEZfS1RIUkVBRCkpCiAJCWdv
dG8gb3V0X3NldDsKIAorCWlmICh0LT5zaWdxdWV1ZV9jYWNoZSkgeworCQlxID0gdC0+c2lncXVl
dWVfY2FjaGU7CisJCXQtPnNpZ3F1ZXVlX2NhY2hlID0gTlVMTDsKKwkJZ290byBhZGRfc2lncXVl
dWU7CisJfQorCiAJLyoKIAkgKiBSZWFsLXRpbWUgc2lnbmFscyBtdXN0IGJlIHF1ZXVlZCBpZiBz
ZW50IGJ5IHNpZ3F1ZXVlLCBvcgogCSAqIHNvbWUgb3RoZXIgcmVhbC10aW1lIG1lY2hhbmlzbS4g
IEl0IGlzIGltcGxlbWVudGF0aW9uCkBAIC0xMTI0LDYgKzExMzAsNyBAQCBzdGF0aWMgaW50IF9f
c2VuZF9zaWduYWxfbG9ja2VkKGludCBzaWcsIHN0cnVjdCBrZXJuZWxfc2lnaW5mbyAqaW5mbywK
IAlxID0gX19zaWdxdWV1ZV9hbGxvYyhzaWcsIHQsIEdGUF9BVE9NSUMsIG92ZXJyaWRlX3JsaW1p
dCwgMCk7CiAKIAlpZiAocSkgeworYWRkX3NpZ3F1ZXVlOgogCQlsaXN0X2FkZF90YWlsKCZxLT5s
aXN0LCAmcGVuZGluZy0+bGlzdCk7CiAJCXN3aXRjaCAoKHVuc2lnbmVkIGxvbmcpIGluZm8pIHsK
IAkJY2FzZSAodW5zaWduZWQgbG9uZykgU0VORF9TSUdfTk9JTkZPOgpAQCAtMTkzMyw2ICsxOTQw
LDEzIEBAIHN0cnVjdCBzaWdxdWV1ZSAqc2lncXVldWVfYWxsb2Modm9pZCkKIAlyZXR1cm4gX19z
aWdxdWV1ZV9hbGxvYygtMSwgY3VycmVudCwgR0ZQX0tFUk5FTCwgMCwgU0lHUVVFVUVfUFJFQUxM
T0MpOwogfQogCisvKgorICogV2Ugb25seSBhZGQgc2lncXVldWVzIHdpdGggU0lHUVVFVUVfUFJF
QUxMT0Mgc2V0CisgKiBhbmQgbGlzdF9lbXB0eSgmcS0+bGlzdCkgdG8gdGhlIHNpZ3F1ZXVlX2Nh
Y2hlLgorICoKKyAqIFRoYXQgYXV0b21hdGljYWxseSBtZWFucyB0aGF0IHdlIGRvbid0IGNvdW50
IHRoZW0KKyAqIHRvd2FyZHMgYW55IGxpbWl0cy4KKyAqLwogdm9pZCBzaWdxdWV1ZV9mcmVlKHN0
cnVjdCBzaWdxdWV1ZSAqcSkKIHsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwpAQCAtMTk0NSw2ICsx
OTU5LDEyIEBAIHZvaWQgc2lncXVldWVfZnJlZShzdHJ1Y3Qgc2lncXVldWUgKnEpCiAJICogX19l
eGl0X3NpZ25hbCgpLT5mbHVzaF9zaWdxdWV1ZSgpLgogCSAqLwogCXNwaW5fbG9ja19pcnFzYXZl
KGxvY2ssIGZsYWdzKTsKKwlpZiAoIWN1cnJlbnQtPnNpZ3F1ZXVlX2NhY2hlICYmIGxpc3RfZW1w
dHkoJnEtPmxpc3QpKSB7CisJCWN1cnJlbnQtPnNpZ3F1ZXVlX2NhY2hlID0gcTsKKwkJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZShsb2NrLCBmbGFncyk7CisJCXJldHVybjsKKwl9CisKIAlxLT5mbGFn
cyAmPSB+U0lHUVVFVUVfUFJFQUxMT0M7CiAJLyoKIAkgKiBJZiBpdCBpcyBxdWV1ZWQgaXQgd2ls
bCBiZSBmcmVlZCB3aGVuIGRlcXVldWVkLAo=
--00000000000095fe0d05eea1860e--
