Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9670C51B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjEVSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjEVSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:24:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D711F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:24:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso9143123a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684779851; x=1687371851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYRWgCDntd6M6zPwTuoO6FVTAIFdNPknpscZnk3SHyI=;
        b=Uv8lWKhIsUfAw8AnlM03yoZvfoUecbhmcjScdnZqdh2uKUIXTShMOWDQI+yJmMjVyT
         b8HVgMAO67LM7eJaUzLgDJ1E9ePaXGcgbCbVDOK9vN8N5REvhyWFE+0VjPlZqy9Ln50x
         lgZvvXIXmwU/Pctg+a2a5O+AHI+e7g+3Jjvho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779851; x=1687371851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYRWgCDntd6M6zPwTuoO6FVTAIFdNPknpscZnk3SHyI=;
        b=Zj6c2ay937BGy0QLuP+6Py6KfgtgtYKF0I3QyTkf4c5DtqhaIiKDBscvPLLHjcxnot
         BBJWYaIs79F7yr6eVbm53EvojGUFBpy39DySqbRS57XC4cSDJ62jSGC5Cpg4Ngze5+Pn
         vdD0E9omPWWbK0CKoAtIn+vCCR1lKz5nUoSV0RAxVKQdeuZpN5VbJceALTecFT6Dvnte
         u/hfznLRKqjjOsAApRNFfEXt32hTY2DkaSI03/Cq+PNilopT6JJ21XM3x4+GwQZlCPBo
         rdsBHI1Umii8lMy4KkJe1TBkQ03AX/+YU72qEoHpDoBT8L30VG4+vAhJ1HdrKRoYFKa1
         fKSg==
X-Gm-Message-State: AC+VfDxAOMSpM1R2Ex7XvW4kpIfa4lFa5QUFzmtErjy5lA+9Qq+Fyzl2
        oYTkhfLmvRMvGURk4yaUcY8zEaermwJpjxq5CcXQX7iS
X-Google-Smtp-Source: ACHHUZ4Lq16Y3ilVwbi2Y8AylbGt6buI5HuxhxzSbU6lpI7pLcVmtgXqqEb/mllttNjrWigq+XtCLQ==
X-Received: by 2002:a05:6402:2d8:b0:4fe:ddf:8d8c with SMTP id b24-20020a05640202d800b004fe0ddf8d8cmr9533915edx.13.1684779851375;
        Mon, 22 May 2023 11:24:11 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id u16-20020a50a410000000b0050696c2d2f6sm3384201edb.88.2023.05.22.11.24.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 11:24:10 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96ff9c0a103so173436266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:24:10 -0700 (PDT)
X-Received: by 2002:a17:907:86a2:b0:96f:a39c:86d6 with SMTP id
 qa34-20020a17090786a200b0096fa39c86d6mr8145445ejc.8.1684779850024; Mon, 22
 May 2023 11:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
 <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com> <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info>
