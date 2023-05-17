Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC54707227
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEQT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjEQT1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:27:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC6D2C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:27:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so1797646a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684351625; x=1686943625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBSaYe/tGc9yPiLd8UilCx8N10jcny5QbPvRBer8Htw=;
        b=HBKWQFa2DPuj10BEKCtwv9YqZn8eBlRBDdJcmGxpxHSnoWtAtw1CLdBOvdjGsImt8W
         3o8o/2/sH+g+2v1pUbcZpmcpZQU0oQAY9v33YPR0JJk1aZfxpwQjsRZgvvoqdeA0h7Ba
         VVyDKj3O0rxroNIUQI90EXatNrBQofxO4GsDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351625; x=1686943625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBSaYe/tGc9yPiLd8UilCx8N10jcny5QbPvRBer8Htw=;
        b=KMWmxAlWRph0ZTzW6NE9qs+an1G3FaXtWHK24KqVQml18s3f8joeqmuC/25Fgwqe0t
         jBdCKHmP73oPeWZBlcdLJiMhliRkLcd3DrQq3D/SEqOeY4tgGnMmKaGn28Y9s1h86DkM
         XvKpqczAzeDkBXavKcahrjt2MmRvgqiP0j6aOyWuGMcfLfpYUAK7DZnXIxA9KwrgktJO
         xTKeDdM2bzLiv7OKDOitacuCaSFo4bl8YfcCyLyb9xCUXsOtmwjrTsC2yySQt4HHjwt2
         kBL5UhjNWB9VOttbkcXYLuGyC/sgNR1U95ZMtWzbUKYDoYtnOLsOeE6FElEvQN/JhFv9
         CCcg==
X-Gm-Message-State: AC+VfDx197+fj9BtPwT/9ZQtiEyaOZeQDnVrHnhtEB+GG4krdvZGW2/A
        AKWmEf+6GLQu0fomwNPaAicgYWVX54QHJZNgK3z2pxCU
X-Google-Smtp-Source: ACHHUZ7DJryAudI7Bmh/rIZ88jEY34m0j1gjnovS2WFvpTNkx4qBsSlWxmkza9sVT52Y8Oe0yWvVeQ==
X-Received: by 2002:a05:6402:783:b0:50d:ff73:64ef with SMTP id d3-20020a056402078300b0050dff7364efmr3064535edy.20.1684351624744;
        Wed, 17 May 2023 12:27:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b0050470aa444fsm9658707eds.51.2023.05.17.12.27.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:27:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so182855066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:27:02 -0700 (PDT)
X-Received: by 2002:a17:907:9603:b0:960:ce5:20c0 with SMTP id
 gb3-20020a170907960300b009600ce520c0mr30090557ejc.20.1684351622229; Wed, 17
 May 2023 12:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517190750.GA366@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 12:26:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
Message-ID: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: multipart/mixed; boundary="0000000000001f8c7105fbe8ac17"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f8c7105fbe8ac17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:08=E2=80=AFPM Beau Belgrave
<beaub@linux.microsoft.com> wrote:
>
> user_event_mm_dup() puts a new mm into the global list before the
> enablers list is fully populated.

Then that simply needs to be fixed.

user_event_mm_dup() should not madd the mm into the global list until
it is *done*.

Because if it makes that list visible to others in a half-way state,
then it needs to use the proper locking and use event_mutex.

You can't say "this is so critical that we can't take a lock" and then
use that as an excuse to simply do buggy code.

Either take the lock in user_event_mm_dup(), or make sure that the
data structures are all completely local so that no lock is necessary.

Here's a COMPLETELY UNTESTED patch that just separates out the notion
of "allocate" and "attach".

NOTE NOTE NOTE! I am *not* claiming this patch works. It builds for
me. It looks right. It seems like it's the right thing to do. But it
might have some issues.

With this, the newly dup'ed list is attached to the process once after
it is done, so nobody can see the list being built up.

