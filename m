Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9D6A718B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCAQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCAQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:50:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98FC38031
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:50:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg37so56278340edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677689432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJG7LUrrBO8AvwxbODYoXm7cIwWH9tkUzhoZynAKsVg=;
        b=XY7oSnFrDYrtLDGTwVu6YKbXB54HUJT77BFN12LZBQg61xoyNk1E1IFWES22ISpAzp
         xxiB0uKGw0WNy1WQ+wa41Pg7u5eOXlFpB46K+cDoMpEw1800ILGp7BVNO+X8eUhlWf6+
         BtElVkoZIKcYtSkGyxDBH06gkJKajHI4+zilk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJG7LUrrBO8AvwxbODYoXm7cIwWH9tkUzhoZynAKsVg=;
        b=kHbKKBt78VcGoyvSwILeW2mBYy78ZSDnHz69RGJIQRQB9DDEswTnVYYHVAaUchLKRe
         fU/XruHERJWfFhN/BgFbOOLcnQ+saZSlEDejmQKHBe6YS+MuBINjtyKy3oWMc6qPmi1b
         eOY5sZ8b/YIG1Mae49q2vXRRt1HeiHeMOOeAlN47lfp8/u8Gn1ngE/Ai2vaOrcGZ7cIR
         aCuSCgQON24Um90ckTiAkz4tUYLnRZpFvbn4F7IINfbDHQPe3uziOYsHcrj/13ZWS4VA
         9iddc5qTsh/SPzTUN8Kq+99Ka1uxDpXpVf0hbyPTJvo3New74N7746xFP5p/t/YxOIRr
         dvIg==
X-Gm-Message-State: AO0yUKUGGLgmlfYJDDY8TRG6/CDEjEfpWH+5as0gaJG0F+/uy5bfVF3E
        saNBueJgC5gpCPFzRlKt9MXg2vzMk89ki0C2dP+WOg==
X-Google-Smtp-Source: AK7set818ES7zg/UJQw3qLSms3zYk6ER1T2Y98he49KaaKkt3WEBbhldDcyUZjc8+J5gLk0z/OS84w==
X-Received: by 2002:a17:907:3da6:b0:88d:d700:fe15 with SMTP id he38-20020a1709073da600b0088dd700fe15mr10371033ejc.0.1677689432087;
        Wed, 01 Mar 2023 08:50:32 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090620d500b008e267d7ec18sm5991067ejc.50.2023.03.01.08.50.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 08:50:31 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id cw28so7309009edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:50:31 -0800 (PST)
X-Received: by 2002:a17:906:a381:b0:877:7480:c75d with SMTP id
 k1-20020a170906a38100b008777480c75dmr3522077ejz.0.1677689430953; Wed, 01 Mar
 2023 08:50:30 -0800 (PST)
MIME-Version: 1.0
References: <a9466e48-77be-bb9e-bdfe-df8c763d7a76@oracle.com> <b9d302f5-a4a1-2481-a477-b31f25f8e73c@oracle.com>
In-Reply-To: <b9d302f5-a4a1-2481-a477-b31f25f8e73c@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 08:50:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe=S2BRMm63S6p53U6zOraSeb5K9zugNnBpqQjWe7fAw@mail.gmail.com>
Message-ID: <CAHk-=whe=S2BRMm63S6p53U6zOraSeb5K9zugNnBpqQjWe7fAw@mail.gmail.com>
Subject: Re: [GIT PULL] jfs updates for 6.3
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     linux-kernel@vger.kernel.org
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

On Wed, Mar 1, 2023 at 8:02=E2=80=AFAM Dave Kleikamp <dave.kleikamp@oracle.=
com> wrote:
>
> Arrgh! Right after sending this I realized I hadn't even pushed my local
> jfs-next branch and it hasn't been in linux-next. It's a very low-risk
> patch, but ignore this request if you'd like to.

Heh. For basically a one-liner sign check, I really don't mind. That
patch looks like something that could have gone in as a fix after the
merge window.

Yes, we have rules, but no rule is _that_ black and white.

I appreciate the "oops, this missed linux-next", though, even if it
really doesn't matter for something like this ;)

           Linus