In-Reply-To: <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 11:23:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
Message-ID: <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
Content-Type: multipart/mixed; boundary="0000000000007cd31e05fc4c60e2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007cd31e05fc4c60e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 5:38=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> FWIW, in case anybody is interested in a status update: one reporter
> bisected the problem down to 586e8fede79 ("HID: logitech-hidpp: Retry
> commands when device is busy"); reverting that commit on-top of 6.3
> fixes the problem for that reporter. For that reporter things also work
> on 6.4-rc; but for someone else that is affected that's not the case.

Hmm. It's likely timing-dependent.

But that code is clearly buggy.

If the wait_event_timeout() returns early, the device hasn't replied,
but the code does

                if (!wait_event_timeout(hidpp->wait, hidpp->answer_availabl=
e,
                                        5*HZ)) {
                        dbg_hid("%s:timeout waiting for response\n", __func=
__);
                        memset(response, 0, sizeof(struct hidpp_report));
                        ret =3D -ETIMEDOUT;
                }

and then continues to look at the response _anyway_.

Now, depending on out hardening options, that response may have been
initialized by the compiler, or may just be random stack contents.

That bug is pre-existing (ie the problem was not introduced by that
commit), but who knows if the retry makes things worse (ie if it then
triggers on a retry, the response data will be the *previous*
response).

The whole "goto exit" games should be removed too, because we're in a
for-loop, and instead of "goto exit" it should just do "break".

IOW, something like this might be worth testing.

That said, while I think the code is buggy, I doubt this is the actual
cause of the problem people are reporting. But it would be lovely to
hear if the attached patch makes any difference, and I think this is
fixing a real - but unlikely - problem anyway.

And obviously it might be helpful to actually enable those dbg_hid()
messages, but I didn't look at what the magic config option to do so
was.

NOTE! Patch below *ENTIRELY* untested. I just looked at the code when
that commit was mentioned, and went "that's not right"...

                     Linus

--0000000000007cd31e05fc4c60e2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhz6dxva0>
X-Attachment-Id: f_lhz6dxva0

IGRyaXZlcnMvaGlkL2hpZC1sb2dpdGVjaC1oaWRwcC5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYyBiL2RyaXZlcnMvaGlkL2hpZC1sb2dpdGVjaC1o
aWRwcC5jCmluZGV4IDBmY2ZkODVmZWEwZi4uNzJiZDYyZDJmOTg0IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYworKysgYi9kcml2ZXJzL2hpZC9oaWQtbG9naXRl
Y2gtaGlkcHAuYwpAQCAtMzA2LDcgKzMwNiw3IEBAIHN0YXRpYyBpbnQgaGlkcHBfc2VuZF9tZXNz
YWdlX3N5bmMoc3RydWN0IGhpZHBwX2RldmljZSAqaGlkcHAsCiAJCWlmIChyZXQpIHsKIAkJCWRi
Z19oaWQoIl9faGlkcHBfc2VuZF9yZXBvcnQgcmV0dXJuZWQgZXJyOiAlZFxuIiwgcmV0KTsKIAkJ
CW1lbXNldChyZXNwb25zZSwgMCwgc2l6ZW9mKHN0cnVjdCBoaWRwcF9yZXBvcnQpKTsKLQkJCWdv
dG8gZXhpdDsKKwkJCWJyZWFrOwogCQl9CiAKIAkJaWYgKCF3YWl0X2V2ZW50X3RpbWVvdXQoaGlk
cHAtPndhaXQsIGhpZHBwLT5hbnN3ZXJfYXZhaWxhYmxlLApAQCAtMzE0LDEzICszMTQsMTQgQEAg
c3RhdGljIGludCBoaWRwcF9zZW5kX21lc3NhZ2Vfc3luYyhzdHJ1Y3QgaGlkcHBfZGV2aWNlICpo
aWRwcCwKIAkJCWRiZ19oaWQoIiVzOnRpbWVvdXQgd2FpdGluZyBmb3IgcmVzcG9uc2VcbiIsIF9f
ZnVuY19fKTsKIAkJCW1lbXNldChyZXNwb25zZSwgMCwgc2l6ZW9mKHN0cnVjdCBoaWRwcF9yZXBv
cnQpKTsKIAkJCXJldCA9IC1FVElNRURPVVQ7CisJCQlicmVhazsKIAkJfQogCiAJCWlmIChyZXNw
b25zZS0+cmVwb3J0X2lkID09IFJFUE9SVF9JRF9ISURQUF9TSE9SVCAmJgogCQkgICAgcmVzcG9u
c2UtPnJhcC5zdWJfaWQgPT0gSElEUFBfRVJST1IpIHsKIAkJCXJldCA9IHJlc3BvbnNlLT5yYXAu
cGFyYW1zWzFdOwogCQkJZGJnX2hpZCgiJXM6Z290IGhpZHBwIGVycm9yICUwMlhcbiIsIF9fZnVu
Y19fLCByZXQpOwotCQkJZ290byBleGl0OworCQkJYnJlYWs7CiAJCX0KIAogCQlpZiAoKHJlc3Bv
bnNlLT5yZXBvcnRfaWQgPT0gUkVQT1JUX0lEX0hJRFBQX0xPTkcgfHwKQEAgLTMyOSwxMyArMzMw
LDEyIEBAIHN0YXRpYyBpbnQgaGlkcHBfc2VuZF9tZXNzYWdlX3N5bmMoc3RydWN0IGhpZHBwX2Rl
dmljZSAqaGlkcHAsCiAJCQlyZXQgPSByZXNwb25zZS0+ZmFwLnBhcmFtc1sxXTsKIAkJCWlmIChy
ZXQgIT0gSElEUFAyMF9FUlJPUl9CVVNZKSB7CiAJCQkJZGJnX2hpZCgiJXM6Z290IGhpZHBwIDIu
MCBlcnJvciAlMDJYXG4iLCBfX2Z1bmNfXywgcmV0KTsKLQkJCQlnb3RvIGV4aXQ7CisJCQkJYnJl
YWs7CiAJCQl9CiAJCQlkYmdfaGlkKCIlczpnb3QgYnVzeSBoaWRwcCAyLjAgZXJyb3IgJTAyWCwg
cmV0cnlpbmdcbiIsIF9fZnVuY19fLCByZXQpOwogCQl9CiAJfQogCi1leGl0OgogCW11dGV4X3Vu
bG9jaygmaGlkcHAtPnNlbmRfbXV0ZXgpOwogCXJldHVybiByZXQ7CiAK
--0000000000007cd31e05fc4c60e2--
