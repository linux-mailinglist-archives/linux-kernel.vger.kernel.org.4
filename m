Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C336AACFA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCDWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCDWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:35:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359011EBE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 14:35:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so24209648edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677969318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjLU05mpbmIrZ5UOJsg0FItkE1EtBF9bZysOGBrLVhQ=;
        b=Y6wD5A6CQnmMTLgQdcGKSUoePY7qOwARkvWy2V77lvrUHkJN9BB/+tofM45h5yiddG
         cpiW5r05bjqOE35GSPOwhMSrkBSY/Ed9P0hYO3GeN/QMBB2wm3354o69R+zOXBlrIb+7
         odxgV+ICXHIi7jvjH00v6RiQxKmxSG+tv/yvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677969318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjLU05mpbmIrZ5UOJsg0FItkE1EtBF9bZysOGBrLVhQ=;
        b=jN1grEzSjNPUF+D6HmquQxZjxLnxFLbqvAv4DONAxjCr2rW9Av8rNznHSu9lPYCPEo
         XZ1MW/g0yJuufXJLEByjdB9kP7sYxPiTcCuudfQs2mOXw56Cjl9BEUww2Nk+DAzh5XQ3
         GaH/lndlRNSJC0QGtsY3D0Y8irND5za82Ee0SgPkhLwS4DnpULU8T216H4whMvrrkEKW
         Mz4wAVxJTPqOVtYajQB4T9zBtoDoFW500YvE7k00fwujSpwBFuSk1GWpK78xBVrwHxvs
         1gCw8DMlyzrxOHwPVzl7+LS7yoNzHwaQ8KRPPm1CqWK2o8g4jttGUEi1YlpDAu3/G6CJ
         Ir2g==
X-Gm-Message-State: AO0yUKWdodUUHhmS0BgoIB2P77ivKIYZFix6Dwmi9cEz+2U7ZT/4HIbb
        MovmVPh70gNlzfRhhiBxIYOj1d40wwTKj1xtZKIfyQ==
X-Google-Smtp-Source: AK7set9F/s1mU+Dt9bJAbs76JFicvVoHOXUWJzUgYXUtq0VfzOItc7zNiqVZ+wokWU8ineLA5eIXAQ==
X-Received: by 2002:a17:907:9719:b0:895:ef96:9d9b with SMTP id jg25-20020a170907971900b00895ef969d9bmr6743908ejc.30.1677969318095;
        Sat, 04 Mar 2023 14:35:18 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b008e09deb6610sm2469094ejb.200.2023.03.04.14.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 14:35:17 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id s11so24087985edy.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 14:35:17 -0800 (PST)
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr3476060edi.5.1677969317070; Sat, 04 Mar
 2023 14:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
In-Reply-To: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 14:35:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
Message-ID: <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 1:15=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> 17 hotfixes.  Eight are for MM and seven are for other parts of the
> kernel.  Seven are cc:stable and eight address post-6.3 issues or were
> judged unsuitable for -stable backporting.

Hmm. Since this pull didn't fix the gcc note about playing pointer
games that I get for my allmodconfig test build, and since I _really_
don't want to have an rc1 release tomorrow with that (valid) warning,
I fixed it up myself.

I fixed up the gcc note the cleanest way I could, by using a union to
make it very explicit that yes, we're basically doing a bit-for-bit
assignment from one incompatible type to another.

I would *not* encourage this pattern in general, but it had a comment
about why that invalid pointer conversion was fine in this case, and
it really does seem to be a fairly natural use of a union. This
situation really is that kind of "don't convert types, just copy the
bit representation".

So it's kind of conceptually quite similar to the traditional "use a
union to convert floating point bit representations to integers" and
back (as opposed to using a cast to convert a pointer in order to then
_use_ it as a pointer in the new form).

See

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De77d587a2c04e82c6a0dffa4a32c874a4029385d

for details.

At least gcc generated identical code (well, for an unholy version of
that patch that had been edited to avoid line number changes) for me,
so that "go through a union type" doesn't cause any other differences
than getting rid of the gcc note.

(And this was definitely one of the cases where I felt that the gcc
note was entirely valid, and a good warning - even if it wasn't
technically a warnign that would cause -Werror to trigger. So I didn't
want to shut up the note by turning it off, I really wanted the code
to be more clear about what it does).

             Linus
