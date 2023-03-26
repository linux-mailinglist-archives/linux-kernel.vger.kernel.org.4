Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E16C98A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCZXUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:20:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DA127
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:20:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er18so17636357edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679872835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCly5l6nRUWUXhlZL7zSxahKOMxrBb+La4gaJU0ndjA=;
        b=E6prLVhGXXLNS6UEkXnUFwSroZaC1Mfr3gNG8TyGMYdSPXqumkGOCJi5Jm6RalX+IM
         MGUb+f6Bk/rW7qx/bdb4OweOgWXP5mkxTQdk9PdWG++mVyI8YkSGDxl4NcfWmNkA9/Lm
         XOLs747f65SJu/ZZx+DXWC0HWDaJ1W0Rs0PcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679872835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCly5l6nRUWUXhlZL7zSxahKOMxrBb+La4gaJU0ndjA=;
        b=QN2hRUv8c+kHPWAOnBCMey04usH0dnuqIFBtcWgozPyCMCsgLXDibJNzVLXCRtjBYG
         tQehkBVsgwfah+IrNsUsvop6RVwuz4abZ4ePc3X64p9vP4YBvoAIX0eaD0Bf6YHZgC2Z
         P/Lz2jiAZV6xwP96+XgyHZcX4wjdi8Ljb/DIzR73j6aJVNihmplQU5cjriEWHavc/IvY
         XdgMg7FTN+8HWGOp1lzMoYCZ4ao2qisdafra+XOhIiMG4gGGbTDfSWM8A6g+3EU8rM1M
         d5/IXNBxMyd9nMuSQnIRsvSTVQCG1RhI9QRl6RRyKg7ld/B32tpD4Cw6k7+3bJ8dwj4D
         kLEA==
X-Gm-Message-State: AAQBX9euBPekJkrStZH+9Z1M2MC30u8ovh+z/lO3EtvCURPtIc/qZKBJ
        Tz6JJ63FRXMdxlUoh9rJWBuD7EIofD/8/q5oxxerxg==
X-Google-Smtp-Source: AKy350bfa2aq03A49GjNGiHcChoM4fC8Kn6pCphlwL6wJ72K4wML/YZOOgxa54Cm7B8Cpti8Kbrpjg==
X-Received: by 2002:a17:906:a15a:b0:933:1967:a98a with SMTP id bu26-20020a170906a15a00b009331967a98amr9937445ejb.17.1679872835372;
        Sun, 26 Mar 2023 16:20:35 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm14155360edb.72.2023.03.26.16.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 16:20:34 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id ew6so28810963edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:20:34 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr4300322ejb.15.1679872834094; Sun, 26
 Mar 2023 16:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley> <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
 <ZB281JxlZtKSkJoJ@alley>
In-Reply-To: <ZB281JxlZtKSkJoJ@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Mar 2023 16:20:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheQYsUiKmJnqR3qGrjjh8z7b2ov4rZzHLHJS+VJT9aLQ@mail.gmail.com>
Message-ID: <CAHk-=wheQYsUiKmJnqR3qGrjjh8z7b2ov4rZzHLHJS+VJT9aLQ@mail.gmail.com>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
To:     Petr Mladek <pmladek@suse.com>
Cc:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 8:08=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> I need an advice whether to revert the commit 3cffa06aeef7ece30f
> ("printk/console: Allow to disable console output by using
> console=3D"" or console=3Dnull").

I think it's too late to revert it by now. It sounds like people who
were affected are either chrome developers that already changed their
setup, or embedded people who similarly have already reacted to it.

This went into 5.11, it's ancient history by now, so reverting it
would likely just cause more issues.

              Linus
