Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9C64ACEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiLMBSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiLMBSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:18:23 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAFB1208B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:18:22 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z12so7719356qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1qlp2GTj5x/LkTSxfePaRyJL4fqAt8PlJEzH2bzb7I=;
        b=ZGUcpYl3WCUCAmSbHPOYgGi1Mr5al02m2Riul5cdqCqBBm6zJVef3JRhXH2W8Y5jG6
         2NLH9kWHvaymO8AjwpPGyIo8jcatEiF0ZyMGUCvMGrk+wSI9Pr8vF99Wt5WB3htApnKg
         b4FCWRmKE/gatcP/BuQ5l/zRd3IF5fzPRlbjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1qlp2GTj5x/LkTSxfePaRyJL4fqAt8PlJEzH2bzb7I=;
        b=YfE3EEjnzMmCzD37x/JTaZpEOwqARZ3otdLwYoSPoHTU9/gexjs+IzULdC/4VifO9/
         f2yKDzZxowRdqOiHXO5ClCc8NO0SGLLqtRApJuh+GM1eELDUIDIvUBCF75WMQH4qkxp1
         UPtrYxuoAtNIpXbP9VcPKVDeIkt0QJz7wC+dmhJn8tH2IaQPlivQaNDmRSZa4NNo3yFg
         AFxDtxWahQHVsakqvMKLAmgqdbr8MW6JcraABx4pRtwZLFieTBvorrzfP27CB4JtJZ3L
         ticAGi9msYUIAxKh1LvSN74FON0K8qwEbFl+rgWE/jF/Fjf7v4K3sqJ7e4WCAQuji3yN
         ijhQ==
X-Gm-Message-State: ANoB5plZ/DTZ1qGaY2kdDldt76gA/w+yVDdllsuhaIB49FC6+PBL3LP0
        hAetcFk/jtGnpvLMmoQrpB+MlaFjua7287/2
X-Google-Smtp-Source: AA0mqf7pVNG493ClTEb6xByKzdsx7z90l1Vw66bccePCVgD/wsZJQ2pbMlOYFrm4qn1jryFOiranpg==
X-Received: by 2002:a05:622a:1e8d:b0:3a5:2ff3:1ea7 with SMTP id bz13-20020a05622a1e8d00b003a52ff31ea7mr26338186qtb.26.1670894300850;
        Mon, 12 Dec 2022 17:18:20 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85046000000b003a5430ee366sm6603038qtm.60.2022.12.12.17.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 17:18:19 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id a25so2199603qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:18:19 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10621664qkg.594.1670894299003; Mon, 12
 Dec 2022 17:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20221211005609.270457-1-ojeda@kernel.org>
In-Reply-To: <20221211005609.270457-1-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 17:18:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiW=ioE_6N988=fseYLTzaCXaULNzippLMTRTcT=oPa0A@mail.gmail.com>
Message-ID: <CAHk-=wiW=ioE_6N988=fseYLTzaCXaULNzippLMTRTcT=oPa0A@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.2
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Dec 10, 2022 at 4:56 PM <ojeda@kernel.org> wrote:
>
> - String and formatting: new types `CString`, `CStr`, `BStr` and
>   `Formatter`; new macros `c_str!`, `b_str!` and `fmt!`.

Heh. You have an unusual habit of using the back-tick instead of the
regular single quote character. It's not wrong, just surprising. I
ended up just replacing it with the regular single quote.

Maybe I'm biased against it, because I grew up with it being a dead
key, and while my current keyboard has it very easily accessible, in
many situations it's actually very inconvenient (ie it ends up being a
dead key to generate acute grave on many European keyboard layouts).

Anyway, not a big deal. Just odd enough for me to react to that thing.

At least you didn't do the thing where you are trying to match it with
the tick going the *other* way (which doesn't even exist in ASCII and
requires UTF-8), which is literally impossible to type without going
through strange contortions.

Or, worse yet, do the crazy traditional "pair apostrophe with
backtick" that also looks very ugly in most fonts because the two
characters aren't even visually symmetrical in modern fonts and often
have different weights.

So it's unusual, and I edited it in the commit message, but it's not
one of the actively horrid options.

              Linus
