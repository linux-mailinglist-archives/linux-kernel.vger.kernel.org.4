Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F263B271
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiK1TnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiK1TnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:43:12 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1081205C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:43:11 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k4so8119280qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cs/yVYVyheB/puNQ3h4E9ObUQQEW9GgSclnt3ZzDlQw=;
        b=U15rds3g/T1G2ZTwslfvgVjO5IpckPs36qzu0PWbgT7bQ5czd2xDBen8DqPH3rUmGD
         26eVmFv/s7NYX90CQIDXGZKmqYRbuk5/dzIyr2pZQLc0C4VbHgFhSe+m5PwlN4Nf/dPS
         HPla1pKdVr3ukpgOMrZM+yzTAhk1JGxTacQxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cs/yVYVyheB/puNQ3h4E9ObUQQEW9GgSclnt3ZzDlQw=;
        b=MD00R/fRloltfBf3cVuHbY2vnKHGK4jdVVWgV5fY1dkFq2U1DR43bbRUA+s9DANgBK
         iPlbx9xfyU7+51AaKM6FvYLI1PiPzQlcsRHobQa0e40R7/612kGSzRqR+VCjoK9Pxf1w
         JGoXM50rCm5aFKVjcYYroqrXIZG2cJgDzv+d4yDDDNxNT2YJt1P00f8Dq8ydjLBeT+x7
         9fyRu/M69x4w4CeuKwvfPqOKtOFEEb05wPHMQAKrYgmoTVyftuuF2AjYR1Af+3Yll/6b
         zQx096cmlfGUh0bMryTcnfeJCh52gYJlVemj5bKU5QDWOMNEIvxIIGPmh6SqmeQ9YhuV
         qSAA==
X-Gm-Message-State: ANoB5pkL5gEftRvGpLNZXClIJ55On1IJZw3eeCxeGV4OQb/HQiNEzTU8
        cBjrNL1RjhOr11LVc2YB3OjOXM+hNo88Wg==
X-Google-Smtp-Source: AA0mqf6HLSY8VEc0IYyfUkdOX0zcwZVmL9S6B3wBSWNPRWU8hZbmsrWyxUCPHyiF30uzpBJdzqcmCQ==
X-Received: by 2002:a05:620a:51d0:b0:6ee:909e:ed6c with SMTP id cx16-20020a05620a51d000b006ee909eed6cmr31950394qkb.264.1669664590367;
        Mon, 28 Nov 2022 11:43:10 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id t24-20020a05622a181800b003a50b9f099esm7495405qtc.12.2022.11.28.11.43.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:43:09 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id q10so8125583qvt.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:43:09 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr30769274qvj.130.1669664588981; Mon, 28
 Nov 2022 11:43:08 -0800 (PST)
MIME-Version: 1.0
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
 <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
 <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com> <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
 <b96a46eb24c2482bb6081418bd2ace02@AcuMS.aculab.com> <CAHk-=wgxzGTsqcNv7B5Cr_BshyRkhrvsPMratxhNb0LA1EnwdA@mail.gmail.com>
 <a74be3ec15294206a13cd5b3a4b35858@AcuMS.aculab.com>
In-Reply-To: <a74be3ec15294206a13cd5b3a4b35858@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Nov 2022 11:42:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5FC6e3TnkDV2anfRWjj+a5gtx__3v0BfX+OrT2YXTTg@mail.gmail.com>
Message-ID: <CAHk-=wj5FC6e3TnkDV2anfRWjj+a5gtx__3v0BfX+OrT2YXTTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 1:10 AM David Laight <David.Laight@aculab.com> wrote:
>
> So you start with:
>         unsigned int a;
>         min(a, 5u)

That's not the case I worry about.

Look at something like this instead:

        min(4u, -5l)

which we currently warn about, because the types are very different.

It's simply a dangerous thing to do, since the signedness is
ambiguous. We *need* to warn about it.

But with your patch, that warning goes away, and the '4u' is a
positive integer, so it gets turned into 'int', and now that
comparison gets done as a signed type and returns -5.

No?

Now, the above is obviously crazy code, and I would certainly hope
that we don't have anything quite that odd in the kernel. That example
is designed to be silly, but minimally show the issue.

You can't just say "because it has a positive _value_, we can now use
it as a signed type".

See what I'm saying?

                 Linus