Also note that this does NOT fix the incorrect RCU walks.

           Linus

--0000000000001f8c7105fbe8ac17
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhs3gera0>
X-Attachment-Id: f_lhs3gera0

IGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfdXNlci5jIHwgMjkgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYyBiL2tl
cm5lbC90cmFjZS90cmFjZV9ldmVudHNfdXNlci5jCmluZGV4IGIxZWNkNzY3NzY0Mi4uYjJhZWNi
ZmJiZDI0IDEwMDY0NAotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYworKysg
Yi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYwpAQCAtNTM4LDEwICs1MzgsOSBAQCBz
dGF0aWMgc3RydWN0IHVzZXJfZXZlbnRfbW0gKnVzZXJfZXZlbnRfbW1fZ2V0X2FsbChzdHJ1Y3Qg
dXNlcl9ldmVudCAqdXNlcikKIAlyZXR1cm4gZm91bmQ7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgdXNl
cl9ldmVudF9tbSAqdXNlcl9ldmVudF9tbV9jcmVhdGUoc3RydWN0IHRhc2tfc3RydWN0ICp0KQor
c3RhdGljIHN0cnVjdCB1c2VyX2V2ZW50X21tICp1c2VyX2V2ZW50X21tX2FsbG9jKHN0cnVjdCB0
YXNrX3N0cnVjdCAqdCkKIHsKIAlzdHJ1Y3QgdXNlcl9ldmVudF9tbSAqdXNlcl9tbTsKLQl1bnNp
Z25lZCBsb25nIGZsYWdzOwogCiAJdXNlcl9tbSA9IGt6YWxsb2Moc2l6ZW9mKCp1c2VyX21tKSwg
R0ZQX0tFUk5FTF9BQ0NPVU5UKTsKIApAQCAtNTUzLDEyICs1NTIsNiBAQCBzdGF0aWMgc3RydWN0
IHVzZXJfZXZlbnRfbW0gKnVzZXJfZXZlbnRfbW1fY3JlYXRlKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dCkKIAlyZWZjb3VudF9zZXQoJnVzZXJfbW0tPnJlZmNudCwgMSk7CiAJcmVmY291bnRfc2V0KCZ1
c2VyX21tLT50YXNrcywgMSk7CiAKLQlzcGluX2xvY2tfaXJxc2F2ZSgmdXNlcl9ldmVudF9tbXNf
bG9jaywgZmxhZ3MpOwotCWxpc3RfYWRkX3JjdSgmdXNlcl9tbS0+bGluaywgJnVzZXJfZXZlbnRf
bW1zKTsKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ1c2VyX2V2ZW50X21tc19sb2NrLCBmbGFn
cyk7Ci0KLQl0LT51c2VyX2V2ZW50X21tID0gdXNlcl9tbTsKLQogCS8qCiAJICogVGhlIGxpZmV0
aW1lIG9mIHRoZSBtZW1vcnkgZGVzY3JpcHRvciBjYW4gc2xpZ2h0bHkgb3V0bGFzdAogCSAqIHRo
ZSB0YXNrIGxpZmV0aW1lIGlmIGEgcmVmIHRvIHRoZSB1c2VyX2V2ZW50X21tIGlzIHRha2VuCkBA
IC01NzIsNiArNTY1LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNlcl9ldmVudF9tbSAqdXNlcl9ldmVu
dF9tbV9jcmVhdGUoc3RydWN0IHRhc2tfc3RydWN0ICp0KQogCXJldHVybiB1c2VyX21tOwogfQog
CitzdGF0aWMgdm9pZCB1c2VyX2V2ZW50X21tX2F0dGFjaChzdHJ1Y3QgdXNlcl9ldmVudF9tbSAq
dXNlcl9tbSwgc3RydWN0IHRhc2tfc3RydWN0ICp0KQoreworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmdXNlcl9ldmVudF9tbXNfbG9jaywgZmxhZ3MpOworCWxp
c3RfYWRkX3JjdSgmdXNlcl9tbS0+bGluaywgJnVzZXJfZXZlbnRfbW1zKTsKKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZ1c2VyX2V2ZW50X21tc19sb2NrLCBmbGFncyk7CisKKwl0LT51c2VyX2V2
ZW50X21tID0gdXNlcl9tbTsKK30KKwogc3RhdGljIHN0cnVjdCB1c2VyX2V2ZW50X21tICpjdXJy
ZW50X3VzZXJfZXZlbnRfbW0odm9pZCkKIHsKIAlzdHJ1Y3QgdXNlcl9ldmVudF9tbSAqdXNlcl9t
bSA9IGN1cnJlbnQtPnVzZXJfZXZlbnRfbW07CkBAIC01NzksMTAgKzU4MywxMiBAQCBzdGF0aWMg
c3RydWN0IHVzZXJfZXZlbnRfbW0gKmN1cnJlbnRfdXNlcl9ldmVudF9tbSh2b2lkKQogCWlmICh1
c2VyX21tKQogCQlnb3RvIGluYzsKIAotCXVzZXJfbW0gPSB1c2VyX2V2ZW50X21tX2NyZWF0ZShj
dXJyZW50KTsKKwl1c2VyX21tID0gdXNlcl9ldmVudF9tbV9hbGxvYyhjdXJyZW50KTsKIAogCWlm
ICghdXNlcl9tbSkKIAkJZ290byBlcnJvcjsKKworCXVzZXJfZXZlbnRfbW1fYXR0YWNoKHVzZXJf
bW0sIGN1cnJlbnQpOwogaW5jOgogCXJlZmNvdW50X2luYygmdXNlcl9tbS0+cmVmY250KTsKIGVy
cm9yOgpAQCAtNjcwLDcgKzY3Niw3IEBAIHZvaWQgdXNlcl9ldmVudF9tbV9yZW1vdmUoc3RydWN0
IHRhc2tfc3RydWN0ICp0KQogCiB2b2lkIHVzZXJfZXZlbnRfbW1fZHVwKHN0cnVjdCB0YXNrX3N0
cnVjdCAqdCwgc3RydWN0IHVzZXJfZXZlbnRfbW0gKm9sZF9tbSkKIHsKLQlzdHJ1Y3QgdXNlcl9l
dmVudF9tbSAqbW0gPSB1c2VyX2V2ZW50X21tX2NyZWF0ZSh0KTsKKwlzdHJ1Y3QgdXNlcl9ldmVu
dF9tbSAqbW0gPSB1c2VyX2V2ZW50X21tX2FsbG9jKHQpOwogCXN0cnVjdCB1c2VyX2V2ZW50X2Vu
YWJsZXIgKmVuYWJsZXI7CiAKIAlpZiAoIW1tKQpAQCAtNjg0LDEwICs2OTAsMTEgQEAgdm9pZCB1
c2VyX2V2ZW50X21tX2R1cChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsIHN0cnVjdCB1c2VyX2V2ZW50
X21tICpvbGRfbW0pCiAKIAlyY3VfcmVhZF91bmxvY2soKTsKIAorCXVzZXJfZXZlbnRfbW1fYXR0
YWNoKG1tLCB0KTsKIAlyZXR1cm47CiBlcnJvcjoKIAlyY3VfcmVhZF91bmxvY2soKTsKLQl1c2Vy
X2V2ZW50X21tX3JlbW92ZSh0KTsKKwl1c2VyX2V2ZW50X21tX2Rlc3Ryb3kobW0pOwogfQogCiBz
dGF0aWMgYm9vbCBjdXJyZW50X3VzZXJfZXZlbnRfZW5hYmxlcl9leGlzdHModW5zaWduZWQgbG9u
ZyB1YWRkciwK
--0000000000001f8c7105fbe8ac17--
