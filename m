Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516A7473C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGDONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGDOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:12:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B510F9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:12:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso243310e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688479962; x=1691071962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3So2gYeZeNuR/2q5MlAFdt4BonOt1PCCLvQw80QmelA=;
        b=VMYVeQ/3aOo2t7q5I2qhzWvMI1BoQTPHN1dTxFMKqSuI+BTcu/l9Rp4m2ZZwGpXclf
         suVev63/PkXCAXBzad/rOT+DokjOk76HpR3M8An9Z8331TIOHDz0nAfHZyJ+cOreIj9F
         NLPX+0s4cwWM3S/No8zcIOzWq7bzSxwXVhCSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479962; x=1691071962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3So2gYeZeNuR/2q5MlAFdt4BonOt1PCCLvQw80QmelA=;
        b=C7PjuJ7rTMBfBakMe1sEbRUTyODATdHU4+N00TxNYLrL8k2RHYxj6q7IjnajK4EiMO
         VbXj52BlofJVlWaydBJRkCJbvgQX2lxhvW4jPQorhcYwPkTUVb32rU3n2tV8p2VTJEO7
         4sI4SSEwVzhSbpa2aV1w29jsXDv17jkcfFeOdva0bjtgdZIbtPXnkHYkEgwcbBZ7Im55
         UMz97hdEv/Krm9LxjHO/0ax1i53BY4on/tfIk137iCyc1RinDek2pceljD3Siyr+wEhl
         2iD9H23K2qNyLnGzma2tK7i8lQlbKrbXgWzLXAoAfuag075EVhAhO/bsYfzbuG9fbu/C
         0bhw==
X-Gm-Message-State: ABy/qLYNCeCZcn0y409ODGCyivYmDphWERJrIRVqIO54fp8dsL7pSasS
        M8MAXyJZE5KnSu6WxuuxbxY01VuPFEL296Yv1/PJOTT3
X-Google-Smtp-Source: APBJJlGH7ePGRDAtRCMRdadEnCwytkhhmxyFxw4YyfTT40hI3k/VegN8aa3WXoVlhM1E4GCR7poCZA==
X-Received: by 2002:a05:6512:3994:b0:4f6:47a2:7bb4 with SMTP id j20-20020a056512399400b004f647a27bb4mr11577205lfu.60.1688479962204;
        Tue, 04 Jul 2023 07:12:42 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25582000000b004fba077e654sm2823452lfg.194.2023.07.04.07.12.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:12:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso8982255e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:12:41 -0700 (PDT)
X-Received: by 2002:a05:6512:2386:b0:4fb:763c:af54 with SMTP id
 c6-20020a056512238600b004fb763caf54mr11708321lfv.62.1688479961179; Tue, 04
 Jul 2023 07:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <202307041023.bcdbbfc0-oliver.sang@intel.com>
In-Reply-To: <202307041023.bcdbbfc0-oliver.sang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 07:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
Message-ID: <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
Subject: Re: [linus:master] [gup] a425ac5365: WARNING:at_mm/gup.c:#__get_user_pages
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="0000000000004cc04805ffa9e054"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004cc04805ffa9e054
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jul 2023 at 00:03, kernel test robot <oliver.sang@intel.com> wrote:
>
> we noticed this commit 'add a (temporary) warning' for the case that
> 'anybody actually does anything quite this strange'.
> and in our this test, the warning hits. just FYI.

Yeah, so it looks like this is trinity doing system calls with random
arguments, and that will obviously hit the whole

  "GUP will no longer expand the stack, warn if somebody seems to want
to do GUP under the stack"

test.

So then it will warn if somebody passes in bogus addresses that *used*
to maybe work.

But with a random argument tester like trinity, passing in random
bogus addresses is obviously expected, so the warning will trigger
even if it's not something that we would not want to keep working.

I do not have a good idea for how to not warn for things like syzbot
and trinity that do random system calls, and only warn for any
potential real applications that do crazy things and expect them to
work.

