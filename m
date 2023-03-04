Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698676AAC9B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDVDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCDVDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:03:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE70D502
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 13:03:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy23so23535454edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=OVRr1Xtm41f/Vcw9KhdqRl13hClLRcHXk2rZiZ3Qck7HP1jNEgIxGULY0Sb4GJVFGd
         bH8EektFMUsW3uMwDxV5gDamyvJvjxzHGLRA6Ivi2/gmB7JwTmFgoqcrPQgyVOAD5T6j
         A5eLHbfnfikk+mTusCd/h+LXQwxlc4pPJ9tXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=BdbseSZthY/cmX4ziuK+8sJxtJkVNGinOB3tmk2nuK8hkz5uKhcw6aqvsk08QGw+wb
         VpCTTvwDI91YHk3D8auAUPYSp9ay20wQ3y86KwgdbxvkneAw/DxjwCNn9vZkd8jbp3gg
         IyxmZ/nT+91jIU7PI+W9Ck87fBLv9OdqoXd33oz+VV+ZhemGR3pAdZhetu+GJ4hErWp7
         EXQcHObrtr7TQE6NY7WSOMFj0G3sPGR/mxRbUlBxr7/0Gk9oHaU28BSgv7Hzonu7vLDi
         segX0MU0VAllP9jCKik9pFzKC808/fB93CDFhkojaupK2l34DwBKeBG+DlALQ36t1Y7N
         k2PQ==
X-Gm-Message-State: AO0yUKX8W7pimKuPsY/UlpYitO48fxYbA6PBDpR8qEz2ZHlJnVZhpCic
        ANVeB4xL2d26tRf5zq/LRbIdRZLmpxlJoRMAau2y7g==
X-Google-Smtp-Source: AK7set8qknzW/9gW6SwKrU6+mpNC4TwlgBznw7pKUE6MTHxD17fFie1OxlqStMBQugH4hWwzLasRHw==
X-Received: by 2002:aa7:c552:0:b0:4cf:350e:3459 with SMTP id s18-20020aa7c552000000b004cf350e3459mr4116152edr.25.1677963805043;
        Sat, 04 Mar 2023 13:03:25 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090671c600b008b26f3d45fbsm2451660ejk.143.2023.03.04.13.03.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:03:24 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id ay14so19982068edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:03:24 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr2890993ejb.0.1677963804011; Sat, 04 Mar
 2023 13:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
In-Reply-To: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 13:03:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Sat, Mar 4, 2023 at 1:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Silly useless cases are just that - silly and useless. They should not
> be arguments for the real cases then being optimized and simplified.

There's a missing "not" above, that was hopefully obvious from the
context: "They should not be arguments for the real cases then NOT
being optimized and simplified"

               Linus
