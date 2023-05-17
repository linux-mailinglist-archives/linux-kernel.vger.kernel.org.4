Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6D707252
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjEQTiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEQTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:38:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA8140D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96a9c44ec4bso77500466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=dST0i2fL5crJmyksJX0862DQUmET9sHJlkPm04jxbIwsJnbNUW7+0b9DaPO9SxViNp
         8CzG00bl4e2iNhYUUIqZpckBCyAUm20fVCmG2RA76lWUFaM4nC8fP1fK2o1BbU/ipu7m
         Bu3FNI0mAQY4PxO8q5NtnD+m9tmxVXzdQOtzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=eBWZ45msNd0te36f9ttY+Gu4fVTYZtCPFExVXRV2O58xZ4cRhoTu9+7jVZAHuxfRgt
         Oxamh10POL6zZl5lG+i9iChFDejcEJ8QM4aUOvQYNxzZFcDga7g/LfC9YDmzMTG5Z+y8
         Y9jYWaxajDq45UiUziwiMzKu+GS8hMf1sb33SsvDVggCupFNAwTP5+nFjtMm51g7IEzZ
         9gyyvNvdrac2lt53gCndLS15pS20nnXvbnDpHD90RynAz1Qiane+hrMRcVD83R4RzXGP
         blfVEONWffGvsTBbjyYGLGMc5l9dWcQtSLkqrJDWJPDeLpU0Z9rbTHuqw/tIe4J7Kq2Z
         xjEQ==
X-Gm-Message-State: AC+VfDxJiewVXED2v+OxQ9OSA73ddKnVkdciyHQCnpEKTX+fyAjYo8B+
        2cRyjytZeuSLQXwqXPlnpBp7y15K7alpBUsg0h8xulH7
X-Google-Smtp-Source: ACHHUZ7sasT3znVoyE/Xc++udW1HtKV6JKC1oL9gi+0heOOniphx9MwJP3MZvDkDW6iJiQ+4g080WQ==
X-Received: by 2002:a17:907:1c15:b0:966:4973:b35 with SMTP id nc21-20020a1709071c1500b0096649730b35mr3477809ejc.22.1684352250076;
        Wed, 17 May 2023 12:37:30 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id fe18-20020a1709072a5200b00968242f8c37sm12674054ejc.50.2023.05.17.12.37.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:37:29 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso77973766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:28 -0700 (PDT)
X-Received: by 2002:a17:907:3f9e:b0:96a:2b4:eb69 with SMTP id
 hr30-20020a1709073f9e00b0096a02b4eb69mr3422885ejc.31.1684352248662; Wed, 17
 May 2023 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 12:37:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000759fcb05fbe8d165"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000759fcb05fbe8d165
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.

Let's actually attach the patch too. Duh.

               Linus

--000000000000759fcb05fbe8d165
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhs3trhk0>
X-Attachment-Id: f_lhs3trhk0

IGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfdXNlci5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
dXNlci5jCmluZGV4IGIyYWVjYmZiYmQyNC4uMDU0ZTI4Y2M1YWQ0IDEwMDY0NAotLS0gYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYworKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZl
bnRzX3VzZXIuYwpAQCAtNDM5LDcgKzQzOSw3IEBAIHN0YXRpYyBib29sIHVzZXJfZXZlbnRfZW5h
Ymxlcl9leGlzdHMoc3RydWN0IHVzZXJfZXZlbnRfbW0gKm1tLAogCXN0cnVjdCB1c2VyX2V2ZW50
X2VuYWJsZXIgKmVuYWJsZXI7CiAJc3RydWN0IHVzZXJfZXZlbnRfZW5hYmxlciAqbmV4dDsKIAot
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJzLCBs
aW5rKSB7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJz
LCBsaW5rKSB7CiAJCWlmIChlbmFibGVyLT5hZGRyID09IHVhZGRyICYmCiAJCSAgICAoZW5hYmxl
ci0+dmFsdWVzICYgRU5BQkxFX1ZBTF9CSVRfTUFTSykgPT0gYml0KQogCQkJcmV0dXJuIHRydWU7
CkBAIC00NTUsMTkgKzQ1NSwxOSBAQCBzdGF0aWMgdm9pZCB1c2VyX2V2ZW50X2VuYWJsZXJfdXBk
YXRlKHN0cnVjdCB1c2VyX2V2ZW50ICp1c2VyKQogCXN0cnVjdCB1c2VyX2V2ZW50X21tICpuZXh0
OwogCWludCBhdHRlbXB0OwogCisJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZXZlbnRfbXV0ZXgpOwor
CiAJd2hpbGUgKG1tKSB7CiAJCW5leHQgPSBtbS0+bmV4dDsKIAkJbW1hcF9yZWFkX2xvY2sobW0t
Pm1tKTsKLQkJcmN1X3JlYWRfbG9jaygpOwogCi0JCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVu
YWJsZXIsICZtbS0+ZW5hYmxlcnMsIGxpbmspIHsKKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFi
bGVyLCAmbW0tPmVuYWJsZXJzLCBsaW5rKSB7CiAJCQlpZiAoZW5hYmxlci0+ZXZlbnQgPT0gdXNl
cikgewogCQkJCWF0dGVtcHQgPSAwOwogCQkJCXVzZXJfZXZlbnRfZW5hYmxlcl93cml0ZShtbSwg
ZW5hYmxlciwgdHJ1ZSwgJmF0dGVtcHQpOwogCQkJfQogCQl9CiAKLQkJcmN1X3JlYWRfdW5sb2Nr
KCk7CiAJCW1tYXBfcmVhZF91bmxvY2sobW0tPm1tKTsKIAkJdXNlcl9ldmVudF9tbV9wdXQobW0p
OwogCQltbSA9IG5leHQ7Cg==
--000000000000759fcb05fbe8d165--