And I *do* want the backtrace from the warning (in this case, it shows
that it's the "process_vm_readv/writev()" path, which actually might
be worth adding stack expansion to, the same way __access_remote_vm()
does).

I guess I can do the limiting manually, and just avoid WARN_ON_ONCE().

If I do just "dump_stack()", will the kernel test robot react to that
too? IOW, would a patch like the attached make the kernel test robot
not react?

              Linus

--0000000000004cc04805ffa9e054
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljodbtsf0>
X-Attachment-Id: f_ljodbtsf0

IG1tL2d1cC5jIHwgMTggKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIvbW0vZ3Vw
LmMKaW5kZXggZWYyOTY0MTY3MWM3Li5jOWQ3OTlkMjhkZTcgMTAwNjQ0Ci0tLSBhL21tL2d1cC5j
CisrKyBiL21tL2d1cC5jCkBAIC0xMDkxLDYgKzEwOTEsMjEgQEAgc3RhdGljIGludCBjaGVja192
bWFfZmxhZ3Moc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgZ3VwX2Zs
YWdzKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBndXBfc3RhY2tfZXhwYW5zaW9uX3dh
cm5pbmcoY29uc3Qgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCisJdW5zaWduZWQgbG9uZyBh
ZGRyKQoreworCXN0YXRpYyB2b2xhdGlsZSB1bnNpZ25lZCBsb25nIG5leHRfd2FybjsKKwl1bnNp
Z25lZCBsb25nIG5vdyA9IGppZmZpZXMsIG5leHQgPSBuZXh0X3dhcm47CisKKwkvKiBMZXQncyBu
b3Qgd2FybiBtb3JlIHRoYW4gb25jZSBhbiBob3VyLi4gKi8KKwlpZiAobmV4dCAmJiB0aW1lX2Jl
Zm9yZShub3csIG5leHQpKQorCQlyZXR1cm47CisJbmV4dF93YXJuID0gbm93ICsgNjAqNjAqSFo7
CisJcHJfd2FybigiR1VQIG5vIGxvbmdlciBncm93cyB0aGUgc3RhY2sgJWx4LSVseCAoJWx4KVxu
IiwKKwkJdm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQsIGFkZHIpOworCWR1bXBfc3RhY2soKTsK
K30KKwogLyoqCiAgKiBfX2dldF91c2VyX3BhZ2VzKCkgLSBwaW4gdXNlciBwYWdlcyBpbiBtZW1v
cnkKICAqIEBtbToJCW1tX3N0cnVjdCBvZiB0YXJnZXQgbW0KQEAgLTExNzAsNyArMTE4NSw4IEBA
IHN0YXRpYyBsb25nIF9fZ2V0X3VzZXJfcGFnZXMoc3RydWN0IG1tX3N0cnVjdCAqbW0sCiAJCWlm
ICghdm1hIHx8IHN0YXJ0ID49IHZtYS0+dm1fZW5kKSB7CiAJCQl2bWEgPSBmaW5kX3ZtYShtbSwg
c3RhcnQpOwogCQkJaWYgKHZtYSAmJiAoc3RhcnQgPCB2bWEtPnZtX3N0YXJ0KSkgewotCQkJCVdB
Uk5fT05fT05DRSh2bWEtPnZtX2ZsYWdzICYgVk1fR1JPV1NET1dOKTsKKwkJCQlpZiAodW5saWtl
bHkodm1hLT52bV9mbGFncyAmIFZNX0dST1dTRE9XTikpCisJCQkJCWd1cF9zdGFja19leHBhbnNp
b25fd2FybmluZyh2bWEsIHN0YXJ0KTsKIAkJCQl2bWEgPSBOVUxMOwogCQkJfQogCQkJaWYgKCF2
bWEgJiYgaW5fZ2F0ZV9hcmVhKG1tLCBzdGFydCkpIHsK
--0000000000004cc04805ffa9e054--
